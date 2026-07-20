import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { DomainEvents } from '../events/domain-events';

export class TrustVerificationSaga extends BaseSaga {
  public entityId: string;
  public entityType: string;

  constructor(entityId: string, entityType: string, sagaId?: string, localization?: LocalizationContext) {
    super(sagaId, { step: 'VERIFICATION_REQUESTED', entityId, entityType }, localization);
    this.entityId = entityId;
    this.entityType = entityType;
  }

  protected async compensate(): Promise<void> {
    console.log(`[TrustVerificationSaga] Compensating trust verification for ${this.entityId}.`);
  }

  public async onVerificationRequested() {
    console.log(`[TrustVerificationSaga] Verification requested for ${this.entityId}. Processing...`);
    await this.transition({ step: 'PROCESSING_VERIFICATION' });
    setTimeout(() => {
      eventBus.publish(DomainEvents.TRUST_VERIFICATION_COMPLETED, { entityId: this.entityId, score: 0.85, localization: this.localization }, 'TrustOS', this.sagaId);
    }, 2000);
  }

  public async onVerificationCompleted(msg: EventMessage) {
    console.log(`[TrustVerificationSaga] Verification completed for ${this.entityId}. TRUST SAGA COMPLETE.`);
    await this.complete();
  }
}

const activeSagas = new Map<string, TrustVerificationSaga>();

export function registerTrustVerificationListeners() {
  eventBus.subscribe(DomainEvents.TRUST_VERIFICATION_REQUESTED, (msg) => {
    const saga = new TrustVerificationSaga(msg.payload.entityId, msg.payload.entityType, msg.correlationId, msg.localization);
    activeSagas.set(saga.sagaId, saga);
    saga.onVerificationRequested();
  });
  eventBus.subscribe(DomainEvents.TRUST_VERIFICATION_COMPLETED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onVerificationCompleted(msg);
  });
}
