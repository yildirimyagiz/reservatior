/**
 * Subscription Tiers Configuration
 * Defines pricing and feature limits for different subscription packages
 */

export interface SubscriptionTierConfig {
  name: string;
  type: string;
  price: number;
  currency: string;
  billingCycle: 'MONTHLY' | 'YEARLY';
  
  // Property & Listing Limits
  maxProperties: number;
  maxListings: number;
  featuredListings: number;
  boostedListings: number;
  
  // Marketing & Advertising
  socialMediaPosts: number;
  googleAdsCredits: number;
  adCredits: number;
  
  // Tag Allowances (FEATURED, URGENT, PRICE_DROP, DISCOUNT)
  tagAllowances: {
    FEATURED: number;
    URGENT: number;
    PRICE_DROP: number;
    DISCOUNT: number;
  };
  
  // Support & API
  prioritySupport: boolean;
  apiAccess: boolean;
  commissionDiscount: number;
  loyaltyMultiplier: number;
  
  // Features
  features: string[];
}

export const SUBSCRIPTION_TIERS: Record<string, SubscriptionTierConfig> = {
  STARTER: {
    name: 'Starter',
    type: 'STARTER',
    price: 0,
    currency: 'USD',
    billingCycle: 'MONTHLY',
    maxProperties: 1,
    maxListings: 3,
    featuredListings: 0,
    boostedListings: 0,
    socialMediaPosts: 0,
    googleAdsCredits: 0,
    adCredits: 0,
    tagAllowances: {
      FEATURED: 0,
      URGENT: 0,
      PRICE_DROP: 0,
      DISCOUNT: 0
    },
    prioritySupport: false,
    apiAccess: false,
    commissionDiscount: 0,
    loyaltyMultiplier: 1.0,
    features: [
      'Basic listing management',
      'Standard support',
      'Property analytics dashboard'
    ]
  },
  
  BASIC: {
    name: 'Basic',
    type: 'BASIC',
    price: 29.99,
    currency: 'USD',
    billingCycle: 'MONTHLY',
    maxProperties: 5,
    maxListings: 10,
    featuredListings: 1,
    boostedListings: 2,
    socialMediaPosts: 5,
    googleAdsCredits: 50,
    adCredits: 25,
    tagAllowances: {
      FEATURED: 1,
      URGENT: 2,
      PRICE_DROP: 3,
      DISCOUNT: 3
    },
    prioritySupport: false,
    apiAccess: false,
    commissionDiscount: 0.05,
    loyaltyMultiplier: 1.1,
    features: [
      'Up to 5 properties',
      '10 listings per month',
      '1 featured listing',
      '2 boosted listings',
      '5 social media posts',
      '$50 Google Ads credit',
      '5% commission discount',
      'Standard support'
    ]
  },
  
  PROFESSIONAL: {
    name: 'Professional',
    type: 'PROFESSIONAL',
    price: 79.99,
    currency: 'USD',
    billingCycle: 'MONTHLY',
    maxProperties: 15,
    maxListings: 50,
    featuredListings: 5,
    boostedListings: 10,
    socialMediaPosts: 20,
    googleAdsCredits: 200,
    adCredits: 100,
    tagAllowances: {
      FEATURED: 5,
      URGENT: 10,
      PRICE_DROP: 15,
      DISCOUNT: 15
    },
    prioritySupport: true,
    apiAccess: false,
    commissionDiscount: 0.10,
    loyaltyMultiplier: 1.25,
    features: [
      'Up to 15 properties',
      '50 listings per month',
      '5 featured listings',
      '10 boosted listings',
      '20 social media posts',
      '$200 Google Ads credit',
      '10% commission discount',
      'Priority support',
      'Advanced analytics',
      'Lead management system'
    ]
  },
  
  AGENCY: {
    name: 'Agency',
    type: 'AGENCY',
    price: 199.99,
    currency: 'USD',
    billingCycle: 'MONTHLY',
    maxProperties: 50,
    maxListings: 200,
    featuredListings: 20,
    boostedListings: 50,
    socialMediaPosts: 100,
    googleAdsCredits: 500,
    adCredits: 250,
    tagAllowances: {
      FEATURED: 20,
      URGENT: 50,
      PRICE_DROP: 75,
      DISCOUNT: 75
    },
    prioritySupport: true,
    apiAccess: true,
    commissionDiscount: 0.15,
    loyaltyMultiplier: 1.5,
    features: [
      'Up to 50 properties',
      '200 listings per month',
      '20 featured listings',
      '50 boosted listings',
      '100 social media posts',
      '$500 Google Ads credit',
      '15% commission discount',
      'Priority support',
      'Full API access',
      'Team collaboration tools',
      'White-label options',
      'Custom branding'
    ]
  },
  
  ENTERPRISE: {
    name: 'Enterprise',
    type: 'ENTERPRISE',
    price: 499.99,
    currency: 'USD',
    billingCycle: 'MONTHLY',
    maxProperties: 999,
    maxListings: 9999,
    featuredListings: 100,
    boostedListings: 500,
    socialMediaPosts: 1000,
    googleAdsCredits: 2000,
    adCredits: 1000,
    tagAllowances: {
      FEATURED: 100,
      URGENT: 500,
      PRICE_DROP: 1000,
      DISCOUNT: 1000
    },
    prioritySupport: true,
    apiAccess: true,
    commissionDiscount: 0.20,
    loyaltyMultiplier: 2.0,
    features: [
      'Unlimited properties',
      'Unlimited listings',
      '100 featured listings',
      '500 boosted listings',
      '1000 social media posts',
      '$2000 Google Ads credit',
      '20% commission discount',
      '24/7 dedicated support',
      'Full API access',
      'Custom integrations',
      'Dedicated account manager',
      'Custom reporting',
      'SLA guarantee',
      'Multi-region deployment'
    ]
  }
};

