<template>
    <div>
        <div class="page-header d-flex align-center justify-space-between mb-4">
            <h1 class="text-h4 page-title">Products</h1>
            <v-btn color="primary" prepend-icon="mdi-plus" @click="openDialog(null)">Add Product</v-btn>
        </div>

        <v-card class="mb-4">
            <v-card-text>
                <v-row dense>
                    <v-col cols="12" md="4">
                        <v-text-field v-model="search" label="Search by name, SKU, barcode"
                            prepend-inner-icon="mdi-magnify" variant="outlined" density="compact" clearable
                            @keyup.enter="loadProducts" />
                    </v-col>
                    <v-col cols="12" md="3">
                        <v-select v-model="categoryFilter" :items="categoryOptions" item-value="value"
                            item-title="label" label="Category" clearable variant="outlined" density="compact"
                            @update:model-value="loadProducts" />
                    </v-col>
                    <v-col cols="12" md="3">
                        <v-select v-model="activeFilter" :items="activeOptions" label="Status" clearable
                            variant="outlined" density="compact" @update:model-value="loadProducts" />
                    </v-col>
                </v-row>
            </v-card-text>
        </v-card>

        <v-card>
            <v-card-title class="d-flex justify-space-between align-center">
                <span>Products</span>
                <v-btn size="small" icon="mdi-refresh" variant="text" @click="loadProducts" :loading="loading" />
            </v-card-title>
            <v-divider />
            <v-card-text>
                <v-table density="compact">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>SKU</th>
                            <th>Category</th>
                            <th class="text-right">Purchase</th>
                            <th class="text-right">Sale</th>
                            <th class="text-right">Min Stock</th>
                            <th>Status</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-if="loading">
                            <td colspan="8" class="text-center text-grey">Loading...</td>
                        </tr>
                        <tr v-else-if="products.length === 0">
                            <td colspan="8" class="text-center text-grey">No products found</td>
                        </tr>
                        <tr v-for="product in products" :key="product.id">
                            <td>{{ product.name }}</td>
                            <td>{{ product.sku || '-' }}</td>
                            <td>{{ product.category?.name || '-' }}</td>
                            <td class="text-right">{{ formatCurrency(product.purchase_price) }}</td>
                            <td class="text-right">{{ formatCurrency(product.sale_price) }}</td>
                            <td class="text-right">{{ product.minimum_stock_level || 0 }}</td>
                            <td>
                                <v-chip size="small" :color="product.is_active ? 'success' : 'error'" variant="tonal">
                                    {{ product.is_active ? 'Active' : 'Inactive' }}
                                </v-chip>
                            </td>
                            <td class="text-right">
                                <v-btn icon="mdi-pencil" variant="text" size="small" @click="openDialog(product)" />
                                <v-btn icon="mdi-delete" variant="text" size="small" color="error"
                                    @click="deleteProduct(product)" />
                            </td>
                        </tr>
                    </tbody>
                </v-table>
                <v-pagination v-model="page" :length="pagination.last_page || 1" class="mt-3"
                    @update:model-value="loadProducts" />
            </v-card-text>
        </v-card>

        <product-dialog v-model="dialog" :product="editingProduct" @saved="loadProducts" />
    </div>
</template>

<script>
import axios from '@/utils/axios.config';
import ProductDialog from './dialogs/ProductDialog.vue';

export default {
    name: 'AdminProducts',
    components: { ProductDialog },
    data() {
        return {
            products: [],
            pagination: {},
            loading: false,
            page: 1,
            perPage: 10,
            search: '',
            categoryOptions: [],
            categoryFilter: null,
            activeOptions: [
                { title: 'Active', value: true },
                { title: 'Inactive', value: false },
            ],
            activeFilter: null,
            dialog: false,
            editingProduct: null,
        };
    },
    created() {
        this.loadOptions();
        this.loadProducts();
    },
    methods: {
        async loadOptions() {
            try {
                const { data } = await axios.get('/api/v1/products/categories');
                this.categoryOptions = data.categories || [];
            } catch (error) {
                console.error('Failed to load categories', error);
            }
        },
        async loadProducts() {
            try {
                this.loading = true;
                const params = {
                    page: this.page,
                    per_page: this.perPage,
                };
                if (this.search) params.search = this.search;
                if (this.categoryFilter) params.category_id = this.categoryFilter;
                if (this.activeFilter !== null) params.is_active = this.activeFilter;

                const { data } = await axios.get('/api/v1/products', { params });
                this.products = data.data || [];
                this.pagination = data;
            } catch (error) {
                console.error('Failed to load products', error);
                this.$toast?.error('Failed to load products');
            } finally {
                this.loading = false;
            }
        },
        openDialog(product) {
            this.editingProduct = product;
            this.dialog = true;
        },
        async deleteProduct(product) {
            if (!confirm(`Delete ${product.name}?`)) return;
            try {
                await axios.delete(`/api/v1/products/${product.id}`);
                this.$toast?.success('Product deleted');
                this.loadProducts();
            } catch (error) {
                console.error('Failed to delete product', error);
                this.$toast?.error(error.response?.data?.message || 'Delete failed');
            }
        },
        formatCurrency(value) {
            const number = Number(value) || 0;
            return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(number);
        },
    },
};
</script>
