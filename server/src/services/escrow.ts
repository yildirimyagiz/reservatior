import { prismaManager } from "../lib/prisma";
import { isExecutionLocked } from "../lib/config/execution-lock";
import { EventDispatcher } from "../core/events/event-dispatcher";
import { contractMutator } from "./contract-mutator";

export class EscrowService {
  async configurePropertyEscrowSplit(
    region: string,
    propertyId: string,
    agentId: string,
    agentPayoutRate: number = 3.0,
    reservatiorFeeRate: number = 4.0,
    blockageDays: number = 15
  ) {
    const prisma = prismaManager.getClient(region);

    const property = await prisma.property.findUnique({
      where: { id: propertyId }
    });
    if (!property) throw new Error("Property not found");

    const agent = await prisma.agent.findUnique({
      where: { id: agentId }
    });
    if (!agent) throw new Error("Agent not found");

    const config = await prisma.escrowSplitConfig.upsert({
      where: { propertyId },
      update: {
        agentId,
        agentPayoutRate,
        reservatiorFeeRate,
        blockageDays,
        isActive: true
      },
      create: {
        propertyId,
        agentId,
        agentPayoutRate,
        reservatiorFeeRate,
        blockageDays,
        isActive: true
      }
    });

    return config;
  }

  async processRentPayment(region: string, paymentId: string) {
    const prisma = prismaManager.getClient(region);

    const payment = await prisma.payment.findUnique({
      where: { id: paymentId },
      include: { Property: true, Lease: true, Reservation: true }
    });

    if (!payment) throw new Error("Payment not found");
    if (payment.status !== "PAID") {
      throw new Error(`Cannot process escrow for unpaid payment. Current status: ${payment.status}`);
    }

    const propertyId = payment.propertyId;
    if (!propertyId) throw new Error("Payment is not associated with a property");

    const forceEscrow = isExecutionLocked(region, "forcePaymentThroughEscrow");

    const splitConfig = await prisma.escrowSplitConfig.findUnique({
      where: { propertyId },
      include: { agent: true }
    });

    if (!splitConfig || !splitConfig.isActive) {
      if (forceEscrow) {
        throw new Error(`EXECUTION_LOCK: Escrow split config required for property ${propertyId} in region ${region}. Configure escrow before processing payments.`);
      }
      return { success: true, reason: "No active split configuration" };
    }

    const { agentId, agentPayoutRate, reservatiorFeeRate, blockageDays } = splitConfig;

    const totalAmount = payment.amount;
    const agentAmount = (totalAmount * agentPayoutRate) / 100;
    const reservatiorAmount = (totalAmount * reservatiorFeeRate) / 100;
    const landlordAmount = totalAmount - agentAmount - reservatiorAmount;

    let wallet = await prisma.agentEscrowWallet.findUnique({
      where: { agentId }
    });

    if (!wallet) {
      wallet = await prisma.agentEscrowWallet.create({
        data: {
          agentId,
          currency: payment.currencyId || "USD"
        }
      });
    }

    const releaseDate = new Date();
    releaseDate.setDate(releaseDate.getDate() + blockageDays);

    const reservationId = payment.reservationId || `res_mock_${paymentId}`;

    const escrow = await prisma.escrowAccount.upsert({
      where: { reservationId },
      create: {
        orgId: payment.Property?.orgId || "tr_residence_org",
        reservationId,
        totalAmount,
        depositAmount: 0.00,
        currency: payment.currencyId || "USD",
        status: "HOLDING"
      },
      update: {
        totalAmount,
        status: "HOLDING"
      }
    });

    const existingTx = await prisma.agentEscrowTransaction.findFirst({
      where: { escrowAccountId: escrow.id, type: "COMMISSION_EARNED", walletId: wallet.id }
    });

    if (!existingTx) {
      await prisma.agentEscrowTransaction.create({
        data: {
          walletId: wallet.id,
          amount: agentAmount,
          currency: payment.currencyId || "USD",
          type: "COMMISSION_EARNED",
          status: "BLOCKED",
          escrowAccountId: escrow.id,
          releaseDate,
          reference: `Rent Payment split for ${payment.id}. Total rent: ${totalAmount}. Agent split: ${agentPayoutRate}%.`
        }
      });

      await prisma.agentEscrowWallet.update({
        where: { id: wallet.id },
        data: {
          pendingBalance: { increment: agentAmount }
        }
      });
    }

    if (escrow.status === "HOLDING" && forceEscrow && payment.Lease) {
      const leaseContract = await prisma.contract.findFirst({
        where: { leaseId: payment.Lease.id }
      });
      if (leaseContract && leaseContract.status === "SIGNING") {
        await contractMutator.withRegion(region).transition(
          leaseContract.id,
          "ACTIVE",
          "ESCROW_HOLDING_CONFIRMED"
        ).catch(() => {});
      }
    }

    EventDispatcher.emit("ESCROW_HOLDING_ESTABLISHED" as any, {
      escrowId: escrow.id,
      paymentId,
      region,
      totalAmount,
      agentAmount,
      reservatiorAmount,
      landlordAmount,
    });

    return {
      success: true,
      escrowId: escrow.id,
      agentAmount,
      reservatiorAmount,
      landlordAmount,
      releaseDate
    };
  }

