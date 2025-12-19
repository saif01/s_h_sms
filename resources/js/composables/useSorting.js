import { ref } from 'vue';

/**
 * Composable for managing table sorting
 * Works with both Options API and Composition API
 * 
 * @param {Object} options - Configuration options
 * @param {string} options.defaultField - Default field to sort by
 * @param {string} options.defaultDirection - Default sort direction ('asc' or 'desc')
 * @param {Function} options.onSortChange - Callback function when sort changes
 * @returns {Object} Sorting state and methods
 */
export function useSorting(options = {}) {
    const {
        defaultField = 'name',
        defaultDirection = 'asc',
        onSortChange = null
    } = options;

    const sortByField = ref(defaultField);
    const sortDirection = ref(defaultDirection);

    /**
     * Sort by a specific field
     * @param {string} field - Field name to sort by
     */
    const sortBy = (field) => {
        if (sortByField.value === field) {
            // Toggle direction if same field
            sortDirection.value = sortDirection.value === 'asc' ? 'desc' : 'asc';
        } else {
            // New field, default to ascending
            sortByField.value = field;
            sortDirection.value = 'asc';
        }

        // Call callback if provided
        if (onSortChange && typeof onSortChange === 'function') {
            onSortChange(sortByField.value, sortDirection.value);
        }
    };

    /**
     * Reset sorting to defaults
     */
    const resetSort = () => {
        sortByField.value = defaultField;
        sortDirection.value = defaultDirection;
        if (onSortChange && typeof onSortChange === 'function') {
            onSortChange(sortByField.value, sortDirection.value);
        }
    };

    /**
     * Get sort parameters for API requests
     * @returns {Object} Object with sort_by and sort_direction
     */
    const getSortParams = () => {
        return {
            sort_by: sortByField.value,
            sort_direction: sortDirection.value
        };
    };

    /**
     * Check if a field is currently being sorted
     * @param {string} field - Field name to check
     * @returns {boolean} True if field is the current sort field
     */
    const isSortingBy = (field) => {
        return sortByField.value === field;
    };

    /**
     * Get sort direction for a specific field
     * @param {string} field - Field name to check
     * @returns {string|null} 'asc', 'desc', or null if not sorting by this field
     */
    const getSortDirection = (field) => {
        if (sortByField.value === field) {
            return sortDirection.value;
        }
        return null;
    };

    return {
        sortByField,
        sortDirection,
        sortBy,
        resetSort,
        getSortParams,
        isSortingBy,
        getSortDirection
    };
}

/**
 * Options API mixin for sorting functionality
 * Use this in Vue 2 or Options API components
 */
export const sortingMixin = {
    data() {
        return {
            sortByField: 'name',
            sortDirection: 'asc',
        };
    },
    methods: {
        sortBy(field) {
            if (this.sortByField === field) {
                // Toggle direction if same field
                this.sortDirection = this.sortDirection === 'asc' ? 'desc' : 'asc';
            } else {
                // New field, default to ascending
                this.sortByField = field;
                this.sortDirection = 'asc';
            }

            // Call onSortChange if defined
            if (this.onSortChange && typeof this.onSortChange === 'function') {
                this.onSortChange(this.sortByField, this.sortDirection);
            }
        },
        getSortParams() {
            return {
                sort_by: this.sortByField,
                sort_direction: this.sortDirection
            };
        },
        isSortingBy(field) {
            return this.sortByField === field;
        },
        getSortDirection(field) {
            if (this.sortByField === field) {
                return this.sortDirection;
            }
            return null;
        },
        resetSort() {
            this.sortByField = 'name';
            this.sortDirection = 'asc';
            if (this.onSortChange && typeof this.onSortChange === 'function') {
                this.onSortChange(this.sortByField, this.sortDirection);
            }
        }
    }
};

