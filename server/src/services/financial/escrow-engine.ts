import { PrismaClient, EscrowStatus } from '@prisma/client';
import { eventBus } from "../../core/events/event-bus";
import { DomainEvents } from "../../core/events/domain-events";

const prisma = new PrismaClient();

export class EscrowEngine {
  /**
   * Creates a new Escrow Account and sets the state to HOLDING
   */
  static async createEscrow(data: {
    orgId: string;
    reservationId: string;
    totalAmount: number;
    depositAmount: number;
    currency?: string;
  }) {
    // Validate if already exists
    const existing = await prisma.escrowAccount.findUnique({
      where: { reservationId: data.reservationId }
    });

    if (existing) {
      throw new Error(`Escrow already exists for reservation ${data.reservationId}`);
    }

    const escrow = await prisma.escrowAccount.create({
      data: {
        orgId: data.orgId,
        reservationId: data.reservationId,
        totalAmount: data.totalAmount,
        depositAmount: data.depositAmount,
        currency: data.currency || 'USD',
        status: EscrowStatus.HOLDING,
      }
    });

    await eventBus.publish({
      type: DomainEvents.ESCROW_CREATED,
      payload: { id: escrow.id, amount: escrow.totalAmount, orgId: escrow.orgId },
      source: "FinanceOS",
    });

    return escrow;
  }

  /**
   * Releases funds from Escrow (State Machine Transition)
   * Prevents releasing if it's DISPUTED or CANCELLED
   */
  static async releaseFunds(escrowId: string, amountToRelease: number, reason: string) {
    return await prisma.$transaction(async (tx) => {
      const escrow = await tx.escrowAccount.findUnique({
        where: { id: escrowId }
      });

      if (!escrow) throw new Error("Escrow account not found");
      
      if (escrow.status === EscrowStatus.DISPUTED || escrow.status === EscrowStatus.CANCELLED) {
        throw new Error(`Cannot release funds from ${escrow.status} state.`);
      }

      if (escrow.status === EscrowStatus.FULLY_RELEASED) {
        throw new Error("Funds already fully released.");
      }

      const totalReleasedSoFar = await tx.escrowRelease.aggregate({
        where: { escrowId: escrowId },
        _sum: { amount: true }
      });

      const releasedAmount = Number(totalReleasedSoFar._sum?.amount || 0);
      const newTotalReleased = releasedAmount + amountToRelease;
      
      const totalEscrowAmount = Number(escrow.totalAmount);

      if (newTotalReleased > totalEscrowAmount) {
        throw new Error("Release amount exceeds total held in escrow.");
      }

      // Create release record
      const release = await tx.escrowRelease.create({
        data: {
          orgId: escrow.orgId,
          escrowId: escrowId,
          amount: amountToRelease,
          triggerEvent: "MANUAL_RELEASE",
          releasePercent: (amountToRelease / totalEscrowAmount) * 100,
          status: "PENDING" as any, 
          notes: reason
        }
      });

      // Determine new state
      const newStatus = newTotalReleased >= totalEscrowAmount 
        ? EscrowStatus.FULLY_RELEASED 
        : EscrowStatus.PARTIALLY_RELEASED;

      // Update escrow state
      const updatedEscrow = await tx.escrowAccount.update({
        where: { id: escrowId },
        data: {
          status: newStatus,
          releasedAt: newStatus === EscrowStatus.FULLY_RELEASED ? new Date() : null
        }
      });

      await eventBus.publish({
        type: DomainEvents.ESCROW_RELEASED,
        payload: { id: escrowId, amount: amountToRelease },
        source: "FinanceOS",
      });

      return { updatedEscrow, release };
    });
  }

  /**
   * Fetch live dashboard stats for Finance OS
   */
  static async getDashboardStats(orgId: string) {
    // 1. Total Escrow Value (Currently Holding)
    const holdingEscrows = await prisma.escrowAccount.aggregate({
      where: { 
        orgId, 
        status: { in: [EscrowStatus.HOLDING, EscrowStatus.PARTIALLY_RELEASED] } 
      },
      _sum: { totalAmount: true }
    });

    const totalReleased = await prisma.escrowRelease.aggregate({
      where: { escrow: { orgId, status: { in: [EscrowStatus.HOLDING, EscrowStatus.PARTIALLY_RELEASED] } } },
      _sum: { amount: true }
    });

    const activeHoldingValue = Number(holdingEscrows._sum?.totalAmount || 0) - Number(totalReleased._sum?.amount || 0);

    // 2. Pending Payouts (Ready for settlement - conceptual for now, could be HOLDING that met a date condition)
    // We'll simulate by pulling partially released or ready status if we had one. 
    // Let's just say pending payouts are total deposit amounts waiting to be distributed.
    const pendingPayouts = await prisma.escrowAccount.aggregate({
      where: { orgId, status: EscrowStatus.HOLDING },
      _sum: { depositAmount: true }
    });

    // 3. Active Contracts
    const activeContracts = await prisma.escrowAccount.count({
      where: { 
        orgId, 
        status: { in: [EscrowStatus.HOLDING, EscrowStatus.PARTIALLY_RELEASED] } 
      }
    });

    // 4. Recent Transactions (Releases)
    const recentTransactions = await prisma.escrowRelease.findMany({
      where: { escrow: { orgId } },
      orderBy: { createdAt: 'desc' },
      take: 5,
      include: {
        escrow: true
      }
    });

    // 5. Chart Data (Last 7 days of releases)
    const sevenDaysAgo = new Date();
    sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);
    
    const recentReleases = await prisma.escrowRelease.findMany({
      where: { 
        escrow: { orgId },
        createdAt: { gte: sevenDaysAgo }
      },
      orderBy: { createdAt: 'asc' }
    });
    
    // Group by day for chart
    const chartDataMap = new Map();
    for (let i = 6; i >= 0; i--) {
      const d = new Date();
      d.setDate(d.getDate() - i);
      const dateStr = d.toISOString().split('T')[0];
      chartDataMap.set(dateStr, { name: dateStr, amount: 0 });
    }
    
    recentReleases.forEach(r => {
      const dateStr = r.createdAt.toISOString().split('T')[0];
      if (chartDataMap.has(dateStr)) {
        const current = chartDataMap.get(dateStr);
        current.amount += Number(r.amount);
        chartDataMap.set(dateStr, current);
      }
    });

    return {
      totalEscrowValue: activeHoldingValue,
      pendingPayouts: Number(pendingPayouts._sum?.depositAmount || 0),
      activeContracts: activeContracts,
      recentTransactions: recentTransactions.map(t => ({
        id: t.id,
        amount: Number(t.amount),
        status: t.status,
        date: t.createdAt,
        contractId: t.escrow.reservationId
      })),
      chartData: Array.from(chartDataMap.values())
    };
  }
}
