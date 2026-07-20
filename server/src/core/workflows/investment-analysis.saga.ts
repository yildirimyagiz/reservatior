/**
 * Investment Analysis Saga
 * 
 * Flow: DEAL_CREATED → valuation → comparables → projection → recommendation
 * Each step has compensation for rollback.
 */
import { eventBus } from "../events/event-bus";
import { v4 as uuidv4 } from "uuid";

const sagaSteps: string[] = [];
const completedSteps: { step: string;补偿: () => void }[] = [];

function compensate() {
  for (const step of [...completedSteps].reverse()) {
    try { step.补偿(); } catch (e) { /* best effort */ }
  }
}

export function registerInvestmentAnalysisListeners() {
  eventBus.subscribe("DEAL_CREATED", async (payload: any) => {
    const sagaId = uuidv4();
    completedSteps.length = 0;
    
    try {
      // Step 1: Trigger property valuation
      eventBus.publish("VALUATION_REQUESTED", {
        sagaId,
        propertyId: payload.propertyId,
        orgId: payload.orgId,
      });
      completedSteps.push({
        step: "valuation",
        补偿: () => eventBus.publish("VALUATION_CANCELLED", { sagaId }),
      });

      // Step 2: Fetch market comparables
      eventBus.publish("COMPARABLES_FETCHED", {
        sagaId,
        propertyId: payload.propertyId,
        orgId: payload.orgId,
      });
      completedSteps.push({
        step: "comparables",
        补偿: () => eventBus.publish("COMPARABLES_DISCARDED", { sagaId }),
      });

      // Step 3: Generate investment projection
      eventBus.publish("PROJECTION_GENERATED", {
        sagaId,
        dealId: payload.dealId,
        orgId: payload.orgId,
      });
      completedSteps.push({
        step: "projection",
        补偿: () => eventBus.publish("PROJECTION_DISCARDED", { sagaId }),
      });

      // Step 4: Emit AI recommendation
      eventBus.publish("INVESTMENT_RECOMMENDATION_READY", {
        sagaId,
        dealId: payload.dealId,
        orgId: payload.orgId,
        recommendedAt: new Date(),
      });

      eventBus.publish("INVESTMENT_ANALYSIS_COMPLETED", {
        sagaId,
        dealId: payload.dealId,
        orgId: payload.orgId,
      });
    } catch (error: any) {
      eventBus.publish("INVESTMENT_ANALYSIS_FAILED", {
        sagaId,
        dealId: payload.dealId,
        error: error.message,
      });
      compensate();
    }
  });

  eventBus.subscribe("INVESTMENT_RECOMMENDATION_ACCEPTED", async (payload: any) => {
    eventBus.publish("DEAL_STATUS_UPDATED", {
      dealId: payload.dealId,
      status: "ANALYZED",
    });
  });

  eventBus.subscribe("INVESTMENT_RECOMMENDATION_REJECTED", async (payload: any) => {
    eventBus.publish("DEAL_STATUS_UPDATED", {
      dealId: payload.dealId,
      status: "NEEDS_REVIEW",
    });
  });
}
