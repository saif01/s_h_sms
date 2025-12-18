<template>
    <v-dialog :model-value="modelValue" @update:model-value="$emit('update:modelValue', $event)" max-width="900"
        scrollable persistent>
        <v-card>
            <v-card-title>
                {{ editingReturn ? 'Edit Purchase Return' : 'New Purchase Return' }}
            </v-card-title>
            <v-card-text class="pa-0">
                <v-form ref="form" @submit.prevent="handleSave">
                    <div class="pa-6">
                        <v-row>
                            <v-col cols="12" md="6">
                                <v-select v-model="localForm.purchase_id" :items="purchaseOptions" item-title="label"
                                    item-value="value" label="Purchase Invoice" :rules="[rules.required]" required
                                    @update:model-value="loadPurchaseItems"></v-select>
                            </v-col>
                            <v-col cols="12" md="6">
                                <v-text-field v-model="localForm.return_date" label="Return Date" type="date"
                                    :rules="[rules.required]" required></v-text-field>
                            </v-col>
                            <v-col cols="12" md="6">
                                <v-select v-model="localForm.reason" :items="reasonOptions" item-title="title"
                                    item-value="value" label="Reason"></v-select>
                            </v-col>
                            <v-col cols="12">
                                <v-textarea v-model="localForm.notes" label="Notes" variant="outlined"
                                    rows="2"></v-textarea>
                            </v-col>
                        </v-row>

                        <!-- Return Items -->
                        <div class="mt-4">
                            <div class="d-flex justify-space-between align-center mb-2">
                                <h3 class="text-h6">Return Items</h3>
                            </div>
                            <v-table>
                                <thead>
                                    <tr>
                                        <th>Product</th>
                                        <th>Quantity</th>
                                        <th>Unit Price</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="(item, index) in localForm.items" :key="index">
                                        <td>{{ item.product?.name || 'Loading...' }}</td>
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
                                        <td>{{ formatCurrency(item.total || 0) }}</td>
                                    </tr>
                                    <tr v-if="localForm.items.length === 0">
                                        <td colspan="4" class="text-center py-4 text-grey">Select a purchase invoice to
                                            load items</td>
                                    </tr>
                                    <tr v-if="localForm.items.length > 0">
                                        <td colspan="3" class="text-right font-weight-bold">Total:</td>
                                        <td class="font-weight-bold">{{ formatCurrency(calculatedTotal) }}</td>
                                    </tr>
                                </tbody>
                            </v-table>
                        </div>
                    </div>
                </v-form>
            </v-card-text>
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn @click="handleCancel" variant="text">Cancel</v-btn>
                <v-btn @click="handleSave" color="primary" :loading="saving">
                    {{ editingReturn ? 'Update' : 'Create' }}
                </v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
</template>

<script>
export default {
    name: 'PurchaseReturnDialog',
    props: {
        modelValue: {
            type: Boolean,
            default: false
        },
        editingReturn: {
            type: Object,
            default: null
        },
        purchaseOptions: {
            type: Array,
            default: () => []
        },
        reasonOptions: {
            type: Array,
            default: () => [
                { title: 'Defective', value: 'defective' },
                { title: 'Wrong Item', value: 'wrong_item' },
                { title: 'Damaged', value: 'damaged' },
                { title: 'Other', value: 'other' }
            ]
        },
        saving: {
            type: Boolean,
            default: false
        }
    },
    emits: ['update:modelValue', 'save', 'cancel', 'load-purchase-items'],
    data() {
        return {
            localForm: {
                purchase_id: null,
                return_date: new Date().toISOString().split('T')[0],
                reason: 'other',
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
        calculatedTotal() {
            return this.localForm.items.reduce((sum, item) => sum + (item.total || 0), 0);
        }
    },
    watch: {
        modelValue(newVal) {
            if (newVal && this.editingReturn) {
                this.initializeForm(this.editingReturn);
            } else if (newVal) {
                this.resetForm();
            }
        },
        editingReturn: {
            handler(newVal) {
                if (newVal && this.modelValue) {
                    this.initializeForm(newVal);
                }
            },
            deep: true
        }
    },
    methods: {
        initializeForm(returnItem) {
            this.localForm = {
                purchase_id: returnItem.purchase_id,
                return_date: returnItem.return_date,
                reason: returnItem.reason || 'other',
                notes: returnItem.notes || '',
                items: returnItem.items?.map(item => ({
                    product_id: item.product_id,
                    product: item.product,
                    quantity: item.quantity,
                    unit_price: item.unit_price,
                    total: item.total || 0
                })) || []
            };
        },
        resetForm() {
            this.localForm = {
                purchase_id: null,
                return_date: new Date().toISOString().split('T')[0],
                reason: 'other',
                notes: '',
                items: []
            };
            if (this.$refs.form) {
                this.$refs.form.resetValidation();
            }
        },
        loadPurchaseItems() {
            this.$emit('load-purchase-items', this.localForm.purchase_id);
        },
        calculateItemTotal(index) {
            const item = this.localForm.items[index];
            if (item.quantity && item.unit_price) {
                const itemTotal = item.quantity * item.unit_price;
                this.$set(this.localForm.items[index], 'total', itemTotal);
            }
        },
        handleSave() {
            if (!this.$refs.form.validate()) {
                return;
            }

            if (this.localForm.items.length === 0) {
                this.$emit('save', { ...this.localForm }, 'Please select a purchase invoice with items');
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
        },
        setItems(items) {
            this.localForm.items = items;
        }
    }
};
</script>
