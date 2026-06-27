import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { paymentService } from "../services/payment";
import { stripeService } from "../services/stripe";
import { 
  PaymentPlainInputCreate, 
  PaymentPlainInputUpdate 
} from "../../generated/prismabox/Payment";
import { regionMiddleware } from "../middleware/region";

export const paymentRoutes = new Elysia({ prefix: "/payments" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * POST /payment/create-checkout-session
   * Creates a Stripe checkout session for a payment.
   */
  .post("/create-checkout-session", async ({ orgId, db, body }: { body: any }) => {
    const { amount, currency, successUrl, cancelUrl, paymentType, mode, priceId, planId, ...metadata } = body;
    
    const session = await stripeService.withDB(db as any).createCheckoutSession({
      amount,
      currency: currency || "try",
      successUrl: successUrl || `${process.env.FRONTEND_URL}/payment/success?session_id={CHECKOUT_SESSION_ID}`,
      cancelUrl: cancelUrl || `${process.env.FRONTEND_URL}/payment/cancel`,
      mode: mode || 'payment',
      priceId,
      metadata: {
        ...metadata,
        planId,
        paymentType: paymentType || 'GENERAL_PAYMENT'
      }
    });

    return { sessionId: session.id, url: session.url };
  }, {
    body: t.Object({
      amount: t.Number(),
      currency: t.Optional(t.String()),
      successUrl: t.Optional(t.String()),
      cancelUrl: t.Optional(t.String()),
      paymentType: t.Optional(t.String()),
      propertyId: t.Optional(t.String()),
      bookingId: t.Optional(t.String()),
      expenseId: t.Optional(t.String()),
      extraChargeId: t.Optional(t.String()),
      includedServiceId: t.Optional(t.String()),
      recipientId: t.Optional(t.String()),
      orgId: t.String(),
      planId: t.Optional(t.String()),
      mode: t.Optional(t.String()),
      priceId: t.Optional(t.String()),
      description: t.Optional(t.String()),
    })
  })

  /**
   * GET /payment
   * Retrieves all Payment with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return paymentService.withDB(db as any).getAll({
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
   * POST /payment
   * Creates a new Payment.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await paymentService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: PaymentPlainInputCreate
  })

  /**
   * GET /payment/:id
   * Retrieves a single Payment by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await paymentService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Payment not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /payment/:id
   * Updates an existing Payment.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await paymentService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Payment not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PaymentPlainInputUpdate
  })

  /**
   * DELETE /payment/:id
   * Deletes a Payment.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await paymentService.withDB(db as any).delete(params.id);
      return { success: true, message: "Payment deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Payment not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
