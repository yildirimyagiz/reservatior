import { Elysia, t } from "elysia";
import { authMiddleware, hasPermission } from "../middleware/auth";
import { kumbaraDepositService } from "../services/kumbara-deposit";

export const kumbaraDepositRoutes = new Elysia({ prefix: "/kumbara-deposits" })
  .use(authMiddleware)

  /**
   * GET /kumbara-deposits
   * Retrieves all KumbaraDeposits with pagination and filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return kumbaraDepositService.getAll({
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
      leaseId: t.Optional(t.String()),
    })),
    detail: {
      summary: "List Kumbara Deposits",
      description: "Retrieve all Kumbara deposit accounts for the organization with pagination and filtering",
      tags: ["Kumbara"]
    }
  })

  /**
   * POST /kumbara-deposits
   * Creates a new KumbaraDeposit with calculated nextDueDate and remainingBalance.
   */
  .post("/", async ({ body, set }) => {
    const data = await kumbaraDepositService.createDeposit(body as any);
    set.status = 201;
    return { data };
  }, {
    body: t.Any(),
    beforeHandle: hasPermission("KUMBARA_MANAGE"),
    detail: {
      summary: "Create Kumbara Deposit",
      description: "Create a new Kumbara deposit account with calculated nextDueDate and remainingBalance",
      tags: ["Kumbara"]
    }
  })

  /**
   * GET /kumbara-deposits/:id
   * Retrieves a single KumbaraDeposit by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await kumbaraDepositService.getById(params.id, {
      contributions: { orderBy: { createdAt: "desc" } },
      rules: true,
    });
    if (!data) {
      set.status = 404;
      return { error: "KumbaraDeposit not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() }),
    detail: {
      summary: "Get Kumbara Deposit",
      description: "Retrieve a single Kumbara deposit by ID with contributions and rules",
      tags: ["Kumbara"]
    }
  })

  /**
   * PATCH /kumbara-deposits/:id
   * Updates an existing KumbaraDeposit.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await kumbaraDepositService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "KumbaraDeposit not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Any(),
    beforeHandle: hasPermission("KUMBARA_MANAGE"),
    detail: {
      summary: "Update Kumbara Deposit",
      description: "Update an existing Kumbara deposit account",
      tags: ["Kumbara"]
    }
  })

  /**
   * DELETE /kumbara-deposits/:id
   * Deletes a KumbaraDeposit.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await kumbaraDepositService.delete(params.id);
      return { success: true, message: "KumbaraDeposit deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "KumbaraDeposit not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    beforeHandle: hasPermission("KUMBARA_MANAGE"),
    detail: {
      summary: "Delete Kumbara Deposit",
      description: "Delete a Kumbara deposit account",
      tags: ["Kumbara"]
    }
  })

  /**
   * POST /kumbara-deposits/:id/contribute
   * Records a contribution to a deposit.
   */
  .post("/:id/contribute", async ({ params, body, set }) => {
    try {
      const { amount, paymentMethod, gatewayRef } = body as any;
      const result = await kumbaraDepositService.recordContribution(
        params.id,
        amount,
        paymentMethod,
        gatewayRef,
      );
      return { data: result };
    } catch (e: any) {
      set.status = 400;
      return { error: e.message || "Failed to record contribution" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Any(),
    beforeHandle: hasPermission("KUMBARA_MANAGE"),
    detail: {
      summary: "Record Contribution",
      description: "Record a contribution/payment to a Kumbara deposit account",
      tags: ["Kumbara"]
    }
  })

  /**
   * GET /kumbara-deposits/:id/summary
   * Returns deposit summary with contribution history, remaining balance, next due date.
   */
  .get("/:id/summary", async ({ params, set }) => {
    const data = await kumbaraDepositService.getDepositSummary(params.id);
    if (!data) {
      set.status = 404;
      return { error: "KumbaraDeposit not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() }),
    detail: {
      summary: "Get Deposit Summary",
      description: "Returns deposit summary with contribution history, remaining balance, and next due date",
      tags: ["Kumbara"]
    }
  })

  /**
   * GET /kumbara-deposits/org/:orgId
   * Lists all deposits for an org with optional filters.
   */
  .get("/org/:orgId", async ({ params, query, set }) => {
    const { status, leaseId, propertyId, tenantId, page, limit } = query as any;
    const data = await kumbaraDepositService.getOrgDeposits(
      params.orgId,
      { status, leaseId, propertyId, tenantId, page: page ? parseInt(page) : undefined, limit: limit ? parseInt(limit) : undefined },
    );
    return { data: data.data, total: data.total, page: data.page, limit: data.limit };
  }, {
    params: t.Object({ orgId: t.String() }),
    query: t.Partial(t.Object({
      status: t.Optional(t.String()),
      leaseId: t.Optional(t.String()),
      propertyId: t.Optional(t.String()),
      tenantId: t.Optional(t.String()),
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
    })),
    detail: {
      summary: "List Organization Deposits",
      description: "List all Kumbara deposits for an organization with optional filters",
      tags: ["Kumbara"]
    }
  });
