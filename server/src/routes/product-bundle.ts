import { Elysia, t } from "elysia";
import { authMiddleware, hasPermission } from "../middleware/auth";
import { productBundleService } from "../services/product-bundle";

export const productBundleRoutes = new Elysia({ prefix: "/bundles" })
  .use(authMiddleware)

  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return productBundleService.getAll({
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
      bundleType: t.Optional(t.String()),
      isActive: t.Optional(t.String()),
    })),
    detail: {
      summary: "List Product Bundles",
      description: "List all product bundles with pagination",
      tags: ["Commerce OS"]
    }
  })

  .get("/type/:bundleType", async ({ params, query }) => {
    const { page = "1", limit = "20" } = query as any;
    return productBundleService.getAll({
      where: { bundleType: params.bundleType },
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { createdAt: "desc" },
    });
  }, {
    params: t.Object({ bundleType: t.String() }),
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
    })),
    detail: {
      summary: "Get Bundles by Type",
      description: "List bundles filtered by type",
      tags: ["Commerce OS"]
    }
  })

  .get("/:id", async ({ params, set }) => {
    const data = await productBundleService.getByIdWithItems(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Bundle not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() }),
    detail: {
      summary: "Get Bundle",
      description: "Get a single bundle by ID with its items",
      tags: ["Commerce OS"]
    }
  })

  .post("/", async ({ body, set }) => {
    const data = await productBundleService.createWithItems(body);
    set.status = 201;
    return { data };
  }, {
    body: t.Object({
      orgId: t.String(),
      name: t.String(),
      description: t.Optional(t.String()),
      bundleType: t.String(),
      totalPrice: t.Number(),
      currency: t.Optional(t.String()),
      propertyId: t.Optional(t.String()),
      propertyType: t.Optional(t.String()),
      bedrooms: t.Optional(t.Number()),
      originalPrice: t.Optional(t.Number()),
      discountPct: t.Optional(t.Number()),
      isActive: t.Optional(t.Boolean()),
      images: t.Optional(t.Any()),
      metadata: t.Optional(t.Any()),
      items: t.Optional(t.Array(t.Object({
        productId: t.String(),
        quantity: t.Optional(t.Number()),
        unitPrice: t.Number(),
      }))),
    }),
    beforeHandle: hasPermission("COMMERCE_MANAGE"),
    detail: {
      summary: "Create Bundle",
      description: "Create a new furniture/staging bundle with items",
      tags: ["Commerce OS"]
    }
  })

  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await productBundleService.updateWithItems(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Bundle not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      name: t.Optional(t.String()),
      description: t.Optional(t.String()),
      bundleType: t.Optional(t.String()),
      totalPrice: t.Optional(t.Number()),
      currency: t.Optional(t.String()),
      propertyId: t.Optional(t.String()),
      propertyType: t.Optional(t.String()),
      bedrooms: t.Optional(t.Number()),
      originalPrice: t.Optional(t.Number()),
      discountPct: t.Optional(t.Number()),
      isActive: t.Optional(t.Boolean()),
      images: t.Optional(t.Any()),
      metadata: t.Optional(t.Any()),
      items: t.Optional(t.Array(t.Object({
        productId: t.String(),
        quantity: t.Optional(t.Number()),
        unitPrice: t.Number(),
      }))),
    }),
    beforeHandle: hasPermission("COMMERCE_MANAGE"),
    detail: {
      summary: "Update Bundle",
      description: "Update an existing bundle and its items",
      tags: ["Commerce OS"]
    }
  })

  .delete("/:id", async ({ params, set }) => {
    try {
      await productBundleService.delete(params.id);
      return { success: true, message: "Bundle deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Bundle not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    beforeHandle: hasPermission("COMMERCE_MANAGE"),
    detail: {
      summary: "Delete Bundle",
      description: "Delete a product bundle",
      tags: ["Commerce OS"]
    }
  });
