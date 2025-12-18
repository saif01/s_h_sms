<template>
    <v-dialog :model-value="modelValue" @update:model-value="$emit('update:modelValue', $event)" max-width="1000"
        scrollable>
        <v-card v-if="order">
            <v-card-title class="d-flex justify-space-between align-center">
                <span>Purchase Order Details</span>
                <v-chip :color="getStatusColor(order.status)" size="small">
                    {{ order.status }}
                </v-chip>
            </v-card-title>
            <v-card-text class="pa-0">
                <div class="pa-6">
                    <!-- Header Information -->
                    <v-row class="mb-4">
                        <v-col cols="12" md="6">
                            <div class="text-caption text-grey mb-1">PO Number</div>
                            <div class="text-h6 font-weight-bold">{{ order.po_number }}</div>
                        </v-col>
                        <v-col cols="12" md="6">
                            <div class="text-caption text-grey mb-1">Order Date</div>
                            <div class="text-body-1">{{ formatDate(order.order_date) }}</div>
                        </v-col>
                    </v-row>

                    <!-- Supplier and Warehouse -->
                    <v-row class="mb-4">
                        <v-col cols="12" md="6">
                            <div class="text-caption text-grey mb-1">Supplier</div>
                            <div class="text-body-1 font-weight-medium">{{ order.supplier?.name || 'N/A' }}</div>
                        </v-col>
                        <v-col cols="12" md="6">
                            <div class="text-caption text-grey mb-1">Warehouse</div>
                            <div class="text-body-1 font-weight-medium">{{ order.warehouse?.name || 'N/A' }}</div>
                        </v-col>
                    </v-row>

                    <!-- Dates -->
                    <v-row class="mb-4" v-if="order.expected_delivery_date">
                        <v-col cols="12" md="6">
                            <div class="text-caption text-grey mb-1">Expected Delivery Date</div>
                            <div class="text-body-1">{{ formatDate(order.expected_delivery_date) }}</div>
                        </v-col>
                    </v-row>

                    <!-- Notes -->
                    <v-row class="mb-4" v-if="order.notes">
                        <v-col cols="12">
                            <div class="text-caption text-grey mb-1">Notes</div>
                            <div class="text-body-1">{{ order.notes }}</div>
                        </v-col>
                    </v-row>

                    <!-- Order Items -->
                    <div class="mt-4">
                        <h3 class="text-h6 mb-3">Order Items</h3>
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
                                <tr v-for="(item, index) in order.items" :key="index">
                                    <td>{{ item.product?.name || 'N/A' }}</td>
                                    <td>{{ item.product?.sku || 'N/A' }}</td>
                                    <td>{{ item.quantity }}</td>
                                    <td>{{ formatCurrency(item.unit_price) }}</td>
                                    <td>{{ formatCurrency(item.discount || 0) }}</td>
                                    <td>{{ formatCurrency(item.tax || 0) }}</td>
                                    <td class="font-weight-medium">{{ formatCurrency(item.total || 0) }}</td>
                                </tr>
                                <tr v-if="!order.items || order.items.length === 0">
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
                                                formatCurrency(order.subtotal || 0) }}</span>
                                        </div>
                                        <div class="d-flex justify-space-between mb-2">
                                            <span class="text-body-2">Tax:</span>
                                            <span class="text-body-2">{{ formatCurrency(order.tax_amount || 0) }}</span>
                                        </div>
                                        <div class="d-flex justify-space-between mb-2">
                                            <span class="text-body-2">Discount:</span>
                                            <span class="text-body-2">{{ formatCurrency(order.discount_amount || 0)
                                                }}</span>
                                        </div>
                                        <v-divider class="my-2"></v-divider>
                                        <div class="d-flex justify-space-between">
                                            <span class="text-h6 font-weight-bold">Total:</span>
                                            <span class="text-h6 font-weight-bold">{{ formatCurrency(order.total_amount
                                                || 0) }}</span>
                                        </div>
                                    </v-card-text>
                                </v-card>
                            </v-col>
                        </v-row>
                    </div>
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
    name: 'ViewPurchaseOrderDialog',
    props: {
        modelValue: {
            type: Boolean,
            default: false
        },
        order: {
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
        getStatusColor(status) {
            const colors = {
                'draft': 'grey',
                'sent': 'info',
                'confirmed': 'primary',
                'partial': 'warning',
                'completed': 'success',
                'cancelled': 'error'
            };
            return colors[status] || 'default';
        }
    }
};
</script>
