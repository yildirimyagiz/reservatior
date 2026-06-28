import { Elysia } from "elysia";
import { LOCAL_EVENT_BUS } from "../../services/rabbitmq-service";
import { AppEvent } from "../../core/events/event-dispatcher";

export const triggerStreamRoutes = new Elysia()
  .get("/trigger-stream", ({ set, request }) => {
    // Basic SSE endpoint using standard Web Streams API
    set.headers["Content-Type"] = "text/event-stream";
    set.headers["Cache-Control"] = "no-cache";
    set.headers["Connection"] = "keep-alive";

    const stream = new ReadableStream({
      start(controller) {
        controller.enqueue(`data: ${JSON.stringify({ event: "CONNECTED", time: Date.now() })}\n\n`);

        // We listen to ALL events on the LOCAL_EVENT_BUS and forward them to the client
        const wildcardListener = (eventName: string | symbol, ...args: any[]) => {
          const payload = args[0];
          controller.enqueue(`data: ${JSON.stringify({ event: eventName, payload })}\n\n`);
        };

        LOCAL_EVENT_BUS.on("newListener", () => {}); // No-op, just to not crash
        // If wildcard isn't supported by standard EventEmitter, we just listen to specific events
        // EventEmitter doesn't support wildcard out of the box unless using eventemitter2.
        // We will manually attach to all AppEvents.
        
        const eventNames: AppEvent[] = [
          "OFFER_CREATED", "OFFER_UPDATED", "MAINTENANCE_CREATED", "MAINTENANCE_UPDATED",
          "TENANT_APPLICATION_SUBMITTED", "TENANT_APPLICATION_APPROVED",
          "PROPERTY_STATUS_CHANGED", "VIEWING_SCHEDULED", "VIEWING_COMPLETED",
          "LEASE_EXPIRY_APPROACHING", "RENT_PAYMENT_OVERDUE", "INVOICE_UPLOADED",
          "QUARTERLY_TAX_REVIEW", "COMPLIANCE_EXPIRY_APPROACHING", "DOCUMENT_EXPIRED",
          "SECURITY_INCIDENT_CREATED", "AI_TASK_CREATED", "AI_TASK_STARTED", 
          "AI_TASK_PROGRESS", "AI_TASK_COMPLETED", "AI_TASK_FAILED",
          "LISTING_OPTIMIZED", "STAGING_GENERATED", "AGENT_ASSIGNED",
          "AGENT_PERFORMANCE_UPDATED", "AGENT_LICENSE_VERIFIED", "COMPLIANCE_ALERT"
        ];

        const listeners = new Map<string, any>();

        for (const eventName of eventNames) {
          const listener = (payload: any) => {
            controller.enqueue(`data: ${JSON.stringify({ event: eventName, payload })}\n\n`);
          };
          LOCAL_EVENT_BUS.on(eventName, listener);
          listeners.set(eventName, listener);
        }

        // Cleanup on disconnect
        request.signal.addEventListener("abort", () => {
          for (const [eventName, listener] of listeners.entries()) {
            LOCAL_EVENT_BUS.off(eventName, listener);
          }
          controller.close();
        });
      }
    });

    return stream;
  });
