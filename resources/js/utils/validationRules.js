/**
 * Validation rules factory
 * Creates validation rules with access to component context methods
 * 
 * @param {Object} context - Component context with getFieldError method
 * @param {string} requiredFieldName - Field name to use for required validation (default: 'name')
 * @returns {Object} Validation rules object
 */
export function createValidationRules(context, requiredFieldName = 'name') {
    return {
        required: (value) => {
            // Check for backend errors if getFieldError method exists
            const backendError = context.getFieldError ? context.getFieldError(requiredFieldName) : null;
            if (backendError) return backendError;

            // Handle number types (for fields like category_id, unit_id, etc.)
            if (typeof value === 'number') {
                return value >= 0 || 'This field is required';
            }
            return !!value || 'This field is required';
        },
        email: (value) => {
            // Check for backend errors if getFieldError method exists
            const backendError = context.getFieldError ? context.getFieldError('email') : null;
            if (backendError) return backendError;
            return !value || /.+@.+\..+/.test(value) || 'Email must be valid';
        },
        maxLength: (max) => (value) => {
            if (!value) return true;
            return value.length <= max || `Maximum ${max} characters allowed`;
        },
        numeric: (value) => {
            if (value === '' || value === null) return true;
            return !isNaN(value) || 'Must be a valid number';
        },
        minValue: (min) => (value) => {
            if (value === '' || value === null) return true;
            return value >= min || `Value must be greater than or equal to ${min}`;
        },
        phone: value => {
            if (!value) return true;
            // Remove spaces, dashes, parentheses, and plus signs for validation
            const cleaned = value.replace(/[\s\-\(\)\+]/g, '');
            // Bangladeshi mobile: 01XXXXXXXXX (11 digits) or 8801XXXXXXXXX (13 digits)
            // Format: 01[3-9]XXXXXXXX (where 3-9 are operator codes: 013, 014, 015, 016, 017, 018, 019)
            const mobilePattern = /^(880)?01[3-9]\d{8}$/;
            // Bangladeshi landline: 0[2-9]XXXXXXX (area code 02-09 followed by 6-8 digits)
            const landlinePattern = /^0[2-9]\d{6,8}$/;
            if (mobilePattern.test(cleaned) || landlinePattern.test(cleaned)) {
                return true;
            }
            return 'Invalid Bangladeshi phone number format (e.g., 01712345678 or 02-1234567)';
        },
        mobile: value => {
            if (!value) return true;
            // Remove spaces, dashes, parentheses, and plus signs for validation
            const cleaned = value.replace(/[\s\-\(\)\+]/g, '');
            // Bangladeshi mobile: 01XXXXXXXXX (11 digits) or 8801XXXXXXXXX (13 digits)
            // Format: 01[3-9]XXXXXXXX (where 3-9 are operator codes: 013, 014, 015, 016, 017, 018, 019)
            const mobilePattern = /^(880)?01[3-9]\d{8}$/;
            if (mobilePattern.test(cleaned)) {
                return true;
            }
            return 'Invalid Bangladeshi mobile number. Must be 11 digits starting with 01 (e.g., 01712345678)';
        }
    };
}
