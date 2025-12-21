<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    <title>Sales Report</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'DejaVu Sans', sans-serif;
            font-size: 9px;
            color: #333;
            line-height: 1.3;
        }

        .header {
            text-align: center;
            margin-bottom: 8px;
            padding-bottom: 6px;
            border-bottom: 1.5px solid #1976d2;
        }

        .header h1 {
            color: #1976d2;
            font-size: 16px;
            margin-bottom: 2px;
            font-weight: bold;
        }

        .header .date-range {
            color: #666;
            font-size: 8px;
        }

        .summary-section {
            margin-bottom: 8px;
            display: table;
            width: 100%;
        }

        .summary-box {
            display: table-cell;
            width: 25%;
            padding: 4px 6px;
            text-align: center;
            border: 1px solid #ddd;
            background-color: #f5f5f5;
        }

        .summary-box .label {
            font-size: 7px;
            color: #666;
            margin-bottom: 2px;
        }

        .summary-box .value {
            font-size: 10px;
            font-weight: bold;
            color: #1976d2;
        }

        .filters-section {
            margin-bottom: 6px;
            font-size: 7px;
            color: #666;
        }

        .filters-section span {
            margin-right: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 8px;
            font-size: 8px;
        }

        thead {
            background-color: #1976d2;
            color: white;
        }

        th {
            padding: 4px 5px;
            text-align: left;
            font-weight: bold;
            font-size: 8px;
        }

        th.text-right {
            text-align: right;
        }

        td {
            padding: 3px 5px;
            border-bottom: 1px solid #ddd;
            font-size: 8px;
        }

        td.text-right {
            text-align: right;
        }

        .status-badge {
            display: inline-block;
            padding: 1px 5px;
            border-radius: 2px;
            font-size: 7px;
            font-weight: bold;
            text-transform: uppercase;
        }

        .status-draft {
            background-color: #9e9e9e;
            color: white;
        }

        .status-pending {
            background-color: #ff9800;
            color: white;
        }

        .status-partial {
            background-color: #2196f3;
            color: white;
        }

        .status-paid {
            background-color: #4caf50;
            color: white;
        }

        .status-cancelled {
            background-color: #f44336;
            color: white;
        }

        .footer {
            margin-top: 10px;
            padding-top: 6px;
            border-top: 1px solid #ddd;
            text-align: center;
            font-size: 7px;
            color: #666;
        }

        .top-products {
            margin-top: 10px;
            page-break-inside: avoid;
        }

        .top-products h3 {
            color: #1976d2;
            font-size: 11px;
            margin-bottom: 4px;
            font-weight: bold;
        }

        .no-data {
            text-align: center;
            padding: 20px;
            color: #999;
            font-style: italic;
            font-size: 9px;
        }
    </style>
</head>

<body>
    <div class="header">
        <h1>Sales Report</h1>
        <div class="date-range">
            @if ($filters['date_from'] || $filters['date_to'])
                Period: {{ $filters['date_from'] ? date('d M Y', strtotime($filters['date_from'])) : 'N/A' }} to
                {{ $filters['date_to'] ? date('d M Y', strtotime($filters['date_to'])) : 'N/A' }}
            @else
                All Time
            @endif
        </div>
    </div>

    @if ($summary)
        <div class="summary-section">
            <div class="summary-box">
                <div class="label">Total Sales</div>
                <div class="value">Tk {{ number_format($summary['total_sales'], 2) }}</div>
            </div>
            <div class="summary-box">
                <div class="label">Total Paid</div>
                <div class="value">Tk {{ number_format($summary['total_paid'], 2) }}</div>
            </div>
            <div class="summary-box">
                <div class="label">Total Due</div>
                <div class="value">Tk {{ number_format($summary['total_due'], 2) }}</div>
            </div>
            <div class="summary-box">
                <div class="label">Total Invoices</div>
                <div class="value">{{ number_format($summary['total_count']) }}</div>
            </div>
        </div>
    @endif

    @if ($filters['customer_id'] || $filters['status'])
        <div class="filters-section">
            <strong>Filters:</strong>
            @if ($filters['customer_id'])
                <span>Customer: {{ $customerName ?? 'Selected' }}</span>
            @endif
            @if ($filters['status'])
                <span>Status: {{ ucfirst($filters['status']) }}</span>
            @endif
        </div>
    @endif

    @if (count($sales) > 0)
        <table>
            <thead>
                <tr>
                    <th>Invoice #</th>
                    <th>Date</th>
                    <th>Customer</th>
                    <th class="text-right">Total</th>
                    <th class="text-right">Paid</th>
                    <th class="text-right">Due</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($sales as $sale)
                    <tr>
                        <td>{{ $sale->invoice_number }}</td>
                        <td>{{ date('d M Y', strtotime($sale->invoice_date)) }}</td>
                        <td>{{ $sale->customer_name ?? 'N/A' }}</td>
                        <td class="text-right">Tk {{ number_format($sale->total_amount, 2) }}</td>
                        <td class="text-right">Tk {{ number_format($sale->paid_amount, 2) }}</td>
                        <td class="text-right">
                            @if ($sale->balance_amount > 0)
                                <span style="color: #f44336;">Tk {{ number_format($sale->balance_amount, 2) }}</span>
                            @else
                                <span style="color: #4caf50;">Tk {{ number_format($sale->balance_amount, 2) }}</span>
                            @endif
                        </td>
                        <td><span
                                class="status-badge status-{{ strtolower($sale->status) }}">{{ ucfirst($sale->status) }}</span>
                        </td>
                    </tr>
                @endforeach
            </tbody>
        </table>
    @else
        <div class="no-data">No sales data found for the selected criteria.</div>
    @endif

    @if (isset($topProducts) && count($topProducts) > 0)
        <div class="top-products">
            <h3>Top Selling Products</h3>
            <table>
                <thead>
                    <tr>
                        <th>Product</th>
                        <th class="text-right">Qty Sold</th>
                        <th class="text-right">Revenue</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($topProducts as $product)
                        <tr>
                            <td>{{ $product->product_name }}</td>
                            <td class="text-right">{{ number_format($product->total_quantity) }}</td>
                            <td class="text-right">Tk {{ number_format($product->total_revenue, 2) }}</td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    @endif

    <div class="footer">Generated on {{ date('d M Y, h:i A') }}</div>
</body>

</html>
