/**
 * Saga: Localization Pipeline
 * 
 * Flow:
 *   localization.country_created
 *       |
 *   [Setup country-specific configurations]
 *       |
 *   localization.translated
 *       |
 *   [Content localization]
 *       |
 *   localization.content_updated
 *       |
 *   [Localization complete]
 */

import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { DomainEvents } from '../events/domain-events';

export class LocalizationPipelineSaga extends BaseSaga {
  public countryId: string;
  public countryCode: string;
  public language: string;
  public currency: string;
  public organizationId: string;

  constructor(
    countryId: string,
    countryCode: string,
    language: string,
    currency: string,
    organizationId: string,
    sagaId?: string,
    localization?: LocalizationContext
  ) {
    super(sagaId, { step: 'COUNTRY_CREATED', countryId, countryCode, language, currency, organizationId }, localization);
    this.countryId = countryId;
    this.countryCode = countryCode;
    this.language = language;
    this.currency = currency;
    this.organizationId = organizationId;
  }

  protected async compensate(): Promise<void> {
    console.log(`[LocalizationPipelineSaga] Compensating country ${this.countryId}. Rolling back localization setup...`);
  }

  public async onCountryCreated() {
    console.log(`[LocalizationPipelineSaga] Country ${this.countryCode} created. Setting up configurations...`);
    await this.transition({ step: 'SETTING_UP_CONFIGURATIONS' });

    // Simulate setting up country-specific configurations
    setTimeout(() => {
      eventBus.publish(DomainEvents.LOCALIZATION_TRANSLATED, {
        countryId: this.countryId,
        countryCode: this.countryCode,
        language: this.language,
        translatedAt: new Date().toISOString(),
        localization: this.localization
      }, 'LocalizationOS', this.sagaId);
    }, 1500);
  }

  public async onTranslated(msg: EventMessage) {
    console.log(`[LocalizationPipelineSaga] Translation complete for ${this.countryCode}. Updating content...`);
    await this.transition({ step: 'UPDATING_CONTENT' });

    // Simulate content localization
    setTimeout(() => {
      eventBus.publish(DomainEvents.LOCALIZATION_CONTENT_UPDATED, {
        countryId: this.countryId,
        countryCode: this.countryCode,
        language: this.language,
        updatedAt: new Date().toISOString(),
        localization: this.localization
      }, 'LocalizationOS', this.sagaId);
    }, 1000);
  }

  public async onContentUpdated(msg: EventMessage) {
    console.log(`[LocalizationPipelineSaga] Content updated for ${this.countryCode}. LOCALIZATION SAGA COMPLETE.`);
    await this.complete();
  }

  public async onExchangeRateUpdated(msg: EventMessage) {
    console.log(`[LocalizationPipelineSaga] Exchange rate updated for ${this.countryCode}.`);
    await this.transition({ step: 'EXCHANGE_RATE_UPDATED' });
  }
}

// ─── Registry ─────────────────────────────────────────────────────────────────
const activeSagas = new Map<string, LocalizationPipelineSaga>();

export function registerLocalizationPipelineListeners() {
  eventBus.subscribe(DomainEvents.LOCALIZATION_COUNTRY_CREATED, (msg) => {
    const { countryId, countryCode, language, currency, organizationId } = msg.payload;
    const localization = msg.localization || {
      countryCode: 'US',
      language: 'en',
      currency: 'USD',
      timezone: 'America/New_York'
    };
    const saga = new LocalizationPipelineSaga(countryId, countryCode, language, currency, organizationId, msg.correlationId, localization);
    activeSagas.set(saga.sagaId, saga);
    saga.onCountryCreated();
    console.log(`[LocalizationPipelineSaga] ✅ Started for Country ${countryCode}`);
  });

  eventBus.subscribe(DomainEvents.LOCALIZATION_TRANSLATED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onTranslated(msg);
  });

  eventBus.subscribe(DomainEvents.LOCALIZATION_CONTENT_UPDATED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onContentUpdated(msg);
  });

  eventBus.subscribe(DomainEvents.LOCALIZATION_EXCHANGE_RATE_UPDATED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onExchangeRateUpdated(msg);
  });
}
