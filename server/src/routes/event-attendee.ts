import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { eventAttendeeService } from "../services/eventattendee";
import { 
  EventAttendeePlainInputCreate, 
  EventAttendeePlainInputUpdate 
} from "../../generated/prismabox/EventAttendee";
import { regionMiddleware } from "../middleware/region";

export const eventAttendeeRoutes = new Elysia({ prefix: "/event-attendees" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /event-attendee
   * Retrieves all EventAttendee with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return eventAttendeeService.withDB(db as any).getAll({
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
   * POST /event-attendee
   * Creates a new EventAttendee.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await eventAttendeeService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: EventAttendeePlainInputCreate
  })

  /**
   * GET /event-attendee/:id
   * Retrieves a single EventAttendee by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await eventAttendeeService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "EventAttendee not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /event-attendee/:id
   * Updates an existing EventAttendee.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await eventAttendeeService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "EventAttendee not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: EventAttendeePlainInputUpdate
  })

  /**
   * DELETE /event-attendee/:id
   * Deletes a EventAttendee.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await eventAttendeeService.withDB(db as any).delete(params.id);
      return { success: true, message: "EventAttendee deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "EventAttendee not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
