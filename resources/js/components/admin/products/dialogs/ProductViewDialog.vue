<template>
    <v-dialog :model-value="modelValue" @update:model-value="$emit('update:modelValue', $event)" max-width="800px"
        persistent scrollable>
        <v-card class="product-view-dialog">
            <!-- Header -->
            <v-card-title class="dialog-header d-flex justify-space-between align-center pa-3">
                <span class="text-h6 font-weight-medium">Product Details</span>
                <v-btn icon="mdi-close" variant="text" size="small" @click="close" />
            </v-card-title>
            <v-divider />
            <v-card-text class="pa-3">
                <div v-if="loading" class="text-center py-8">
                    <v-progress-circular indeterminate color="primary" size="48"></v-progress-circular>
                    <div class="mt-3 text-body-2">Loading product details...</div>
                </div>
                <div v-else-if="!product" class="text-center py-8">
                    <v-alert type="error" variant="tonal" class="ma-3" density="compact">
                        Failed to load product details
                    </v-alert>
                </div>
                <div v-else>
                    <!-- Product Image -->
                    <div v-if="product.image" class="text-center mb-3">
                        <v-img :src="product.image" max-width="200" max-height="200" class="mx-auto"
                            style="border-radius: 8px;" cover></v-img>
                    </div>

                    <!-- Basic Information Section -->
                    <v-divider class="my-3" />
                    <div class="text-subtitle-2 font-weight-medium mb-2">Basic Information</div>
                    <v-card variant="outlined" class="mb-2">
                        <v-card-text class="pa-2">
                            <v-row dense class="ma-0">
                                <v-col cols="12" sm="6" class="pa-2">
                                    <div class="info-item">
                                        <div class="text-caption text-grey mb-1">Product Name</div>
                                        <div class="text-body-2 font-weight-medium">{{ product.name || '-' }}</div>
                                    </div>
                                </v-col>
                                <v-col cols="12" sm="6" class="pa-2">
                                    <div class="info-item">
                                        <div class="text-caption text-grey mb-1">Status</div>
                                        <v-chip size="small" :color="product.is_active ? 'success' : 'error'"
                                            variant="tonal">
                                            {{ product.is_active ? 'Active' : 'Inactive' }}
                                        </v-chip>
                                    </div>
                                </v-col>
                                <v-col cols="12" sm="6" class="pa-2">
                                    <div class="info-item">
                                        <div class="text-caption text-grey mb-1">SKU</div>
                                        <div class="text-body-2">{{ product.sku || '-' }}</div>
                                    </div>
                                </v-col>
                                <v-col cols="12" sm="6" class="pa-2">
                                    <div class="info-item">
                                        <div class="text-caption text-grey mb-1">Barcode</div>
                                        <div class="text-body-2">{{ product.barcode || '-' }}</div>
                                    </div>
                                </v-col>
                                <v-col cols="12" sm="6" class="pa-2">
                                    <div class="info-item">
                                        <div class="text-caption text-grey mb-1">Brand</div>
                                        <div class="text-body-2">{{ product.brand || '-' }}</div>
                                    </div>
                                </v-col>
                                <v-col cols="12" sm="6" class="pa-2">
                                    <div class="info-item">
                                        <div class="text-caption text-grey mb-1">Category</div>
                                        <div class="text-body-2">{{ product.category?.name || '-' }}</div>
                                    </div>
                                </v-col>
                                <v-col cols="12" sm="6" class="pa-2">
                                    <div class="info-item">
                                        <div class="text-caption text-grey mb-1">Unit</div>
                                        <div class="text-body-2">{{ product.unit?.name || '-' }}</div>
                                    </div>
                                </v-col>
                                <v-col cols="12" class="pa-2">
                                    <div class="info-item">
                                        <div class="text-caption text-grey mb-1">Description</div>
                                        <div class="text-body-2">{{ product.description || '-' }}</div>
                                    </div>
                                </v-col>
                            </v-row>
                        </v-card-text>
                    </v-card>

                    <!-- Pricing Information Section -->
                    <v-divider class="my-3" />
                    <div class="text-subtitle-2 font-weight-medium mb-2">Pricing Information</div>
                    <v-card variant="outlined" class="mb-2">
                        <v-card-text class="pa-2">
                            <v-row dense class="ma-0">
                                <v-col cols="12" sm="4" class="pa-2">
                                    <div class="info-item">
                                        <div class="text-caption text-grey mb-1">Purchase Price</div>
                                        <div class="text-body-2 font-weight-medium">
                                            ৳{{ parseFloat(product.purchase_price || 0).toFixed(2) }}
                                        </div>
                                    </div>
                                </v-col>
                                <v-col cols="12" sm="4" class="pa-2">
                                    <div class="info-item">
                                        <div class="text-caption text-grey mb-1">Sale Price</div>
                                        <div class="text-body-2 font-weight-medium">
                                            ৳{{ parseFloat(product.sale_price || 0).toFixed(2) }}
                                        </div>
                                    </div>
                                </v-col>
                                <v-col cols="12" sm="4" class="pa-2">
                                    <div class="info-item">
                                        <div class="text-caption text-grey mb-1">VAT/Tax Rate</div>
                                        <div class="text-body-2">{{ parseFloat(product.tax_rate || 0).toFixed(2) }}%</div>
                                    </div>
                                </v-col>
                            </v-row>
                        </v-card-text>
                    </v-card>

                    <!-- Stock Information Section -->
                    <v-divider class="my-3" />
                    <div class="text-subtitle-2 font-weight-medium mb-2">Stock Information</div>
                    <v-card variant="outlined" class="mb-2">
                        <v-card-text class="pa-2">
                            <v-row dense class="ma-0">
                                <v-col cols="12" sm="6" class="pa-2">
                                    <div class="info-item">
                                        <div class="text-caption text-grey mb-1">Total Stock</div>
                                        <v-chip size="small" :color="getStockStatusColor(totalStock)"
                                            variant="tonal" class="font-weight-medium">
                                            {{ totalStock }}
                                        </v-chip>
                                    </div>
                                </v-col>
                                <v-col cols="12" sm="6" class="pa-2">
                                    <div class="info-item">
                                        <div class="text-caption text-grey mb-1">Minimum Stock Alert</div>
                                        <div class="text-body-2">{{ product.minimum_stock_level || 0 }}</div>
                                    </div>
                                </v-col>
                            </v-row>
                        </v-card-text>
                    </v-card>

                    <!-- Stock by Warehouse -->
                    <v-divider class="my-3" />
                    <div class="text-subtitle-2 font-weight-medium mb-2">Stock by Warehouse</div>
                    <v-card variant="outlined" class="mb-2">
                        <v-card-text class="pa-2">
                            <div v-if="product.stock_by_warehouse && product.stock_by_warehouse.length > 0">
                                <v-table density="compact">
                                    <thead>
                                        <tr>
                                            <th>Warehouse</th>
                                            <th class="text-end">Quantity</th>
                                            <th class="text-end">Avg Cost</th>
                                            <th class="text-end">Total Value</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="stock in product.stock_by_warehouse" :key="stock.warehouse_id">
                                            <td>
                                                <span class="font-weight-medium">{{ stock.warehouse_name }}</span>
                                                <span v-if="stock.warehouse_code" class="text-caption text-grey ml-1">
                                                    ({{ stock.warehouse_code }})
                                                </span>
                                            </td>
                                            <td class="text-end">
                                                <v-chip size="small" :color="getStockStatusColor(stock.quantity)"
                                                    variant="tonal">
                                                    {{ stock.quantity || 0 }}
                                                </v-chip>
                                            </td>
                                            <td class="text-end">৳{{ parseFloat(stock.average_cost || 0).toFixed(2) }}
                                            </td>
                                            <td class="text-end">৳{{ parseFloat(stock.total_value || 0).toFixed(2) }}
                                            </td>
                                        </tr>
                                    </tbody>
                                </v-table>
                            </div>
                            <div v-else class="text-center text-grey py-2">
                                <span class="text-caption">No stock information available</span>
                            </div>
                        </v-card-text>
                    </v-card>
                </div>
            </v-card-text>
            <v-divider />
            <v-card-actions class="pa-2 justify-end">
                <v-btn variant="text" size="small" @click="close">Close</v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
