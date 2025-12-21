<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profit Report</title>
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
        
        .header .date-range {
            color: #666;
            font-size: 11px;
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
        
        .profit-positive {
            color: #4caf50;
            font-weight: bold;
        }
        
        .profit-negative {
            color: #f44336;
            font-weight: bold;
        }
        
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
        <h1>Profit Report</h1>
        <div class="date-range">
            @if($filters['date_from'] || $filters['date_to'])
                Period: 
                {{ $filters['date_from'] ? date('d M Y', strtotime($filters['date_from'])) : 'N/A' }} 
                to 
                {{ $filters['date_to'] ? date('d M Y', strtotime($filters['date_to'])) : 'N/A' }}
            @else
                All Time
            @endif
            | Grouped by: {{ ucfirst($groupBy) }}
        </div>
    </div>

    @if($summary)
    <div class="summary-section">
        <div class="summary-box">
            <div class="label">Total Revenue</div>
            <div class="value">Tk {{ number_format($summary['total_revenue'], 2) }}</div>
        </div>
        <div class="summary-box">
            <div class="label">Total Cost</div>
            <div class="value">Tk {{ number_format($summary['total_cost'], 2) }}</div>
        </div>
        <div class="summary-box">
            <div class="label">Gross Profit</div>
            <div class="value {{ $summary['gross_profit'] >= 0 ? 'profit-positive' : 'profit-negative' }}">
                Tk {{ number_format($summary['gross_profit'], 2) }}
            </div>
        </div>
        <div class="summary-box">
            <div class="label">Profit Margin</div>
            <div class="value">{{ number_format($summary['profit_margin'], 2) }}%</div>
        </div>
    </div>
    @endif

    @if($filters['category_id'])
    <div class="filters-section">
        <strong>Filters Applied:</strong>
        <span>Category: {{ $categoryName ?? 'Selected Category' }}</span>
    </div>
    @endif

    @if(count($profit) > 0)
    <table>
        <thead>
            <tr>
                @if($groupBy === 'product' || $groupBy === 'category')
                    <th>Name</th>
                @else
                    <th>Period</th>
                @endif
                <th class="text-right">Qty Sold</th>
                <th class="text-right">Revenue</th>
                <th class="text-right">Cost</th>
                <th class="text-right">Discount</th>
                <th class="text-right">Profit</th>
                <th class="text-right">Margin %</th>
            </tr>
        </thead>
        <tbody>
            @foreach($profit as $item)
            <tr>
                @if($groupBy === 'product' || $groupBy === 'category')
                    <td>{{ $item['name'] }}</td>
                @else
                    <td>{{ $item['period'] }}</td>
                @endif
                <td class="text-right">{{ number_format($item['quantity_sold']) }}</td>
                <td class="text-right">Tk {{ number_format($item['revenue'], 2) }}</td>
                <td class="text-right">Tk {{ number_format($item['cost'], 2) }}</td>
                <td class="text-right">Tk {{ number_format($item['discount'], 2) }}</td>
                <td class="text-right {{ $item['profit'] >= 0 ? 'profit-positive' : 'profit-negative' }}">
                    Tk {{ number_format($item['profit'], 2) }}
                </td>
                <td class="text-right">{{ number_format($item['profit_margin'], 2) }}%</td>
            </tr>
            @endforeach
        </tbody>
    </table>
    @else
    <div class="no-data">
        No profit data found for the selected criteria.
    </div>
    @endif

    <div class="footer">
        Generated on {{ date('d M Y, h:i A') }} | Page 1
    </div>
</body>
</html>

