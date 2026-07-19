import { Elysia, t } from "elysia";
import { authMiddleware, hasPermission } from "../middleware/auth";
import { supplierService } from "../services/supplier";

export const supplierRoutes = new Elysia({ prefix: "/suppliers" })
  .use(authMiddleware)

  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return supplierService.getAll({
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
      country: t.Optional(t.String()),
    })),
    detail: {
      summary: "List Suppliers",
      description: "List all suppliers with pagination and filtering",
      tags: ["Commerce OS"]
    }
  })

  .get("/:id", async ({ params, set }) => {
    const data = await supplierService.getWithProducts(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Supplier not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() }),
    detail: {
      summary: "Get Supplier",
      description: "Get a single supplier by ID with their products",
      tags: ["Commerce OS"]
    }
  })

  .post("/", async ({ body, set }) => {
    const data = await supplierService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: t.Object({
      orgId: t.String(),
      name: t.String(),
      description: t.Optional(t.String()),
      contactName: t.Optional(t.String()),
      email: t.Optional(t.String()),
      phone: t.Optional(t.String()),
      website: t.Optional(t.String()),
      logo: t.Optional(t.String()),
      taxId: t.Optional(t.String()),
      businessType: t.Optional(t.String()),
      country: t.Optional(t.String()),
      city: t.Optional(t.String()),
      paymentTerms: t.Optional(t.String()),
      minimumOrder: t.Optional(t.Number()),
      currency: t.Optional(t.String()),
      leadTimeDays: t.Optional(t.Number()),
      commissionRate: t.Optional(t.Number()),
      status: t.Optional(t.String()),
      rating: t.Optional(t.Number()),
      metadata: t.Optional(t.Any()),
    }),
    beforeHandle: hasPermission("COMMERCE_MANAGE"),
    detail: {
      summary: "Create Supplier",
      description: "Register a new supplier partner",
      tags: ["Commerce OS"]
    }
  })

  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await supplierService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Supplier not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      name: t.Optional(t.String()),
      description: t.Optional(t.String()),
      contactName: t.Optional(t.String()),
      email: t.Optional(t.String()),
      phone: t.Optional(t.String()),
      website: t.Optional(t.String()),
      logo: t.Optional(t.String()),
      taxId: t.Optional(t.String()),
      businessType: t.Optional(t.String()),
      country: t.Optional(t.String()),
      city: t.Optional(t.String()),
      paymentTerms: t.Optional(t.String()),
      minimumOrder: t.Optional(t.Number()),
      currency: t.Optional(t.String()),
      leadTimeDays: t.Optional(t.Number()),
      commissionRate: t.Optional(t.Number()),
      status: t.Optional(t.String()),
      rating: t.Optional(t.Number()),
      metadata: t.Optional(t.Any()),
    }),
    beforeHandle: hasPermission("COMMERCE_MANAGE"),
    detail: {
      summary: "Update Supplier",
      description: "Update an existing supplier",
      tags: ["Commerce OS"]
    }
  })

  .delete("/:id", async ({ params, set }) => {
    try {
      await supplierService.delete(params.id);
      return { success: true, message: "Supplier deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Supplier not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    beforeHandle: hasPermission("COMMERCE_MANAGE"),
    detail: {
      summary: "Delete Supplier",
      description: "Delete a supplier",
      tags: ["Commerce OS"]
    }
  });
