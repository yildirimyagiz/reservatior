import { BaseSaga } from './saga-orchestrator';
import { EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { rentalRiskEngine } from '../../services/rental-finance/rental-risk-engine';
import { rentalPlanService } from '../../services/rental-finance/rental-plan-service';
import { escrowEngine } from '../../services/rental-finance/escrow-engine';
import { tenantScoreService } from '../../services/rental-finance/tenant-score-service';
import { RentalFinanceEvents } from '../../services/rental-finance/rental-event-publisher';

/**
 * Rental Finance OS — Late Payment Risk Saga
 *
 * Reacts to a late payment by propagating risk and protecting escrow:
 *
 *   PAYMENT_LATE → RISK_PROPAGATED → ESCROW_SAFETY → RESOLUTION
 *
 * - Propagates the tenant risk downgrade to Security OS (risk alert).
 * - Blocks escrow release while the payment is late.
 * - Escalates to plan suspension when the payment is severely overdue (≥30 days).
 *
 * Compensation chain (reverse order):
 *   1. RestoreTenantScore — restore the tenant score if a later step fails.
 *   2. ClearEscrowBlock   — re-evaluate escrow release once risk clears.
 *
 * Triggered by `rental.payment.late` (published by RentalPaymentService.markLatePayments).
 */

export interface RentalFinanceRiskSagaData {
  step: string;
  paymentId?: string;
  rentalPlanId?: string;
  tenantId?: string;
  daysLate?: number;
  riskScore?: number;
  riskLevel?: string;
  escrowBlocked?: boolean;
  countryCode?: string;
}

export class RentalFinanceRiskSaga extends BaseSaga {
  public sagaData: RentalFinanceRiskSagaData;

  constructor(lateData: any = {}, sagaId?: string) {
    super(
      sagaId,
      { step: 'PAYMENT_LATE', ...lateData },
      {
        countryCode: lateData.countryCode || 'US',
        language: 'en',
        currency: 'USD',
        timezone: 'UTC',
      },
    );
    this.sagaData = { step: 'PAYMENT_LATE', ...lateData };
  }

  /** Public failure entrypoint for listeners (BaseSaga.fail is protected). */
  public async abort(reason: string): Promise<void> {
    await this.fail(reason);
  }

  public async runLatePaymentResponse(): Promise<void> {
    const paymentId = this.sagaData.paymentId!;
    const rentalPlanId = this.sagaData.rentalPlanId!;
    const tenantId = this.sagaData.tenantId;
    const daysLate = this.sagaData.daysLate ?? 3;

    // ── Step 2: Propagate risk (tenant score + Security OS alert) ───────────
    await this.transition({ step: 'RISK_PROPAGATED' });

    const risk = await this.executeStep('RISK_PROPAGATED', () =>
      rentalRiskEngine.propagateLatePayment(paymentId),
    );

    this.sagaData.riskScore = risk.score;
    this.sagaData.riskLevel = risk.riskLevel;

    // Compensation: restore the tenant score if a later step fails.
    if (tenantId) {
      this.registerCompensation('RestoreTenantScore', async () => {
        await tenantScoreService
          .updateAfterPayment(tenantId, true, 0)
          .catch((err: Error) =>
            console.error(`[RentalFinanceRiskSaga] RestoreTenantScore compensation failed: ${err.message}`),
          );
      });
    }

    // ── Step 3: Escrow safety check ─────────────────────────────────────────
    await this.transition({ step: 'ESCROW_SAFETY' });

    const blocked = await this.executeStep('ESCROW_SAFETY', () =>
      escrowEngine.evaluateReleaseTrigger(paymentId),
    );

    this.sagaData.escrowBlocked = !blocked;

    // Compensation: re-evaluate escrow once risk clears.
    this.registerCompensation('ClearEscrowBlock', async () => {
      eventBus.publish(
        'rental.escrow.release.cleared',
        { paymentId, rentalPlanId, reason: 'SAGA_RECOVERY' },
        'RentalFinanceOS',
        this.sagaId,
      );
    });

    if (!blocked) {
      eventBus.publish(
        'rental.escrow.blocked',
        {
          paymentId,
          rentalPlanId,
          tenantId,
          daysLate,
          reason: 'LATE_PAYMENT_RISK',
        },
        'RentalFinanceOS',
        this.sagaId,
      );
      console.log(`[RentalFinanceRiskSaga ${this.sagaId}] 🔒 Escrow release BLOCKED for late payment ${paymentId}`);
    }

    // ── Step 4: Resolution ──────────────────────────────────────────────────
    await this.transition({ step: 'RESOLUTION' });

    if (daysLate >= 30) {
      await this.executeStep('PLAN_SUSPENDED', () => rentalPlanService.suspendPlan(rentalPlanId));
      eventBus.publish(
        'rental.plan.suspended.by.risk',
        { rentalPlanId, tenantId, paymentId, daysLate },
        'RentalFinanceOS',
        this.sagaId,
      );
      console.log(`[RentalFinanceRiskSaga ${this.sagaId}] 🛑 Plan ${rentalPlanId} suspended (${daysLate}d late)`);
    } else {
      eventBus.publish(
        'rental.payment.recovery.notified',
        { paymentId, rentalPlanId, tenantId, daysLate },
        'RentalFinanceOS',
        this.sagaId,
      );
    }

    console.log(`[RentalFinanceRiskSaga ${this.sagaId}] ✅ LATE PAYMENT WORKFLOW RESOLVED!`);
    await this.complete();
  }
}

const activeRiskSagas = new Map<string, RentalFinanceRiskSaga>();

export function registerRentalFinanceRiskListeners() {
  eventBus.subscribe(RentalFinanceEvents.PaymentLate, (msg: EventMessage<any>) => {
    const payload = msg.payload ?? {};
    const saga = new RentalFinanceRiskSaga(payload, msg.correlationId);
    activeRiskSagas.set(saga.sagaId, saga);

    saga.runLatePaymentResponse().catch(async (err: unknown) => {
      const reason = err instanceof Error ? err.message : String(err);
      await saga.abort(reason);
    });
  });
}
