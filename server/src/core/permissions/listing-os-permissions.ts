/**
 * Listing OS Permission Model
 * Defines granular permissions for listing operations
 */

export const ListingOSPermissions = {
  // Listing Management
  LISTING_CREATE: 'listing.create',
  LISTING_READ: 'listing.read',
  LISTING_UPDATE: 'listing.update',
  LISTING_DELETE: 'listing.delete',
  LISTING_PUBLISH: 'listing.publish',
  LISTING_UNPUBLISH: 'listing.unpublish',
  
  // Listing Content
  LISTING_MANAGE_IMAGES: 'listing.manage_images',
  LISTING_MANAGE_VIDEOS: 'listing.manage_videos',
  LISTING_MANAGE_DESCRIPTION: 'listing.manage_description',
  LISTING_MANAGE_AMENITIES: 'listing.manage_amenities',
  LISTING_MANAGE_PRICING: 'listing.manage_pricing',
  LISTING_MANAGE_AVAILABILITY: 'listing.manage_availability',
  
  // Listing Operations
  LISTING_FEATURE: 'listing.feature',
  LISTING_PROMOTE: 'listing.promote',
  LISTING_DUPLICATE: 'listing.duplicate',
  LISTING_ARCHIVE: 'listing.archive',
  LISTING_RESTORE: 'listing.restore',
  
  // Property Management
  PROPERTY_CREATE: 'property.create',
  PROPERTY_READ: 'property.read',
  PROPERTY_UPDATE: 'property.update',
  PROPERTY_DELETE: 'property.delete',
  PROPERTY_MANAGE_DETAILS: 'property.manage_details',
  
  // Market Analysis
  MARKET_ANALYSIS_VIEW: 'market_analysis.view',
  MARKET_ANALYSIS_ADVANCED: 'market_analysis.advanced',
  MARKET_COMPETITORS_VIEW: 'market_competitors.view',
  
  // Pricing Operations
  PRICING_DYNAMIC: 'pricing.dynamic',
  PRICING_MANUAL: 'pricing.manual',
  PRICING_STRATEGY: 'pricing.strategy',
  PRICING_HISTORY_VIEW: 'pricing.history_view',
  
  // Analytics Operations
  ANALYTICS_VIEW: 'analytics.view',
  ANALYTICS_EXPORT: 'analytics.export',
  ANALYTICS_ADVANCED: 'analytics.advanced',
  
  // Integration Operations
  MLS_SYNC: 'mls.sync',
  CHANNEL_MANAGE: 'channel.manage',
  INTEGRATION_MANAGE: 'integration.manage',
  
  // Review Management
  REVIEW_MANAGE: 'review.manage',
  REVIEW_RESPOND: 'review.respond',
  REVIEW_MODERATE: 'review.moderate',
  
  // Admin Operations
  LISTING_ADMIN_ALL: 'listing.admin.all',
  LISTING_ADMIN_OVERRIDE: 'listing.admin.override',
  LISTING_ADMIN_AUDIT: 'listing.admin.audit',
} as const;

export type ListingOSPermission = typeof ListingOSPermissions[keyof typeof ListingOSPermissions];

/**
 * Role-based permission mappings
 */
