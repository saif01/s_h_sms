<template>
    <div>
        <div class="page-header">
            <h1 class="text-h4 page-title">Products</h1>
            <v-btn color="primary" prepend-icon="mdi-plus" @click="openDialog(null)" class="add-button">
                Add Product
            </v-btn>
        </div>

        <!-- Search and Filter -->
        <v-card class="mb-4">
            <v-card-text>
                <v-row>
                    <v-col cols="12" md="3">
                        <v-select v-model="pagination.per_page" :items="perPageOptions" label="Items per page"
                            prepend-inner-icon="mdi-format-list-numbered" variant="outlined" density="compact"
                            @update:model-value="onPerPageChange"></v-select>
                    </v-col>

                    <v-col cols="12" md="2">
                        <v-select v-model="categoryFilter" :items="categoryOptions" item-value="value"
                            item-title="label" label="Category" clearable variant="outlined" density="compact"
                            @update:model-value="onFilterChange" />
                    </v-col>
                    <v-col cols="12" md="3">
                        <v-select v-model="activeFilter" :items="activeOptions" label="Status" clearable
                            variant="outlined" density="compact" @update:model-value="onFilterChange" />
                    </v-col>
                    <v-col cols="12" md="4">
                        <v-text-field v-model="search" label="Search by name, SKU, barcode"
                            prepend-inner-icon="mdi-magnify" variant="outlined" density="compact" clearable
                            @keyup.enter="loadProducts" @update:model-value="onSearchChange" />
                    </v-col>
                </v-row>
            </v-card-text>
        </v-card>

        <!-- Products List -->
        <v-card>
            <v-card-title class="d-flex justify-space-between align-center">
                <span>Products</span>
                <span class="text-caption text-grey">
                    Total Records: <strong>{{ pagination.total || 0 }}</strong>
                    <span v-if="products.length > 0">
                        | Showing {{ ((pagination.current_page - 1) * pagination.per_page) + 1 }} to
                        {{ Math.min(pagination.current_page * pagination.per_page, pagination.total) }} of
                        {{ pagination.total }}
                    </span>
                </span>
            </v-card-title>
            <v-card-text>
                <div v-if="loading" class="text-center py-4">
                    <v-progress-circular indeterminate color="primary"></v-progress-circular>
                </div>
                <v-table v-else>
                    <thead>
                        <tr>
                            <th class="sortable" @click="sortBy('name')">
                                <div class="sortable-header">
                                    <span>Name</span>
                                    <v-icon v-if="isSortingBy('name')" size="18" class="sort-icon active">
                                        {{ getSortDirection('name') === 'asc' ? 'mdi-arrow-up' : 'mdi-arrow-down' }}
                                    </v-icon>
                                    <v-icon v-else size="18" class="sort-icon inactive">
                                        mdi-unfold-more-horizontal
                                    </v-icon>
                                </div>
                            </th>
                            <th class="sortable" @click="sortBy('sku')">
                                <div class="sortable-header">
                                    <span>SKU</span>
                                    <v-icon v-if="isSortingBy('sku')" size="18" class="sort-icon active">
                                        {{ getSortDirection('sku') === 'asc' ? 'mdi-arrow-up' : 'mdi-arrow-down' }}
                                    </v-icon>
                                    <v-icon v-else size="18" class="sort-icon inactive">
                                        mdi-unfold-more-horizontal
                                    </v-icon>
                                </div>
                            </th>
                            <th>Category</th>
                            <th class="text-end sortable" @click="sortBy('purchase_price')">
                                <div class="sortable-header justify-end">
                                    <span>Purchase</span>
                                    <v-icon v-if="isSortingBy('purchase_price')" size="18" class="sort-icon active">
                                        {{ getSortDirection('purchase_price') === 'asc' ? 'mdi-arrow-up' :
                                            'mdi-arrow-down' }}
                                    </v-icon>
                                    <v-icon v-else size="18" class="sort-icon inactive">
                                        mdi-unfold-more-horizontal
                                    </v-icon>
                                </div>
                            </th>
                            <th class="text-end sortable" @click="sortBy('sale_price')">
                                <div class="sortable-header justify-end">
                                    <span>Sale</span>
                                    <v-icon v-if="isSortingBy('sale_price')" size="18" class="sort-icon active">
                                        {{ getSortDirection('sale_price') === 'asc' ? 'mdi-arrow-up' : 'mdi-arrow-down'
                                        }}
                                    </v-icon>
                                    <v-icon v-else size="18" class="sort-icon inactive">
                                        mdi-unfold-more-horizontal
                                    </v-icon>
                                </div>
                            </th>
                            <th class="text-end">Total Stock</th>
                            <th class="text-end sortable" @click="sortBy('minimum_stock_level')">
                                <div class="sortable-header justify-end">
                                    <span>Min Stock</span>
                                    <v-icon v-if="isSortingBy('minimum_stock_level')" size="18"
                                        class="sort-icon active">
                                        {{ getSortDirection('minimum_stock_level') === 'asc' ? 'mdi-arrow-up' :
                                            'mdi-arrow-down' }}
                                    </v-icon>
                                    <v-icon v-else size="18" class="sort-icon inactive">
                                        mdi-unfold-more-horizontal
                                    </v-icon>
                                </div>
                            </th>
                            <th class="sortable" @click="sortBy('is_active')">
                                <div class="sortable-header">
                                    <span>Status</span>
                                    <v-icon v-if="isSortingBy('is_active')" size="18" class="sort-icon active">
                                        {{ getSortDirection('is_active') === 'asc' ? 'mdi-arrow-up' : 'mdi-arrow-down'
                                        }}
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
                        <tr v-for="product in products" :key="product.id">
                            <td>
                                <span class="font-weight-medium">{{ product.name }}</span>
                            </td>
                            <td>{{ product.sku || '-' }}</td>
                            <td>{{ product.category?.name || '-' }}</td>
                            <td class="text-end">৳{{ parseFloat(product.purchase_price || 0).toFixed(2) }}</td>
                            <td class="text-end">৳{{ parseFloat(product.sale_price || 0).toFixed(2) }}</td>
                            <td class="text-end">
                                <v-chip size="small" :color="getStockStatusColor(product)" variant="tonal">
                                    {{ product.stock_quantity || 0 }}
                                </v-chip>
                                <v-tooltip v-if="product.stock_by_warehouse && product.stock_by_warehouse.length > 0"
                                    activator="parent" location="top">
                                    <div class="text-caption">
                                        <div v-for="stock in product.stock_by_warehouse" :key="stock.warehouse_id"
                                            class="py-1">
                                            <strong>{{ stock.warehouse_name }}:</strong> {{ stock.quantity || 0 }}
                                        </div>
                                    </div>
                                </v-tooltip>
                            </td>
                            <td class="text-end">{{ product.minimum_stock_level || 0 }}</td>
                            <td>
                                <v-chip size="small" :color="product.is_active ? 'success' : 'error'" variant="tonal">
                                    {{ product.is_active ? 'Active' : 'Inactive' }}
                                </v-chip>
                            </td>
                            <td>
                                <v-btn icon="mdi-pencil" variant="text" size="small" @click="openDialog(product)" />
                                <v-btn icon="mdi-delete" variant="text" size="small" color="error"
                                    @click="deleteProduct(product)" />
                            </td>
                        </tr>
                        <tr v-if="products.length === 0">
                            <td colspan="9" class="text-center py-4">No products found</td>
                        </tr>
                    </tbody>
                </v-table>

                <!-- Pagination and Records Info -->
                <div
                    class="d-flex flex-column flex-md-row justify-space-between align-center align-md-start gap-3 mt-4">
                    <div class="text-caption text-grey">
                        <span v-if="products.length > 0 && pagination.total > 0">
                            Showing <strong>{{ ((pagination.current_page - 1) * pagination.per_page) + 1 }}</strong> to
                            <strong>{{ Math.min(pagination.current_page * pagination.per_page, pagination.total)
                            }}</strong> of
                            <strong>{{ pagination.total.toLocaleString() }}</strong> records
                            <span v-if="pagination.last_page > 1" class="ml-2">
                                (Page {{ pagination.current_page }} of {{ pagination.last_page }})
                            </span>
                        </span>
                        <span v-else>
                            No records found
                        </span>
                    </div>
                    <div v-if="pagination.last_page > 1" class="d-flex align-center gap-2">
                        <v-pagination v-model="pagination.current_page" :length="pagination.last_page"
                            :total-visible="7" density="comfortable" @update:model-value="loadProducts">
                        </v-pagination>
                    </div>
                </div>
            </v-card-text>
        </v-card>

        <product-dialog v-model="dialog" :product="editingProduct" @saved="loadProducts" />
    </div>
