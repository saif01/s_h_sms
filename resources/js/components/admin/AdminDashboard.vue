<template>
    <div>
        <div class="page-header mb-6 d-flex align-center justify-space-between">
            <h1 class="text-h4 page-title">Dashboard</h1>
            <v-btn icon="mdi-refresh" @click="loadDashboard" :loading="loading" variant="text" />
        </div>

        <v-row class="mb-4" dense>
            <v-col cols="12" sm="6" md="3" v-for="card in cards" :key="card.title">
                <v-card class="py-3 px-4">
                    <div class="text-caption text-grey mb-1">{{ card.title }}</div>
                    <div class="text-h4 font-weight-bold">{{ card.value }}</div>
                </v-card>
            </v-col>
        </v-row>

        <v-card>
            <v-card-title class="d-flex justify-space-between align-center">
                <div class="text-subtitle-1">Recent Sales</div>
                <v-btn size="small" icon="mdi-refresh" @click="loadDashboard" :loading="loading" variant="text" />
            </v-card-title>
            <v-divider />
            <v-card-text>
                <v-table density="compact">
                    <thead>
                        <tr>
                            <th>Invoice</th>
                            <th>Customer</th>
                            <th class="text-right">Total</th>
                            <th class="text-right">Paid</th>
                            <th class="text-right">Due</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-if="recentSales.length === 0">
                            <td colspan="6" class="text-center text-grey">No sales recorded yet</td>
                        </tr>
                        <tr v-for="sale in recentSales" :key="sale.id">
                            <td>{{ sale.invoice_number }}</td>
                            <td>{{ sale.customer || 'Walk-in' }}</td>
                            <td class="text-right">{{ formatCurrency(sale.total) }}</td>
                            <td class="text-right">{{ formatCurrency(sale.paid) }}</td>
                            <td class="text-right">{{ formatCurrency(sale.balance) }}</td>
                            <td>{{ sale.date }}</td>
                        </tr>
                    </tbody>
                </v-table>
            </v-card-text>
        </v-card>
    </div>
</template>

<script>
import axios from '@/utils/axios.config';

export default {
    name: 'AdminDashboard',
    data() {
        return {
            loading: false,
            metrics: {
                today_sales: 0,
                month_sales: 0,
                customer_due: 0,
                low_stock_items: 0,
                product_count: 0,
            },
            recentSales: [],
        };
    },
    computed: {
        cards() {
            return [
                { title: 'Today Sales', value: this.formatCurrency(this.metrics.today_sales) },
                { title: 'This Month Sales', value: this.formatCurrency(this.metrics.month_sales) },
                { title: 'Customer Due', value: this.formatCurrency(this.metrics.customer_due) },
                { title: 'Low Stock Items', value: this.metrics.low_stock_items },
                { title: 'Products', value: this.metrics.product_count },
            ];
        },
    },
    created() {
        this.loadDashboard();
    },
    methods: {
        async loadDashboard() {
            this.loading = true;
            try {
                const { data } = await axios.get('/api/v1/dashboard');
                this.metrics = data.metrics || this.metrics;
                this.recentSales = data.recent_sales || [];
            } catch (error) {
                console.error('Failed to load dashboard', error);
                this.$toast?.error('Failed to load dashboard data');
            } finally {
                this.loading = false;
            }
        },
        formatCurrency(value) {
            const number = Number(value) || 0;
            return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(number);
        },
    },
};
</script>

<style scoped>
.page-header {
    gap: 8px;
}
</style>
