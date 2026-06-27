import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { guestProfileService } from "../services/guestprofile";
import { 
  GuestProfilePlainInputCreate, 
  GuestProfilePlainInputUpdate 
} from "../../generated/prismabox/GuestProfile";

export const guestProfileRoutes = new Elysia({ prefix: "/guest-profiles" })
  .use(authMiddleware)

  /**
   * GET /guest-profile
   * Retrieves all GuestProfile with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return guestProfileService.getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { id: "desc" }
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  /**
   * POST /guest-profile
   * Creates a new GuestProfile.
   */
  .post("/", async ({ body, set }) => {
    const data = await guestProfileService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: GuestProfilePlainInputCreate
  })

  /**
   * GET /guest-profile/:id
   * Retrieves a single GuestProfile by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await guestProfileService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "GuestProfile not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /guest-profile/:id
   * Updates an existing GuestProfile.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await guestProfileService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "GuestProfile not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: GuestProfilePlainInputUpdate
  })

  /**
   * DELETE /guest-profile/:id
   * Deletes a GuestProfile.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await guestProfileService.delete(params.id);
      return { success: true, message: "GuestProfile deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "GuestProfile not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
