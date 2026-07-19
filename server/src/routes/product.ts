import { Elysia, t } from "elysia";
import { authMiddleware, hasPermission } from "../middleware/auth";
import { productService } from "../services/product";

export const productRoutes = new Elysia({ prefix: "/products" })
  .use(authMiddleware)

  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return productService.getAll({
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
      category: t.Optional(t.String()),
      supplierId: t.Optional(t.String()),
    })),
    detail: {
      summary: "List Products",
      description: "List all products with pagination and filtering",
      tags: ["Commerce OS"]
    }
  })

  .get("/category/:category", async ({ params, query }) => {
    const { page = "1", limit = "20" } = query as any;
    return productService.getByCategory(params.category, {
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
    });
  }, {
    params: t.Object({ category: t.String() }),
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
    })),
    detail: {
      summary: "Get Products by Category",
      description: "List products filtered by category",
      tags: ["Commerce OS"]
    }
  })

  .get("/:id", async ({ params, set }) => {
    const data = await productService.getById(params.id, { supplier: true });
    if (!data) {
      set.status = 404;
      return { error: "Product not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() }),
    detail: {
      summary: "Get Product",
      description: "Get a single product by ID with supplier info",
      tags: ["Commerce OS"]
    }
  })

  .post("/", async ({ body, set }) => {
    const data = await productService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: t.Object({
      orgId: t.String(),
      name: t.String(),
      description: t.Optional(t.String()),
      category: t.String(),
      sku: t.Optional(t.String()),
      price: t.Number(),
      currency: t.Optional(t.String()),
      supplierId: t.Optional(t.String()),
      status: t.Optional(t.String()),
      isActive: t.Optional(t.Boolean()),
      weight: t.Optional(t.Number()),
      commissionRate: t.Optional(t.Number()),
      wholesalePrice: t.Optional(t.Number()),
      retailPrice: t.Optional(t.Number()),
      images: t.Optional(t.Any()),
      attributes: t.Optional(t.Any()),
      dimensions: t.Optional(t.Any()),
      metadata: t.Optional(t.Any()),
    }),
    beforeHandle: hasPermission("COMMERCE_MANAGE"),
    detail: {
      summary: "Create Product",
      description: "Add a new product to the catalog",
      tags: ["Commerce OS"]
    }
  })

  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await productService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Product not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      name: t.Optional(t.String()),
      description: t.Optional(t.String()),
      category: t.Optional(t.String()),
      sku: t.Optional(t.String()),
      price: t.Optional(t.Number()),
      currency: t.Optional(t.String()),
      supplierId: t.Optional(t.String()),
      status: t.Optional(t.String()),
      isActive: t.Optional(t.Boolean()),
      weight: t.Optional(t.Number()),
      commissionRate: t.Optional(t.Number()),
      wholesalePrice: t.Optional(t.Number()),
      retailPrice: t.Optional(t.Number()),
      images: t.Optional(t.Any()),
      attributes: t.Optional(t.Any()),
      dimensions: t.Optional(t.Any()),
      metadata: t.Optional(t.Any()),
    }),
    beforeHandle: hasPermission("COMMERCE_MANAGE"),
    detail: {
      summary: "Update Product",
      description: "Update an existing product",
      tags: ["Commerce OS"]
    }
  })

  .delete("/:id", async ({ params, set }) => {
    try {
      await productService.delete(params.id);
      return { success: true, message: "Product deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Product not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    beforeHandle: hasPermission("COMMERCE_MANAGE"),
    detail: {
      summary: "Delete Product",
      description: "Delete a product from the catalog",
      tags: ["Commerce OS"]
    }
  });
