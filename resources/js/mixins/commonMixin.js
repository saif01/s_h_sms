/**
 * Common Mixin
 * 
 * Provides common utilities and methods for all admin pages to reduce code duplication.
 * 
 * This mixin includes:
 * - Search functionality
 * - Loading/saving states
 * - Success/Error notification methods
 * - Date formatting utilities
 * - Authentication helpers
 * - API error handling
 * - Sorting functionality
 * - Common helper methods
 */
export default {
    data() {
        return {
            // Common search state
            search: '',

            // Sorting state
            sortBy: null,
            sortDirection: 'asc', // 'asc' or 'desc'

            // Loading states
            loading: false,
            saving: false
        };
    },

    methods: {
        /**
         * Show success notification
         * @param {string} message - Success message to display
         */
        showSuccess(message) {
            if (window.Toast) {
                window.Toast.fire({
                    icon: 'success',
                    title: message
                });
            } else {
                alert(message);
            }
        },

        /**
         * Show error notification
         * @param {string} message - Error message to display
         */
        showError(message) {
            if (window.Toast) {
                window.Toast.fire({
                    icon: 'error',
                    title: message
                });
            } else {
                alert(message);
            }
        },

        /**
         * Format date to locale string
         * @param {string|Date} date - Date to format
         * @returns {string} Formatted date string
         */
        formatDate(date) {
            if (!date) return '-';
            return new Date(date).toLocaleDateString();
        },

        /**
         * Format date with time
         * @param {string|Date} date - Date to format
         * @returns {string} Formatted date and time string
         */
        formatDateTime(date) {
            if (!date) return '-';
            return new Date(date).toLocaleString();
        },

        /**
         * Format date to DD/MM/YYYY format (e.g., 18/12/2025)
         * @param {string|Date} date - Date to format
         * @returns {string} Formatted date string in DD/MM/YYYY format
         */
        formatDateDDMMYYYY(date) {
            if (!date) return '';
            try {
                // Handle YYYY-MM-DD format directly (no timezone conversion)
                if (typeof date === 'string' && /^\d{4}-\d{2}-\d{2}$/.test(date)) {
                    const [year, month, day] = date.split('-');
                    return `${day}/${month}/${year}`;
                }

                const d = new Date(date);
                if (isNaN(d.getTime())) return '';

                const day = String(d.getDate()).padStart(2, '0');
                const month = String(d.getMonth() + 1).padStart(2, '0');
                const year = d.getFullYear();

                return `${day}/${month}/${year}`;
            } catch (error) {
                return date;
            }
        },

        /**
         * Format date to DD/MM/YYYY HH:MM format (e.g., 18/12/2025 14:30)
         * @param {string|Date} date - Date to format
         * @returns {string} Formatted date string in DD/MM/YYYY HH:MM format
         */
        formatDateDDMMYYYYHHMM(date) {
            if (!date) return '';
            try {
                const d = new Date(date);
                if (isNaN(d.getTime())) return '';

                const day = String(d.getDate()).padStart(2, '0');
                const month = String(d.getMonth() + 1).padStart(2, '0');
                const year = d.getFullYear();
                const hours = String(d.getHours()).padStart(2, '0');
                const minutes = String(d.getMinutes()).padStart(2, '0');

                return `${day}/${month}/${year} ${hours}:${minutes}`;
            } catch (error) {
                return date;
            }
        },

        /**
         * Format date to DD/MM/YYYY HH:MM AM/PM format (e.g., 18/12/2025 02:30 PM)
         * @param {string|Date} date - Date to format
         * @returns {string} Formatted date string in DD/MM/YYYY HH:MM AM/PM format
         */
        formatDateShort(date) {
            if (!date) return '-';
            try {
                const d = new Date(date);
                if (isNaN(d.getTime())) return '-';

                const day = String(d.getDate()).padStart(2, '0');
                const month = String(d.getMonth() + 1).padStart(2, '0');
                const year = d.getFullYear();

                let hours = d.getHours();
                const minutes = String(d.getMinutes()).padStart(2, '0');
                const ampm = hours >= 12 ? 'PM' : 'AM';
                hours = hours % 12;
                hours = hours ? hours : 12; // the hour '0' should be '12'
                const formattedHours = String(hours).padStart(2, '0');

                return `${day}/${month}/${year} ${formattedHours}:${minutes} ${ampm}`;
            } catch (error) {
                return date;
            }
        },

        /**
         * Get authentication token from localStorage
         * @returns {string|null} Authentication token
         */
        getAuthToken() {
            return localStorage.getItem('admin_token');
        },

        /**
         * Get axios headers with authentication
         * @returns {Object} Headers object with Authorization
         */
        getAuthHeaders() {
            return {
                Authorization: `Bearer ${this.getAuthToken()}`
            };
        },

        /**
         * Handle API error with user-friendly messages
         * @param {Error} error - Error object from axios
         * @param {string} defaultMessage - Default error message
         */
        handleApiError(error, defaultMessage = 'An error occurred') {
            console.error('API Error:', error);

            let message = defaultMessage;

            if (error.response?.data?.errors) {
                // Handle validation errors
                const errors = error.response.data.errors;
                const errorMessages = [];
                Object.keys(errors).forEach(key => {
                    if (Array.isArray(errors[key])) {
                        errorMessages.push(`${key}: ${errors[key][0]}`);
                    } else {
                        errorMessages.push(`${key}: ${errors[key]}`);
                    }
                });
                message = errorMessages.join('\n');
            } else if (error.response?.data?.message) {
                message = error.response.data.message;
            } else if (error.message) {
                message = error.message;
            }

            this.showError(message);
        },

        /**
         * Handle table header sort click
         * @param {string} field - Field name to sort by
         */
        handleSort(field) {
            if (this.sortBy === field) {
                // Toggle direction if same field
                this.sortDirection = this.sortDirection === 'asc' ? 'desc' : 'asc';
            } else {
                // New field, default to ascending
                this.sortBy = field;
                this.sortDirection = 'asc';
            }
        },

        /**
         * Get sort icon for table header
         * @param {string} field - Field name
         * @returns {string} Icon name
         */
        getSortIcon(field) {
            if (this.sortBy !== field) {
                return 'mdi-sort';
            }
            return this.sortDirection === 'asc' ? 'mdi-sort-ascending' : 'mdi-sort-descending';
        },

        /**
         * Reset sorting
         */
        resetSorting() {
            this.sortBy = null;
            this.sortDirection = 'asc';
        },

        /**
         * Custom value setter - matches DatePickerVuetify pattern
         * Dynamically sets a property value by field name
         * @param {string} fieldName - Name of the field to set
         * @param {*} fieldValue - Value to set
         */
        customValueSet(fieldName, fieldValue) {
            // Check if field exists in filters object
            if (this.filters && Object.prototype.hasOwnProperty.call(this.filters, fieldName)) {
                this.filters[fieldName] = fieldValue;
            }
            // Check if field exists at root level
            else if (Object.prototype.hasOwnProperty.call(this, fieldName)) {
                this[fieldName] = fieldValue;
            }
        }
    }
};


