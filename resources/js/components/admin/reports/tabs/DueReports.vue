<template>
    <div>
        <!-- Filters -->
        <v-card class="mb-4">
            <v-card-text>
                <v-row>
                    <v-col cols="12" md="4">
                        <v-select v-model="filters.party_type" :items="partyTypes" label="Party Type"
                            variant="outlined" density="compact" @update:model-value="onFilterChange" />
                    </v-col>
                    <v-col cols="12" md="4">
                        <v-select v-model="filters.party_id" :items="partyOptions" item-value="id" item-title="name"
                            label="Select Party" variant="outlined" density="compact" clearable
                            @update:model-value="onFilterChange" />
                    </v-col>
                    <v-col cols="12" md="4">
                        <v-switch v-model="filters.overdue_only" label="Overdue Only" density="compact"
                            @update:model-value="onFilterChange" />
                    </v-col>
                </v-row>
            </v-card-text>
        </v-card>

        <!-- Summary Cards -->
        <v-row v-if="summary" class="mb-4" dense>
            <v-col cols="12" sm="4">
                <v-card color="error" variant="tonal" class="summary-card">
                    <v-card-text class="py-3">
                        <div class="text-caption text-grey-darken-1 mb-1">Total Due Amount</div>
                        <div class="text-h6 font-weight-bold">{{ formatCurrency(summary.total_due) }}</div>
                    </v-card-text>
                </v-card>
            </v-col>
            <v-col cols="12" sm="4">
                <v-card color="warning" variant="tonal" class="summary-card">
                    <v-card-text class="py-3">
                        <div class="text-caption text-grey-darken-1 mb-1">Overdue Amount</div>
                        <div class="text-h6 font-weight-bold">{{ formatCurrency(summary.overdue_amount) }}</div>
                    </v-card-text>
                </v-card>
            </v-col>
            <v-col cols="12" sm="4">
                <v-card color="info" variant="tonal" class="summary-card">
                    <v-card-text class="py-3">
                        <div class="text-caption text-grey-darken-1 mb-1">Total Parties</div>
                        <div class="text-h6 font-weight-bold">{{ summary.total_parties || 0 }}</div>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>

        <!-- Report Table -->
        <v-card>
            <v-card-title class="d-flex justify-space-between align-center">
                <span>Due Report</span>
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
                            <th class="sortable" @click="onSort('party_name')">
                                <div class="sortable-header">
                                    <span>{{ filters.party_type === 'customer' ? 'Customer' : 'Supplier' }}</span>
                                    <v-icon v-if="sortBy === 'party_name'" size="18" class="sort-icon active">
                                        {{ sortDirection === 'asc' ? 'mdi-arrow-up' : 'mdi-arrow-down' }}
                                    </v-icon>
                                    <v-icon v-else size="18" class="sort-icon inactive">
                                        mdi-unfold-more-horizontal
                                    </v-icon>
                                </div>
                            </th>
                            <th class="sortable" @click="onSort('invoice_number')">
                                <div class="sortable-header">
                                    <span>Invoice #</span>
                                    <v-icon v-if="sortBy === 'invoice_number'" size="18" class="sort-icon active">
                                        {{ sortDirection === 'asc' ? 'mdi-arrow-up' : 'mdi-arrow-down' }}
                                    </v-icon>
                                    <v-icon v-else size="18" class="sort-icon inactive">
                                        mdi-unfold-more-horizontal
                                    </v-icon>
                                </div>
                            </th>
                            <th class="sortable" @click="onSort('invoice_date')">
                                <div class="sortable-header">
                                    <span>Date</span>
                                    <v-icon v-if="sortBy === 'invoice_date'" size="18" class="sort-icon active">
                                        {{ sortDirection === 'asc' ? 'mdi-arrow-up' : 'mdi-arrow-down' }}
                                    </v-icon>
                                    <v-icon v-else size="18" class="sort-icon inactive">
                                        mdi-unfold-more-horizontal
                                    </v-icon>
                                </div>
                            </th>
                            <th class="sortable" @click="onSort('due_date')">
                                <div class="sortable-header">
                                    <span>Due Date</span>
                                    <v-icon v-if="sortBy === 'due_date'" size="18" class="sort-icon active">
                                        {{ sortDirection === 'asc' ? 'mdi-arrow-up' : 'mdi-arrow-down' }}
                                    </v-icon>
                                    <v-icon v-else size="18" class="sort-icon inactive">
                                        mdi-unfold-more-horizontal
                                    </v-icon>
                                </div>
                            </th>
                            <th class="text-end sortable" @click="onSort('total_amount')">
                                <div class="sortable-header justify-end">
                                    <span>Total</span>
                                    <v-icon v-if="sortBy === 'total_amount'" size="18" class="sort-icon active">
                                        {{ sortDirection === 'asc' ? 'mdi-arrow-up' : 'mdi-arrow-down' }}
                                    </v-icon>
                                    <v-icon v-else size="18" class="sort-icon inactive">
                                        mdi-unfold-more-horizontal
                                    </v-icon>
                                </div>
                            </th>
                            <th class="text-end sortable" @click="onSort('paid_amount')">
                                <div class="sortable-header justify-end">
                                    <span>Paid</span>
                                    <v-icon v-if="sortBy === 'paid_amount'" size="18" class="sort-icon active">
                                        {{ sortDirection === 'asc' ? 'mdi-arrow-up' : 'mdi-arrow-down' }}
                                    </v-icon>
                                    <v-icon v-else size="18" class="sort-icon inactive">
                                        mdi-unfold-more-horizontal
                                    </v-icon>
                                </div>
                            </th>
                            <th class="text-end sortable" @click="onSort('due_amount')">
                                <div class="sortable-header justify-end">
                                    <span>Due</span>
                                    <v-icon v-if="sortBy === 'due_amount'" size="18" class="sort-icon active">
                                        {{ sortDirection === 'asc' ? 'mdi-arrow-up' : 'mdi-arrow-down' }}
                                    </v-icon>
                                    <v-icon v-else size="18" class="sort-icon inactive">
                                        mdi-unfold-more-horizontal
                                    </v-icon>
                                </div>
                            </th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Skeleton Loaders -->
                        <tr v-if="loading" v-for="n in 5" :key="`skeleton-${n}`">
                            <td><v-skeleton-loader type="text" width="150"></v-skeleton-loader></td>
                            <td><v-skeleton-loader type="text" width="120"></v-skeleton-loader></td>
                            <td><v-skeleton-loader type="text" width="100"></v-skeleton-loader></td>
                            <td><v-skeleton-loader type="text" width="100"></v-skeleton-loader></td>
                            <td><v-skeleton-loader type="text" width="80"></v-skeleton-loader></td>
                            <td><v-skeleton-loader type="text" width="80"></v-skeleton-loader></td>
                            <td><v-skeleton-loader type="text" width="80"></v-skeleton-loader></td>
                            <td><v-skeleton-loader type="button" width="80" height="32"></v-skeleton-loader></td>
                        </tr>
                        <!-- Actual Report Data -->
                        <template v-else>
                            <tr v-for="item in reportData" :key="item.id || item.invoice_number">
                                <td>{{ item.party_name }}</td>
                                <td>{{ item.invoice_number }}</td>
                                <td>{{ formatDateDDMMYYYY(item.invoice_date) }}</td>
                                <td>
                                    <span :class="isOverdue(item.due_date) ? 'text-error font-weight-bold' : ''">
                                        {{ formatDateDDMMYYYY(item.due_date) }}
                                    </span>
                                </td>
                                <td class="text-end">{{ formatCurrency(item.total_amount) }}</td>
                                <td class="text-end">{{ formatCurrency(item.paid_amount) }}</td>
                                <td class="text-end">
                                    <v-chip color="error" size="small" variant="flat">
                                        {{ formatCurrency(item.due_amount || item.balance_amount) }}
                                    </v-chip>
                                </td>
                                <td>
                                    <v-btn size="small" color="success" prepend-icon="mdi-cash"
                                        @click="collectPayment(item)">
                                        Collect
                                    </v-btn>
                                </td>
                            </tr>
                            <tr v-if="reportData.length === 0">
                                <td colspan="8" class="text-center py-4">No due data found</td>
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

        <!-- Payment Collection Dialog -->
        <v-dialog v-model="paymentDialog" max-width="500px">
            <v-card v-if="selectedItem">
                <v-card-title>Collect Payment</v-card-title>
                <v-card-text>
                    <v-form ref="paymentForm">
                        <v-text-field v-model="selectedItem.party_name" label="Party" readonly />
                        <v-text-field v-model="selectedItem.invoice_number" label="Invoice" readonly />
                        <v-text-field
                            :model-value="formatCurrency(parseFloat(selectedItem.due_amount || selectedItem.balance_amount))"
                            label="Due Amount" readonly />
                        <v-text-field v-model.number="paymentAmount" type="number" label="Payment Amount *"
                            :rules="[rules.required, rules.maxDue]" />
                        <v-select v-model="paymentMethod" :items="paymentMethods" label="Payment Method *"
                            :rules="[rules.required]" />
                        <v-text-field v-model="paymentDate" type="date" label="Payment Date *"
                            :rules="[rules.required]" />
                        <v-textarea v-model="paymentNotes" label="Notes" rows="2" />
                    </v-form>
                </v-card-text>
                <v-card-actions>
                    <v-spacer />
                    <v-btn @click="paymentDialog = false">Cancel</v-btn>
                    <v-btn color="success" :loading="saving" @click="savePayment">Save Payment</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </div>
