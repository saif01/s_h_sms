<template>
    <v-dialog :model-value="modelValue" @update:model-value="$emit('update:modelValue', $event)" max-width="900"
        scrollable persistent>
        <v-card>
            <v-card-title>
                {{ editingUser ? 'Edit User' : 'Add New User' }}
            </v-card-title>
            <v-card-text class="pa-0">
                <v-form ref="form" @submit.prevent="onSave">
                    <v-tabs v-model="activeTab" bg-color="grey-lighten-4">
                        <v-tab value="basic">Basic Information</v-tab>
                        <v-tab value="profile">Profile Information</v-tab>
                        <v-tab value="security">Security</v-tab>
                    </v-tabs>

                    <v-window v-model="activeTab">
                        <!-- Basic Information Tab -->
                        <v-window-item value="basic">
                            <div class="pa-6">
                                <v-text-field v-model="form.name" label="Full Name" :rules="[rules.required]" required
                                    class="mb-4"></v-text-field>

                                <v-text-field v-model="form.email" label="Email" type="email"
                                    :rules="[rules.required, rules.email]" required class="mb-4"></v-text-field>

                                <v-select v-model="form.role_ids" :items="roles" item-title="label" item-value="value"
                                    label="Roles" :rules="[rules.required]" required multiple chips class="mb-4">
                                    <template v-slot:item="{ props, item }">
                                        <v-list-item v-bind="props">
                                            <template v-slot:title>
                                                {{ item.raw.label }}
                                                <v-chip v-if="item.raw.is_system" size="x-small" color="warning"
                                                    class="ml-2">
                                                    System
                                                </v-chip>
                                            </template>
                                            <template v-slot:subtitle>
                                                {{ item.raw.description }}
                                            </template>
                                        </v-list-item>
                                    </template>
                                    <template v-slot:selection="{ item, index }">
                                        <v-chip v-if="index < 2" size="small" class="mr-1">
                                            {{ item.raw.label }}
                                        </v-chip>
                                        <span v-if="index === 2" class="text-grey text-caption align-self-center">
                                            (+{{ form.role_ids.length - 2 }} others)
                                        </span>
                                    </template>
                                </v-select>

                                <!-- Avatar Upload Section -->
                                <div class="mb-4">
                                    <div class="text-subtitle-2 font-weight-medium mb-2">Avatar</div>

                                    <!-- Avatar Preview -->
                                    <div v-if="form.avatar" class="mb-3 text-center">
                                        <v-avatar size="80" class="mb-2">
                                            <v-img :src="form.avatar ? resolveImageUrl(form.avatar) : ''"
                                                alt="Avatar Preview"></v-img>
                                        </v-avatar>
                                        <div>
                                            <v-btn size="small" variant="text" color="error" prepend-icon="mdi-delete"
                                                @click="clearAvatar">Remove
                                                Avatar</v-btn>
                                        </div>
                                    </div>

                                    <!-- File Upload -->
                                    <v-file-input v-model="avatarFile" label="Upload Avatar" variant="outlined"
                                        density="comfortable" color="primary" accept="image/*" prepend-icon="mdi-image"
                                        hint="Upload an avatar image (JPG, PNG, GIF, WebP - Max 5MB). Recommended size: 200x200px"
                                        persistent-hint show-size @update:model-value="handleAvatarUpload" class="mb-3">
                                        <template v-slot:append-inner v-if="uploadingAvatar">
                                            <v-progress-circular indeterminate size="20"
                                                color="primary"></v-progress-circular>
                                        </template>
                                    </v-file-input>
                                </div>
                            </div>
                        </v-window-item>

                        <!-- Profile Information Tab -->
                        <v-window-item value="profile">
                            <div class="pa-6">
                                <v-row>
                                    <v-col cols="12" md="6">
                                        <v-text-field v-model="form.phone" label="Phone Number" variant="outlined"
                                            prepend-inner-icon="mdi-phone" hint="e.g., +8801707080401"
                                            persistent-hint></v-text-field>
                                    </v-col>
                                    <v-col cols="12" md="6">
                                        <v-text-field v-model="form.date_of_birth" label="Date of Birth" type="date"
                                            variant="outlined" prepend-inner-icon="mdi-calendar"></v-text-field>
                                    </v-col>
                                    <v-col cols="12" md="6">
                                        <v-select v-model="form.gender" :items="genderOptions" label="Gender"
                                            variant="outlined" prepend-inner-icon="mdi-gender-male-female"
                                            clearable></v-select>
                                    </v-col>
                                    <v-col cols="12">
                                        <v-textarea v-model="form.address" label="Address" variant="outlined" rows="2"
                                            prepend-inner-icon="mdi-map-marker" hint="Street address"
                                            persistent-hint></v-textarea>
                                    </v-col>
                                    <v-col cols="12" md="4">
                                        <v-text-field v-model="form.city" label="City" variant="outlined"
                                            prepend-inner-icon="mdi-city"></v-text-field>
                                    </v-col>
                                    <v-col cols="12" md="4">
                                        <v-text-field v-model="form.state" label="State/Province" variant="outlined"
                                            prepend-inner-icon="mdi-map"></v-text-field>
                                    </v-col>
                                    <v-col cols="12" md="4">
                                        <v-text-field v-model="form.country" label="Country" variant="outlined"
                                            prepend-inner-icon="mdi-earth"></v-text-field>
                                    </v-col>
                                    <v-col cols="12" md="6">
                                        <v-text-field v-model="form.postal_code" label="Postal Code" variant="outlined"
                                            prepend-inner-icon="mdi-mailbox"></v-text-field>
                                    </v-col>
                                    <v-col cols="12">
                                        <v-textarea v-model="form.bio" label="Bio/Description" variant="outlined"
                                            rows="4" prepend-inner-icon="mdi-text"
                                            hint="Brief description about the user" persistent-hint
                                            :counter="1000"></v-textarea>
                                    </v-col>
                                </v-row>
                            </div>
                        </v-window-item>

                        <!-- Security Tab -->
                        <v-window-item value="security">
                            <div class="pa-6">
                                <v-text-field v-model="form.password" label="Password"
                                    :type="showPassword ? 'text' : 'password'"
                                    :rules="editingUser ? [] : [rules.required, rules.minLength]"
                                    :required="!editingUser" hint="Leave blank to keep current password" persistent-hint
                                    class="mb-4" prepend-inner-icon="mdi-lock">
                                    <template v-slot:append-inner>
                                        <v-btn icon variant="text" size="small" @click="showPassword = !showPassword">
                                            <v-icon>{{ showPassword ? 'mdi-eye-off' : 'mdi-eye' }}</v-icon>
                                        </v-btn>
                                    </template>
                                </v-text-field>

                                <v-text-field v-if="!editingUser || form.password" v-model="form.password_confirmation"
                                    label="Confirm Password" :type="showPasswordConfirmation ? 'text' : 'password'"
                                    :rules="form.password ? [
                                        () => !!form.password_confirmation || 'Please confirm your password',
                                        () => form.password_confirmation === form.password || 'Passwords do not match'
                                    ] : []" :required="!!form.password"
                                    prepend-inner-icon="mdi-lock-check"></v-text-field>
                            </div>
                        </v-window-item>
                    </v-window>
                </v-form>
            </v-card-text>
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn @click="close" variant="text">Cancel</v-btn>
                <v-btn @click="onSave" color="primary" :loading="saving">
                    {{ editingUser ? 'Update' : 'Create' }}
                </v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
