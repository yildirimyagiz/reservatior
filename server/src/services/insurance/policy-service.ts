import { Prisma, InsurancePolicyStatus } from "@prisma/client";
import { prisma } from "../../lib/prisma";
import { InsurancePricingEngine, insurancePricingEngine } from "./pricing-engine";
import { providerAdapterRegistry } from "./provider-adapter";
import { publishInsuranceEvent, InsuranceEvents } from "./insurance-events";

/**
 * Policy Service — manages the RentalInsurancePolicy lifecycle.
 *
 * Flow: QUOTE → (provider createPolicy) → ACTIVE → (premium paid each cycle)
 * Termination: CANCELLED / EXPIRED / CLAIMED.
 *
 * Premium belongs to the insurance provider. Reservatior only routes payments
 * (see InsurancePaymentTransaction) and never holds insurance liability.
 */
export class PolicyService {
  constructor(
    private readonly pricing: InsurancePricingEngine = insurancePricingEngine,
    private readonly db: typeof prisma = prisma,
  ) {}

  /**
   * Generate a risk-priced quote for a rental plan. Creates a policy row in
   * QUOTE status and publishes InsuranceQuoteCreated.
   */
  async createQuote(input: {
    rentalPlanId: string;
    providerId: string;
    productId: string;
    tenantId?: string;
    landlordEntityId?: string;
    coverageAmount?: number;
    currency?: string;
    countryCode: string;
    fraudScore?: number;
    correlationId?: string;
  }) {
    const { rentalPlanId, providerId, productId, tenantId, landlordEntityId, countryCode } = input;

    const [plan, provider, product, tenantProfile, landlordProfile] = await Promise.all([
      this.db.rentalServicePlan.findUnique({ where: { id: rentalPlanId } }),
      this.db.insuranceProvider.findUnique({ where: { id: providerId } }),
      this.db.rentalInsuranceProduct.findUnique({ where: { id: productId } }),
      tenantId
        ? this.db.tenantFinancialProfile.findUnique({ where: { tenantId } })
        : Promise.resolve(null),
      landlordEntityId
        ? this.db.landlordFinancialProfile.findUnique({ where: { landlordEntityId } })
        : Promise.resolve(null),
    ]);

    if (!plan) throw new Error("RentalServicePlan not found");
    if (!provider) throw new Error("InsuranceProvider not found");
    if (!product) throw new Error("RentalInsuranceProduct not found");

    const paymentHistory = (await this.db.rentalPayment
      .findMany({ where: { rentalPlanId } })
      .catch(() => [])).map((p) => ({
      status: p.status,
      daysLate: p.daysLate,
      amount: Number(p.amount),
    }));

    const result = this.pricing.calculatePremium({
      tenantProfile: tenantProfile ?? undefined,
      landlordProfile: landlordProfile ?? undefined,
      paymentHistory,
      fraudScore: input.fraudScore,
      basePremiumRate: Number(product.basePremiumRate),
      propertyData: undefined,
      locationRisk: undefined,
    });

    const coverageAmount =
      input.coverageAmount ?? Number(product.maxCoverageAmount) ?? 10000;
    const premiumAmount = Math.round(coverageAmount * result.premiumRate * 100) / 100;
    const currency = input.currency ?? product.currency ?? plan.currency ?? "USD";

    const policy = await this.db.rentalInsurancePolicy.create({
      data: {
        rentalPlanId,
        tenantId,
        landlordEntityId,
        providerId,
        productId,
        status: InsurancePolicyStatus.QUOTE,
        premiumAmount,
        premiumRate: result.premiumRate,
        coverageAmount,
        currency,
        metadata: {
          riskBand: result.riskBand,
          riskEngineScore: result.riskEngineScore,
          explanation: result.explanation,
          premiumBreakdown: {
            platformFee: 0, // platform revenue is tracked separately, never mixed
            insurancePremium: premiumAmount,
          },
        },
      },
    });

    await this.pricing.persistExplanation({
      tenantId,
      landlordEntityId,
      fraudScore: input.fraudScore,
      result,
      correlationId: input.correlationId,
    });

    await publishInsuranceEvent({
      eventType: InsuranceEvents.QuoteCreated,
      countryCode,
      data: {
        quoteId: policy.id,
        policyId: policy.id,
        tenantId,
        landlordId: landlordEntityId,
        rentalPlanId,
        propertyId: plan.propertyId ?? undefined,
        riskScore: result.riskEngineScore,
        financialImpact: Number(premiumAmount),
        correlationId: input.correlationId,
      },
    });

    return policy;
  }

