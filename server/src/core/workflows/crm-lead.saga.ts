import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { DomainEvents } from '../events/domain-events';

export class CRMLeadSaga extends BaseSaga {
  public leadId: string;
  public organizationId: string;

  constructor(leadId: string, organizationId: string, sagaId?: string, localization?: LocalizationContext) {
    super(sagaId, { step: 'LEAD_CREATED', leadId, organizationId }, localization);
    this.leadId = leadId;
    this.organizationId = organizationId;
  }

  protected async compensate(): Promise<void> {
    console.log(`[CRMLeadSaga] Compensating lead ${this.leadId}. Rolling back...`);
  }

  public async onLeadCreated() {
    console.log(`[CRMLeadSaga] Lead ${this.leadId} created. Qualifying...`);
    await this.transition({ step: 'QUALIFYING_LEAD' });
    setTimeout(() => {
      eventBus.publish(DomainEvents.LEAD_CONVERTED, { leadId: this.leadId, status: 'converted', localization: this.localization }, 'CRMOS', this.sagaId);
    }, 2000);
  }

  public async onLeadConverted(msg: EventMessage) {
    console.log(`[CRMLeadSaga] Lead ${this.leadId} converted. CRM SAGA COMPLETE.`);
    await this.complete();
  }
}

const activeSagas = new Map<string, CRMLeadSaga>();

export function registerCRMLeadListeners() {
  eventBus.subscribe(DomainEvents.LEAD_CREATED, (msg) => {
    const saga = new CRMLeadSaga(msg.payload.leadId, msg.payload.organizationId, msg.correlationId, msg.localization);
    activeSagas.set(saga.sagaId, saga);
    saga.onLeadCreated();
  });
  eventBus.subscribe(DomainEvents.LEAD_CONVERTED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onLeadConverted(msg);
  });
}
