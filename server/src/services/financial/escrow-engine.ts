import { PrismaClient, EscrowStatus } from '@prisma/client';

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

    return {
      totalEscrowValue: activeHoldingValue,
      pendingPayouts: Number(pendingPayouts._sum?.depositAmount || 0),
      activeContracts: activeContracts
    };
  }
}
