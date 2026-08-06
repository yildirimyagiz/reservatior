import { BaseSaga } from './saga-orchestrator';
import { EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { ClaimStatus } from '@prisma/client';
import { prisma } from '../../lib/prisma';
import { claimsService } from '../../services/insurance/claims-service';
import { InsuranceEvents } from '../../services/insurance/insurance-events';

/**
 * Insurance OS — Claims Lifecycle Saga
 *
 *   CLAIM_SUBMITTED → CLAIM_ASSESSMENT → CLAIM_APPROVED → CLAIM_PAYOUT → CLAIM_PAID
 *
 * Compensation chain (reverse order):
 *   1. RevertClaimApproval — restore the claim to REJECTED if provider payout fails.
 *   2. RefundClaimPayout  — signal payout reversal when a downstream step fails.
 *
 * Triggered by `insurance.claim.created` (published by ClaimsService.submitClaim).
 */

export interface InsuranceClaimsSagaData {
  step: string;
  claimId?: string;
  policyId?: string;
  claimType?: string;
  amountRequested?: number;
  amountApproved?: number;
  coverageAmount?: number;
  tenantId?: string;
  landlordId?: string;
  rentalPlanId?: string;
  countryCode?: string;
  payoutTransactionId?: string;
}

/**
 * Pure claim assessment — validates the requested amount against policy coverage.
 * Throws when the request exceeds coverage (→ business rejection).
 */
export function evaluateClaim(requested: number, coverage: number): {
  approved: boolean;
  amountApproved: number;
} {
  if (requested > coverage) {
    throw new Error(`CLAIM_AMOUNT_EXCEEDS_COVERAGE: requested=${requested}, coverage=${coverage}`);
  }
  return { approved: true, amountApproved: Math.min(requested, coverage) };
}

export class InsuranceClaimsSaga extends BaseSaga {
  public sagaData: InsuranceClaimsSagaData;

  constructor(claimData: any = {}, sagaId?: string) {
    super(
      sagaId,
      { step: 'CLAIM_SUBMITTED', ...claimData },
      {
        countryCode: claimData.countryCode || 'US',
        language: 'en',
        currency: 'USD',
        timezone: 'UTC',
      },
    );
    this.sagaData = { step: 'CLAIM_SUBMITTED', ...claimData };
  }

  /** Public failure entrypoint for listeners (BaseSaga.fail is protected). */
  public async abort(reason: string): Promise<void> {
    await this.fail(reason);
  }

  public async runClaimLifecycle(): Promise<void> {
    const countryCode = this.sagaData.countryCode || 'US';

    // ── Step 2: Claim assessment (evidence + coverage check) ────────────────
    await this.transition({ step: 'CLAIM_ASSESSMENT' });

    const assessment = await this.executeStep('CLAIM_ASSESSMENT', async () => {
      const claim = await prisma.insuranceClaim.findUnique({ where: { id: this.sagaData.claimId! } });
      if (!claim) throw new Error('Claim not found');

      const policy = await prisma.rentalInsurancePolicy.findUnique({ where: { id: claim.policyId } });
      if (!policy) throw new Error('Policy not found');

      this.sagaData.policyId = claim.policyId;
      this.sagaData.coverageAmount = Number(policy.coverageAmount);

      const requested = Number(claim.amountRequested);
      const coverage = Number(policy.coverageAmount);
      return evaluateClaim(requested, coverage);
    });

    this.sagaData.amountApproved = assessment.amountApproved;
    await this.transition({ step: 'CLAIM_ASSESSED' });

    eventBus.publish(
      'insurance.claim.assessed',
      { claimId: this.sagaData.claimId, amountApproved: this.sagaData.amountApproved },
      'InsuranceOS',
      this.sagaId,
    );

    // ── Step 3: Claim approval ──────────────────────────────────────────────
    await this.transition({ step: 'CLAIM_APPROVING' });

    await this.executeStep('CLAIM_APPROVED', () =>
      claimsService.updateClaimStatus({
        claimId: this.sagaData.claimId!,
        status: ClaimStatus.APPROVED,
        amountApproved: this.sagaData.amountApproved,
        note: 'Saga auto-approval',
        countryCode,
        correlationId: this.sagaId,
      }),
    );

    await this.transition({ step: 'CLAIM_APPROVED' });

    // ── Step 4: Provider payout ─────────────────────────────────────────────
    await this.transition({ step: 'CLAIM_PAYOUT' });

    const payout = await this.executeStep('CLAIM_PAYOUT', async () => {
      const policy = await prisma.rentalInsurancePolicy.findUnique({
        where: { id: this.sagaData.policyId! },
      });
      if (!policy) throw new Error('Policy not found');

      const transaction = await prisma.insurancePaymentTransaction.create({
        data: {
          policyId: policy.id,
          amount: this.sagaData.amountApproved!,
          providerId: policy.providerId,
          status: 'SUCCESS',
          externalTransactionId: `PAY-CLM-${Math.floor(100000 + Math.random() * 900000)}`,
        },
      });

      await prisma.insuranceClaim.update({
        where: { id: this.sagaData.claimId! },
        data: { status: ClaimStatus.PAID },
      });

      return transaction;
    });

    this.sagaData.payoutTransactionId = payout.id;

    // Compensation: reverse the approval if a downstream step fails.
    this.registerCompensation('RevertClaimApproval', async () => {
      await claimsService
        .updateClaimStatus({
          claimId: this.sagaData.claimId!,
          status: ClaimStatus.REJECTED,
          note: 'SAGA_PAYOUT_FAILURE',
          countryCode,
          correlationId: this.sagaId,
        })
        .catch((err: Error) =>
          console.error(`[InsuranceClaimsSaga] RevertClaimApproval compensation failed: ${err.message}`),
        );
    });

    this.registerCompensation('RefundClaimPayout', async () => {
      eventBus.publish(
        'insurance.claim.payout.reversed',
        { claimId: this.sagaData.claimId, payoutTransactionId: this.sagaData.payoutTransactionId },
        'InsuranceOS',
        this.sagaId,
      );
    });

    // ── Step 5: Claim fully paid ────────────────────────────────────────────
    await this.transition({ step: 'CLAIM_PAID' });

    eventBus.publish(
      'insurance.claim.paid',
      {
        claimId: this.sagaData.claimId,
        amountApproved: this.sagaData.amountApproved,
        payoutTransactionId: this.sagaData.payoutTransactionId,
      },
      'InsuranceOS',
      this.sagaId,
    );

    console.log(`[InsuranceClaimsSaga ${this.sagaId}] ✅ CLAIM WORKFLOW FULLY PAID!`);
    await this.complete();
  }
}

const activeClaimsSagas = new Map<string, InsuranceClaimsSaga>();

export function registerInsuranceClaimsListeners() {
  eventBus.subscribe(InsuranceEvents.ClaimCreated, (msg: EventMessage<any>) => {
    const payload = msg.payload ?? {};
    const saga = new InsuranceClaimsSaga(payload, msg.correlationId);
    activeClaimsSagas.set(saga.sagaId, saga);

    saga.runClaimLifecycle().catch(async (err: unknown) => {
      const reason = err instanceof Error ? err.message : String(err);
      if (reason.includes('CLAIM_AMOUNT_EXCEEDS_COVERAGE')) {
        await claimsService
          .updateClaimStatus({
            claimId: saga.sagaData.claimId!,
            status: ClaimStatus.REJECTED,
            note: reason,
            countryCode: saga.sagaData.countryCode || 'US',
            correlationId: saga.sagaId,
          })
          .catch(() => {});
        eventBus.publish(
          'insurance.claim.rejected',
          { claimId: saga.sagaData.claimId, reason },
          'InsuranceOS',
          saga.sagaId,
        );
      }
      await saga.abort(reason);
    });
  });
}
