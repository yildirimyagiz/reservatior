import { Elysia, t } from "elysia";
import { insuranceDashboardService } from "../services/insurance/insurance-dashboard-service";

/**
 * Insurance OS Dashboard — matches the GenericOSDashboard client contract
 * (GET /api/v1/{osName}/dashboard?orgId=... → flat { kpis, recentActivity, alerts }).
 */
export const insuranceOSRoutes = new Elysia({ prefix: "/api/v1/insurance-os" }).get(
  "/dashboard",
  async ({ query, set }) => {
    if (!query.orgId) {
      set.status = 400;
      return { error: "orgId is required" };
    }
    return insuranceDashboardService.getStats(query.orgId);
  },
  {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "Insurance OS Dashboard", tags: ["Insurance OS"] },
  },
);
