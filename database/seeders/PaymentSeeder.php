<?php

namespace Database\Seeders;

use App\Models\Customer;
use App\Models\Payment;
use App\Models\Purchase;
use App\Models\Sale;
use App\Models\Supplier;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Database\Seeder;

class PaymentSeeder extends Seeder
{
    /**
     * Seed payment transactions for purchases and sales
     */
    public function run(): void
    {
        $adminUser = User::where('email', 'admin@mail.com')->first() ?? User::first();
        
        if (!$adminUser) {
            $this->command->error('No admin user found. Please run AdminUserSeeder first.');
            return;
        }

        $this->command->info('Seeding payment transactions...');

        // Get the highest payment number to continue from
        $lastPayment = Payment::orderBy('id', 'desc')->first();
        $paymentCounter = $lastPayment ? (int) str_replace('PAY-', '', $lastPayment->payment_number) + 1 : 1;

        // Seed payments for purchases (supplier payments)
        $purchases = Purchase::whereIn('status', ['pending', 'partial'])
            ->where('balance_amount', '>', 0)
            ->get();

        $this->command->info("Found {$purchases->count()} purchases with pending balance");

        foreach ($purchases as $purchase) {
            if ($purchase->balance_amount <= 0) {
                continue;
            }

            // Generate unique payment number
            do {
                $paymentNumber = 'PAY-' . str_pad($paymentCounter++, 6, '0', STR_PAD_LEFT);
            } while (Payment::where('payment_number', $paymentNumber)->exists());

            // Determine payment amount (full or partial)
            $paymentAmount = $purchase->balance_amount;
            if ($purchase->status === 'partial') {
                // For partial purchases, make a partial payment
                $paymentAmount = $purchase->balance_amount * (rand(30, 80) / 100);
            }

            $paymentMethods = ['cash', 'bank_transfer', 'cheque', 'card', 'mobile_banking'];
            $paymentMethod = $paymentMethods[array_rand($paymentMethods)];

            $paymentDate = Carbon::parse($purchase->invoice_date)->addDays(rand(1, 30));

            Payment::create([
                'payment_number' => $paymentNumber,
                'payment_type' => 'purchase',
                'party_type' => 'supplier',
                'party_id' => $purchase->supplier_id,
                'reference_type' => 'Purchase',
                'reference_id' => $purchase->id,
                'reference_number' => $purchase->invoice_number,
                'payment_date' => $paymentDate,
                'amount' => round($paymentAmount, 2),
                'payment_method' => $paymentMethod,
                'transaction_reference' => $paymentMethod === 'cheque' ? 'CHQ-' . rand(100000, 999999) : ($paymentMethod === 'bank_transfer' ? 'TXN-' . rand(1000000, 9999999) : null),
                'bank_name' => in_array($paymentMethod, ['bank_transfer', 'cheque']) ? ['DBBL', 'BRAC', 'City Bank', 'Eastern Bank'][array_rand(['DBBL', 'BRAC', 'City Bank', 'Eastern Bank'])] : null,
                'account_number' => in_array($paymentMethod, ['bank_transfer', 'cheque']) ? rand(1000000000, 9999999999) : null,
                'status' => 'completed',
                'notes' => "Payment for purchase {$purchase->invoice_number}",
                'created_by' => $adminUser->id,
            ]);

            // Update purchase paid and balance amounts
            $purchase->paid_amount += $paymentAmount;
            $purchase->balance_amount -= $paymentAmount;
            $purchase->status = $purchase->balance_amount <= 0 ? 'paid' : 'partial';
            $purchase->save();

            // Update supplier balance
            $supplier = Supplier::find($purchase->supplier_id);
            if ($supplier) {
                $supplier->current_balance -= $paymentAmount;
                $supplier->save();
            }
        }

        // Seed payments for sales (customer payments)
        $sales = Sale::whereIn('status', ['pending', 'partial'])
            ->where('balance_amount', '>', 0)
            ->get();

        $this->command->info("Found {$sales->count()} sales with pending balance");

        foreach ($sales as $sale) {
            if ($sale->balance_amount <= 0) {
                continue;
            }

            // Generate unique payment number
            do {
                $paymentNumber = 'PAY-' . str_pad($paymentCounter++, 6, '0', STR_PAD_LEFT);
            } while (Payment::where('payment_number', $paymentNumber)->exists());

            // Determine payment amount (full or partial)
            $paymentAmount = $sale->balance_amount;
            if ($sale->status === 'partial') {
                // For partial sales, make a partial payment
                $paymentAmount = $sale->balance_amount * (rand(30, 80) / 100);
            }

            $paymentMethods = ['cash', 'bank_transfer', 'cheque', 'card', 'mobile_banking'];
            $paymentMethod = $paymentMethods[array_rand($paymentMethods)];

            $paymentDate = Carbon::parse($sale->invoice_date)->addDays(rand(1, 30));

            Payment::create([
                'payment_number' => $paymentNumber,
                'payment_type' => 'sale',
                'party_type' => 'customer',
                'party_id' => $sale->customer_id,
                'reference_type' => 'Sale',
                'reference_id' => $sale->id,
                'reference_number' => $sale->invoice_number,
                'payment_date' => $paymentDate,
                'amount' => round($paymentAmount, 2),
                'payment_method' => $paymentMethod,
                'transaction_reference' => $paymentMethod === 'cheque' ? 'CHQ-' . rand(100000, 999999) : ($paymentMethod === 'bank_transfer' ? 'TXN-' . rand(1000000, 9999999) : null),
                'bank_name' => in_array($paymentMethod, ['bank_transfer', 'cheque']) ? ['DBBL', 'BRAC', 'City Bank', 'Eastern Bank'][array_rand(['DBBL', 'BRAC', 'City Bank', 'Eastern Bank'])] : null,
                'account_number' => in_array($paymentMethod, ['bank_transfer', 'cheque']) ? rand(1000000000, 9999999999) : null,
                'status' => 'completed',
                'notes' => "Payment for sale {$sale->invoice_number}",
                'created_by' => $adminUser->id,
            ]);

            // Update sale paid and balance amounts
            $sale->paid_amount += $paymentAmount;
            $sale->balance_amount -= $paymentAmount;
            $sale->status = $sale->balance_amount <= 0 ? 'paid' : 'partial';
            $sale->save();

            // Update customer balance
            $customer = Customer::find($sale->customer_id);
            if ($customer) {
                $customer->current_balance -= $paymentAmount;
                $customer->save();
            }
        }

        // Create some standalone payments (not linked to specific invoices)
        $this->command->info('Creating standalone payment entries...');

        $suppliers = Supplier::where('current_balance', '>', 0)->get();
        $customers = Customer::where('current_balance', '>', 0)->get();

        // Supplier payments
        foreach ($suppliers->take(5) as $supplier) {
            if ($supplier->current_balance <= 0) {
                continue;
            }

            do {
                $paymentNumber = 'PAY-' . str_pad($paymentCounter++, 6, '0', STR_PAD_LEFT);
            } while (Payment::where('payment_number', $paymentNumber)->exists());

            $paymentAmount = min($supplier->current_balance, rand(5000, 20000));
            $paymentMethod = ['cash', 'bank_transfer', 'cheque'][array_rand(['cash', 'bank_transfer', 'cheque'])];

            Payment::create([
                'payment_number' => $paymentNumber,
                'payment_type' => 'purchase',
                'party_type' => 'supplier',
                'party_id' => $supplier->id,
                'reference_type' => null,
                'reference_id' => null,
                'reference_number' => null,
                'payment_date' => Carbon::now()->subDays(rand(1, 60)),
                'amount' => round($paymentAmount, 2),
                'payment_method' => $paymentMethod,
                'transaction_reference' => $paymentMethod === 'cheque' ? 'CHQ-' . rand(100000, 999999) : null,
                'bank_name' => $paymentMethod === 'bank_transfer' ? 'DBBL' : null,
                'account_number' => null,
                'status' => 'completed',
                'notes' => "Advance payment to supplier",
                'created_by' => $adminUser->id,
            ]);

            $supplier->current_balance -= $paymentAmount;
            $supplier->save();
        }

        // Customer payments
        foreach ($customers->take(5) as $customer) {
            if ($customer->current_balance <= 0) {
                continue;
            }

            do {
                $paymentNumber = 'PAY-' . str_pad($paymentCounter++, 6, '0', STR_PAD_LEFT);
            } while (Payment::where('payment_number', $paymentNumber)->exists());

            $paymentAmount = min($customer->current_balance, rand(3000, 15000));
            $paymentMethod = ['cash', 'bank_transfer', 'cheque'][array_rand(['cash', 'bank_transfer', 'cheque'])];

            Payment::create([
                'payment_number' => $paymentNumber,
                'payment_type' => 'sale',
                'party_type' => 'customer',
                'party_id' => $customer->id,
                'reference_type' => null,
                'reference_id' => null,
                'reference_number' => null,
                'payment_date' => Carbon::now()->subDays(rand(1, 60)),
                'amount' => round($paymentAmount, 2),
                'payment_method' => $paymentMethod,
                'transaction_reference' => $paymentMethod === 'cheque' ? 'CHQ-' . rand(100000, 999999) : null,
                'bank_name' => $paymentMethod === 'bank_transfer' ? 'DBBL' : null,
                'account_number' => null,
                'status' => 'completed',
                'notes' => "Payment received from customer",
                'created_by' => $adminUser->id,
            ]);

            $customer->current_balance -= $paymentAmount;
            $customer->save();
        }

        $this->command->info('Payment transactions seeded successfully!');
    }
}

