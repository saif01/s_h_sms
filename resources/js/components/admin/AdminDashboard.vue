<template>
    <div>
        <!-- Page Header -->
        <div class="page-header mb-6 d-flex align-center justify-space-between">
            <div>
                <h1 class="text-h4 page-title mb-1">Dashboard</h1>
                <p class="text-body-2 text-grey">Welcome back! Here's what's happening with your business today.</p>
            </div>
            <v-btn icon="mdi-refresh" @click="loadDashboard" :loading="loading" variant="text" size="large" />
        </div>

        <!-- KPI Cards Row 1 - Primary Metrics -->
        <v-row class="mb-4" dense>
            <v-col cols="12" sm="6" md="3" v-for="card in primaryCards" :key="card.title">
                <v-card class="kpi-card" :class="card.color" elevation="2">
                    <v-card-text class="pa-4">
                        <div class="d-flex align-center justify-space-between mb-2">
                            <div class="kpi-icon" :class="card.iconColor">
                                <v-icon :icon="card.icon" size="32" />
                            </div>
                            <v-chip v-if="card.trend !== null" :color="card.trend >= 0 ? 'success' : 'error'"
                                size="small" variant="flat">
                                <v-icon start size="14">{{ card.trend >= 0 ? 'mdi-arrow-up' : 'mdi-arrow-down'
                                    }}</v-icon>
                                {{ Math.abs(card.trend).toFixed(1) }}%
                            </v-chip>
                        </div>
                        <div class="text-caption text-grey-darken-1 mb-1">{{ card.title }}</div>
                        <div class="text-h5 font-weight-bold">{{ card.value }}</div>
                        <div v-if="card.subtitle" class="text-caption text-grey mt-1">{{ card.subtitle }}</div>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>

        <!-- KPI Cards Row 2 - Secondary Metrics -->
        <v-row class="mb-4" dense>
            <v-col cols="12" sm="6" md="3" v-for="card in secondaryCards" :key="card.title">
                <v-card class="kpi-card" elevation="1" variant="outlined">
                    <v-card-text class="pa-3">
                        <div class="d-flex align-center mb-2">
                            <v-icon :icon="card.icon" :color="card.color" size="24" class="mr-2" />
                            <div class="text-caption text-grey-darken-1">{{ card.title }}</div>
                        </div>
                        <div class="text-h6 font-weight-bold">{{ card.value }}</div>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>

        <!-- AI Powered Analysis -->
        <v-row class="mb-4" dense>
            <v-col cols="12">
                <v-card elevation="2" class="ai-insights-card">
                    <v-card-title class="d-flex align-center">
                        <v-icon icon="mdi-brain" color="primary" class="mr-2" size="28" />
                        <span class="text-h6">AI-Powered Business Insights</span>
                        <v-spacer />
                        <v-chip size="small" color="primary" variant="flat" class="ml-2">
                            <v-icon start size="16">mdi-sparkles</v-icon>
                            Smart Analysis
                        </v-chip>
                    </v-card-title>
                    <v-divider />
                    <v-card-text class="pa-4">
                        <div v-if="loading" class="text-center py-8">
                            <v-progress-circular indeterminate color="primary" />
                            <div class="text-caption text-grey mt-2">Analyzing your business data...</div>
                        </div>
                        <div v-else>
                            <!-- Insights Grid -->
                            <v-row dense>
                                <!-- Sales Forecast -->
                                <v-col cols="12" md="4" v-if="aiInsights.salesForecast">
                                    <v-card variant="outlined" class="insight-card">
                                        <v-card-text class="pa-3">
                                            <div class="d-flex align-center mb-2">
                                                <v-icon icon="mdi-trending-up" color="info" class="mr-2" />
                                                <span class="text-subtitle-2 font-weight-bold">Sales Forecast</span>
                                            </div>
                                            <div class="text-body-2 text-grey mb-2">{{ aiInsights.salesForecast.message
                                                }}</div>
                                            <div class="text-h6 font-weight-bold text-info">
                                                {{ formatCurrency(aiInsights.salesForecast.predicted) }}
                                            </div>
                                            <div class="text-caption text-grey mt-1">
                                                Expected {{ aiInsights.salesForecast.period }}
                                            </div>
                                        </v-card-text>
                                    </v-card>
                                </v-col>

                                <!-- Anomaly Detection -->
                                <v-col cols="12" md="4" v-if="aiInsights.anomalies && aiInsights.anomalies.length > 0">
                                    <v-card :color="aiInsights.anomalies[0].severity === 'high' ? 'error' : 'warning'"
                                        variant="tonal">
                                        <v-card-text class="pa-3">
                                            <div class="d-flex align-center mb-2">
                                                <v-icon icon="mdi-alert-circle"
                                                    :color="aiInsights.anomalies[0].severity === 'high' ? 'error' : 'warning'"
                                                    class="mr-2" />
                                                <span class="text-subtitle-2 font-weight-bold">Anomaly Detected</span>
                                            </div>
                                            <div class="text-body-2 mb-2">{{ aiInsights.anomalies[0].message }}</div>
                                            <v-chip size="x-small"
                                                :color="aiInsights.anomalies[0].severity === 'high' ? 'error' : 'warning'"
                                                variant="flat">
                                                {{ aiInsights.anomalies[0].severity.toUpperCase() }} PRIORITY
                                            </v-chip>
                                        </v-card-text>
                                    </v-card>
                                </v-col>

                                <!-- Performance Score -->
                                <v-col cols="12" md="4" v-if="aiInsights.performanceScore">
                                    <v-card variant="outlined" class="insight-card">
                                        <v-card-text class="pa-3">
                                            <div class="d-flex align-center mb-2">
                                                <v-icon icon="mdi-chart-box" color="success" class="mr-2" />
                                                <span class="text-subtitle-2 font-weight-bold">Performance Score</span>
                                            </div>
                                            <div class="d-flex align-center">
                                                <v-progress-circular :model-value="aiInsights.performanceScore.score"
                                                    :color="getPerformanceColor(aiInsights.performanceScore.score)"
                                                    size="60" width="6" class="mr-3">
                                                    <span class="text-h6 font-weight-bold">{{
                                                        aiInsights.performanceScore.score
                                                        }}</span>
                                                </v-progress-circular>
                                                <div>
                                                    <div class="text-body-2">{{ aiInsights.performanceScore.label }}
                                                    </div>
                                                    <div class="text-caption text-grey">{{
                                                        aiInsights.performanceScore.description }}</div>
                                                </div>
                                            </div>
                                        </v-card-text>
                                    </v-card>
                                </v-col>
                            </v-row>

                            <!-- Recommendations -->
                            <v-row class="mt-2" dense
                                v-if="aiInsights.recommendations && aiInsights.recommendations.length > 0">
                                <v-col cols="12">
                                    <div class="text-subtitle-2 font-weight-bold mb-2">
                                        <v-icon icon="mdi-lightbulb-on" color="warning" size="20" class="mr-1" />
                                        Recommendations
                                    </div>
                                    <v-list density="compact" variant="outlined" rounded>
                                        <v-list-item v-for="(rec, index) in aiInsights.recommendations" :key="index"
                                            class="px-3">
                                            <template v-slot:prepend>
                                                <v-avatar :color="getRecommendationColor(rec.priority)" size="32"
                                                    class="mr-3">
                                                    <v-icon :icon="getRecommendationIcon(rec.priority)" size="18"
                                                        color="white" />
                                                </v-avatar>
                                            </template>
                                            <v-list-item-title class="text-body-2">{{ rec.title }}</v-list-item-title>
                                            <v-list-item-subtitle class="text-caption">{{ rec.description
                                                }}</v-list-item-subtitle>
                                            <template v-slot:append>
                                                <v-chip size="x-small" :color="getRecommendationColor(rec.priority)"
                                                    variant="flat">
                                                    {{ rec.priority }}
                                                </v-chip>
                                            </template>
                                        </v-list-item>
                                    </v-list>
                                </v-col>
                            </v-row>

                            <!-- Trend Insights -->
                            <v-row class="mt-2" dense
                                v-if="aiInsights.trendInsights && aiInsights.trendInsights.length > 0">
                                <v-col cols="12">
                                    <div class="text-subtitle-2 font-weight-bold mb-2">
                                        <v-icon icon="mdi-chart-timeline-variant" color="info" size="20" class="mr-1" />
                                        Trend Insights
                                    </div>
                                    <v-chip-group>
                                        <v-chip v-for="(insight, index) in aiInsights.trendInsights" :key="index"
                                            :color="insight.type === 'positive' ? 'success' : insight.type === 'negative' ? 'error' : 'info'"
                                            variant="flat" size="small" class="mr-2 mb-2">
                                            <v-icon start
                                                :icon="insight.type === 'positive' ? 'mdi-arrow-up' : insight.type === 'negative' ? 'mdi-arrow-down' : 'mdi-information'"
                                                size="16" />
                                            {{ insight.message }}
                                        </v-chip>
                                    </v-chip-group>
                                </v-col>
                            </v-row>
                        </div>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>

        <!-- Charts Row -->
        <v-row class="mb-4" dense>
            <!-- Sales Trend Chart -->
            <v-col cols="12" md="8">
                <v-card elevation="2">
                    <v-card-title class="d-flex justify-space-between align-center">
                        <div>
                            <span class="text-h6">Sales Trend</span>
                            <v-chip-group v-model="chartPeriod" mandatory class="ml-3">
                                <v-chip filter size="small" value="7">7 Days</v-chip>
                                <v-chip filter size="small" value="30">30 Days</v-chip>
                            </v-chip-group>
                        </div>
                    </v-card-title>
                    <v-divider />
                    <v-card-text class="pa-4">
                        <div v-if="loading" class="text-center py-12">
                            <v-progress-circular indeterminate color="primary" />
                        </div>
                        <div v-else-if="chartData.labels && chartData.labels.length > 0"
                            style="position: relative; height: 300px;">
                            <Line :key="chartPeriod" :data="chartData" :options="chartOptions" />
                        </div>
                        <div v-else class="text-center py-12 text-grey">
                            <v-icon icon="mdi-chart-line" size="48" class="mb-2" />
                            <div>No sales data available for the selected period</div>
                        </div>
                    </v-card-text>
                </v-card>
            </v-col>

            <!-- Quick Stats -->
            <v-col cols="12" md="4">
                <v-card elevation="2" class="h-100">
                    <v-card-title>Quick Stats</v-card-title>
                    <v-divider />
                    <v-card-text class="pa-4">
                        <div v-for="stat in quickStats" :key="stat.label"
                            class="d-flex justify-space-between align-center mb-4">
                            <div>
                                <div class="text-caption text-grey">{{ stat.label }}</div>
                                <div class="text-h6 font-weight-bold mt-1">{{ stat.value }}</div>
                            </div>
                            <v-icon :icon="stat.icon" :color="stat.color" size="24" />
                        </div>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>

        <!-- Data Tables Row -->
        <v-row class="mb-4" dense>
            <!-- Top Products -->
            <v-col cols="12" md="6">
                <v-card elevation="2">
                    <v-card-title class="d-flex justify-space-between align-center">
                        <span>Top Products (This Month)</span>
                        <v-chip size="small" color="primary" variant="flat">Top 5</v-chip>
                    </v-card-title>
                    <v-divider />
                    <v-card-text class="pa-0">
                        <v-list v-if="topProducts.length > 0" lines="two">
                            <v-list-item v-for="(product, index) in topProducts" :key="product.id" class="px-4">
                                <template v-slot:prepend>
                                    <div class="rank-badge mr-3">{{ index + 1 }}</div>
                                </template>
                                <v-list-item-title class="font-weight-medium">{{ product.name }}</v-list-item-title>
                                <v-list-item-subtitle>
                                    <div class="d-flex justify-space-between align-center mt-1">
                                        <span>{{ product.quantity }} units sold</span>
                                        <span class="font-weight-bold text-primary">{{ formatCurrency(product.sales)
                                            }}</span>
                                    </div>
                                </v-list-item-subtitle>
                            </v-list-item>
                        </v-list>
                        <div v-else class="text-center py-8 text-grey">No data available</div>
                    </v-card-text>
                </v-card>
            </v-col>

            <!-- Top Customers -->
            <v-col cols="12" md="6">
                <v-card elevation="2">
                    <v-card-title class="d-flex justify-space-between align-center">
                        <span>Top Customers (This Month)</span>
                        <v-chip size="small" color="success" variant="flat">Top 5</v-chip>
                    </v-card-title>
                    <v-divider />
                    <v-card-text class="pa-0">
                        <v-list v-if="topCustomers.length > 0" lines="two">
                            <v-list-item v-for="(customer, index) in topCustomers" :key="customer.id" class="px-4">
                                <template v-slot:prepend>
                                    <v-avatar :color="getCustomerColor(index)" size="40" class="mr-3">
                                        <span class="text-white font-weight-bold">{{
                                            customer.name.charAt(0).toUpperCase() }}</span>
                                    </v-avatar>
                                </template>
                                <v-list-item-title class="font-weight-medium">{{ customer.name }}</v-list-item-title>
                                <v-list-item-subtitle>
                                    <div class="d-flex justify-space-between align-center mt-1">
                                        <span>{{ customer.orders }} {{ customer.orders === 1 ? 'order' : 'orders'
                                            }}</span>
                                        <span class="font-weight-bold text-success">{{ formatCurrency(customer.sales)
                                            }}</span>
                                    </div>
                                </v-list-item-subtitle>
                            </v-list-item>
                        </v-list>
                        <div v-else class="text-center py-8 text-grey">No data available</div>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>

        <!-- Alerts and Recent Sales Row -->
        <v-row dense>
            <!-- Low Stock Alerts -->
            <v-col cols="12" md="4">
                <v-card elevation="2" :color="lowStockItems.length > 0 ? 'error' : 'success'" variant="tonal">
                    <v-card-title class="d-flex align-center">
                        <v-icon :icon="lowStockItems.length > 0 ? 'mdi-alert' : 'mdi-check-circle'" class="mr-2" />
                        <span>Stock Alerts</span>
                        <v-chip v-if="lowStockItems.length > 0" size="small" color="error" class="ml-2">{{
                            lowStockItems.length
                            }}</v-chip>
                    </v-card-title>
                    <v-divider />
                    <v-card-text class="pa-0">
                        <v-list v-if="lowStockItems.length > 0" lines="two" max-height="300" style="overflow-y: auto;">
                            <v-list-item v-for="item in lowStockItems" :key="item.id" class="px-4">
                                <v-list-item-title class="font-weight-medium">{{ item.name }}</v-list-item-title>
                                <v-list-item-subtitle>
                                    <div class="d-flex justify-space-between align-center mt-1">
                                        <span class="text-error">Stock: {{ item.quantity }}</span>
                                        <span class="text-caption">Min: {{ item.minimum }}</span>
                                    </div>
                                    <div class="text-caption text-error mt-1">
                                        <v-icon icon="mdi-alert-circle" size="14" class="mr-1" />
                                        Need {{ item.needed }} more
                                    </div>
                                </v-list-item-subtitle>
                            </v-list-item>
                        </v-list>
                        <div v-else class="text-center py-8">
                            <v-icon icon="mdi-check-circle" size="48" color="success" class="mb-2" />
                            <div class="text-body-1">All products are well stocked</div>
                        </div>
                    </v-card-text>
                </v-card>
            </v-col>

            <!-- Recent Sales -->
            <v-col cols="12" md="8">
                <v-card elevation="2">
                    <v-card-title class="d-flex justify-space-between align-center">
                        <span>Recent Sales</span>
                        <v-btn size="small" variant="text" to="/admin/reports">View All</v-btn>
                    </v-card-title>
                    <v-divider />
                    <v-card-text class="pa-0">
                        <v-table v-if="recentSales.length > 0" density="compact">
                            <thead>
                                <tr>
                                    <th>Invoice</th>
                                    <th>Customer</th>
                                    <th class="text-right">Total</th>
                                    <th class="text-right">Paid</th>
                                    <th class="text-right">Due</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="sale in recentSales" :key="sale.id">
                                    <td>
                                        <v-chip size="small" variant="outlined">{{ sale.invoice_number }}</v-chip>
                                    </td>
                                    <td>{{ sale.customer }}</td>
                                    <td class="text-right font-weight-bold">{{ formatCurrency(sale.total) }}</td>
                                    <td class="text-right text-success">{{ formatCurrency(sale.paid) }}</td>
                                    <td class="text-right">
                                        <span
                                            :class="sale.balance > 0 ? 'text-warning font-weight-bold' : 'text-success'">
                                            {{ formatCurrency(sale.balance) }}
                                        </span>
                                    </td>
                                    <td>{{ formatDate(sale.date) }}</td>
                                    <td>
                                        <v-chip :color="getStatusColor(sale.status)" size="small" variant="flat">
                                            {{ sale.status }}
                                        </v-chip>
                                    </td>
                                </tr>
                            </tbody>
                        </v-table>
                        <div v-else class="text-center py-8 text-grey">No sales recorded yet</div>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>
    </div>
