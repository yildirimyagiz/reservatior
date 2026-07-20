import { eventBus } from "../events/event-bus";
import { v4 as uuidv4 } from "uuid";

export function registerLeadConversionListeners() {
  eventBus.subscribe("LEAD_CREATED", async (payload: any) => {
    const sagaId = uuidv4();
    try {
      eventBus.publish("LEAD_ASSIGNED", { sagaId, leadId: payload.leadId, orgId: payload.orgId });
      eventBus.publish("LEAD_NURTURE_STARTED", { sagaId, leadId: payload.leadId, orgId: payload.orgId });
      eventBus.publish("LEAD_SCORE_CALCULATED", { sagaId, leadId: payload.leadId, orgId: payload.orgId });
      eventBus.publish("LEAD_CONVERSION_COMPLETED", { sagaId, leadId: payload.leadId });
    } catch (error: any) {
      eventBus.publish("LEAD_CONVERSION_FAILED", { sagaId, leadId: payload.leadId, error: error.message });
    }
  });

  eventBus.subscribe("LEAD_SCORE_HIGH", async (payload: any) => {
    eventBus.publish("LEAD_FOLLOWUP_TRIGGERED", { leadId: payload.leadId, priority: "HIGH", orgId: payload.orgId });
  });

  eventBus.subscribe("LEAD_SCORE_LOW", async (payload: any) => {
    eventBus.publish("LEAD_NURTURE_CONTINUED", { leadId: payload.leadId, orgId: payload.orgId });
  });

  eventBus.subscribe("LEAD_FOLLOWUP_COMPLETED", async (payload: any) => {
    eventBus.publish("LEAD_STATUS_UPDATED", { leadId: payload.leadId, status: "CONTACTED" });
  });
}
