import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";
import { treasuryCashFlowService, CashFlowCategory, CashFlowStatus } from "../services/treasury/cash-flow.service";

/**
 * Treasury OS - Cash flow management and treasury operations
 * Manages cash flow forecasting, escrow liquidity, reserve ratios, partner payouts, and settlement timing
 * Extends Finance OS and Rental Finance OS for advanced treasury management
 */
export const treasuryOSRoutes = new Elysia({
  prefix: "/api/v1/treasury-os",
})
  // Forecast cash flow
  .get("/forecast/:orgId/:period", async ({ params, query }) => {
    try {
      const forecast = await treasuryCashFlowService.forecastCashFlow(
        params.orgId,
        params.period,
        query.category as CashFlowCategory
      );
      return { success: true, forecast };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ orgId: t.String(), period: t.String() }),
    query: t.Object({ category: t.Optional(t.String()) }),
    detail: { summary: "Forecast Cash Flow", tags: ["Treasury OS"] },
  })

  // Get liquidity position
  .get("/liquidity/:orgId", async ({ params }) => {
    try {
      const liquidity = await treasuryCashFlowService.getLiquidityPosition(params.orgId);
      return { success: true, liquidity };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ orgId: t.String() }),
    detail: { summary: "Get Liquidity Position", tags: ["Treasury OS"] },
  })

  // Check escrow liquidity
  .get("/escrow-liquidity/:orgId", async ({ params }) => {
    try {
      const liquidity = await treasuryCashFlowService.checkEscrowLiquidity(params.orgId);
      return { success: true, liquidity };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ orgId: t.String() }),
    detail: { summary: "Check Escrow Liquidity", tags: ["Treasury OS"] },
  })

  // Calculate reserve ratio
  .get("/reserve-ratio/:orgId", async ({ params }) => {
    try {
      const ratio = await treasuryCashFlowService.calculateReserveRatio(params.orgId);
      return { success: true, ratio };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ orgId: t.String() }),
    detail: { summary: "Calculate Reserve Ratio", tags: ["Treasury OS"] },
  })

  // Create payout schedule
  .post("/payout", async ({ body }) => {
    try {
      const payout = await treasuryCashFlowService.createPayoutSchedule(
        body.partnerId,
        body.amount,
        new Date(body.dueDate),
        body.metadata
      );
      return { success: true, payout };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      partnerId: t.String(),
      amount: t.Number(),
      dueDate: t.String(),
      metadata: t.Optional(t.Any()),
    }),
    detail: { summary: "Create Payout Schedule", tags: ["Treasury OS"] },
  })

  // Process payout
  .post("/payout/:payoutId/process", async ({ params }) => {
    try {
      const processed = await treasuryCashFlowService.processPayout(params.payoutId);
      return { success: true, processed };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ payoutId: t.String() }),
    detail: { summary: "Process Payout", tags: ["Treasury OS"] },
  })

  // Get payout schedule
  .get("/payouts/:orgId", async ({ params, query }) => {
    try {
      const payouts = await treasuryCashFlowService.getPayoutSchedule(
        params.orgId,
        new Date(query.startDate || new Date()),
        new Date(query.endDate || new Date(Date.now() + 30 * 24 * 60 * 60 * 1000))
      );
      return { success: true, payouts };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ orgId: t.String() }),
    query: t.Object({ startDate: t.Optional(t.String()), endDate: t.Optional(t.String()) }),
    detail: { summary: "Get Payout Schedule", tags: ["Treasury OS"] },
  })

  // Optimize settlement timing
  .get("/settlement-timing/:orgId", async ({ params }) => {
    try {
      const timing = await treasuryCashFlowService.optimizeSettlementTiming(params.orgId);
      return { success: true, timing };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ orgId: t.String() }),
    detail: { summary: "Optimize Settlement Timing", tags: ["Treasury OS"] },
  })

  // Get treasury dashboard
  .get("/dashboard/:orgId", async ({ params }) => {
    try {
      const dashboard = await treasuryCashFlowService.getTreasuryDashboard(params.orgId);
      return { success: true, dashboard };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ orgId: t.String() }),
    detail: { summary: "Treasury Dashboard", tags: ["Treasury OS"] },
  })

  // Get cash flow history
  .get("/history/:orgId", async ({ params, query }) => {
    try {
      const history = await treasuryCashFlowService.getCashFlowHistory(
        params.orgId,
        query.months ? parseInt(query.months) : 12
      );
      return { success: true, history };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ orgId: t.String() }),
    query: t.Object({ months: t.Optional(t.String()) }),
    detail: { summary: "Get Cash Flow History", tags: ["Treasury OS"] },
  })

  // Analyze cash flow trends
  .get("/trends/:orgId", async ({ params }) => {
    try {
      const trends = await treasuryCashFlowService.analyzeCashFlowTrends(params.orgId);
      return { success: true, trends };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ orgId: t.String() }),
    detail: { summary: "Analyze Cash Flow Trends", tags: ["Treasury OS"] },
  });
