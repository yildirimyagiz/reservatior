import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { facilityBlockService } from "../services/facilityblock";
import { 
  FacilityBlockPlainInputCreate, 
  FacilityBlockPlainInputUpdate 
} from "../../generated/prismabox/FacilityBlock";

export const facilityBlockRoutes = new Elysia({ prefix: "/facility-block" })
  .use(authMiddleware)

  /**
   * GET /facility-block
   * Retrieves all FacilityBlock with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return facilityBlockService.getAll({
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
   * POST /facility-block
   * Creates a new FacilityBlock.
   */
  .post("/", async ({ body, set }) => {
    const data = await facilityBlockService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: FacilityBlockPlainInputCreate
  })

  /**
   * GET /facility-block/:id
   * Retrieves a single FacilityBlock by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await facilityBlockService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "FacilityBlock not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /facility-block/:id
   * Updates an existing FacilityBlock.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await facilityBlockService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "FacilityBlock not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: FacilityBlockPlainInputUpdate
  })

  /**
   * DELETE /facility-block/:id
   * Deletes a FacilityBlock.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await facilityBlockService.delete(params.id);
      return { success: true, message: "FacilityBlock deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "FacilityBlock not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
