/**
 * Maintenance Orchestration Saga
 * 
 * Flow: schedule → vendor → work order → in progress → completed → rated
 */
import { eventBus } from "../events/event-bus";
import { v4 as uuidv4 } from "uuid";

const completedSteps: { step: string; compensate: () => void }[] = [];

function compensate() {
  for (const step of [...completedSteps].reverse()) {
    try { step.compensate(); } catch (e) { /* best effort */ }
  }
}

export function registerMaintenanceOrchestrationListeners() {
  eventBus.subscribe("MAINTENANCE_SCHEDULED", async (payload: any) => {
    const sagaId = uuidv4();
    completedSteps.length = 0;

    try {
      // Step 1: Assign vendor
      eventBus.publish("VENDOR_ASSIGNED", {
        sagaId,
        maintenanceId: payload.maintenanceId,
        orgId: payload.orgId,
      });
      completedSteps.push({
        step: "vendor_assigned",
        compensate: () => eventBus.publish("VENDOR_UNASSIGNED", { sagaId }),
      });

      // Step 2: Create work order
      eventBus.publish("WORK_ORDER_CREATED", {
        sagaId,
        maintenanceId: payload.maintenanceId,
        orgId: payload.orgId,
      });
      completedSteps.push({
        step: "work_order_created",
        compensate: () => eventBus.publish("WORK_ORDER_CANCELLED", { sagaId }),
      });

      // Step 3: Notify vendor
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
      compensate();
    }
  });

  eventBus.subscribe("WORK_ORDER_COMPLETED", async (payload: any) => {
    eventBus.publish("MAINTENANCE_STATUS_UPDATED", {
      maintenanceId: payload.maintenanceId,
      status: "COMPLETED",
    });
  });

  eventBus.subscribe("MAINTENANCE_COMPLETED", async (payload: any) => {
    // Auto-trigger inspection
    eventBus.publish("INSPECTION_SCHEDULED", {
      propertyId: payload.propertyId,
      orgId: payload.orgId,
      triggerSource: "maintenance_completion",
    });

    // Auto-trigger vendor rating
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
