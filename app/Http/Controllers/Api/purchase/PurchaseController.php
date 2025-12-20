<?php

namespace App\Http\Controllers\Api\purchase;

use App\Http\Controllers\Controller;
use App\Models\Purchase;
use App\Models\Stock;
use App\Models\StockLedger;
use App\Models\Payment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class PurchaseController extends Controller
{
    public function index(Request $request)
    {
        $query = Purchase::with(['supplier', 'warehouse', 'createdBy', 'items.product']);

        // Filter by supplier
        if ($request->has('supplier_id')) {
            $query->where('supplier_id', $request->supplier_id);
        }

        // Filter by warehouse
        if ($request->has('warehouse_id')) {
            $query->where('warehouse_id', $request->warehouse_id);
        }

        // Filter by status
        if ($request->has('status')) {
            $query->where('status', $request->status);
        }

        // Search by invoice number
        if ($request->has('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('invoice_number', 'like', "%{$search}%")
                  ->orWhere('notes', 'like', "%{$search}%");
            });
        }

        // Sorting
        $sortBy = $request->get('sort_by', 'invoice_date');
        $sortDirection = $request->get('sort_direction', 'desc');
        
        $allowedSortFields = ['id', 'invoice_number', 'invoice_date', 'due_date', 'status', 'total_amount', 'created_at'];
        if (!in_array($sortBy, $allowedSortFields)) {
            $sortBy = 'invoice_date';
        }
        
        if (!in_array($sortDirection, ['asc', 'desc'])) {
            $sortDirection = 'desc';
        }
        
        $query->orderBy($sortBy, $sortDirection);

        $purchases = $query->paginate($request->get('per_page', 10));
        
        return response()->json($purchases);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'supplier_id' => 'required|exists:suppliers,id',
            'warehouse_id' => 'required|exists:warehouses,id',
            'invoice_date' => 'required|date',
            'due_date' => 'nullable|date',
            'notes' => 'nullable|string',
            'paid_amount' => 'nullable|numeric|min:0',
            'payment_method' => 'nullable|string|max:50',
            'items' => 'required|array|min:1',
            'items.*.product_id' => 'required|exists:products,id',
            'items.*.quantity' => 'required|integer|min:1',
            'items.*.unit_price' => 'required|numeric|min:0',
            'items.*.discount' => 'nullable|numeric|min:0',
            'items.*.tax' => 'nullable|numeric|min:0',
            'items.*.notes' => 'nullable|string',
            'subtotal' => 'nullable|numeric|min:0',
            'tax_amount' => 'nullable|numeric|min:0',
            'discount_amount' => 'nullable|numeric|min:0',
            'shipping_cost' => 'nullable|numeric|min:0',
        ]);

        $subtotal = $validated['subtotal'] ?? 0;
        $totalTax = $validated['tax_amount'] ?? 0;
        $totalDiscount = $validated['discount_amount'] ?? 0;
        $shippingCost = $validated['shipping_cost'] ?? 0;

        if ($subtotal == 0) {
            foreach ($validated['items'] as $item) {
                $lineSubtotal = $item['quantity'] * $item['unit_price'];
                $lineDiscount = $item['discount'] ?? 0;
                $lineTax = $item['tax'] ?? 0;
                $subtotal += $lineSubtotal;
                $totalTax += $lineTax;
                $totalDiscount += $lineDiscount;
            }
        }

        $totalAmount = $subtotal + $totalTax + $shippingCost - $totalDiscount;
        $paidAmount = min($validated['paid_amount'] ?? 0, $totalAmount);
        $balanceAmount = max($totalAmount - $paidAmount, 0);
        $status = $balanceAmount <= 0 ? 'paid' : ($paidAmount > 0 ? 'partial' : 'draft');

        $purchase = DB::transaction(function () use ($validated, $subtotal, $totalTax, $totalDiscount, $shippingCost, $totalAmount, $paidAmount, $balanceAmount, $status) {
            $invoiceNumber = 'INV-P-' . strtoupper(Str::random(6));
            while (Purchase::where('invoice_number', $invoiceNumber)->exists()) {
                $invoiceNumber = 'INV-P-' . strtoupper(Str::random(6));
            }

            $purchase = Purchase::create([
                'invoice_number' => $invoiceNumber,
                'supplier_id' => $validated['supplier_id'],
                'warehouse_id' => $validated['warehouse_id'],
                'invoice_date' => $validated['invoice_date'],
                'due_date' => $validated['due_date'] ?? null,
                'status' => $status,
                'subtotal' => $subtotal,
                'tax_amount' => $totalTax,
                'discount_amount' => $totalDiscount,
                'shipping_cost' => $shippingCost,
                'total_amount' => $totalAmount,
                'paid_amount' => $paidAmount,
                'balance_amount' => $balanceAmount,
                'notes' => $validated['notes'] ?? null,
                'created_by' => auth()->id(),
            ]);

            foreach ($validated['items'] as $item) {
                $lineSubtotal = $item['quantity'] * $item['unit_price'];
                $lineDiscount = $item['discount'] ?? 0;
                $lineTax = $item['tax'] ?? 0;
                $lineTotal = $lineSubtotal - $lineDiscount + $lineTax;

                $purchaseItem = $purchase->items()->create([
                    'product_id' => $item['product_id'],
                    'quantity' => $item['quantity'],
                    'unit_price' => $item['unit_price'],
                    'discount' => $lineDiscount,
                    'tax' => $lineTax,
                    'total' => $lineTotal,
                    'notes' => $item['notes'] ?? null,
                ]);

                $stock = Stock::where('product_id', $purchaseItem->product_id)
                    ->where('warehouse_id', $purchase->warehouse_id)
                    ->lockForUpdate()
                    ->first();

                if ($stock) {
                    $oldQty = $stock->quantity;
                    $newQty = $oldQty + $purchaseItem->quantity;
                    $oldValue = $stock->total_value;
                    $newValue = $oldValue + ($purchaseItem->quantity * $purchaseItem->unit_price);
                    $avgCost = $newQty > 0 ? $newValue / $newQty : $purchaseItem->unit_price;

                    $stock->update([
                        'quantity' => $newQty,
                        'average_cost' => $avgCost,
                        'total_value' => $newValue,
                    ]);
                    $balanceAfter = $newQty;
                    $valueBefore = $oldValue;
                    $valueAfter = $newValue;
                } else {
                    $stock = Stock::create([
                        'product_id' => $purchaseItem->product_id,
                        'warehouse_id' => $purchase->warehouse_id,
                        'quantity' => $purchaseItem->quantity,
                        'average_cost' => $purchaseItem->unit_price,
                        'total_value' => $purchaseItem->quantity * $purchaseItem->unit_price,
                    ]);
                    $balanceAfter = $purchaseItem->quantity;
                    $valueBefore = 0;
                    $valueAfter = $stock->total_value;
                    $avgCost = $purchaseItem->unit_price;
                }

                StockLedger::create([
                    'product_id' => $purchaseItem->product_id,
                    'warehouse_id' => $purchase->warehouse_id,
                    'type' => 'in',
                    'reference_type' => 'purchase',
                    'reference_id' => $purchase->id,
                    'reference_number' => $invoiceNumber,
                    'quantity' => $purchaseItem->quantity,
                    'unit_cost' => $purchaseItem->unit_price,
                    'weighted_avg_cost' => $avgCost,
                    'total_cost' => $purchaseItem->total,
                    'balance_after' => $balanceAfter,
                    'value_before' => $valueBefore,
                    'value_after' => $valueAfter,
                    'created_by' => auth()->id(),
                    'transaction_date' => $validated['invoice_date'],
                ]);
            }

            if ($paidAmount > 0) {
                Payment::create([
                    'payment_number' => Str::upper('PAY-' . now()->format('YmdHis') . '-' . Str::random(4)),
                    'payment_type' => 'purchase',
                    'party_type' => 'supplier',
                    'party_id' => $validated['supplier_id'],
                    'reference_type' => 'purchase',
                    'reference_id' => $purchase->id,
                    'reference_number' => $invoiceNumber,
                    'payment_date' => $validated['invoice_date'],
                    'amount' => $paidAmount,
                    'payment_method' => $validated['payment_method'] ?? 'cash',
                    'status' => 'completed',
                    'created_by' => auth()->id(),
                ]);
            }

            return $purchase;
        });

        $purchase->load(['supplier', 'warehouse', 'createdBy', 'items.product']);
        
        return response()->json($purchase, 201);
    }

    public function show(Purchase $purchase)
    {
        $purchase->load(['supplier', 'warehouse', 'createdBy', 'items.product']);
        return response()->json($purchase);
    }

    public function update(Request $request, Purchase $purchase)
    {
        if ($purchase->status !== 'draft') {
            return response()->json(['message' => 'Only draft purchases can be updated'], 422);
        }

        $validated = $request->validate([
            'supplier_id' => 'sometimes|required|exists:suppliers,id',
            'warehouse_id' => 'sometimes|required|exists:warehouses,id',
            'invoice_date' => 'sometimes|required|date',
            'due_date' => 'nullable|date',
            'notes' => 'nullable|string',
            'items' => 'sometimes|required|array|min:1',
            'items.*.product_id' => 'required|exists:products,id',
            'items.*.quantity' => 'required|integer|min:1',
            'items.*.unit_price' => 'required|numeric|min:0',
            'items.*.discount' => 'nullable|numeric|min:0',
            'items.*.tax' => 'nullable|numeric|min:0',
            'items.*.notes' => 'nullable|string',
            'subtotal' => 'nullable|numeric|min:0',
            'tax_amount' => 'nullable|numeric|min:0',
            'discount_amount' => 'nullable|numeric|min:0',
            'shipping_cost' => 'nullable|numeric|min:0',
        ]);

        return DB::transaction(function () use ($purchase, $validated) {
            $oldItems = $purchase->items()->get();
            $oldWarehouseId = $purchase->warehouse_id;
            $newWarehouseId = $validated['warehouse_id'] ?? $purchase->warehouse_id;

            // Reverse stock from old items
            foreach ($oldItems as $oldItem) {
                $oldStock = Stock::where('product_id', $oldItem->product_id)
                    ->where('warehouse_id', $oldWarehouseId)
                    ->lockForUpdate()
                    ->first();

                if ($oldStock) {
                    $oldQty = $oldStock->quantity;
                    $newQty = max(0, $oldQty - $oldItem->quantity);
                    $oldValue = $oldStock->total_value;
                    $newValue = max(0, $oldValue - ($oldItem->quantity * $oldItem->unit_price));
                    $avgCost = $newQty > 0 ? $newValue / $newQty : ($oldStock->average_cost ?? 0);

                    $oldStock->update([
                        'quantity' => $newQty,
                        'average_cost' => $avgCost,
                        'total_value' => $newValue,
                    ]);
                }

                // Delete old stock ledger entries for this purchase item
                StockLedger::where('reference_type', 'purchase')
                    ->where('reference_id', $purchase->id)
                    ->where('product_id', $oldItem->product_id)
                    ->delete();
            }

            // Delete old items
            $purchase->items()->delete();

            // Update items if provided
            if (isset($validated['items'])) {
                $subtotal = 0;
                $totalTax = 0;
                $totalDiscount = 0;

                foreach ($validated['items'] as $item) {
                    $lineSubtotal = $item['quantity'] * $item['unit_price'];
                    $lineDiscount = $item['discount'] ?? 0;
                    $lineTax = $item['tax'] ?? 0;
                    $itemTotal = $lineSubtotal - $lineDiscount + $lineTax;
                    
                    $subtotal += $lineSubtotal;
                    $totalTax += $lineTax;
                    $totalDiscount += $lineDiscount;

                    $purchaseItem = $purchase->items()->create([
                        'product_id' => $item['product_id'],
                        'quantity' => $item['quantity'],
                        'unit_price' => $item['unit_price'],
                        'discount' => $lineDiscount,
                        'tax' => $lineTax,
                        'total' => $itemTotal,
                        'notes' => $item['notes'] ?? null,
                    ]);

                    // Update stock for new items
                    $stock = Stock::where('product_id', $purchaseItem->product_id)
                        ->where('warehouse_id', $newWarehouseId)
                        ->lockForUpdate()
                        ->first();

                    if ($stock) {
                        $oldQty = $stock->quantity;
                        $newQty = $oldQty + $purchaseItem->quantity;
                        $oldValue = $stock->total_value;
                        $newValue = $oldValue + ($purchaseItem->quantity * $purchaseItem->unit_price);
                        $avgCost = $newQty > 0 ? $newValue / $newQty : $purchaseItem->unit_price;

                        $stock->update([
                            'quantity' => $newQty,
                            'average_cost' => $avgCost,
                            'total_value' => $newValue,
                        ]);
                        $balanceAfter = $newQty;
                        $valueBefore = $oldValue;
                        $valueAfter = $newValue;
                    } else {
                        $stock = Stock::create([
                            'product_id' => $purchaseItem->product_id,
                            'warehouse_id' => $newWarehouseId,
                            'quantity' => $purchaseItem->quantity,
                            'average_cost' => $purchaseItem->unit_price,
                            'total_value' => $purchaseItem->quantity * $purchaseItem->unit_price,
                        ]);
                        $balanceAfter = $purchaseItem->quantity;
                        $valueBefore = 0;
                        $valueAfter = $stock->total_value;
                        $avgCost = $purchaseItem->unit_price;
                    }

                    // Create stock ledger entry
                    StockLedger::create([
                        'product_id' => $purchaseItem->product_id,
                        'warehouse_id' => $newWarehouseId,
                        'type' => 'in',
                        'reference_type' => 'purchase',
                        'reference_id' => $purchase->id,
                        'reference_number' => $purchase->invoice_number,
                        'quantity' => $purchaseItem->quantity,
                        'unit_cost' => $purchaseItem->unit_price,
                        'weighted_avg_cost' => $avgCost,
                        'total_cost' => $purchaseItem->total,
                        'balance_after' => $balanceAfter,
                        'value_before' => $valueBefore,
                        'value_after' => $valueAfter,
                        'created_by' => auth()->id(),
                        'transaction_date' => $validated['invoice_date'] ?? $purchase->invoice_date,
                    ]);
                }

                $purchase->subtotal = $subtotal;
                $purchase->tax_amount = $totalTax;
                $purchase->discount_amount = $totalDiscount;
                $purchase->total_amount = $subtotal + $totalTax + ($validated['shipping_cost'] ?? $purchase->shipping_cost) - $totalDiscount;
            }

            if (isset($validated['supplier_id'])) {
                $purchase->supplier_id = $validated['supplier_id'];
            }
            if (isset($validated['warehouse_id'])) {
                $purchase->warehouse_id = $validated['warehouse_id'];
            }
            if (isset($validated['invoice_date'])) {
                $purchase->invoice_date = $validated['invoice_date'];
            }
            if (isset($validated['due_date'])) {
                $purchase->due_date = $validated['due_date'];
            }
            if (isset($validated['notes'])) {
                $purchase->notes = $validated['notes'];
            }
            if (isset($validated['shipping_cost'])) {
                $purchase->shipping_cost = $validated['shipping_cost'];
                $purchase->total_amount = $purchase->subtotal + $purchase->tax_amount + $validated['shipping_cost'] - $purchase->discount_amount;
            }

            $purchase->balance_amount = $purchase->total_amount - $purchase->paid_amount;
            $purchase->save();
            $purchase->load(['supplier', 'warehouse', 'createdBy', 'items.product']);
            
            return response()->json($purchase);
        });
    }

    public function receive(Request $request, Purchase $purchase)
    {
        return response()->json(['message' => 'Purchases are received on creation in this system'], 200);
    }

    public function destroy(Purchase $purchase)
    {
        if ($purchase->status !== 'draft') {
            return response()->json(['message' => 'Only draft purchases can be deleted'], 422);
        }

        return DB::transaction(function () use ($purchase) {
            $items = $purchase->items()->get();
            $warehouseId = $purchase->warehouse_id;

            // Reverse stock from all items
            foreach ($items as $item) {
                $stock = Stock::where('product_id', $item->product_id)
                    ->where('warehouse_id', $warehouseId)
                    ->lockForUpdate()
                    ->first();

                if ($stock) {
                    $oldQty = $stock->quantity;
                    $newQty = max(0, $oldQty - $item->quantity);
                    $oldValue = $stock->total_value;
                    $newValue = max(0, $oldValue - ($item->quantity * $item->unit_price));
                    $avgCost = $newQty > 0 ? $newValue / $newQty : ($stock->average_cost ?? 0);

                    $stock->update([
                        'quantity' => $newQty,
                        'average_cost' => $avgCost,
                        'total_value' => $newValue,
                    ]);
                }

                // Delete stock ledger entries for this purchase
                StockLedger::where('reference_type', 'purchase')
                    ->where('reference_id', $purchase->id)
                    ->where('product_id', $item->product_id)
                    ->delete();
            }

            // Delete payment records if any
            Payment::where('reference_type', 'purchase')
                ->where('reference_id', $purchase->id)
                ->delete();

            $purchase->delete();
            
            return response()->json(['message' => 'Purchase deleted successfully']);
        });
    }
}

