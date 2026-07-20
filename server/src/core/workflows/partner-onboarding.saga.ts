/**
 * Partner Onboarding Saga
 *
 * Flow: partner registered → log onboarding start
 *       partner agreement signed → activate partner status
 */
import { eventBus } from "../events/event-bus";
import { DomainEvents, EventMessage } from "../events/domain-events";

export function registerPartnerOnboardingListeners() {
  eventBus.subscribe(DomainEvents.PARTNER_REGISTERED, async (msg: EventMessage) => {
    const { partnerId, orgId, partnerType } = msg.payload;
    console.log(`[PartnerOnboardingSaga] 📋 Partner registered: ${partnerId} (type: ${partnerType})`);

    eventBus.publish(DomainEvents.AUDIT_LOG_CREATED, {
      action: "PARTNER_ONBOARDING_STARTED",
      partnerId,
      partnerType,
      orgId,
      timestamp: new Date(),
    }, "PartnerOS", msg.correlationId);
  });

  eventBus.subscribe(DomainEvents.PARTNER_AGREEMENT_SIGNED, async (msg: EventMessage) => {
    const { partnerId, orgId, agreementId } = msg.payload;
    console.log(`[PartnerOnboardingSaga] ✍️  Agreement signed for partner ${partnerId} (agreement: ${agreementId})`);

    eventBus.publish(DomainEvents.AUDIT_LOG_CREATED, {
      action: "PARTNER_ACTIVATED",
      partnerId,
      agreementId,
      orgId,
      timestamp: new Date(),
    }, "PartnerOS", msg.correlationId);
  });

  eventBus.subscribe(DomainEvents.PARTNER_AGREEMENT_EXPIRED, async (msg: EventMessage) => {
    const { partnerId, orgId, agreementId } = msg.payload;
    console.log(`[PartnerOnboardingSaga] ⏰ Agreement expired for partner ${partnerId} (agreement: ${agreementId})`);

    eventBus.publish(DomainEvents.AUDIT_LOG_CREATED, {
      action: "PARTNER_AGREEMENT_EXPIRED",
      partnerId,
      agreementId,
      orgId,
      timestamp: new Date(),
    }, "PartnerOS", msg.correlationId);
  });
}
