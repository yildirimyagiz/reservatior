import { eventBus } from "../events/event-bus";
import { v4 as uuidv4 } from "uuid";

export function registerUserAcquisitionListeners() {
  eventBus.subscribe("USER_SIGNED_UP", async (payload: any) => {
    const sagaId = uuidv4();
    try {
      eventBus.publish("USER_PROFILE_CREATED", { sagaId, userId: payload.userId, orgId: payload.orgId });
      eventBus.publish("USER_EMAIL_VERIFY_SENT", { sagaId, userId: payload.userId, email: payload.email });
      eventBus.publish("USER_IDENTITY_INITIATED", { sagaId, userId: payload.userId, orgId: payload.orgId });
      eventBus.publish("USER_CONSENT_REQUESTED", { sagaId, userId: payload.userId, types: ["TERMS", "PRIVACY", "MARKETING"] });
      eventBus.publish("USER_JOURNEY_STAGE_SET", { sagaId, userId: payload.userId, stage: "SIGNED_UP" });
      eventBus.publish("USER_TRUST_SCORE_INIT", { sagaId, userId: payload.userId, score: 0 });
      eventBus.publish("USER_ACQUISITION_COMPLETED", { sagaId, userId: payload.userId });
    } catch (error: any) {
      eventBus.publish("USER_ACQUISITION_FAILED", { sagaId, userId: payload.userId, error: error.message });
    }
  });

  eventBus.subscribe("USER_EMAIL_VERIFIED", async (payload: any) => {
    eventBus.publish("USER_JOURNEY_STAGE_SET", { userId: payload.userId, stage: "EMAIL_VERIFIED" });
    eventBus.publish("USER_TRUST_SCORE_UPDATE", { userId: payload.userId, delta: 10, reason: "email_verified" });
  });
}
