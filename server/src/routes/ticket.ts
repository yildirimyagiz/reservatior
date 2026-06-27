import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { ticketService } from "../services/ticket";
import { 
  TicketPlainInputCreate, 
  TicketPlainInputUpdate 
} from "../../generated/prismabox/Ticket";

export const ticketRoutes = new Elysia({ prefix: "/tickets" })
  .use(authMiddleware)

  /**
   * GET /ticket
   * Retrieves all Ticket with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return ticketService.getAll({
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
   * POST /ticket
   * Creates a new Ticket.
   */
  .post("/", async ({ body, set }) => {
    const data = await ticketService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: TicketPlainInputCreate
  })

  /**
   * GET /ticket/:id
   * Retrieves a single Ticket by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await ticketService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Ticket not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /ticket/:id
   * Updates an existing Ticket.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await ticketService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Ticket not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: TicketPlainInputUpdate
  })

  /**
   * DELETE /ticket/:id
   * Deletes a Ticket.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await ticketService.delete(params.id);
      return { success: true, message: "Ticket deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Ticket not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
