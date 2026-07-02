import { rabbitMQService, LOCAL_EVENT_BUS } from "../../services/rabbitmq-service";
import { WebhookService } from "../webhooks/webhook-service";

/**
 * Event Types
 */
export type AppEvent = 
  | "OFFER_CREATED"
  | "OFFER_UPDATED"
  | "MAINTENANCE_CREATED"
  | "MAINTENANCE_UPDATED"
  | "TENANT_APPLICATION_SUBMITTED"
  | "TENANT_APPLICATION_APPROVED"
  | "PROPERTY_STATUS_CHANGED"
  | "VIEWING_SCHEDULED"
  | "VIEWING_COMPLETED"
  | "LEASE_EXPIRY_APPROACHING"
  | "RENT_PAYMENT_OVERDUE"
  | "INVOICE_UPLOADED"
  | "QUARTERLY_TAX_REVIEW"
  | "COMPLIANCE_EXPIRY_APPROACHING"
  | "DOCUMENT_EXPIRED"
  | "SECURITY_INCIDENT_CREATED"
  | "AI_TASK_CREATED"
  | "AI_TASK_STARTED"
  | "AI_TASK_PROGRESS"
  | "AI_TASK_COMPLETED"
  | "AI_TASK_FAILED"
  | "LISTING_OPTIMIZED"
  | "STAGING_GENERATED"
  | "AGENT_ASSIGNED"
  | "AGENT_PERFORMANCE_UPDATED"
  | "AGENT_LICENSE_VERIFIED"
  | "COMPLIANCE_ALERT"
  | "CONTRACT_STATE_CHANGED"
  | "ESCROW_HOLDING_ESTABLISHED"
  | "DISPUTE_OPENED"
  | "DISPUTE_ESCALATED"
  | "DISPUTE_RESOLVED"
  | "DEMAND_GENERATED"
  | "CROSS_SELL_OPPORTUNITY";

export class EventDispatcher {
  /**
   * Publishes an event to the message broker (or in-memory fallback).
   */
  static async emit(event: AppEvent, payload: any) {
    try {
      console.log(`[EventDispatcher] Emitting: ${event}`);
      if (!rabbitMQService.isConnected) {
        LOCAL_EVENT_BUS.emit(event, payload);
      } else {
        await rabbitMQService.publishToQueue(event, payload);
      }

      // Also dispatch to webhooks
      // Try to extract orgId from payload if available
      const orgId = payload?.orgId || payload?.organizationId;
      if (orgId) {
        WebhookService.dispatch(event, payload, orgId).catch(err => 
          console.error(`[EventDispatcher] Webhook dispatch error:`, err)
        );
      }
    } catch (error) {
      console.error(`[EventDispatcher] Failed to emit ${event}:`, error);
    }
  }
}
