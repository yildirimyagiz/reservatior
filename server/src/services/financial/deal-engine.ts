import { PrismaClient, DealStatusUSA } from '@prisma/client';
import { EscrowEngine } from './escrow-engine';

const prisma = new PrismaClient();

export class DealEngine {
  /**
   * Initializes a new Deal in LEAD status
   */
  static async createDeal(data: {
    orgId: string;
    clientId: string;
    propertyId?: string;
    offerPrice?: number;
    agentId?: string;
  }) {
    return await prisma.deal.create({
      data: {
        orgId: data.orgId,
        clientId: data.clientId,
        propertyId: data.propertyId,
        offerPrice: data.offerPrice,
        agentId: data.agentId,
        dealStatus: DealStatusUSA.LEAD,
      }
    });
  }

  /**
   * Accepts an offer, moves to UNDER_CONTRACT, and automatically creates Escrow
   */
  static async acceptOffer(dealId: string, acceptedPrice: number, earnestMoney: number, reservationIdForEscrow: string) {
    return await prisma.$transaction(async (tx) => {
      const deal = await tx.deal.findUnique({ where: { id: dealId } });
      if (!deal) throw new Error("Deal not found");

      if (deal.dealStatus !== DealStatusUSA.LEAD && deal.dealStatus !== DealStatusUSA.PROSPECT && deal.dealStatus !== DealStatusUSA.QUALIFIED) {
        throw new Error(`Cannot accept offer from status ${deal.dealStatus}`);
      }

      // Update Deal Status
      const updatedDeal = await tx.deal.update({
        where: { id: dealId },
        data: {
          dealStatus: DealStatusUSA.UNDER_CONTRACT,
          salePrice: acceptedPrice,
          earnestMoney: earnestMoney,
          escrowAmount: earnestMoney,
        }
      });

      // Automatically Create Escrow for the earnest money
      // Passing it to our EscrowEngine ensures consistency
      const escrow = await EscrowEngine.createEscrow({
        orgId: deal.orgId,
        reservationId: reservationIdForEscrow, // Linking the deal to a reservation representation
        totalAmount: earnestMoney,
        depositAmount: earnestMoney, // Full amount of earnest money is the deposit
      });

      return { deal: updatedDeal, escrow };
    });
  }

  /**
   * Closes a deal, moving funds from Escrow and generating ledgers
   */
  static async closeDeal(dealId: string, escrowId: string) {
    return await prisma.$transaction(async (tx) => {
      const deal = await tx.deal.findUnique({ where: { id: dealId } });
      if (!deal) throw new Error("Deal not found");

      if (deal.dealStatus !== DealStatusUSA.PENDING_CLOSING && deal.dealStatus !== DealStatusUSA.UNDER_CONTRACT) {
        throw new Error(`Cannot close deal from status ${deal.dealStatus}`);
      }

      // We instruct the Escrow Engine to fully release funds.
      // The total escrow amount will be requested.
      const escrowAccount = await tx.escrowAccount.findUnique({ where: { id: escrowId } });
      if (!escrowAccount) throw new Error("Linked escrow not found");

      // Attempt to release the entire holding
      const releaseResult = await EscrowEngine.releaseFunds(escrowId, Number(escrowAccount.totalAmount), "DEAL_CLOSED");

      // Update Deal Status to CLOSED
      const updatedDeal = await tx.deal.update({
        where: { id: dealId },
        data: {
          dealStatus: DealStatusUSA.CLOSED,
          closingDate: new Date(),
        }
      });

      return { deal: updatedDeal, release: releaseResult };
    });
  }
}