</template>

<script>
import commonMixin from '../../../../mixins/commonMixin';
import PaginationControls from '../../../common/PaginationControls.vue';
import { paginationMixin } from '../../../../utils/pagination.js';

export default {
    name: 'DueReports',
    components: {
        PaginationControls
    },
    mixins: [commonMixin, paginationMixin],
    data() {
        return {
            loading: false,
            saving: false,
            exporting: false,
            filters: {
                party_type: 'customer',
                party_id: null,
                overdue_only: false,
            },
            reportData: [],
            summary: null,
            customers: [],
            suppliers: [],
            paymentDialog: false,
            selectedItem: null,
            paymentAmount: 0,
            paymentMethod: 'cash',
            paymentDate: new Date().toISOString().split('T')[0],
            paymentNotes: '',
            partyTypes: [
                { title: 'Customer Due', value: 'customer' },
                { title: 'Supplier Due', value: 'supplier' },
            ],
            paymentMethods: [
                { title: 'Cash', value: 'cash' },
                { title: 'Card', value: 'card' },
                { title: 'Mobile Banking', value: 'mobile_banking' },
                { title: 'Bank Transfer', value: 'bank_transfer' },
                { title: 'Cheque', value: 'cheque' },
            ],
            rules: {
                required: v => !!v || 'Required',
                maxDue: v => {
                    const due = parseFloat(this.selectedItem?.due_amount || this.selectedItem?.balance_amount || 0);
                    return v <= due || `Cannot exceed due amount (${this.formatCurrency(due)})`;
                },
            },
        };
    },
    computed: {
        partyOptions() {
            return this.filters.party_type === 'customer' ? this.customers : this.suppliers;
        },
    },
    watch: {
        'filters.party_type'() {
            this.filters.party_id = null;
            this.resetPagination();
            this.generateReport();
        },
    },
    mounted() {
        this.fetchParties();
        this.generateReport();
    },
    methods: {
        async fetchParties() {
            try {
                const [customersRes, suppliersRes] = await Promise.all([
                    this.$axios.get('/api/v1/customers', {
                        headers: this.getAuthHeaders()
                    }),
                    this.$axios.get('/api/v1/suppliers', {
                        headers: this.getAuthHeaders()
                    }),
                ]);
                this.customers = customersRes.data.data || customersRes.data.customers || [];
                this.suppliers = suppliersRes.data.data || suppliersRes.data.suppliers || [];
            } catch (error) {
                console.error('Failed to fetch parties', error);
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
                if (this.filters.party_type) {
                    params.party_type = this.filters.party_type;
                }
                if (this.filters.party_id) {
                    params.party_id = this.filters.party_id;
                }
                if (this.filters.overdue_only) {
                    params.overdue_only = this.filters.overdue_only;
                }

                const response = await this.$axios.get('/api/v1/reports/due', {
                    params,
                    headers: this.getAuthHeaders()
                });
                // Handle both paginated response (data) and legacy format (due)
                this.reportData = response.data.data || response.data.due || [];
                this.summary = response.data.summary || null;
                this.updatePagination(response.data);
            } catch (error) {
                this.handleApiError(error, 'Failed to generate due report');
            } finally {
                this.loading = false;
            }
        },
        async exportExcel() {
            try {
                this.exporting = true;
                const response = await this.$axios.get('/api/v1/reports/due/export/excel', {
                    params: this.filters,
                    responseType: 'blob',
                    headers: this.getAuthHeaders()
                });
                const url = window.URL.createObjectURL(new Blob([response.data]));
                const link = document.createElement('a');
                link.href = url;
                link.setAttribute('download', `due_report_${Date.now()}.xlsx`);
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
                const response = await this.$axios.get('/api/v1/reports/due/export/pdf', {
                    params: this.filters,
                    responseType: 'blob',
                    headers: this.getAuthHeaders()
                });
                const url = window.URL.createObjectURL(new Blob([response.data]));
                const link = document.createElement('a');
                link.href = url;
                link.setAttribute('download', `due_report_${Date.now()}.pdf`);
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
        collectPayment(item) {
            this.selectedItem = item;
            this.paymentAmount = parseFloat(item.due_amount || item.balance_amount);
            this.paymentDialog = true;
        },
        async savePayment() {
            const valid = await this.$refs.paymentForm.validate();
            if (!valid.valid) return;

            this.saving = true;
            try {
                await this.$axios.post('/api/v1/payments', {
                    payment_type: this.filters.party_type === 'customer' ? 'sale' : 'purchase',
                    party_type: this.filters.party_type,
                    party_id: this.selectedItem.party_id || this.selectedItem.customer_id || this.selectedItem.supplier_id,
                    reference_type: this.filters.party_type === 'customer' ? 'sale' : 'purchase',
                    reference_id: this.selectedItem.id,
                    reference_number: this.selectedItem.invoice_number,
                    payment_date: this.paymentDate,
                    amount: this.paymentAmount,
                    payment_method: this.paymentMethod,
                    notes: this.paymentNotes,
                }, {
                    headers: this.getAuthHeaders()
                });
                this.$toast?.success('Payment recorded successfully');
                this.paymentDialog = false;
                this.generateReport();
            } catch (error) {
                this.handleApiError(error, 'Failed to record payment');
            } finally {
                this.saving = false;
            }
        },
        formatCurrency(value) {
            if (value === null || value === undefined) return '৳0.00';
            return '৳' + new Intl.NumberFormat('en-US', {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            }).format(value);
        },
        isOverdue(dueDate) {
            if (!dueDate) return false;
            return new Date(dueDate) < new Date();
        },
        onFilterChange() {
            this.resetPagination();
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
