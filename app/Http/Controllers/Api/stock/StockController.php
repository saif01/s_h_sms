<?php

namespace App\Http\Controllers\Api\stock;

use App\Http\Controllers\Controller;
use App\Models\Stock;
use App\Models\StockLedger;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class StockController extends Controller
{
    public function index(Request $request)
    {
        $query = Stock::with(['product', 'warehouse']);

        // Filter by product
        if ($request->has('product_id')) {
            $query->where('product_id', $request->product_id);
        }

        // Filter by warehouse
        if ($request->has('warehouse_id')) {
            $query->where('warehouse_id', $request->warehouse_id);
        }

        // Search by product name or SKU
        if ($request->has('search')) {
            $search = $request->search;
            $query->whereHas('product', function ($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                  ->orWhere('sku', 'like', "%{$search}%");
            });
        }

        // Sorting
        $sortBy = $request->get('sort_by', 'product_id');
        $sortDirection = $request->get('sort_direction', 'asc');
        
        $allowedSortFields = ['id', 'quantity', 'average_cost', 'total_value'];
        if (!in_array($sortBy, $allowedSortFields)) {
            $sortBy = 'product_id';
        }
        
        if (!in_array($sortDirection, ['asc', 'desc'])) {
            $sortDirection = 'asc';
        }
        
        $query->orderBy($sortBy, $sortDirection);

        $stocks = $query->paginate($request->get('per_page', 25));
        
        return response()->json($stocks);
    }

    public function show(Stock $stock)
    {
        $stock->load(['product', 'warehouse']);
        return response()->json($stock);
    }

    /**
     * Store or update stock for a product in a warehouse
     * This allows direct stock adjustment
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'product_id' => 'required|exists:products,id',
            'warehouse_id' => 'required|exists:warehouses,id',
            'quantity' => 'required|integer|min:0',
            'unit_cost' => 'nullable|numeric|min:0',
            'notes' => 'nullable|string',
            'adjustment_type' => 'nullable|in:set,add,subtract', // set = set exact quantity, add = add to existing, subtract = subtract from existing
        ]);

        return DB::transaction(function () use ($validated) {
            $productId = $validated['product_id'];
            $warehouseId = $validated['warehouse_id'];
            $newQuantity = $validated['quantity'];
            $unitCost = $validated['unit_cost'] ?? 0;
            $adjustmentType = $validated['adjustment_type'] ?? 'set';
            $notes = $validated['notes'] ?? 'Manual stock adjustment';

            // Get or create stock record
            $stock = Stock::where('product_id', $productId)
                ->where('warehouse_id', $warehouseId)
                ->lockForUpdate()
                ->first();

            $oldQuantity = $stock ? $stock->quantity : 0;
            $oldValue = $stock ? $stock->total_value : 0;

            // Calculate new quantity based on adjustment type
            if ($adjustmentType === 'add') {
                $finalQuantity = $oldQuantity + $newQuantity;
            } elseif ($adjustmentType === 'subtract') {
                $finalQuantity = max(0, $oldQuantity - $newQuantity);
            } else {
                // 'set' - set exact quantity
                $finalQuantity = $newQuantity;
            }

            // Calculate quantity change for ledger
            $quantityChange = $finalQuantity - $oldQuantity;

            // Calculate new average cost and total value
            if ($stock) {
                if ($quantityChange > 0 && $unitCost > 0) {
                    // Adding stock - calculate weighted average
                    $oldTotalCost = $oldQuantity * ($stock->average_cost ?? 0);
                    $newTotalCost = $oldTotalCost + ($quantityChange * $unitCost);
                    $newAvgCost = $finalQuantity > 0 ? $newTotalCost / $finalQuantity : $unitCost;
                } else {
                    // Subtracting or setting - keep or update average cost
                    $newAvgCost = $unitCost > 0 ? $unitCost : ($stock->average_cost ?? 0);
                }
            } else {
                $newAvgCost = $unitCost > 0 ? $unitCost : 0;
            }

            $newTotalValue = $finalQuantity * $newAvgCost;

            // Update or create stock
            if ($stock) {
                $stock->update([
                    'quantity' => $finalQuantity,
                    'average_cost' => $newAvgCost,
                    'total_value' => $newTotalValue,
                ]);
            } else {
                $stock = Stock::create([
                    'product_id' => $productId,
                    'warehouse_id' => $warehouseId,
                    'quantity' => $finalQuantity,
                    'average_cost' => $newAvgCost,
                    'total_value' => $newTotalValue,
                ]);
            }

            // Create stock ledger entry if there's a change
            if ($quantityChange != 0) {
                StockLedger::create([
                    'product_id' => $productId,
                    'warehouse_id' => $warehouseId,
                    'type' => $quantityChange > 0 ? 'in' : 'out',
                    'reference_type' => 'damage', // Using 'damage' as reference type for manual adjustments
                    'reference_id' => null,
                    'reference_number' => 'MANUAL-' . now()->format('YmdHis'),
                    'quantity' => abs($quantityChange),
                    'unit_cost' => $unitCost > 0 ? $unitCost : $newAvgCost,
                    'weighted_avg_cost' => $newAvgCost,
                    'cost_method' => 'wavg',
                    'total_cost' => abs($quantityChange) * ($unitCost > 0 ? $unitCost : $newAvgCost),
                    'balance_after' => $finalQuantity,
                    'value_before' => $oldValue,
                    'value_after' => $newTotalValue,
                    'notes' => $notes,
                    'created_by' => auth()->id(),
                    'transaction_date' => now()->toDateString(),
                ]);
            }

            $stock->load(['product', 'warehouse']);

            return response()->json([
                'message' => 'Stock updated successfully',
                'stock' => $stock,
            ], 201);
        });
    }
}

