<template>
    <v-container fluid>
        <v-card>
            <v-card-title class="d-flex justify-space-between align-center">
                <div class="d-flex align-center gap-2">
                    <v-icon>mdi-weight-kilogram</v-icon>
                    <span class="text-h5">Units</span>
                </div>
                <v-btn color="primary" prepend-icon="mdi-plus" @click="openDialog">Add Unit</v-btn>
            </v-card-title>
            <v-divider />

            <v-card-text>
                <v-text-field v-model="search" label="Search Units" prepend-inner-icon="mdi-magnify" clearable />
            </v-card-text>

            <v-table>
                <thead>
                    <tr>
                        <th class="sortable" @click="onSort('name')">
                            <div class="sortable-header">
                                <span>Name</span>
                                <v-icon v-if="sortBy === 'name'" size="18" class="sort-icon active">
                                    {{ sortDirection === 'asc' ? 'mdi-arrow-up' : 'mdi-arrow-down' }}
                                </v-icon>
                                <v-icon v-else size="18" class="sort-icon inactive">
                                    mdi-unfold-more-horizontal
                                </v-icon>
                            </div>
                        </th>
                        <th class="sortable" @click="onSort('code')">
                            <div class="sortable-header">
                                <span>Code</span>
                                <v-icon v-if="sortBy === 'code'" size="18" class="sort-icon active">
                                    {{ sortDirection === 'asc' ? 'mdi-arrow-up' : 'mdi-arrow-down' }}
                                </v-icon>
                                <v-icon v-else size="18" class="sort-icon inactive">
                                    mdi-unfold-more-horizontal
                                </v-icon>
                            </div>
                        </th>
                        <th class="sortable" @click="onSort('description')">
                            <div class="sortable-header">
                                <span>Description</span>
                                <v-icon v-if="sortBy === 'description'" size="18" class="sort-icon active">
                                    {{ sortDirection === 'asc' ? 'mdi-arrow-up' : 'mdi-arrow-down' }}
                                </v-icon>
                                <v-icon v-else size="18" class="sort-icon inactive">
                                    mdi-unfold-more-horizontal
                                </v-icon>
                            </div>
                        </th>
                        <th class="sortable" @click="onSort('is_active')">
                            <div class="sortable-header">
                                <span>Status</span>
                                <v-icon v-if="sortBy === 'is_active'" size="18" class="sort-icon active">
                                    {{ sortDirection === 'asc' ? 'mdi-arrow-up' : 'mdi-arrow-down' }}
                                </v-icon>
                                <v-icon v-else size="18" class="sort-icon inactive">
                                    mdi-unfold-more-horizontal
                                </v-icon>
                            </div>
                        </th>
                        <th class="sortable" @click="onSort('created_at')">
                            <div class="sortable-header">
                                <span>Created</span>
                                <v-icon v-if="sortBy === 'created_at'" size="18" class="sort-icon active">
                                    {{ sortDirection === 'asc' ? 'mdi-arrow-up' : 'mdi-arrow-down' }}
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
                    <!-- Skeleton Loaders -->
                    <tr v-if="loading" v-for="n in 5" :key="`skeleton-${n}`">
                        <td><v-skeleton-loader type="text" width="150"></v-skeleton-loader></td>
                        <td><v-skeleton-loader type="text" width="80"></v-skeleton-loader></td>
                        <td><v-skeleton-loader type="text" width="200"></v-skeleton-loader></td>
                        <td><v-skeleton-loader type="chip" width="80" height="24"></v-skeleton-loader></td>
                        <td><v-skeleton-loader type="text" width="100"></v-skeleton-loader></td>
                        <td>
                            <div class="d-flex">
                                <v-skeleton-loader type="button" width="32" height="32"
                                    class="mr-1"></v-skeleton-loader>
                                <v-skeleton-loader type="button" width="32" height="32"></v-skeleton-loader>
                            </div>
                        </td>
                    </tr>
                    <!-- Actual Unit Data -->
                    <template v-else>
                        <tr v-for="unit in sortedUnits" :key="unit.id">
                            <td>{{ unit.name }}</td>
                            <td>
                                <v-chip size="small">{{ unit.code }}</v-chip>
                            </td>
                            <td>{{ unit.description || '-' }}</td>
                            <td>
                                <v-chip :color="unit.is_active ? 'success' : 'error'" size="small">
                                    {{ unit.is_active ? 'Active' : 'Inactive' }}
                                </v-chip>
                            </td>
                            <td>{{ formatDate(unit.created_at) }}</td>
                            <td>
                                <v-btn icon="mdi-pencil" size="small" variant="text" @click="editUnit(unit)" />
                                <v-btn icon="mdi-delete" size="small" variant="text" color="error"
                                    @click="confirmDelete(unit)" />
                            </td>
                        </tr>
                        <tr v-if="sortedUnits.length === 0">
                            <td colspan="6" class="text-center py-4">No units found</td>
                        </tr>
                    </template>
                </tbody>
            </v-table>
        </v-card>

        <!-- Unit Dialog -->
        <v-dialog v-model="dialog" max-width="500px" persistent>
            <v-card>
                <v-card-title class="d-flex justify-space-between align-center">
                    <span>{{ isEdit ? 'Edit Unit' : 'Add Unit' }}</span>
                    <v-btn icon="mdi-close" variant="text" @click="closeDialog" />
                </v-card-title>
                <v-divider />
                <v-card-text>
                    <v-form ref="formRef" v-model="formValid">
                        <v-text-field v-model="form.name" label="Unit Name *" :rules="[rules.required]" />
                        <v-text-field v-model="form.code" label="Code *" :rules="[rules.required]"
                            hint="e.g., KG, PCS, LTR" />
                        <v-textarea v-model="form.description" label="Description" rows="2" />
                        <v-switch v-model="form.is_active" label="Active" color="primary" />
                    </v-form>
                </v-card-text>
                <v-divider />
                <v-card-actions class="justify-end">
                    <v-btn variant="text" @click="closeDialog">Cancel</v-btn>
                    <v-btn color="primary" :loading="saving" @click="save">
                        {{ isEdit ? 'Update' : 'Save' }}
                    </v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>

        <!-- Delete Confirmation -->
        <v-dialog v-model="deleteDialog" max-width="400">
            <v-card>
                <v-card-title>Confirm Delete</v-card-title>
                <v-card-text>Are you sure you want to delete this unit?</v-card-text>
                <v-card-actions>
                    <v-spacer />
                    <v-btn @click="deleteDialog = false">Cancel</v-btn>
                    <v-btn color="error" :loading="deleting" @click="deleteUnit">Delete</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </v-container>
