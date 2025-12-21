<?php

namespace App\Http\Controllers\Api\reports;

use App\Http\Controllers\Controller;
use App\Models\Sale;
use App\Models\Purchase;
use App\Models\Stock;
use App\Models\Customer;
use App\Models\Supplier;
use App\Models\SalesItem;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Facades\Excel;
use Barryvdh\DomPDF\Facade\Pdf;

class ReportController extends Controller
{
    /**
     * Sales Report
     */
    public function salesReport(Request $request)
    {
        $query = Sale::with(['customer', 'items.product'])
            ->select('sales.*')
            ->selectRaw('customers.name as customer_name');
        
        $query->leftJoin('customers', 'sales.customer_id', '=', 'customers.id');

        // Apply filters
        if ($request->date_from) {
            $query->whereDate('sales.invoice_date', '>=', $request->date_from);
        }
        if ($request->date_to) {
            $query->whereDate('sales.invoice_date', '<=', $request->date_to);
        }
        if ($request->customer_id) {
            $query->where('sales.customer_id', $request->customer_id);
        }
        if ($request->status) {
            $query->where('sales.status', $request->status);
        }

        // Sorting
        $sortBy = $request->get('sort_by', 'invoice_date');
        $sortDirection = $request->get('sort_direction', 'desc');
        
        $allowedSortFields = [
            'id', 'invoice_number', 'invoice_date', 'customer_name', 
            'total_amount', 'paid_amount', 'balance_amount', 'status', 'created_at'
        ];
        
        // Map frontend sort fields to database fields
        $sortFieldMap = [
            'invoice_number' => 'sales.invoice_number',
            'invoice_date' => 'sales.invoice_date',
            'customer_name' => 'customers.name',
            'total_amount' => 'sales.total_amount',
            'paid_amount' => 'sales.paid_amount',
            'balance_amount' => 'sales.balance_amount',
            'status' => 'sales.status',
        ];
        
        $dbSortField = $sortFieldMap[$sortBy] ?? 'sales.invoice_date';
        
        if (!in_array($sortDirection, ['asc', 'desc'])) {
            $sortDirection = 'desc';
        }
        
        $query->orderBy($dbSortField, $sortDirection);

        // Get all sales for summary calculation (before pagination)
        $allSales = clone $query;
        $allSalesForSummary = $allSales->get();

        // For financial calculations: exclude cancelled sales unless explicitly filtered by cancelled status
        $salesForFinancials = $allSalesForSummary;
        if (!$request->status || $request->status !== 'cancelled') {
            // If no status filter or not filtering by cancelled, exclude cancelled from financials
            $salesForFinancials = $allSalesForSummary->where('status', '!=', 'cancelled');
        }
        
        // Calculate summary from all filtered sales
        // Financial totals exclude cancelled sales (unless explicitly viewing cancelled), count includes all
        $summary = [
            'total_sales' => (float) ($salesForFinancials->sum('total_amount') ?? 0),
            'total_paid' => (float) ($salesForFinancials->sum('paid_amount') ?? 0),
            'total_due' => (float) ($salesForFinancials->sum('balance_amount') ?? 0),
            'total_count' => (int) $allSalesForSummary->count(), // Include all statuses in count
        ];

        // Paginate the sales
        $perPage = $request->get('per_page', 10);
        $sales = $query->paginate($perPage);

        // Top selling products
        $topProducts = SalesItem::select(
                'product_id',
                'products.name as product_name',
                DB::raw('SUM(quantity) as total_quantity'),
                DB::raw('SUM(total) as total_revenue')
            )
            ->join('products', 'sales_items.product_id', '=', 'products.id')
            ->join('sales', 'sales_items.sale_id', '=', 'sales.id');
        
        // Apply same filters as main query
        if ($request->date_from) {
            $topProducts->whereDate('sales.invoice_date', '>=', $request->date_from);
        }
        if ($request->date_to) {
            $topProducts->whereDate('sales.invoice_date', '<=', $request->date_to);
        }
        if ($request->customer_id) {
            $topProducts->where('sales.customer_id', $request->customer_id);
        }
        if ($request->status) {
            $topProducts->where('sales.status', $request->status);
        } else {
            // If no status filter, exclude cancelled sales from top products
            $topProducts->where('sales.status', '!=', 'cancelled');
        }
        
        $topProducts = $topProducts->groupBy('product_id', 'products.name')
            ->orderByDesc('total_quantity')
            ->limit(10)
            ->get();

        // Return paginated response with additional data
        $response = $sales->toArray();
        $response['summary'] = $summary;
        $response['top_products'] = $topProducts;
        $response['sales'] = $response['data']; // Keep 'sales' key for backward compatibility
        
        return response()->json($response);
    }

