import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { facilityService } from "../services/facility";
import { 
  FacilityPlainInputCreate, 
  FacilityPlainInputUpdate 
} from "../../generated/prismabox/Facility";
import { regionMiddleware } from "../middleware/region";

export const facilityRoutes = new Elysia({ prefix: "/facility" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /facility
   * Retrieves all Facility with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return facilityService.withDB(db as any).getAll({
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
   * POST /facility
   * Creates a new Facility.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await facilityService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: FacilityPlainInputCreate
  })

  /**
   * GET /facility/:id
   * Retrieves a single Facility by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await facilityService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Facility not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /facility/:id
   * Updates an existing Facility.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await facilityService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Facility not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: FacilityPlainInputUpdate
  })

  /**
   * DELETE /facility/:id
   * Deletes a Facility.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await facilityService.withDB(db as any).delete(params.id);
      return { success: true, message: "Facility deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Facility not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
