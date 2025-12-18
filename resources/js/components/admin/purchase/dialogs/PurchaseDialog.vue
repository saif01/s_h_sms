<template>
    <v-dialog :model-value="modelValue" @update:model-value="$emit('update:modelValue', $event)" max-width="1000"
        scrollable persistent>
        <v-card>
            <v-card-title>
                {{ editingPurchase ? 'Edit Purchase Invoice' : 'New Purchase Invoice' }}
            </v-card-title>
            <v-card-text class="pa-0">
                <v-form ref="form" @submit.prevent="handleSave">
                    <v-tabs v-model="activeTab" bg-color="grey-lighten-4">
                        <v-tab value="basic">Basic Information</v-tab>
                        <v-tab value="items">Items</v-tab>
                    </v-tabs>

                    <v-window v-model="activeTab">
                        <!-- Basic Information Tab -->
                        <v-window-item value="basic">
                            <div class="pa-6">
                                <v-row>
                                    <v-col cols="12" md="6">
                                        <v-select v-model="localForm.supplier_id" :items="supplierOptions"
                                            item-title="label" item-value="value" label="Supplier"
                                            :rules="[rules.required]" required></v-select>
                                    </v-col>
                                    <v-col cols="12" md="6">
                                        <v-select v-model="localForm.warehouse_id" :items="warehouseOptions"
                                            item-title="label" item-value="value" label="Warehouse"
                                            :rules="[rules.required]" required></v-select>
                                    </v-col>
                                    <v-col cols="12" md="6">
                                        <v-select v-model="localForm.grn_id" :items="grnOptions" item-title="label"
                                            item-value="value" label="GRN (Optional)" clearable></v-select>
                                    </v-col>
                                    <v-col cols="12" md="6">
                                        <v-text-field v-model="localForm.invoice_date" label="Invoice Date" type="date"
                                            :rules="[rules.required]" required></v-text-field>
                                    </v-col>
                                    <v-col cols="12" md="6">
                                        <v-text-field v-model="localForm.due_date" label="Due Date"
                                            type="date"></v-text-field>
                                    </v-col>
                                    <v-col cols="12" md="6">
                                        <v-text-field v-model.number="localForm.shipping_cost" label="Shipping Cost"
                                            type="number" min="0" step="0.01" prefix="৳"
                                            @input="calculateTotals"></v-text-field>
                                    </v-col>
                                    <v-col cols="12">
                                        <v-textarea v-model="localForm.notes" label="Notes" variant="outlined"
                                            rows="2"></v-textarea>
                                    </v-col>
                                </v-row>
                            </div>
                        </v-window-item>

                        <!-- Items Tab -->
                        <v-window-item value="items">
                            <div class="pa-6">
                                <div class="d-flex justify-space-between align-center mb-2">
                                    <h3 class="text-h6">Invoice Items</h3>
                                    <v-btn size="small" color="primary" prepend-icon="mdi-plus"
                                        @click="addPurchaseItem">Add Item</v-btn>
                                </div>
                                <v-table>
                                    <thead>
                                        <tr>
                                            <th>Product</th>
                                            <th>Quantity</th>
                                            <th>Unit Price</th>
                                            <th>Discount</th>
                                            <th>Tax</th>
                                            <th>Total</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="(item, index) in localForm.items" :key="index">
                                            <td>
                                                <v-select v-model="item.product_id" :items="productOptions"
                                                    item-title="label" item-value="value" density="compact"
                                                    @update:model-value="calculateItemTotal(index)"
                                                    :rules="[rules.required]"></v-select>
                                            </td>
                                            <td>
                                                <v-text-field v-model.number="item.quantity" type="number" min="1"
                                                    density="compact" @input="calculateItemTotal(index)"
                                                    :rules="[rules.required, rules.minValue]"></v-text-field>
                                            </td>
                                            <td>
                                                <v-text-field v-model.number="item.unit_price" type="number" min="0"
                                                    step="0.01" density="compact" @input="calculateItemTotal(index)"
                                                    :rules="[rules.required]"></v-text-field>
                                            </td>
                                            <td>
                                                <v-text-field v-model.number="item.discount" type="number" min="0"
                                                    step="0.01" density="compact"
                                                    @input="calculateItemTotal(index)"></v-text-field>
                                            </td>
                                            <td>
                                                <v-text-field v-model.number="item.tax" type="number" min="0"
                                                    step="0.01" density="compact"
                                                    @input="calculateItemTotal(index)"></v-text-field>
                                            </td>
                                            <td>{{ formatCurrency(item.total || 0) }}</td>
                                            <td>
                                                <v-btn size="small" icon="mdi-delete" variant="text" color="error"
                                                    @click="removePurchaseItem(index)"></v-btn>
                                            </td>
                                        </tr>
                                        <tr v-if="localForm.items.length === 0">
                                            <td colspan="7" class="text-center py-4 text-grey">No items added</td>
                                        </tr>
                                        <tr v-if="localForm.items.length > 0">
                                            <td colspan="5" class="text-right font-weight-bold">Subtotal:</td>
                                            <td class="font-weight-bold">{{ formatCurrency(calculatedSubtotal) }}</td>
                                            <td></td>
                                        </tr>
                                        <tr v-if="localForm.items.length > 0">
                                            <td colspan="5" class="text-right">Tax:</td>
                                            <td>{{ formatCurrency(calculatedTax) }}</td>
                                            <td></td>
                                        </tr>
                                        <tr v-if="localForm.items.length > 0">
                                            <td colspan="5" class="text-right">Shipping:</td>
                                            <td>{{ formatCurrency(localForm.shipping_cost || 0) }}</td>
                                            <td></td>
                                        </tr>
                                        <tr v-if="localForm.items.length > 0">
                                            <td colspan="5" class="text-right">Discount:</td>
                                            <td>{{ formatCurrency(calculatedDiscount) }}</td>
                                            <td></td>
                                        </tr>
                                        <tr v-if="localForm.items.length > 0">
                                            <td colspan="5" class="text-right font-weight-bold">Total:</td>
                                            <td class="font-weight-bold">{{ formatCurrency(calculatedTotal) }}</td>
                                            <td></td>
                                        </tr>
                                    </tbody>
                                </v-table>
                            </div>
                        </v-window-item>
                    </v-window>
                </v-form>
            </v-card-text>
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn @click="handleCancel" variant="text">Cancel</v-btn>
                <v-btn @click="handleSave" color="primary" :loading="saving">
                    {{ editingPurchase ? 'Update' : 'Create' }}
                </v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
