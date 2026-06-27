import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { agentPerformanceService } from "../services/agentperformance";

export const agentsRoutes = new Elysia({ prefix: "/agents" })
  .use(authMiddleware)

  /**
   * GET /agents/:id/performance
   * Gets performance metrics for a specific agent
   */
  .get("/:id/performance", async ({ params, query }) => {
    const { id } = params;
    const { period = "30d" } = query as any;
    
    // Mock performance data for now
    const mockPerformance = {
      agentId: id,
      period,
      metrics: {
        totalListings: 12,
        activeListings: 8,
        soldListings: 4,
        averageSalePrice: 450000,
        totalCommission: 13500,
        clientSatisfaction: 4.8,
        responseTime: "2.3h"
      },
      trend: {
        listingsChange: "+15%",
        commissionChange: "+22%",
        satisfactionChange: "+0.3"
      }
    };
    
    return mockPerformance;
  }, {
    params: t.Object({ id: t.String() }),
    query: t.Partial(t.Object({
      period: t.Optional(t.String()),
    }))
  });
