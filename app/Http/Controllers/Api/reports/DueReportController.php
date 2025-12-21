<?php

namespace App\Http\Controllers\Api\reports;

use App\Http\Controllers\Controller;
use App\Models\Sale;
use App\Models\Purchase;
use App\Models\Customer;
use App\Models\Supplier;
use Illuminate\Http\Request;
use Barryvdh\DomPDF\Facade\Pdf;

class DueReportController extends Controller
{
    /**
     * Due Report
     */
    public function index(Request $request)
    {
        $partyType = $request->party_type ?? 'customer';
        
        if ($partyType === 'customer') {
            $query = Sale::with('customer')
                ->select('sales.*')
                ->selectRaw('customers.name as party_name')
                ->selectRaw('customers.id as party_id')
                ->selectRaw('sales.balance_amount as due_amount')
                ->leftJoin('customers', 'sales.customer_id', '=', 'customers.id')
                ->where('sales.balance_amount', '>', 0);
            
            if ($request->party_id) {
                $query->where('sales.customer_id', $request->party_id);
            }
        } else {
            $query = Purchase::with('supplier')
                ->select('purchases.*')
                ->selectRaw('suppliers.name as party_name')
                ->selectRaw('suppliers.id as party_id')
                ->selectRaw('purchases.balance_amount as due_amount')
                ->leftJoin('suppliers', 'purchases.supplier_id', '=', 'suppliers.id')
                ->where('purchases.balance_amount', '>', 0);
            
            if ($request->party_id) {
                $query->where('purchases.supplier_id', $request->party_id);
            }
        }

        if ($request->overdue_only) {
            $query->whereNotNull('due_date')
                ->whereDate('due_date', '<', now());
        }

        // Sorting
        $sortBy = $request->get('sort_by', 'due_date');
        $sortDirection = $request->get('sort_direction', 'asc');
        
        // Map frontend sort fields to database fields
        $sortFieldMap = [
            'party_name' => $partyType === 'customer' ? 'customers.name' : 'suppliers.name',
            'invoice_number' => $partyType === 'customer' ? 'sales.invoice_number' : 'purchases.invoice_number',
            'invoice_date' => $partyType === 'customer' ? 'sales.invoice_date' : 'purchases.invoice_date',
            'due_date' => $partyType === 'customer' ? 'sales.due_date' : 'purchases.due_date',
            'total_amount' => $partyType === 'customer' ? 'sales.total_amount' : 'purchases.total_amount',
            'paid_amount' => $partyType === 'customer' ? 'sales.paid_amount' : 'purchases.paid_amount',
            'due_amount' => $partyType === 'customer' ? 'sales.balance_amount' : 'purchases.balance_amount',
        ];
        
        $dbSortField = $sortFieldMap[$sortBy] ?? ($partyType === 'customer' ? 'sales.due_date' : 'purchases.due_date');
        
        if (!in_array($sortDirection, ['asc', 'desc'])) {
            $sortDirection = 'asc';
        }
        
        $query->orderBy($dbSortField, $sortDirection);

        // Get all due records for summary calculation (before pagination)
        $allDue = clone $query;
        $allDueForSummary = $allDue->get();

        // Calculate summary from all filtered due records
        $summary = [
            'total_due' => (float) ($allDueForSummary->sum('due_amount') ?? 0),
            'overdue_amount' => (float) ($allDueForSummary->filter(function ($item) {
                return $item->due_date && $item->due_date < now();
            })->sum('due_amount') ?? 0),
            'total_parties' => (int) $allDueForSummary->unique('party_id')->count(),
        ];

        // Paginate the due records
        $perPage = $request->get('per_page', 10);
        $due = $query->paginate($perPage);

        // Return paginated response with additional data
        $response = $due->toArray();
        $response['summary'] = $summary;
        $response['due'] = $response['data']; // Keep 'due' key for backward compatibility
        
        return response()->json($response);
    }

    /**
     * Export Due Report to Excel
     */
    public function exportExcel(Request $request)
    {
        // Implementation would use Maatwebsite\Excel package
        return response()->json(['message' => 'Excel export functionality to be implemented']);
    }

    /**
     * Export Due Report to PDF
     */
    public function exportPDF(Request $request)
    {
        $partyType = $request->party_type ?? 'customer';
        
        if ($partyType === 'customer') {
            $query = Sale::with('customer')
                ->select('sales.*')
                ->selectRaw('customers.name as party_name')
                ->selectRaw('customers.id as party_id')
                ->selectRaw('sales.balance_amount as due_amount')
                ->leftJoin('customers', 'sales.customer_id', '=', 'customers.id')
                ->where('sales.balance_amount', '>', 0);
            
            if ($request->party_id) {
                $query->where('sales.customer_id', $request->party_id);
            }
        } else {
            $query = Purchase::with('supplier')
                ->select('purchases.*')
                ->selectRaw('suppliers.name as party_name')
                ->selectRaw('suppliers.id as party_id')
                ->selectRaw('purchases.balance_amount as due_amount')
                ->leftJoin('suppliers', 'purchases.supplier_id', '=', 'suppliers.id')
                ->where('purchases.balance_amount', '>', 0);
            
            if ($request->party_id) {
                $query->where('purchases.supplier_id', $request->party_id);
            }
        }

        if ($request->overdue_only) {
            $query->whereNotNull('due_date')
                ->whereDate('due_date', '<', now());
        }

        // Get all due records (no pagination for PDF)
        $allDue = $query->orderBy('due_date', 'asc')->get();

        // Calculate summary
        $summary = [
            'total_due' => (float) ($allDue->sum('due_amount') ?? 0),
            'overdue_amount' => (float) ($allDue->filter(function ($item) {
                return $item->due_date && $item->due_date < now();
            })->sum('due_amount') ?? 0),
            'total_parties' => (int) $allDue->unique('party_id')->count(),
        ];

        // Get party name if filter is applied
        $partyName = null;
        if ($request->party_id) {
            if ($partyType === 'customer') {
                $party = Customer::find($request->party_id);
            } else {
                $party = Supplier::find($request->party_id);
            }
            $partyName = $party ? $party->name : null;
        }

        // Prepare data for PDF
        $data = [
            'due' => $allDue,
            'summary' => $summary,
            'partyType' => $partyType,
            'filters' => [
                'party_id' => $request->party_id,
                'overdue_only' => $request->overdue_only,
            ],
            'partyName' => $partyName,
        ];

        // Generate PDF
        $pdf = Pdf::loadView('reports.due-report', $data);
        $pdf->setPaper('a4', 'landscape');
        
        // Generate filename
        $filename = 'due_report_' . $partyType . '_' . date('Y-m-d_His') . '.pdf';
        
        return $pdf->download($filename);
    }
}

