<template>
    <div>
        <!-- Filters -->
        <v-card class="mb-4">
            <v-card-text>
                <v-row>
                    <v-col cols="12" md="3">
                        <DatePicker v-model="filters.date_from" label="From Date" density="compact"
                            @update:model-value="onDateFromChange" />
                    </v-col>
                    <v-col cols="12" md="3">
                        <DatePicker v-model="filters.date_to" label="To Date" density="compact"
                            @update:model-value="onDateToChange" />
                    </v-col>
                    <v-col cols="12" md="3">
                        <v-select v-model="filters.category_id" :items="categories" item-value="id" item-title="name"
                            label="Category" variant="outlined" density="compact" clearable
                            @update:model-value="onFilterChange" />
                    </v-col>
                    <v-col cols="12" md="3">
                        <v-select v-model="filters.group_by" :items="groupByOptions" label="Group By" variant="outlined"
                            density="compact" @update:model-value="onFilterChange" />
                    </v-col>
                </v-row>
            </v-card-text>
        </v-card>

        <!-- Summary Cards -->
        <v-row v-if="summary" class="mb-4" dense>
            <v-col cols="12" sm="6" md="3">
                <v-card color="primary" variant="tonal" class="summary-card">
                    <v-card-text class="py-3">
                        <div class="text-caption text-grey-darken-1 mb-1">Total Revenue</div>
                        <div class="text-h6 font-weight-bold">{{ formatCurrency(summary.total_revenue) }}</div>
                    </v-card-text>
                </v-card>
            </v-col>
            <v-col cols="12" sm="6" md="3">
                <v-card color="warning" variant="tonal" class="summary-card">
                    <v-card-text class="py-3">
                        <div class="text-caption text-grey-darken-1 mb-1">Total Cost</div>
                        <div class="text-h6 font-weight-bold">{{ formatCurrency(summary.total_cost) }}</div>
                    </v-card-text>
                </v-card>
            </v-col>
            <v-col cols="12" sm="6" md="3">
                <v-card color="success" variant="tonal" class="summary-card">
                    <v-card-text class="py-3">
                        <div class="text-caption text-grey-darken-1 mb-1">Gross Profit</div>
                        <div class="text-h6 font-weight-bold">{{ formatCurrency(summary.gross_profit) }}</div>
                    </v-card-text>
                </v-card>
            </v-col>
            <v-col cols="12" sm="6" md="3">
                <v-card color="info" variant="tonal" class="summary-card">
                    <v-card-text class="py-3">
                        <div class="text-caption text-grey-darken-1 mb-1">Profit Margin</div>
                        <div class="text-h6 font-weight-bold">{{ summary.profit_margin?.toFixed(2) || 0 }}%</div>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>

        <!-- Report Table -->
        <v-card>
            <v-card-title class="d-flex justify-space-between align-center">
                <span>Profit Report</span>
                <div class="d-flex align-center gap-2">
                    <v-btn color="success" size="small" prepend-icon="mdi-file-excel" @click="exportExcel"
                        :disabled="loading || !reportData.length" :loading="exporting">
                        Export Excel
                    </v-btn>
                    <v-btn color="error" size="small" prepend-icon="mdi-file-pdf-box" @click="exportPDF"
                        :disabled="loading || !reportData.length" :loading="exporting">
                        Export PDF
                    </v-btn>
                    <span class="text-caption text-grey">
                        Total Records: <strong>{{ (pagination.total || 0).toLocaleString() }}</strong>
                        <span v-if="reportData.length > 0">
                            | Showing {{ ((currentPage - 1) * perPage) + 1 }} to {{ Math.min(currentPage * perPage,
                                pagination.total).toLocaleString() }} of {{ pagination.total.toLocaleString() }}
                        </span>
                    </span>
                </div>
            </v-card-title>
            <v-card-text>
                <v-table>
                    <thead>
                        <tr>
                            <th class="sortable" @click="onSort('period')">
                                <div class="sortable-header">
                                    <span>Period</span>
                                    <v-icon v-if="sortBy === 'period'" size="18" class="sort-icon active">
                                        {{ sortDirection === 'asc' ? 'mdi-arrow-up' : 'mdi-arrow-down' }}
                                    </v-icon>
                                    <v-icon v-else size="18" class="sort-icon inactive">
                                        mdi-unfold-more-horizontal
                                    </v-icon>
                                </div>
                            </th>
                            <th class="sortable" @click="onSort('name')">
                                <div class="sortable-header">
                                    <span>Product/Category</span>
                                    <v-icon v-if="sortBy === 'name'" size="18" class="sort-icon active">
                                        {{ sortDirection === 'asc' ? 'mdi-arrow-up' : 'mdi-arrow-down' }}
                                    </v-icon>
                                    <v-icon v-else size="18" class="sort-icon inactive">
                                        mdi-unfold-more-horizontal
                                    </v-icon>
                                </div>
                            </th>
                            <th class="text-center sortable" @click="onSort('quantity_sold')">
                                <div class="sortable-header justify-center">
                                    <span>Qty Sold</span>
                                    <v-icon v-if="sortBy === 'quantity_sold'" size="18" class="sort-icon active">
                                        {{ sortDirection === 'asc' ? 'mdi-arrow-up' : 'mdi-arrow-down' }}
                                    </v-icon>
                                    <v-icon v-else size="18" class="sort-icon inactive">
                                        mdi-unfold-more-horizontal
                                    </v-icon>
                                </div>
                            </th>
                            <th class="text-end sortable" @click="onSort('revenue')">
                                <div class="sortable-header justify-end">
                                    <span>Revenue</span>
                                    <v-icon v-if="sortBy === 'revenue'" size="18" class="sort-icon active">
                                        {{ sortDirection === 'asc' ? 'mdi-arrow-up' : 'mdi-arrow-down' }}
                                    </v-icon>
                                    <v-icon v-else size="18" class="sort-icon inactive">
                                        mdi-unfold-more-horizontal
                                    </v-icon>
                                </div>
                            </th>
                            <th class="text-end sortable" @click="onSort('cost')">
                                <div class="sortable-header justify-end">
                                    <span>Cost</span>
                                    <v-icon v-if="sortBy === 'cost'" size="18" class="sort-icon active">
                                        {{ sortDirection === 'asc' ? 'mdi-arrow-up' : 'mdi-arrow-down' }}
                                    </v-icon>
                                    <v-icon v-else size="18" class="sort-icon inactive">
                                        mdi-unfold-more-horizontal
                                    </v-icon>
                                </div>
                            </th>
                            <th class="text-end sortable" @click="onSort('discount')">
                                <div class="sortable-header justify-end">
                                    <span>Discount</span>
                                    <v-icon v-if="sortBy === 'discount'" size="18" class="sort-icon active">
                                        {{ sortDirection === 'asc' ? 'mdi-arrow-up' : 'mdi-arrow-down' }}
                                    </v-icon>
                                    <v-icon v-else size="18" class="sort-icon inactive">
                                        mdi-unfold-more-horizontal
                                    </v-icon>
                                </div>
                            </th>
                            <th class="text-end sortable" @click="onSort('profit')">
                                <div class="sortable-header justify-end">
                                    <span>Profit</span>
                                    <v-icon v-if="sortBy === 'profit'" size="18" class="sort-icon active">
                                        {{ sortDirection === 'asc' ? 'mdi-arrow-up' : 'mdi-arrow-down' }}
                                    </v-icon>
                                    <v-icon v-else size="18" class="sort-icon inactive">
                                        mdi-unfold-more-horizontal
                                    </v-icon>
                                </div>
                            </th>
                            <th class="text-end sortable" @click="onSort('profit_margin')">
                                <div class="sortable-header justify-end">
                                    <span>Margin %</span>
                                    <v-icon v-if="sortBy === 'profit_margin'" size="18" class="sort-icon active">
                                        {{ sortDirection === 'asc' ? 'mdi-arrow-up' : 'mdi-arrow-down' }}
                                    </v-icon>
                                    <v-icon v-else size="18" class="sort-icon inactive">
                                        mdi-unfold-more-horizontal
                                    </v-icon>
                                </div>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Skeleton Loaders -->
                        <tr v-if="loading" v-for="n in 5" :key="`skeleton-${n}`">
                            <td><v-skeleton-loader type="text" width="100"></v-skeleton-loader></td>
                            <td><v-skeleton-loader type="text" width="150"></v-skeleton-loader></td>
                            <td><v-skeleton-loader type="text" width="80"></v-skeleton-loader></td>
                            <td><v-skeleton-loader type="text" width="100"></v-skeleton-loader></td>
                            <td><v-skeleton-loader type="text" width="100"></v-skeleton-loader></td>
                            <td><v-skeleton-loader type="text" width="80"></v-skeleton-loader></td>
                            <td><v-skeleton-loader type="text" width="100"></v-skeleton-loader></td>
                            <td><v-skeleton-loader type="text" width="80"></v-skeleton-loader></td>
                        </tr>
                        <!-- Actual Report Data -->
                        <template v-else>
                            <tr v-for="item in reportData" :key="item.id || item.period || item.name">
                                <td>{{ item.period }}</td>
                                <td>{{ item.name }}</td>
                                <td class="text-center">{{ item.quantity_sold || 0 }}</td>
                                <td class="text-end">{{ formatCurrency(item.revenue) }}</td>
                                <td class="text-end">{{ formatCurrency(item.cost) }}</td>
                                <td class="text-end">{{ formatCurrency(item.discount) }}</td>
                                <td class="text-end">
                                    <v-chip :color="item.profit >= 0 ? 'success' : 'error'" size="small" variant="flat">
                                        {{ formatCurrency(item.profit) }}
                                    </v-chip>
                                </td>
                                <td class="text-end">{{ parseFloat(item.profit_margin || 0).toFixed(2) }}%</td>
                            </tr>
                            <tr v-if="reportData.length === 0">
                                <td colspan="8" class="text-center py-4">No profit data found</td>
                            </tr>
                        </template>
                    </tbody>
                </v-table>

                <!-- Pagination -->
                <div
                    class="d-flex flex-column flex-md-row justify-space-between align-center align-md-start gap-3 mt-4">
                    <!-- Left: Records Info -->
                    <div class="text-caption text-grey">
                        <span v-if="reportData.length > 0 && pagination.total > 0">
                            <span v-if="perPage === 'all'">
                                Showing <strong>all {{ pagination.total.toLocaleString() }}</strong> records
                            </span>
                            <span v-else>
                                Showing <strong>{{ ((currentPage - 1) * perPage) + 1 }}</strong> to
                                <strong>{{ Math.min(currentPage * perPage, pagination.total).toLocaleString()
                                    }}</strong> of
                                <strong>{{ pagination.total.toLocaleString() }}</strong> records
                            </span>
                        </span>
                        <span v-else>No records found</span>
                    </div>

                    <!-- Right: Items Per Page and Pagination -->
                    <PaginationControls v-model="currentPage" :pagination="pagination" :per-page-value="perPage"
                        :per-page-options="perPageOptions" @update:per-page="onPerPageUpdate"
                        @page-change="onPageChange" />
                </div>
            </v-card-text>
        </v-card>

        <!-- Profit Chart -->
        <v-card class="mt-4" v-if="chartData.length">
            <v-card-title>Profit Trend</v-card-title>
            <v-card-text>
                <div class="text-center text-caption">
                    Chart visualization would go here (integrate with Chart.js or similar)
                </div>
            </v-card-text>
        </v-card>
    </div>
