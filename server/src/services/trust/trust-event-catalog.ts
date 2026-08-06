/**
 * Trust Event Catalog
 * 
 * Defines all trust-related events that can be recorded in the system.
 * Each event has a category, impact weight, and description.
 */

export enum TrustEventCategory {
  PAYMENT = "PAYMENT",
  LEASE = "LEASE",
  PROPERTY_CARE = "PROPERTY_CARE",
  COMMUNICATION = "COMMUNICATION",
  VERIFICATION = "VERIFICATION",
  DISPUTE = "DISPUTE",
  MAINTENANCE = "MAINTENANCE",
  RESPONSIVENESS = "RESPONSIVENESS",
  COMPLIANCE = "COMPLIANCE",
  SATISFACTION = "SATISFACTION",
  PERFORMANCE = "PERFORMANCE",
  ACCURACY = "ACCURACY",
  CONDITION = "CONDITION",
  LOCATION = "LOCATION",
  LEGAL = "LEGAL",
}

export interface TrustEventDefinition {
  eventType: string;
  category: TrustEventCategory;
  defaultImpact: number;
  description: string;
  applicableTo: string[]; // TENANT, LANDLORD, AGENT, PROPERTY, TRANSACTION
}

export const TRUST_EVENT_CATALOG: Record<string, TrustEventDefinition> = {
  // Payment Events
  PAYMENT_ON_TIME: {
    eventType: "PAYMENT_ON_TIME",
    category: TrustEventCategory.PAYMENT,
    defaultImpact: 5,
    description: "Payment made on or before due date",
    applicableTo: ["TENANT", "LANDLORD"],
  },
  PAYMENT_LATE: {
    eventType: "PAYMENT_LATE",
    category: TrustEventCategory.PAYMENT,
    defaultImpact: -3,
    description: "Payment made after due date",
    applicableTo: ["TENANT", "LANDLORD"],
  },
  PAYMENT_MISSED: {
    eventType: "PAYMENT_MISSED",
    category: TrustEventCategory.PAYMENT,
    defaultImpact: -10,
    description: "Payment not made",
    applicableTo: ["TENANT", "LANDLORD"],
  },
  PAYMENT_DISPUTE: {
    eventType: "PAYMENT_DISPUTE",
    category: TrustEventCategory.PAYMENT,
    defaultImpact: -5,
    description: "Payment disputed",
    applicableTo: ["TENANT", "LANDLORD"],
  },

  // Lease Events
  LEASE_COMPLETED: {
    eventType: "LEASE_COMPLETED",
    category: TrustEventCategory.LEASE,
    defaultImpact: 10,
    description: "Lease completed successfully",
    applicableTo: ["TENANT", "LANDLORD"],
  },
  LEASE_EARLY_TERMINATION: {
    eventType: "LEASE_EARLY_TERMINATION",
    category: TrustEventCategory.LEASE,
    defaultImpact: -5,
    description: "Lease terminated early",
    applicableTo: ["TENANT", "LANDLORD"],
  },
  LEASE_RENEWED: {
    eventType: "LEASE_RENEWED",
    category: TrustEventCategory.LEASE,
    defaultImpact: 8,
    description: "Lease renewed successfully",
    applicableTo: ["TENANT", "LANDLORD"],
  },

  // Property Care Events
  PROPERTY_WELL_MAINTAINED: {
    eventType: "PROPERTY_WELL_MAINTAINED",
    category: TrustEventCategory.PROPERTY_CARE,
    defaultImpact: 5,
    description: "Property maintained in good condition",
    applicableTo: ["TENANT", "LANDLORD", "PROPERTY"],
  },
  PROPERTY_DAMAGE_REPORTED: {
    eventType: "PROPERTY_DAMAGE_REPORTED",
    category: TrustEventCategory.PROPERTY_CARE,
    defaultImpact: -3,
    description: "Property damage reported",
    applicableTo: ["TENANT", "LANDLORD", "PROPERTY"],
  },
  MAINTENANCE_REQUEST_RESOLVED: {
    eventType: "MAINTENANCE_REQUEST_RESOLVED",
    category: TrustEventCategory.PROPERTY_CARE,
    defaultImpact: 3,
    description: "Maintenance request resolved",
    applicableTo: ["LANDLORD", "PROPERTY"],
  },
  MAINTENANCE_REQUEST_DELAYED: {
    eventType: "MAINTENANCE_REQUEST_DELAYED",
    category: TrustEventCategory.PROPERTY_CARE,
    defaultImpact: -2,
    description: "Maintenance request delayed",
    applicableTo: ["LANDLORD", "PROPERTY"],
  },

  // Communication Events
  COMMUNICATION_PROMPT: {
    eventType: "COMMUNICATION_PROMPT",
    category: TrustEventCategory.COMMUNICATION,
    defaultImpact: 3,
    description: "Prompt response to communication",
    applicableTo: ["TENANT", "LANDLORD", "AGENT"],
  },
  COMMUNICATION_DELAYED: {
    eventType: "COMMUNICATION_DELAYED",
    category: TrustEventCategory.COMMUNICATION,
    defaultImpact: -2,
    description: "Delayed response to communication",
    applicableTo: ["TENANT", "LANDLORD", "AGENT"],
  },
  COMMUNICATION_IGNORED: {
    eventType: "COMMUNICATION_IGNORED",
    category: TrustEventCategory.COMMUNICATION,
    defaultImpact: -5,
    description: "Communication ignored",
    applicableTo: ["TENANT", "LANDLORD", "AGENT"],
  },

  // Verification Events
  IDENTITY_VERIFIED: {
    eventType: "IDENTITY_VERIFIED",
    category: TrustEventCategory.VERIFICATION,
    defaultImpact: 10,
    description: "Identity successfully verified",
    applicableTo: ["TENANT", "LANDLORD", "AGENT"],
  },
  BACKGROUND_CHECK_PASSED: {
    eventType: "BACKGROUND_CHECK_PASSED",
    category: TrustEventCategory.VERIFICATION,
    defaultImpact: 8,
    description: "Background check passed",
    applicableTo: ["TENANT", "LANDLORD", "AGENT"],
  },
  LICENSE_VERIFIED: {
    eventType: "LICENSE_VERIFIED",
    category: TrustEventCategory.VERIFICATION,
    defaultImpact: 10,
    description: "Professional license verified",
    applicableTo: ["AGENT"],
  },
  VERIFICATION_FAILED: {
    eventType: "VERIFICATION_FAILED",
    category: TrustEventCategory.VERIFICATION,
    defaultImpact: -15,
    description: "Verification failed",
    applicableTo: ["TENANT", "LANDLORD", "AGENT"],
  },

  // Dispute Events
  DISPUTE_RESOLVED_AMICABLY: {
    eventType: "DISPUTE_RESOLVED_AMICABLY",
    category: TrustEventCategory.DISPUTE,
    defaultImpact: 5,
    description: "Dispute resolved amicably",
    applicableTo: ["TENANT", "LANDLORD", "TRANSACTION"],
  },
  DISPUTE_ESCALATED: {
    eventType: "DISPUTE_ESCALATED",
    category: TrustEventCategory.DISPUTE,
    defaultImpact: -8,
    description: "Dispute escalated to higher authority",
    applicableTo: ["TENANT", "LANDLORD", "TRANSACTION"],
  },
  DISPUTE_LOST: {
    eventType: "DISPUTE_LOST",
    category: TrustEventCategory.DISPUTE,
    defaultImpact: -10,
    description: "Dispute lost",
    applicableTo: ["TENANT", "LANDLORD", "TRANSACTION"],
  },

  // Maintenance Events
  MAINTENANCE_SCHEDULED: {
    eventType: "MAINTENANCE_SCHEDULED",
    category: TrustEventCategory.MAINTENANCE,
    defaultImpact: 3,
    description: "Maintenance scheduled proactively",
    applicableTo: ["LANDLORD", "PROPERTY"],
  },
  MAINTENANCE_COMPLETED: {
    eventType: "MAINTENANCE_COMPLETED",
    category: TrustEventCategory.MAINTENANCE,
    defaultImpact: 5,
    description: "Maintenance completed on time",
    applicableTo: ["LANDLORD", "PROPERTY"],
  },
  EMERGENCY_REPAIR_HANDLED: {
    eventType: "EMERGENCY_REPAIR_HANDLED",
    category: TrustEventCategory.MAINTENANCE,
    defaultImpact: 8,
    description: "Emergency repair handled promptly",
    applicableTo: ["LANDLORD", "PROPERTY"],
  },

  // Responsiveness Events
  QUICK_RESPONSE: {
    eventType: "QUICK_RESPONSE",
    category: TrustEventCategory.RESPONSIVENESS,
    defaultImpact: 4,
    description: "Response within 24 hours",
    applicableTo: ["LANDLORD", "AGENT"],
  },
  SLOW_RESPONSE: {
    eventType: "SLOW_RESPONSE",
    category: TrustEventCategory.RESPONSIVENESS,
    defaultImpact: -3,
    description: "Response after 48 hours",
    applicableTo: ["LANDLORD", "AGENT"],
  },
  NO_RESPONSE: {
    eventType: "NO_RESPONSE",
    category: TrustEventCategory.RESPONSIVENESS,
    defaultImpact: -7,
    description: "No response after 72 hours",
    applicableTo: ["LANDLORD", "AGENT"],
  },

  // Compliance Events
  COMPLIANCE_MET: {
    eventType: "COMPLIANCE_MET",
    category: TrustEventCategory.COMPLIANCE,
    defaultImpact: 5,
    description: "Compliance requirements met",
    applicableTo: ["LANDLORD", "PROPERTY", "AGENT"],
  },
  COMPLIANCE_VIOLATION: {
    eventType: "COMPLIANCE_VIOLATION",
    category: TrustEventCategory.COMPLIANCE,
    defaultImpact: -10,
    description: "Compliance violation detected",
    applicableTo: ["LANDLORD", "PROPERTY", "AGENT"],
  },
  INSPECTION_PASSED: {
    eventType: "INSPECTION_PASSED",
    category: TrustEventCategory.COMPLIANCE,
    defaultImpact: 8,
    description: "Property inspection passed",
    applicableTo: ["LANDLORD", "PROPERTY"],
  },

  // Satisfaction Events
  POSITIVE_REVIEW: {
    eventType: "POSITIVE_REVIEW",
    category: TrustEventCategory.SATISFACTION,
    defaultImpact: 5,
    description: "Received positive review (4+ stars)",
    applicableTo: ["TENANT", "LANDLORD", "AGENT", "PROPERTY"],
  },
  NEGATIVE_REVIEW: {
    eventType: "NEGATIVE_REVIEW",
    category: TrustEventCategory.SATISFACTION,
    defaultImpact: -5,
    description: "Received negative review (2 or fewer stars)",
    applicableTo: ["TENANT", "LANDLORD", "AGENT", "PROPERTY"],
  },
  REPEAT_CLIENT: {
    eventType: "REPEAT_CLIENT",
    category: TrustEventCategory.SATISFACTION,
    defaultImpact: 10,
    description: "Client returned for another transaction",
    applicableTo: ["AGENT", "LANDLORD"],
  },

  // Performance Events
  DEAL_CLOSED: {
    eventType: "DEAL_CLOSED",
    category: TrustEventCategory.PERFORMANCE,
    defaultImpact: 8,
    description: "Successfully closed a deal",
    applicableTo: ["AGENT"],
  },
  TARGET_ACHIEVED: {
    eventType: "TARGET_ACHIEVED",
    category: TrustEventCategory.PERFORMANCE,
    defaultImpact: 6,
    description: "Achieved performance target",
    applicableTo: ["AGENT"],
  },
  HIGH_CONVERSION_RATE: {
    eventType: "HIGH_CONVERSION_RATE",
    category: TrustEventCategory.PERFORMANCE,
    defaultImpact: 5,
    description: "High lead conversion rate",
    applicableTo: ["AGENT"],
  },

  // Accuracy Events
  CONTRACT_ACCURATE: {
    eventType: "CONTRACT_ACCURATE",
    category: TrustEventCategory.ACCURACY,
    defaultImpact: 5,
    description: "Contract details accurate",
    applicableTo: ["AGENT", "LANDLORD", "TRANSACTION"],
  },
  DOCUMENTATION_COMPLETE: {
    eventType: "DOCUMENTATION_COMPLETE",
    category: TrustEventCategory.ACCURACY,
    defaultImpact: 4,
    description: "All documentation complete",
    applicableTo: ["AGENT", "LANDLORD", "TRANSACTION"],
  },
  INFORMATION_ACCURATE: {
    eventType: "INFORMATION_ACCURATE",
    category: TrustEventCategory.ACCURACY,
    defaultImpact: 3,
    description: "Provided accurate information",
    applicableTo: ["AGENT", "LANDLORD", "PROPERTY"],
  },

  // Condition Events
  PROPERTY_EXCELLENT_CONDITION: {
    eventType: "PROPERTY_EXCELLENT_CONDITION",
    category: TrustEventCategory.CONDITION,
    defaultImpact: 5,
    description: "Property in excellent condition",
    applicableTo: ["PROPERTY", "LANDLORD"],
  },
  PROPERTY_POOR_CONDITION: {
    eventType: "PROPERTY_POOR_CONDITION",
    category: TrustEventCategory.CONDITION,
    defaultImpact: -8,
    description: "Property in poor condition",
    applicableTo: ["PROPERTY", "LANDLORD"],
  },
  IMPROVEMENTS_MADE: {
    eventType: "IMPROVEMENTS_MADE",
    category: TrustEventCategory.CONDITION,
    defaultImpact: 4,
    description: "Property improvements made",
    applicableTo: ["PROPERTY", "LANDLORD"],
  },

  // Location Events
  PRIME_LOCATION: {
    eventType: "PRIME_LOCATION",
    category: TrustEventCategory.LOCATION,
    defaultImpact: 5,
    description: "Property in prime location",
    applicableTo: ["PROPERTY"],
  },
  SAFE_NEIGHBORHOOD: {
    eventType: "SAFE_NEIGHBORHOOD",
    category: TrustEventCategory.LOCATION,
    defaultImpact: 4,
    description: "Located in safe neighborhood",
    applicableTo: ["PROPERTY"],
  },
  GOOD_AMENITIES: {
    eventType: "GOOD_AMENITIES",
    category: TrustEventCategory.LOCATION,
    defaultImpact: 3,
    description: "Good local amenities",
    applicableTo: ["PROPERTY"],
  },

  // Legal Events
  LEGAL_COMPLIANT: {
    eventType: "LEGAL_COMPLIANT",
    category: TrustEventCategory.LEGAL,
    defaultImpact: 5,
    description: "All legal requirements met",
    applicableTo: ["LANDLORD", "PROPERTY", "AGENT"],
  },
  ZONING_VERIFIED: {
    eventType: "ZONING_VERIFIED",
    category: TrustEventCategory.LEGAL,
    defaultImpact: 4,
    description: "Zoning verified",
    applicableTo: ["PROPERTY", "LANDLORD"],
  },
  PERMITS_VALID: {
    eventType: "PERMITS_VALID",
    category: TrustEventCategory.LEGAL,
    defaultImpact: 4,
    description: "All permits valid",
    applicableTo: ["PROPERTY", "LANDLORD"],
  },
};

export class TrustEventCatalog {
  static getEventDefinition(eventType: string): TrustEventDefinition | undefined {
    return TRUST_EVENT_CATALOG[eventType];
  }

  static getEventsByCategory(category: TrustEventCategory): TrustEventDefinition[] {
    return Object.values(TRUST_EVENT_CATALOG).filter(
      (event) => event.category === category
    );
  }

  static getEventsForEntityType(entityType: string): TrustEventDefinition[] {
    return Object.values(TRUST_EVENT_CATALOG).filter((event) =>
      event.applicableTo.includes(entityType)
    );
  }

  static getAllEvents(): TrustEventDefinition[] {
    return Object.values(TRUST_EVENT_CATALOG);
  }

  static calculateCustomImpact(eventType: string, baseImpact: number): number {
    const definition = TRUST_EVENT_CATALOG[eventType];
    if (!definition) return baseImpact;
    
    // Allow custom impact to deviate from default by up to 50%
    const maxDeviation = definition.defaultImpact * 0.5;
    const deviation = baseImpact - definition.defaultImpact;
    
    if (Math.abs(deviation) > maxDeviation) {
      return definition.defaultImpact + Math.sign(deviation) * maxDeviation;
    }
    
    return baseImpact;
  }
}
