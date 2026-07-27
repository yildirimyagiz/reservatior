/**
 * Revenue Lifecycle Saga
 * Full financial pipeline from Lead to Accounting.
 *
 * Flow:
 *   LEAD_CREATED
 *     ↓ VIEWING_SCHEDULED
 *     ↓ OFFER_MADE
 *     ↓ CONTRACT_SIGNED
 *     ↓ ESCROW_FUNDED
 *     ↓ COMMISSION_CALCULATED
 *     ↓ COMMISSION_PAID / INSTALLMENT_STARTED
 *     ↓ REFERRAL_PROCESSED (if applicable)
 *     ↓ ACCOUNTING_RECORDED
 *     ↓ COMPLETE
 *
 * This is Reservatior's financial backbone — every dollar
 * flows through this saga and is fully observable.
 *
 * Compensation chain:
 *   refund_commission → void_escrow → cancel_contract → cancel_offer
 */

import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage, DomainEvents } from '../events/domain-events';
import { eventBus } from '../events/event-bus';

export class RevenueLifecycleSaga extends BaseSaga {
  public leadId: string;
  public propertyId: string;
  public orgId: string;
  public agentId?: string;
  public amount: number;

  constructor(
    leadId: string,
    propertyId: string,
    orgId: string,
    amount: number,
    agentId?: string,
    sagaId?: string,
    localization?: LocalizationContext
  ) {
    super(sagaId, {
      step: 'LEAD_CREATED', leadId, propertyId, orgId, amount, agentId
    }, localization);
    this.leadId = leadId;
    this.propertyId = propertyId;
    this.orgId = orgId;
    this.amount = amount;
    this.agentId = agentId;
    this.lockKey = `revenue:${leadId}`;
  }

  protected async compensate(): Promise<void> {
    console.log(`[RevenueSaga] Compensating revenue pipeline for lead ${this.leadId}`);
    await super.compensate();
  }

  // ── Step 1: Lead created → schedule viewing ─────────────────────────────────
  public async onLeadCreated() {
    console.log(`[RevenueSaga] Lead ${this.leadId} created for property ${this.propertyId}. Scheduling viewing…`);
    await this.transition({ step: 'VIEWING_SCHEDULING' });

    this.registerCompensation('cancel_lead', async () => {
      await eventBus.publish(
        'revenue.lead.cancelled.v1',
        { leadId: this.leadId, reason: 'saga_compensation' },
        'RevenueLifecycleSaga', this.sagaId
      );
    });
  }

  // ── Step 2: Viewing scheduled → await offer ────────────────────────────────
  public async onViewingScheduled(msg: EventMessage) {
    console.log(`[RevenueSaga] Viewing scheduled for lead ${this.leadId}`);
    await this.transition({
      step: 'VIEWING_SCHEDULED',
      viewingDate: msg.payload.viewingDate,
      viewingId: msg.payload.viewingId,
    });
    // Parks until offer is made
  }

  // ── Step 3: Offer made → contract negotiation ─────────────────────────────
  public async onOfferMade(msg: EventMessage) {
    const { offerAmount, offerCurrency } = msg.payload;
    console.log(`[RevenueSaga] Offer made for lead ${this.leadId}: ${offerAmount} ${offerCurrency}`);
    this.amount = offerAmount || this.amount;
    await this.transition({
      step: 'OFFER_MADE',
      offerAmount,
      offerCurrency,
      offerId: msg.payload.offerId,
    });

    this.registerCompensation('cancel_offer', async () => {
      await eventBus.publish(
        'revenue.offer.cancelled.v1',
        { leadId: this.leadId, offerId: msg.payload.offerId },
        'RevenueLifecycleSaga', this.sagaId
      );
    });
  }