</template>

<script>
import axios from '@/utils/axios.config';

export default {
    name: 'AdminUnits',
    data() {
        return {
            units: [],
            search: '',
            loading: false,
            dialog: false,
            deleteDialog: false,
            saving: false,
            deleting: false,
            formValid: false,
            form: this.getEmptyForm(),
            sortBy: null,
            sortDirection: 'asc',
            rules: {
                required: v => !!v || 'Required',
            },
        };
    },
    computed: {
        filteredUnits() {
            if (!this.search) return this.units;
            const searchLower = this.search.toLowerCase();
            return this.units.filter(unit =>
                unit.name?.toLowerCase().includes(searchLower) ||
                unit.code?.toLowerCase().includes(searchLower)
            );
        },
        sortedUnits() {
            let units = [...this.filteredUnits];

            if (!this.sortBy) {
                return units;
            }

            units.sort((a, b) => {
                let aVal = a[this.sortBy];
                let bVal = b[this.sortBy];

                // Handle null/undefined values
                if (aVal == null) aVal = '';
                if (bVal == null) bVal = '';

                // Handle boolean values
                if (typeof aVal === 'boolean') {
                    aVal = aVal ? 1 : 0;
                    bVal = bVal ? 1 : 0;
                }

                // Handle date strings
                if (this.sortBy === 'created_at' && typeof aVal === 'string') {
                    aVal = new Date(aVal).getTime();
                    bVal = new Date(bVal).getTime();
                }

                // Convert to string for comparison if not numbers
                if (typeof aVal !== 'number' && typeof bVal !== 'number') {
                    aVal = String(aVal).toLowerCase();
                    bVal = String(bVal).toLowerCase();
                }

                if (aVal < bVal) return this.sortDirection === 'asc' ? -1 : 1;
                if (aVal > bVal) return this.sortDirection === 'asc' ? 1 : -1;
                return 0;
            });

            return units;
        },
        isEdit() {
            return !!this.form.id;
        },
    },
    mounted() {
        this.fetchUnits();
    },
    methods: {
        getEmptyForm() {
            return {
                id: null,
                name: '',
                code: '',
                description: '',
                is_active: true,
            };
        },
        async fetchUnits() {
            this.loading = true;
            try {
                const { data } = await axios.get('/api/v1/units');
                this.units = data.data || data.units || [];
            } catch (error) {
                console.error('Failed to fetch units', error);
                this.$toast?.error('Failed to load units');
            } finally {
                this.loading = false;
            }
        },
        openDialog() {
            this.form = this.getEmptyForm();
            this.dialog = true;
        },
        editUnit(unit) {
            this.form = { ...unit };
            this.dialog = true;
        },
        closeDialog() {
            this.dialog = false;
            this.form = this.getEmptyForm();
        },
        async save() {
            const valid = await this.$refs.formRef.validate();
            if (!valid.valid) return;

            this.saving = true;
            try {
                if (this.isEdit) {
                    await axios.put(`/api/v1/units/${this.form.id}`, this.form);
                    this.$toast?.success('Unit updated successfully');
                } else {
                    await axios.post('/api/v1/units', this.form);
                    this.$toast?.success('Unit created successfully');
                }
                this.closeDialog();
                this.fetchUnits();
            } catch (error) {
                console.error('Failed to save unit', error);
                this.$toast?.error('Failed to save unit');
            } finally {
                this.saving = false;
            }
        },
        confirmDelete(unit) {
            this.form = unit;
            this.deleteDialog = true;
        },
        async deleteUnit() {
            this.deleting = true;
            try {
                await axios.delete(`/api/v1/units/${this.form.id}`);
                this.$toast?.success('Unit deleted successfully');
                this.deleteDialog = false;
                this.fetchUnits();
            } catch (error) {
                console.error('Failed to delete unit', error);
                this.$toast?.error('Failed to delete unit');
            } finally {
                this.deleting = false;
            }
        },
        formatDate(date) {
            if (!date) return '';
            return new Date(date).toLocaleDateString();
        },
        onSort(field) {
            if (this.sortBy === field) {
                // Toggle direction if same field
                this.sortDirection = this.sortDirection === 'asc' ? 'desc' : 'asc';
            } else {
                // New field, default to ascending
                this.sortBy = field;
                this.sortDirection = 'asc';
            }
        },
    },
};
</script>

