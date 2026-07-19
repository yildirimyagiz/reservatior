import { Elysia, t } from "elysia";
import { authMiddleware, hasPermission } from "../middleware/auth";
import { orderService } from "../services/order";

export const commerceOrderRoutes = new Elysia({ prefix: "/commerce-orders" })
  .use(authMiddleware)

  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return orderService.getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { createdAt: "desc" },
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
      status: t.Optional(t.String()),
      buyerType: t.Optional(t.String()),
      agentId: t.Optional(t.String()),
    })),
    detail: {
      summary: "List Orders",
      description: "List all orders with pagination and filtering",
      tags: ["Commerce OS"]
    }
  })

  .get("/buyer/:buyerType/:buyerId", async ({ params }) => {
    return orderService.getByBuyer(params.buyerType, params.buyerId);
  }, {
    params: t.Object({
      buyerType: t.String(),
      buyerId: t.String(),
    }),
    detail: {
      summary: "Get Buyer Orders",
      description: "Get all orders for a specific buyer",
      tags: ["Commerce OS"]
    }
  })

  .get("/:id", async ({ params, set }) => {
    const data = await orderService.getById(params.id, {
      items: { include: { product: true } },
      bundle: true,
      agent: true,
      commissions: true,
    });
    if (!data) {
      set.status = 404;
      return { error: "Order not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() }),
    detail: {
      summary: "Get Order",
      description: "Get a single order by ID with items and details",
      tags: ["Commerce OS"]
    }
  })

  .post("/", async ({ body, set }) => {
    const data = await orderService.createOrder(body);
    set.status = 201;
    return { data };
  }, {
    body: t.Object({
      orgId: t.String(),
      buyerType: t.String(),
      buyerId: t.String(),
      buyerName: t.Optional(t.String()),
      buyerEmail: t.Optional(t.String()),
      agentId: t.Optional(t.String()),
      bundleId: t.Optional(t.String()),
      propertyId: t.Optional(t.String()),
      subtotal: t.Number(),
      discount: t.Optional(t.Number()),
      tax: t.Optional(t.Number()),
      total: t.Number(),
      currency: t.Optional(t.String()),
      paymentMethod: t.Optional(t.String()),
      financingOption: t.Optional(t.String()),
      financingTerm: t.Optional(t.Number()),
      deliveryAddress: t.Optional(t.Any()),
      deliveryDate: t.Optional(t.String()),
      metadata: t.Optional(t.Any()),
      items: t.Optional(t.Array(t.Object({
        productId: t.String(),
        quantity: t.Optional(t.Number()),
        unitPrice: t.Number(),
        totalAmount: t.Number(),
      }))),
    }),
    beforeHandle: hasPermission("COMMERCE_MANAGE"),
    detail: {
      summary: "Create Order",
      description: "Create a new order",
      tags: ["Commerce OS"]
    }
  })

  .patch("/:id/status", async ({ params, body, set }) => {
    try {
      const data = await orderService.updateStatus(params.id, body.status);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Order not found or status update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({ status: t.String() }),
    beforeHandle: hasPermission("COMMERCE_MANAGE"),
    detail: {
      summary: "Update Order Status",
      description: "Update the status of an order",
      tags: ["Commerce OS"]
    }
  });