export const ListingOSRolePermissions: Record<string, ListingOSPermission[]> = {
  // Guest - Basic viewing
  guest: [
    ListingOSPermissions.LISTING_READ,
    ListingOSPermissions.PROPERTY_READ,
    ListingOSPermissions.MARKET_ANALYSIS_VIEW,
    ListingOSPermissions.ANALYTICS_VIEW,
  ],
  
  // Agent - Full listing management
  agent: [
    ListingOSPermissions.LISTING_CREATE,
    ListingOSPermissions.LISTING_READ,
    ListingOSPermissions.LISTING_UPDATE,
    ListingOSPermissions.LISTING_DELETE,
    ListingOSPermissions.LISTING_PUBLISH,
    ListingOSPermissions.LISTING_UNPUBLISH,
    ListingOSPermissions.LISTING_MANAGE_IMAGES,
    ListingOSPermissions.LISTING_MANAGE_VIDEOS,
    ListingOSPermissions.LISTING_MANAGE_DESCRIPTION,
    ListingOSPermissions.LISTING_MANAGE_AMENITIES,
    ListingOSPermissions.LISTING_MANAGE_PRICING,
    ListingOSPermissions.LISTING_MANAGE_AVAILABILITY,
    ListingOSPermissions.LISTING_FEATURE,
    ListingOSPermissions.LISTING_PROMOTE,
    ListingOSPermissions.LISTING_DUPLICATE,
    ListingOSPermissions.LISTING_ARCHIVE,
    ListingOSPermissions.PROPERTY_CREATE,
    ListingOSPermissions.PROPERTY_READ,
    ListingOSPermissions.PROPERTY_UPDATE,
    ListingOSPermissions.PROPERTY_MANAGE_DETAILS,
    ListingOSPermissions.MARKET_ANALYSIS_VIEW,
    ListingOSPermissions.MARKET_ANALYSIS_ADVANCED,
    ListingOSPermissions.MARKET_COMPETITORS_VIEW,
    ListingOSPermissions.PRICING_DYNAMIC,
    ListingOSPermissions.PRICING_MANUAL,
    ListingOSPermissions.PRICING_STRATEGY,
    ListingOSPermissions.PRICING_HISTORY_VIEW,
    ListingOSPermissions.ANALYTICS_VIEW,
    ListingOSPermissions.ANALYTICS_EXPORT,
    ListingOSPermissions.MLS_SYNC,
    ListingOSPermissions.CHANNEL_MANAGE,
    ListingOSPermissions.REVIEW_MANAGE,
    ListingOSPermissions.REVIEW_RESPOND,
  ],
  
  // Property Manager - Extended operations
  property_manager: [
    ListingOSPermissions.LISTING_CREATE,
    ListingOSPermissions.LISTING_READ,
    ListingOSPermissions.LISTING_UPDATE,
    ListingOSPermissions.LISTING_DELETE,
    ListingOSPermissions.LISTING_PUBLISH,
    ListingOSPermissions.LISTING_UNPUBLISH,
    ListingOSPermissions.LISTING_MANAGE_IMAGES,
    ListingOSPermissions.LISTING_MANAGE_VIDEOS,
    ListingOSPermissions.LISTING_MANAGE_DESCRIPTION,
    ListingOSPermissions.LISTING_MANAGE_AMENITIES,
    ListingOSPermissions.LISTING_MANAGE_PRICING,
    ListingOSPermissions.LISTING_MANAGE_AVAILABILITY,
    ListingOSPermissions.LISTING_FEATURE,
    ListingOSPermissions.LISTING_PROMOTE,
    ListingOSPermissions.LISTING_DUPLICATE,
    ListingOSPermissions.LISTING_ARCHIVE,
    ListingOSPermissions.LISTING_RESTORE,
    ListingOSPermissions.PROPERTY_CREATE,
    ListingOSPermissions.PROPERTY_READ,
    ListingOSPermissions.PROPERTY_UPDATE,
    ListingOSPermissions.PROPERTY_DELETE,
    ListingOSPermissions.PROPERTY_MANAGE_DETAILS,
    ListingOSPermissions.MARKET_ANALYSIS_VIEW,
    ListingOSPermissions.MARKET_ANALYSIS_ADVANCED,
    ListingOSPermissions.MARKET_COMPETITORS_VIEW,
    ListingOSPermissions.PRICING_DYNAMIC,
    ListingOSPermissions.PRICING_MANUAL,
    ListingOSPermissions.PRICING_STRATEGY,
    ListingOSPermissions.PRICING_HISTORY_VIEW,
    ListingOSPermissions.ANALYTICS_VIEW,
    ListingOSPermissions.ANALYTICS_EXPORT,
    ListingOSPermissions.ANALYTICS_ADVANCED,
    ListingOSPermissions.MLS_SYNC,
    ListingOSPermissions.CHANNEL_MANAGE,
    ListingOSPermissions.INTEGRATION_MANAGE,
    ListingOSPermissions.REVIEW_MANAGE,
    ListingOSPermissions.REVIEW_RESPOND,
    ListingOSPermissions.REVIEW_MODERATE,
  ],
  
  // Marketing Manager - Focus on promotion
  marketing_manager: [
    ListingOSPermissions.LISTING_READ,
    ListingOSPermissions.LISTING_UPDATE,
    ListingOSPermissions.LISTING_FEATURE,
    ListingOSPermissions.LISTING_PROMOTE,
    ListingOSPermissions.LISTING_MANAGE_IMAGES,
    ListingOSPermissions.LISTING_MANAGE_VIDEOS,
    ListingOSPermissions.LISTING_MANAGE_DESCRIPTION,
    ListingOSPermissions.MARKET_ANALYSIS_VIEW,
    ListingOSPermissions.MARKET_ANALYSIS_ADVANCED,
    ListingOSPermissions.MARKET_COMPETITORS_VIEW,
    ListingOSPermissions.PRICING_DYNAMIC,
    ListingOSPermissions.PRICING_STRATEGY,
    ListingOSPermissions.ANALYTICS_VIEW,
    ListingOSPermissions.ANALYTICS_EXPORT,
    ListingOSPermissions.CHANNEL_MANAGE,
  ],
  
  // Admin - Full access
  admin: [
    ListingOSPermissions.LISTING_ADMIN_ALL,
    ListingOSPermissions.LISTING_ADMIN_OVERRIDE,
    ListingOSPermissions.LISTING_ADMIN_AUDIT,
  ],
};

/**
 * Permission validation helper
 */
export function hasListingPermission(
  userPermissions: string[],
  requiredPermission: ListingOSPermission
): boolean {
  if (userPermissions.includes(ListingOSPermissions.LISTING_ADMIN_ALL)) {
    return true;
  }
  return userPermissions.includes(requiredPermission);
}

/**
 * Batch permission validation
 */
export function hasListingPermissions(
  userPermissions: string[],
  requiredPermissions: ListingOSPermission[]
): boolean {
  return requiredPermissions.every(permission => 
    hasListingPermission(userPermissions, permission)
  );
}
