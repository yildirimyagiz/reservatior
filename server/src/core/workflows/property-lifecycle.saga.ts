import { eventBus } from "../events/event-bus";
import { v4 as uuidv4 } from "uuid";

export function registerPropertyLifecycleListeners() {
  eventBus.subscribe("PROPERTY_CREATED", async (payload: any) => {
    const sagaId = uuidv4();
    try {
      eventBus.publish("MAINTENANCE_SCHEDULED", { sagaId, propertyId: payload.propertyId, orgId: payload.orgId });
      eventBus.publish("PROPERTY_INSPECTION_QUEUED", { sagaId, propertyId: payload.propertyId, orgId: payload.orgId });
      eventBus.publish("PROPERTY_VALUATION_REQUESTED", { sagaId, propertyId: payload.propertyId, orgId: payload.orgId });
      eventBus.publish("PROPERTY_LIFECYCLE_COMPLETED", { sagaId, propertyId: payload.propertyId });
    } catch (error: any) {
      eventBus.publish("PROPERTY_LIFECYCLE_FAILED", { sagaId, propertyId: payload.propertyId, error: error.message });
    }
  });

  eventBus.subscribe("MAINTENANCE_COMPLETED", async (payload: any) => {
    eventBus.publish("PROPERTY_INSPECTION_SCHEDULED", { propertyId: payload.propertyId, orgId: payload.orgId, triggerSource: "maintenance" });
  });

  eventBus.subscribe("PROPERTY_VALUATION_COMPLETED", async (payload: any) => {
    eventBus.publish("LISTING_PRICE_UPDATED", { propertyId: payload.propertyId, valuation: payload.valuation, orgId: payload.orgId });
  });
}
