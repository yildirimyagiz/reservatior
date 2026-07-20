import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { DomainEvents } from '../events/domain-events';

export class APIKeyLifecycleSaga extends BaseSaga {
  public apiKeyId: string;
  public developerId: string;

  constructor(apiKeyId: string, developerId: string, sagaId?: string, localization?: LocalizationContext) {
    super(sagaId, { step: 'API_KEY_CREATED', apiKeyId, developerId }, localization);
    this.apiKeyId = apiKeyId;
    this.developerId = developerId;
  }

  protected async compensate(): Promise<void> {
    console.log(`[APIKeyLifecycleSaga] Compensating API key ${this.apiKeyId}. Rolling back...`);
  }

  public async onAPIKeyCreated() {
    console.log(`[APIKeyLifecycleSaga] API key ${this.apiKeyId} created. Setting up rate limits...`);
    await this.transition({ step: 'SETTING_UP_RATE_LIMITS' });
    setTimeout(() => {
      eventBus.publish(DomainEvents.API_USAGE_LOGGED, { apiKeyId: this.apiKeyId, usage: 0, localization: this.localization }, 'DeveloperAPIOS', this.sagaId);
    }, 1000);
  }

  public async onUsageLogged(msg: EventMessage) {
    console.log(`[APIKeyLifecycleSaga] Usage logged for API key ${this.apiKeyId}. API SAGA COMPLETE.`);
    await this.complete();
  }
}

const activeSagas = new Map<string, APIKeyLifecycleSaga>();

export function registerAPIKeyLifecycleListeners() {
  eventBus.subscribe(DomainEvents.API_KEY_CREATED, (msg) => {
    const saga = new APIKeyLifecycleSaga(msg.payload.apiKeyId, msg.payload.developerId, msg.correlationId, msg.localization);
    activeSagas.set(saga.sagaId, saga);
    saga.onAPIKeyCreated();
  });
  eventBus.subscribe(DomainEvents.API_USAGE_LOGGED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onUsageLogged(msg);
  });
}
