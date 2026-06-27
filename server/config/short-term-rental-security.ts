/**
 * Reservatior Short-Term Rental Security Configuration
 * 
 * This configuration implements the "High-End Hospitality" model for safe short-term rentals.
 * It enforces quality standards, operational filters, and security measures to ensure
 * short-term rentals enhance rather than diminish residence prestige.
 */

export interface ShortTermRentalSecurityRule {
  countryCode: string;
  enabled: boolean;
  
  // Price Barrier & Duration Policies
  minimumNights: number;
  minimumNightsPeakSeason: number;
  minimumNightsHoliday: number;
  priceFloorMultiplier: number; // Multiplier of long-term rental rate
  
  // Operator Requirements
  requiresLicensedOperator: boolean;
  operatorVettingRequired: boolean;
  operatorInsuranceMinimum: number; // Minimum coverage in USD
  operatorBackgroundCheck: boolean;
  
  // Guest Screening
  guestIdentityVerification: boolean;
  guestBackgroundCheck: boolean;
  guestRatingMinimum: number;
  guestReviewsMinimum: number;
  
  // Physical Security
  separateGuestEntrance: boolean;
  smartElevatorRestriction: boolean;
  guestWristbandSystem: boolean;
  luggageHandlingZones: boolean;
  
  // Enforcement & Penalties
  noiseMonitoring: boolean;
  noiseThresholdDb: number;
  noiseViolationFine: number; // Per incident in local currency
  unauthorizedOccupantPenalty: number;
  threeStrikePolicy: boolean;
  securityDepositRequired: boolean;
  securityDepositAmount: number; // Multiplier of nightly rate
  
  // Operational Standards
  checkInProtocol: 'digital' | 'in-person' | 'hybrid';
  checkOutProtocol: 'digital' | 'in-person' | 'hybrid';
  houseRulesBriefing: boolean;
  twentyFourSevenConcierge: boolean;
  
  // Revenue & Quality
  ownerRevenueTransparency: boolean;
  qualityScoreMinimum: number;
  responseTimeMaximumHours: number;
}

