/**
 * Localization Sync Saga
 *
 * Flow: exchange rate imported → log rate change, trigger financial recalculation
 */
import { eventBus } from "../events/event-bus";
import { DomainEvents, EventMessage } from "../events/domain-events";

export function registerLocalizationSyncListeners() {
  eventBus.subscribe(DomainEvents.EXCHANGE_RATE_IMPORTED, async (msg: EventMessage) => {
    const { rateId, orgId, baseCurrency, targetCurrency, rate } = msg.payload;
    console.log(`[LocalizationSyncSaga] 💱 Exchange rate imported: ${baseCurrency} → ${targetCurrency} @ ${rate} (id: ${rateId})`);

    eventBus.publish(DomainEvents.CURRENCY_RATE_UPDATED, {
      rateId,
      baseCurrency,
      targetCurrency,
      rate,
      orgId,
      updatedAt: new Date(),
    }, "LocalizationOS", msg.correlationId);

    eventBus.publish(DomainEvents.AUDIT_LOG_CREATED, {
      action: "EXCHANGE_RATE_IMPORTED",
      rateId,
      baseCurrency,
      targetCurrency,
      rate,
      orgId,
      timestamp: new Date(),
    }, "LocalizationOS", msg.correlationId);
  });

  eventBus.subscribe(DomainEvents.TAX_REGULATION_CREATED, async (msg: EventMessage) => {
    const { regulationId, orgId, jurisdiction, taxType } = msg.payload;
    console.log(`[LocalizationSyncSaga] 📜 Tax regulation created: ${taxType} in ${jurisdiction} (id: ${regulationId})`);

    eventBus.publish(DomainEvents.AUDIT_LOG_CREATED, {
      action: "TAX_REGULATION_CREATED",
      regulationId,
      jurisdiction,
      taxType,
      orgId,
      timestamp: new Date(),
    }, "LocalizationOS", msg.correlationId);
  });

  eventBus.subscribe(DomainEvents.COMPLIANCE_STATUS_CHANGED, async (msg: EventMessage) => {
    const { orgId, jurisdiction, status } = msg.payload;
    console.log(`[LocalizationSyncSaga] 🔄 Compliance status changed: ${jurisdiction} → ${status}`);

    eventBus.publish(DomainEvents.AUDIT_LOG_CREATED, {
      action: "LOCALIZATION_COMPLIANCE_CHANGED",
      jurisdiction,
      status,
      orgId,
      timestamp: new Date(),
    }, "LocalizationOS", msg.correlationId);
  });
}
