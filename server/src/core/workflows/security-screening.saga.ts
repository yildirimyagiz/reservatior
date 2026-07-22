import { eventBus } from "../events/event-bus";
import { v4 as uuidv4 } from "uuid";

function compensate(completedSteps: { step: string; compensate: () => void }[]) {
  for (const step of [...completedSteps].reverse()) {
    try { step.compensate(); } catch (e) { /* best effort */ }
  }
}

export function registerSecurityScreeningListeners() {
  eventBus.subscribe("BOOKING_CREATED", async (payload: any) => {
    const sagaId = uuidv4();
    const completedSteps: { step: string; compensate: () => void }[] = [];

    try {
      eventBus.publish("KYC_INITIATED", {
        sagaId,
        userId: payload.userId,
        orgId: payload.orgId,
        bookingId: payload.bookingId,
      });
      completedSteps.push({
        step: "kyc_initiated",
        compensate: () => eventBus.publish("KYC_CANCELLED", { sagaId }),
      });

      eventBus.publish("FRAUD_CHECK_INITIATED", {
        sagaId,
        userId: payload.userId,
        orgId: payload.orgId,
        bookingId: payload.bookingId,
      });
      completedSteps.push({
        step: "fraud_check_initiated",
        compensate: () => eventBus.publish("FRAUD_CHECK_CANCELLED", { sagaId }),
      });

      eventBus.publish("SECURITY_SCREENING_COMPLETED", {
        sagaId,
        bookingId: payload.bookingId,
        userId: payload.userId,
        orgId: payload.orgId,
        completedAt: new Date(),
      });

      eventBus.publish("SECURITY_APPROVED", {
        sagaId,
        bookingId: payload.bookingId,
        userId: payload.userId,
        orgId: payload.orgId,
      });
    } catch (error: any) {
      eventBus.publish("SECURITY_SCREENING_FAILED", {
        sagaId,
        bookingId: payload.bookingId,
        error: error.message,
      });
      compensate(completedSteps);
    }
  });

  eventBus.subscribe("KYC_APPROVED", async (payload: any) => {
    eventBus.publish("SECURITY_STEP_COMPLETED", {
      sagaId: payload.sagaId,
      step: "kyc_verified",
    });
  });

  eventBus.subscribe("KYC_REJECTED", async (payload: any) => {
    eventBus.publish("SECURITY_REJECTED", {
      sagaId: payload.sagaId,
      bookingId: payload.bookingId,
      reason: "KYC verification failed",
    });
  });

  eventBus.subscribe("FRAUD_ALERT_CREATED", async (payload: any) => {
    if (payload.riskLevel === "HIGH" || payload.riskLevel === "CRITICAL") {
      eventBus.publish("SECURITY_REJECTED", {
        sagaId: payload.sagaId,
        bookingId: payload.bookingId,
        reason: `Fraud detected: ${payload.riskLevel} risk`,
      });
    }
  });

  eventBus.subscribe("SECURITY_APPROVED", async (payload: any) => {
    eventBus.publish("BOOKING_SECURITY_CLEARED", {
      bookingId: payload.bookingId,
      userId: payload.userId,
      orgId: payload.orgId,
    });
  });
}