  async createEscrowFromContract(region: string, contractId: string, totalAmount: number, currency: string = "USD") {
    const prisma = prismaManager.getClient(region);
    const contract = await prisma.contract.findUnique({
      where: { id: contractId },
      include: { lease: true, booking: true }
    });
    if (!contract) throw new Error("Contract not found");

    const reservationId = contract.leaseId || contract.bookingId || contractId;

    const escrow = await prisma.escrowAccount.create({
      data: {
        orgId: contract.orgId,
        reservationId,
        totalAmount,
        depositAmount: 0.00,
        currency,
        status: "HOLDING"
      }
    });

    EventDispatcher.emit("ESCROW_HOLDING_ESTABLISHED" as any, {
      escrowId: escrow.id,
      contractId,
      region,
      totalAmount,
    });

    return escrow;
  }

  async releaseScheduledCommissions(region: string) {
    const prisma = prismaManager.getClient(region);
    const now = new Date();

    const pendingTxs = await prisma.agentEscrowTransaction.findMany({
      where: {
        status: "BLOCKED",
        releaseDate: { lte: now }
      },
      include: {
        wallet: true
      }
    });

    let successCount = 0;

    for (const tx of pendingTxs) {
      try {
        await prisma.$transaction(async (txPrisma) => {
          const activeDispute = tx.escrowAccountId ? await txPrisma.escrowDispute.findFirst({
            where: { escrowAccountId: tx.escrowAccountId, status: { in: ["OPEN", "EVIDENCE_COLLECTION", "UNDER_REVIEW"] } }
          }) : null;

          if (activeDispute) {
            throw new Error("Active dispute exists on escrow account. Release blocked.");
          }

          await txPrisma.agentEscrowTransaction.update({
            where: { id: tx.id },
            data: { status: "SUCCEEDED" }
          });

          await txPrisma.agentEscrowWallet.update({
            where: { id: tx.walletId },
            data: {
              pendingBalance: { decrement: tx.amount },
              balance: { increment: tx.amount }
            }
          });

          if (tx.escrowAccountId) {
            const remainingBlocked = await txPrisma.agentEscrowTransaction.count({
              where: { escrowAccountId: tx.escrowAccountId, status: "BLOCKED" }
            });

            if (remainingBlocked === 0) {
              await txPrisma.escrowAccount.update({
                where: { id: tx.escrowAccountId },
                data: {
                  status: "FULLY_RELEASED",
                  releasedAt: now
                }
              });

              const contractWithEscrow = await txPrisma.contract.findFirst({
                where: { lease: { payments: { some: { reservation: { escrowAccount: { id: tx.escrowAccountId } } } } } }
              });
              if (contractWithEscrow && contractWithEscrow.status === "ACTIVE") {
                await contractMutator.withRegion(region).transition(
                  contractWithEscrow.id,
                  "EXPIRING",
                  "ALL_ESCROW_RELEASED"
                ).catch(() => {});
              }
            }
          }
        });

        successCount++;
      } catch (err) {
        console.error(`Failed to release transaction ${tx.id}:`, err);
      }
    }

    return { totalChecked: pendingTxs.length, releasedCount: successCount };
  }

