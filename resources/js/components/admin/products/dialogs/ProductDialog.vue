<template>
    <v-dialog :model-value="modelValue" @update:model-value="$emit('update:modelValue', $event)" max-width="700px" persistent>
        <v-card>
            <v-card-title class="d-flex justify-space-between align-center">
                <span class="text-h6">{{ isEdit ? 'Edit Product' : 'Add Product' }}</span>
                <v-btn icon="mdi-close" variant="text" @click="close" />
            </v-card-title>
            <v-divider />
            <v-card-text>
                <v-form ref="formRef" v-model="formValid" lazy-validation>
                    <v-row dense>
                        <v-col cols="12" sm="8">
                            <v-text-field v-model="form.name" label="Product Name" :rules="[rules.required]" />
                        </v-col>
                        <v-col cols="12" sm="4">
                            <v-switch v-model="form.is_active" inset label="Active" />
                        </v-col>
                        <v-col cols="12" sm="6">
                            <v-text-field v-model="form.sku" label="SKU" />
                        </v-col>
                        <v-col cols="12" sm="6">
                            <v-text-field v-model="form.barcode" label="Barcode" />
                        </v-col>
                        <v-col cols="12" sm="6">
                            <v-text-field v-model="form.brand" label="Brand" />
                        </v-col>
                        <v-col cols="12" sm="6">
                            <v-text-field v-model="form.image" label="Image URL" />
                        </v-col>
                        <v-col cols="12" sm="6">
                            <v-select v-model="form.category_id" :items="categoryOptions" item-value="value" item-title="label"
                                label="Category" clearable />
                        </v-col>
                        <v-col cols="12" sm="6">
                            <v-select v-model="form.unit_id" :items="unitOptions" item-value="value" item-title="label"
                                label="Unit" clearable />
                        </v-col>
                        <v-col cols="12" sm="6">
                            <v-text-field v-model.number="form.purchase_price" label="Purchase Price" type="number"
                                min="0" step="0.01" :rules="[rules.required]" />
                        </v-col>
                        <v-col cols="12" sm="6">
                            <v-text-field v-model.number="form.sale_price" label="Sale Price" type="number" min="0"
                                step="0.01" :rules="[rules.required]" />
                        </v-col>
                        <v-col cols="12" sm="6">
                            <v-text-field v-model.number="form.tax_rate" label="VAT/Tax (%)" type="number" min="0"
                                step="0.01" />
                        </v-col>
                        <v-col cols="12" sm="6">
                            <v-text-field v-model.number="form.minimum_stock_level" label="Minimum Stock Alert"
                                type="number" min="0" />
                        </v-col>
                        <v-col cols="12">
                            <v-textarea v-model="form.description" label="Description" rows="2" />
                        </v-col>
                    </v-row>
                </v-form>
            </v-card-text>
            <v-divider />
            <v-card-actions class="d-flex justify-end">
                <v-btn variant="text" @click="close">Cancel</v-btn>
                <v-btn color="primary" :loading="saving" @click="save">{{ isEdit ? 'Update' : 'Save' }}</v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
</template>

<script>
import axios from '@/utils/axios.config';

export default {
    name: 'ProductDialog',
    props: {
        modelValue: { type: Boolean, required: true },
        product: { type: Object, default: null },
    },
    emits: ['update:modelValue', 'saved'],
    data() {
        return {
            form: this.getEmptyForm(),
            formValid: false,
            saving: false,
            categoryOptions: [],
            unitOptions: [],
            rules: {
                required: v => !!v || 'Required',
            },
        };
    },
    computed: {
        isEdit() {
            return !!this.form.id;
        },
    },
    watch: {
        product: {
            immediate: true,
            handler(newVal) {
                this.form = newVal ? { ...this.getEmptyForm(), ...newVal } : this.getEmptyForm();
            },
        },
    },
    created() {
        this.fetchOptions();
    },
    methods: {
        getEmptyForm() {
            return {
                id: null,
                name: '',
                sku: '',
                barcode: '',
                brand: '',
                category_id: null,
                unit_id: null,
                description: '',
                image: '',
                purchase_price: 0,
                sale_price: 0,
                tax_rate: 0,
                minimum_stock_level: 0,
                is_active: true,
            };
        },
        async fetchOptions() {
            try {
                const [categoriesRes, unitsRes] = await Promise.all([
                    axios.get('/api/v1/products/categories'),
                    axios.get('/api/v1/products/units'),
                ]);
                this.categoryOptions = categoriesRes.data.categories || [];
                this.unitOptions = unitsRes.data.units || [];
            } catch (error) {
                console.error('Failed to load options', error);
            }
        },
        close() {
            this.$emit('update:modelValue', false);
        },
        async save() {
            const valid = await this.$refs.formRef.validate();
            if (!valid) return;
            this.saving = true;
            try {
                const payload = { ...this.form };
                if (this.isEdit) {
                    await axios.put(`/api/v1/products/${this.form.id}`, payload);
                } else {
                    await axios.post('/api/v1/products', payload);
                }
                this.$emit('saved');
                this.close();
            } catch (error) {
                console.error('Failed to save product', error);
                this.$toast?.error('Failed to save product');
            } finally {
                this.saving = false;
            }
        },
    },
};
</script>
