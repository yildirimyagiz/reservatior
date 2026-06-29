import { PrismaClient, EscrowStatus } from '@prisma/client';
import { EscrowEngine } from './escrow-engine';

const prisma = new PrismaClient();

export class AdvancedEscrowRouter {
  /**
   * Intelligently routes funds upon a trigger event.
   * "Better than Airbnb" - supports dynamic split based on EscrowSplitConfig and active disputes.
   */
  static async routeFundsOnTrigger(escrowId: string, eventType: "RESERVATION_CONFIRMED" | "CHECK_IN_COMPLETED" | "CLEANING_VERIFIED" | "CHECK_OUT_COMPLETED") {
    const escrow = await prisma.escrowAccount.findUnique({
      where: { id: escrowId },
      include: {
        reservation: {
          include: { property: true }
        },
        disputes: {
          where: { status: { notIn: ["RESOLVED", "CLOSED"] } }
        }
      }
    });

    if (!escrow) throw new Error("Escrow not found");
    if (escrow.status === EscrowStatus.FULLY_RELEASED) return;

    // Load dynamic split config
    let config = await prisma.escrowSplitConfig.findUnique({
      where: { propertyId: escrow.reservation.propertyId }
    });

    // Fallback defaults if no config exists for property
    if (!config) {
      config = {
        reservatiorFeeRate: 4.00,
        agentPayoutRate: 3.00,
        blockageDays: 15,
      } as any;
    }

    const totalAmount = Number(escrow.totalAmount);
    const platformFeeAmount = totalAmount * (config!.reservatiorFeeRate / 100);
    const hostTotalAmount = totalAmount - platformFeeAmount;

    switch (eventType) {
      case "RESERVATION_CONFIRMED":
        // Platform takes its fee immediately upon confirmation
        await EscrowEngine.releaseFunds(escrowId, platformFeeAmount, "PLATFORM_FEE_COLLECTION");
        break;

      case "CHECK_IN_COMPLETED":
        // Evaluate disputes before releasing to host
        if (escrow.disputes.length > 0) {
          // Pause payout! Smart contract logic holds the fund.
          console.log(`[Escrow Router] Hold applied for ${escrowId} due to active disputes.`);
          return { status: "HELD_DUE_TO_DISPUTE" };
        }

        // Release 50% of host's cut to host
        const firstHostPayout = hostTotalAmount * 0.50;
        await EscrowEngine.releaseFunds(escrowId, firstHostPayout, "HOST_CHECK_IN_ADVANCE");
        break;

      case "CHECK_OUT_COMPLETED":
        if (escrow.disputes.length > 0) {
          console.log(`[Escrow Router] Hold applied for ${escrowId} due to active disputes.`);
          return { status: "HELD_DUE_TO_DISPUTE" };
        }

        // Release remaining host funds
        // Get how much has already been released
        const releasedSoFar = await prisma.escrowRelease.aggregate({
          where: { escrowId },
          _sum: { amount: true }
        });
        const remainingToRelease = totalAmount - Number(releasedSoFar._sum?.amount || 0);
        
        if (remainingToRelease > 0) {
          await EscrowEngine.releaseFunds(escrowId, remainingToRelease, "HOST_FINAL_PAYOUT");
        }
        break;

      case "CLEANING_VERIFIED":
        // Example of multi-party routing:
        // Cleaners get paid instantly, bypassing the host completely
        // Assumes a fixed $150 cleaning fee mapped in the ledger.
        // await EscrowEngine.releaseFunds(escrowId, 150, "CLEANING_VENDOR_PAYOUT");
        break;
    }

    return { status: "SUCCESS" };
  }
}