  // ── Step 4: Contract signed → escrow setup ────────────────────────────────
  public async onContractSigned(msg: EventMessage) {
    console.log(`[RevenueSaga] Contract signed for lead ${this.leadId}. Setting up escrow…`);
    await this.transition({
      step: 'CONTRACT_SIGNED',
      contractId: msg.payload.contractId,
      signedAt: new Date().toISOString(),
    });

    this.registerCompensation('cancel_contract', async () => {
      await eventBus.publish(
        'revenue.contract.cancelled.v1',
        { leadId: this.leadId, contractId: msg.payload.contractId },
        'RevenueLifecycleSaga', this.sagaId
      );
    });

    await eventBus.publish(
      'revenue.escrow.setup.requested.v1',
      {
        leadId: this.leadId,
        propertyId: this.propertyId,
        orgId: this.orgId,
        amount: this.amount,
        currency: this.localization.currency,
        contractId: msg.payload.contractId,
      },
      'RevenueLifecycleSaga',
      this.sagaId
    );
  }

  // ── Step 5: Escrow funded → commission calculation ────────────────────────
  public async onEscrowFunded(msg: EventMessage) {
    console.log(`[RevenueSaga] Escrow funded for lead ${this.leadId}: ${msg.payload.escrowAmount}`);
    await this.transition({
      step: 'ESCROW_FUNDED',
      escrowId: msg.payload.escrowId,
      escrowAmount: msg.payload.escrowAmount,
    });

    this.registerCompensation('void_escrow', async () => {
      await eventBus.publish(
        'revenue.escrow.voided.v1',
        { leadId: this.leadId, escrowId: msg.payload.escrowId },
        'RevenueLifecycleSaga', this.sagaId
      );
    });

    await eventBus.publish(
      'revenue.commission.calculate.requested.v1',
      {
        leadId: this.leadId,
        propertyId: this.propertyId,
        orgId: this.orgId,
        agentId: this.agentId,
        transactionAmount: this.amount,
        currency: this.localization.currency,
      },
      'RevenueLifecycleSaga',
      this.sagaId
    );
  }

  // ── Step 6: Commission calculated → payment ───────────────────────────────
  public async onCommissionCalculated(msg: EventMessage) {
    const { commissionAmount, effectiveRate, calculationType } = msg.payload;
    console.log(`[RevenueSaga] Commission calculated for lead ${this.leadId}: ${commissionAmount} (rate=${effectiveRate})`);
    await this.transition({
      step: 'COMMISSION_CALCULATED',
      commissionAmount,
      effectiveRate,
      calculationType,
    });

    this.registerCompensation('void_commission', async () => {
      await eventBus.publish(
        'revenue.commission.voided.v1',
        { leadId: this.leadId, agentId: this.agentId },
        'RevenueLifecycleSaga', this.sagaId
      );
    });

    await eventBus.publish(
      'revenue.commission.pay.requested.v1',
      {
        leadId: this.leadId,
        agentId: this.agentId,
        orgId: this.orgId,
        commissionAmount,
        currency: this.localization.currency,
      },
      'RevenueLifecycleSaga',
      this.sagaId
    );
  }

  // ── Step 7: Commission paid → referral check ──────────────────────────────
  public async onCommissionPaid(msg: EventMessage) {
    console.log(`[RevenueSaga] Commission paid for lead ${this.leadId}`);
    await this.transition({
      step: 'COMMISSION_PAID',
      paidAt: new Date().toISOString(),
      paymentMethod: msg.payload.paymentMethod || 'LUMP_SUM',
    });

    this.registerCompensation('refund_commission', async () => {
      await eventBus.publish(
        'revenue.commission.refunded.v1',
        { leadId: this.leadId, agentId: this.agentId },
        'RevenueLifecycleSaga', this.sagaId
      );
    });

    // Check if referral bonus applies
    if (msg.payload.referrerId) {
      await this.transition({ step: 'REFERRAL_PROCESSING' });
      await eventBus.publish(
        'revenue.referral.process.requested.v1',
        {
          leadId: this.leadId,
          referrerId: msg.payload.referrerId,
          orgId: this.orgId,
          transactionAmount: this.amount,
        },
        'RevenueLifecycleSaga',
        this.sagaId
      );
    } else {
      // Skip referral → go straight to accounting
      await this.proceedToAccounting();
    }
  }

  // ── Step 8: Referral processed → accounting ───────────────────────────────
  public async onReferralProcessed(msg: EventMessage) {
    console.log(`[RevenueSaga] Referral bonus processed for lead ${this.leadId}: ${msg.payload.referralAmount}`);
    await this.transition({
      step: 'REFERRAL_PROCESSED',
      referralAmount: msg.payload.referralAmount,
    });

    await this.proceedToAccounting();
  }