</template>

<script>
import axios from '@/utils/axios.config';
import ProductDialog from './dialogs/ProductDialog.vue';
import { sortingMixin } from '@/composables/useSorting';

export default {
    name: 'AdminProducts',
    components: { ProductDialog },
    mixins: [sortingMixin],
    data() {
        return {
            products: [],
            loading: false,
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
            pagination: {
                current_page: 1,
                per_page: 15,
                last_page: 1,
                total: 0,
            },
            perPageOptions: [
                { title: '10', value: 10 },
                { title: '15', value: 15 },
                { title: '25', value: 25 },
                { title: '50', value: 50 },
                { title: '100', value: 100 },
            ],
        };
    },
    mounted() {
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
            this.loading = true;
            try {
                const params = {
                    page: this.pagination.current_page,
                    per_page: this.pagination.per_page,
                    ...this.getSortParams(), // Use centralized sort params
                };
                if (this.search) params.search = this.search;
                if (this.categoryFilter) params.category_id = this.categoryFilter;
                if (this.activeFilter !== null) params.is_active = this.activeFilter;

                const { data } = await axios.get('/api/v1/products', { params });
                this.products = data.data || [];
                this.pagination = {
                    current_page: data.current_page || 1,
                    per_page: data.per_page || 15,
                    last_page: data.last_page || 1,
                    total: data.total || 0,
                };
            } catch (error) {
                console.error('Failed to load products', error);
                this.showError('Failed to load products');
            } finally {
                this.loading = false;
            }
        },
        // sortBy method is provided by sortingMixin
        // Override onSortChange to handle pagination reset
        onSortChange() {
            // Reset to first page when sorting changes
            this.pagination.current_page = 1;
            this.loadProducts();
        },
        openDialog(product) {
            this.editingProduct = product;
            this.dialog = true;
        },
        async deleteProduct(product) {
            const result = await window.Swal.fire({
                title: 'Are you sure?',
                text: `Do you want to delete product ${product.name}?`,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6',
                confirmButtonText: 'Yes, delete it!',
                cancelButtonText: 'Cancel'
            });

            if (result.isConfirmed) {
                try {
                    await axios.delete(`/api/v1/products/${product.id}`);
                    this.showSuccess('Product deleted successfully');
                    this.loadProducts();
                } catch (error) {
                    console.error('Failed to delete product', error);
                    this.showError(error.response?.data?.message || 'Failed to delete product');
                }
            }
        },
        onPerPageChange() {
            this.pagination.current_page = 1;
            this.loadProducts();
        },
        resetFilters() {
            this.search = '';
            this.categoryFilter = null;
            this.activeFilter = null;
            this.pagination.current_page = 1;
            this.loadProducts();
        },
        onSearchChange() {
            // Reset to first page when search changes
            this.pagination.current_page = 1;
            this.loadProducts();
        },
        onFilterChange() {
            // Reset to first page when filters change
            this.pagination.current_page = 1;
            this.loadProducts();
        },
        showSuccess(message) {
            if (window.Toast) {
                window.Toast.fire({
                    icon: 'success',
                    title: message
                });
            } else if (window.Swal) {
                window.Swal.fire({
                    icon: 'success',
                    title: message,
                    timer: 2000,
                    showConfirmButton: false
                });
            } else {
                alert(message);
            }
        },
        showError(message) {
            if (window.Toast) {
                window.Toast.fire({
                    icon: 'error',
                    title: message
                });
            } else if (window.Swal) {
                window.Swal.fire({
                    icon: 'error',
                    title: message
                });
            } else {
                alert(message);
            }
        },
        getStockStatusColor(product) {
            const stockQty = product.stock_quantity || 0;
            const minStock = product.minimum_stock_level || 0;
            if (stockQty <= 0) return 'error';
            if (minStock > 0 && stockQty <= minStock) return 'warning';
            return 'success';
        },
    },
};
</script>