  /**
   * Activate a quote by issuing the policy at the provider.
   */
  async issuePolicy(input: {
    quoteId: string;
    providerName?: string;
    countryCode: string;
    effectiveFrom?: Date;
    effectiveTo?: Date;
    correlationId?: string;
  }) {
    const quote = await this.db.rentalInsurancePolicy.findUnique({
      where: { id: input.quoteId },
      include: { provider: true },
    });
    if (!quote) throw new Error("Quote not found");
    if (quote.status !== InsurancePolicyStatus.QUOTE) {
      throw new Error(`Cannot issue policy from status ${quote.status}`);
    }

    const adapter = providerAdapterRegistry.get(input.providerName ?? "mock");
    const issued = await adapter.createPolicy({
      quoteId: quote.id,
      tenant: {},
      property: {},
      coverageAmount: Number(quote.coverageAmount),
      currency: quote.currency ?? "USD",
      premiumAmount: Number(quote.premiumAmount),
      effectiveFrom: input.effectiveFrom?.toISOString(),
      effectiveTo: input.effectiveTo?.toISOString(),
    });

    const policy = await this.db.rentalInsurancePolicy.update({
      where: { id: quote.id },
      data: {
        status: InsurancePolicyStatus.ACTIVE,
        externalPolicyId: issued.externalId,
        effectiveFrom: input.effectiveFrom ?? new Date(),
        effectiveTo: input.effectiveTo ?? new Date(Date.now() + 365 * 24 * 3600 * 1000),
      },
    });

    await publishInsuranceEvent({
      eventType: InsuranceEvents.PolicyActivated,
      countryCode: input.countryCode,
      data: {
        policyId: policy.id,
        externalPolicyId: issued.externalId,
        tenantId: policy.tenantId ?? undefined,
        landlordId: policy.landlordEntityId ?? undefined,
        rentalPlanId: policy.rentalPlanId,
        riskScore: (policy.metadata as any)?.riskEngineScore,
        financialImpact: Number(policy.premiumAmount),
        correlationId: input.correlationId,
      },
    });

    return policy;
  }

  /**
   * Record a tenant premium payment. The payment is routed to the provider
   * (InsurancePaymentTransaction) — never mixed with platform revenue.
   */
  async recordPremiumPayment(input: {
    policyId: string;
    amount: number;
    currency?: string;
    externalTransactionId?: string;
    countryCode: string;
    correlationId?: string;
  }) {
    const policy = await this.db.rentalInsurancePolicy.findUnique({
      where: { id: input.policyId },
    });
    if (!policy) throw new Error("Policy not found");

    const transaction = await this.db.insurancePaymentTransaction.create({
      data: {
        policyId: policy.id,
        amount: input.amount,
        providerId: policy.providerId,
        status: "SUCCESS",
        externalTransactionId: input.externalTransactionId,
      },
    });

    await publishInsuranceEvent({
      eventType: InsuranceEvents.PremiumPaid,
      countryCode: input.countryCode,
      data: {
        policyId: policy.id,
        transactionId: transaction.id,
        tenantId: policy.tenantId ?? undefined,
        landlordId: policy.landlordEntityId ?? undefined,
        rentalPlanId: policy.rentalPlanId,
        financialImpact: Number(input.amount),
        correlationId: input.correlationId,
      },
    });

    await publishInsuranceEvent({
      eventType: InsuranceEvents.PaymentReceived,
      countryCode: input.countryCode,
      data: {
        policyId: policy.id,
        transactionId: transaction.id,
        providerId: policy.providerId,
        amount: Number(input.amount),
        currency: input.currency ?? policy.currency ?? "USD",
        tenantId: policy.tenantId ?? undefined,
        landlordId: policy.landlordEntityId ?? undefined,
        rentalPlanId: policy.rentalPlanId,
        correlationId: input.correlationId,
      },
    });

    return transaction;
  }

  async cancelPolicy(input: {
    policyId: string;
    reason?: string;
    countryCode: string;
    correlationId?: string;
  }) {
    const policy = await this.db.rentalInsurancePolicy.findUnique({
      where: { id: input.policyId },
    });
    if (!policy) throw new Error("Policy not found");
    if (!policy.externalPolicyId) throw new Error("Policy has no external id");

    const adapter = providerAdapterRegistry.get("mock");
    await adapter.cancelPolicy(policy.externalPolicyId);

    return this.db.rentalInsurancePolicy.update({
      where: { id: policy.id },
      data: {
        status: InsurancePolicyStatus.CANCELLED,
        metadata: {
          ...(policy.metadata as any),
          cancelledAt: new Date().toISOString(),
          cancelReason: input.reason,
        },
      },
    });
  }

  async listPolicies(input: { orgId?: string; status?: string; page?: number; limit?: number }) {
    const page = input.page ?? 1;
    const limit = input.limit ?? 20;
    const where: Prisma.RentalInsurancePolicyWhereInput = {
      ...(input.status ? { status: input.status as InsurancePolicyStatus } : {}),
    };
    if (input.orgId) {
      where.provider = { organizationId: input.orgId };
    }
    const [data, total] = await Promise.all([
      this.db.rentalInsurancePolicy.findMany({
        where,
        include: { provider: true, product: true },
        orderBy: { createdAt: "desc" },
        skip: (page - 1) * limit,
        take: limit,
      }),
      this.db.rentalInsurancePolicy.count({ where }),
    ]);
    return { data, total, page, limit };
  }
}

export const policyService = new PolicyService();
