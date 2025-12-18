<template>
    <v-dialog :model-value="modelValue" @update:model-value="$emit('update:modelValue', $event)" max-width="600"
        scrollable persistent>
        <v-card>
            <v-card-title>
                {{ editingRequest ? 'Edit Purchase Request' : 'New Purchase Request' }}
            </v-card-title>
            <v-card-text>
                <v-form ref="form" @submit.prevent="handleSave">
                    <v-select v-model="localForm.warehouse_id" :items="warehouseOptions" item-title="label"
                        item-value="value" label="Warehouse" :rules="[rules.required]" required class="mb-4"></v-select>

                    <DatePicker v-model="localForm.request_date" label="Request Date" :rules="[rules.required]" required
                        class="mb-4" density="compact" />

                    <v-textarea v-model="localForm.notes" label="Notes" rows="3" class="mb-4"></v-textarea>
                </v-form>
            </v-card-text>
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn @click="handleCancel" variant="text">Cancel</v-btn>
                <v-btn @click="handleSave" color="primary" :loading="saving">
                    {{ editingRequest ? 'Update' : 'Create' }}
                </v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
</template>

<script>
import DatePicker from '../../../common/DatePicker.vue';

export default {
    name: 'PurchaseRequestDialog',
    components: {
        DatePicker
    },
    props: {
        modelValue: {
            type: Boolean,
            default: false
        },
        editingRequest: {
            type: Object,
            default: null
        },
        warehouseOptions: {
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
            localForm: {
                warehouse_id: null,
                request_date: new Date().toISOString().split('T')[0],
                notes: ''
            },
            rules: {
                required: value => !!value || 'This field is required'
            }
        };
    },
    watch: {
        modelValue(newVal) {
            if (newVal && this.editingRequest) {
                this.initializeForm(this.editingRequest);
            } else if (newVal) {
                this.resetForm();
            }
        },
        editingRequest: {
            handler(newVal) {
                if (newVal && this.modelValue) {
                    this.initializeForm(newVal);
                }
            },
            deep: true
        }
    },
    methods: {
        initializeForm(request) {
            // Extract date part only (YYYY-MM-DD) if it comes with time
            let requestDate = request.request_date;
            if (requestDate && typeof requestDate === 'string' && requestDate.includes('T')) {
                requestDate = requestDate.split('T')[0];
            } else if (requestDate instanceof Date) {
                // Convert Date object to YYYY-MM-DD string
                const year = requestDate.getFullYear();
                const month = String(requestDate.getMonth() + 1).padStart(2, '0');
                const day = String(requestDate.getDate()).padStart(2, '0');
                requestDate = `${year}-${month}-${day}`;
            }

            this.localForm = {
                warehouse_id: request.warehouse_id,
                request_date: requestDate,
                notes: request.notes || ''
            };
        },
        resetForm() {
            this.localForm = {
                warehouse_id: null,
                request_date: new Date().toISOString().split('T')[0],
                notes: ''
            };
            if (this.$refs.form) {
                this.$refs.form.resetValidation();
            }
        },
        handleSave() {
            if (!this.$refs.form.validate()) {
                return;
            }
            this.$emit('save', { ...this.localForm });
        },
        handleCancel() {
            this.resetForm();
            this.$emit('cancel');
        }
    }
};
</script>
