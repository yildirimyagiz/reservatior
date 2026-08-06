import Elysia, { t } from "elysia";
import { eventBus } from "../core/events/event-bus";
import { hybridRentalEngine, PropertyInputData } from "../services/intelligence/hybrid-rental-engine";
import { hybridRentalMultiAgentSwarm } from "../services/ai/hybrid-rental-multi-agent";
import { acquisitionEngine } from "../services/intelligence/acquisition-engine";
import { revenueDAGEngine } from "../services/intelligence/revenue-dag-engine";

export const hybridRentalOSRoutes = new Elysia({ prefix: "/api/os/hybrid-rental" })
  .post(
    "/trigger-saga",
    async ({ body }) => {
      const propertyId = body.propertyId || `PROP-${Math.floor(100000 + Math.random() * 900000)}`;
      const correlationId = `SAGA-${Math.floor(100000 + Math.random() * 900000)}`;

      eventBus.publish('hybrid.evaluation.requested', {
        propertyId,
        neighbourhood: body.neighbourhood || 'Beyoğlu',
        accommodates: body.accommodates || 4,
        sizeSqm: body.sizeSqm || 85,
        hasBuildingConsent100Pct: body.hasBuildingConsent100Pct ?? true,
        hasTourismResidenceLicense: body.hasTourismResidenceLicense ?? true
      }, 'HybridRentalOS', correlationId);

      return {
        success: true,
        sagaId: correlationId,
        propertyId,
        status: "SAGA_STARTED",
        message: `HybridRentalOnboardingSaga triggered successfully with correlation ID ${correlationId}`
      };
    },
    {
      body: t.Object({
        propertyId: t.Optional(t.String()),
        neighbourhood: t.Optional(t.String()),
        accommodates: t.Optional(t.Number()),
        sizeSqm: t.Optional(t.Number()),
        hasBuildingConsent100Pct: t.Optional(t.Boolean()),
        hasTourismResidenceLicense: t.Optional(t.Boolean())
      })
    }
  )

  .post(
    "/trigger-compensation",
    async ({ body }) => {
      const sagaId = body.sagaId || `SAGA-${Math.floor(100000 + Math.random() * 900000)}`;

      eventBus.publish('hybrid.compensation.requested', {
        reason: body.reason || '7464 Sayılı Kanun Kat Malikleri Muvafakat Reddi'
      }, 'HybridRentalOS', sagaId);

      return {
        success: true,
        sagaId,
        status: "COMPENSATION_TRIGGERED",
        message: `Compensation rollback initiated for Saga ID ${sagaId}`
      };
    },
    {
      body: t.Object({
        sagaId: t.String(),
        reason: t.Optional(t.String())
      })
    }
  )

  .post(
    "/multi-agent-swarm",
    async ({ body }) => {
      const inputData: PropertyInputData = {
        neighbourhood: body.neighbourhood || "Beyoğlu",
        roomType: "Entire home/apt",
        accommodates: Number(body.accommodates || 4),
        bedrooms: 2,
        bathrooms: 1,
        sizeSqm: Number(body.sizeSqm || 85),
        buildingAge: 5,
        isFurnished: true,
        hasElevator: true,
        hasParking: false,
        hasPoolOrGym: false,
        proximityToMetroMins: 5,
        proximityToAirportMins: 35,
        hasBuildingConsent100Pct: true,
        hasTourismResidenceLicense: true,
        hasKabisRegistration: true
      };

      const evalResult = hybridRentalEngine.evaluateProperty(inputData);
      const swarmResult = hybridRentalMultiAgentSwarm.runSwarmAnalysis(inputData, evalResult);

      return {
        success: true,
        evaluation: evalResult,
        swarm: swarmResult
      };
    },
    {
      body: t.Object({
        neighbourhood: t.Optional(t.String()),
        accommodates: t.Optional(t.Number()),
        sizeSqm: t.Optional(t.Number())
      })
    }
  )

  .post(
    "/acquisition-discover",
    async ({ body }) => {
      const scanResult = acquisitionEngine.discoverAcquisitionTargets(body.neighbourhood);
      return {
        success: true,
        data: scanResult
      };
    },
    {
      body: t.Object({
        neighbourhood: t.Optional(t.String())
      })
    }
  )

  .post(
    "/revenue-dag-process",
    async ({ body }) => {
      const grossRevenue = Number(body.grossRevenueTRY || 98500);
      const propertyId = body.propertyId || "PROP-546038";
      const dagResult = revenueDAGEngine.processBookingRevenueDAG(propertyId, grossRevenue);
      return {
        success: true,
        data: dagResult
      };
    },
    {
      body: t.Object({
        propertyId: t.Optional(t.String()),
        grossRevenueTRY: t.Optional(t.Number())
      })
    }
  );
