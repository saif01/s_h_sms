<template>
    <v-dialog :model-value="modelValue" @update:model-value="$emit('update:modelValue', $event)" max-width="1000"
        scrollable>
        <v-card v-if="purchase">
            <v-card-title class="d-flex justify-space-between align-center">
                <span>Purchase Invoice Details</span>
                <v-chip :color="getStatusColor(purchase.status)" size="small">
                    {{ purchase.status }}
                </v-chip>
            </v-card-title>
            <v-card-text class="pa-0">
                <div class="pa-6">
                    <!-- Header Information -->
                    <v-row class="mb-4">
                        <v-col cols="12" md="6">
                            <div class="text-caption text-grey mb-1">Invoice Number</div>
                            <div class="text-h6 font-weight-bold">{{ purchase.invoice_number }}</div>
                        </v-col>
                        <v-col cols="12" md="6">
                            <div class="text-caption text-grey mb-1">Invoice Date</div>
                            <div class="text-body-1">{{ formatDate(purchase.invoice_date) }}</div>
                        </v-col>
                    </v-row>

                    <!-- Supplier and Warehouse -->
                    <v-row class="mb-4">
                        <v-col cols="12" md="6">
                            <div class="text-caption text-grey mb-1">Supplier</div>
                            <div class="text-body-1 font-weight-medium">{{ purchase.supplier?.name || 'N/A' }}</div>
                        </v-col>
                        <v-col cols="12" md="6">
                            <div class="text-caption text-grey mb-1">Warehouse</div>
                            <div class="text-body-1 font-weight-medium">{{ purchase.warehouse?.name || 'N/A' }}</div>
                        </v-col>
                    </v-row>

                    <!-- GRN and Due Date -->
                    <v-row class="mb-4">
                        <v-col cols="12" md="6" v-if="purchase.grn">
                            <div class="text-caption text-grey mb-1">GRN</div>
                            <div class="text-body-1">{{ purchase.grn?.grn_number || 'N/A' }}</div>
                        </v-col>
                        <v-col cols="12" md="6" v-if="purchase.due_date">
                            <div class="text-caption text-grey mb-1">Due Date</div>
                            <div class="text-body-1">{{ formatDate(purchase.due_date) }}</div>
                        </v-col>
                    </v-row>

                    <!-- Notes -->
                    <v-row class="mb-4" v-if="purchase.notes">
                        <v-col cols="12">
                            <div class="text-caption text-grey mb-1">Notes</div>
                            <div class="text-body-1">{{ purchase.notes }}</div>
                        </v-col>
                    </v-row>

                    <!-- Purchase Items -->
                    <div class="mt-4">
                        <h3 class="text-h6 mb-3">Invoice Items</h3>
                        <v-table>
                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>SKU</th>
                                    <th>Quantity</th>
                                    <th>Unit Price</th>
                                    <th>Discount</th>
                                    <th>Tax</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(item, index) in purchase.items" :key="index">
                                    <td>{{ item.product?.name || 'N/A' }}</td>
                                    <td>{{ item.product?.sku || 'N/A' }}</td>
                                    <td>{{ item.quantity }}</td>
                                    <td>{{ formatCurrency(item.unit_price) }}</td>
                                    <td>{{ formatCurrency(item.discount || 0) }}</td>
                                    <td>{{ formatCurrency(item.tax || 0) }}</td>
                                    <td class="font-weight-medium">{{ formatCurrency(item.total || 0) }}</td>
                                </tr>
                                <tr v-if="!purchase.items || purchase.items.length === 0">
                                    <td colspan="7" class="text-center py-4 text-grey">No items found</td>
                                </tr>
                            </tbody>
                        </v-table>

                        <!-- Summary -->
                        <v-row class="mt-4">
                            <v-col cols="12" md="6" offset-md="6">
                                <v-card variant="outlined">
                                    <v-card-text>
                                        <div class="d-flex justify-space-between mb-2">
                                            <span class="text-body-2">Subtotal:</span>
                                            <span class="text-body-2 font-weight-medium">{{
                                                formatCurrency(purchase.subtotal || 0) }}</span>
                                        </div>
                                        <div class="d-flex justify-space-between mb-2">
                                            <span class="text-body-2">Tax:</span>
                                            <span class="text-body-2">{{ formatCurrency(purchase.tax_amount || 0)
                                            }}</span>
                                        </div>
                                        <div class="d-flex justify-space-between mb-2">
                                            <span class="text-body-2">Shipping:</span>
                                            <span class="text-body-2">{{ formatCurrency(purchase.shipping_cost || 0)
                                            }}</span>
                                        </div>
                                        <div class="d-flex justify-space-between mb-2">
                                            <span class="text-body-2">Discount:</span>
                                            <span class="text-body-2">{{ formatCurrency(purchase.discount_amount || 0)
                                            }}</span>
                                        </div>
                                        <v-divider class="my-2"></v-divider>
                                        <div class="d-flex justify-space-between mb-2">
                                            <span class="text-h6 font-weight-bold">Total:</span>
                                            <span class="text-h6 font-weight-bold">{{
                                                formatCurrency(purchase.total_amount
                                                || 0) }}</span>
                                        </div>
                                        <div class="d-flex justify-space-between mb-2">
                                            <span class="text-body-2">Paid:</span>
                                            <span class="text-body-2">{{ formatCurrency(purchase.paid_amount || 0)
                                            }}</span>
                                        </div>
                                        <div class="d-flex justify-space-between">
                                            <span class="text-body-2 font-weight-medium">Balance:</span>
                                            <span class="text-body-2 font-weight-medium"
                                                :class="purchase.balance_amount > 0 ? 'text-warning' : 'text-success'">{{
                                                    formatCurrency(purchase.balance_amount || 0) }}</span>
                                        </div>
                                    </v-card-text>
                                </v-card>
                            </v-col>
                        </v-row>
                    </div>

                    <!-- Audit Information -->
                    <v-divider class="my-4"></v-divider>
                    <v-row class="mt-2">
                        <v-col cols="12" md="6" v-if="purchase.created_by">
                            <div class="text-caption text-grey mb-1">Created By</div>
                            <div class="text-body-2">{{ purchase.created_by?.name || 'N/A' }}</div>
                        </v-col>
                        <v-col cols="12" md="6" v-if="purchase.created_at">
                            <div class="text-caption text-grey mb-1">Created At</div>
                            <div class="text-body-2">{{ formatDateTime(purchase.created_at) }}</div>
                        </v-col>
                        <v-col cols="12" md="6" v-if="purchase.updated_by">
                            <div class="text-caption text-grey mb-1">Updated By</div>
                            <div class="text-body-2">{{ purchase.updated_by?.name || 'N/A' }}</div>
                        </v-col>
                        <v-col cols="12" md="6" v-if="purchase.updated_at">
                            <div class="text-caption text-grey mb-1">Updated At</div>
                            <div class="text-body-2">{{ formatDateTime(purchase.updated_at) }}</div>
                        </v-col>
                    </v-row>
                </div>
            </v-card-text>
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn @click="$emit('update:modelValue', false)" variant="text">Close</v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
</template>

<script>
export default {
    name: 'ViewPurchaseDialog',
    props: {
        modelValue: {
            type: Boolean,
            default: false
        },
        purchase: {
            type: Object,
            default: null
        }
    },
    emits: ['update:modelValue'],
    methods: {
        formatCurrency(value) {
            if (value === null || value === undefined) return '৳0.00';
            return '৳' + new Intl.NumberFormat('en-US', {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            }).format(value);
        },
        formatDate(date) {
            if (!date) return 'N/A';
            return new Date(date).toLocaleDateString('en-US', {
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            });
        },
        formatDateTime(dateTime) {
            if (!dateTime) return 'N/A';
            return new Date(dateTime).toLocaleString('en-US', {
                year: 'numeric',
                month: 'long',
                day: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            });
        },
        getStatusColor(status) {
            const colors = {
                'draft': 'grey',
                'pending': 'warning',
                'partial': 'info',
                'paid': 'success',
                'cancelled': 'error'
            };
            return colors[status] || 'default';
        }
    }
};
</script>
