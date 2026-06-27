import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { availabilityService } from "../services/availability";
import { 
  AvailabilityPlainInputCreate, 
  AvailabilityPlainInputUpdate 
} from "../../generated/prismabox/Availability";
import { regionMiddleware } from "../middleware/region";

export const availabilityRoutes = new Elysia({ prefix: "/availabilities" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /availability
   * Retrieves all Availability with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return availabilityService.withDB(db as any).getAll({
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
   * POST /availability
   * Creates a new Availability.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await availabilityService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AvailabilityPlainInputCreate
  })

  /**
   * GET /availability/:id
   * Retrieves a single Availability by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await availabilityService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Availability not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /availability/:id
   * Updates an existing Availability.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await availabilityService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Availability not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AvailabilityPlainInputUpdate
  })

  /**
   * DELETE /availability/:id
   * Deletes a Availability.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await availabilityService.withDB(db as any).delete(params.id);
      return { success: true, message: "Availability deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Availability not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
