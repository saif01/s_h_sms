<template>
    <v-dialog :model-value="modelValue" @update:model-value="$emit('update:modelValue', $event)" max-width="800"
        persistent>
        <v-card>
            <v-card-title>
                Manage Permissions - {{ role?.name }}
                <v-chip v-if="role?.is_system" color="warning" size="small" class="ml-2">
                    System Role
                </v-chip>
            </v-card-title>
            <v-card-text>
                <div v-if="Object.keys(safeGroupedPermissions).length === 0" class="text-center py-4">
                    <p class="text-grey">No permissions available</p>
                </div>
                <div v-else>
                    <div v-for="(permissions, group) in safeGroupedPermissions" :key="group" class="mb-6">
                        <h3 class="text-h6 mb-3">{{ group.charAt(0).toUpperCase() + group.slice(1) }}</h3>
                        <v-row v-if="Array.isArray(permissions)">
                            <v-col v-for="permission in permissions" :key="permission.id" cols="12" md="6">
                                <v-checkbox :model-value="isPermissionSelected(permission.id)"
                                    @update:model-value="togglePermission(permission.id)" :label="permission.name"
                                    :hint="permission.description" persistent-hint density="compact"></v-checkbox>
                            </v-col>
                        </v-row>
                        <v-alert v-else type="warning" variant="tonal" class="mt-2">
                            Invalid permission group structure
                        </v-alert>
                    </div>
                </div>
            </v-card-text>
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn @click="close" variant="text">Cancel</v-btn>
                <v-btn @click="onSave" color="primary" :loading="saving">
                    Save Permissions
                </v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
</template>

<script>
import commonMixin from '../../../../mixins/commonMixin';

export default {
    name: 'RolePermissionsDialog',
    mixins: [commonMixin],
    props: {
        modelValue: { type: Boolean, required: true },
        role: { type: Object, default: null },
        groupedPermissions: { type: Object, default: () => ({}) }
    },
    emits: ['update:modelValue', 'save', 'error'],
    data() {
        return {
            selectedPermissions: [],
            saving: false
        };
    },
    computed: {
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
        }
    },
    watch: {
        role: {
            handler(newRole) {
                if (newRole) {
                    this.selectedPermissions = newRole.permissions
                        ? newRole.permissions.map(p => p.id || p)
                        : [];
                } else {
                    this.selectedPermissions = [];
                }
            },
            immediate: true
        },
        modelValue(newValue) {
            if (!newValue) {
                this.selectedPermissions = [];
            }
        }
    },
    methods: {
        isPermissionSelected(permissionId) {
            return this.selectedPermissions.includes(permissionId);
        },
        togglePermission(permissionId) {
            const index = this.selectedPermissions.indexOf(permissionId);
            if (index > -1) {
                this.selectedPermissions.splice(index, 1);
            } else {
                this.selectedPermissions.push(permissionId);
            }
        },
        close() {
            this.$emit('update:modelValue', false);
        },
        async onSave() {
            if (!this.role) {
                this.showError('No role selected');
                return;
            }

            this.saving = true;
            try {
                await this.$axios.put(`/api/v1/roles/${this.role.id}/permissions`, {
                    permissions: this.selectedPermissions
                }, {
                    headers: this.getAuthHeaders()
                });

                this.showSuccess('Permissions updated successfully');
                this.$emit('save', {
                    roleId: this.role.id,
                    permissions: this.selectedPermissions
                });
                this.close();
            } catch (error) {
                this.handleApiError(error, 'Error saving permissions');
                this.$emit('error', error);
            } finally {
                this.saving = false;
            }
        }
    }
};
</script>