<style scoped>
.page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 24px;
}

.page-title {
    margin: 0;
}

.sortable {
    cursor: pointer;
    user-select: none;
    transition: background-color 0.2s;
    position: relative;
}

.sortable:hover {
    background-color: rgba(0, 0, 0, 0.04);
}

/* Ensure icons are visible on table header */
:deep(.v-table thead th) {
    background-color: rgba(var(--v-theme-surface), 1);
}

:deep(.v-table thead th.sortable) {
    background-color: rgba(var(--v-theme-surface), 1);
}

:deep(.v-table thead th.sortable:hover) {
    background-color: rgba(0, 0, 0, 0.04);
}

.sortable-header {
    display: flex;
    align-items: center;
    gap: 6px;
    justify-content: flex-start;
    width: 100%;
}

.sortable-header.justify-end {
    justify-content: flex-end;
}

.sort-icon {
    flex-shrink: 0;
    transition: opacity 0.2s, color 0.2s;
    display: inline-flex !important;
    visibility: visible !important;
    opacity: 1 !important;
    font-size: 18px !important;
    width: 18px !important;
    height: 18px !important;
    line-height: 1 !important;
}

.sort-icon.active {
    opacity: 1 !important;
    color: rgb(var(--v-theme-primary)) !important;
    visibility: visible !important;
}