</template>

<script>
import axios from '@/utils/axios.config';

export default {
    name: 'ProductViewDialog',
    props: {
        modelValue: { type: Boolean, required: true },
        product: { type: Object, default: null },
    },
    emits: ['update:modelValue'],
    data() {
        return {
            loading: false,
            productData: null,
        };
    },
    computed: {
        product() {
            return this.productData || this.product;
        },
        totalStock() {
            if (!this.product?.stock_by_warehouse || this.product.stock_by_warehouse.length === 0) {
                return 0;
            }
            return this.product.stock_by_warehouse.reduce((sum, stock) => sum + (parseFloat(stock.quantity) || 0), 0);
        },
    },
    watch: {
        modelValue(newVal) {
            if (newVal && this.product && this.product.id) {
                this.loadProductDetails();
            } else {
                this.productData = null;
            }
        },
        product: {
            immediate: true,
            handler(newVal) {
                if (newVal && newVal.id) {
                    this.loadProductDetails();
                } else {
                    this.productData = null;
                }
            },
        },
    },
    methods: {
        async loadProductDetails() {
            if (!this.product?.id) return;

            this.loading = true;
            try {
                const response = await axios.get(`/api/v1/products/${this.product.id}`);
                this.productData = response.data;
            } catch (error) {
                console.error('Failed to load product details', error);
                this.$toast?.error('Failed to load product details');
            } finally {
                this.loading = false;
            }
        },
        getStockStatusColor(quantity) {
            if (!this.product?.minimum_stock_level) return 'default';
            if (quantity <= 0) return 'error';
            if (quantity <= this.product.minimum_stock_level) return 'warning';
            return 'success';
        },
        close() {
            this.$emit('update:modelValue', false);
        },
    },
};
</script>

<style scoped>
.product-view-dialog {
    max-height: 90vh;
}

.dialog-header {
    background-color: rgba(0, 0, 0, 0.02);
}

.info-item {
    min-height: 40px;
    display: flex;
    flex-direction: column;
    justify-content: center;
}
</style>

