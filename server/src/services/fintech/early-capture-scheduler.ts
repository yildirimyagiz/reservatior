/**
 * Reservatior FinTech v2 — Early Capture Scheduler
 *
 * Cron-based engine that runs daily at 08:00 and processes
 * all EarlyCaptureCycle records scheduled for today.
 *
 * Flow:
 * 1. Query all cycles with captureAttemptDate = today
 * 2. For each cycle: attempt gateway capture
 * 3. On success → markCycleCaptured, update SplitPayoutSchedule to IN_FLOAT
 * 4. On failure → markCycleFailed, raise riskFlag, trigger alert
 */

import {
  getTodayCaptureCycles,
  markCycleCaptured,
  markCycleFailed,
} from "./hybrid-settlement";
import { db } from "../../lib/db";

// ── Main Scheduler Function ────────────────────────────────────────────────

export async function runEarlyCaptureScheduler(): Promise<void> {
  const cycles = await getTodayCaptureCycles();

  if (cycles.length === 0) {
    console.log("[EarlyCapture] No cycles scheduled for today.");
    return;
  }

  console.log(`[EarlyCapture] Processing ${cycles.length} cycle(s) for today.`);

  const results = await Promise.allSettled(
    cycles.map((cycle) => processSingleCycle(cycle.id, cycle))
  );

  const succeeded = results.filter((r) => r.status === "fulfilled").length;
  const failed = results.filter((r) => r.status === "rejected").length;

  console.log(`[EarlyCapture] Done. Succeeded: ${succeeded}, Failed: ${failed}`);
}

// ── Single Cycle Processor ─────────────────────────────────────────────────

async function processSingleCycle(
  cycleId: string,
  cycle: Awaited<ReturnType<typeof getTodayCaptureCycles>>[number]
): Promise<void> {
  const { contractFinancials, totalAmount, paymentRail, rentAmount, installmentAmount } = cycle;
  const { splitPayout, lease } = contractFinancials;

  console.log(
    `[EarlyCapture] Cycle ${cycleId}: Lease ${lease.id}, Amount ${totalAmount} ${contractFinancials.currency}, Rail: ${paymentRail}`
  );

  try {
    // ── Gateway Capture (stub — replace with real PayTR/Stripe call) ──
    const gatewayRef = await simulateGatewayCapture({
      amount: Number(totalAmount),
      currency: contractFinancials.currency,
      rail: paymentRail,
      leaseId: lease.id,
      cycleId,
    });

    // Mark cycle as captured
    await markCycleCaptured(cycleId, gatewayRef);

    // Update SplitPayoutSchedule to IN_FLOAT
    if (splitPayout) {
      await db.splitPayoutSchedule.update({
        where: { id: splitPayout.id },
        data: { status: "IN_FLOAT", floatStartDate: new Date() },
      });
    }

    // Log to PaymentRoutingLog
    await db.paymentRoutingLog.create({
      data: {
        amount: totalAmount,
        currency: contractFinancials.currency,
        selectedProvider: contractFinancials.gatewayProvider ?? "PAYTR",
        routingReason: "EARLY_CAPTURE_CYCLE",
        isSuccess: true,
        latencyMs: 0,
      },
    });

    console.log(`[EarlyCapture] ✅ Cycle ${cycleId} captured. Ref: ${gatewayRef}`);
  } catch (error: any) {
    const reason = error?.message ?? "Unknown gateway error";
    console.error(`[EarlyCapture] ❌ Cycle ${cycleId} failed: ${reason}`);

    await markCycleFailed(cycleId, reason);

    // Log failure
    await db.paymentRoutingLog.create({
      data: {
        amount: totalAmount,
        currency: contractFinancials.currency,
        selectedProvider: contractFinancials.gatewayProvider ?? "PAYTR",
        routingReason: "EARLY_CAPTURE_FAILED",
        isSuccess: false,
      },
    });

    throw error; // Re-throw so Promise.allSettled tracks it
  }
}

// ── Disbursement Processor ─────────────────────────────────────────────────

/**
 * Runs on valorEndDate to disburse funds to all 3 parties.
 * Called by a separate cron or webhook from gateway.
 */
export async function processDisbursement(splitPayoutId: string): Promise<void> {
  const split = await db.splitPayoutSchedule.findUniqueOrThrow({
    where: { id: splitPayoutId },
    include: { contractFinancials: { include: { lease: true } } },
  });

  if (split.isDisbursed) {
    console.log(`[Disbursement] ${splitPayoutId} already disbursed.`);
    return;
  }

  if (split.status !== "IN_FLOAT") {
    console.warn(`[Disbursement] ${splitPayoutId} not in float state: ${split.status}`);
    return;
  }

  console.log(`[Disbursement] Processing split ${splitPayoutId}`);
  console.log(`  Office  (${(split.officeShareRate * 100).toFixed(0)}%): ${split.officeShareAmount} → ${split.officeId}`);
  console.log(`  Agent   (${(split.agentShareRate * 100).toFixed(0)}%): ${split.agentShareAmount} → ${split.agentId}`);
  console.log(`  Platform(${(split.platformShareRate * 100).toFixed(0)}%): ${split.platformShareAmount}`);

  // TODO: Integrate real gateway payout API (PayTR sub-merchant / Stripe Connect)
  // await payTRService.sendPayout(split.officeIban, split.officeShareAmount);
  // await payTRService.sendPayout(split.agentWalletId, split.agentShareAmount);

  await db.splitPayoutSchedule.update({
    where: { id: splitPayoutId },
    data: {
      status: "DISBURSED",
      isDisbursed: true,
      disbursedAt: new Date(),
      officeDisbursedAt: new Date(),
      agentDisbursedAt: new Date(),
      platformDisbursedAt: new Date(),
    },
  });

  console.log(`[Disbursement] ✅ ${splitPayoutId} disbursed to all 3 parties.`);
}

// ── Gateway Stub ───────────────────────────────────────────────────────────

/**
 * Simulates a gateway capture call.
 * Replace with real PayTR / Stripe API integration.
 */
async function simulateGatewayCapture(params: {
  amount: number;
  currency: string;
  rail: string;
  leaseId: string;
  cycleId: string;
}): Promise<string> {
  // Simulate network latency
  await new Promise((r) => setTimeout(r, 50));

  // Return a mock reference ID
  return `REF-${params.cycleId.slice(0, 8).toUpperCase()}-${Date.now()}`;
}
