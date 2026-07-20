/**
 * Developer API Lifecycle Saga
 *
 * Flow: API key created → log creation, audit
 *       webhook registered → validate endpoint, log registration
 */
import { eventBus } from "../events/event-bus";
import { DomainEvents, EventMessage } from "../events/domain-events";

export function registerDeveloperApiLifecycleListeners() {
  eventBus.subscribe(DomainEvents.API_KEY_CREATED, async (msg: EventMessage) => {
    const { keyId, orgId, scopes } = msg.payload;
    console.log(`[DeveloperApiLifecycleSaga] 🔑 API key created: ${keyId} (scopes: ${scopes?.join(", ")})`);

    eventBus.publish(DomainEvents.AUDIT_LOG_CREATED, {
      action: "API_KEY_CREATED",
      keyId,
      scopes,
      orgId,
      timestamp: new Date(),
    }, "DeveloperAPIOS", msg.correlationId);
  });

  eventBus.subscribe(DomainEvents.WEBHOOK_REGISTERED, async (msg: EventMessage) => {
    const { webhookId, orgId, url } = msg.payload;
    console.log(`[DeveloperApiLifecycleSaga] 🪝 Webhook registered: ${webhookId} → ${url}`);

    eventBus.publish(DomainEvents.AUDIT_LOG_CREATED, {
      action: "WEBHOOK_REGISTERED",
      webhookId,
      url,
      orgId,
      timestamp: new Date(),
    }, "DeveloperAPIOS", msg.correlationId);
  });

  eventBus.subscribe(DomainEvents.WEBHOOK_DELIVERY_FAILED, async (msg: EventMessage) => {
    const { webhookId, orgId, error } = msg.payload;
    console.log(`[DeveloperApiLifecycleSaga] ⚠️  Webhook delivery failed: ${webhookId} — ${error}`);

    eventBus.publish(DomainEvents.AUDIT_LOG_CREATED, {
      action: "WEBHOOK_DELIVERY_FAILED",
      webhookId,
      error,
      orgId,
      timestamp: new Date(),
    }, "DeveloperAPIOS", msg.correlationId);
  });
}
