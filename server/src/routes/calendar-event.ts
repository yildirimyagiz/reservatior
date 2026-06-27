import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { calendarEventService } from "../services/calendarevent";
import { 
  CalendarEventPlainInputCreate, 
  CalendarEventPlainInputUpdate 
} from "../../generated/prismabox/CalendarEvent";
import { regionMiddleware } from "../middleware/region";

export const calendarEventRoutes = new Elysia({ prefix: "/calendar-events" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /calendar-event
   * Retrieves all CalendarEvent with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return calendarEventService.withDB(db as any).getAll({
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
   * POST /calendar-event
   * Creates a new CalendarEvent.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await calendarEventService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: CalendarEventPlainInputCreate
  })

  /**
   * GET /calendar-event/:id
   * Retrieves a single CalendarEvent by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await calendarEventService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "CalendarEvent not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /calendar-event/:id
   * Updates an existing CalendarEvent.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await calendarEventService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "CalendarEvent not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: CalendarEventPlainInputUpdate
  })

  /**
   * DELETE /calendar-event/:id
   * Deletes a CalendarEvent.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await calendarEventService.withDB(db as any).delete(params.id);
      return { success: true, message: "CalendarEvent deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "CalendarEvent not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
