<template>
    <v-dialog :model-value="modelValue" @update:model-value="$emit('update:modelValue', $event)" max-width="700"
        scrollable>
        <v-card v-if="request">
            <v-card-title class="d-flex justify-space-between align-center">
                <span>Purchase Request Details</span>
                <v-chip :color="getStatusColor(request.status)" size="small">
                    {{ request.status }}
                </v-chip>
            </v-card-title>
            <v-card-text class="pa-0">
                <div class="pa-6">
                    <!-- Header Information -->
                    <v-row class="mb-4">
                        <v-col cols="12" md="6">
                            <div class="text-caption text-grey mb-1">PR Number</div>
                            <div class="text-h6 font-weight-bold">{{ request.pr_number }}</div>
                        </v-col>
                        <v-col cols="12" md="6">
                            <div class="text-caption text-grey mb-1">Request Date</div>
                            <div class="text-body-1">{{ formatDate(request.request_date) }}</div>
                        </v-col>
                    </v-row>

                    <!-- Warehouse -->
                    <v-row class="mb-4">
                        <v-col cols="12" md="6">
                            <div class="text-caption text-grey mb-1">Warehouse</div>
                            <div class="text-body-1 font-weight-medium">{{ request.warehouse?.name || 'N/A' }}</div>
                        </v-col>
                    </v-row>

                    <!-- User Information -->
                    <v-row class="mb-4">
                        <v-col cols="12" md="6">
                            <div class="text-caption text-grey mb-1">Requested By</div>
                            <div class="text-body-1">{{ request.requested_by?.name || '-' }}</div>
                        </v-col>
                        <v-col cols="12" md="6" v-if="request.approved_by">
                            <div class="text-caption text-grey mb-1">Approved By</div>
                            <div class="text-body-1">{{ request.approved_by?.name || '-' }}</div>
                        </v-col>
                    </v-row>

                    <v-row class="mb-4" v-if="request.approved_at">
                        <v-col cols="12" md="6">
                            <div class="text-caption text-grey mb-1">Approved At</div>
                            <div class="text-body-1">{{ formatDateTime(request.approved_at) }}</div>
                        </v-col>
                    </v-row>

                    <!-- Notes -->
                    <v-row class="mb-4" v-if="request.notes">
                        <v-col cols="12">
                            <div class="text-caption text-grey mb-1">Notes</div>
                            <div class="text-body-1">{{ request.notes }}</div>
                        </v-col>
                    </v-row>
                </div>
            </v-card-text>
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn @click="$emit('update:modelValue', false)" variant="text">Close</v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
</template>

<script>
export default {
    name: 'ViewPurchaseRequestDialog',
    props: {
        modelValue: {
            type: Boolean,
            default: false
        },
        request: {
            type: Object,
            default: null
        }
    },
    emits: ['update:modelValue'],
    methods: {
        formatDate(date) {
            if (!date) return 'N/A';
            return new Date(date).toLocaleDateString('en-US', {
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            });
        },
        formatDateTime(dateTime) {
            if (!dateTime) return 'N/A';
            return new Date(dateTime).toLocaleString('en-US', {
                year: 'numeric',
                month: 'long',
                day: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            });
        },
        getStatusColor(status) {
            const colors = {
                'pending': 'warning',
                'approved': 'success',
                'rejected': 'error',
                'converted': 'info'
            };
            return colors[status] || 'default';
        }
    }
};
</script>