</template>

<script>
import axios from '@/utils/axios.config';
import { Line } from 'vue-chartjs';
import {
    Chart as ChartJS,
    CategoryScale,
    LinearScale,
    PointElement,
    LineElement,
    Title,
    Tooltip,
    Legend,
    Filler
} from 'chart.js';
import commonMixin from '../../mixins/commonMixin';

ChartJS.register(
    CategoryScale,
    LinearScale,
    PointElement,
    LineElement,
    Title,
    Tooltip,
    Legend,
    Filler
);

export default {
    name: 'AdminDashboard',
    components: {
        Line
    },
    mixins: [commonMixin],
    data() {
        return {
            loading: false,
            chartPeriod: '7',
            metrics: {
                today_sales: 0,
                yesterday_sales: 0,
                sales_growth: 0,
                month_sales: 0,
                last_month_sales: 0,
                month_growth: 0,
                today_purchases: 0,
                month_purchases: 0,
                profit: 0,
                customer_due: 0,
                supplier_due: 0,
                low_stock_items: 0,
                product_count: 0,
                customer_count: 0,
                supplier_count: 0,
            },
            charts: {
                sales_trend_7: [],
                sales_trend_30: [],
            },
            topProducts: [],
            topCustomers: [],
            lowStockItems: [],
            recentSales: [],
            aiInsights: {
                salesForecast: null,
                anomalies: [],
                performanceScore: null,
                recommendations: [],
                trendInsights: [],
            },
        };
    },
    computed: {
        primaryCards() {
            return [
                {
                    title: 'Today Sales',
                    value: this.formatCurrency(this.metrics.today_sales),
                    icon: 'mdi-cash-register',
                    iconColor: 'bg-primary',
                    color: 'primary-card',
                    trend: this.metrics.sales_growth,
                    subtitle: 'vs Yesterday',
                },
                {
                    title: 'This Month Sales',
                    value: this.formatCurrency(this.metrics.month_sales),
                    icon: 'mdi-chart-line',
                    iconColor: 'bg-success',
                    color: 'success-card',
                    trend: this.metrics.month_growth,
                    subtitle: 'vs Last Month',
                },
                {
                    title: 'This Month Profit',
                    value: this.formatCurrency(this.metrics.profit),
                    icon: 'mdi-trending-up',
                    iconColor: 'bg-info',
                    color: 'info-card',
                    trend: null,
                    subtitle: 'Revenue - Cost',
                },
                {
                    title: 'Customer Due',
                    value: this.formatCurrency(this.metrics.customer_due),
                    icon: 'mdi-account-alert',
                    iconColor: 'bg-warning',
                    color: 'warning-card',
                    trend: null,
                    subtitle: 'Outstanding payments',
                },
            ];
        },
        secondaryCards() {
            return [
                {
                    title: 'Today Purchases',
                    value: this.formatCurrency(this.metrics.today_purchases),
                    icon: 'mdi-cart-arrow-down',
                    color: 'info',
                },
                {
                    title: 'Supplier Due',
                    value: this.formatCurrency(this.metrics.supplier_due),
                    icon: 'mdi-account-outline',
                    color: 'warning',
                },
                {
                    title: 'Products',
                    value: this.metrics.product_count,
                    icon: 'mdi-package-variant',
                    color: 'primary',
                },
                {
                    title: 'Low Stock Items',
                    value: this.metrics.low_stock_items,
                    icon: 'mdi-alert',
                    color: 'error',
                },
            ];
        },
        quickStats() {
            return [
                {
                    label: 'Customers',
                    value: this.metrics.customer_count,
                    icon: 'mdi-account-group',
                    color: 'primary',
                },
                {
                    label: 'Suppliers',
                    value: this.metrics.supplier_count,
                    icon: 'mdi-truck-delivery',
                    color: 'info',
                },
                {
                    label: 'Month Purchases',
                    value: this.formatCurrency(this.metrics.month_purchases),
                    icon: 'mdi-cart',
                    color: 'success',
                },
            ];
        },
        chartData() {
            const trendData = this.chartPeriod === '7'
                ? (this.charts.sales_trend_7 || [])
                : (this.charts.sales_trend_30 || []);

            if (!trendData || trendData.length === 0) {
                return {
                    labels: [],
                    datasets: []
                };
            }

            return {
                labels: trendData.map(item => item.label || item.week || item.date),
                datasets: [
                    {
                        label: 'Sales',
                        data: trendData.map(item => item.sales || 0),
                        borderColor: 'rgb(25, 118, 210)',
                        backgroundColor: 'rgba(25, 118, 210, 0.1)',
                        fill: true,
                        tension: 0.4,
                        pointRadius: 4,
                        pointHoverRadius: 6,
                    },
                ],
            };
        },
        chartOptions() {
            return {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false,
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        padding: 12,
                        titleFont: {
                            size: 14,
                            weight: 'bold',
                        },
                        bodyFont: {
                            size: 13,
                        },
                        callbacks: {
                            label: (context) => {
                                const value = context.parsed.y || 0;
                                const formatted = '৳' + value.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                                return `Sales: ${formatted}`;
                            },
                        },
                    },
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: (value) => {
                                if (value >= 1000) {
                                    return '৳' + (value / 1000).toFixed(1) + 'k';
                                }
                                return '৳' + value;
                            },
                        },
                        grid: {
                            color: 'rgba(0, 0, 0, 0.05)',
                        },
                    },
                    x: {
                        grid: {
                            display: false,
                        },
                    },
                },
            };
        },
    },
    watch: {
        chartPeriod() {
            // Chart will automatically update via computed property
        },
    },
    created() {
        this.loadDashboard();
    },
    methods: {
        async loadDashboard() {
            this.loading = true;
            try {
                const response = await axios.get('/api/v1/dashboard', {
                    headers: this.getAuthHeaders()
                });
                const data = response.data;
                this.metrics = { ...this.metrics, ...(data.metrics || {}) };
                this.charts = { ...this.charts, ...(data.charts || {}) };
                this.topProducts = data.top_products || [];
                this.topCustomers = data.top_customers || [];
                this.lowStockItems = data.low_stock_items || [];
                this.recentSales = data.recent_sales || [];

                // Generate AI insights after data is loaded
                this.generateAIInsights();
            } catch (error) {
                console.error('Failed to load dashboard', error);
                this.handleApiError(error, 'Failed to load dashboard data');
            } finally {
                this.loading = false;
            }
        },
        generateAIInsights() {
            // Sales Forecast
            this.aiInsights.salesForecast = this.calculateSalesForecast();

            // Anomaly Detection
            this.aiInsights.anomalies = this.detectAnomalies();

            // Performance Score
            this.aiInsights.performanceScore = this.calculatePerformanceScore();

            // Recommendations
            this.aiInsights.recommendations = this.generateRecommendations();

            // Trend Insights
            this.aiInsights.trendInsights = this.analyzeTrends();
        },
        calculateSalesForecast() {
            const trendData = this.chartPeriod === '7'
                ? (this.charts.sales_trend_7 || [])
                : (this.charts.sales_trend_30 || []);

            if (!trendData || trendData.length < 3) {
                return null;
            }

            // Simple linear regression for forecasting
            const sales = trendData.map(item => item.sales || 0);
            const avgSales = sales.reduce((a, b) => a + b, 0) / sales.length;

            // Calculate trend (simple average of last 3 days/weeks)
            const recentSales = sales.slice(-3);
            const recentAvg = recentSales.reduce((a, b) => a + b, 0) / recentSales.length;
            const trend = recentAvg > avgSales ? 'increasing' : 'decreasing';

            // Predict next period (simple projection)
            const growthRate = recentAvg > 0 ? (recentAvg - avgSales) / avgSales : 0;
            const predicted = this.metrics.month_sales * (1 + growthRate * 0.1); // Conservative projection

            const period = this.chartPeriod === '7' ? 'next week' : 'next month';

            return {
                predicted: Math.max(0, predicted),
                period: period,
                trend: trend,
                message: trend === 'increasing'
                    ? 'Sales are trending upward. Expected growth continues.'
                    : 'Sales are declining. Consider promotional strategies.',
            };
        },
        detectAnomalies() {
            const anomalies = [];

            // Check for sudden sales drop
            if (this.metrics.sales_growth < -20) {
                anomalies.push({
                    severity: 'high',
                    message: `Sales dropped ${Math.abs(this.metrics.sales_growth).toFixed(1)}% compared to yesterday. Immediate attention required.`,
                    type: 'sales_drop',
                });
            } else if (this.metrics.sales_growth < -10) {
                anomalies.push({
                    severity: 'medium',
                    message: `Sales decreased ${Math.abs(this.metrics.sales_growth).toFixed(1)}% compared to yesterday. Monitor closely.`,
                    type: 'sales_drop',
                });
            }

            // Check for low stock items
            if (this.metrics.low_stock_items > 5) {
                anomalies.push({
                    severity: 'high',
                    message: `${this.metrics.low_stock_items} products are running low on stock. Restock needed.`,
                    type: 'low_stock',
                });
            } else if (this.metrics.low_stock_items > 0) {
                anomalies.push({
                    severity: 'medium',
                    message: `${this.metrics.low_stock_items} product(s) need restocking.`,
                    type: 'low_stock',
                });
            }

            // Check for high customer due
            if (this.metrics.customer_due > this.metrics.month_sales * 0.3) {
                anomalies.push({
                    severity: 'medium',
                    message: `Customer dues (${this.formatCurrency(this.metrics.customer_due)}) are high. Follow up on payments.`,
                    type: 'high_due',
                });
            }

            // Check for negative profit
            if (this.metrics.profit < 0) {
                anomalies.push({
                    severity: 'high',
                    message: 'Negative profit detected this month. Review pricing and costs.',
                    type: 'negative_profit',
                });
            }

            return anomalies;
        },
        calculatePerformanceScore() {
            let score = 100;
            const factors = [];

            // Sales growth factor
            if (this.metrics.sales_growth > 0) {
                score += Math.min(10, this.metrics.sales_growth / 2);
                factors.push('positive');
            } else {
                score -= Math.min(15, Math.abs(this.metrics.sales_growth));
                factors.push('negative');
            }

            // Month growth factor
            if (this.metrics.month_growth > 0) {
                score += Math.min(10, this.metrics.month_growth / 2);
            } else {
                score -= Math.min(15, Math.abs(this.metrics.month_growth));
            }

            // Low stock penalty
            score -= this.metrics.low_stock_items * 2;

            // Profit factor
            if (this.metrics.profit > 0) {
                const profitMargin = (this.metrics.profit / this.metrics.month_sales) * 100;
                if (profitMargin > 20) {
                    score += 10;
                } else if (profitMargin > 10) {
                    score += 5;
                }
            } else {
                score -= 20;
            }

            // Due management
            const dueRatio = this.metrics.customer_due / (this.metrics.month_sales || 1);
            if (dueRatio > 0.3) {
                score -= 10;
            } else if (dueRatio < 0.1) {
                score += 5;
            }

            score = Math.max(0, Math.min(100, score));

            let label = 'Excellent';
            let description = 'Your business is performing exceptionally well.';

            if (score < 50) {
                label = 'Needs Improvement';
                description = 'Several areas need attention to improve performance.';
            } else if (score < 70) {
                label = 'Good';
                description = 'Business is performing well with room for optimization.';
            } else if (score < 85) {
                label = 'Very Good';
                description = 'Strong performance with minor areas to enhance.';
            }

            return {
                score: Math.round(score),
                label: label,
                description: description,
            };
        },
        generateRecommendations() {
            const recommendations = [];

            // Sales recommendations
            if (this.metrics.sales_growth < -10) {
                recommendations.push({
                    title: 'Boost Sales Performance',
                    description: 'Sales are declining. Consider running promotions, improving marketing, or reviewing pricing strategy.',
                    priority: 'high',
                    category: 'sales',
                });
            }

            // Stock recommendations
            if (this.lowStockItems.length > 0) {
                const topLowStock = this.lowStockItems.slice(0, 3).map(item => item.name).join(', ');
                recommendations.push({
                    title: 'Restock Low Inventory Items',
                    description: `Priority items: ${topLowStock}. Reorder to prevent stockouts.`,
                    priority: this.metrics.low_stock_items > 5 ? 'high' : 'medium',
                    category: 'inventory',
                });
            }

            // Profit recommendations
            if (this.metrics.profit < this.metrics.month_sales * 0.1) {
                recommendations.push({
                    title: 'Optimize Profit Margins',
                    description: 'Profit margins are low. Review product pricing, negotiate better supplier rates, or reduce operational costs.',
                    priority: 'high',
                    category: 'profit',
                });
            }

            // Customer due recommendations
            if (this.metrics.customer_due > this.metrics.month_sales * 0.2) {
                recommendations.push({
                    title: 'Collect Outstanding Payments',
                    description: `Customer dues of ${this.formatCurrency(this.metrics.customer_due)} need attention. Follow up with customers.`,
                    priority: 'medium',
                    category: 'finance',
                });
            }

            // Top product recommendations
            if (this.topProducts.length > 0 && this.topProducts[0].sales > 0) {
                recommendations.push({
                    title: 'Leverage Top Performing Products',
                    description: `${this.topProducts[0].name} is your best seller. Consider increasing inventory and promoting similar products.`,
                    priority: 'low',
                    category: 'marketing',
                });
            }

            // Growth recommendations
            if (this.metrics.month_growth > 10 && this.metrics.sales_growth > 5) {
                recommendations.push({
                    title: 'Capitalize on Growth Momentum',
                    description: 'Strong growth detected. Consider expanding inventory, hiring staff, or investing in marketing to sustain growth.',
                    priority: 'low',
                    category: 'growth',
                });
            }

            return recommendations;
        },
        analyzeTrends() {
            const insights = [];

            // Sales trend
            if (this.metrics.sales_growth > 10) {
                insights.push({
                    type: 'positive',
                    message: `Sales up ${this.metrics.sales_growth.toFixed(1)}% today`,
                });
            } else if (this.metrics.sales_growth < -10) {
                insights.push({
                    type: 'negative',
                    message: `Sales down ${Math.abs(this.metrics.sales_growth).toFixed(1)}% today`,
                });
            }

            // Month growth
            if (this.metrics.month_growth > 15) {
                insights.push({
                    type: 'positive',
                    message: `Month-over-month growth: ${this.metrics.month_growth.toFixed(1)}%`,
                });
            } else if (this.metrics.month_growth < -10) {
                insights.push({
                    type: 'negative',
                    message: `Month-over-month decline: ${Math.abs(this.metrics.month_growth).toFixed(1)}%`,
                });
            }

            // Profit trend
            if (this.metrics.profit > 0) {
                const profitMargin = (this.metrics.profit / this.metrics.month_sales) * 100;
                if (profitMargin > 20) {
                    insights.push({
                        type: 'positive',
                        message: `Strong profit margin: ${profitMargin.toFixed(1)}%`,
                    });
                } else if (profitMargin < 5) {
                    insights.push({
                        type: 'negative',
                        message: `Low profit margin: ${profitMargin.toFixed(1)}%`,
                    });
                }
            }

            // Customer activity
            if (this.topCustomers.length > 0) {
                const avgOrderValue = this.topCustomers.reduce((sum, c) => sum + (c.sales / c.orders), 0) / this.topCustomers.length;
                insights.push({
                    type: 'info',
                    message: `Average order value: ${this.formatCurrency(avgOrderValue)}`,
                });
            }

            return insights;
        },
        getPerformanceColor(score) {
            if (score >= 85) return 'success';
            if (score >= 70) return 'info';
            if (score >= 50) return 'warning';
            return 'error';
        },
        getRecommendationColor(priority) {
            const colorMap = {
                'high': 'error',
                'medium': 'warning',
                'low': 'info',
            };
            return colorMap[priority] || 'info';
        },
        getRecommendationIcon(priority) {
            const iconMap = {
                'high': 'mdi-alert',
                'medium': 'mdi-information',
                'low': 'mdi-lightbulb',
            };
            return iconMap[priority] || 'mdi-information';
        },
        formatCurrency(value) {
            const number = Number(value) || 0;
            // Format with BDT symbol (৳) and comma separators
            return '৳' + number.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
        },
        getCustomerColor(index) {
            const colors = ['primary', 'success', 'info', 'warning', 'error'];
            return colors[index % colors.length];
        },
        getStatusColor(status) {
            const colorMap = {
                'completed': 'success',
                'pending': 'warning',
                'cancelled': 'error',
                'paid': 'success',
                'partial': 'info',
            };
            return colorMap[status?.toLowerCase()] || 'grey';
        },
    },
};
</script>

