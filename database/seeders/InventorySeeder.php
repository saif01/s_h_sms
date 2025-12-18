<?php

namespace Database\Seeders;

use App\Models\Category;
use App\Models\Customer;
use App\Models\Product;
use App\Models\Sale;
use App\Models\SalesItem;
use App\Models\Stock;
use App\Models\Supplier;
use App\Models\Unit;
use App\Models\Warehouse;
use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class InventorySeeder extends Seeder
{
    /**
     * Seed a minimal shop setup: units, categories, warehouse, sample products, stock, suppliers/customers, one sale.
     */
    public function run(): void
    {
        // Units
        $units = [
            ['name' => 'Piece', 'code' => 'PCS'],
            ['name' => 'Kilogram', 'code' => 'KG'],
            ['name' => 'Liter', 'code' => 'LTR'],
        ];
        foreach ($units as $unit) {
            Unit::updateOrCreate(['code' => $unit['code']], $unit);
        }

        // Categories
        $categories = [
            ['name' => 'Grocery', 'slug' => 'grocery', 'order' => 1],
            ['name' => 'Cosmetics', 'slug' => 'cosmetics', 'order' => 2],
            ['name' => 'Electronics', 'slug' => 'electronics', 'order' => 3],
        ];
        foreach ($categories as $category) {
            Category::updateOrCreate(['slug' => $category['slug']], $category);
        }

        // Warehouse
        $warehouse = Warehouse::firstOrCreate(
            ['code' => 'WH-001'],
            ['name' => 'Main Warehouse', 'address' => 'Default Location']
        );

        // Suppliers
        $supplier = Supplier::firstOrCreate([
            'phone' => '01700000000',
        ], [
            'name' => 'Default Supplier',
            'address' => 'Dhaka',
            'email' => 'supplier@example.com',
        ]);

        // Customers
        $customer = Customer::firstOrCreate([
            'phone' => '01800000000',
        ], [
            'name' => 'Walk-in Customer',
            'address' => 'N/A',
        ]);

        // Products + stock
        $products = [
            [
                'name' => 'Rice 1kg',
                'sku' => 'RICE-1KG',
                'barcode' => '1000001',
                'category_id' => Category::where('slug', 'grocery')->first()->id ?? null,
                'unit_id' => Unit::where('code', 'KG')->first()->id ?? null,
                'purchase_price' => 45,
                'sale_price' => 55,
                'minimum_stock_level' => 5,
            ],
            [
                'name' => 'Shampoo 200ml',
                'sku' => 'SHP-200',
                'barcode' => '1000002',
                'category_id' => Category::where('slug', 'cosmetics')->first()->id ?? null,
                'unit_id' => Unit::where('code', 'LTR')->first()->id ?? null,
                'purchase_price' => 120,
                'sale_price' => 150,
                'minimum_stock_level' => 3,
            ],
        ];

        foreach ($products as $data) {
            $product = Product::updateOrCreate(
                ['sku' => $data['sku']],
                array_merge($data, ['is_active' => true])
            );

            Stock::updateOrCreate(
                ['product_id' => $product->id, 'warehouse_id' => $warehouse->id],
                ['quantity' => 20, 'average_cost' => $product->purchase_price, 'total_value' => 20 * $product->purchase_price]
            );
        }

        // Sample sale with due tracking
        $product = Product::where('sku', 'RICE-1KG')->first();
        if ($product) {
            $sale = Sale::firstOrCreate(
                ['invoice_number' => 'INV-0001'],
                [
                    'customer_id' => $customer->id,
                    'warehouse_id' => $warehouse->id,
                    'invoice_date' => Carbon::today(),
                    'status' => 'paid',
                    'subtotal' => $product->sale_price * 2,
                    'tax_amount' => 0,
                    'discount_amount' => 0,
                    'shipping_cost' => 0,
                    'total_amount' => $product->sale_price * 2,
                    'paid_amount' => $product->sale_price * 2,
                    'balance_amount' => 0,
                    'created_by' => 1,
                ]
            );

            SalesItem::firstOrCreate(
                ['sale_id' => $sale->id, 'product_id' => $product->id],
                [
                    'quantity' => 2,
                    'unit_price' => $product->sale_price,
                    'discount' => 0,
                    'tax' => 0,
                    'total' => $product->sale_price * 2,
                ]
            );
        }
    }
}

