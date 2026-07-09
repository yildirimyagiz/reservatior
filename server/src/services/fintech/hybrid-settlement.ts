/**
 * Reservatior FinTech v2 — Hybrid Settlement Service
 *
 * Handles:
 * - Tri-party split calculation (35% Office / 35% Agent / 30% Platform)
 * - Early Capture Cycle scheduling ("20th of the Month" engine)
 * - ContractFinancials CRUD
 */

import { db } from "../../lib/db";
import type { DepositStrategy, PaymentRail, Prisma } from "@prisma/client";

// ── Types ──────────────────────────────────────────────────────────────────

export interface CreateContractFinancialsInput {
  leaseId: string;
  rentAmount: number;
  currency?: string;
  depositStrategy?: DepositStrategy;
  depositTotal?: number;
  depositInstallments?: number;
  commissionRateBps?: number;
  commissionTotal?: number;
  commissionInstallments?: number;
  rentPaymentRail?: PaymentRail;
  depositPaymentRail?: PaymentRail;
  earlyCaptureDayOfMonth?: number;
  captureBufferDays?: number;
  hasRentalInsurance?: boolean;
  insuranceProvider?: string;
  insurancePolicyNo?: string;
  insuranceCoverageLimit?: number;
  gatewayProvider?: string;
}

export interface SplitRates {
  officeRate: number;  // default 0.35
  agentRate: number;   // default 0.35
  platformRate: number; // default 0.30
}

export interface TriPartySplit {
  officeAmount: number;
  agentAmount: number;
  platformAmount: number;
  totalCommission: number;
}

// ── Core Calculations ──────────────────────────────────────────────────────

/**
 * Calculates the tri-party commission split.
 * Ensures the three parts always sum to 100% with no rounding leakage.
 */
export function calculateTriPartySplit(
  grossAmount: number,
  rates: Partial<SplitRates> = {}
): TriPartySplit {
  const officeRate = rates.officeRate ?? 0.35;
  const agentRate = rates.agentRate ?? 0.35;
  const platformRate = rates.platformRate ?? 0.30;

  // Validate rates sum to 1.0
  const sum = officeRate + agentRate + platformRate;
  if (Math.abs(sum - 1.0) > 0.001) {
    throw new Error(`Split rates must sum to 1.0, got ${sum}`);
  }

  const officeAmount = Math.round(grossAmount * officeRate * 100) / 100;
  const agentAmount = Math.round(grossAmount * agentRate * 100) / 100;
  // Platform gets the remainder to absorb any rounding difference
  const platformAmount = Math.round((grossAmount - officeAmount - agentAmount) * 100) / 100;

  return {
    officeAmount,
    agentAmount,
    platformAmount,
    totalCommission: grossAmount,
  };
}

/**
 * Calculates the installment amount per billing cycle.
 * By default: 6 installments means each cycle = ~16.67% of total.
 * This isolates only ~16.5% of the card limit during move-in.
 */
export function calculateInstallmentAmount(
  totalAmount: number,
  installmentCount: number = 6
): number {
  return Math.ceil((totalAmount / installmentCount) * 100) / 100;
}

/**
 * Calculates the early capture date for a given month/year.
 * The "20th of the Month" engine fires 15 days before the lease due date,
 * pushing the charge into the *next* billing statement.
 */
export function calculateCaptureDates(
  moveInDate: Date,
  cycleIndex: number,   // 0-based: 0 = first month
  captureDayOfMonth: number = 20,
  captureBufferDays: number = 15
): { captureDate: Date; dueDate: Date; statementDate: Date } {
  // Move-in month + cycle index
  const baseDate = new Date(moveInDate);
  baseDate.setMonth(baseDate.getMonth() + cycleIndex);

  // Due date: same day of month as move-in, next month after capture
  const dueDate = new Date(baseDate);
  dueDate.setMonth(dueDate.getMonth() + 1);
  dueDate.setDate(moveInDate.getDate());

  // Capture date: 20th of the capture month (15 days before due)
  const captureDate = new Date(baseDate);
  captureDate.setDate(captureDayOfMonth);

  // Statement date: end of capture month (card billing cycle closes)
  const statementDate = new Date(captureDate);
  statementDate.setMonth(statementDate.getMonth() + 1);
  statementDate.setDate(0); // Last day of capture month

  return { captureDate, dueDate, statementDate };
}

// ── Database Operations ────────────────────────────────────────────────────

/**
 * Creates ContractFinancials + SplitPayoutSchedule + EarlyCaptureCycles
 * for a given lease in a single transaction.
 */
