<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Due Report</title>
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
            width: 33.33%;
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
        
        .overdue {
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
        <h1>Due Report - {{ ucfirst($partyType) }}s</h1>
    </div>

    @if($summary)
    <div class="summary-section">
        <div class="summary-box">
            <div class="label">Total Due</div>
            <div class="value">Tk {{ number_format($summary['total_due'], 2) }}</div>
        </div>
        <div class="summary-box">
            <div class="label">Overdue Amount</div>
            <div class="value">Tk {{ number_format($summary['overdue_amount'], 2) }}</div>
        </div>
        <div class="summary-box">
            <div class="label">Total Parties</div>
            <div class="value">{{ number_format($summary['total_parties']) }}</div>
        </div>
    </div>
    @endif

    @if($filters['party_id'] || $filters['overdue_only'])
    <div class="filters-section">
        <strong>Filters Applied:</strong>
        @if($filters['party_id'])
            <span>{{ ucfirst($partyType) }}: {{ $partyName ?? 'Selected ' . ucfirst($partyType) }}</span>
        @endif
        @if($filters['overdue_only'])
            <span>Overdue Only: Yes</span>
        @endif
    </div>
    @endif

    @if(count($due) > 0)
    <table>
        <thead>
            <tr>
                <th>{{ ucfirst($partyType) }}</th>
                <th>Invoice #</th>
                <th>Invoice Date</th>
                <th>Due Date</th>
                <th class="text-right">Total</th>
                <th class="text-right">Paid</th>
                <th class="text-right">Due</th>
            </tr>
        </thead>
        <tbody>
            @foreach($due as $item)
            @php
                $isOverdue = $item->due_date && strtotime($item->due_date) < time();
            @endphp
            <tr>
                <td>{{ $item->party_name ?? 'N/A' }}</td>
                <td>{{ $item->invoice_number }}</td>
                <td>{{ date('d M Y', strtotime($item->invoice_date)) }}</td>
                <td class="{{ $isOverdue ? 'overdue' : '' }}">
                    {{ $item->due_date ? date('d M Y', strtotime($item->due_date)) : 'N/A' }}
                </td>
                <td class="text-right">Tk {{ number_format($item->total_amount, 2) }}</td>
                <td class="text-right">Tk {{ number_format($item->paid_amount, 2) }}</td>
                <td class="text-right overdue">Tk {{ number_format($item->due_amount, 2) }}</td>
            </tr>
            @endforeach
        </tbody>
    </table>
    @else
    <div class="no-data">
        No due records found for the selected criteria.
    </div>
    @endif

    <div class="footer">
        Generated on {{ date('d M Y, h:i A') }} | Page 1
    </div>
</body>
</html>

