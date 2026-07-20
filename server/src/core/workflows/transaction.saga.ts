import { eventBus } from "../events/event-bus";
import { v4 as uuidv4 } from "uuid";

export function registerTransactionListeners() {
  eventBus.subscribe("DEAL_CREATED", async (payload: any) => {
    const sagaId = uuidv4();
    try {
      eventBus.publish("CONTRACT_GENERATION_STARTED", { sagaId, dealId: payload.dealId, orgId: payload.orgId });
      eventBus.publish("DEAL_STATUS_UPDATED", { dealId: payload.dealId, status: "CONTRACT_PENDING" });
      eventBus.publish("DEAL_TRANSACTION_COMPLETED", { sagaId, dealId: payload.dealId });
    } catch (error: any) {
      eventBus.publish("DEAL_TRANSACTION_FAILED", { sagaId, dealId: payload.dealId, error: error.message });
    }
  });

  eventBus.subscribe("CONTRACT_SIGNED", async (payload: any) => {
    eventBus.publish("DEAL_STATUS_UPDATED", { dealId: payload.dealId, status: "CONTRACT_SIGNED" });
    eventBus.publish("ESCROW_INITIATED", { dealId: payload.dealId, orgId: payload.orgId });
  });

  eventBus.subscribe("ESCROW_FUNDED", async (payload: any) => {
    eventBus.publish("DEAL_STATUS_UPDATED", { dealId: payload.dealId, status: "ESCROW_FUNDED" });
    eventBus.publish("PAYMENT_PROCESSING", { dealId: payload.dealId, orgId: payload.orgId });
  });

  eventBus.subscribe("PAYMENT_COMPLETED", async (payload: any) => {
    eventBus.publish("COMMISSION_CALCULATED", { dealId: payload.dealId, orgId: payload.orgId });
    eventBus.publish("DEAL_STATUS_UPDATED", { dealId: payload.dealId, status: "CLOSED" });
    eventBus.publish("DEAL_CLOSED", { dealId: payload.dealId, orgId: payload.orgId });
  });
}
