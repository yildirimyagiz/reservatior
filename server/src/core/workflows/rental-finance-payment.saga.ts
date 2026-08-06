import { BaseSaga } from './saga-orchestrator';
import { EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { RentalPaymentStatus, EscrowAccountStatus } from '@prisma/client';
import { prisma } from '../../lib/prisma';
import { rentalPlanService } from '../../services/rental-finance/rental-plan-service';
import { rentalPaymentService } from '../../services/rental-finance/rental-payment-service';
import { escrowEngine } from '../../services/rental-finance/escrow-engine';
import { RentalFinanceEvents } from '../../services/rental-finance/rental-event-publisher';

/**
 * Rental Finance OS — Plan Activation Saga
 *
 * Orchestrates the RentalServicePlan financial activation:
 *
 *   PLAN_ACTIVATED → ESCROW_READY → PAYMENTS_SCHEDULED → FIRST_PAYMENT_PROCESSED → PLAN_FULLY_ACTIVATED
 *
 * Compensation chain (reverse order):
 *   1. RevokeFirstPayment — mark the processed payment FAILED (tenant score drops).
 *   2. SuspendPlan        — suspend the plan so no further obligations accrue.
 *   3. CloseEscrow        — close the created escrow account (no funds at this stage).
 *
 * Triggered by `rental.plan.activated` (published by RentalPlanService.activatePlan).
 */

export interface RentalFinancePlanSagaData {
  step: string;
  rentalPlanId?: string;
  tenantId?: string;
  landlordId?: string;
  propertyId?: string;
  orgId?: string;
  escrowId?: string;
  scheduledPaymentIds?: string[];
  firstPaymentId?: string;
  countryCode?: string;
}

export class RentalFinancePlanSaga extends BaseSaga {
  public sagaData: RentalFinancePlanSagaData;

  constructor(planData: any = {}, sagaId?: string) {
    super(
      sagaId,
      { step: 'PLAN_ACTIVATED', ...planData },
      {
        countryCode: planData.countryCode || 'US',
        language: 'en',
        currency: 'USD',
        timezone: 'UTC',
      },
    );
    this.sagaData = { step: 'PLAN_ACTIVATED', ...planData };
  }

  /** Public failure entrypoint for listeners (BaseSaga.fail is protected). */
  public async abort(reason: string): Promise<void> {
    await this.fail(reason);
  }

  public async runPlanActivation(): Promise<void> {
    const rentalPlanId = this.sagaData.rentalPlanId!;
    const countryCode = this.sagaData.countryCode || 'US';

    // ── Step 2: Escrow readiness ────────────────────────────────────────────
    await this.transition({ step: 'ESCROW_READY' });

    const escrow = await this.executeStep('ESCROW_READY', async () => {
      const existing = await prisma.rentalEscrowAccount.findUnique({ where: { rentalPlanId } });
      if (existing) return existing;

      const plan = await prisma.rentalServicePlan.findUnique({ where: { id: rentalPlanId } });
      if (!plan?.orgId) throw new Error('Plan has no org');
      return escrowEngine.createEscrowForPlan({
        orgId: plan.orgId,
        rentalPlanId,
        currency: plan.currency ?? 'USD',
      });
    });

    this.sagaData.escrowId = escrow.id;

    // Compensation: close the escrow if a downstream step fails.
    this.registerCompensation('CloseEscrow', async () => {
      if (this.sagaData.escrowId) {
        await prisma.rentalEscrowAccount
          .update({
            where: { id: this.sagaData.escrowId },
            data: { status: EscrowAccountStatus.CLOSED },
          })
          .catch((err: Error) =>
            console.error(`[RentalFinancePlanSaga] CloseEscrow compensation failed: ${err.message}`),
          );
      }
    });

    await this.transition({ step: 'ESCROW_CREATED' });

    // ── Step 3: Schedule monthly payments ───────────────────────────────────
    await this.transition({ step: 'PAYMENTS_SCHEDULING' });

    const scheduled = await this.executeStep('PAYMENTS_SCHEDULED', () =>
      rentalPaymentService.scheduleMonthlyPayments(rentalPlanId),
    );

    this.sagaData.scheduledPaymentIds = scheduled.map((p: any) => p.id);

    // Compensation: suspend the plan so no further obligations accrue.
    this.registerCompensation('SuspendPlan', async () => {
      await rentalPlanService
        .suspendPlan(rentalPlanId)
        .catch((err: Error) =>
          console.error(`[RentalFinancePlanSaga] SuspendPlan compensation failed: ${err.message}`),
        );
    });

    await this.transition({ step: 'PAYMENTS_SCHEDULED' });

    // ── Step 4: Process the first payment ───────────────────────────────────
    await this.transition({ step: 'FIRST_PAYMENT_PROCESSING' });

    const firstPayment = await this.executeStep('FIRST_PAYMENT_PROCESSED', async () => {
      const payment = await prisma.rentalPayment.findFirst({
        where: { rentalPlanId, status: RentalPaymentStatus.SCHEDULED },
        orderBy: { scheduledDate: 'asc' },
      });
      if (!payment) throw new Error('No scheduled payment found to process');
      return rentalPaymentService.processPayment(payment.id);
    });

    this.sagaData.firstPaymentId = firstPayment.id;

    // Compensation: mark the processed payment FAILED (tenant score drops).
    this.registerCompensation('RevokeFirstPayment', async () => {
      if (this.sagaData.firstPaymentId) {
        await prisma.rentalPayment
          .update({
            where: { id: this.sagaData.firstPaymentId },
            data: { status: RentalPaymentStatus.FAILED },
          })
          .catch((err: Error) =>
            console.error(`[RentalFinancePlanSaga] RevokeFirstPayment compensation failed: ${err.message}`),
          );
      }
    });

    await this.transition({ step: 'FIRST_PAYMENT_PROCESSED' });

    // ── Step 5: Plan fully activated ────────────────────────────────────────
    await this.transition({ step: 'PLAN_FULLY_ACTIVATED' });

    eventBus.publish(
      'rental.finance.workflow.completed',
      {
        rentalPlanId,
        escrowId: this.sagaData.escrowId,
        firstPaymentId: this.sagaData.firstPaymentId,
        scheduledPayments: this.sagaData.scheduledPaymentIds?.length ?? 0,
      },
      'RentalFinanceOS',
      this.sagaId,
    );

    console.log(`[RentalFinancePlanSaga ${this.sagaId}] ✅ PLAN FINANCIAL ACTIVATION COMPLETED!`);
    await this.complete();
  }
}

const activePlanSagas = new Map<string, RentalFinancePlanSaga>();

export function registerRentalFinancePaymentListeners() {
  eventBus.subscribe(RentalFinanceEvents.PlanActivated, (msg: EventMessage<any>) => {
    const payload = msg.payload ?? {};
    const saga = new RentalFinancePlanSaga(payload, msg.correlationId);
    activePlanSagas.set(saga.sagaId, saga);

    saga.runPlanActivation().catch(async (err: unknown) => {
      const reason = err instanceof Error ? err.message : String(err);
      await saga.abort(reason);
    });
  });
}