<style scoped>
.page-header {
    gap: 8px;
}

.kpi-card {
    transition: transform 0.2s, box-shadow 0.2s;
    cursor: default;
}

.kpi-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15) !important;
}

.kpi-icon {
    width: 56px;
    height: 56px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
}

.bg-primary {
    background: linear-gradient(135deg, #1976d2 0%, #1565c0 100%);
}

.bg-success {
    background: linear-gradient(135deg, #388e3c 0%, #2e7d32 100%);
}

.bg-info {
    background: linear-gradient(135deg, #0288d1 0%, #0277bd 100%);
}

.bg-warning {
    background: linear-gradient(135deg, #f57c00 0%, #ef6c00 100%);
}

.primary-card {
    border-left: 4px solid #1976d2;
}

.success-card {
    border-left: 4px solid #388e3c;
}

.info-card {
    border-left: 4px solid #0288d1;
}

.warning-card {
    border-left: 4px solid #f57c00;
}

.rank-badge {
    width: 32px;
    height: 32px;
    border-radius: 50%;
    background: linear-gradient(135deg, #1976d2 0%, #1565c0 100%);
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    font-size: 14px;
}

:deep(.v-chip-group .v-chip--selected) {
    background-color: rgb(var(--v-theme-primary));
    color: white;
}

.ai-insights-card {
    background: linear-gradient(135deg, rgba(25, 118, 210, 0.05) 0%, rgba(25, 118, 210, 0.02) 100%);
    border: 1px solid rgba(25, 118, 210, 0.1);
}

.insight-card {
    transition: transform 0.2s, box-shadow 0.2s;
    height: 100%;
}

.insight-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1) !important;
}
</style>