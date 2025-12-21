<?php

namespace Database\Seeders;

use App\Models\Product;
use App\Models\Purchase;
use App\Models\PurchaseItem;
use App\Models\Stock;
use App\Models\Supplier;
use App\Models\User;
use App\Models\Warehouse;
use Carbon\Carbon;
use Illuminate\Database\Seeder;

class PurchaseSeeder extends Seeder
{
    /**
     * Seed purchase transactions with items
     */
    public function run(): void
    {
        $adminUser = User::where('email', 'admin@mail.com')->first() ?? User::first();
        
        if (!$adminUser) {
            $this->command->error('No admin user found. Please run AdminUserSeeder first.');
            return;
        }

        $suppliers = Supplier::all();
        $warehouses = Warehouse::all();
        $products = Product::all();

        if ($suppliers->isEmpty() || $warehouses->isEmpty() || $products->isEmpty()) {
            $this->command->error('Required data not found. Please run CurrentProjectSeeder first.');
            return;
        }

        $this->command->info('Seeding purchase transactions...');

        // Get the highest invoice number to continue from
        $lastPurchase = Purchase::orderBy('id', 'desc')->first();
        $invoiceCounter = $lastPurchase ? (int) str_replace('PO-', '', $lastPurchase->invoice_number) + 1 : 1;

        // Create 50 purchase transactions
        for ($i = 0; $i < 50; $i++) {
            $supplier = $suppliers->random();
            $warehouse = $warehouses->random();
            
            // Generate unique invoice number
            do {
                $invoiceNumber = 'PO-' . str_pad($invoiceCounter++, 6, '0', STR_PAD_LEFT);
            } while (Purchase::where('invoice_number', $invoiceNumber)->exists());
            
            // Random date within last 6 months
            $invoiceDate = Carbon::now()->subMonths(rand(0, 6))->subDays(rand(0, 30));
            $dueDate = $invoiceDate->copy()->addDays(rand(15, 45));
            
            // Random status
            $statuses = ['draft', 'pending', 'partial', 'paid', 'cancelled'];
            $status = $statuses[array_rand($statuses)];
            
            // Select 1-5 random products for this purchase
            $purchaseProducts = $products->random(rand(1, min(5, count($products))));
            
            $subtotal = 0;
            $taxAmount = 0;
            $discountAmount = 0;
            $purchaseItems = [];

            foreach ($purchaseProducts as $product) {
                $quantity = rand(10, 100);
                $unitPrice = $product->purchase_price * (1 + (rand(-10, 10) / 100)); // ±10% variation
                $discount = rand(0, 20) > 15 ? rand(100, 1000) : 0; // 20% chance of discount
                $tax = ($unitPrice * $quantity - $discount) * 0.15; // 15% tax
                $total = ($unitPrice * $quantity) - $discount + $tax;

                $subtotal += ($unitPrice * $quantity);
                $discountAmount += $discount;
                $taxAmount += $tax;

                $purchaseItems[] = [
                    'product_id' => $product->id,
                    'quantity' => $quantity,
                    'unit_price' => round($unitPrice, 2),
                    'discount' => $discount,
                    'tax' => round($tax, 2),
                    'total' => round($total, 2),
                ];
            }

            $shippingCost = rand(0, 20) > 15 ? rand(200, 500) : 0; // 20% chance of shipping
            $totalAmount = $subtotal - $discountAmount + $taxAmount + $shippingCost;

            // Calculate paid and balance based on status
            $paidAmount = 0;
            $balanceAmount = $totalAmount;

            if ($status === 'paid') {
                $paidAmount = $totalAmount;
                $balanceAmount = 0;
            } elseif ($status === 'partial') {
                $paidAmount = $totalAmount * (rand(30, 70) / 100);
                $balanceAmount = $totalAmount - $paidAmount;
            } elseif ($status === 'pending') {
                $paidAmount = 0;
                $balanceAmount = $totalAmount;
            } elseif ($status === 'cancelled') {
                $paidAmount = 0;
                $balanceAmount = 0;
            }

            $purchase = Purchase::create([
                'invoice_number' => $invoiceNumber,
                'supplier_id' => $supplier->id,
                'warehouse_id' => $warehouse->id,
                'invoice_date' => $invoiceDate,
                'due_date' => $dueDate,
                'status' => $status,
                'subtotal' => round($subtotal, 2),
                'tax_amount' => round($taxAmount, 2),
                'discount_amount' => round($discountAmount, 2),
                'shipping_cost' => $shippingCost,
                'total_amount' => round($totalAmount, 2),
                'paid_amount' => round($paidAmount, 2),
                'balance_amount' => round($balanceAmount, 2),
                'notes' => rand(0, 10) > 7 ? 'Additional notes for purchase order ' . $invoiceNumber : null,
                'created_by' => $adminUser->id,
                'updated_by' => null, // Newly created records haven't been updated yet
            ]);

            // Create purchase items and update stock
            foreach ($purchaseItems as $item) {
                PurchaseItem::create([
                    'purchase_id' => $purchase->id,
                    'product_id' => $item['product_id'],
                    'quantity' => $item['quantity'],
                    'unit_price' => $item['unit_price'],
                    'discount' => $item['discount'],
                    'tax' => $item['tax'],
                    'total' => $item['total'],
                ]);

                // Update stock (only if purchase is not cancelled or draft)
                if (!in_array($status, ['cancelled', 'draft'])) {
                    $stock = Stock::firstOrNew([
                        'product_id' => $item['product_id'],
                        'warehouse_id' => $warehouse->id,
                    ]);

                    $oldQuantity = $stock->quantity ?? 0;
                    $oldValue = $stock->total_value ?? 0;
                    $newQuantity = $oldQuantity + $item['quantity'];
                    $newValue = $oldValue + ($item['unit_price'] * $item['quantity']);
                    $averageCost = $newQuantity > 0 ? $newValue / $newQuantity : $item['unit_price'];

                    $stock->quantity = $newQuantity;
                    $stock->average_cost = round($averageCost, 2);
                    $stock->total_value = round($newValue, 2);
                    $stock->save();
                }
            }

            // Update supplier balance
            if (!in_array($status, ['cancelled', 'draft'])) {
                $supplier->current_balance += $balanceAmount;
                $supplier->save();
            }

            if (($i + 1) % 10 === 0) {
                $this->command->info("Created {$invoiceNumber} - Progress: " . ($i + 1) . "/50");
            }
        }

        $this->command->info('Successfully seeded 50 purchase transactions!');
    }
}