export async function createContractFinancials(
  input: CreateContractFinancialsInput,
  officeId: string,
  agentId: string,
  splitRates?: Partial<SplitRates>
) {
  const {
    leaseId,
    rentAmount,
    currency = "USD",
    depositStrategy = "FLEXIBLE_INSTALLMENT",
    depositTotal,
    depositInstallments = 6,
    commissionRateBps = 700,
    commissionTotal,
    commissionInstallments = 6,
    rentPaymentRail = "A2A_FAST",
    depositPaymentRail = "CARD_INSTALLMENT",
    earlyCaptureDayOfMonth = 20,
    captureBufferDays = 15,
    gatewayProvider,
    hasRentalInsurance = false,
    insuranceProvider,
    insurancePolicyNo,
    insuranceCoverageLimit,
  } = input;

  // Fetch lease for move-in date
  const lease = await db.lease.findUniqueOrThrow({ where: { id: leaseId } });
  const moveInDate = lease.startDate;

  // Calculate derived values
  const depositPerInstallment = depositTotal
    ? calculateInstallmentAmount(depositTotal, depositInstallments)
    : undefined;

  const resolvedCommissionTotal =
    commissionTotal ?? (rentAmount * commissionRateBps) / 10000;

  const commissionPerInstallment = calculateInstallmentAmount(
    resolvedCommissionTotal,
    commissionInstallments
  );

  // Tri-party split
  const split = calculateTriPartySplit(resolvedCommissionTotal, splitRates);

  return db.$transaction(async (tx) => {
    // 1. Create ContractFinancials
    const cf = await tx.contractFinancials.create({
      data: {
        leaseId,
        rentAmount,
        currency,
        depositStrategy,
        depositTotal,
        depositInstallments,
        depositPerInstallment,
        commissionRateBps,
        commissionTotal: resolvedCommissionTotal,
        commissionInstallments,
        rentPaymentRail,
        depositPaymentRail,
        earlyCaptureDayOfMonth,
        captureBufferDays,
        firstCaptureDate: calculateCaptureDates(moveInDate, 0, earlyCaptureDayOfMonth).captureDate,
        hasRentalInsurance,
        insuranceProvider,
        insurancePolicyNo,
        insuranceCoverageLimit,
        gatewayProvider,
      },
    });

    // 2. Create SplitPayoutSchedule
    const { captureDate: floatStart, dueDate: valorEnd } = calculateCaptureDates(
      moveInDate,
      0,
      earlyCaptureDayOfMonth
    );
    const valorEndDate = new Date(valorEnd);
    valorEndDate.setDate(valorEndDate.getDate() + 3); // +3 settlement days

    await tx.splitPayoutSchedule.create({
      data: {
        contractFinancialsId: cf.id,
        totalCommissionCollected: resolvedCommissionTotal,
        currency,
        officeId,
        officeShareRate: splitRates?.officeRate ?? 0.35,
        officeShareAmount: split.officeAmount,
        agentId,
        agentShareRate: splitRates?.agentRate ?? 0.35,
        agentShareAmount: split.agentAmount,
        platformShareRate: splitRates?.platformRate ?? 0.30,
        platformShareAmount: split.platformAmount,
        gatewayProvider,
        floatStartDate: floatStart,
        valorEndDate,
        floatDurationDays: Math.ceil(
          (valorEndDate.getTime() - floatStart.getTime()) / (1000 * 60 * 60 * 24)
        ),
      },
    });

    // 3. Generate EarlyCaptureCycles for all installment months
    const totalCycles = Math.max(depositInstallments, commissionInstallments);
    const cyclesData: Prisma.EarlyCaptureCycleCreateManyInput[] = [];

    for (let i = 0; i < totalCycles; i++) {
      const { captureDate, dueDate, statementDate } = calculateCaptureDates(
        moveInDate,
        i,
        earlyCaptureDayOfMonth,
        captureBufferDays
      );

      const isDepositCycle = i < depositInstallments;
      const installmentAmount = isDepositCycle
        ? (depositPerInstallment ?? commissionPerInstallment)
        : 0;

      cyclesData.push({
        contractFinancialsId: cf.id,
        cycleNumber: i + 1,
        cycleMonth: captureDate.getMonth() + 1,
        cycleYear: captureDate.getFullYear(),
        captureAttemptDate: captureDate,
        dueDate,
        statementDate,
        rentAmount,
        installmentAmount: installmentAmount > 0 ? installmentAmount : undefined,
        totalAmount: rentAmount + installmentAmount,
        paymentRail: i === 0 ? "A2A_FAST" : depositPaymentRail,
      });
    }

    await tx.earlyCaptureCycle.createMany({ data: cyclesData });

    return tx.contractFinancials.findUniqueOrThrow({
      where: { id: cf.id },
      include: { splitPayout: true, earlyCaptureCycles: { orderBy: { cycleNumber: "asc" } } },
    });
  });
}

/**
 * Retrieves ContractFinancials with full detail for a lease.
 */
export async function getContractFinancialsByLease(leaseId: string) {
  return db.contractFinancials.findUnique({
    where: { leaseId },
    include: {
      splitPayout: true,
      earlyCaptureCycles: { orderBy: { cycleNumber: "asc" } },
      lease: { select: { id: true, startDate: true, endDate: true, rent: true, currency: true } },
    },
  });
}

/**
 * Returns all cycles scheduled for today (for the cron job).
 */
export async function getTodayCaptureCycles() {
  const today = new Date();
  const startOfDay = new Date(today.getFullYear(), today.getMonth(), today.getDate());
  const endOfDay = new Date(startOfDay);
  endOfDay.setDate(endOfDay.getDate() + 1);

  return db.earlyCaptureCycle.findMany({
    where: {
      captureAttemptDate: { gte: startOfDay, lt: endOfDay },
      status: { in: ["PENDING_CAPTURE", "FAILED"] },
      retryCount: { lt: 3 },
    },
    include: {
      contractFinancials: {
        include: { splitPayout: true, lease: true },
      },
    },
  });
}

/**
 * Marks a capture cycle as captured (after gateway success).
 */
export async function markCycleCaptured(cycleId: string, gatewayReference: string) {
  return db.earlyCaptureCycle.update({
    where: { id: cycleId },
    data: {
      status: "CAPTURED",
      actualCaptureDate: new Date(),
      gatewayReference,
    },
  });
}

/**
 * Marks a capture cycle as failed and increments retry count.
 */
export async function markCycleFailed(cycleId: string, reason: string) {
  const cycle = await db.earlyCaptureCycle.findUniqueOrThrow({ where: { id: cycleId } });
  return db.earlyCaptureCycle.update({
    where: { id: cycleId },
    data: {
      status: cycle.retryCount + 1 >= cycle.maxRetries ? "FAILED" : "FAILED",
      failureReason: reason,
      retryCount: { increment: 1 },
      riskFlag: true,
    },
  });
}
