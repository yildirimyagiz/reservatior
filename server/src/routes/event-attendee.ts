import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { eventAttendeeService } from "../services/eventattendee";
import { 
  EventAttendeePlainInputCreate, 
  EventAttendeePlainInputUpdate 
} from "../../generated/prismabox/EventAttendee";

export const eventAttendeeRoutes = new Elysia({ prefix: "/event-attendees" })
  .use(authMiddleware)

  /**
   * GET /event-attendee
   * Retrieves all EventAttendee with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return eventAttendeeService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await eventAttendeeService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: EventAttendeePlainInputCreate
  })

  /**
   * GET /event-attendee/:id
   * Retrieves a single EventAttendee by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await eventAttendeeService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await eventAttendeeService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await eventAttendeeService.delete(params.id);
      return { success: true, message: "EventAttendee deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "EventAttendee not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
