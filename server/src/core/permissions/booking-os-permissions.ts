/**
 * Booking OS Permission Model
 * Defines granular permissions for booking operations
 */

export const BookingOSPermissions = {
  // Booking Management
  BOOKING_CREATE: 'booking.create',
  BOOKING_READ: 'booking.read',
  BOOKING_UPDATE: 'booking.update',
  BOOKING_DELETE: 'booking.delete',
  BOOKING_CANCEL: 'booking.cancel',
  
  // Booking Operations
  BOOKING_CHECK_IN: 'booking.check_in',
  BOOKING_CHECK_OUT: 'booking.check_out',
  BOOKING_MODIFY: 'booking.modify',
  BOOKING_EXTEND: 'booking.extend',
  
  // Payment Operations
  BOOKING_PAYMENT_PROCESS: 'booking.payment.process',
  BOOKING_PAYMENT_REFUND: 'booking.payment.refund',
  BOOKING_PAYMENT_VIEW: 'booking.payment.view',
  
  // Guest Operations
  BOOKING_GUEST_MANAGE: 'booking.guest.manage',
  BOOKING_GUEST_VIEW: 'booking.guest.view',
  
  // Property Operations
  BOOKING_PROPERTY_MANAGE: 'booking.property.manage',
  BOOKING_PROPERTY_VIEW: 'booking.property.view',
  
  // Review Operations
  BOOKING_REVIEW_CREATE: 'booking.review.create',
  BOOKING_REVIEW_VIEW: 'booking.review.view',
  BOOKING_REVIEW_MODERATE: 'booking.review.moderate',
  
  // Dispute Operations
  BOOKING_DISPUTE_CREATE: 'booking.dispute.create',
  BOOKING_DISPUTE_RESOLVE: 'booking.dispute.resolve',
  BOOKING_DISPUTE_VIEW: 'booking.dispute.view',
  
  // Analytics Operations
  BOOKING_ANALYTICS_VIEW: 'booking.analytics.view',
  BOOKING_ANALYTICS_EXPORT: 'booking.analytics.export',
  BOOKING_REPORTS_VIEW: 'booking.reports.view',
  
  // Calendar Operations
  BOOKING_CALENDAR_VIEW: 'booking.calendar.view',
  BOOKING_CALENDAR_MANAGE: 'booking.calendar.manage',
  BOOKING_AVAILABILITY_MANAGE: 'booking.availability.manage',
  
  // Pricing Operations
  BOOKING_PRICING_VIEW: 'booking.pricing.view',
  BOOKING_PRICING_MANAGE: 'booking.pricing.manage',
  BOOKING_PRICING_DYNAMIC: 'booking.pricing.dynamic',
  
  // Integration Operations
  BOOKING_INTEGRATION_MANAGE: 'booking.integration.manage',
  BOOKING_WEBHOOK_MANAGE: 'booking.webhook.manage',
  
  // Admin Operations
  BOOKING_ADMIN_ALL: 'booking.admin.all',
  BOOKING_ADMIN_OVERRIDE: 'booking.admin.override',
  BOOKING_ADMIN_AUDIT: 'booking.admin.audit',
} as const;

export type BookingOSPermission = typeof BookingOSPermissions[keyof typeof BookingOSPermissions];

/**
 * Role-based permission mappings
 */