<style scoped>
.sortable {
    cursor: pointer;
    user-select: none;
    transition: background-color 0.2s;
    position: relative;
}

.sortable:hover {
    background-color: rgba(0, 0, 0, 0.04);
}

.sortable-header {
    display: flex;
    align-items: center;
    gap: 6px;
    justify-content: flex-start;
    width: 100%;
}

.sort-icon {
    flex-shrink: 0;
    transition: opacity 0.2s, color 0.2s, background-color 0.2s;
    display: inline-flex !important;
    visibility: visible !important;
    opacity: 1 !important;
    font-size: 18px !important;
    width: 18px !important;
    height: 18px !important;
    line-height: 1 !important;
    background-color: white;
    border-radius: 4px;
    padding: 2px;
}

.sort-icon.active {
    opacity: 1 !important;
    color: rgb(var(--v-theme-primary)) !important;
    visibility: visible !important;
    background-color: white !important;
}

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
    background-color: white !important;
}

.sort-icon.inactive :deep(svg),
.sort-icon.inactive :deep(path) {
    fill: #424242 !important;
    color: #424242 !important;
    opacity: 0.7 !important;
}

.sortable:hover .sort-icon.inactive {
    opacity: 1 !important;
    color: #212121 !important;
    background-color: white !important;
}

.sortable:hover .sort-icon.inactive :deep(svg),
.sortable:hover .sort-icon.inactive :deep(path) {
    fill: #212121 !important;
    color: #212121 !important;
    opacity: 1 !important;
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
</style>
