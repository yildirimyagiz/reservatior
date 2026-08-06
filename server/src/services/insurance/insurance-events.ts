import { EventFactory, EventEnvelope } from "../../events/base/event-envelope";
import { eventBus } from "../../core/events/event-bus";
import { prisma } from "../../lib/prisma";

/**
 * Insurance Integration OS — Event Definitions
 *
 * Follows the Reservatior EventEnvelope standard (event-driven, Security OS
 * compatible). Every event carries tenantId / landlordId / propertyId /
 * rentalPlanId / riskScore / financialImpact / correlationId so downstream
 * consumers (analytics, Security OS AI analyst, webhooks) can correlate.
 *
 * Persistence uses the Transactional Outbox pattern via `EventLog`
 * (PENDING → outbox worker), and in-process dispatch via `eventBus`.
 */
export const InsuranceEvents = {
  QuoteCreated: "insurance.quote.created",
  PolicyActivated: "insurance.policy.activated",
  PremiumPaid: "insurance.premium.paid",
  ClaimCreated: "insurance.claim.created",
  ClaimApproved: "insurance.claim.approved",
  ClaimRejected: "insurance.claim.rejected",
  PaymentReceived: "insurance.payment.received",
} as const;

export type InsuranceEventType = (typeof InsuranceEvents)[keyof typeof InsuranceEvents];

export interface InsuranceEventData {
  tenantId?: string;
  landlordId?: string;
  propertyId?: string;
  rentalPlanId?: string;
  riskScore?: number;
  financialImpact?: number;
  correlationId?: string;
  [key: string]: any;
}

export interface PublishInsuranceEventParams {
  eventType: InsuranceEventType;
  countryCode: string;
  data: InsuranceEventData;
  producer?: string;
  /** Optional transaction client so the EventLog write is atomic with business writes. */
  tx?: typeof prisma;
}

/**
 * Publish an insurance domain event durably (outbox) + in-process (eventBus).
 */
export async function publishInsuranceEvent(
  params: PublishInsuranceEventParams,
): Promise<EventEnvelope> {
  const event = EventFactory.createEvent({
    event_type: params.eventType,
    producer: params.producer ?? "insurance-os",
    country_code: params.countryCode,
    data: params.data,
    correlation_id: params.data.correlationId,
  });

  const db = params.tx ?? prisma;

  try {
    await db.eventLog.create({
      data: {
        eventType: event.event_type,
        aggregateType: "InsuranceOS",
        aggregateId: String(
          event.data.policyId ?? event.data.claimId ?? event.data.quoteId ?? event.event_id,
        ),
        payload: event.data as any,
        status: "PENDING",
      },
    });
  } catch (err) {
    console.error("[InsuranceEvents] EventLog write failed:", err);
  }

  try {
    await eventBus.publish(event.event_type as any, event.data, "InsuranceOS", event.correlation_id);
  } catch (err) {
    console.error("[InsuranceEvents] eventBus publish failed:", err);
  }

  return event;
}
