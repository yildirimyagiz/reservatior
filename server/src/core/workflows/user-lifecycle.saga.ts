import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { DomainEvents } from '../events/domain-events';

export class UserLifecycleSaga extends BaseSaga {
  public userId: string;
  public organizationId: string;

  constructor(userId: string, organizationId: string, sagaId?: string, localization?: LocalizationContext) {
    super(sagaId, { step: 'USER_CREATED', userId, organizationId }, localization);
    this.userId = userId;
    this.organizationId = organizationId;
  }

  protected async compensate(): Promise<void) {
    console.log(`[UserLifecycleSaga] Compensating user ${this.userId}. Rolling back...`);
  }

  public async onUserCreated() {
    console.log(`[UserLifecycleSaga] User ${this.userId} created. Setting up profile...`);
    await this.transition({ step: 'SETTING_UP_PROFILE' });
    setTimeout(() => {
      eventBus.publish(DomainEvents.USER_UPDATED, { userId: this.userId, updates: {}, localization: this.localization }, 'UserOS', this.sagaId);
    }, 1000);
  }

  public async onUserUpdated(msg: EventMessage) {
    console.log(`[UserLifecycleSaga] User ${this.userId} updated. USER SAGA COMPLETE.`);
    await this.complete();
  }
}

const activeSagas = new Map<string, UserLifecycleSaga>();

export function registerUserLifecycleListeners() {
  eventBus.subscribe(DomainEvents.USER_CREATED, (msg) => {
    const saga = new UserLifecycleSaga(msg.payload.userId, msg.payload.organizationId, msg.correlationId, msg.localization);
    activeSagas.set(saga.sagaId, saga);
    saga.onUserCreated();
  });
  eventBus.subscribe(DomainEvents.USER_UPDATED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onUserUpdated(msg);
  });
}
