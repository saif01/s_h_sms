<?php

namespace Database\Seeders;

use App\Models\Product;
use App\Models\Purchase;
use App\Models\Sale;
use App\Models\Stock;
use App\Models\StockLedger;
use App\Models\User;
use App\Models\Warehouse;
use Carbon\Carbon;
use Illuminate\Database\Seeder;

class StockLedgerSeeder extends Seeder
{
    /**
     * Seed stock ledger entries based on existing purchases, sales, and stock records
     */
    public function run(): void
    {
        $adminUser = User::where('email', 'admin@mail.com')->first() ?? User::first();
        
        if (!$adminUser) {
            $this->command->error('No admin user found. Please run AdminUserSeeder first.');
            return;
        }

        $products = Product::all();
        $warehouses = Warehouse::all();

        if ($products->isEmpty() || $warehouses->isEmpty()) {
            $this->command->error('No products or warehouses found. Please run CurrentProjectSeeder first.');
            return;
        }

        $this->command->info('Seeding stock ledger entries...');

        // Get all purchases to create stock-in entries
        $purchases = Purchase::with(['items.product', 'warehouse'])->get();
        
        foreach ($purchases as $purchase) {
            foreach ($purchase->items as $item) {
                $product = $item->product;
                $warehouse = $purchase->warehouse;
                
                // Get current stock balance before this transaction
                $stock = Stock::where('product_id', $product->id)
                    ->where('warehouse_id', $warehouse->id)
                    ->first();
                
                $balanceBefore = $stock ? $stock->quantity : 0;
                $balanceAfter = $balanceBefore + $item->quantity;
                
                // Calculate weighted average cost
                $valueBefore = $stock ? $stock->total_value : 0;
                $newValue = $item->unit_price * $item->quantity;
                $valueAfter = $valueBefore + $newValue;
                $weightedAvgCost = $balanceAfter > 0 ? $valueAfter / $balanceAfter : $item->unit_price;

                StockLedger::updateOrCreate(
                    [
                        'product_id' => $product->id,
                        'warehouse_id' => $warehouse->id,
                        'reference_type' => 'purchase',
                        'reference_id' => $purchase->id,
                    ],
                    [
                        'type' => 'in',
                        'reference_number' => $purchase->invoice_number,
                        'quantity' => $item->quantity,
                        'unit_cost' => $item->unit_price,
                        'weighted_avg_cost' => round($weightedAvgCost, 2),
                        'cost_method' => 'wavg',
                        'total_cost' => round($newValue, 2),
                        'balance_after' => $balanceAfter,
                        'value_before' => round($valueBefore, 2),
                        'value_after' => round($valueAfter, 2),
                        'notes' => "Stock in from purchase {$purchase->invoice_number}",
                        'created_by' => $adminUser->id,
                        'transaction_date' => $purchase->invoice_date,
                    ]
                );
            }
        }

        // Get all sales to create stock-out entries
        $sales = Sale::with(['items.product', 'warehouse'])->get();
        
        foreach ($sales as $sale) {
            foreach ($sale->items as $item) {
                $product = $item->product;
                $warehouse = $sale->warehouse;
                
                // Get current stock balance before this transaction
                $stock = Stock::where('product_id', $product->id)
                    ->where('warehouse_id', $warehouse->id)
                    ->first();
                
                $balanceBefore = $stock ? $stock->quantity : 0;
                $balanceAfter = max(0, $balanceBefore - $item->quantity);
                
                // Use average cost from stock for stock-out
                $unitCost = $stock && $stock->quantity > 0 ? $stock->average_cost : $product->purchase_price;
                $totalCost = $unitCost * $item->quantity;
                
                $valueBefore = $stock ? $stock->total_value : 0;
                $valueAfter = max(0, $valueBefore - $totalCost);

                StockLedger::updateOrCreate(
                    [
                        'product_id' => $product->id,
                        'warehouse_id' => $warehouse->id,
                        'reference_type' => 'sales',
                        'reference_id' => $sale->id,
                    ],
                    [
                        'type' => 'out',
                        'reference_number' => $sale->invoice_number,
                        'quantity' => $item->quantity,
                        'unit_cost' => round($unitCost, 2),
                        'weighted_avg_cost' => round($unitCost, 2),
                        'cost_method' => 'wavg',
                        'total_cost' => round($totalCost, 2),
                        'balance_after' => $balanceAfter,
                        'value_before' => round($valueBefore, 2),
                        'value_after' => round($valueAfter, 2),
                        'notes' => "Stock out from sale {$sale->invoice_number}",
                        'created_by' => $adminUser->id,
                        'transaction_date' => $sale->invoice_date,
                    ]
                );
            }
        }

        // Create some additional manual stock adjustments (damage/lost entries)
        $this->command->info('Creating additional stock adjustment entries...');
        
        for ($i = 0; $i < 5; $i++) {
            $product = $products->random();
            $warehouse = $warehouses->random();
            
            $stock = Stock::where('product_id', $product->id)
                ->where('warehouse_id', $warehouse->id)
                ->first();
            
            if (!$stock || $stock->quantity <= 0) {
                continue;
            }
            
            $adjustmentTypes = ['damage', 'lost'];
            $referenceType = $adjustmentTypes[array_rand($adjustmentTypes)];
            $quantity = rand(1, min(5, $stock->quantity));
            
            $balanceBefore = $stock->quantity;
            $balanceAfter = $balanceBefore - $quantity;
            $unitCost = $stock->average_cost;
            $totalCost = $unitCost * $quantity;
            
            $valueBefore = $stock->total_value;
            $valueAfter = max(0, $valueBefore - $totalCost);
            
            $transactionDate = Carbon::now()->subDays(rand(1, 90));

            StockLedger::create([
                'product_id' => $product->id,
                'warehouse_id' => $warehouse->id,
                'type' => 'out',
                'reference_type' => $referenceType,
                'reference_id' => null,
                'reference_number' => strtoupper($referenceType) . '-' . str_pad($i + 1, 6, '0', STR_PAD_LEFT),
                'quantity' => $quantity,
                'unit_cost' => round($unitCost, 2),
                'weighted_avg_cost' => round($unitCost, 2),
                'cost_method' => 'wavg',
                'total_cost' => round($totalCost, 2),
                'balance_after' => $balanceAfter,
                'value_before' => round($valueBefore, 2),
                'value_after' => round($valueAfter, 2),
                'notes' => ucfirst($referenceType) . " adjustment entry",
                'created_by' => $adminUser->id,
                'transaction_date' => $transactionDate,
            ]);
        }

        $this->command->info('Stock ledger entries seeded successfully!');
    }
}

