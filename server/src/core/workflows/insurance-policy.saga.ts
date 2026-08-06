import { BaseSaga } from './saga-orchestrator';
import { EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { policyService } from '../../services/insurance/policy-service';
import { InsuranceEvents } from '../../services/insurance/insurance-events';

/**
 * Insurance OS — Policy Lifecycle Saga
 *
 * Orchestrates the long-running insurance policy workflow with full
 * compensation support:
 *
 *   QUOTE_CREATED → UNDERWRITING_APPROVED → POLICY_ISSUED → PREMIUM_PAID → POLICY_ACTIVATED
 *
 * Compensation chain (reverse order):
 *   1. CancelPolicy  — revoke the issued policy at the provider when a
 *                      downstream step (premium) fails.
 *   2. RefundPremium — signal premium reversal to the provider ledger.
 *
 * Triggered by `insurance.quote.created` (published by PolicyService.createQuote).
 */

export interface InsurancePolicySagaData {
  step: string;
  policyId?: string;
  quoteId?: string;
  rentalPlanId?: string;
  tenantId?: string;
  landlordId?: string;
  riskScore?: number;
  coverageAmount?: number;
  premiumAmount?: number;
  currency?: string;
  countryCode?: string;
  externalPolicyId?: string;
  isUnderwritingApproved?: boolean;
}

export const UNDERWRITING_RISK_THRESHOLD = 75;

/**
 * Pure underwriting decision — keeps the risk band policy testable in isolation.
 */
export function evaluateUnderwriting(riskScore: number, threshold = UNDERWRITING_RISK_THRESHOLD): {
  approved: boolean;
  riskScore: number;
} {
  if (riskScore > threshold) {
    throw new Error(`UNDERWRITING_REJECTED: riskScore=${riskScore} exceeds threshold ${threshold}`);
  }
  return { approved: true, riskScore };
}

export class InsurancePolicySaga extends BaseSaga {
  public sagaData: InsurancePolicySagaData;

  constructor(quoteData: any = {}, sagaId?: string) {
    super(
      sagaId,
      { step: 'QUOTE_CREATED', ...quoteData },
      {
        countryCode: quoteData.countryCode || 'US',
        language: 'en',
        currency: 'USD',
        timezone: 'UTC',
      },
    );
    this.sagaData = { step: 'QUOTE_CREATED', ...quoteData };
  }

  /** Public failure entrypoint for listeners (BaseSaga.fail is protected). */
  public async abort(reason: string): Promise<void> {
    await this.fail(reason);
  }

  public async runPolicyLifecycle(): Promise<void> {
    const countryCode = this.sagaData.countryCode || 'US';

    // ── Step 2: Underwriting ────────────────────────────────────────────────
    await this.transition({ step: 'UNDERWRITING' });

    const underwriting = await this.executeStep('UNDERWRITING_CHECK', async () =>
      evaluateUnderwriting(this.sagaData.riskScore ?? 0),
    );

    this.sagaData.isUnderwritingApproved = underwriting.approved;
    await this.transition({ step: 'UNDERWRITING_APPROVED' });

    eventBus.publish(
      'insurance.underwriting.approved',
      { quoteId: this.sagaData.quoteId, policyId: this.sagaData.policyId, riskScore: underwriting.riskScore },
      'InsuranceOS',
      this.sagaId,
    );

    // ── Step 3: Policy issuance (provider) ──────────────────────────────────
    await this.transition({ step: 'POLICY_ISSUING' });

    const policy = await this.executeStep('POLICY_ISSUED', () =>
      policyService.issuePolicy({
        quoteId: this.sagaData.quoteId || this.sagaData.policyId!,
        countryCode,
        correlationId: this.sagaId,
      }),
    );

    this.sagaData.policyId = policy.id;
    this.sagaData.externalPolicyId = policy.externalPolicyId ?? undefined;
    this.sagaData.coverageAmount = Number(policy.coverageAmount);
    this.sagaData.premiumAmount = Number(policy.premiumAmount);
    this.sagaData.currency = policy.currency ?? 'USD';

    // Compensation: revoke the issued policy if a later step fails.
    this.registerCompensation('CancelPolicy', async () => {
      await policyService
        .cancelPolicy({
          policyId: this.sagaData.policyId!,
          reason: 'SAGA_ROLLBACK',
          countryCode,
          correlationId: this.sagaId,
        })
        .catch((err: Error) =>
          console.error(`[InsurancePolicySaga] CancelPolicy compensation failed: ${err.message}`),
        );
    });

    await this.transition({ step: 'POLICY_ISSUED' });

    eventBus.publish(
      'insurance.policy.issued',
      {
        policyId: this.sagaData.policyId,
        externalPolicyId: this.sagaData.externalPolicyId,
        coverageAmount: this.sagaData.coverageAmount,
        premiumAmount: this.sagaData.premiumAmount,
      },
      'InsuranceOS',
      this.sagaId,
    );

    // ── Step 4: Premium payment ─────────────────────────────────────────────
    await this.transition({ step: 'PREMIUM_PAYMENT' });

    await this.executeStep('PREMIUM_PAID', () =>
      policyService.recordPremiumPayment({
        policyId: this.sagaData.policyId!,
        amount: this.sagaData.premiumAmount!,
        currency: this.sagaData.currency,
        countryCode,
        correlationId: this.sagaId,
      }),
    );

    // Compensation: signal premium reversal to the provider ledger.
    this.registerCompensation('RefundPremium', async () => {
      eventBus.publish(
        'insurance.premium.refunded',
        { policyId: this.sagaData.policyId, amount: this.sagaData.premiumAmount, reason: 'SAGA_ROLLBACK' },
        'InsuranceOS',
        this.sagaId,
      );
    });

    // ── Step 5: Policy fully activated ──────────────────────────────────────
    await this.transition({ step: 'POLICY_ACTIVATED' });

    eventBus.publish(
      'insurance.policy.workflow.completed',
      {
        policyId: this.sagaData.policyId,
        externalPolicyId: this.sagaData.externalPolicyId,
        premiumAmount: this.sagaData.premiumAmount,
      },
      'InsuranceOS',
      this.sagaId,
    );

    console.log(`[InsurancePolicySaga ${this.sagaId}] ✅ POLICY WORKFLOW FULLY ACTIVATED!`);
    await this.complete();
  }
}

const activePolicySagas = new Map<string, InsurancePolicySaga>();

export function registerInsurancePolicyListeners() {
  eventBus.subscribe(InsuranceEvents.QuoteCreated, (msg: EventMessage<any>) => {
    const payload = msg.payload ?? {};
    const saga = new InsurancePolicySaga(payload, msg.correlationId);
    activePolicySagas.set(saga.sagaId, saga);

    saga.runPolicyLifecycle().catch(async (err: unknown) => {
      const reason = err instanceof Error ? err.message : String(err);
      if (reason.includes('UNDERWRITING_REJECTED')) {
        eventBus.publish(
          'insurance.underwriting.rejected',
          { quoteId: saga.sagaData.quoteId, policyId: saga.sagaData.policyId, reason },
          'InsuranceOS',
          saga.sagaId,
        );
      }
      await saga.abort(reason);
    });
  });
}
