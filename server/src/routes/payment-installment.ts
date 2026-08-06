import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { paymentInstallmentService } from "../services/paymentinstallment";
import { 
  PaymentInstallmentPlainInputCreate, 
  PaymentInstallmentPlainInputUpdate 
} from "../../generated/prismabox/PaymentInstallment";
import { prismaManager } from "../lib/prisma";

export const paymentInstallmentRoutes = new Elysia({ prefix: "/payment-installments" })
  .use(authMiddleware)

  /**
   * GET /payment-installment
   * Retrieves all PaymentInstallment with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return paymentInstallmentService.getAll({
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
   * POST /payment-installments
   * Creates a new PaymentInstallment.
   */
  .post("/", async ({ body, set }) => {
    const data = await paymentInstallmentService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: PaymentInstallmentPlainInputCreate
  })

  /**
   * GET /payment-installments/overdue
   * Retrieves overdue payment installments.
   */
  .get("/overdue", async ({ query, set }) => {
    try {
      const db = prismaManager.getClient();
      const { orgId } = query as any;
      
      const where: any = {
        status: "UNPAID",
        dueDate: { lt: new Date() }
      };
      
      if (orgId) {
        where.orgId = orgId;
      }
      
      const overdueInstallments = await db.paymentInstallment.findMany({
        where,
        include: {
          commission: {
            include: {
              agent: true
            }
          }
        },
        orderBy: { dueDate: "asc" }
      });
      
      return { data: overdueInstallments };
    } catch (e: any) {
      set.status = 500;
      return { error: e.message };
    }
  }, {
    query: t.Partial(t.Object({
      orgId: t.Optional(t.String())
    }))
  })

  /**
   * GET /payment-installments/:id
   * Retrieves a single PaymentInstallment by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await paymentInstallmentService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "PaymentInstallment not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /payment-installment/:id
   * Updates an existing PaymentInstallment.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await paymentInstallmentService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "PaymentInstallment not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PaymentInstallmentPlainInputUpdate
  })

  /**
   * DELETE /payment-installment/:id
   * Deletes a PaymentInstallment.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await paymentInstallmentService.delete(params.id);
      return { success: true, message: "PaymentInstallment deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PaymentInstallment not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
