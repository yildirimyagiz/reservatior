/**
 * Insurance Provider Adapter Architecture
 *
 * Reservatior connects to external insurers via adapters. Adapters translate
 * Reservatior's normalized calls into provider-specific formats. Only the
 * `MockProviderAdapter` is implemented — future adapters (Allianz, AXA,
 * Türkiye Sigorta, Aksigorta) implement the same trait.
 */
export interface CreateQuoteRequest {
  externalPolicyId?: string;
  policyId?: string;
  rentalPlanId: string;
  productId: string;
  coverageAmount: number;
  currency: string;
  tenant: Record<string, any>;
  premiumRate?: number;
  premiumAmount?: number;
  effectiveFrom?: string;
  effectiveTo?: string;
}

export interface CreatePolicyRequest {
  quoteId: string;
  externalPolicyId?: string;
  tenant: Record<string, any>;
  property: Record<string, any>;
  coverageAmount: number;
  currency: string;
  premiumAmount: number;
  effectiveFrom?: string;
  effectiveTo?: string;
}

export interface SubmitClaimRequest {
  policyId: string;
  externalPolicyId?: string;
  claimType: string;
  amountRequested: number;
  currency: string;
  evidence: Record<string, any>;
  legalCaseId?: string;
}

export interface ProviderAdapterResult {
  success: boolean;
  externalId?: string;
  status?: string;
  error?: string;
}

export interface InsuranceProviderAdapter {
  createQuote(data: CreateQuoteRequest): Promise<ProviderAdapterResult>;
  createPolicy(data: CreatePolicyRequest): Promise<ProviderAdapterResult>;
  cancelPolicy(externalPolicyId: string): Promise<ProviderAdapterResult>;
  submitClaim(data: SubmitClaimRequest): Promise<ProviderAdapterResult>;
  getClaimStatus(externalClaimId: string): Promise<ProviderAdapterResult>;
}

/**
 * Deterministic mock adapter for tests and local/dev flows.
 * `failNextCall` simulates provider outages so failure handling can be tested.
 */
export class MockProviderAdapter implements InsuranceProviderAdapter {
  private failNext: boolean = false;

  /** Simulate a provider outage for the next adapter call. */
  setFailNextCall(fail: boolean = true) {
    this.failNext = fail;
  }

  private maybeFail(): void {
    if (this.failNext) {
      this.failNext = false;
      throw new Error("MockProviderAdapter: simulated provider outage");
    }
  }

  async createQuote(data: CreateQuoteRequest) {
    this.maybeFail();
    const premium = data.premiumAmount ?? Number((data.premiumRate ?? 0.02) * data.coverageAmount);
    return { success: true, externalId: `MQ-${Date.now()}`, status: "QUOTE", premium };
  }

  async createPolicy(data: CreatePolicyRequest) {
    this.maybeFail();
    return { success: true, externalId: `MP-${Date.now()}`, status: "ACTIVE" };
  }

  async cancelPolicy(externalPolicyId: string) {
    this.maybeFail();
    return { success: true, externalId: externalPolicyId, status: "CANCELLED" };
  }

  async submitClaim(data: SubmitClaimRequest) {
    this.maybeFail();
    return { success: true, externalId: `MC-${Date.now()}`, status: "SUBMITTED" };
  }

  async getClaimStatus(externalClaimId: string) {
    this.maybeFail();
    return { success: true, externalId: externalClaimId, status: "UNDER_REVIEW" };
  }
}

/**
 * Registry for provider adapters. Mock is registered by default; real
 * adapters can be registered at startup once credentials are configured.
 */
class ProviderAdapterRegistry {
  private adapters = new Map<string, InsuranceProviderAdapter>();

  register(providerName: string, adapter: InsuranceProviderAdapter) {
    this.adapters.set(providerName.toLowerCase(), adapter);
  }

  get(providerName: string): InsuranceProviderAdapter {
    const adapter = this.adapters.get(providerName.toLowerCase());
    if (!adapter) {
      // Fall back to mock for safety in dev/unknown providers.
      return this.adapters.get("mock")!;
    }
    return adapter;
  }

  has(providerName: string): boolean {
    return this.adapters.has(providerName.toLowerCase());
  }
}

export const providerAdapterRegistry = new ProviderAdapterRegistry();
providerAdapterRegistry.register("mock", new MockProviderAdapter());