  // ── Step 9: Accounting recorded → COMPLETE ────────────────────────────────
  private async proceedToAccounting() {
    await this.transition({ step: 'ACCOUNTING_RECORDING' });

    await eventBus.publish(
      'revenue.accounting.record.requested.v1',
      {
        leadId: this.leadId,
        propertyId: this.propertyId,
        orgId: this.orgId,
        agentId: this.agentId,
        transactionAmount: this.amount,
        commissionAmount: this.state.commissionAmount,
        referralAmount: this.state.referralAmount || 0,
        currency: this.localization.currency,
        localization: this.localization,
      },
      'RevenueLifecycleSaga',
      this.sagaId
    );
  }

  public async onAccountingRecorded(msg: EventMessage) {
    console.log(`[RevenueSaga] ✅ Revenue pipeline COMPLETE for lead ${this.leadId}. Total: ${this.amount} ${this.localization.currency}`);
    await this.transition({ step: 'COMPLETE', accountingId: msg.payload.accountingId });

    await eventBus.publish(
      'revenue.lifecycle.completed.v1',
      {
        leadId: this.leadId,
        propertyId: this.propertyId,
        orgId: this.orgId,
        agentId: this.agentId,
        transactionAmount: this.amount,
        commissionAmount: this.state.commissionAmount,
        sagaId: this.sagaId,
        completedAt: new Date().toISOString(),
      },
      'RevenueLifecycleSaga',
      this.sagaId
    );

    await this.complete();
  }

  // ── Error / Cancellation ──────────────────────────────────────────────────
  public async onDealLost(msg: EventMessage) {
    console.log(`[RevenueSaga] Deal lost for lead ${this.leadId}: ${msg.payload.reason}`);
    await this.fail(msg.payload.reason || 'Deal lost');
  }
}

// ─── Registry ─────────────────────────────────────────────────────────────────
const activeSagas = new Map<string, RevenueLifecycleSaga>();

export function registerRevenueLifecycleListeners() {
  // Step 1: Lead created
  eventBus.subscribe(DomainEvents.LEAD_CREATED, (msg) => {
    const { leadId, propertyId, orgId, amount, agentId } = msg.payload;
    const localization = msg.localization || {
      countryCode: 'US', language: 'en', currency: 'USD', timezone: 'America/New_York'
    };

    const saga = new RevenueLifecycleSaga(
      leadId, propertyId, orgId, amount || 0, agentId,
      msg.correlationId, localization
    );
    activeSagas.set(saga.sagaId, saga);
    saga.onLeadCreated();
    console.log(`[RevenueSaga] 💰 Started for lead ${leadId}`);
  });

  // Step 2: Viewing scheduled
  eventBus.subscribe('revenue.viewing.scheduled.v1', (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onViewingScheduled(msg);
  });

  // Step 3: Offer made
  eventBus.subscribe('revenue.offer.made.v1', (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onOfferMade(msg);
  });

  // Step 4: Contract signed
  eventBus.subscribe('revenue.contract.signed.v1', (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onContractSigned(msg);
  });

  // Step 5: Escrow funded
  eventBus.subscribe('revenue.escrow.funded.v1', (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onEscrowFunded(msg);
  });

  // Step 6: Commission calculated
  eventBus.subscribe('revenue.commission.calculated.v1', (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onCommissionCalculated(msg);
  });

  // Step 7: Commission paid
  eventBus.subscribe('revenue.commission.paid.v1', (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onCommissionPaid(msg);
  });

  // Step 8: Referral processed
  eventBus.subscribe('revenue.referral.processed.v1', (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onReferralProcessed(msg);
  });

  // Step 9: Accounting recorded
  eventBus.subscribe('revenue.accounting.recorded.v1', (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onAccountingRecorded(msg);
  });

  // Deal lost
  eventBus.subscribe('revenue.deal.lost.v1', (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onDealLost(msg);
  });

  console.log('[RevenueSaga] ✅ Listeners registered (10 steps)');
}

export { activeSagas as revenueLifecycleActiveSagas };
