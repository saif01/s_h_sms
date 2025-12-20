<template>
    <v-dialog :model-value="modelValue" @update:model-value="$emit('update:modelValue', $event)" max-width="900"
        persistent>
        <v-card>
            <v-card-title>
                {{ editingRole ? 'Edit Role' : 'Add New Role' }}
            </v-card-title>
            <v-card-text>
                <v-alert v-if="editingRole && editingRole.is_system" type="info" variant="tonal" class="mb-4">
                    <strong>System Role:</strong> This is a system role. Core properties (name, slug, description,
                    status, order) cannot be modified. Only permissions can be updated using the permissions button.
                </v-alert>
                <v-form ref="roleForm" @submit.prevent="onSave">
                    <v-text-field v-model="form.name" placeholder="Enter role name (e.g., Administrator, Editor)"
                        :rules="[rules.required]" required hint="Display name for the role" persistent-hint
                        variant="outlined" density="comfortable" hide-details="auto" class="mb-4"
                        :disabled="editingRole && editingRole.is_system" @blur="autoGenerateSlugFromName">
                        <template #label>
                            Role Name <span class="text-error" style="font-size: 1.2em; font-weight: bold;">*</span>
                        </template>
                    </v-text-field>

                    <v-text-field v-model="form.slug" label="Slug"
                        placeholder="Enter slug (e.g., administrator, editor) or click generate to auto-generate"
                        hint="URL-friendly identifier (auto-generated from name if empty)" persistent-hint
                        variant="outlined" density="comfortable" hide-details="auto"
                        prepend-inner-icon="mdi-link-variant" class="mb-4"
                        :disabled="editingRole && editingRole.is_system">
                        <template #append-inner>
                            <v-btn icon variant="text" size="small" color="primary"
                                :disabled="!form.name || (editingRole && editingRole.is_system)"
                                @click="generateSlugFromName"
                                :title="form.name ? 'Generate slug from role name' : 'Enter role name first'">
                                <v-icon size="small">mdi-refresh</v-icon>
                            </v-btn>
                        </template>
                    </v-text-field>

                    <v-textarea v-model="form.description" label="Description"
                        placeholder="Enter a brief description of the role and its purpose (optional)"
                        hint="Brief description of the role" persistent-hint variant="outlined" density="comfortable"
                        rows="2" hide-details="auto" class="mb-4" :disabled="editingRole && editingRole.is_system" />

                    <v-text-field v-model.number="form.order" label="Order" type="number"
                        placeholder="Enter display order (e.g., 0, 1, 2)" hint="Display order (lower numbers first)"
                        persistent-hint variant="outlined" density="comfortable" hide-details="auto" class="mb-4"
                        :disabled="editingRole && editingRole.is_system" />

                    <v-switch v-model="form.is_active" label="Active" hint="Inactive roles cannot be assigned to users"
                        persistent-hint class="mb-4" :disabled="editingRole && editingRole.is_system"></v-switch>

                    <!-- Permissions Section -->
                    <v-divider class="my-4"></v-divider>
                    <div class="mb-2">
                        <div class="d-flex justify-space-between align-center mb-2">
                            <div>
                                <h3 class="text-h6 mb-1">Permissions</h3>
                                <p class="text-caption text-grey">Select permissions to assign to this role</p>
                            </div>
                            <div class="d-flex gap-2">
                                <v-btn size="small" variant="outlined" @click="selectAllPermissions" color="primary">
                                    Select All
                                </v-btn>
                                <v-btn size="small" variant="outlined" @click="deselectAllPermissions" color="grey">
                                    Deselect All
                                </v-btn>
                            </div>
                        </div>
                    </div>

                    <!-- Search Filter -->
                    <v-text-field v-model="permissionSearch" label="Search permissions"
                        placeholder="Search by permission name, description, or slug" prepend-inner-icon="mdi-magnify"
                        variant="outlined" density="compact" clearable
                        hint="Type to filter permissions by name, description, or slug" persistent-hint
                        hide-details="auto" class="mb-4" />

                    <!-- Permissions List - All Expanded -->
                    <div v-if="Object.keys(filteredGroupedPermissions).length > 0" class="permissions-container mb-4">
                        <div v-for="(permissions, group) in filteredGroupedPermissions" :key="group"
                            class="permission-group mb-4">
                            <v-card variant="outlined">
                                <v-card-title class="d-flex justify-space-between align-center py-2">
                                    <div class="d-flex align-center gap-2">
                                        <span class="text-h6">{{ group.charAt(0).toUpperCase() + group.slice(1)
                                            }}</span>
                                        <v-chip size="small" color="primary" variant="flat">
                                            {{ getSelectedCountInGroup(group) }} / {{ permissions.length }} selected
                                        </v-chip>
                                    </div>
                                    <div class="d-flex gap-1">
                                        <v-btn size="x-small" variant="text" @click="selectAllInGroup(group)"
                                            color="primary">
                                            Select All
                                        </v-btn>
                                        <v-btn size="x-small" variant="text" @click="deselectAllInGroup(group)"
                                            color="grey">
                                            Clear
                                        </v-btn>
                                    </div>
                                </v-card-title>
                                <v-card-text>
                                    <v-row v-if="Array.isArray(permissions)">
                                        <v-col v-for="permission in permissions" :key="permission.id" cols="12" md="6"
                                            lg="4">
                                            <v-checkbox :model-value="isFormPermissionSelected(permission.id)"
                                                @update:model-value="toggleFormPermission(permission.id)"
                                                :label="permission.name" :hint="permission.description" persistent-hint
                                                density="comfortable" color="primary">
                                                <template v-slot:label>
                                                    <div>
                                                        <div class="font-weight-medium">{{ permission.name }}</div>
                                                        <div v-if="permission.description"
                                                            class="text-caption text-grey">
                                                            {{ permission.description }}
                                                        </div>
                                                    </div>
                                                </template>
                                            </v-checkbox>
                                        </v-col>
                                    </v-row>
                                </v-card-text>
                            </v-card>
                        </div>
                    </div>
                    <v-alert v-else type="info" variant="tonal" class="mb-4">
                        <div v-if="permissionSearch">
                            No permissions found matching "{{ permissionSearch }}"
                        </div>
                        <div v-else>
                            No permissions available. Please ensure permissions are loaded.
                        </div>
                    </v-alert>
                </v-form>
            </v-card-text>
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn @click="close" variant="text">Cancel</v-btn>
                <v-btn v-if="editingRole && editingRole.is_system" @click="close" color="primary">
                    Close
                </v-btn>
                <v-btn v-else @click="onSave" color="primary" :loading="saving">
                    {{ editingRole ? 'Update' : 'Create' }}
                </v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
