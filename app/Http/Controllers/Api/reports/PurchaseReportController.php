<?php

namespace App\Http\Controllers\Api\reports;

use App\Http\Controllers\Controller;
use App\Models\Purchase;
use App\Models\Supplier;
use Illuminate\Http\Request;
use Barryvdh\DomPDF\Facade\Pdf;

class PurchaseReportController extends Controller
{
    /**
     * Purchase Report
     */
    public function index(Request $request)
    {
        $query = Purchase::with(['supplier', 'items.product'])
            ->select('purchases.*')
            ->selectRaw('suppliers.name as supplier_name');
        
        $query->leftJoin('suppliers', 'purchases.supplier_id', '=', 'suppliers.id');

        // Apply filters
        if ($request->date_from) {
            $query->whereDate('purchases.invoice_date', '>=', $request->date_from);
        }
        if ($request->date_to) {
            $query->whereDate('purchases.invoice_date', '<=', $request->date_to);
        }
        if ($request->supplier_id) {
            $query->where('purchases.supplier_id', $request->supplier_id);
        }
        if ($request->status) {
            $query->where('purchases.status', $request->status);
        }

        // Sorting
        $sortBy = $request->get('sort_by', 'invoice_date');
        $sortDirection = $request->get('sort_direction', 'desc');
        
        // Map frontend sort fields to database fields
        $sortFieldMap = [
            'invoice_number' => 'purchases.invoice_number',
            'invoice_date' => 'purchases.invoice_date',
            'supplier_name' => 'suppliers.name',
            'total_amount' => 'purchases.total_amount',
            'paid_amount' => 'purchases.paid_amount',
            'balance_amount' => 'purchases.balance_amount',
            'status' => 'purchases.status',
        ];
        
        $dbSortField = $sortFieldMap[$sortBy] ?? 'purchases.invoice_date';
        
        if (!in_array($sortDirection, ['asc', 'desc'])) {
            $sortDirection = 'desc';
        }
        
        $query->orderBy($dbSortField, $sortDirection);

        // Get all purchases for summary calculation (before pagination)
        $allPurchases = clone $query;
        $allPurchasesForSummary = $allPurchases->get();

        // For financial calculations: exclude cancelled purchases unless explicitly filtered by cancelled status
        $purchasesForFinancials = $allPurchasesForSummary;
        if (!$request->status || $request->status !== 'cancelled') {
            $purchasesForFinancials = $allPurchasesForSummary->where('status', '!=', 'cancelled');
        }
        
        // Calculate summary from all filtered purchases
        $summary = [
            'total_purchases' => (float) ($purchasesForFinancials->sum('total_amount') ?? 0),
            'total_paid' => (float) ($purchasesForFinancials->sum('paid_amount') ?? 0),
            'total_due' => (float) ($purchasesForFinancials->sum('balance_amount') ?? 0),
            'total_count' => (int) $allPurchasesForSummary->count(),
        ];

        // Paginate the purchases
        $perPage = $request->get('per_page', 10);
        $purchases = $query->paginate($perPage);

        // Return paginated response with additional data
        $response = $purchases->toArray();
        $response['summary'] = $summary;
        $response['purchases'] = $response['data']; // Keep 'purchases' key for backward compatibility
        
        return response()->json($response);
    }

    /**
     * Export Purchase Report to Excel
     */
    public function exportExcel(Request $request)
    {
        // Implementation would use Maatwebsite\Excel package
        return response()->json(['message' => 'Excel export functionality to be implemented']);
    }

    /**
     * Export Purchase Report to PDF
     */
    public function exportPDF(Request $request)
    {
        $query = Purchase::with(['supplier', 'items.product'])
            ->select('purchases.*')
            ->selectRaw('suppliers.name as supplier_name');
        
        $query->leftJoin('suppliers', 'purchases.supplier_id', '=', 'suppliers.id');

        // Apply filters
        if ($request->date_from) {
            $query->whereDate('purchases.invoice_date', '>=', $request->date_from);
        }
        if ($request->date_to) {
            $query->whereDate('purchases.invoice_date', '<=', $request->date_to);
        }
        if ($request->supplier_id) {
            $query->where('purchases.supplier_id', $request->supplier_id);
        }
        if ($request->status) {
            $query->where('purchases.status', $request->status);
        }

        // Get all purchases (no pagination for PDF)
        $allPurchases = $query->orderBy('purchases.invoice_date', 'desc')->get();

        // For financial calculations: exclude cancelled purchases unless explicitly filtered by cancelled status
        $purchasesForFinancials = $allPurchases;
        if (!$request->status || $request->status !== 'cancelled') {
            $purchasesForFinancials = $allPurchases->where('status', '!=', 'cancelled');
        }
        
        // Calculate summary
        $summary = [
            'total_purchases' => (float) ($purchasesForFinancials->sum('total_amount') ?? 0),
            'total_paid' => (float) ($purchasesForFinancials->sum('paid_amount') ?? 0),
            'total_due' => (float) ($purchasesForFinancials->sum('balance_amount') ?? 0),
            'total_count' => (int) $allPurchases->count(),
        ];

        // Get supplier name if filter is applied
        $supplierName = null;
        if ($request->supplier_id) {
            $supplier = Supplier::find($request->supplier_id);
            $supplierName = $supplier ? $supplier->name : null;
        }

        // Prepare data for PDF
        $data = [
            'purchases' => $allPurchases,
            'summary' => $summary,
            'filters' => [
                'date_from' => $request->date_from,
                'date_to' => $request->date_to,
                'supplier_id' => $request->supplier_id,
                'status' => $request->status,
            ],
            'supplierName' => $supplierName,
        ];

        // Generate PDF
        $pdf = Pdf::loadView('reports.purchase-report', $data);
        $pdf->setPaper('a4', 'landscape');
        
        // Generate filename
        $filename = 'purchase_report_' . date('Y-m-d_His') . '.pdf';
        
        return $pdf->download($filename);
    }
}