export const SHORT_TERM_RENTAL_SECURITY_RULES: Record<string, ShortTermRentalSecurityRule> = {
  'TR': {
    countryCode: 'TR',
    enabled: true,
    
    // Price Barrier & Duration Policies
    minimumNights: 3,
    minimumNightsPeakSeason: 7,
    minimumNightsHoliday: 14,
    priceFloorMultiplier: 2.5, // 2.5x long-term rental rate
    
    // Operator Requirements
    requiresLicensedOperator: true,
    operatorVettingRequired: true,
    operatorInsuranceMinimum: 500000, // $500,000 USD coverage
    operatorBackgroundCheck: true,
    
    // Guest Screening
    guestIdentityVerification: true,
    guestBackgroundCheck: true,
    guestRatingMinimum: 4.0,
    guestReviewsMinimum: 3,
    
    // Physical Security
    separateGuestEntrance: true,
    smartElevatorRestriction: true,
    guestWristbandSystem: true,
    luggageHandlingZones: true,
    
    // Enforcement & Penalties
    noiseMonitoring: true,
    noiseThresholdDb: 55,
    noiseViolationFine: 5000, // ₺5,000 per incident
    unauthorizedOccupantPenalty: 10000, // ₺10,000
    threeStrikePolicy: true,
    securityDepositRequired: true,
    securityDepositAmount: 2, // 2x nightly rate
    
    // Operational Standards
    checkInProtocol: 'in-person',
    checkOutProtocol: 'in-person',
    houseRulesBriefing: true,
    twentyFourSevenConcierge: true,
    
    // Revenue & Quality
    ownerRevenueTransparency: true,
    qualityScoreMinimum: 4.5,
    responseTimeMaximumHours: 2
  },
  
  'AE': {
    countryCode: 'AE',
    enabled: true,
    
    minimumNights: 3,
    minimumNightsPeakSeason: 7,
    minimumNightsHoliday: 14,
    priceFloorMultiplier: 3.0,
    
    requiresLicensedOperator: true,
    operatorVettingRequired: true,
    operatorInsuranceMinimum: 1000000,
    operatorBackgroundCheck: true,
    
    guestIdentityVerification: true,
    guestBackgroundCheck: true,
    guestRatingMinimum: 4.5,
    guestReviewsMinimum: 5,
    
    separateGuestEntrance: true,
    smartElevatorRestriction: true,
    guestWristbandSystem: true,
    luggageHandlingZones: true,
    
    noiseMonitoring: true,
    noiseThresholdDb: 50,
    noiseViolationFine: 2000, // AED 2,000
    unauthorizedOccupantPenalty: 5000, // AED 5,000
    threeStrikePolicy: true,
    securityDepositRequired: true,
    securityDepositAmount: 3,
    
    checkInProtocol: 'hybrid',
    checkOutProtocol: 'hybrid',
    houseRulesBriefing: true,
    twentyFourSevenConcierge: true,
    
    ownerRevenueTransparency: true,
    qualityScoreMinimum: 4.8,
    responseTimeMaximumHours: 1
  },
  
  'ES': {
    countryCode: 'ES',
    enabled: true,
    
    minimumNights: 3,
    minimumNightsPeakSeason: 7,
    minimumNightsHoliday: 14,
    priceFloorMultiplier: 2.0,
    
    requiresLicensedOperator: true,
    operatorVettingRequired: true,
    operatorInsuranceMinimum: 300000,
    operatorBackgroundCheck: true,
    
    guestIdentityVerification: true,
    guestBackgroundCheck: true,
    guestRatingMinimum: 4.0,
    guestReviewsMinimum: 3,
    
    separateGuestEntrance: false, // Not always feasible in older buildings
    smartElevatorRestriction: true,
    guestWristbandSystem: false,
    luggageHandlingZones: true,
    
    noiseMonitoring: true,
    noiseThresholdDb: 55,
    noiseViolationFine: 600, // €600
    unauthorizedOccupantPenalty: 1500, // €1,500
    threeStrikePolicy: true,
    securityDepositRequired: true,
    securityDepositAmount: 2,
    
    checkInProtocol: 'hybrid',
    checkOutProtocol: 'hybrid',
    houseRulesBriefing: true,
    twentyFourSevenConcierge: true,
    
    ownerRevenueTransparency: true,
    qualityScoreMinimum: 4.5,
    responseTimeMaximumHours: 3
  },
  
  'UK': {
    countryCode: 'UK',
    enabled: true,
    
    minimumNights: 3,
    minimumNightsPeakSeason: 7,
    minimumNightsHoliday: 14,
    priceFloorMultiplier: 2.5,
    
    requiresLicensedOperator: true,
    operatorVettingRequired: true,
    operatorInsuranceMinimum: 500000,
    operatorBackgroundCheck: true,
    
    guestIdentityVerification: true,
    guestBackgroundCheck: true,
    guestRatingMinimum: 4.0,
    guestReviewsMinimum: 3,
    
    separateGuestEntrance: true,
    smartElevatorRestriction: true,
    guestWristbandSystem: false,
    luggageHandlingZones: true,
    
    noiseMonitoring: true,
    noiseThresholdDb: 50,
    noiseViolationFine: 500, // £500
    unauthorizedOccupantPenalty: 1000, // £1,000
    threeStrikePolicy: true,
    securityDepositRequired: true,
    securityDepositAmount: 2,
    
    checkInProtocol: 'hybrid',
    checkOutProtocol: 'hybrid',
    houseRulesBriefing: true,
    twentyFourSevenConcierge: true,
    
    ownerRevenueTransparency: true,
    qualityScoreMinimum: 4.5,
    responseTimeMaximumHours: 2
  },
  
  'US': {
    countryCode: 'US',
    enabled: true,
    
    minimumNights: 3,
    minimumNightsPeakSeason: 7,
    minimumNightsHoliday: 14,
    priceFloorMultiplier: 2.0,
    
    requiresLicensedOperator: true,
    operatorVettingRequired: true,
    operatorInsuranceMinimum: 1000000,
    operatorBackgroundCheck: true,
    
    guestIdentityVerification: true,
    guestBackgroundCheck: true,
    guestRatingMinimum: 4.0,
    guestReviewsMinimum: 3,
    
    separateGuestEntrance: true,
    smartElevatorRestriction: true,
    guestWristbandSystem: false,
    luggageHandlingZones: true,
    
    noiseMonitoring: true,
    noiseThresholdDb: 55,
    noiseViolationFine: 500, // $500
    unauthorizedOccupantPenalty: 1000, // $1,000
    threeStrikePolicy: true,
    securityDepositRequired: true,
    securityDepositAmount: 2,
    
    checkInProtocol: 'hybrid',
    checkOutProtocol: 'hybrid',
    houseRulesBriefing: true,
    twentyFourSevenConcierge: true,
    
    ownerRevenueTransparency: true,
    qualityScoreMinimum: 4.5,
    responseTimeMaximumHours: 2
  }
};

