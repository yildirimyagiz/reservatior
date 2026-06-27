import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { guestService } from "../services/guest";
import { 
  GuestPlainInputCreate, 
  GuestPlainInputUpdate 
} from "../../generated/prismabox/Guest";
import { regionMiddleware } from "../middleware/region";

export const guestRoutes = new Elysia({ prefix: "/guests" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /guest
   * Retrieves all Guest with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return guestService.withDB(db as any).getAll({
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
   * POST /guest
   * Creates a new Guest.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await guestService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: GuestPlainInputCreate
  })

  /**
   * GET /guest/:id
   * Retrieves a single Guest by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await guestService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Guest not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /guest/:id
   * Updates an existing Guest.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await guestService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Guest not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: GuestPlainInputUpdate
  })

  /**
   * DELETE /guest/:id
   * Deletes a Guest.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await guestService.withDB(db as any).delete(params.id);
      return { success: true, message: "Guest deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Guest not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
