/**
 * Reservatior FinTech v2 — API Routes
 * Base: /api/v1/fintech
 */

import Elysia, { t } from "elysia";
import {
  createContractFinancials,
  getContractFinancialsByLease,
  calculateTriPartySplit,
  calculateCaptureDates,
  getTodayCaptureCycles,
  markCycleCaptured,
  markCycleFailed,
} from "../services/fintech/hybrid-settlement";
import { processDisbursement } from "../services/fintech/early-capture-scheduler";
import { db } from "../lib/db";

export const fintechRoutes = new Elysia({ prefix: "/api/v1/fintech" })

  // ── GET /contract-financials/:leaseId ─────────────────────────────────
  .get(
    "/contract-financials/:leaseId",
    async ({ params, set }) => {
      const data = await getContractFinancialsByLease(params.leaseId);
      if (!data) {
        set.status = 404;
        return { error: "ContractFinancials not found for this lease" };
      }
      return data;
    },
    {
      params: t.Object({ leaseId: t.String() }),
      detail: {
        summary: "Get ContractFinancials for a lease",
        tags: ["FinTech v2"],
      },
    }
  )

  // ── POST /contract-financials ──────────────────────────────────────────
  .post(
    "/contract-financials",
    async ({ body, set }) => {
      try {
        const { officeId, agentId, splitRates, ...input } = body;
        const result = await createContractFinancials(input, officeId, agentId, splitRates);
        set.status = 201;
        return result;
      } catch (error: any) {
        set.status = 400;
        return { error: error.message };
      }
    },
    {
      body: t.Object({
        leaseId: t.String(),
        officeId: t.String(),
        agentId: t.String(),
        rentAmount: t.Number(),
        currency: t.Optional(t.String()),
        depositStrategy: t.Optional(
          t.Union([
            t.Literal("INSURANCE_BACKED"),
            t.Literal("FLEXIBLE_INSTALLMENT"),
            t.Literal("TRADITIONAL_CASH"),
          ])
        ),
        depositTotal: t.Optional(t.Number()),
        depositInstallments: t.Optional(t.Number()),
        commissionRateBps: t.Optional(t.Number()),
        commissionTotal: t.Optional(t.Number()),
        commissionInstallments: t.Optional(t.Number()),
        rentPaymentRail: t.Optional(t.String()),
        depositPaymentRail: t.Optional(t.String()),
        earlyCaptureDayOfMonth: t.Optional(t.Number()),
        captureBufferDays: t.Optional(t.Number()),
        hasRentalInsurance: t.Optional(t.Boolean()),
        insuranceProvider: t.Optional(t.String()),
        insurancePolicyNo: t.Optional(t.String()),
        insuranceCoverageLimit: t.Optional(t.Number()),
        gatewayProvider: t.Optional(t.String()),
        splitRates: t.Optional(
          t.Object({
            officeRate: t.Optional(t.Number()),
            agentRate: t.Optional(t.Number()),
            platformRate: t.Optional(t.Number()),
          })
        ),
      }),
      detail: {
        summary: "Create ContractFinancials with split payout and capture cycles",
        tags: ["FinTech v2"],
      },
    }
  )

  // ── GET /split-preview ─────────────────────────────────────────────────
  // Utility: preview a split calculation without saving
  .get(
    "/split-preview",
    async ({ query }) => {
      const grossAmount = parseFloat(query.grossAmount as string);
      if (isNaN(grossAmount) || grossAmount <= 0) {
        return { error: "Invalid grossAmount" };
      }
      return calculateTriPartySplit(grossAmount, {
        officeRate: query.officeRate ? parseFloat(query.officeRate as string) : 0.35,
        agentRate: query.agentRate ? parseFloat(query.agentRate as string) : 0.35,
        platformRate: query.platformRate ? parseFloat(query.platformRate as string) : 0.30,
      });
    },
    {
      detail: {
        summary: "Preview tri-party split without saving",
        tags: ["FinTech v2"],
      },
    }
  )

  // ── GET /capture-schedule-preview ─────────────────────────────────────
  // Utility: preview all capture dates for a move-in date
  .get(
    "/capture-schedule-preview",
    async ({ query }) => {
      const moveInDate = new Date(query.moveInDate as string);
      const cycles = parseInt(query.cycles as string) || 6;
      const captureDay = parseInt(query.captureDay as string) || 20;

      if (isNaN(moveInDate.getTime())) {
        return { error: "Invalid moveInDate. Use ISO format: YYYY-MM-DD" };
      }

      const schedule = [];
      for (let i = 0; i < cycles; i++) {
        const { captureDate, dueDate, statementDate } = calculateCaptureDates(
          moveInDate,
          i,
          captureDay
        );
        schedule.push({
          cycle: i + 1,
          captureDate: captureDate.toISOString().split("T")[0],
          dueDate: dueDate.toISOString().split("T")[0],
          statementDate: statementDate.toISOString().split("T")[0],
          bufferDays: Math.ceil(
            (dueDate.getTime() - captureDate.getTime()) / (1000 * 60 * 60 * 24)
          ),
        });
      }
      return { moveInDate: query.moveInDate, captureDay, schedule };
    },
    {
      detail: {
        summary: "Preview early capture schedule for a move-in date",
        tags: ["FinTech v2"],
      },
    }
  )

  // ── GET /split-payout/:contractFinancialsId ────────────────────────────
  .get(
    "/split-payout/:contractFinancialsId",
    async ({ params, set }) => {
      const data = await db.splitPayoutSchedule.findUnique({
        where: { contractFinancialsId: params.contractFinancialsId },
      });
      if (!data) {
        set.status = 404;
        return { error: "SplitPayoutSchedule not found" };
      }
      return data;
    },
    {
      params: t.Object({ contractFinancialsId: t.String() }),
      detail: {
        summary: "Get tri-party split payout schedule",
        tags: ["FinTech v2"],
      },
    }
  )

  // ── POST /split-payout/:id/disburse ───────────────────────────────────
  .post(
    "/split-payout/:id/disburse",
    async ({ params, set }) => {
      try {
        await processDisbursement(params.id);
        return { success: true, message: "Disbursement processed successfully" };
      } catch (error: any) {
        set.status = 400;
        return { error: error.message };
      }
    },
    {
      params: t.Object({ id: t.String() }),
      detail: {
        summary: "Disburse split payout to all 3 parties",
        tags: ["FinTech v2"],
      },
    }
  )

  // ── GET /capture-cycles ────────────────────────────────────────────────
  .get(
    "/capture-cycles/today",
    async () => {
      const cycles = await getTodayCaptureCycles();
      return { count: cycles.length, cycles };
    },
    {
      detail: {
        summary: "Get all capture cycles scheduled for today",
        tags: ["FinTech v2"],
      },
    }
  )

  // ── GET /capture-cycles/:contractFinancialsId ──────────────────────────
  .get(
    "/capture-cycles/:contractFinancialsId",
    async ({ params }) => {
      const cycles = await db.earlyCaptureCycle.findMany({
        where: { contractFinancialsId: params.contractFinancialsId },
        orderBy: { cycleNumber: "asc" },
      });
      return cycles;
    },
    {
      params: t.Object({ contractFinancialsId: t.String() }),
      detail: {
        summary: "Get all early capture cycles for a contract",
        tags: ["FinTech v2"],
      },
    }
  )

  // ── POST /capture-cycles/:cycleId/retry ───────────────────────────────
  .post(
    "/capture-cycles/:cycleId/retry",
    async ({ params, set }) => {
      const cycle = await db.earlyCaptureCycle.findUnique({
        where: { id: params.cycleId },
      });
      if (!cycle) {
        set.status = 404;
        return { error: "Cycle not found" };
      }
      if (cycle.retryCount >= cycle.maxRetries) {
        set.status = 400;
        return { error: "Max retries exceeded" };
      }
      // Reset to PENDING_CAPTURE for re-attempt
      await db.earlyCaptureCycle.update({
        where: { id: params.cycleId },
        data: { status: "PENDING_CAPTURE", captureAttemptDate: new Date() },
      });
      return { success: true, message: "Cycle queued for retry" };
    },
    {
      params: t.Object({ cycleId: t.String() }),
      detail: {
        summary: "Retry a failed capture cycle",
        tags: ["FinTech v2"],
      },
    }
  );
