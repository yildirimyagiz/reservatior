import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { eventService } from "../services/event";
import { 
  EventPlainInputCreate, 
  EventPlainInputUpdate 
} from "../../generated/prismabox/Event";

export const eventRoutes = new Elysia({ prefix: "/events" })
  .use(authMiddleware)

  /**
   * GET /event
   * Retrieves all Event with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return eventService.getAll({
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
   * POST /event
   * Creates a new Event.
   */
  .post("/", async ({ body, set }) => {
    const data = await eventService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: EventPlainInputCreate
  })

  /**
   * GET /event/:id
   * Retrieves a single Event by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await eventService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Event not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /event/:id
   * Updates an existing Event.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await eventService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Event not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: EventPlainInputUpdate
  })

  /**
   * DELETE /event/:id
   * Deletes a Event.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await eventService.delete(params.id);
      return { success: true, message: "Event deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Event not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
