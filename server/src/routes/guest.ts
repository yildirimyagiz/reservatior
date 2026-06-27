import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { guestService } from "../services/guest";
import { 
  GuestPlainInputCreate, 
  GuestPlainInputUpdate 
} from "../../generated/prismabox/Guest";

export const guestRoutes = new Elysia({ prefix: "/guests" })
  .use(authMiddleware)

  /**
   * GET /guest
   * Retrieves all Guest with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return guestService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await guestService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: GuestPlainInputCreate
  })

  /**
   * GET /guest/:id
   * Retrieves a single Guest by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await guestService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await guestService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await guestService.delete(params.id);
      return { success: true, message: "Guest deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Guest not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
