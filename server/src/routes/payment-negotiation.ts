import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { paymentNegotiationService } from "../services/paymentnegotiation";
import { 
  PaymentNegotiationPlainInputCreate, 
  PaymentNegotiationPlainInputUpdate 
} from "../../generated/prismabox/PaymentNegotiation";

export const paymentNegotiationRoutes = new Elysia({ prefix: "/payment-negotiations" })
  .use(authMiddleware)

  /**
   * GET /payment-negotiation
   * Retrieves all PaymentNegotiation with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return paymentNegotiationService.getAll({
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
   * POST /payment-negotiation
   * Creates a new PaymentNegotiation.
   */
  .post("/", async ({ body, set }) => {
    const data = await paymentNegotiationService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: PaymentNegotiationPlainInputCreate
  })

  /**
   * GET /payment-negotiation/:id
   * Retrieves a single PaymentNegotiation by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await paymentNegotiationService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "PaymentNegotiation not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /payment-negotiation/:id
   * Updates an existing PaymentNegotiation.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await paymentNegotiationService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "PaymentNegotiation not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PaymentNegotiationPlainInputUpdate
  })

  /**
   * DELETE /payment-negotiation/:id
   * Deletes a PaymentNegotiation.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await paymentNegotiationService.delete(params.id);
      return { success: true, message: "PaymentNegotiation deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PaymentNegotiation not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
