import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { commissionService } from "../services/commission";
import { 
  CommissionPlainInputCreate, 
  CommissionPlainInputUpdate 
} from "../../generated/prismabox/Commission";
import { MLBridgeService } from "../lib/intelligence/MLBridgeService";
import { prismaManager } from "../lib/prisma";

export const commissionRoutes = new Elysia({ prefix: "/commission" })
  .use(authMiddleware)

  /**
   * GET /commission
   * Retrieves all Commission with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return commissionService.getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { createdAt: "desc" }
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  /**
   * POST /commission
   * Creates a new Commission — triggers earning telemetry and agent wallet credit.
   */
  .post("/", async ({ body, set }) => {
    const data = await commissionService.create(body);
    const db = prismaManager.getClient();

    // --- ML Trigger: Commission earned ---
    MLBridgeService.sendFeedback("commission-tracking", "COMMISSION_EARNED", +2.0, {
      commissionId: data.id,
      agentId: data.agentId,
      agencyId: data.agencyId,
      amount: Number(data.commissionAmount),
      baseAmount: Number(data.amountBase),
      rate: data.commissionRate
    }).catch(console.error);

    // Audit log
    try {
      await db.auditLog.create({
        data: {
          action: "COMMISSION_EARNED",
          entityType: "Commission",
          entityId: data.id,
          newValues: { details: `Commission of ${data.commissionAmount} ${data.currency} earned. Agent: ${data.agentId || "N/A"}, Agency: ${data.agencyId || "N/A"}. Rate: ${data.commissionRate}%.` },
          orgId: data.orgId
        }
      });
    } catch (e) { console.warn("Audit log failed:", e); }

    // Credit agent's escrow wallet if an agent is linked
    if (data.agentId) {
      try {
        const wallet = await db.agentEscrowWallet.findUnique({ where: { agentId: data.agentId } });
        if (wallet) {
          await db.agentEscrowWallet.update({
            where: { agentId: data.agentId },
            data: { pendingBalance: { increment: Number(data.commissionAmount) } }
          });

          await db.agentEscrowTransaction.create({
            data: {
              walletId: wallet.id,
              amount: Number(data.commissionAmount),
              currency: data.currency,
              type: "COMMISSION_EARNED",
              status: "BLOCKED",
              reference: `Commission ${data.id}`
            }
          });
        }

        // Notify the agent
        const agent = await db.agent.findUnique({ where: { id: data.agentId }, select: { ownerId: true } });
        if (agent?.ownerId) {
          await db.notification.create({
            data: {
              title: "New Commission Earned 💰",
              body: `You have earned a commission of ${data.commissionAmount} ${data.currency} (${data.commissionRate}% rate). Funds are in escrow pending release.`,
              status: "QUEUED",
              userId: agent.ownerId,
              orgId: data.orgId
            }
          });
        }
      } catch (e) { console.warn("Agent wallet credit failed:", e); }
    }

    set.status = 201;
    return { data };
  }, {
    body: CommissionPlainInputCreate
  })

  /**
   * GET /commission/:id
   * Retrieves a single Commission by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await commissionService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Commission not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /commission/:id
   * Updates an existing Commission — detects status transitions (PAID, OVERDUE, DISPUTED).
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const oldData = await commissionService.getById(params.id);
      const data = await commissionService.update(params.id, body);
      const db = prismaManager.getClient();

      if (oldData && body.status && oldData.status !== body.status) {
        const newStatus = body.status as string;

        // --- PAID: Commission has been released to the agent ---
        if (newStatus === "PAID") {
          MLBridgeService.sendFeedback("commission-tracking", "COMMISSION_PAID", +3.0, {
            commissionId: data.id,
            agentId: data.agentId,
            amount: Number(data.commissionAmount)
          }).catch(console.error);

          // Move funds from pendingBalance -> paidBalance in wallet
          if (data.agentId) {
            const wallet = await db.agentEscrowWallet.findUnique({ where: { agentId: data.agentId } }).catch(() => null);
            if (wallet) {
              await db.agentEscrowWallet.update({
                where: { agentId: data.agentId },
                data: {
                  pendingBalance: { decrement: Number(data.commissionAmount) },
                  paidBalance: { increment: Number(data.commissionAmount) }
                }
              }).catch(console.warn);
            }
          }

          await db.auditLog.create({
            data: {
              action: "COMMISSION_PAID",
              entityType: "Commission",
              entityId: data.id,
              newValues: { details: `Commission ${data.id} of ${data.commissionAmount} ${data.currency} paid out to agent ${data.agentId}.` },
              orgId: data.orgId
            }
          }).catch(console.warn);
        }

        // --- OVERDUE: Commission payment delayed ---
        if (newStatus === "OVERDUE") {
          MLBridgeService.sendFeedback("commission-tracking", "COMMISSION_OVERDUE", -3.0, {
            commissionId: data.id,
            agentId: data.agentId,
            agencyId: data.agencyId
          }).catch(console.error);

          // Alert the agent
          if (data.agentId) {
            const agent = await db.agent.findUnique({ where: { id: data.agentId }, select: { ownerId: true } }).catch(() => null);
            if (agent?.ownerId) {
              await db.notification.create({
                data: {
                  title: "⚠️ Commission Payment Overdue",
                  body: `Your commission of ${data.commissionAmount} ${data.currency} for transaction ${data.transactionId || data.reservationId || "N/A"} is overdue. Please contact your agency administrator.`,
                  status: "QUEUED",
                  userId: agent.ownerId,
                  orgId: data.orgId
                }
              }).catch(console.warn);
            }
          }

          await db.auditLog.create({
            data: {
              action: "COMMISSION_OVERDUE",
              entityType: "Commission",
              entityId: data.id,
              newValues: { details: `Commission ${data.id} is now OVERDUE. Agent: ${data.agentId}, Amount: ${data.commissionAmount} ${data.currency}.` },
              orgId: data.orgId
            }
          }).catch(console.warn);
        }

        // --- DISPUTED: Commission is under dispute ---
        if (newStatus === "DISPUTED") {
          MLBridgeService.sendFeedback("commission-tracking", "COMMISSION_DISPUTED", -5.0, {
            commissionId: data.id,
            agentId: data.agentId,
            agencyId: data.agencyId
          }).catch(console.error);

          await db.auditLog.create({
            data: {
              action: "COMMISSION_DISPUTED",
              entityType: "Commission",
              entityId: data.id,
              newValues: { details: `Commission ${data.id} disputed. Funds frozen pending resolution. Agent: ${data.agentId}, Agency: ${data.agencyId}.` },
              orgId: data.orgId
            }
          }).catch(console.warn);
        }
      }

      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Commission not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: CommissionPlainInputUpdate
  })

  /**
   * DELETE /commission/:id
   * Deletes a Commission.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await commissionService.delete(params.id);
      return { success: true, message: "Commission deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Commission not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * POST /commission/:id/installment-plan
   * Generates a payment installment plan for a commission.
   */
  .post("/:id/installment-plan", async ({ params, body, set }) => {
    try {
      const db = prismaManager.getClient();
      const commission = await commissionService.getById(params.id);
      
      if (!commission) {
        set.status = 404;
        return { error: "Commission not found" };
      }

      // Default logic: create installments based on count and commission amount
      const installmentCount = body.installmentCount || commission.installmentCount || 12;
      const totalAmount = Number(commission.commissionAmount);
      
      const installmentAmount = totalAmount / installmentCount;
      const startDate = body.startDate ? new Date(body.startDate) : new Date();
      
      const installmentsData: any[] = [];
      for (let i = 0; i < installmentCount; i++) {
        const dueDate = new Date(startDate);
        // Default frequency: monthly
        dueDate.setMonth(dueDate.getMonth() + i);
        
        installmentsData.push({
          orgId: commission.orgId,
          negotiationId: "system-generated", // Usually links to a deal/negotiation
          commissionId: commission.id,
          installmentNo: i + 1,
          amount: installmentAmount,
          currency: commission.currency,
          dueDate: dueDate,
          status: "UNPAID"
        });
      }

      // Execute in a transaction
      await db.$transaction(async (tx: any) => {
        // Update commission collection type
        await tx.commission.update({
          where: { id: commission.id },
          data: { collectionType: "INSTALLMENT" }
        });
        
        // Delete existing installments if any
        await tx.paymentInstallment.deleteMany({
          where: { commissionId: commission.id }
        });
        
        // Create new installments
        await tx.paymentInstallment.createMany({
          data: installmentsData
        });
      });

      const newInstallments = await db.paymentInstallment.findMany({
        where: { commissionId: commission.id },
        orderBy: { installmentNo: "asc" }
      });

      return { data: newInstallments, success: true };
    } catch (e: any) {
      set.status = 500;
      return { error: e.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      installmentCount: t.Optional(t.Number()),
      startDate: t.Optional(t.String()), // ISO date string
    })
  });
