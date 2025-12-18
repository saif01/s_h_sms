<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Product;
use App\Models\Sale;
use App\Models\Stock;
use Carbon\Carbon;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    /**
     * Owner dashboard summary for the shop management system.
     */
    public function index(Request $request)
    {
        $today = Carbon::today();
        $startOfMonth = Carbon::now()->startOfMonth();

        $todaySales = Sale::whereDate('invoice_date', $today)->sum('total_amount');
        $monthSales = Sale::whereDate('invoice_date', '>=', $startOfMonth)->sum('total_amount');
        $customerDue = Sale::sum('balance_amount');

        $lowStockCount = Stock::whereHas('product', function ($q) {
            $q->where('minimum_stock_level', '>', 0);
        })
            ->join('products', 'products.id', '=', 'stocks.product_id')
            ->whereColumn('stocks.quantity', '<', 'products.minimum_stock_level')
            ->count();

        $recentSales = Sale::with('customer')
            ->orderByDesc('invoice_date')
            ->orderByDesc('id')
            ->limit(10)
            ->get()
            ->map(function ($sale) {
                return [
                    'id' => $sale->id,
                    'invoice_number' => $sale->invoice_number,
                    'customer' => $sale->customer?->name,
                    'total' => $sale->total_amount,
                    'paid' => $sale->paid_amount,
                    'balance' => $sale->balance_amount,
                    'date' => $sale->invoice_date?->toDateString(),
                ];
            });

        return response()->json([
            'metrics' => [
                'today_sales' => (float) $todaySales,
                'month_sales' => (float) $monthSales,
                'low_stock_items' => $lowStockCount,
                'customer_due' => (float) $customerDue,
                'product_count' => Product::count(),
            ],
            'recent_sales' => $recentSales,
        ]);
    }
}
