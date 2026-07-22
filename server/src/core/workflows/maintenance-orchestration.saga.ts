import { eventBus } from "../events/event-bus";
import { v4 as uuidv4 } from "uuid";

function compensate(completedSteps: { step: string; compensate: () => void }[]) {
  for (const step of [...completedSteps].reverse()) {
    try { step.compensate(); } catch (e) { /* best effort */ }
  }
}

export function registerMaintenanceOrchestrationListeners() {
  eventBus.subscribe("MAINTENANCE_SCHEDULED", async (payload: any) => {
    const sagaId = uuidv4();
    const completedSteps: { step: string; compensate: () => void }[] = [];

    try {
      eventBus.publish("VENDOR_ASSIGNED", {
        sagaId,
        maintenanceId: payload.maintenanceId,
        orgId: payload.orgId,
      });
      completedSteps.push({
        step: "vendor_assigned",
        compensate: () => eventBus.publish("VENDOR_UNASSIGNED", { sagaId }),
      });

      eventBus.publish("WORK_ORDER_CREATED", {
        sagaId,
        maintenanceId: payload.maintenanceId,
        orgId: payload.orgId,
      });
      completedSteps.push({
        step: "work_order_created",
        compensate: () => eventBus.publish("WORK_ORDER_CANCELLED", { sagaId }),
      });

      eventBus.publish("VENDOR_NOTIFIED", {
        sagaId,
        maintenanceId: payload.maintenanceId,
        orgId: payload.orgId,
      });

      eventBus.publish("MAINTENANCE_ORCHESTRATION_COMPLETED", {
        sagaId,
        maintenanceId: payload.maintenanceId,
        orgId: payload.orgId,
      });
    } catch (error: any) {
      eventBus.publish("MAINTENANCE_ORCHESTRATION_FAILED", {
        sagaId,
        maintenanceId: payload.maintenanceId,
        error: error.message,
      });
      compensate(completedSteps);
    }
  });

  eventBus.subscribe("WORK_ORDER_COMPLETED", async (payload: any) => {
    eventBus.publish("MAINTENANCE_STATUS_UPDATED", {
      maintenanceId: payload.maintenanceId,
      status: "COMPLETED",
    });
  });

  eventBus.subscribe("MAINTENANCE_COMPLETED", async (payload: any) => {
    eventBus.publish("INSPECTION_SCHEDULED", {
      propertyId: payload.propertyId,
      orgId: payload.orgId,
      triggerSource: "maintenance_completion",
    });

    eventBus.publish("VENDOR_RATING_REQUESTED", {
      vendorId: payload.vendorId,
      maintenanceId: payload.maintenanceId,
      orgId: payload.orgId,
    });
  });

  eventBus.subscribe("VENDOR_RATED", async (payload: any) => {
    eventBus.publish("VENDOR_RATING_COMPLETED", {
      vendorId: payload.vendorId,
      sagaId: payload.sagaId,
    });
  });
}
