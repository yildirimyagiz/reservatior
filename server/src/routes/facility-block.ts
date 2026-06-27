import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { facilityBlockService } from "../services/facilityblock";
import { 
  FacilityBlockPlainInputCreate, 
  FacilityBlockPlainInputUpdate 
} from "../../generated/prismabox/FacilityBlock";
import { regionMiddleware } from "../middleware/region";

export const facilityBlockRoutes = new Elysia({ prefix: "/facility-block" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /facility-block
   * Retrieves all FacilityBlock with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return facilityBlockService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await facilityBlockService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: FacilityBlockPlainInputCreate
  })

  /**
   * GET /facility-block/:id
   * Retrieves a single FacilityBlock by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await facilityBlockService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await facilityBlockService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await facilityBlockService.withDB(db as any).delete(params.id);
      return { success: true, message: "FacilityBlock deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "FacilityBlock not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
