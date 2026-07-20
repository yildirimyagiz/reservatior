import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { DomainEvents } from '../events/domain-events';

export class AdsCampaignSaga extends BaseSaga {
  public campaignId: string;
  public organizationId: string;

  constructor(campaignId: string, organizationId: string, sagaId?: string, localization?: LocalizationContext) {
    super(sagaId, { step: 'CAMPAIGN_CREATED', campaignId, organizationId }, localization);
    this.campaignId = campaignId;
    this.organizationId = organizationId;
  }

  protected async compensate(): Promise<void> {
    console.log(`[AdsCampaignSaga] Compensating campaign ${this.campaignId}. Rolling back...`);
  }

  public async onCampaignCreated() {
    console.log(`[AdsCampaignSaga] Campaign ${this.campaignId} created. Publishing ads...`);
    await this.transition({ step: 'PUBLISHING_ADS' });
    setTimeout(() => {
      eventBus.publish(DomainEvents.AD_PUBLISHED, { campaignId: this.campaignId, adCount: 5, localization: this.localization }, 'AdsOS', this.sagaId);
    }, 1500);
  }

  public async onAdPublished(msg: EventMessage) {
    console.log(`[AdsCampaignSaga] Ads published for campaign ${this.campaignId}. ADS SAGA COMPLETE.`);
    await this.complete();
  }
}

const activeSagas = new Map<string, AdsCampaignSaga>();

export function registerAdsCampaignListeners() {
  eventBus.subscribe(DomainEvents.AD_CAMPAIGN_CREATED, (msg) => {
    const saga = new AdsCampaignSaga(msg.payload.campaignId, msg.payload.organizationId, msg.correlationId, msg.localization);
    activeSagas.set(saga.sagaId, saga);
    saga.onCampaignCreated();
  });
  eventBus.subscribe(DomainEvents.AD_PUBLISHED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onAdPublished(msg);
  });
}
