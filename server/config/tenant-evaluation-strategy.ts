/**
 * Reservatior Tenant Evaluation Strategy
 * 
 * This strategy balances security screening with marketing effectiveness by using
 * a progressive verification approach. Security is marketed as a premium feature
 * rather than a barrier, increasing trust and conversion rates.
 */

export interface TenantEvaluationCriteria {
  id: string;
  category: 'identity' | 'financial' | 'behavioral' | 'social';
  weight: number; // 0-100, higher = more important
  required: boolean; // Must pass to proceed
  visibleToUser: boolean; // Shown to user during evaluation
  description: string;
  marketingBenefit: string; // How this benefits the user (for marketing)
}

export const TENANT_EVALUATION_CRITERIA: TenantEvaluationCriteria[] = [
  // IDENTITY VERIFICATION (High Weight, Required, Visible)
  {
    id: 'government_id',
    category: 'identity',
    weight: 90,
    required: true,
    visibleToUser: true,
    description: 'Government-issued ID verification (passport, national ID, driver\'s license)',
    marketingBenefit: 'Verified identity ensures a safe community for everyone'
  },
  {
    id: 'email_verification',
    category: 'identity',
    weight: 70,
    required: true,
    visibleToUser: true,
    description: 'Email address verification through secure link',
    marketingBenefit: 'Secure communication channel for your bookings'
  },
  {
    id: 'phone_verification',
    category: 'identity',
    weight: 75,
    required: true,
    visibleToUser: true,
    description: 'Phone number verification via SMS code',
    marketingBenefit: 'Instant support and emergency contact capability'
  },
  
  // FINANCIAL RELIABILITY (Medium Weight, Required, Partially Visible)
  {
    id: 'payment_method',
    category: 'financial',
    weight: 60,
    required: true,
    visibleToUser: true,
    description: 'Valid payment method on file (credit card, bank transfer)',
    marketingBenefit: 'Seamless booking experience with secure payments'
  },
  {
    id: 'booking_deposit',
    category: 'financial',
    weight: 65,
    required: true,
    visibleToUser: true,
    description: 'Ability to provide security deposit',
    marketingBenefit: 'Protects your stay and guarantees property care'
  },
  {
    id: 'income_verification',
    category: 'financial',
    weight: 40,
    required: false,
    visibleToUser: false, // Hidden, used for risk scoring only
    description: 'Optional income verification for long-term stays',
    marketingBenefit: 'Enables premium property access'
  },
  
  // BEHAVIORAL HISTORY (High Weight, Required, Visible)
  {
    id: 'previous_rental_history',
    category: 'behavioral',
    weight: 80,
    required: false, // Not required for first-time users
    visibleToUser: true,
    description: 'Previous rental history and landlord references',
    marketingBenefit: 'Build your rental reputation for better properties'
  },
  {
    id: 'platform_reviews',
    category: 'behavioral',
    weight: 85,
    required: false,
    visibleToUser: true,
    description: 'Review history from previous stays on Reservatior or partner platforms',
    marketingBenefit: 'Great reviews unlock exclusive properties and discounts'
  },
  {
    id: 'cancellation_history',
    category: 'behavioral',
    weight: 50,
    required: false,
    visibleToUser: false, // Used for internal scoring
    description: 'Historical cancellation patterns',
    marketingBenefit: 'Reliable guests get priority booking'
  },
  
  // SOCIAL PROOF (Medium Weight, Not Required, Visible)
  {
    id: 'social_media_linking',
    category: 'social',
    weight: 30,
    required: false,
    visibleToUser: true,
    description: 'Optional LinkedIn or professional profile linking',
    marketingBenefit: 'Professional verification builds host trust'
  },
  {
    id: 'emergency_contacts',
    category: 'social',
    weight: 45,
    required: true,
    visibleToUser: true,
    description: 'Emergency contact information',
    marketingBenefit: '24/7 safety support during your stay'
  },
  {
    id: 'travel_purpose',
    category: 'social',
    weight: 35,
    required: true,
    visibleToUser: true,
    description: 'Purpose of travel (business, leisure, family, etc.)',
    marketingBenefit: 'Personalized recommendations and local tips'
  }
];

export interface TenantScore {
  overall: number; // 0-100
  identity: number;
  financial: number;
  behavioral: number;
  social: number;
  tier: 'bronze' | 'silver' | 'gold' | 'platinum';
  benefits: string[];
}

export interface ProgressiveVerificationStage {
  stage: number;
  name: string;
  requiredCriteria: string[];
  timeToComplete: string; // e.g., "2 minutes"
  conversionGate: boolean; // If true, user cannot proceed without completing
  marketingMessage: string;
}

export const PROGRESSIVE_VERIFICATION_STAGES: ProgressiveVerificationStage[] = [
  {
    stage: 1,
    name: 'Quick Start',
    requiredCriteria: ['email_verification', 'phone_verification'],
    timeToComplete: '2 minutes',
    conversionGate: false, // Can browse, limited booking
    marketingMessage: 'Start browsing properties in under 2 minutes'
  },
  {
    stage: 2,
    name: 'Verified Guest',
    requiredCriteria: ['government_id', 'payment_method', 'emergency_contacts'],
    timeToComplete: '5 minutes',
    conversionGate: true, // Must complete to book
    marketingMessage: 'Book any property with verified identity'
  },
  {
    stage: 3,
    name: 'Trusted Traveler',
    requiredCriteria: ['booking_deposit', 'travel_purpose', 'platform_reviews'],
    timeToComplete: '10 minutes',
    conversionGate: false, // Optional for premium benefits
    marketingMessage: 'Unlock premium properties and exclusive discounts'
  },
  {
    stage: 4,
    name: 'Elite Member',
    requiredCriteria: ['previous_rental_history', 'social_media_linking'],
    timeToComplete: '15 minutes',
    conversionGate: false, // Optional for highest tier
    marketingMessage: 'Access luxury residences and VIP treatment'
  }
];

