import { Elysia, t } from "elysia";
import { AIArbitrageService } from "../services/ai-arbitrage";
import { regionMiddleware } from "../middleware/region";

export const aiArbitrageRoutes = new Elysia({ prefix: "/ai-arbitrage" })
  .use(regionMiddleware)
  .get(
    "/upsell",
    async ({ orgId, db, query }) => {
      try {
        const { destination, checkIn, checkOut, guests } = query;
        
        const result = await AIArbitrageService.withDB(db as any).evaluateUpsell({
          destination,
          checkIn,
          checkOut,
          guests: parseInt(guests) || 2
        });

        return {
          success: true,
          data: result
        };
      } catch (error) {
        console.error("Error evaluating AI Upsell:", error);
        return { success: false, error: "Failed to evaluate AI Upsell." };
      }
    },
    {
      query: t.Object({
        destination: t.String(),
        checkIn: t.String(),
        checkOut: t.String(),
        guests: t.String()
      })
    }
  );
