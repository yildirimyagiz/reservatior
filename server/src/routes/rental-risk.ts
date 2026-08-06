import { Elysia, t } from "elysia";
import { rentalRiskEngine } from "../services/rental-finance/rental-risk-engine";

/**
 * Rental Risk Engine (Security OS integrated)
 * Prefix: /api/v1/risk
 */
export const rentalRiskRoutes = new Elysia({ prefix: "/api/v1/risk" })
  .get(
    "/tenant/:tenantId",
    async ({ params: { tenantId } }) => rentalRiskEngine.assessTenantRisk(tenantId),
    { params: t.Object({ tenantId: t.String() }), detail: { summary: "Assess tenant risk", tags: ["Risk"] } },
  )
  .post(
    "/propagate/:rentalPaymentId",
    async ({ params: { rentalPaymentId } }) => rentalRiskEngine.propagateLatePayment(rentalPaymentId),
    { params: t.Object({ rentalPaymentId: t.String() }), detail: { summary: "Propagate late payment risk", tags: ["Risk"] } },
  );
