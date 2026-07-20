import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { DomainEvents } from '../events/domain-events';

export class InvestmentLifecycleSaga extends BaseSaga {
  public investmentId: string;
  public organizationId: string;

  constructor(investmentId: string, organizationId: string, sagaId?: string, localization?: LocalizationContext) {
    super(sagaId, { step: 'INVESTMENT_CREATED', investmentId, organizationId }, localization);
    this.investmentId = investmentId;
    this.organizationId = organizationId;
  }

  protected async compensate(): Promise<void> {
    console.log(`[InvestmentLifecycleSaga] Compensating investment ${this.investmentId}. Rolling back...`);
  }

  public async onInvestmentCreated() {
    console.log(`[InvestmentLifecycleSaga] Investment ${this.investmentId} created. Processing approval...`);
    await this.transition({ step: 'PROCESSING_APPROVAL' });
    setTimeout(() => {
      eventBus.publish(DomainEvents.INVESTMENT_APPROVED, { investmentId: this.investmentId, status: 'approved', localization: this.localization }, 'InvestmentOS', this.sagaId);
    }, 2000);
  }

  public async onInvestmentApproved(msg: EventMessage) {
    console.log(`[InvestmentLifecycleSaga] Investment ${this.investmentId} approved. Funding...`);
    await this.transition({ step: 'FUNDING_INVESTMENT' });
    setTimeout(() => {
      eventBus.publish(DomainEvents.INVESTMENT_FUNDED, { investmentId: this.investmentId, amount: 100000, localization: this.localization }, 'InvestmentOS', this.sagaId);
    }, 1500);
  }

  public async onInvestmentFunded(msg: EventMessage) {
    console.log(`[InvestmentLifecycleSaga] Investment ${this.investmentId} funded. INVESTMENT SAGA COMPLETE.`);
    await this.complete();
  }
}

const activeSagas = new Map<string, InvestmentLifecycleSaga>();

export function registerInvestmentLifecycleListeners() {
  eventBus.subscribe(DomainEvents.INVESTMENT_CREATED, (msg) => {
    const saga = new InvestmentLifecycleSaga(msg.payload.investmentId, msg.payload.organizationId, msg.correlationId, msg.localization);
    activeSagas.set(saga.sagaId, saga);
    saga.onInvestmentCreated();
  });
  eventBus.subscribe(DomainEvents.INVESTMENT_APPROVED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onInvestmentApproved(msg);
  });
  eventBus.subscribe(DomainEvents.INVESTMENT_FUNDED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onInvestmentFunded(msg);
  });
}