/* Ensure active icon is visible on any background */
.sort-icon.active :deep(svg),
.sort-icon.active :deep(path) {
    fill: currentColor !important;
    color: rgb(var(--v-theme-primary)) !important;
    opacity: 1 !important;
}

.sort-icon.inactive {
    opacity: 0.7 !important;
    color: #424242 !important;
    visibility: visible !important;
}

/* Ensure inactive icon is visible on table header background */
.sort-icon.inactive :deep(svg),
.sort-icon.inactive :deep(path) {
    fill: #424242 !important;
    color: #424242 !important;
    opacity: 0.7 !important;
}

.sortable:hover .sort-icon.inactive {
    opacity: 1 !important;
    color: #212121 !important;
}

.sortable:hover .sort-icon.inactive :deep(svg),
.sortable:hover .sort-icon.inactive :deep(path) {
    fill: #212121 !important;
    color: #212121 !important;
    opacity: 1 !important;
}
</style>

<style>
/* Non-scoped styles for add button - ensures it works across all scenarios */
.page-header .add-button {
    visibility: visible !important;
    opacity: 1 !important;
    display: inline-flex !important;
}

.page-header .add-button .v-btn__content {
    visibility: visible !important;
    opacity: 1 !important;
    display: inline-flex !important;
    align-items: center !important;
}

.page-header .add-button .v-btn__prepend {
    visibility: visible !important;
    opacity: 1 !important;
    display: inline-flex !important;
    margin-inline-end: 8px !important;
}

.page-header .add-button .v-icon {
    visibility: visible !important;
    opacity: 1 !important;
    display: inline-flex !important;
    font-size: 20px !important;
}
</style>
