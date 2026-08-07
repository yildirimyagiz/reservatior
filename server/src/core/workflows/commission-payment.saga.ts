import { BaseSaga } from "./saga-orchestrator";
import { LocalizationContext, EventMessage } from "../domain/events/event-schema";
import { EventCatalog, RevenueEvents } from "../domain/events/event-catalog";
import { eventBus } from "../events/event-bus";
import { evaluateCommissionRules, CommissionContext } from "../../services/financial/commission-rule-engine";
import { PolicyOSClient } from "../policy/policy-os.client";
import { DomainEvents } from "../events/domain-events";

export class CommissionPaymentSaga extends BaseSaga {
  public dealId: string;
  public agentId: string;
  public amount: number;
  public agentType: string;
  public listingOptimizationStatus?: string;
  public campaignTag?: string;
  public isFirstTransaction?: boolean;
  public volumeYtd?: number;

  constructor(
    dealId: string,
    agentId: string,
    amount: number,
    sagaId?: string,
    localization?: LocalizationContext,
    options?: {
      agentType?: string;
      listingOptimizationStatus?: string;
      campaignTag?: string;
      isFirstTransaction?: boolean;
      volumeYtd?: number;
    }
  ) {
    super(sagaId, { step: "DEAL_CLOSED", dealId, agentId, amount }, localization);
    this.dealId = dealId;
    this.agentId = agentId;
    this.amount = amount;
    this.agentType = options?.agentType || "OFFICE";
    this.listingOptimizationStatus = options?.listingOptimizationStatus;
    this.campaignTag = options?.campaignTag;
    this.isFirstTransaction = options?.isFirstTransaction;
    this.volumeYtd = options?.volumeYtd;
  }

  protected async compensate(): Promise<void> {
    console.log(`[CommissionPaymentSaga] Compensating deal ${this.dealId}. Reversing commission creation...`);
    await super.compensate();
  }

  public async onDealClosed() {
    console.log(`[CommissionPaymentSaga] Deal ${this.dealId} closed. Evaluating commission rules for Agent ${this.agentId}...`);
    await this.transition({ step: "EVALUATING_RULES" });

    const context: CommissionContext = {
      countryCode: this.localization.countryCode || "US",
      agentType: (this.agentType as any) || "OFFICE",
      agentId: this.agentId,
      transactionAmount: this.amount,
      currency: this.localization.currency || "USD",
      campaignTag: this.campaignTag,
      isFirstTransaction: this.isFirstTransaction,
      volumeYtd: this.volumeYtd,
      listingOptimizationStatus: this.listingOptimizationStatus as any,
    };

    // Query Policy OS for the dynamic commission rate
    const policyRate = await PolicyOSClient.getCommissionRate({
      countryCode: context.countryCode,
      userId: this.agentId,
      transactionAmount: this.amount
    });

    const result = await evaluateCommissionRules(context);
    // Override the hardcoded rule engine with Policy OS decision
    result.finalRate = policyRate;

    console.log(
      `[CommissionPaymentSaga] Commission evaluated via Policy OS: rate=${(result.finalRate * 100).toFixed(2)}%, ` +
        `type=${result.calculationType}, rules=[${result.appliedRules.join(", ")}]`
    );

    if (result.warnings.length > 0) {
      console.warn(`[CommissionPaymentSaga] Warnings: ${result.warnings.join("; ")}`);
    }

    await this.transition({ step: "CREATING_COMMISSION" });
    this.registerCompensation('void_commission', async () => {
      eventBus.publish(RevenueEvents.COMMISSION_VOIDED, { dealId: this.dealId, reason: 'saga_compensation' }, 'CommissionPaymentSaga', this.sagaId);
    });

    const effectiveRate = result.finalRate;
    const calculationType = result.calculationType;
    const appliedRules = result.appliedRules;

    setTimeout(() => {
      eventBus.publish(
        RevenueEvents.COMMISSION_CREATED,
        {
          dealId: this.dealId,
          agentId: this.agentId,
          amount: this.amount,
          currency: this.localization.currency,
          effectiveRate,
          calculationType,
          appliedRules,
          ruleBreakdown: result.breakdown,
        },
        "FinanceOS",
        this.sagaId
      );
    }, 800);
  }