</template>

<script>
import commonMixin from '../../../../mixins/commonMixin';
import PaginationControls from '../../../common/PaginationControls.vue';
import DatePicker from '../../../common/DatePicker.vue';
import { paginationMixin } from '../../../../utils/pagination.js';

export default {
    name: 'ProfitReports',
    components: {
        PaginationControls,
        DatePicker
    },
    mixins: [commonMixin, paginationMixin],
    data() {
        return {
            loading: false,
            exporting: false,
            filters: {
                date_from: new Date(new Date().getFullYear(), new Date().getMonth(), 1).toISOString().split('T')[0],
                date_to: new Date().toISOString().split('T')[0],
                category_id: null,
                group_by: 'daily',
            },
            reportData: [],
            chartData: [],
            summary: null,
            categories: [],
            groupByOptions: [
                { title: 'Daily', value: 'daily' },
                { title: 'Weekly', value: 'weekly' },
                { title: 'Monthly', value: 'monthly' },
                { title: 'By Product', value: 'product' },
                { title: 'By Category', value: 'category' },
            ],
        };
    },
    mounted() {
        this.fetchCategories();
        this.generateReport();
    },
    methods: {
        async fetchCategories() {
            try {
                const response = await this.$axios.get('/api/v1/categories', {
                    headers: this.getAuthHeaders()
                });
                this.categories = response.data.data || response.data.categories || [];
            } catch (error) {
                console.error('Failed to fetch categories', error);
            }
        },
        async generateReport() {
            try {
                this.loading = true;
                const params = this.buildPaginationParams();

                // Handle "Show All" option
                if (this.perPage === 'all') {
                    params.per_page = 999999;
                }

                // Add filter params
                if (this.filters.date_from) {
                    params.date_from = this.filters.date_from;
                }
                if (this.filters.date_to) {
                    params.date_to = this.filters.date_to;
                }
                if (this.filters.category_id) {
                    params.category_id = this.filters.category_id;
                }
                if (this.filters.group_by) {
                    params.group_by = this.filters.group_by;
                }

                const response = await this.$axios.get('/api/v1/reports/profit', {
                    params,
                    headers: this.getAuthHeaders()
                });
                // Handle both paginated response (data) and legacy format (profit)
                this.reportData = response.data.data || response.data.profit || [];
                this.chartData = response.data.chart || [];
                this.summary = response.data.summary || null;
                this.updatePagination(response.data);
            } catch (error) {
                this.handleApiError(error, 'Failed to generate profit report');
            } finally {
                this.loading = false;
            }
        },
        async exportExcel() {
            try {
                this.exporting = true;
                const response = await this.$axios.get('/api/v1/reports/profit/export/excel', {
                    params: this.filters,
                    responseType: 'blob',
                    headers: this.getAuthHeaders()
                });
                const url = window.URL.createObjectURL(new Blob([response.data]));
                const link = document.createElement('a');
                link.href = url;
                link.setAttribute('download', `profit_report_${Date.now()}.xlsx`);
                document.body.appendChild(link);
                link.click();
                link.remove();
                window.URL.revokeObjectURL(url);
                this.$toast?.success('Report exported successfully');
            } catch (error) {
                console.error('Failed to export Excel', error);
                this.$toast?.error('Failed to export report');
            } finally {
                this.exporting = false;
            }
        },
        async exportPDF() {
            try {
                this.exporting = true;
                const response = await this.$axios.get('/api/v1/reports/profit/export/pdf', {
                    params: this.filters,
                    responseType: 'blob',
                    headers: this.getAuthHeaders()
                });
                const url = window.URL.createObjectURL(new Blob([response.data]));
                const link = document.createElement('a');
                link.href = url;
                link.setAttribute('download', `profit_report_${Date.now()}.pdf`);
                document.body.appendChild(link);
                link.click();
                link.remove();
                window.URL.revokeObjectURL(url);
                this.$toast?.success('Report exported successfully');
            } catch (error) {
                console.error('Failed to export PDF', error);
                this.$toast?.error('Failed to export report');
            } finally {
                this.exporting = false;
            }
        },
        formatCurrency(value) {
            if (value === null || value === undefined) return '৳0.00';
            return '৳' + new Intl.NumberFormat('en-US', {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            }).format(value);
        },
        // Date change handlers - explicitly set the filter value and fetch
        onDateFromChange(value) {
            // Set the filter value explicitly (handles both v-model update and direct value)
            this.filters.date_from = value || '';
            this.resetPagination(); // Reset to first page when filter changes
            this.generateReport();
        },
        onDateToChange(value) {
            // Set the filter value explicitly (handles both v-model update and direct value)
            this.filters.date_to = value || '';
            this.resetPagination(); // Reset to first page when filter changes
            this.generateReport();
        },
        onFilterChange() {
            this.resetPagination(); // Reset to first page when filter changes
            this.generateReport();
        },
    },
};
</script>

<style scoped>
.summary-card {
    height: 100%;
}

.summary-card .v-card-text {
    padding: 12px 16px;
}

.gap-2 {
    gap: 8px;
}

.sortable {
    cursor: pointer;
    user-select: none;
}

.sortable:hover {
    background-color: rgba(0, 0, 0, 0.04);
}

.sortable-header {
    display: flex;
    align-items: center;
    gap: 4px;
}

.sort-icon {
    opacity: 0.5;
    transition: opacity 0.2s;
}

.sort-icon.active {
    opacity: 1;
    color: rgb(var(--v-theme-primary));
}
</style>
