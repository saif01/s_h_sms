<template>
    <v-dialog :model-value="modelValue" @update:model-value="$emit('update:modelValue', $event)" max-width="600" persistent>
        <v-card>
            <v-card-title>
                {{ editingPermission ? 'Edit Permission' : 'Add New Permission' }}
            </v-card-title>
            <v-card-text>
                <v-form ref="permissionForm" @submit.prevent="onSave">
                    <v-text-field v-model="form.name" label="Permission Name" :rules="[rules.required]" required
                        hint="Display name for the permission (e.g., 'Manage Pages')" persistent-hint class="mb-4"
                        @blur="autoGenerateSlugFromName"></v-text-field>

                    <v-text-field v-model="form.slug" label="Slug"
                        hint="URL-friendly identifier (auto-generated if empty)" persistent-hint
                        class="mb-4"></v-text-field>

                    <v-select v-model="form.group" :items="groups"
                        :item-title="item => typeof item === 'string' ? item : item.name"
                        :item-value="item => typeof item === 'string' ? item : item.name" label="Group"
                        :rules="[rules.required]" required hint="Category/group for organizing permissions"
                        persistent-hint class="mb-4">
                        <template v-slot:append-item>
                            <v-list-item>
                                <v-text-field v-model="newGroup" label="Add New Group" prepend-inner-icon="mdi-plus"
                                    variant="outlined" density="compact" @keyup.enter="addNewGroup"></v-text-field>
                            </v-list-item>
                        </template>
                    </v-select>

                    <v-textarea v-model="form.description" label="Description"
                        hint="Brief description of what this permission allows" persistent-hint rows="2"
                        class="mb-4"></v-textarea>
                </v-form>
            </v-card-text>
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn @click="close" variant="text">Cancel</v-btn>
                <v-btn @click="onSave" color="primary" :loading="saving">
                    {{ editingPermission ? 'Update' : 'Create' }}
                </v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
</template>

<script>
import commonMixin from '../../../../mixins/commonMixin';

export default {
    name: 'PermissionDialog',
    mixins: [commonMixin],
    props: {
        modelValue: { type: Boolean, required: true },
        permission: { type: Object, default: null },
        groups: { type: Array, default: () => [] }
    },
    emits: ['update:modelValue', 'save', 'error'],
    data() {
        return {
            form: {
                name: '',
                slug: '',
                group: '',
                description: '',
            },
            newGroup: '',
            rules: {
                required: value => !!value || 'This field is required'
            }
        };
    },
    computed: {
        editingPermission() {
            return !!this.permission;
        }
    },
    watch: {
        permission: {
            handler(newPermission) {
                if (newPermission) {
                    this.form = {
                        name: newPermission.name || '',
                        slug: newPermission.slug || '',
                        group: newPermission.group || '',
                        description: newPermission.description || '',
                    };
                } else {
                    this.resetForm();
                }
            },
            immediate: true
        },
        modelValue(newValue) {
            if (!newValue) {
                this.resetForm();
            }
        }
    },
    methods: {
        resetForm() {
            this.form = {
                name: '',
                slug: '',
                group: '',
                description: '',
            };
            this.newGroup = '';
            if (this.$refs.permissionForm) {
                this.$refs.permissionForm.resetValidation();
            }
        },
        autoGenerateSlugFromName() {
            if (!this.form.slug && this.form.name && !this.editingPermission) {
                this.form.slug = this.form.name
                    .toLowerCase()
                    .replace(/[^a-z0-9]+/g, '-')
                    .replace(/^-+|-+$/g, '');
            }
        },
        addNewGroup() {
            if (this.newGroup && !this.groups.find(g => g.name === this.newGroup || (typeof g === 'string' && g === this.newGroup))) {
                const groupName = this.newGroup.trim();
                // Emit event to parent to add group
                this.$emit('add-group', groupName);
                this.form.group = groupName;
                this.newGroup = '';
            }
        },
        close() {
            this.$emit('update:modelValue', false);
        },
        async onSave() {
            // Validate form
            if (!this.$refs.permissionForm) {
                this.showError('Form reference not found');
                return;
            }

            if (!this.$refs.permissionForm.validate()) {
                return;
            }

            // Auto-generate slug if empty
            if (!this.form.slug && this.form.name) {
                this.form.slug = this.form.name
                    .toLowerCase()
                    .replace(/[^a-z0-9]+/g, '-')
                    .replace(/^-+|-+$/g, '');
            }

            this.saving = true;
            try {
                const url = this.editingPermission
                    ? `/api/v1/permissions/${this.permission.id}`
                    : '/api/v1/permissions';

                const method = this.editingPermission ? 'put' : 'post';

                const data = {
                    name: this.form.name.trim(),
                    slug: this.form.slug ? this.form.slug.trim() : null,
                    group: this.form.group.trim(),
                    description: this.form.description ? this.form.description.trim() : null,
                };

                await this.$axios[method](url, data, {
                    headers: this.getAuthHeaders()
                });

                this.showSuccess(
                    this.editingPermission ? 'Permission updated successfully' : 'Permission created successfully'
                );
                this.$emit('save', data);
                this.close();
            } catch (error) {
                this.handleApiError(error, 'Error saving permission');
                this.$emit('error', error);
            } finally {
                this.saving = false;
            }
        }
    }
};
</script>