</template>

<script>
export default {
    name: 'PurchaseDialog',
    props: {
        modelValue: {
            type: Boolean,
            default: false
        },
        editingPurchase: {
            type: Object,
            default: null
        },
        supplierOptions: {
            type: Array,
            default: () => []
        },
        warehouseOptions: {
            type: Array,
            default: () => []
        },
        grnOptions: {
            type: Array,
            default: () => []
        },
        productOptions: {
            type: Array,
            default: () => []
        },
        saving: {
            type: Boolean,
            default: false
        }
    },
    emits: ['update:modelValue', 'save', 'cancel'],
    data() {
        return {
            activeTab: 'basic',
            localForm: {
                supplier_id: null,
                warehouse_id: null,
                grn_id: null,
                invoice_date: new Date().toISOString().split('T')[0],
                due_date: null,
                shipping_cost: 0,
                notes: '',
                items: []
            },
            rules: {
                required: value => !!value || 'This field is required',
                minValue: value => value > 0 || 'Quantity must be greater than 0'
            }
        };
    },
    computed: {
        calculatedSubtotal() {
            return this.localForm.items.reduce((sum, item) => {
                const itemTotal = (item.quantity || 0) * (item.unit_price || 0) - (item.discount || 0);
                return sum + itemTotal;
            }, 0);
        },
        calculatedTax() {
            return this.localForm.items.reduce((sum, item) => sum + (item.tax || 0), 0);
        },
        calculatedDiscount() {
            return this.localForm.items.reduce((sum, item) => sum + (item.discount || 0), 0);
        },
        calculatedTotal() {
            return this.calculatedSubtotal + this.calculatedTax + (this.localForm.shipping_cost || 0) - this.calculatedDiscount;
        }
    },
    watch: {
        modelValue(newVal) {
            if (newVal && this.editingPurchase) {
                this.initializeForm(this.editingPurchase);
            } else if (newVal) {
                this.resetForm();
            }
        },
        editingPurchase: {
            handler(newVal) {
                if (newVal && this.modelValue) {
                    this.initializeForm(newVal);
                }
            },
            deep: true
        }
    },
    methods: {
        initializeForm(purchase) {
            this.activeTab = 'basic';
            this.localForm = {
                supplier_id: purchase.supplier_id,
                warehouse_id: purchase.warehouse_id,
                grn_id: purchase.grn_id,
                invoice_date: purchase.invoice_date,
                due_date: purchase.due_date,
                shipping_cost: purchase.shipping_cost || 0,
                notes: purchase.notes || '',
                items: purchase.items?.map(item => ({
                    product_id: item.product_id,
                    quantity: item.quantity,
                    unit_price: item.unit_price,
                    discount: item.discount || 0,
                    tax: item.tax || 0,
                    total: item.total || 0
                })) || []
            };
        },
        resetForm() {
            this.activeTab = 'basic';
            this.localForm = {
                supplier_id: null,
                warehouse_id: null,
                grn_id: null,
                invoice_date: new Date().toISOString().split('T')[0],
                due_date: null,
                shipping_cost: 0,
                notes: '',
                items: []
            };
            if (this.$refs.form) {
                this.$refs.form.resetValidation();
            }
        },
        calculateItemTotal(index) {
            const item = this.localForm.items[index];
            if (item.quantity && item.unit_price) {
                const itemTotal = (item.quantity * item.unit_price) - (item.discount || 0) + (item.tax || 0);
                this.$set(this.localForm.items[index], 'total', itemTotal);
            }
        },
        calculateTotals() {
            // Trigger recalculation
        },
        addPurchaseItem() {
            this.localForm.items.push({
                product_id: null,
                quantity: 1,
                unit_price: 0,
                discount: 0,
                tax: 0,
                total: 0
            });
        },
        removePurchaseItem(index) {
            this.localForm.items.splice(index, 1);
        },
        handleSave() {
            if (!this.$refs.form.validate()) {
                return;
            }

            if (this.localForm.items.length === 0) {
                this.$emit('save', { ...this.localForm }, 'Please add at least one item');
                return;
            }

            this.$emit('save', { ...this.localForm }, null);
        },
        handleCancel() {
            this.resetForm();
            this.$emit('cancel');
        },
        formatCurrency(value) {
            if (value === null || value === undefined) return '৳0.00';
            return '৳' + new Intl.NumberFormat('en-US', {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            }).format(value);
        }
    }
};
</script>
