import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { DomainEvents } from '../events/domain-events';

export class CommerceOrderSaga extends BaseSaga {
  public orderId: string;
  public organizationId: string;

  constructor(orderId: string, organizationId: string, sagaId?: string, localization?: LocalizationContext) {
    super(sagaId, { step: 'ORDER_CREATED', orderId, organizationId }, localization);
    this.orderId = orderId;
    this.organizationId = organizationId;
  }

  protected async compensate(): Promise<void> {
    console.log(`[CommerceOrderSaga] Compensating order ${this.orderId}. Rolling back...`);
  }

  public async onOrderCreated() {
    console.log(`[CommerceOrderSaga] Order ${this.orderId} created. Processing payment...`);
    await this.transition({ step: 'PROCESSING_PAYMENT' });
    setTimeout(() => {
      eventBus.publish(DomainEvents.ORDER_FULFILLED, { orderId: this.orderId, status: 'fulfilled', localization: this.localization }, 'CommerceOS', this.sagaId);
    }, 2000);
  }

  public async onOrderFulfilled(msg: EventMessage) {
    console.log(`[CommerceOrderSaga] Order ${this.orderId} fulfilled. COMMERCE SAGA COMPLETE.`);
    await this.complete();
  }
}

const activeSagas = new Map<string, CommerceOrderSaga>();

export function registerCommerceOrderListeners() {
  eventBus.subscribe(DomainEvents.ORDER_CREATED, (msg) => {
    const saga = new CommerceOrderSaga(msg.payload.orderId, msg.payload.organizationId, msg.correlationId, msg.localization);
    activeSagas.set(saga.sagaId, saga);
    saga.onOrderCreated();
  });
  eventBus.subscribe(DomainEvents.ORDER_FULFILLED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onOrderFulfilled(msg);
  });
}
