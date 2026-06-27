import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { rightToRentCheckService } from "../services/righttorentcheck";
import { 
  RightToRentCheckPlainInputCreate, 
  RightToRentCheckPlainInputUpdate 
} from "../../generated/prismabox/RightToRentCheck";
import { regionMiddleware } from "../middleware/region";

export const rightToRentCheckRoutes = new Elysia({ prefix: "/right-to-rent-checks" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /right-to-rent-check
   * Retrieves all RightToRentCheck with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return rightToRentCheckService.withDB(db as any).getAll({
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
   * POST /right-to-rent-check
   * Creates a new RightToRentCheck.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await rightToRentCheckService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: RightToRentCheckPlainInputCreate
  })

  /**
   * GET /right-to-rent-check/:id
   * Retrieves a single RightToRentCheck by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await rightToRentCheckService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "RightToRentCheck not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /right-to-rent-check/:id
   * Updates an existing RightToRentCheck.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await rightToRentCheckService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "RightToRentCheck not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: RightToRentCheckPlainInputUpdate
  })

  /**
   * DELETE /right-to-rent-check/:id
   * Deletes a RightToRentCheck.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await rightToRentCheckService.withDB(db as any).delete(params.id);
      return { success: true, message: "RightToRentCheck deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "RightToRentCheck not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
