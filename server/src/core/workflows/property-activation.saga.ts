import { eventBus } from "../events/event-bus";
import { v4 as uuidv4 } from "uuid";

export function registerPropertyActivationListeners() {
  eventBus.subscribe("PROPERTY_CREATED", async (payload: any) => {
    const sagaId = uuidv4();
    try {
      eventBus.publish("PROPERTY_PHOTOS_REQUESTED", { sagaId, propertyId: payload.propertyId, orgId: payload.orgId });
      eventBus.publish("PROPERTY_LISTING_PUBLISHED", { sagaId, propertyId: payload.propertyId, orgId: payload.orgId });
      eventBus.publish("PROPERTY_AI_IMPROVEMENT_QUEUED", { sagaId, propertyId: payload.propertyId, orgId: payload.orgId });
      eventBus.publish("PROPERTY_STAGING_STARTED", { sagaId, propertyId: payload.propertyId, orgId: payload.orgId });
      eventBus.publish("PROPERTY_AD_GENERATED", { sagaId, propertyId: payload.propertyId, orgId: payload.orgId });
      eventBus.publish("PROPERTY_ACTIVATION_COMPLETED", { sagaId, propertyId: payload.propertyId });
    } catch (error: any) {
      eventBus.publish("PROPERTY_ACTIVATION_FAILED", { sagaId, propertyId: payload.propertyId, error: error.message });
    }
  });

  eventBus.subscribe("PROPERTY_LISTING_PUBLISHED", async (payload: any) => {
    eventBus.publish("PROPERTY_STATUS_UPDATED", { propertyId: payload.propertyId, status: "ACTIVE" });
  });
}