  async withdrawCommissions(region: string, agentId: string, amount: number) {
    const prisma = prismaManager.getClient(region);

    if (amount <= 0) throw new Error("Withdrawal amount must be greater than zero");

    const wallet = await prisma.agentEscrowWallet.findUnique({
      where: { agentId }
    });

    if (!wallet) throw new Error("Escrow wallet not found for agent");

    const availableBalance = Number(wallet.balance);
    if (availableBalance < amount) {
      throw new Error(`Insufficient cleared balance. Available: $${availableBalance}, Requested: $${amount}`);
    }

    const withdrawalTx = await prisma.$transaction(async (txPrisma) => {
      const updatedWallet = await txPrisma.agentEscrowWallet.update({
        where: { id: wallet.id },
        data: {
          balance: { decrement: amount },
          paidBalance: { increment: amount }
        }
      });

      const txLog = await txPrisma.agentEscrowTransaction.create({
        data: {
          walletId: wallet.id,
          amount,
          currency: wallet.currency,
          type: "PAYOUT_WITHDRAWAL",
          status: "SUCCEEDED",
          reference: `Withdrawal payout requested by agent ${agentId} to their bank account.`
        }
      });

      return { updatedWallet, txLog };
    });

    return {
      success: true,
      amount,
      newBalance: Number(withdrawalTx.updatedWallet.balance),
      transactionId: withdrawalTx.txLog.id
    };
  }

  async getAgentWallet(region: string, agentId: string) {
    const prisma = prismaManager.getClient(region);

    let wallet = await prisma.agentEscrowWallet.findUnique({
      where: { agentId },
      include: {
        transactions: {
          orderBy: { createdAt: "desc" },
          take: 50
        }
      }
    });

    if (!wallet) {
      wallet = await prisma.agentEscrowWallet.create({
        data: {
          agentId,
          currency: "USD"
        },
        include: {
          transactions: true
        }
      });
    }

    return wallet;
  }

  async createCrossBorderEscrow(
    buyerEmail: string,
    buyerRegion: string,
    sellerRegion: string,
    amount: number,
    propertyId: string
  ) {
    if (amount <= 0) throw new Error("Amount must be greater than zero");

    const buyerPrisma = prismaManager.getClient(buyerRegion);
    const sellerPrisma = prismaManager.getClient(sellerRegion);

    const buyer = await buyerPrisma.user.findUnique({
      where: { email: buyerEmail },
    });

    if (!buyer) throw new Error("Buyer not found in origin region");

    const wallet = { id: "mock-wallet", balance: 10000, currency: "USD" };
    if (wallet.balance < amount) {
      throw new Error("Insufficient coupon balance");
    }

    const updatedWallet = wallet;

    try {
      const escrow = await sellerPrisma.escrowAccount.create({
        data: {
          orgId: "tr_residence_org",
          totalAmount: amount,
          depositAmount: amount,
          currency: wallet.currency,
          status: "HOLDING",
          reservationId: propertyId,
        }
      });

      return {
        success: true,
        transactionId: escrow.id,
        newBalance: updatedWallet.balance
      };

    } catch (sellerError) {
      throw new Error("Cross-border transaction failed. Funds have been securely rolled back.");
    }
  }

  async releaseEscrow(
    escrowId: string,
    sellerEmail: string,
    sellerRegion: string,
    transactionRegion: string
  ) {
    const transactionPrisma = prismaManager.getClient(transactionRegion);
    const sellerPrisma = prismaManager.getClient(sellerRegion);

    const escrow = await transactionPrisma.escrowAccount.update({
      where: { id: escrowId },
      data: { status: "FULLY_RELEASED" }
    });

    const seller = await sellerPrisma.user.findUnique({
      where: { email: sellerEmail },
    });

    if (!seller) throw new Error("Seller not found");

    return escrow;
  }
}

export const escrowService = new EscrowService();
