import { createHash } from "crypto";
import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

interface AuditLogParams {
  orgId?: string;
  action: string;
  entityType: string;
  entityId: string;
  userId?: string;
  actorType?: string;
  amount?: number;
  currency?: string;
  oldAmount?: number;
  newAmount?: number;
  oldStatus?: string;
  newStatus?: string;
  oldValues?: any;
  newValues?: any;
  reservationId?: string;
  leaseId?: string;
  escrowId?: string;
  paymentId?: string;
  ipAddress?: string;
  idempotencyKey?: string;
}

export class FinancialAuditLogService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.financialAuditLog, "financialAuditLog");
  }

  private computeChecksum(payload: string, previousHash: string | null): string {
    const data = `${previousHash || "GENESIS"}:${payload}`;
    return createHash("sha256").update(data).digest("hex");
  }

  async log(params: AuditLogParams) {
    if (params.idempotencyKey) {
      const existing = await this.model.findFirst({
        where: { idempotencyKey: params.idempotencyKey },
      });
      if (existing) return existing;
    }

    const lastEntry = await this.model.findFirst({
      where: { orgId: params.orgId || undefined },
      orderBy: { createdAt: "desc" },
      select: { checksum: true },
    });

    const payloadObj = {
      orgId: params.orgId,
      action: params.action,
      entityType: params.entityType,
      entityId: params.entityId,
      userId: params.userId,
      actorType: params.actorType || "USER",
      amount: params.amount,
      currency: params.currency,
      oldAmount: params.oldAmount,
      newAmount: params.newAmount,
      oldStatus: params.oldStatus,
      newStatus: params.newStatus,
      oldValues: params.oldValues,
      newValues: params.newValues,
      reservationId: params.reservationId,
      leaseId: params.leaseId,
      escrowId: params.escrowId,
      paymentId: params.paymentId,
      ipAddress: params.ipAddress,
      idempotencyKey: params.idempotencyKey,
    };

    const payloadJson = JSON.stringify(payloadObj);
    const checksum = this.computeChecksum(payloadJson, lastEntry?.checksum || null);

    return this.model.create({
      data: {
        orgId: params.orgId,
        action: params.action as any,
        entityType: params.entityType,
        entityId: params.entityId,
        userId: params.userId,
        actorType: params.actorType || "USER",
        amount: params.amount,
        currency: params.currency,
        oldAmount: params.oldAmount,
        newAmount: params.newAmount,
        oldStatus: params.oldStatus,
        newStatus: params.newStatus,
        oldValues: params.oldValues,
        newValues: params.newValues,
        reservationId: params.reservationId,
        leaseId: params.leaseId,
        escrowId: params.escrowId,
        paymentId: params.paymentId,
        ipAddress: params.ipAddress,
        idempotencyKey: params.idempotencyKey,
        checksum,
        previousHash: lastEntry?.checksum || null,
      },
    });
  }

  async getEntityAuditTrail(entityType: string, entityId: string) {
    return this.model.findMany({
      where: { entityType, entityId },
      orderBy: { createdAt: "asc" },
    });
  }

  async getOrgAuditTrail(
    orgId: string,
    filters: {
      action?: string;
      entityType?: string;
      from?: string;
      to?: string;
      page?: number;
      limit?: number;
    }
  ) {
    const { action, entityType, from, to, page = 1, limit = 20 } = filters;

    const where: any = { orgId };
    if (action) where.action = action;
    if (entityType) where.entityType = entityType;
    if (from || to) {
      where.createdAt = {};
      if (from) where.createdAt.gte = new Date(from);
      if (to) where.createdAt.lte = new Date(to);
    }

    return this.getAll({
      where,
      skip: (page - 1) * limit,
      take: limit,
      orderBy: { createdAt: "desc" },
    });
  }

  async getFinancialSummary(orgId: string, dateRange?: { from?: string; to?: string }) {
    const where: any = { orgId };
    if (dateRange?.from || dateRange?.to) {
      where.createdAt = {};
      if (dateRange.from) where.createdAt.gte = new Date(dateRange.from);
      if (dateRange.to) where.createdAt.lte = new Date(dateRange.to);
    }

    const logs = await this.model.findMany({ where, orderBy: { createdAt: "asc" } });

    const actionCounts: Record<string, number> = {};
    const statusAmounts: Record<string, number> = {};

    for (const log of logs) {
      actionCounts[log.action] = (actionCounts[log.action] || 0) + 1;
      if (log.newStatus && log.amount) {
        statusAmounts[log.newStatus] = (statusAmounts[log.newStatus] || 0) + Number(log.amount);
      }
    }

    return { totalEntries: logs.length, actionCounts, statusAmounts };
  }

  async verifyIntegrity(orgId: string, from?: string, to?: string) {
    const where: any = { orgId };
    if (from || to) {
      where.createdAt = {};
      if (from) where.createdAt.gte = new Date(from);
      if (to) where.createdAt.lte = new Date(to);
    }

    const logs = await this.model.findMany({ where, orderBy: { createdAt: "asc" } });

    let chainBroken = false;
    let brokenAt: string | null = null;

    for (let i = 1; i < logs.length; i++) {
      if (logs[i].previousHash !== logs[i - 1].checksum) {
        chainBroken = true;
        brokenAt = logs[i].id;
        break;
      }
    }

    return {
      verified: !chainBroken,
      totalEntries: logs.length,
      brokenAt,
    };
  }
}

export const financialAuditLogService = new FinancialAuditLogService();