    /**
     * Purchase Report
     */
    public function purchaseReport(Request $request)
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
        
        $allowedSortFields = [
            'id', 'invoice_number', 'invoice_date', 'supplier_name', 
            'total_amount', 'paid_amount', 'balance_amount', 'status', 'created_at'
        ];
        
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
            // If no status filter or not filtering by cancelled, exclude cancelled from financials
            $purchasesForFinancials = $allPurchasesForSummary->where('status', '!=', 'cancelled');
        }
        
        // Calculate summary from all filtered purchases
        // Financial totals exclude cancelled purchases (unless explicitly viewing cancelled), count includes all
        $summary = [
            'total_purchases' => (float) ($purchasesForFinancials->sum('total_amount') ?? 0),
            'total_paid' => (float) ($purchasesForFinancials->sum('paid_amount') ?? 0),
            'total_due' => (float) ($purchasesForFinancials->sum('balance_amount') ?? 0),
            'total_count' => (int) $allPurchasesForSummary->count(), // Include all statuses in count
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
     * Stock Report
     */
    public function stockReport(Request $request)
    {
        $query = Stock::with(['product.category', 'warehouse'])
            ->select('stocks.*')
            ->selectRaw('products.name as product_name')
            ->selectRaw('products.sku as sku')
            ->selectRaw('products.purchase_price as purchase_price')
            ->selectRaw('products.minimum_stock_level as minimum_stock_level')
            ->selectRaw('categories.name as category_name')
            ->selectRaw('warehouses.name as warehouse_name');
        
        $query->leftJoin('products', 'stocks.product_id', '=', 'products.id')
            ->leftJoin('categories', 'products.category_id', '=', 'categories.id')
            ->leftJoin('warehouses', 'stocks.warehouse_id', '=', 'warehouses.id');

        // Apply filters
        if ($request->warehouse_id) {
            $query->where('stocks.warehouse_id', $request->warehouse_id);
        }
        if ($request->category_id) {
            $query->where('products.category_id', $request->category_id);
        }
        if ($request->low_stock_only) {
            $query->whereColumn('stocks.quantity', '<=', 'products.minimum_stock_level');
        }

        // Sorting
        $sortBy = $request->get('sort_by', 'product_name');
        $sortDirection = $request->get('sort_direction', 'asc');
        
        $allowedSortFields = [
            'product_name', 'sku', 'category_name', 'warehouse_name',
            'quantity', 'minimum_stock_level', 'status'
        ];
        
        // Map frontend sort fields to database fields
        $sortFieldMap = [
            'product_name' => 'products.name',
            'sku' => 'products.sku',
            'category_name' => 'categories.name',
            'warehouse_name' => 'warehouses.name',
            'quantity' => 'stocks.quantity',
            'minimum_stock_level' => 'products.minimum_stock_level',
            'stock_value' => DB::raw('(stocks.quantity * products.purchase_price)'),
            'status' => DB::raw('CASE 
                WHEN stocks.quantity = 0 THEN 1
                WHEN stocks.quantity <= products.minimum_stock_level THEN 2
                ELSE 3
            END'),
        ];
        
        $dbSortField = $sortFieldMap[$sortBy] ?? 'products.name';
        
        if (!in_array($sortDirection, ['asc', 'desc'])) {
            $sortDirection = 'asc';
        }
        
        $query->orderBy($dbSortField, $sortDirection);

        // Get all stock for summary calculation (before pagination)
        $allStock = clone $query;
        $allStockForSummary = $allStock->get();

        // Calculate summary from all filtered stock
        $totalStockValue = $allStockForSummary->sum(function ($item) {
            return $item->quantity * $item->purchase_price;
        });

        $lowStockCount = $allStockForSummary->filter(function ($item) {
            return $item->quantity > 0 && $item->quantity <= $item->minimum_stock_level;
        })->count();

        $outOfStockCount = $allStockForSummary->filter(function ($item) {
            return $item->quantity == 0;
        })->count();

        $summary = [
            'total_products' => $allStockForSummary->count(),
            'total_stock_value' => (float) $totalStockValue,
            'low_stock_count' => (int) $lowStockCount,
            'out_of_stock_count' => (int) $outOfStockCount,
        ];

        // Paginate the stock
        $perPage = $request->get('per_page', 10);
        $stock = $query->paginate($perPage);

        // Return paginated response with additional data
        $response = $stock->toArray();
        $response['summary'] = $summary;
        $response['stock'] = $response['data']; // Keep 'stock' key for backward compatibility
        
        return response()->json($response);
    }

    /**
     * Due Report
     */
    public function dueReport(Request $request)
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
        
        $allowedSortFields = [
            'party_name', 'invoice_number', 'invoice_date', 'due_date',
            'total_amount', 'paid_amount', 'due_amount'
        ];
        
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
     * Profit Report
     */
    public function profitReport(Request $request)
    {
        $groupBy = $request->group_by ?? 'daily';
        
        $query = SalesItem::select(
                'sales_items.*',
                'sales.invoice_date',
                'products.name as product_name',
                'products.purchase_price',
                'categories.name as category_name'
            )
            ->join('sales', 'sales_items.sale_id', '=', 'sales.id')
            ->join('products', 'sales_items.product_id', '=', 'products.id')
            ->leftJoin('categories', 'products.category_id', '=', 'categories.id')
            ->where('sales.status', '!=', 'cancelled');

        // Apply filters
        if ($request->date_from) {
            $query->whereDate('sales.invoice_date', '>=', $request->date_from);
        }
        if ($request->date_to) {
            $query->whereDate('sales.invoice_date', '<=', $request->date_to);
        }
        if ($request->category_id) {
            $query->where('products.category_id', $request->category_id);
        }

        $items = $query->get();

        // Group and calculate profit
        $profitData = [];
        
        if ($groupBy === 'product') {
            $grouped = $items->groupBy('product_id');
            foreach ($grouped as $productId => $group) {
                $revenue = $group->sum('total');
                $cost = $group->sum(function ($item) {
                    return $item->quantity * $item->purchase_price;
                });
                $discount = $group->sum('discount');
                $profit = $revenue - $cost - $discount;
                
                $profitData[] = [
                    'id' => $productId,
                    'name' => $group->first()->product_name,
                    'period' => 'All',
                    'quantity_sold' => $group->sum('quantity'),
                    'revenue' => $revenue,
                    'cost' => $cost,
                    'discount' => $discount,
                    'profit' => $profit,
                    'profit_margin' => $revenue > 0 ? ($profit / $revenue) * 100 : 0,
                ];
            }
        } elseif ($groupBy === 'category') {
            $grouped = $items->groupBy('category_name');
            foreach ($grouped as $category => $group) {
                $revenue = $group->sum('total');
                $cost = $group->sum(function ($item) {
                    return $item->quantity * $item->purchase_price;
                });
                $discount = $group->sum('discount');
                $profit = $revenue - $cost - $discount;
                
                $profitData[] = [
                    'id' => $category ?? 'uncategorized',
                    'name' => $category ?? 'Uncategorized',
                    'period' => 'All',
                    'quantity_sold' => $group->sum('quantity'),
                    'revenue' => $revenue,
                    'cost' => $cost,
                    'discount' => $discount,
                    'profit' => $profit,
                    'profit_margin' => $revenue > 0 ? ($profit / $revenue) * 100 : 0,
                ];
            }
        } else {
            // Group by date period
            $grouped = $items->groupBy(function ($item) use ($groupBy) {
                $date = $item->invoice_date;
                if ($groupBy === 'daily') {
                    return $date->format('Y-m-d');
                } elseif ($groupBy === 'weekly') {
                    return $date->format('Y-W');
                } elseif ($groupBy === 'monthly') {
                    return $date->format('Y-m');
                }
                return $date->format('Y-m-d');
            });
            
            foreach ($grouped as $period => $group) {
                $revenue = $group->sum('total');
                $cost = $group->sum(function ($item) {
                    return $item->quantity * $item->purchase_price;
                });
                $discount = $group->sum('discount');
                $profit = $revenue - $cost - $discount;
                
                $profitData[] = [
                    'id' => $period,
                    'period' => $period,
                    'name' => '-',
                    'quantity_sold' => $group->sum('quantity'),
                    'revenue' => $revenue,
                    'cost' => $cost,
                    'discount' => $discount,
                    'profit' => $profit,
                    'profit_margin' => $revenue > 0 ? ($profit / $revenue) * 100 : 0,
                ];
            }
        }

        // Convert to collection for sorting and pagination
        $profitCollection = collect($profitData);

        // Sorting
        $sortBy = $request->get('sort_by', 'period');
        $sortDirection = $request->get('sort_direction', 'asc');
        
        $allowedSortFields = [
            'period', 'name', 'quantity_sold', 'revenue', 'cost', 'discount', 'profit', 'profit_margin'
        ];
        
        if (in_array($sortBy, $allowedSortFields) && in_array($sortDirection, ['asc', 'desc'])) {
            $profitCollection = $profitCollection->sortBy($sortBy, SORT_REGULAR, $sortDirection === 'desc');
        }

        // Calculate summary from all grouped data (before pagination)
        $totalRevenue = $profitCollection->sum('revenue');
        $totalCost = $profitCollection->sum('cost');
        $grossProfit = $totalRevenue - $totalCost;
        
        $summary = [
            'total_revenue' => (float) $totalRevenue,
            'total_cost' => (float) $totalCost,
            'gross_profit' => (float) $grossProfit,
            'profit_margin' => (float) ($totalRevenue > 0 ? ($grossProfit / $totalRevenue) * 100 : 0),
        ];

        // Paginate the profit data
        $perPage = $request->get('per_page', 10);
        $currentPage = $request->get('page', 1);
        
        // Manual pagination for collection
        $total = $profitCollection->count();
        $offset = ($currentPage - 1) * $perPage;
        $paginatedData = $profitCollection->slice($offset, $perPage)->values();
        
        // Build pagination response
        $lastPage = (int) ceil($total / $perPage);
        
        $response = [
            'data' => $paginatedData,
            'current_page' => (int) $currentPage,
            'last_page' => $lastPage,
            'per_page' => (int) $perPage,
            'total' => $total,
            'from' => $total > 0 ? $offset + 1 : null,
            'to' => $total > 0 ? min($offset + $perPage, $total) : null,
            'summary' => $summary,
            'profit' => $paginatedData, // Keep 'profit' key for backward compatibility
            'chart' => $profitCollection->take(30)->values(), // Chart data (first 30 records for visualization)
        ];
        
        return response()->json($response);
    }

    /**
     * Export Sales Report to Excel
     */
    public function exportSalesExcel(Request $request)
    {
        // Implementation would use Maatwebsite\Excel package
        // For now, return a placeholder response
        return response()->json(['message' => 'Excel export functionality to be implemented']);
    }

    /**
     * Export Sales Report to PDF
     */
    public function exportSalesPDF(Request $request)
    {
        // Implementation would use DomPDF package
        // For now, return a placeholder response
        return response()->json(['message' => 'PDF export functionality to be implemented']);
    }
}

