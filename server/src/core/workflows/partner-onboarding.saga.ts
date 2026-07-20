import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { DomainEvents } from '../events/domain-events';

export class PartnerOnboardingSaga extends BaseSaga {
  public partnerId: string;
  public organizationId: string;

  constructor(partnerId: string, organizationId: string, sagaId?: string, localization?: LocalizationContext) {
    super(sagaId, { step: 'PARTNER_ONBOARDED', partnerId, organizationId }, localization);
    this.partnerId = partnerId;
    this.organizationId = organizationId;
  }

  protected async compensate(): Promise<void> {
    console.log(`[PartnerOnboardingSaga] Compensating partner ${this.partnerId}. Rolling back...`);
  }

  public async onPartnerOnboarded() {
    console.log(`[PartnerOnboardingSaga] Partner ${this.partnerId} onboarded. Creating relationship...`);
    await this.transition({ step: 'CREATING_RELATIONSHIP' });
    setTimeout(() => {
      eventBus.publish(DomainEvents.PARTNER_RELATIONSHIP_CREATED, { partnerId: this.partnerId, relationshipType: 'strategic', localization: this.localization }, 'PartnerOS', this.sagaId);
    }, 2000);
  }

  public async onRelationshipCreated(msg: EventMessage) {
    console.log(`[PartnerOnboardingSaga] Relationship created. Signing agreement...`);
    await this.transition({ step: 'SIGNING_AGREEMENT' });
    setTimeout(() => {
      eventBus.publish(DomainEvents.PARTNER_AGREEMENT_SIGNED, { partnerId: this.partnerId, agreementId: 'agreement-123', localization: this.localization }, 'PartnerOS', this.sagaId);
    }, 1500);
  }

  public async onAgreementSigned(msg: EventMessage) {
    console.log(`[PartnerOnboardingSaga] Agreement signed. PARTNER SAGA COMPLETE.`);
    await this.complete();
  }
}

const activeSagas = new Map<string, PartnerOnboardingSaga>();

export function registerPartnerOnboardingListeners() {
  eventBus.subscribe(DomainEvents.PARTNER_ONBOARDED, (msg) => {
    const saga = new PartnerOnboardingSaga(msg.payload.partnerId, msg.payload.organizationId, msg.correlationId, msg.localization);
    activeSagas.set(saga.sagaId, saga);
    saga.onPartnerOnboarded();
  });
  eventBus.subscribe(DomainEvents.PARTNER_RELATIONSHIP_CREATED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onRelationshipCreated(msg);
  });
  eventBus.subscribe(DomainEvents.PARTNER_AGREEMENT_SIGNED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onAgreementSigned(msg);
  });
}
