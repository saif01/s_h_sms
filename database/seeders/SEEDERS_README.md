# Database Seeders Documentation

This document provides an overview of all database migrations and their corresponding seeders.

## Migration to Seeder Mapping

### Core System Tables
- **users** → `AdminUserSeeder` - Creates admin, cashier, and storekeeper users
- **password_reset_tokens** → No seeder (system table)
- **sessions** → No seeder (system table)
- **personal_access_tokens** → No seeder (system table)

### Settings & Configuration
- **settings** → `DemoDataSeeder` - Seeds site name, logo, footer settings

### Authentication & Authorization
- **permissions** → `RolePermissionSeeder` - Creates all system permissions
- **roles** → `RolePermissionSeeder` - Creates administrator, cashier, storekeeper roles
- **role_permission** → `RolePermissionSeeder` - Links permissions to roles
- **user_role** → `AdminUserSeeder` - Assigns roles to users
- **login_logs** → `LoginLogSeeder` - Creates login history entries (successful and failed attempts)

### Master Data
- **units** → `CurrentProjectSeeder` - Creates PCS, KG, LTR units
- **categories** → `CurrentProjectSeeder`, `ProductSaleSeeder` - Creates grocery, cosmetics, electronics categories
- **warehouses** → `CurrentProjectSeeder` - Creates main warehouse
- **suppliers** → `CurrentProjectSeeder` - Creates 3 sample suppliers
- **customers** → `CurrentProjectSeeder`, `ProductSaleSeeder` - Creates walk-in customer and regular customers

### Products & Inventory
- **products** → `CurrentProjectSeeder`, `ProductSaleSeeder` - Creates sample products
- **stocks** → `CurrentProjectSeeder` - Initial stock levels
- **stock_ledgers** → `StockLedgerSeeder` - Complete stock movement history (purchases, sales, adjustments)

### Transactions
- **purchases** → `PurchaseSeeder` - Creates 50 purchase transactions
- **purchase_items** → `PurchaseSeeder` - Purchase line items
- **sales** → `CurrentProjectSeeder`, `ProductSaleSeeder` - Creates sales transactions
- **sales_items** → `CurrentProjectSeeder`, `ProductSaleSeeder` - Sales line items
- **payments** → `PaymentSeeder` - Payment records for purchases and sales

## Seeder Execution Order

The seeders are executed in the following order (defined in `DatabaseSeeder.php`):

1. **RolePermissionSeeder** - Sets up roles and permissions
2. **AdminUserSeeder** - Creates users and assigns roles
3. **DemoDataSeeder** - Basic system settings
4. **CurrentProjectSeeder** - Base master data (units, categories, warehouses, suppliers, customers, initial products, stocks, one sample sale)
5. **PurchaseSeeder** - Purchase transactions and stock updates
6. **ProductSaleSeeder** - Additional products and 100 sales transactions
7. **StockLedgerSeeder** - Stock movement history from purchases and sales
8. **PaymentSeeder** - Payment records for outstanding invoices
9. **LoginLogSeeder** - Login history entries

## Running Seeders

### Run all seeders:
```bash
php artisan db:seed
```

### Run specific seeder:
```bash
php artisan db:seed --class=PurchaseSeeder
```

### Fresh migration with seeding:
```bash
php artisan migrate:fresh --seed
```

## Notes

- Some seeders depend on data created by previous seeders. Always run them in the order specified in `DatabaseSeeder`.
- `PurchaseSeeder` automatically updates stock levels and supplier balances.
- `StockLedgerSeeder` creates ledger entries based on existing purchases and sales.
- `PaymentSeeder` processes outstanding balances and updates customer/supplier balances.
- System tables (password_reset_tokens, sessions, personal_access_tokens) are managed by Laravel and don't require seeders.

