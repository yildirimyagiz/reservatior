export enum SignalVisibility {
  PUBLIC = "PUBLIC",
  INTERNAL = "INTERNAL",
  PRIVATE = "PRIVATE",
}

export enum SignalCategory {
  AGENT = "AGENT",
  TENANT = "TENANT",
  LANDLORD = "LANDLORD",
}

export interface ReputationSignal {
  key: string;
  name: string;
  category: SignalCategory;
  visibility: SignalVisibility;
  weight: number;
  description: string;
}

const ALL_SIGNALS: ReputationSignal[] = [
  // AGENT SIGNALS
  { key: "success_rate", name: "Success Rate", category: SignalCategory.AGENT, visibility: SignalVisibility.PUBLIC, weight: 0.20, description: "Deals closed vs leads received" },
  { key: "response_speed", name: "Response Speed", category: SignalCategory.AGENT, visibility: SignalVisibility.PUBLIC, weight: 0.15, description: "Average time to respond to leads" },
  { key: "tenant_feedback", name: "Tenant Feedback", category: SignalCategory.AGENT, visibility: SignalVisibility.PUBLIC, weight: 0.15, description: "Average tenant review score" },
  { key: "landlord_feedback", name: "Landlord Feedback", category: SignalCategory.AGENT, visibility: SignalVisibility.PUBLIC, weight: 0.10, description: "Average landlord review score" },
  { key: "platform_loyalty", name: "Platform Loyalty", category: SignalCategory.AGENT, visibility: SignalVisibility.INTERNAL, weight: 0.15, description: "Tenure × transaction count × cross-platform consistency. Only computable from platform-internal data." },
  { key: "dispute_history_ratio", name: "Dispute History Ratio", category: SignalCategory.AGENT, visibility: SignalVisibility.INTERNAL, weight: 0.10, description: "Disputes filed against agent vs total transactions. Dispute resolution is platform-locked." },
  { key: "cross_party_consistency", name: "Cross-Party Consistency", category: SignalCategory.AGENT, visibility: SignalVisibility.INTERNAL, weight: 0.10, description: "Consistency between tenant and landlord feedback. Requires both parties to rate." },
  { key: "lead_to_viewing_ratio", name: "Lead-to-Viewing Ratio", category: SignalCategory.AGENT, visibility: SignalVisibility.PRIVATE, weight: 0.05, description: "Internal efficiency metric. Not shared externally." },

  // TENANT SIGNALS
  { key: "payment_reliability", name: "Payment Reliability", category: SignalCategory.TENANT, visibility: SignalVisibility.PUBLIC, weight: 0.25, description: "On-time payment ratio" },
  { key: "lease_completion", name: "Lease Completion", category: SignalCategory.TENANT, visibility: SignalVisibility.PUBLIC, weight: 0.20, description: "Completed leases vs terminated" },
  { key: "landlord_feedback_tenant", name: "Landlord Feedback", category: SignalCategory.TENANT, visibility: SignalVisibility.PUBLIC, weight: 0.15, description: "Average landlord review" },
  { key: "internal_behavior_score", name: "Internal Behavior Score", category: SignalCategory.TENANT, visibility: SignalVisibility.INTERNAL, weight: 0.20, description: "Communication quality, dispute behavior, inspection compliance. Only from platform interactions." },
  { key: "cross_reference_consistency", name: "Cross-Reference Consistency", category: SignalCategory.TENANT, visibility: SignalVisibility.INTERNAL, weight: 0.10, description: "Consistency across multiple property interactions. Requires multi-lease history." },
  { key: "referral_quality", name: "Referral Quality", category: SignalCategory.TENANT, visibility: SignalVisibility.PRIVATE, weight: 0.10, description: "Quality of tenant's referrals to other tenants." },

  // LANDLORD SIGNALS
  { key: "property_quality", name: "Property Quality", category: SignalCategory.LANDLORD, visibility: SignalVisibility.PUBLIC, weight: 0.20, description: "Average property condition score" },
  { key: "tenant_retention", name: "Tenant Retention", category: SignalCategory.LANDLORD, visibility: SignalVisibility.PUBLIC, weight: 0.20, description: "How long tenants stay" },
  { key: "maintenance_response", name: "Maintenance Response", category: SignalCategory.LANDLORD, visibility: SignalVisibility.PUBLIC, weight: 0.15, description: "Speed of maintenance resolution" },
  { key: "deposit_return_fairness", name: "Deposit Return Fairness", category: SignalCategory.LANDLORD, visibility: SignalVisibility.INTERNAL, weight: 0.20, description: "Fairness of deposit deductions. Only verifiable via platform escrow." },
  { key: "dispute_ratio_landlord", name: "Dispute Ratio", category: SignalCategory.LANDLORD, visibility: SignalVisibility.INTERNAL, weight: 0.15, description: "Disputes filed by tenants against this landlord. Platform-locked." },
  { key: "regulatory_compliance", name: "Regulatory Compliance", category: SignalCategory.LANDLORD, visibility: SignalVisibility.PRIVATE, weight: 0.10, description: "Safety certificate compliance. Private to platform." },
];

export class SignalRegistry {
  private signals: Map<string, ReputationSignal> = new Map();

  constructor() {
    for (const signal of ALL_SIGNALS) {
      this.signals.set(signal.key, signal);
    }
  }

  getSignal(key: string): ReputationSignal | undefined {
    return this.signals.get(key);
  }

  getAllSignals(): ReputationSignal[] {
    return ALL_SIGNALS;
  }

  getPublicSignals(): ReputationSignal[] {
    return ALL_SIGNALS.filter(s => s.visibility === SignalVisibility.PUBLIC);
  }

  getInternalSignals(): ReputationSignal[] {
    return ALL_SIGNALS.filter(s => s.visibility === SignalVisibility.INTERNAL);
  }

  getPrivateSignals(): ReputationSignal[] {
    return ALL_SIGNALS.filter(s => s.visibility === SignalVisibility.PRIVATE);
  }

  getSignalsByCategory(category: SignalCategory): ReputationSignal[] {
    return ALL_SIGNALS.filter(s => s.category === category);
  }

  getExportableSignals(): ReputationSignal[] {
    return ALL_SIGNALS.filter(s => s.visibility === SignalVisibility.PUBLIC);
  }

  getInternalWeight(): number {
    return ALL_SIGNALS
      .filter(s => s.visibility !== SignalVisibility.PUBLIC)
      .reduce((acc, s) => acc + s.weight, 0);
  }
}

export const signalRegistry = new SignalRegistry();