// Helper function to get security rules for a country
export function getShortTermRentalSecurityRules(countryCode: string): ShortTermRentalSecurityRule {
  return SHORT_TERM_RENTAL_SECURITY_RULES[countryCode] || SHORT_TERM_RENTAL_SECURITY_RULES['US'];
}

// Validation function to check if a booking meets security requirements
export interface BookingValidationRequest {
  countryCode: string;
  nights: number;
  isPeakSeason: boolean;
  isHoliday: boolean;
  nightlyRate: number;
  longTermRate: number;
  guestRating?: number;
  guestReviewCount?: number;
  operatorLicensed: boolean;
  operatorInsurance?: number;
}

export interface BookingValidationResult {
  valid: boolean;
  errors: string[];
  warnings: string[];
}

export function validateShortTermRentalBooking(request: BookingValidationRequest): BookingValidationResult {
  const rules = getShortTermRentalSecurityRules(request.countryCode);
  const errors: string[] = [];
  const warnings: string[] = [];
  
  if (!rules.enabled) {
    return { valid: true, errors: [], warnings: ['Short-term rentals not enabled for this country'] };
  }
  
  // Check minimum nights
  let minNights = rules.minimumNights;
  if (request.isPeakSeason) minNights = rules.minimumNightsPeakSeason;
  if (request.isHoliday) minNights = rules.minimumNightsHoliday;
  
  if (request.nights < minNights) {
    errors.push(`Minimum stay of ${minNights} nights required`);
  }
  
  // Check price floor
  const minPrice = request.longTermRate * rules.priceFloorMultiplier;
  if (request.nightlyRate < minPrice) {
    warnings.push(`Rate below recommended floor (${minPrice.toFixed(2)})`);
  }
  
  // Check operator requirements
  if (rules.requiresLicensedOperator && !request.operatorLicensed) {
    errors.push('Licensed operator required');
  }
  
  if (rules.operatorInsuranceMinimum && request.operatorInsurance && request.operatorInsurance < rules.operatorInsuranceMinimum) {
    errors.push(`Operator insurance below minimum (${rules.operatorInsuranceMinimum})`);
  }
  
  // Check guest requirements
  if (rules.guestRatingMinimum && request.guestRating && request.guestRating < rules.guestRatingMinimum) {
    errors.push(`Guest rating below minimum (${rules.guestRatingMinimum})`);
  }
  
  if (rules.guestReviewsMinimum && request.guestReviewCount && request.guestReviewCount < rules.guestReviewsMinimum) {
    warnings.push(`Guest has fewer than recommended reviews (${rules.guestReviewsMinimum})`);
  }
  
  return {
    valid: errors.length === 0,
    errors,
    warnings
  };
}

// Security incident tracking
export interface SecurityIncident {
  id: string;
  propertyId: string;
  bookingId: string;
  type: 'noise' | 'unauthorized_occupant' | 'property_damage' | 'rule_violation' | 'other';
  severity: 'low' | 'medium' | 'high' | 'critical';
  timestamp: Date;
  description: string;
  resolved: boolean;
  fineAmount?: number;
  strikeCount: number;
}

export function calculateSecurityFine(
  incidentType: SecurityIncident['type'],
  countryCode: string,
  strikeCount: number
): number {
  const rules = getShortTermRentalSecurityRules(countryCode);
  
  let baseFine = 0;
  switch (incidentType) {
    case 'noise':
      baseFine = rules.noiseViolationFine;
      break;
    case 'unauthorized_occupant':
      baseFine = rules.unauthorizedOccupantPenalty;
      break;
    case 'property_damage':
      baseFine = rules.unauthorizedOccupantPenalty * 2; // Higher penalty
      break;
    default:
      baseFine = rules.noiseViolationFine;
  }
  
  // Escalating fines based on strike count
  const multiplier = Math.pow(1.5, strikeCount);
  return Math.round(baseFine * multiplier);
}
