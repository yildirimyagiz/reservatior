import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { leaseService } from "../services/lease";
import { 
  LeasePlainInputCreate, 
  LeasePlainInputUpdate 
} from "../../generated/prismabox/Lease";
import { regionMiddleware } from "../middleware/region";

export const leaseRoutes = new Elysia({ prefix: "/lease" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /lease
   * Retrieves all Lease with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return leaseService.withDB(db as any).getAll({
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
   * POST /lease
   * Creates a new Lease.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await leaseService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: LeasePlainInputCreate
  })

  /**
   * GET /lease/:id
   * Retrieves a single Lease by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await leaseService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Lease not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /lease/:id
   * Updates an existing Lease.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await leaseService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Lease not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: LeasePlainInputUpdate
  })

  /**
   * DELETE /lease/:id
   * Deletes a Lease.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await leaseService.withDB(db as any).delete(params.id);
      return { success: true, message: "Lease deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Lease not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
