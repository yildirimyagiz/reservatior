/**
 * Saga: Finance Pipeline
 * 
 * Flow:
 *   deal.closed
 *       |
 *   commission.created
 *       |
 *   [Installment evaluation]
 *       |
 *   commission.installment.offered OR commission.paid
 *       |
 *   payment.received
 *       |
 *   invoice.created
 *       |
 *   revenue.recognized
 */

import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { DomainEvents } from '../events/domain-events';

export class FinancePipelineSaga extends BaseSaga {
  public dealId: string;
  public agentId: string;
  public amount: number;
  public commissionModel: 'INSTALLMENT_12' | 'HYBRID_50_6' | 'TRADITIONAL_1M';

  constructor(
    dealId: string, 
    agentId: string, 
    amount: number, 
    commissionModel: 'INSTALLMENT_12' | 'HYBRID_50_6' | 'TRADITIONAL_1M',
    sagaId?: string, 
    localization?: LocalizationContext
  ) {
    super(sagaId, { step: 'DEAL_CLOSED', dealId, agentId, amount, commissionModel }, localization);
    this.dealId = dealId;
    this.agentId = agentId;
    this.amount = amount;
    this.commissionModel = commissionModel;
  }

  protected async compensate(): Promise<void> {
    console.log(`[FinancePipelineSaga] Compensating deal ${this.dealId}. Reversing financial operations...`);
  }

  public async onDealClosed() {
    console.log(`[FinancePipelineSaga] Deal ${this.dealId} closed. Creating commission...`);
    await this.transition({ step: 'CREATING_COMMISSION' });

    setTimeout(() => {
      eventBus.publish(DomainEvents.COMMISSION_CREATED, {
        dealId: this.dealId,
        agentId: this.agentId,
        amount: this.amount,
        currency: this.localization.currency,
        commissionModel: this.commissionModel
      }, 'FinanceOS', this.sagaId);
    }, 1000);
  }

  public async onCommissionCreated(msg: EventMessage) {
    const { amount, currency, commissionModel } = msg.payload;
    console.log(`[FinancePipelineSaga] Commission ${amount} ${currency} created with model ${commissionModel}.`);
    await this.transition({ step: 'EVALUATING_PAYMENT' });

    // Evaluate payment method based on commission model
    if (commissionModel === 'TRADITIONAL_1M') {
      setTimeout(() => {
        eventBus.publish(DomainEvents.PAYMENT_RECEIVED, {
          dealId: this.dealId,
          agentId: this.agentId,
          amount: amount,
          currency: currency,
          paymentMethod: 'lump_sum'
        }, 'FinanceOS', this.sagaId);
      }, 800);
    } else {
      setTimeout(() => {
        eventBus.publish(DomainEvents.COMMISSION_INSTALLMENT_OFFERED, {
          dealId: this.dealId,
          agentId: this.agentId,
          totalAmount: amount,
          currency: currency,
          commissionModel: commissionModel,
          installments: commissionModel === 'INSTALLMENT_12' ? 12 : 6,
          monthlyAmount: Math.round(amount / (commissionModel === 'INSTALLMENT_12' ? 12 : 6))
        }, 'FinanceOS', this.sagaId);
      }, 800);
    }
  }

  public async onInstallmentOffered(msg: EventMessage) {
    console.log(`[FinancePipelineSaga] Installment plan offered: ${msg.payload.monthlyAmount} ${this.localization.currency}/mo x ${msg.payload.installments} months.`);
    await this.transition({ step: 'INSTALLMENT_OFFERED' });
    // Saga parks here until agent accepts
  }

  public async onInstallmentStarted(msg: EventMessage) {
    console.log(`[FinancePipelineSaga] Agent accepted installment plan. Setting up payment schedule...`);
    await this.transition({ step: 'SETTING_UP_INSTALLMENTS' });

    setTimeout(() => {
      eventBus.publish(DomainEvents.INVOICE_CREATED, {
        dealId: this.dealId,
        agentId: this.agentId,
        invoiceType: 'installment_first',
        amount: msg.payload.monthlyAmount,
        currency: this.localization.currency,
        dueDate: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString()
      }, 'FinanceOS', this.sagaId);
    }, 500);
  }