</template>

<script>
import commonMixin from '../../../../mixins/commonMixin';

export default {
    name: 'RoleDialog',
    mixins: [commonMixin],
    props: {
        modelValue: { type: Boolean, required: true },
        role: { type: Object, default: null },
        groupedPermissions: { type: Object, default: () => ({}) }
    },
    emits: ['update:modelValue', 'save', 'error'],
    data() {
        return {
            form: {
                name: '',
                slug: '',
                description: '',
                is_active: true,
                order: 0,
                permissions: []
            },
            permissionSearch: '',
            saving: false,
            rules: {
                required: value => !!value || 'This field is required'
            }
        };
    },
    computed: {
        editingRole() {
            return !!this.role;
        },
        safeGroupedPermissions() {
            if (!this.groupedPermissions || typeof this.groupedPermissions !== 'object') {
                return {};
            }
            const safe = {};
            Object.keys(this.groupedPermissions).forEach(key => {
                if (Array.isArray(this.groupedPermissions[key])) {
                    safe[key] = this.groupedPermissions[key];
                }
            });
            return safe;
        },
        filteredGroupedPermissions() {
            if (!this.permissionSearch) {
                return this.safeGroupedPermissions;
            }
            const search = this.permissionSearch.toLowerCase();
            const filtered = {};
            Object.keys(this.safeGroupedPermissions).forEach(group => {
                const permissions = this.safeGroupedPermissions[group];
                if (Array.isArray(permissions)) {
                    const filteredPermissions = permissions.filter(permission => {
                        const name = (permission.name || '').toLowerCase();
                        const description = (permission.description || '').toLowerCase();
                        const slug = (permission.slug || '').toLowerCase();
                        return name.includes(search) || description.includes(search) || slug.includes(search);
                    });
                    if (filteredPermissions.length > 0) {
                        filtered[group] = filteredPermissions;
                    }
                }
            });
            return filtered;
        },
        allPermissions() {
            const permissions = [];
            Object.values(this.safeGroupedPermissions).forEach(group => {
                if (Array.isArray(group)) {
                    permissions.push(...group);
                }
            });
            return permissions;
        }
    },
    watch: {
        role: {
            handler(newRole) {
                if (newRole) {
                    let rolePermissions = [];
                    if (newRole.permissions) {
                        rolePermissions = newRole.permissions.map(p => {
                            if (typeof p === 'object' && p.id) {
                                return p.id;
                            }
                            return p;
                        });
                    }
                    this.form = {
                        name: newRole.name || '',
                        slug: newRole.slug || '',
                        description: newRole.description || '',
                        is_active: newRole.is_active !== undefined ? newRole.is_active : true,
                        order: newRole.order || 0,
                        permissions: rolePermissions
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
                description: '',
                is_active: true,
                order: 0,
                permissions: []
            };
            this.permissionSearch = '';
            if (this.$refs.roleForm) {
                this.$refs.roleForm.resetValidation();
            }
        },
        autoGenerateSlugFromName() {
            if (!this.form.slug && this.form.name && !this.editingRole) {
                this.generateSlugFromName();
            }
        },
        generateSlugFromName() {
            if (this.form.name) {
                this.form.slug = this.form.name
                    .toLowerCase()
                    .replace(/[^a-z0-9]+/g, '-')
                    .replace(/^-+|-+$/g, '');
            }
        },
        isFormPermissionSelected(permissionId) {
            return this.form.permissions.includes(permissionId);
        },
        toggleFormPermission(permissionId) {
            const index = this.form.permissions.indexOf(permissionId);
            if (index > -1) {
                this.form.permissions.splice(index, 1);
            } else {
                this.form.permissions.push(permissionId);
            }
        },
        getSelectedCountInGroup(group) {
            const permissions = this.filteredGroupedPermissions[group] || this.safeGroupedPermissions[group];
            if (!permissions || !Array.isArray(permissions)) {
                return 0;
            }
            return permissions.filter(p => this.form.permissions.includes(p.id)).length;
        },
        selectAllPermissions() {
            this.allPermissions.forEach(permission => {
                if (!this.form.permissions.includes(permission.id)) {
                    this.form.permissions.push(permission.id);
                }
            });
        },
        deselectAllPermissions() {
            this.form.permissions = [];
        },
        selectAllInGroup(group) {
            const permissions = this.filteredGroupedPermissions[group] || this.safeGroupedPermissions[group];
            if (permissions && Array.isArray(permissions)) {
                permissions.forEach(permission => {
                    if (!this.form.permissions.includes(permission.id)) {
                        this.form.permissions.push(permission.id);
                    }
                });
            }
        },
        deselectAllInGroup(group) {
            const permissions = this.filteredGroupedPermissions[group] || this.safeGroupedPermissions[group];
            if (permissions && Array.isArray(permissions)) {
                const permissionIds = permissions.map(p => p.id);
                this.form.permissions = this.form.permissions.filter(id => !permissionIds.includes(id));
            }
        },
        close() {
            this.$emit('update:modelValue', false);
        },
        async onSave() {
            if (!this.$refs.roleForm) {
                this.showError('Form reference not found');
                return;
            }

            if (!this.$refs.roleForm.validate()) {
                return;
            }

            if (!this.form.slug && this.form.name) {
                this.form.slug = this.form.name
                    .toLowerCase()
                    .replace(/[^a-z0-9]+/g, '-')
                    .replace(/^-+|-+$/g, '');
            }

            this.saving = true;
            try {
                const url = this.editingRole
                    ? `/api/v1/roles/${this.role.id}`
                    : '/api/v1/roles';

                const method = this.editingRole ? 'put' : 'post';

                const data = {
                    name: this.form.name.trim(),
                    description: this.form.description ? this.form.description.trim() : null,
                    is_active: this.form.is_active === true || this.form.is_active === 'true' || this.form.is_active === 1,
                    order: parseInt(this.form.order) || 0
                };

                if (this.editingRole) {
                    if (this.form.slug !== this.role.slug) {
                        if (this.form.slug && this.form.slug.trim()) {
                            data.slug = this.form.slug.trim();
                        } else {
                            data.slug = '';
                        }
                    }
                } else {
                    if (this.form.slug && this.form.slug.trim()) {
                        data.slug = this.form.slug.trim();
                    }
                }

                if (this.form.permissions && Array.isArray(this.form.permissions)) {
                    data.permissions = this.form.permissions;
                }

                await this.$axios[method](url, data, {
                    headers: this.getAuthHeaders()
                });

                this.showSuccess(
                    this.editingRole ? 'Role updated successfully' : 'Role created successfully'
                );
                this.$emit('save', data);
                this.close();
            } catch (error) {
                console.error('Error saving role:', error);
                this.handleApiError(error, 'Error saving role');
                this.$emit('error', error);
            } finally {
                this.saving = false;
            }
        }
    }
};
</script>

<style scoped>
.permissions-container {
    max-height: 600px;
    overflow-y: auto;
    padding-right: 8px;
}

.permission-group {
    margin-bottom: 16px;
}

.permissions-container::-webkit-scrollbar {
    width: 8px;
}

.permissions-container::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 4px;
}

.permissions-container::-webkit-scrollbar-thumb {
    background: #888;
    border-radius: 4px;
}

.permissions-container::-webkit-scrollbar-thumb:hover {
    background: #555;
}
</style>
