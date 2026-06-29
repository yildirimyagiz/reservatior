import { Elysia } from "elysia";
import { EscrowEngine } from "../services/financial/escrow-engine";

export const financeOSRoutes = new Elysia({ prefix: "/finance-os" })
  .get("/dashboard", async ({ query, set }) => {
    try {
      // For now, we expect an orgId. In a real app, this comes from auth context.
      const orgId = query.orgId as string;
      if (!orgId) {
        set.status = 400;
        return { error: "orgId query parameter is required" };
      }

      const stats = await EscrowEngine.getDashboardStats(orgId);
      
      return {
        success: true,
        data: stats
      };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  });
