<template>
    <v-dialog v-model="dialogModel" max-width="800" scrollable persistent>
        <v-card>
            <v-card-title>
                {{ editingSupplier ? 'Edit Supplier' : 'New Supplier' }}
            </v-card-title>
            <v-card-text>
                <v-form ref="form" @submit.prevent="onSave">
                    <v-tabs v-model="activeTab" bg-color="grey-lighten-4">
                        <v-tab value="basic">Basic Information</v-tab>
                        <v-tab value="contact">Contact Details</v-tab>
                        <v-tab value="financial">Financial</v-tab>
                    </v-tabs>

                    <v-window v-model="activeTab">
                        <!-- Basic Information Tab -->
                        <v-window-item value="basic">
                            <div class="pa-4">
                                <v-text-field v-model="form.name" variant="outlined" :rules="[rules.required]" required
                                    hint="Enter the supplier's full name" :error-messages="getFieldError('name')"
                                    persistent-hint @input="handleNameInput"
                                    @update:model-value="clearFieldError('name')" class="mb-4">
                                    <template v-slot:label>
                                        Name <span class="text-error">*</span>
                                    </template>
                                </v-text-field>

                                <v-text-field v-model="form.code" label="Code" variant="outlined"
                                    :rules="[rules.maxLength(255)]" :error-messages="getFieldError('code')"
                                    hint="Auto-generated from name, but can be edited. Unique identifier for the supplier"
                                    persistent-hint @update:model-value="clearFieldError('code')" class="mb-4">
                                    <template v-slot:append-inner>
                                        <v-btn icon="mdi-refresh" size="small" variant="text"
                                            @click="manualGenerateCode" title="Generate code from name"
                                            :disabled="!form.name || form.name.trim().length <= 3">
                                        </v-btn>
                                    </template>
                                </v-text-field>

                                <v-text-field v-model="form.company_name" label="Company Name" variant="outlined"
                                    :rules="[rules.maxLength(255)]" :error-messages="getFieldError('company_name')"
                                    hint="Optional: Enter the company or business name if applicable" persistent-hint
                                    @update:model-value="clearFieldError('company_name')" class="mb-4"></v-text-field>

                                <v-text-field v-model="form.tax_id" label="Tax ID" variant="outlined"
                                    :rules="[rules.maxLength(255)]" :error-messages="getFieldError('tax_id')"
                                    hint="Optional: Enter the tax identification number (TIN/VAT ID)" persistent-hint
                                    @update:model-value="clearFieldError('tax_id')" class="mb-4"></v-text-field>

                                <v-switch v-model="form.is_active" label="Active" color="success"
                                    hint="Enable to make this supplier active. Inactive suppliers won't appear in some lists"
                                    persistent-hint class="mb-4"></v-switch>
                            </div>
                        </v-window-item>

                        <!-- Contact Details Tab -->
                        <v-window-item value="contact">
                            <div class="pa-4">
                                <v-text-field v-model="form.email" label="Email" type="email" variant="outlined"
                                    :rules="[rules.email, rules.maxLength(255)]"
                                    :error-messages="getFieldError('email')"
                                    hint="Optional: Enter the supplier's email address for communication"
                                    persistent-hint @update:model-value="clearFieldError('email')"
                                    class="mb-4"></v-text-field>

                                <v-text-field v-model="form.phone" label="Phone" variant="outlined"
                                    :rules="[rules.phone, rules.maxLength(255)]"
                                    :error-messages="getFieldError('phone')"
                                    hint="Optional: Enter the landline or office phone number (e.g., 02-1234567)"
                                    persistent-hint @update:model-value="clearFieldError('phone')"
                                    class="mb-4"></v-text-field>

                                <v-text-field v-model="form.mobile" label="Mobile" variant="outlined"
                                    :rules="[rules.mobile, rules.maxLength(255)]"
                                    :error-messages="getFieldError('mobile')"
                                    hint="Optional: Enter the mobile or cell phone number (e.g., 01712345678)"
                                    persistent-hint @update:model-value="clearFieldError('mobile')"
                                    class="mb-4"></v-text-field>

                                <v-textarea v-model="form.address" label="Address" variant="outlined" rows="2"
                                    hint="Optional: Enter the complete street address" persistent-hint
                                    class="mb-4"></v-textarea>

                                <v-row>
                                    <v-col cols="12" md="6">
                                        <v-text-field v-model="form.city" label="City" variant="outlined"
                                            :rules="[rules.maxLength(255)]" hint="Optional: Enter the city name"
                                            persistent-hint></v-text-field>
                                    </v-col>
                                    <v-col cols="12" md="6">
                                        <v-text-field v-model="form.state" label="State" variant="outlined"
                                            :rules="[rules.maxLength(255)]"
                                            hint="Optional: Enter the state or province name"
                                            persistent-hint></v-text-field>
                                    </v-col>
                                </v-row>

                                <v-row>
                                    <v-col cols="12" md="6">
                                        <v-text-field v-model="form.country" label="Country" variant="outlined"
                                            :rules="[rules.maxLength(255)]" hint="Optional: Enter the country name"
                                            persistent-hint></v-text-field>
                                    </v-col>
                                    <v-col cols="12" md="6">
                                        <v-text-field v-model="form.postal_code" label="Postal Code" variant="outlined"
                                            :rules="[rules.maxLength(255)]"
                                            hint="Optional: Enter the postal code or zip code"
                                            persistent-hint></v-text-field>
                                    </v-col>
                                </v-row>
                            </div>
                        </v-window-item>

                        <!-- Financial Tab -->
                        <v-window-item value="financial">
                            <div class="pa-4">
                                <v-text-field v-model.number="form.opening_balance" label="Opening Balance"
                                    type="number" step="0.01" prefix="৳" variant="outlined"
                                    :rules="[rules.numeric, rules.minValue(0)]"
                                    :error-messages="getFieldError('opening_balance')"
                                    hint="Enter the initial balance when creating this supplier. Must be 0 or greater"
                                    persistent-hint @update:model-value="clearFieldError('opening_balance')"
                                    class="mb-4"></v-text-field>

                                <v-textarea v-model="form.notes" label="Notes" variant="outlined" rows="4"
                                    hint="Optional: Add any additional notes or comments about this supplier"
                                    persistent-hint class="mb-4"></v-textarea>
                            </div>
                        </v-window-item>
                    </v-window>
                </v-form>
            </v-card-text>
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn @click="onCancel" variant="text">Cancel</v-btn>
                <v-btn @click="onSave" color="primary" :loading="saving">
                    {{ editingSupplier ? 'Update' : 'Create' }}
                </v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
