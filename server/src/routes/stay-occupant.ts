import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { stayOccupantService } from "../services/stayoccupant";
import { 
  StayOccupantPlainInputCreate, 
  StayOccupantPlainInputUpdate 
} from "../../generated/prismabox/StayOccupant";

export const stayOccupantRoutes = new Elysia({ prefix: "/stay-occupant" })
  .use(authMiddleware)

  /**
   * GET /stay-occupant
   * Retrieves all StayOccupant with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return stayOccupantService.getAll({
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
   * POST /stay-occupant
   * Creates a new StayOccupant.
   */
  .post("/", async ({ body, set }) => {
    const data = await stayOccupantService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: StayOccupantPlainInputCreate
  })

  /**
   * GET /stay-occupant/:id
   * Retrieves a single StayOccupant by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await stayOccupantService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "StayOccupant not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /stay-occupant/:id
   * Updates an existing StayOccupant.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await stayOccupantService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "StayOccupant not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: StayOccupantPlainInputUpdate
  })

  /**
   * DELETE /stay-occupant/:id
   * Deletes a StayOccupant.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await stayOccupantService.delete(params.id);
      return { success: true, message: "StayOccupant deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "StayOccupant not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
