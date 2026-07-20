import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { prisma } from "../lib/prisma";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

/**
 * Commerce OS — Unified dashboard for products, orders, bundles, campaigns.
 *
 * Existing sub-routes: /products, /suppliers, /commerce-orders,
 *   /campaigns, /product-bundles, /commission-engine
 *
 * This OS route provides the aggregated dashboard + cross-cutting queries.
 */
export const commerceOSRoutes = new Elysia({ prefix: "/commerce-os" })
  .use(authMiddleware)

  // ─── Dashboard ───────────────────────────────────────────────────────────
  .get(
    "/dashboard",
    async ({ query, set }) => {
      const { orgId } = query;
      if (!orgId) {
        set.status = 400;
        return { success: false, error: "orgId is required" };
      }
      try {
        const [totalProducts, totalOrders, totalRevenue, activeCampaigns, pendingOrders] =
          await Promise.all([
            prisma.product.count({ where: { orgId } }),
            prisma.commerceOrder.count({ where: { orgId } }),
            prisma.commerceOrder.aggregate({
              where: { orgId, status: { in: ["CONFIRMED", "PROCESSING", "SHIPPED", "DELIVERED", "INSTALLED"] } },
              _sum: { total: true },
            }),
            prisma.commerceCampaign.count({ where: { orgId, status: "ACTIVE" } }),
            prisma.commerceOrder.count({ where: { orgId, status: "PENDING" } }),
          ]);

        return {
          success: true,
          data: {
            totalProducts,
            totalOrders,
            totalRevenue: Number(totalRevenue._sum.total ?? 0),
            activeCampaigns,
            pendingOrders,
          },
        };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    { query: t.Object({ orgId: t.String() }), detail: { tags: ["Commerce OS"], summary: "Commerce dashboard overview" } }
  )

  // ─── Orders ──────────────────────────────────────────────────────────────
  .get(
    "/orders",
    async ({ query, set }) => {
      const { orgId, status, page = 1, limit = 20 } = query;
      if (!orgId) {
        set.status = 400;
        return { success: false, error: "orgId is required" };
      }
      try {
        const where: any = { orgId };
        if (status) where.status = status;
        const [orders, total] = await Promise.all([
          prisma.commerceOrder.findMany({
            where,
            skip: (page - 1) * limit,
            take: limit,
            orderBy: { createdAt: "desc" },
            include: { items: true },
          }),
          prisma.commerceOrder.count({ where }),
        ]);
        return { success: true, data: { orders, total, page, limit } };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      query: t.Object({
        orgId: t.String(),
        status: t.Optional(t.String()),
        page: t.Optional(t.Numeric()),
        limit: t.Optional(t.Numeric()),
      }),
      detail: { tags: ["Commerce OS"], summary: "List commerce orders" },
    }
  )

  // ─── Order Status Update ─────────────────────────────────────────────────
  .patch(
    "/orders/:id/status",
    async ({ params, body, set }) => {
      const { id } = params;
      const { status, reason } = body;
      try {
        const order = await prisma.commerceOrder.update({
          where: { id },
          data: { status: status as any },
        });

        const eventMap: Record<string, string> = {
          CANCELLED: DomainEvents.ORDER_CANCELLED,
          REFUNDED: DomainEvents.ORDER_REFUNDED,
          DELIVERED: DomainEvents.ORDER_FULFILLED,
        };
        const eventName = eventMap[status];
        if (eventName) {
          eventBus.publish(eventName, { orderId: id, status, orgId: order.orgId }, "CommerceOS");
        }

        return { success: true, data: order };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      params: t.Object({ id: t.String() }),
      body: t.Object({ status: t.String(), reason: t.Optional(t.String()) }),
      detail: { tags: ["Commerce OS"], summary: "Update order status with event emission" },
    }
  )

  // ─── Products ────────────────────────────────────────────────────────────
  .get(
    "/products",
    async ({ query, set }) => {
      const { orgId, category, page = 1, limit = 20 } = query;
      if (!orgId) {
        set.status = 400;
        return { success: false, error: "orgId is required" };
      }
      try {
        const where: any = { orgId };
        if (category) where.category = category;
        const [products, total] = await Promise.all([
          prisma.product.findMany({ where, skip: (page - 1) * limit, take: limit, orderBy: { createdAt: "desc" } }),
          prisma.product.count({ where }),
        ]);
        return { success: true, data: { products, total, page, limit } };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      query: t.Object({
        orgId: t.String(),
        category: t.Optional(t.String()),
        page: t.Optional(t.Numeric()),
        limit: t.Optional(t.Numeric()),
      }),
      detail: { tags: ["Commerce OS"], summary: "List products" },
    }
  )

  // ─── Campaigns ───────────────────────────────────────────────────────────
  .get(
    "/campaigns",
    async ({ query, set }) => {
      const { orgId, status } = query;
      if (!orgId) {
        set.status = 400;
        return { success: false, error: "orgId is required" };
      }
      try {
        const where: any = { orgId };
        if (status) where.status = status;
        const campaigns = await prisma.commerceCampaign.findMany({
          where,
          orderBy: { createdAt: "desc" },
        });
        return { success: true, data: campaigns };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      query: t.Object({ orgId: t.String(), status: t.Optional(t.String()) }),
      detail: { tags: ["Commerce OS"], summary: "List commerce campaigns" },
    }
  )

  // ─── Revenue Analytics ───────────────────────────────────────────────────
  .get(
    "/analytics/revenue",
    async ({ query, set }) => {
      const { orgId, from, to } = query;
      if (!orgId) {
        set.status = 400;
        return { success: false, error: "orgId is required" };
      }
      try {
        const where: any = { orgId, status: { in: ["CONFIRMED", "PROCESSING", "SHIPPED", "DELIVERED", "INSTALLED"] } };
        if (from || to) {
          where.createdAt = {};
          if (from) where.createdAt.gte = new Date(from);
          if (to) where.createdAt.lte = new Date(to);
        }
        const revenue = await prisma.commerceOrder.aggregate({
          where,
          _sum: { total: true },
          _count: true,
        });
        return {
          success: true,
          data: {
            totalRevenue: Number(revenue._sum.total ?? 0),
            totalOrders: revenue._count,
            avgOrderValue: revenue._count > 0 ? (Number(revenue._sum.total ?? 0) / revenue._count).toFixed(2) : 0,
          },
        };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      query: t.Object({
        orgId: t.String(),
        from: t.Optional(t.String()),
        to: t.Optional(t.String()),
      }),
      detail: { tags: ["Commerce OS"], summary: "Revenue analytics" },
    }
  )

  // ─── Suppliers ───────────────────────────────────────────────────────────
  .get(
    "/suppliers",
    async ({ query, set }) => {
      const { orgId } = query;
      if (!orgId) {
        set.status = 400;
        return { success: false, error: "orgId is required" };
      }
      try {
        const suppliers = await prisma.supplier.findMany({
          where: { orgId },
          orderBy: { createdAt: "desc" },
        });
        return { success: true, data: suppliers };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    { query: t.Object({ orgId: t.String() }), detail: { tags: ["Commerce OS"], summary: "List suppliers" } }
  );