  public async onCommissionCreated(msg: EventMessage) {
    const { amount, currency, calculationType, effectiveRate, appliedRules } = msg.payload;
    console.log(
      `[CommissionPaymentSaga] Commission ${amount} ${currency} created. ` +
        `Type: ${calculationType || "Standard"}, ` +
        `Rate: ${effectiveRate ? (effectiveRate * 100).toFixed(2) + "%" : "N/A"}. ` +
        `Evaluating installment eligibility...`
    );
    await this.transition({ step: "EVALUATING_INSTALLMENTS" });

    const eligibleForInstallments = amount > 5000;

    setTimeout(() => {
      if (eligibleForInstallments) {
        eventBus.publish(
          RevenueEvents.COMMISSION_INSTALLMENT_OFFERED,
          {
            dealId: this.dealId,
            agentId: this.agentId,
            totalAmount: amount,
            currency: this.localization.currency,
            installments: 12,
            monthlyAmount: Math.round(amount / 12),
            calculationType,
            effectiveRate,
          },
          "FinanceOS",
          this.sagaId
        );
      } else {
        eventBus.publish(
          RevenueEvents.COMMISSION_PAID,
          {
            dealId: this.dealId,
            agentId: this.agentId,
            amount,
            currency: this.localization.currency,
            calculationType,
            effectiveRate,
            appliedRules,
          },
          "FinanceOS",
          this.sagaId
        );
      }
    }, 600);
  }

  public async onInstallmentOffered(msg: EventMessage) {
    console.log(
      `[CommissionPaymentSaga] Installment plan offered: ${msg.payload.monthlyAmount} ${this.localization.currency}/mo x ${msg.payload.installments} months. ` +
        `Type: ${msg.payload.calculationType || "Standard"}`
    );
    await this.transition({ step: "INSTALLMENT_OFFERED" });
  }

  public async onInstallmentStarted(msg: EventMessage) {
    console.log(`[CommissionPaymentSaga] Agent accepted installment plan. COMMISSION SAGA COMPLETE.`);
    await this.complete();
  }

  public async onCommissionPaid(msg: EventMessage) {
    console.log(
      `[CommissionPaymentSaga] Lump sum commission paid. SAGA COMPLETE. ` +
        `Type: ${msg.payload.calculationType || "Standard"}`
    );
    await this.complete();
  }
}

const activeSagas = new Map<string, CommissionPaymentSaga>();

export function registerCommissionPaymentListeners() {
  eventBus.subscribe(RevenueEvents.DEAL_CLOSED, (msg) => {
    const { dealId, agentId, amount, agentType, listingOptimizationStatus, campaignTag, isFirstTransaction, volumeYtd } =
      msg.payload;
    const localization = msg.localization || {
      countryCode: "US",
      language: "en",
      currency: "USD",
      timezone: "America/New_York",
    };
    const saga = new CommissionPaymentSaga(
      dealId,
      agentId,
      amount,
      msg.correlationId,
      localization,
      { agentType, listingOptimizationStatus, campaignTag, isFirstTransaction, volumeYtd }
    );
    activeSagas.set(saga.sagaId, saga);
    saga.onDealClosed();
    console.log(`[CommissionPaymentSaga] Started for Deal ${dealId}`);
  });

  eventBus.subscribe(RevenueEvents.COMMISSION_CREATED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onCommissionCreated(msg);
  });

  eventBus.subscribe(RevenueEvents.COMMISSION_INSTALLMENT_OFFERED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onInstallmentOffered(msg);
  });

  eventBus.subscribe(RevenueEvents.COMMISSION_INSTALLMENT_STARTED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onInstallmentStarted(msg);
  });

  eventBus.subscribe(DomainEvents.COMMISSION_PAID, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onCommissionPaid(msg);
  });
}