  public async onPaymentReceived(msg: EventMessage) {
    console.log(`[FinancePipelineSaga] Payment received: ${msg.payload.amount} ${msg.payload.currency}. Creating invoice...`);
    await this.transition({ step: 'CREATING_INVOICE' });

    setTimeout(() => {
      eventBus.publish(DomainEvents.INVOICE_CREATED, {
        dealId: this.dealId,
        agentId: this.agentId,
        invoiceType: 'commission',
        amount: msg.payload.amount,
        currency: msg.payload.currency,
        dueDate: new Date().toISOString()
      }, 'FinanceOS', this.sagaId);
    }, 500);
  }

  public async onInvoiceCreated(msg: EventMessage) {
    console.log(`[FinancePipelineSaga] Invoice created for deal ${this.dealId}. Recognizing revenue...`);
    await this.transition({ step: 'RECOGNIZING_REVENUE' });

    setTimeout(() => {
      eventBus.publish(DomainEvents.REVENUE_RECOGNIZED, {
        dealId: this.dealId,
        agentId: this.agentId,
        amount: msg.payload.amount,
        currency: msg.payload.currency,
        recognizedAt: new Date().toISOString()
      }, 'FinanceOS', this.sagaId);
    }, 500);
  }

  public async onRevenueRecognized(msg: EventMessage) {
    console.log(`[FinancePipelineSaga] Revenue recognized for deal ${this.dealId}. FINANCE SAGA COMPLETE.`);
    await this.complete();
  }

  public async onPaymentFailed(msg: EventMessage) {
    console.log(`[FinancePipelineSaga] Payment failed for deal ${this.dealId}. SAGA FAILED.`);
    await this.fail('Payment processing failed');
  }

  public async onDealCancelled(msg: EventMessage) {
    console.log(`[FinancePipelineSaga] Deal ${this.dealId} cancelled. SAGA FAILED.`);
    await this.fail('Deal was cancelled');
  }
}

// ─── Registry ─────────────────────────────────────────────────────────────────
const activeSagas = new Map<string, FinancePipelineSaga>();

export function registerFinancePipelineListeners() {
  eventBus.subscribe(DomainEvents.DEAL_CLOSED, (msg) => {
    const { dealId, agentId, amount, commissionModel } = msg.payload;
    const localization = msg.localization || {
      countryCode: 'US',
      language: 'en',
      currency: 'USD',
      timezone: 'America/New_York'
    };
    const saga = new FinancePipelineSaga(dealId, agentId, amount, commissionModel || 'TRADITIONAL_1M', msg.correlationId, localization);
    activeSagas.set(saga.sagaId, saga);
    saga.onDealClosed();
    console.log(`[FinancePipelineSaga] ✅ Started for Deal ${dealId}`);
  });

  eventBus.subscribe(DomainEvents.COMMISSION_CREATED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onCommissionCreated(msg);
  });

  eventBus.subscribe(DomainEvents.COMMISSION_INSTALLMENT_OFFERED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onInstallmentOffered(msg);
  });

  eventBus.subscribe(DomainEvents.COMMISSION_INSTALLMENT_STARTED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onInstallmentStarted(msg);
  });

  eventBus.subscribe(DomainEvents.PAYMENT_RECEIVED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onPaymentReceived(msg);
  });

  eventBus.subscribe(DomainEvents.INVOICE_CREATED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onInvoiceCreated(msg);
  });

  eventBus.subscribe(DomainEvents.REVENUE_RECOGNIZED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onRevenueRecognized(msg);
  });

  eventBus.subscribe(DomainEvents.PAYMENT_FAILED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onPaymentFailed(msg);
  });

  eventBus.subscribe(DomainEvents.DEAL_CANCELLED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onDealCancelled(msg);
  });
}
