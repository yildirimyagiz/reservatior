import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

function addMonths(date: Date, months: number): Date {
  const d = new Date(date);
  d.setMonth(d.getMonth() + months);
  return d;
}

function startOfDay(date: Date): Date {
  const d = new Date(date);
  d.setHours(0, 0, 0, 0);
  return d;
}

function isAfter(a: Date, b: Date): boolean {
  return startOfDay(a).getTime() > startOfDay(b).getTime();
}

export class KumbaraDepositService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.kumbaraDeposit, "kumbaraDeposit");
  }

  async createDeposit(data: {
    orgId: string;
    leaseId: string;
    propertyId: string;
    tenantId: string;
    totalTarget: number;
    ruleType?: string;
    contributionRate?: number;
    fixedAmount?: number;
    contributionDay?: number;
    currency?: string;
    ownerProtectionEnabled?: boolean;
    maxMissedPayments?: number;
    autoDefaultOnMiss?: boolean;
    escrowAccountId?: string;
    metadata?: any;
  }) {
    const contributionDay = data.contributionDay ?? 1;
    const now = new Date();
    const nextDueDate = new Date(now.getFullYear(), now.getMonth(), contributionDay);
    if (nextDueDate <= now) {
      nextDueDate.setMonth(nextDueDate.getMonth() + 1);
    }

    const deposit = await prisma.kumbaraDeposit.create({
      data: {
        orgId: data.orgId,
        leaseId: data.leaseId,
        propertyId: data.propertyId,
        tenantId: data.tenantId,
        totalTarget: data.totalTarget,
        remainingBalance: data.totalTarget,
        ruleType: (data.ruleType as any) ?? "PERCENTAGE_OF_RENT",
        contributionRate: data.contributionRate ?? 0.035,
        fixedAmount: data.fixedAmount,
        contributionDay,
        currency: data.currency ?? "USD",
        ownerProtectionEnabled: data.ownerProtectionEnabled ?? true,
        maxMissedPayments: data.maxMissedPayments ?? 3,
        autoDefaultOnMiss: data.autoDefaultOnMiss ?? false,
        escrowAccountId: data.escrowAccountId,
        nextDueDate,
        metadata: data.metadata,
      },
      include: {
        contributions: true,
        rules: true,
      },
    });

    return deposit;
  }

  async recordContribution(
    depositId: string,
    amount: number,
    paymentMethod?: string,
    gatewayRef?: string,
  ) {
    const deposit = await prisma.kumbaraDeposit.findUnique({
      where: { id: depositId },
    });
    if (!deposit) {
      throw new Error("KumbaraDeposit not found");
    }
    if (deposit.status !== "ACTIVE") {
      throw new Error(`Cannot contribute to deposit with status ${deposit.status}`);
    }

    const newTotalContributed = Number(deposit.totalContributed) + amount;
    const newRemainingBalance = Number(deposit.totalTarget) - newTotalContributed;
    const isCompleted = newRemainingBalance <= 0;

    const contribution = await prisma.kumbaraContribution.create({
      data: {
        depositId,
        orgId: deposit.orgId,
        amount,
        currency: deposit.currency,
        status: "COMPLETED",
        dueDate: deposit.nextDueDate,
        paidAt: new Date(),
        paymentMethod,
        gatewayRef,
      },
    });

    const updateData: any = {
      totalContributed: newTotalContributed,
      remainingBalance: newRemainingBalance < 0 ? 0 : newRemainingBalance,
      currentMissedPayments: 0,
    };

    if (isCompleted) {
      updateData.status = "COMPLETED";
      updateData.completedAt = new Date();
    } else {
      const nextDueDate = addMonths(deposit.nextDueDate, 1);
      updateData.nextDueDate = nextDueDate;
    }

    await prisma.kumbaraDeposit.update({
      where: { id: depositId },
      data: updateData,
    });

    return { contribution, depositCompleted: isCompleted };
  }

  async checkMissedPayments(depositId: string) {
    const deposit = await prisma.kumbaraDeposit.findUnique({
      where: { id: depositId },
    });
    if (!deposit) {
      throw new Error("KumbaraDeposit not found");
    }
    if (deposit.status !== "ACTIVE") {
      return { missed: false, reason: `Deposit is ${deposit.status}` };
    }

    const today = startOfDay(new Date());
    const dueDate = startOfDay(deposit.nextDueDate);
    const isPastDue = isAfter(today, dueDate);

    if (!isPastDue) {
      return { missed: false, reason: "Next due date has not passed yet" };
    }

    const hasContribution = await prisma.kumbaraContribution.findFirst({
      where: {
        depositId,
        paidAt: { gte: deposit.nextDueDate },
      },
    });

    if (hasContribution) {
      return { missed: false, reason: "Contribution already recorded for this period" };
    }

    const newMissedCount = deposit.currentMissedPayments + 1;
    const updateData: any = {
      currentMissedPayments: newMissedCount,
    };

    const thresholdReached = newMissedCount >= deposit.maxMissedPayments;

    if (thresholdReached && deposit.autoDefaultOnMiss) {
      updateData.status = "DEFAULTED";
    }

    await prisma.kumbaraDeposit.update({
      where: { id: depositId },
      data: updateData,
    });

    return {
      missed: true,
      currentMissedPayments: newMissedCount,
      maxMissedPayments: deposit.maxMissedPayments,
      thresholdReached,
      autoDefaulted: thresholdReached && deposit.autoDefaultOnMiss,
    };
  }

  async getDepositSummary(depositId: string) {
    const deposit = await prisma.kumbaraDeposit.findUnique({
      where: { id: depositId },
      include: {
        contributions: {
          orderBy: { createdAt: "desc" },
        },
        rules: true,
        escrowAccount: true,
      },
    });

    if (!deposit) return null;

    return {
      ...deposit,
      summary: {
        totalTarget: Number(deposit.totalTarget),
        totalContributed: Number(deposit.totalContributed),
        remainingBalance: Number(deposit.remainingBalance),
        percentComplete: Number(deposit.totalTarget) > 0
          ? Math.round((Number(deposit.totalContributed) / Number(deposit.totalTarget)) * 100)
          : 0,
        isCompleted: deposit.status === "COMPLETED",
        isDefaulted: deposit.status === "DEFAULTED",
        isActive: deposit.status === "ACTIVE",
        missedPaymentRatio: `${deposit.currentMissedPayments}/${deposit.maxMissedPayments}`,
      },
    };
  }

  async getOrgDeposits(
    orgId: string,
    filters?: {
      status?: string;
      leaseId?: string;
      propertyId?: string;
      tenantId?: string;
      page?: number;
      limit?: number;
    },
  ) {
    const page = filters?.page ?? 1;
    const limit = filters?.limit ?? 20;
    const where: any = { orgId };

    if (filters?.status) where.status = filters.status;
    if (filters?.leaseId) where.leaseId = filters.leaseId;
    if (filters?.propertyId) where.propertyId = filters.propertyId;
    if (filters?.tenantId) where.tenantId = filters.tenantId;

    const [data, total] = await Promise.all([
      prisma.kumbaraDeposit.findMany({
        where,
        skip: (page - 1) * limit,
        take: limit,
        orderBy: { createdAt: "desc" },
        include: {
          contributions: {
            orderBy: { createdAt: "desc" },
            take: 5,
          },
          property: {
            select: { id: true, name: true },
          },
          tenant: {
            select: { id: true, firstName: true, lastName: true },
          },
        },
      }),
      prisma.kumbaraDeposit.count({ where }),
    ]);

    return { data, total, page, limit };
  }
}

export const kumbaraDepositService = new KumbaraDepositService();