</template>

<script>
import { createValidationRules } from '../../../../utils/validationRules';

export default {
    name: 'SupplierDialog',
    props: {
        modelValue: {
            type: Boolean,
            default: false
        },
        supplier: {
            type: Object,
            default: null
        }
    },
    emits: ['update:modelValue', 'save', 'cancel'],
    data() {
        return {
            activeTab: 'basic',
            saving: false,
            backendErrors: {},
            form: {
                name: '',
                code: '',
                company_name: '',
                email: '',
                phone: '',
                mobile: '',
                address: '',
                city: '',
                state: '',
                country: '',
                postal_code: '',
                tax_id: '',
                opening_balance: 0,
                notes: '',
                is_active: true
            }
        };
    },
    computed: {
        rules() {
            return createValidationRules(this, 'name');
        },
        dialogModel: {
            get() {
                return this.modelValue;
            },
            set(value) {
                this.$emit('update:modelValue', value);
            }
        },
        editingSupplier() {
            return this.supplier !== null;
        }
    },
    watch: {
        supplier: {
            handler(newSupplier) {
                this.activeTab = 'basic';
                if (newSupplier) {
                    this.form = {
                        name: newSupplier.name || '',
                        code: newSupplier.code || '',
                        company_name: newSupplier.company_name || '',
                        email: newSupplier.email || '',
                        phone: newSupplier.phone || '',
                        mobile: newSupplier.mobile || '',
                        address: newSupplier.address || '',
                        city: newSupplier.city || '',
                        state: newSupplier.state || '',
                        country: newSupplier.country || '',
                        postal_code: newSupplier.postal_code || '',
                        tax_id: newSupplier.tax_id || '',
                        opening_balance: newSupplier.opening_balance || 0,
                        notes: newSupplier.notes || '',
                        is_active: newSupplier.is_active !== undefined ? newSupplier.is_active : true
                    };
                } else {
                    this.resetForm();
                }
            },
            immediate: true
        },
        dialogModel(newValue) {
            if (newValue && !this.editingSupplier) {
                // Generate code when dialog opens for new supplier
                this.$nextTick(() => {
                    if (!this.form.code && this.form.name) {
                        this.generateCodeFromName();
                    }
                });
            }
        },
        'form.name'(newName, oldName) {
            // Auto-generate code from name when code is empty and name length is more than 3
            // Only generate if name is being entered (not cleared) and code is empty
            if (newName && newName.trim().length > 3 && (!this.form.code || !this.form.code.trim())) {
                this.$nextTick(() => {
                    this.generateCodeFromName();
                });
            }
        },
        'form.code'(newCode) {
            // Auto-generate code if it becomes empty and name exists with length more than 3
            if (!newCode && this.form.name && this.form.name.trim().length > 3) {
                this.$nextTick(() => {
                    this.generateCodeFromName();
                });
            }
        }
    },
    methods: {
        handleNameInput() {
            // Trigger code generation when name is being typed and length is more than 3
            if (this.form.name && this.form.name.trim().length > 3 && (!this.form.code || !this.form.code.trim())) {
                this.$nextTick(() => {
                    this.generateCodeFromName();
                });
            }
        },
        generateCodeFromName(force = false) {
            if (!this.form.name || !this.form.name.trim()) {
                return; // Don't generate if name is empty
            }

            // Only generate if code is empty or just whitespace, unless forced
            if (!force && this.form.code && this.form.code.trim()) {
                return; // Don't overwrite existing code unless forced
            }

            // Extract only alphabetic characters from name (A-Z, a-z)
            const alphabetsOnly = this.form.name.replace(/[^A-Za-z]/g, '');

            if (!alphabetsOnly || alphabetsOnly.length === 0) {
                // If no alphabets found, use default
                this.form.code = 'SUP-XXX';
                return;
            }

            // Take first 3 alphabets from the name and convert to uppercase
            let code = '';
            if (alphabetsOnly.length >= 3) {
                // If name has 3 or more alphabets, take first 3
                code = alphabetsOnly.substring(0, 3).toUpperCase();
            } else {
                // If name has less than 3 alphabets, take what's available and pad with first character
                code = alphabetsOnly.toUpperCase();
                const firstChar = code[0] || 'X';
                while (code.length < 3) {
                    code += firstChar;
                }
            }

            // Add prefix SUP-
            this.form.code = `SUP-${code}`;
        },
        async generateCode() {
            // Legacy method - kept for backward compatibility
            this.generateCodeFromName();
        },
        manualGenerateCode() {
            // Manually generate code from name (force overwrite)
            if (this.form.name && this.form.name.trim().length > 3) {
                this.generateCodeFromName(true);
            }
        },
        resetForm() {
            this.form = {
                name: '',
                code: '',
                company_name: '',
                email: '',
                phone: '',
                mobile: '',
                address: '',
                city: '',
                state: '',
                country: '',
                postal_code: '',
                tax_id: '',
                opening_balance: 0,
                notes: '',
                is_active: true
            };
            this.backendErrors = {};
            if (this.$refs.form) {
                this.$refs.form.resetValidation();
            }
        },
        async onSave() {
            if (!this.$refs.form.validate()) {
                return;
            }

            // Clear previous backend errors
            this.backendErrors = {};
            this.saving = true;
            try {
                const token = localStorage.getItem('admin_token');

                // Get supplier ID from the supplier prop (editingSupplier is a boolean computed property)
                const supplierId = this.supplier?.id;
                if (this.editingSupplier && !supplierId) {
                    throw new Error('Supplier ID is missing. Cannot update supplier.');
                }

                const url = supplierId
                    ? `/api/v1/suppliers/${supplierId}`
                    : '/api/v1/suppliers';

                const method = supplierId ? 'put' : 'post';

                await this.$axios[method](url, this.form, {
                    headers: { Authorization: `Bearer ${token}` }
                });

                // Success - emit to parent
                this.$emit('save', { data: this.form, isEditing: !!supplierId });
            } catch (error) {
                // Handle backend validation errors
                if (error.response?.status === 422 && error.response?.data?.errors) {
                    this.backendErrors = error.response.data.errors;

                    // Show toast alert with validation errors
                    const errorMessages = [];
                    Object.keys(this.backendErrors).forEach(field => {
                        const fieldErrors = Array.isArray(this.backendErrors[field])
                            ? this.backendErrors[field]
                            : [this.backendErrors[field]];
                        fieldErrors.forEach(msg => {
                            errorMessages.push(`${this.formatFieldName(field)}: ${msg}`);
                        });
                    });

                    const errorMessage = errorMessages.length > 0
                        ? errorMessages.join('<br>')
                        : 'Please fix the validation errors in the form';

                    this.showError(errorMessage);

                    // Trigger validation to show errors in form fields
                    this.$nextTick(() => {
                        if (this.$refs.form) {
                            this.$refs.form.validate();
                        }
                    });
                } else {
                    // For other errors, emit to parent to handle
                    this.$emit('error', error);
                }
            } finally {
                this.saving = false;
            }
        },
        formatFieldName(fieldName) {
            // Convert snake_case to Title Case
            return fieldName
                .split('_')
                .map(word => word.charAt(0).toUpperCase() + word.slice(1))
                .join(' ');
        },
        showError(message) {
            if (window.Toast) {
                window.Toast.fire({
                    icon: 'error',
                    title: 'Validation Error',
                    html: message
                });
            } else if (window.Swal) {
                window.Swal.fire({
                    icon: 'error',
                    title: 'Validation Error',
                    html: message
                });
            } else {
                alert(message);
            }
        },
        getFieldError(fieldName) {
            if (this.backendErrors[fieldName]) {
                return Array.isArray(this.backendErrors[fieldName])
                    ? this.backendErrors[fieldName][0]
                    : this.backendErrors[fieldName];
            }
            return null;
        },
        clearFieldError(fieldName) {
            if (this.backendErrors[fieldName]) {
                delete this.backendErrors[fieldName];
                this.$forceUpdate();
            }
        },
        onCancel() {
            this.resetForm();
            this.$emit('cancel');
        }
    }
};
</script>

<style scoped>
/* Add any dialog-specific styles here */
</style>
