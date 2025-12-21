<?php

namespace App\Http\Controllers\Api\payments;

use App\Http\Controllers\Controller;
use App\Models\Payment;
use App\Models\Supplier;
use App\Models\Customer;
use App\Models\Purchase;
use App\Models\Sale;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class PaymentController extends Controller
{
    public function index(Request $request)
    {
        $query = Payment::query()->orderByDesc('payment_date')->orderByDesc('id');

        if ($request->filled('party_type')) {
            $query->where('party_type', $request->party_type);
        }

        if ($request->filled('reference_type')) {
            $query->where('reference_type', $request->reference_type);
        }

        if ($request->filled('from_date')) {
            $query->whereDate('payment_date', '>=', $request->from_date);
        }

        if ($request->filled('to_date')) {
            $query->whereDate('payment_date', '<=', $request->to_date);
        }

        if ($request->filled('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('payment_number', 'like', "%{$search}%")
                    ->orWhere('reference_number', 'like', "%{$search}%")
                    ->orWhere('transaction_reference', 'like', "%{$search}%");
            });
        }

        return response()->json($query->paginate($request->get('per_page', 10)));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'party_type' => 'required|in:supplier,customer',
            'party_id' => 'required|integer',
            'reference_type' => 'nullable|in:purchase,sale',
            'reference_id' => 'nullable|integer',
            'reference_number' => 'nullable|string|max:255',
            'payment_date' => 'required|date',
            'amount' => 'required|numeric|min:0.01',
            'payment_method' => 'nullable|string|max:50',
            'transaction_reference' => 'nullable|string|max:255',
            'notes' => 'nullable|string',
        ]);

        if ($validated['party_type'] === 'supplier' && !Supplier::where('id', $validated['party_id'])->exists()) {
            return response()->json(['message' => 'Supplier not found'], 422);
        }

        if ($validated['party_type'] === 'customer' && !Customer::where('id', $validated['party_id'])->exists()) {
            return response()->json(['message' => 'Customer not found'], 422);
        }

        $payment = DB::transaction(function () use ($validated) {
            $referenceNumber = $validated['reference_number'] ?? null;
            $payment = Payment::create([
                'payment_number' => Str::upper('PAY-' . now()->format('YmdHis') . '-' . Str::random(4)),
                'payment_type' => $validated['reference_type'] ?? 'sale',
                'party_type' => $validated['party_type'],
                'party_id' => $validated['party_id'],
                'reference_type' => $validated['reference_type'],
                'reference_id' => $validated['reference_id'],
                'reference_number' => $referenceNumber,
                'payment_date' => $validated['payment_date'],
                'amount' => $validated['amount'],
                'payment_method' => $validated['payment_method'] ?? 'cash',
                'transaction_reference' => $validated['transaction_reference'] ?? null,
                'notes' => $validated['notes'] ?? null,
                'status' => 'completed',
                'created_by' => auth()->id(),
            ]);

            if ($validated['reference_type'] === 'sale' && $validated['reference_id']) {
                $sale = Sale::lockForUpdate()->findOrFail($validated['reference_id']);
                $paid = min($sale->paid_amount + $validated['amount'], $sale->total_amount);
                $balance = max($sale->total_amount - $paid, 0);
                $sale->update([
                    'paid_amount' => $paid,
                    'balance_amount' => $balance,
                    'status' => $balance <= 0 ? 'paid' : 'partial',
                ]);
                $payment->update([
                    'reference_number' => $referenceNumber ?? $sale->invoice_number,
                ]);
            }

            if ($validated['reference_type'] === 'purchase' && $validated['reference_id']) {
                $purchase = Purchase::lockForUpdate()->findOrFail($validated['reference_id']);
                $paid = min($purchase->paid_amount + $validated['amount'], $purchase->total_amount);
                $balance = max($purchase->total_amount - $paid, 0);
                $newStatus = $balance <= 0 ? 'paid' : ($paid > 0 ? 'partial' : 'pending');
                $purchase->update([
                    'paid_amount' => $paid,
                    'balance_amount' => $balance,
                    'status' => $newStatus,
                ]);
                $payment->update([
                    'reference_number' => $referenceNumber ?? $purchase->invoice_number,
                ]);
            }

            return $payment;
        });

        return response()->json($payment, 201);
    }
}