export const BookingOSRolePermissions: Record<string, BookingOSPermission[]> = {
  // Guest - Basic booking operations
  guest: [
    BookingOSPermissions.BOOKING_READ,
    BookingOSPermissions.BOOKING_CREATE,
    BookingOSPermissions.BOOKING_CANCEL,
    BookingOSPermissions.BOOKING_PAYMENT_VIEW,
    BookingOSPermissions.BOOKING_REVIEW_CREATE,
    BookingOSPermissions.BOOKING_REVIEW_VIEW,
    BookingOSPermissions.BOOKING_DISPUTE_CREATE,
  ],
  
  // Host - Property management
  host: [
    BookingOSPermissions.BOOKING_READ,
    BookingOSPermissions.BOOKING_CREATE,
    BookingOSPermissions.BOOKING_CANCEL,
    BookingOSPermissions.BOOKING_PAYMENT_VIEW,
    BookingOSPermissions.BOOKING_REVIEW_CREATE,
    BookingOSPermissions.BOOKING_REVIEW_VIEW,
    BookingOSPermissions.BOOKING_DISPUTE_CREATE,
    BookingOSPermissions.BOOKING_UPDATE,
    BookingOSPermissions.BOOKING_CHECK_IN,
    BookingOSPermissions.BOOKING_CHECK_OUT,
    BookingOSPermissions.BOOKING_MODIFY,
    BookingOSPermissions.BOOKING_PAYMENT_PROCESS,
    BookingOSPermissions.BOOKING_GUEST_MANAGE,
    BookingOSPermissions.BOOKING_GUEST_VIEW,
    BookingOSPermissions.BOOKING_PROPERTY_MANAGE,
    BookingOSPermissions.BOOKING_PROPERTY_VIEW,
    BookingOSPermissions.BOOKING_REVIEW_MODERATE,
    BookingOSPermissions.BOOKING_DISPUTE_RESOLVE,
    BookingOSPermissions.BOOKING_ANALYTICS_VIEW,
    BookingOSPermissions.BOOKING_CALENDAR_VIEW,
    BookingOSPermissions.BOOKING_CALENDAR_MANAGE,
    BookingOSPermissions.BOOKING_AVAILABILITY_MANAGE,
    BookingOSPermissions.BOOKING_PRICING_VIEW,
    BookingOSPermissions.BOOKING_PRICING_MANAGE,
  ],
  
  // Property Manager - Extended operations
  property_manager: [
    BookingOSPermissions.BOOKING_READ,
    BookingOSPermissions.BOOKING_CREATE,
    BookingOSPermissions.BOOKING_CANCEL,
    BookingOSPermissions.BOOKING_PAYMENT_VIEW,
    BookingOSPermissions.BOOKING_REVIEW_CREATE,
    BookingOSPermissions.BOOKING_REVIEW_VIEW,
    BookingOSPermissions.BOOKING_DISPUTE_CREATE,
    BookingOSPermissions.BOOKING_UPDATE,
    BookingOSPermissions.BOOKING_CHECK_IN,
    BookingOSPermissions.BOOKING_CHECK_OUT,
    BookingOSPermissions.BOOKING_MODIFY,
    BookingOSPermissions.BOOKING_PAYMENT_PROCESS,
    BookingOSPermissions.BOOKING_GUEST_MANAGE,
    BookingOSPermissions.BOOKING_GUEST_VIEW,
    BookingOSPermissions.BOOKING_PROPERTY_MANAGE,
    BookingOSPermissions.BOOKING_PROPERTY_VIEW,
    BookingOSPermissions.BOOKING_REVIEW_MODERATE,
    BookingOSPermissions.BOOKING_DISPUTE_RESOLVE,
    BookingOSPermissions.BOOKING_ANALYTICS_VIEW,
    BookingOSPermissions.BOOKING_CALENDAR_VIEW,
    BookingOSPermissions.BOOKING_CALENDAR_MANAGE,
    BookingOSPermissions.BOOKING_AVAILABILITY_MANAGE,
    BookingOSPermissions.BOOKING_PRICING_VIEW,
    BookingOSPermissions.BOOKING_PRICING_MANAGE,
    BookingOSPermissions.BOOKING_PAYMENT_REFUND,
    BookingOSPermissions.BOOKING_EXTEND,
    BookingOSPermissions.BOOKING_ANALYTICS_EXPORT,
    BookingOSPermissions.BOOKING_REPORTS_VIEW,
    BookingOSPermissions.BOOKING_PRICING_DYNAMIC,
    BookingOSPermissions.BOOKING_INTEGRATION_MANAGE,
  ],
  
  // Revenue Manager - Financial focus
  revenue_manager: [
    BookingOSPermissions.BOOKING_READ,
    BookingOSPermissions.BOOKING_PAYMENT_VIEW,
    BookingOSPermissions.BOOKING_PAYMENT_PROCESS,
    BookingOSPermissions.BOOKING_PAYMENT_REFUND,
    BookingOSPermissions.BOOKING_ANALYTICS_VIEW,
    BookingOSPermissions.BOOKING_ANALYTICS_EXPORT,
    BookingOSPermissions.BOOKING_REPORTS_VIEW,
    BookingOSPermissions.BOOKING_PRICING_VIEW,
    BookingOSPermissions.BOOKING_PRICING_MANAGE,
    BookingOSPermissions.BOOKING_PRICING_DYNAMIC,
  ],
  
  // Support Agent - Dispute resolution
  support_agent: [
    BookingOSPermissions.BOOKING_READ,
    BookingOSPermissions.BOOKING_UPDATE,
    BookingOSPermissions.BOOKING_CANCEL,
    BookingOSPermissions.BOOKING_DISPUTE_VIEW,
    BookingOSPermissions.BOOKING_DISPUTE_RESOLVE,
    BookingOSPermissions.BOOKING_GUEST_VIEW,
    BookingOSPermissions.BOOKING_PROPERTY_VIEW,
  ],
  
  // Admin - Full access
  admin: [
    BookingOSPermissions.BOOKING_ADMIN_ALL,
    BookingOSPermissions.BOOKING_ADMIN_OVERRIDE,
    BookingOSPermissions.BOOKING_ADMIN_AUDIT,
  ],
};

/**
 * Permission validation helper
 */
export function hasBookingPermission(
  userPermissions: string[],
  requiredPermission: BookingOSPermission
): boolean {
  if (userPermissions.includes(BookingOSPermissions.BOOKING_ADMIN_ALL)) {
    return true;
  }
  return userPermissions.includes(requiredPermission);
}

/**
 * Batch permission validation
 */
export function hasBookingPermissions(
  userPermissions: string[],
  requiredPermissions: BookingOSPermission[]
): boolean {
  return requiredPermissions.every(permission => 
    hasBookingPermission(userPermissions, permission)
  );
}
