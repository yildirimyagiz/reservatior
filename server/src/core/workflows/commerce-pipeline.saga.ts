/**
 * Saga: Commerce Pipeline
 *
 * Flow:
 *   product.created
 *       |
 *   [Product validation, inventory check]
 *       |
 *   order.created
 *       |
 *   order.paid
 *       |
 *   [Commission calculation]
 *       |
 *   order.fulfilled
 */

import { BaseSaga } from './saga-orchestrator';
import { eventBus } from '../events/event-bus';
import { DomainEvents, EventMessage } from '../events/domain-events';

export class CommercePipelineSaga extends BaseSaga {
  public orderId: string;
  public orgId: string;

  constructor(orderId: string, orgId: string, sagaId?: string) {
    super(sagaId, { step: 'ORDER_CREATED', orderId, orgId });
    this.orderId = orderId;
    this.orgId = orgId;
  }

  protected async compensate(): Promise<void> {
    console.log(`[CommercePipelineSaga] Compensating order ${this.orderId}. Rolling back...`);
    eventBus.publish(DomainEvents.ORDER_CANCELLED, { orderId: this.orderId, reason: 'COMPENSATION' }, 'CommerceOS', this.sagaId);
  }

  public async onOrderCreated() {
    console.log(`[CommercePipelineSaga] Order ${this.orderId} created. Waiting for payment...`);
    await this.transition({ step: 'AWAITING_PAYMENT' });
  }

  public async onOrderPaid(msg: EventMessage) {
    console.log(`[CommercePipelineSaga] Order ${this.orderId} paid. Calculating commission...`);
    await this.transition({ step: 'CALCULATING_COMMISSION' });

    eventBus.publish(DomainEvents.COMMISSION_CALCULATED, {
      orderId: this.orderId,
      orgId: this.orgId,
    }, 'CommerceOS', this.sagaId);

    await this.transition({ step: 'COMMISSION_CALCULATED' });

    eventBus.publish(DomainEvents.ORDER_FULFILLED, {
      orderId: this.orderId,
      orgId: this.orgId,
    }, 'CommerceOS', this.sagaId);
  }

  public async onOrderFulfilled(msg: EventMessage) {
    console.log(`[CommercePipelineSaga] Order ${this.orderId} fulfilled. Pipeline COMPLETE.`);
    await this.complete();
  }

  public async onOrderCancelled(msg: EventMessage) {
    console.log(`[CommercePipelineSaga] Order ${this.orderId} cancelled. Compensating...`);
    await this.compensate();
  }
}

// ─── Registry ─────────────────────────────────────────────────────────────────
const activeSagas = new Map<string, CommercePipelineSaga>();

export function registerCommercePipelineListeners() {
  eventBus.subscribe(DomainEvents.ORDER_CREATED, (msg) => {
    const { orderId, orgId } = msg.payload;
    const saga = new CommercePipelineSaga(orderId, orgId, msg.correlationId);
    activeSagas.set(saga.sagaId, saga);
    saga.onOrderCreated();
    console.log(`[CommercePipelineSaga] Started for order ${orderId}`);
  });

  eventBus.subscribe(DomainEvents.ORDER_PAID, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onOrderPaid(msg);
  });

  eventBus.subscribe(DomainEvents.ORDER_FULFILLED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onOrderFulfilled(msg);
  });

  eventBus.subscribe(DomainEvents.ORDER_CANCELLED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onOrderCancelled(msg);
  });
}
