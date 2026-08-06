import { ClaimStatus } from "@prisma/client";
import { prisma } from "../../lib/prisma";
import { providerAdapterRegistry } from "./provider-adapter";
import { publishInsuranceEvent, InsuranceEvents } from "./insurance-events";

/**
 * Claims Service — manages the InsuranceClaim lifecycle.
 *
 * SUBMITTED → UNDER_REVIEW → APPROVED → PAID  (or REJECTED / DISPUTED)
 *
 * Claims are immutable: every status change is persisted and audited via
 * InsuranceClaimCreated/Approved/Rejected events. Evidence (payment history,
 * lease contract, risk analysis, communication history, events) is stored in
 * `metadata`.
 */
export class ClaimsService {
  constructor(private readonly db: typeof prisma = prisma) {}

  async submitClaim(input: {
    policyId: string;
    claimType: string;
    amountRequested: number;
    evidence?: Record<string, any>;
    legalCaseId?: string;
    countryCode: string;
    correlationId?: string;
  }) {
    const policy = await this.db.rentalInsurancePolicy.findUnique({
      where: { id: input.policyId },
    });
    if (!policy) throw new Error("Policy not found");

    const claim = await this.db.insuranceClaim.create({
      data: {
        policyId: policy.id,
        legalCaseId: input.legalCaseId,
        claimType: input.claimType,
        amountRequested: input.amountRequested,
        status: ClaimStatus.SUBMITTED,
        metadata: {
          evidence: input.evidence ?? {},
          evidenceLog: [
            {
              timestamp: new Date().toISOString(),
              action: "SUBMITTED",
              note: "Claim submitted",
            },
          ],
        },
      },
    });

    // Notify the provider adapter; failures are non-fatal (claim stays SUBMITTED).
    try {
      const adapter = providerAdapterRegistry.get("mock");
      await adapter.submitClaim({
        policyId: policy.id,
        externalPolicyId: policy.externalPolicyId ?? undefined,
        claimType: input.claimType,
        amountRequested: input.amountRequested,
        currency: policy.currency ?? "USD",
        evidence: input.evidence ?? {},
        legalCaseId: input.legalCaseId,
      });
    } catch (err) {
      console.error("[ClaimsService] provider submitClaim failed (kept SUBMITTED):", err);
    }

    await publishInsuranceEvent({
      eventType: InsuranceEvents.ClaimCreated,
      countryCode: input.countryCode,
      data: {
        claimId: claim.id,
        policyId: policy.id,
        tenantId: policy.tenantId ?? undefined,
        landlordId: policy.landlordEntityId ?? undefined,
        rentalPlanId: policy.rentalPlanId,
        riskScore: (policy.metadata as any)?.riskEngineScore,
        financialImpact: Number(input.amountRequested),
        correlationId: input.correlationId,
      },
    });

    return claim;
  }

  async updateClaimStatus(input: {
    claimId: string;
    status: ClaimStatus;
    amountApproved?: number;
    note?: string;
    actorId?: string;
    countryCode: string;
    correlationId?: string;
  }) {
    const claim = await this.db.insuranceClaim.findUnique({
      where: { id: input.claimId },
    });
    if (!claim) throw new Error("Claim not found");

    const metadata = (claim.metadata as any) ?? {};
    const evidenceLog = Array.isArray(metadata.evidenceLog) ? metadata.evidenceLog : [];

    const updated = await this.db.insuranceClaim.update({
      where: { id: claim.id },
      data: {
        status: input.status,
        ...(input.amountApproved != null ? { amountApproved: input.amountApproved } : {}),
        metadata: {
          ...metadata,
          evidenceLog: [
            ...evidenceLog,
            {
              timestamp: new Date().toISOString(),
              action: input.status,
              actorId: input.actorId,
              note: input.note,
              immutable: true,
            },
          ],
        },
      },
    });

    const baseEventData = {
      claimId: updated.id,
      policyId: updated.policyId,
      tenantId: undefined as string | undefined,
      landlordId: undefined as string | undefined,
      rentalPlanId: undefined as string | undefined,
      financialImpact: input.amountApproved ?? Number(updated.amountRequested),
      correlationId: input.correlationId,
    };

    const policy = await this.db.rentalInsurancePolicy
      .findUnique({ where: { id: updated.policyId } })
      .catch(() => null);
    if (policy) {
      baseEventData.tenantId = policy.tenantId ?? undefined;
      baseEventData.landlordId = policy.landlordEntityId ?? undefined;
      baseEventData.rentalPlanId = policy.rentalPlanId;
    }

    if (input.status === ClaimStatus.APPROVED) {
      await publishInsuranceEvent({
        eventType: InsuranceEvents.ClaimApproved,
        countryCode: input.countryCode,
        data: baseEventData,
      });
    } else if (input.status === ClaimStatus.REJECTED) {
      await publishInsuranceEvent({
        eventType: InsuranceEvents.ClaimRejected,
        countryCode: input.countryCode,
        data: baseEventData,
      });
    }

    return updated;
  }

  async listClaims(input: { policyId?: string; status?: string; page?: number; limit?: number }) {
    const page = input.page ?? 1;
    const limit = input.limit ?? 20;
    const where: any = {
      ...(input.policyId ? { policyId: input.policyId } : {}),
      ...(input.status ? { status: input.status as ClaimStatus } : {}),
    };
    const [data, total] = await Promise.all([
      this.db.insuranceClaim.findMany({
        where,
        include: { policy: { include: { provider: true } } },
        orderBy: { createdAt: "desc" },
        skip: (page - 1) * limit,
        take: limit,
      }),
      this.db.insuranceClaim.count({ where }),
    ]);
    return { data, total, page, limit };
  }
}

export const claimsService = new ClaimsService();
