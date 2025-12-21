<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Stock Report</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'DejaVu Sans', sans-serif;
            font-size: 12px;
            color: #333;
            line-height: 1.5;
        }
        
        .header {
            text-align: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #1976d2;
        }
        
        .header h1 {
            color: #1976d2;
            font-size: 24px;
            margin-bottom: 5px;
        }
        
        .summary-section {
            margin-bottom: 20px;
            display: table;
            width: 100%;
        }
        
        .summary-box {
            display: table-cell;
            width: 25%;
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
            background-color: #f5f5f5;
        }
        
        .summary-box .label {
            font-size: 10px;
            color: #666;
            margin-bottom: 5px;
        }
        
        .summary-box .value {
            font-size: 14px;
            font-weight: bold;
            color: #1976d2;
        }
        
        .filters-section {
            margin-bottom: 15px;
            font-size: 10px;
            color: #666;
        }
        
        .filters-section span {
            margin-right: 15px;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        
        thead {
            background-color: #1976d2;
            color: white;
        }
        
        th {
            padding: 8px;
            text-align: left;
            font-weight: bold;
            font-size: 11px;
        }
        
        th.text-right {
            text-align: right;
        }
        
        td {
            padding: 6px 8px;
            border-bottom: 1px solid #ddd;
            font-size: 11px;
        }
        
        td.text-right {
            text-align: right;
        }
        
        .status-badge {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 3px;
            font-size: 10px;
            font-weight: bold;
            text-transform: uppercase;
        }
        
        .status-out { background-color: #f44336; color: white; }
        .status-low { background-color: #ff9800; color: white; }
        .status-ok { background-color: #4caf50; color: white; }
        
        .footer {
            margin-top: 30px;
            padding-top: 15px;
            border-top: 1px solid #ddd;
            text-align: center;
            font-size: 10px;
            color: #666;
        }
        
        .no-data {
            text-align: center;
            padding: 40px;
            color: #999;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Stock Report</h1>
    </div>

    @if($summary)
    <div class="summary-section">
        <div class="summary-box">
            <div class="label">Total Products</div>
            <div class="value">{{ number_format($summary['total_products']) }}</div>
        </div>
        <div class="summary-box">
            <div class="label">Total Stock Value</div>
            <div class="value">Tk {{ number_format($summary['total_stock_value'], 2) }}</div>
        </div>
        <div class="summary-box">
            <div class="label">Low Stock Items</div>
            <div class="value">{{ number_format($summary['low_stock_count']) }}</div>
        </div>
        <div class="summary-box">
            <div class="label">Out of Stock</div>
            <div class="value">{{ number_format($summary['out_of_stock_count']) }}</div>
        </div>
    </div>
    @endif

    @if($filters['warehouse_id'] || $filters['category_id'] || $filters['low_stock_only'])
    <div class="filters-section">
        <strong>Filters Applied:</strong>
        @if($filters['warehouse_id'])
            <span>Warehouse: {{ $warehouseName ?? 'Selected Warehouse' }}</span>
        @endif
        @if($filters['category_id'])
            <span>Category: {{ $categoryName ?? 'Selected Category' }}</span>
        @endif
        @if($filters['low_stock_only'])
            <span>Low Stock Only: Yes</span>
        @endif
    </div>
    @endif

    @if(count($stock) > 0)
    <table>
        <thead>
            <tr>
                <th>Product</th>
                <th>SKU</th>
                <th>Category</th>
                <th>Warehouse</th>
                <th class="text-right">Quantity</th>
                <th class="text-right">Min Level</th>
                <th class="text-right">Stock Value</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            @foreach($stock as $item)
            @php
                $status = 'ok';
                if ($item->quantity == 0) {
                    $status = 'out';
                } elseif ($item->quantity <= $item->minimum_stock_level) {
                    $status = 'low';
                }
            @endphp
            <tr>
                <td>{{ $item->product_name ?? 'N/A' }}</td>
                <td>{{ $item->sku ?? 'N/A' }}</td>
                <td>{{ $item->category_name ?? 'N/A' }}</td>
                <td>{{ $item->warehouse_name ?? 'N/A' }}</td>
                <td class="text-right">{{ number_format($item->quantity) }}</td>
                <td class="text-right">{{ number_format($item->minimum_stock_level) }}</td>
                <td class="text-right">Tk {{ number_format($item->quantity * $item->purchase_price, 2) }}</td>
                <td>
                    <span class="status-badge status-{{ $status }}">
                        @if($status == 'out')
                            Out of Stock
                        @elseif($status == 'low')
                            Low Stock
                        @else
                            OK
                        @endif
                    </span>
                </td>
            </tr>
            @endforeach
        </tbody>
    </table>
    @else
    <div class="no-data">
        No stock data found for the selected criteria.
    </div>
    @endif

    <div class="footer">
        Generated on {{ date('d M Y, h:i A') }} | Page 1
    </div>
</body>
</html>

