import { EventFactory } from "../../events/base/event-envelope";
import { eventBus } from "../../core/events/event-bus";
import { prisma } from "../../lib/prisma";

/**
 * Rental Finance OS — Event Publisher
 *
 * Publishes durable outbox events (EventLog) + in-process dispatch (eventBus)
 * for every Rental Finance domain event. Replaces the previous console.log stub.
 */
export const RentalFinanceEvents = {
  PlanCreated: "rental.plan.created",
  PlanActivated: "rental.plan.activated",
  PlanTerminated: "rental.plan.terminated",
  PaymentScheduled: "rental.payment.scheduled",
  PaymentProcessed: "rental.payment.processed",
  PaymentLate: "rental.payment.late",
  EscrowCreated: "rental.escrow.created",
  EscrowReleased: "rental.escrow.released",
  RiskScored: "rental.risk.scored",
  TenantScoreUpdated: "rental.tenant.score.updated",
} as const;

export type RentalFinanceEventType =
  (typeof RentalFinanceEvents)[keyof typeof RentalFinanceEvents];

export interface RentalFinanceEventData {
  tenantId?: string;
  landlordId?: string;
  propertyId?: string;
  rentalPlanId?: string;
  paymentId?: string;
  escrowId?: string;
  riskScore?: number;
  financialImpact?: number;
  correlationId?: string;
  [key: string]: any;
}

export class RentalEventPublisher {
  async publish(input: {
    eventType: RentalFinanceEventType | string;
    countryCode: string;
    data: RentalFinanceEventData;
    producer?: string;
    tx?: typeof prisma;
  }): Promise<void> {
    const event = EventFactory.createEvent({
      event_type: input.eventType,
      producer: input.producer ?? "rental-finance-os",
      country_code: input.countryCode,
      data: input.data,
      correlation_id: input.data.correlationId,
    });

    const db = input.tx ?? prisma;
    try {
      await db.eventLog.create({
        data: {
          eventType: event.event_type,
          aggregateType: "RentalFinanceOS",
          aggregateId: String(
            input.data.rentalPlanId ?? input.data.paymentId ?? input.data.escrowId ?? event.event_id,
          ),
          payload: event.data as any,
          status: "PENDING",
        },
      });
    } catch (err) {
      console.error("[RentalEventPublisher] EventLog write failed:", err);
    }

    try {
      await eventBus.publish(
        event.event_type as any,
        event.data,
        "RentalFinanceOS",
        event.correlation_id,
      );
    } catch (err) {
      console.error("[RentalEventPublisher] eventBus publish failed:", err);
    }
  }
}

export const rentalEventPublisher = new RentalEventPublisher();