export interface MarketingMessaging {
  securityAngle: string;
  benefitAngle: string;
  exclusivityAngle: string;
  trustAngle: string;
}

export const MARKETING_MESSAGING: Record<string, MarketingMessaging> = {
  verification: {
    securityAngle: 'Your safety is our priority. Every guest is verified.',
    benefitAngle: 'Verified guests get 24/7 support and priority assistance.',
    exclusivityAngle: 'Join the verified community for exclusive property access.',
    trustAngle: 'Hosts prefer verified guests — book with confidence.'
  },
  scoring: {
    securityAngle: 'Smart matching ensures the right guests for the right properties.',
    benefitAngle: 'Higher scores unlock better properties and lower rates.',
    exclusivityAngle: 'Top-tier guests access luxury residences before others.',
    trustAngle: 'Your reliability score builds trust with premium hosts.'
  },
  progressive: {
    securityAngle: 'Start simple, add more verification as you go.',
    benefitAngle: 'Each verification stage unlocks new benefits and properties.',
    exclusivityAngle: 'Progressive verification leads to elite membership.',
    trustAngle: 'Build your reputation over time for better opportunities.'
  }
};

export function calculateTenantScore(
  completedCriteria: string[],
  criteriaScores: Record<string, number>
): TenantScore {
  let totalScore = 0;
  let totalWeight = 0;
  
  const categoryScores = {
    identity: 0,
    financial: 0,
    behavioral: 0,
    social: 0
  };
  
  const categoryWeights = {
    identity: 0,
    financial: 0,
    behavioral: 0,
    social: 0
  };
  
  TENANT_EVALUATION_CRITERIA.forEach(criteria => {
    const isCompleted = completedCriteria.includes(criteria.id);
    const score = isCompleted ? (criteriaScores[criteria.id] || 100) : 0;
    
    totalScore += score * criteria.weight;
    totalWeight += criteria.weight;
    
    categoryScores[criteria.category] += score * criteria.weight;
    categoryWeights[criteria.category] += criteria.weight;
  });
  
  const overall = totalWeight > 0 ? Math.round(totalScore / totalWeight) : 0;
  
  const identity = categoryWeights.identity > 0 
    ? Math.round(categoryScores.identity / categoryWeights.identity) 
    : 0;
  const financial = categoryWeights.financial > 0 
    ? Math.round(categoryScores.financial / categoryWeights.financial) 
    : 0;
  const behavioral = categoryWeights.behavioral > 0 
    ? Math.round(categoryScores.behavioral / categoryWeights.behavioral) 
    : 0;
  const social = categoryWeights.social > 0 
    ? Math.round(categoryScores.social / categoryWeights.social) 
    : 0;
  
  let tier: 'bronze' | 'silver' | 'gold' | 'platinum';
  let benefits: string[];
  
  if (overall >= 85) {
    tier = 'platinum';
    benefits = [
      'Access to all properties including luxury residences',
      'Priority booking and 24/7 concierge',
      'Exclusive discounts and flexible cancellation',
      'VIP treatment and premium support'
    ];
  } else if (overall >= 70) {
    tier = 'gold';
    benefits = [
      'Access to premium properties',
      'Priority customer support',
      'Flexible cancellation policies',
      'Exclusive member discounts'
    ];
  } else if (overall >= 50) {
    tier = 'silver';
    benefits = [
      'Access to standard properties',
      'Standard customer support',
      'Standard cancellation policies',
      'Member-only promotions'
    ];
  } else {
    tier = 'bronze';
    benefits = [
      'Access to basic properties',
      'Email support',
      'Standard cancellation policies',
      'Community access'
    ];
  }
  
  return {
    overall,
    identity,
    financial,
    behavioral,
    social,
    tier,
    benefits
  };
}

export function getMarketingMessageForStage(stage: number): string {
  const stageConfig = PROGRESSIVE_VERIFICATION_STAGES.find(s => s.stage === stage);
  return stageConfig?.marketingMessage || 'Complete verification to unlock more features';
}

export function getRequiredCriteriaForStage(stage: number): string[] {
  const stageConfig = PROGRESSIVE_VERIFICATION_STAGES.find(s => s.stage === stage);
  return stageConfig?.requiredCriteria || [];
}

export function isConversionGate(stage: number): boolean {
  const stageConfig = PROGRESSIVE_VERIFICATION_STAGES.find(s => s.stage === stage);
  return stageConfig?.conversionGate || false;
}

// Marketing-friendly evaluation headings
export const EVALUATION_HEADINGS = {
  quickStart: {
    title: 'Quick Start Verification',
    subtitle: 'Begin your journey in 2 minutes',
    description: 'Basic verification to start browsing properties',
    icon: 'zap'
  },
  verifiedGuest: {
    title: 'Verified Guest Status',
    subtitle: 'Book with confidence',
    description: 'Complete identity verification for full booking access',
    icon: 'shield-check'
  },
  trustedTraveler: {
    title: 'Trusted Traveler Program',
    subtitle: 'Unlock premium benefits',
    description: 'Enhanced verification for exclusive property access',
    icon: 'award'
  },
  eliteMember: {
    title: 'Elite Membership',
    subtitle: 'VIP treatment awaits',
    description: 'Complete verification for luxury residence access',
    icon: 'crown'
  },
  reliabilityScore: {
    title: 'Your Reliability Score',
    subtitle: 'Build trust, unlock benefits',
    description: 'Higher scores lead to better properties and rates',
    icon: 'trending-up'
  }
};