/**
 * Tag pricing configuration with tier-based discounts
 */
export const TAG_PRICING: Record<string, { basePrice: number; duration: number; tierPricing: Record<string, number> }> = {
  FEATURED: {
    basePrice: 49.99,
    duration: 7,
    tierPricing: {
      STARTER: 49.99,
      BASIC: 39.99,
      PROFESSIONAL: 29.99,
      AGENCY: 19.99,
      ENTERPRISE: 0
    }
  },
  URGENT: {
    basePrice: 29.99,
    duration: 3,
    tierPricing: {
      STARTER: 29.99,
      BASIC: 24.99,
      PROFESSIONAL: 19.99,
      AGENCY: 14.99,
      ENTERPRISE: 0
    }
  },
  PRICE_DROP: {
    basePrice: 19.99,
    duration: 5,
    tierPricing: {
      STARTER: 19.99,
      BASIC: 14.99,
      PROFESSIONAL: 9.99,
      AGENCY: 4.99,
      ENTERPRISE: 0
    }
  },
  DISCOUNT: {
    basePrice: 14.99,
    duration: 7,
    tierPricing: {
      STARTER: 14.99,
      BASIC: 9.99,
      PROFESSIONAL: 4.99,
      AGENCY: 2.99,
      ENTERPRISE: 0
    }
  }
};

/**
 * Get tag price based on subscription tier
 */
export function getTagPrice(tagName: string, subscriptionType: string): number {
  const tag = TAG_PRICING[tagName];
  if (!tag) return 0;
  return tag.tierPricing[subscriptionType] || tag.basePrice;
}

/**
 * Get subscription tier config
 */
export function getSubscriptionTier(tierType: string): SubscriptionTierConfig | null {
  return SUBSCRIPTION_TIERS[tierType] || null;
}

/**
 * Check if user has enough tag allowance
 */
export function hasTagAllowance(
  subscriptionType: string,
  tagName: string,
  usedTags: number
): boolean {
  const tier = SUBSCRIPTION_TIERS[subscriptionType];
  if (!tier) return false;
  const allowance = tier.tagAllowances[tagName as keyof typeof tier.tagAllowances] || 0;
  return usedTags < allowance;
}