</template>

<script>
import commonMixin from '../../../../mixins/commonMixin';
import { normalizeUploadPath, resolveUploadUrl } from '../../../../utils/uploads';

export default {
    name: 'UserDialog',
    mixins: [commonMixin],
    props: {
        modelValue: { type: Boolean, required: true },
        user: { type: Object, default: null },
        roles: { type: Array, default: () => [] }
    },
    emits: ['update:modelValue', 'save', 'error'],
    data() {
        return {
            form: {
                name: '',
                email: '',
                role_ids: [],
                password: '',
                password_confirmation: '',
                avatar: '',
                phone: '',
                date_of_birth: '',
                gender: null,
                address: '',
                city: '',
                state: '',
                country: '',
                postal_code: '',
                bio: ''
            },
            activeTab: 'basic',
            genderOptions: [
                { title: 'Male', value: 'male' },
                { title: 'Female', value: 'female' },
                { title: 'Other', value: 'other' }
            ],
            rules: {
                required: value => {
                    if (Array.isArray(value)) {
                        return value.length > 0 || 'At least one role is required';
                    }
                    return !!value || 'This field is required';
                },
                email: value => {
                    const pattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    return pattern.test(value) || 'Invalid email';
                },
                minLength: value => {
                    if (!value) return true; // Skip if empty (handled by required rule)
                    return value.length >= 8 || 'Password must be at least 8 characters';
                }
            },
            showPassword: false,
            showPasswordConfirmation: false,
            avatarFile: null,
            uploadingAvatar: false,
            saving: false
        };
    },
    computed: {
        editingUser() {
            return !!this.user;
        }
    },
    watch: {
        user: {
            handler(newUser) {
                if (newUser) {
                    // Extract role IDs from user.roles array
                    const roleIds = newUser.roles ? newUser.roles.map(role => role.id) : [];
                    // Normalize the avatar URL back to a path for editing
                    const avatarPath = this.normalizeImageInput(newUser.avatar || '');
                    this.form = {
                        name: newUser.name || '',
                        email: newUser.email || '',
                        role_ids: roleIds,
                        password: '',
                        password_confirmation: '',
                        avatar: avatarPath,
                        phone: newUser.phone || '',
                        date_of_birth: newUser.date_of_birth || '',
                        gender: newUser.gender || null,
                        address: newUser.address || '',
                        city: newUser.city || '',
                        state: newUser.state || '',
                        country: newUser.country || '',
                        postal_code: newUser.postal_code || '',
                        bio: newUser.bio || ''
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
            } else {
                this.activeTab = 'basic';
            }
        }
    },
    methods: {
        resetForm() {
            // Set default role (first role) if available
            const defaultRoleId = this.roles.length > 0 ? this.roles[0].value : null;
            this.form = {
                name: '',
                email: '',
                role_ids: defaultRoleId ? [defaultRoleId] : [],
                password: '',
                password_confirmation: '',
                avatar: '',
                phone: '',
                date_of_birth: '',
                gender: null,
                address: '',
                city: '',
                state: '',
                country: '',
                postal_code: '',
                bio: ''
            };
            this.showPassword = false;
            this.showPasswordConfirmation = false;
            this.avatarFile = null;
            this.activeTab = 'basic';
            if (this.$refs.form) {
                this.$refs.form.resetValidation();
            }
        },
        normalizeImageInput(imageValue) {
            return normalizeUploadPath(imageValue);
        },
        resolveImageUrl(value) {
            return resolveUploadUrl(value);
        },
        async handleAvatarUpload() {
            if (!this.avatarFile) {
                return;
            }

            const fileToUpload = Array.isArray(this.avatarFile) ? this.avatarFile[0] : this.avatarFile;
            if (!fileToUpload) {
                return;
            }

            // Validate file type
            if (!fileToUpload.type.startsWith('image/')) {
                this.showError('Please select a valid image file');
                this.avatarFile = null;
                return;
            }

            // Validate file size (5MB max)
            const maxSize = 5 * 1024 * 1024; // 5MB
            if (fileToUpload.size > maxSize) {
                this.showError('File size must be less than 5MB');
                this.avatarFile = null;
                return;
            }

            this.uploadingAvatar = true;
            try {
                const formData = new FormData();
                formData.append('image', fileToUpload);
                formData.append('folder', 'users');
                // Add user name as prefix if available
                if (this.form.name) {
                    formData.append('prefix', this.form.name);
                }

                const token = localStorage.getItem('admin_token');
                const response = await this.$axios.post('/api/v1/upload/image', formData, {
                    headers: {
                        Authorization: `Bearer ${token}`,
                        'Content-Type': 'multipart/form-data'
                    }
                });

                if (response.data.success) {
                    const uploadedPath = this.normalizeImageInput(response.data.path || response.data.url);
                    this.form.avatar = uploadedPath;
                    this.avatarFile = null;
                    this.showSuccess('Avatar uploaded successfully');
                } else {
                    throw new Error(response.data.message || 'Failed to upload avatar');
                }
            } catch (error) {
                console.error('Error uploading avatar:', error);
                let errorMessage = 'Failed to upload avatar';
                if (error.response) {
                    errorMessage = error.response.data?.message || error.response.statusText || errorMessage;
                } else if (error.message) {
                    errorMessage = error.message;
                }
                this.showError(errorMessage);
                this.avatarFile = null;
            } finally {
                this.uploadingAvatar = false;
            }
        },
        clearAvatar() {
            this.form.avatar = '';
            this.avatarFile = null;
        },
        close() {
            this.$emit('update:modelValue', false);
        },
        async onSave() {
            // Manual validation for password confirmation
            if (this.form.password && this.form.password !== this.form.password_confirmation) {
                this.showError('Passwords do not match');
                return;
            }

            // If creating new user, password is required
            if (!this.editingUser && !this.form.password) {
                this.showError('Password is required for new users');
                return;
            }

            // If editing and password is provided, confirmation is required
            if (this.editingUser && this.form.password && !this.form.password_confirmation) {
                this.showError('Please confirm the password');
                return;
            }

            if (!this.$refs.form.validate()) {
                return;
            }

            this.saving = true;
            try {
                const token = localStorage.getItem('admin_token');
                const url = this.editingUser
                    ? `/api/v1/users/${this.user.id}`
                    : '/api/v1/users';

                const data = { ...this.form };

                // Convert role_ids to ensure it's an array
                if (this.form.role_ids) {
                    data.role_ids = Array.isArray(this.form.role_ids)
                        ? this.form.role_ids
                        : [this.form.role_ids];
                }

                // Include password_confirmation for backend validation
                if (this.form.password) {
                    data.password_confirmation = this.form.password_confirmation;
                } else {
                    // Remove password fields if password is not being changed
                    delete data.password;
                    delete data.password_confirmation;
                }

                data.avatar = this.normalizeImageInput(data.avatar);

                // Remove legacy role field if it exists
                delete data.role;

                const method = this.editingUser ? 'put' : 'post';

                await this.$axios[method](url, data, {
                    headers: { Authorization: `Bearer ${token}` }
                });

                this.showSuccess(
                    this.editingUser ? 'User updated successfully' : 'User created successfully'
                );
                this.$emit('save', data);
                this.close();
            } catch (error) {
                console.error('Error saving user:', error);
                let message = 'Error saving user';

                if (error.response?.data?.errors) {
                    // Handle validation errors
                    const errors = error.response.data.errors;
                    const errorMessages = [];
                    Object.keys(errors).forEach(key => {
                        errorMessages.push(errors[key][0]);
                    });
                    message = errorMessages.join(', ');
                } else if (error.response?.data?.message) {
                    message = error.response.data.message;
                }

                this.handleApiError(error, message);
                this.$emit('error', error);
            } finally {
                this.saving = false;
            }
        }
    }
};
</script>
