import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { rentScheduleService } from "../services/rentschedule";
import { 
  RentSchedulePlainInputCreate, 
  RentSchedulePlainInputUpdate 
} from "../../generated/prismabox/RentSchedule";
import { regionMiddleware } from "../middleware/region";

export const rentScheduleRoutes = new Elysia({ prefix: "/rent-schedules" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /rent-schedule
   * Retrieves all RentSchedule with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return rentScheduleService.withDB(db as any).getAll({
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
   * POST /rent-schedule
   * Creates a new RentSchedule.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await rentScheduleService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: RentSchedulePlainInputCreate
  })

  /**
   * GET /rent-schedule/:id
   * Retrieves a single RentSchedule by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await rentScheduleService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "RentSchedule not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /rent-schedule/:id
   * Updates an existing RentSchedule.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await rentScheduleService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "RentSchedule not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: RentSchedulePlainInputUpdate
  })

  /**
   * DELETE /rent-schedule/:id
   * Deletes a RentSchedule.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await rentScheduleService.withDB(db as any).delete(params.id);
      return { success: true, message: "RentSchedule deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "RentSchedule not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
