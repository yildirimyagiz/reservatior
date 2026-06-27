import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { propertyViewingService } from "../services/propertyviewing";
import { 
  PropertyViewingPlainInputCreate, 
  PropertyViewingPlainInputUpdate 
} from "../../generated/prismabox/PropertyViewing";
import { regionMiddleware } from "../middleware/region";

export const propertyViewingRoutes = new Elysia({ prefix: "/property-viewing" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /property-viewing
   * Retrieves all PropertyViewing with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return propertyViewingService.withDB(db as any).getAll({
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
   * POST /property-viewing
   * Creates a new PropertyViewing.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await propertyViewingService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: PropertyViewingPlainInputCreate
  })

  /**
   * GET /property-viewing/:id
   * Retrieves a single PropertyViewing by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await propertyViewingService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "PropertyViewing not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /property-viewing/:id
   * Updates an existing PropertyViewing.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await propertyViewingService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyViewing not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PropertyViewingPlainInputUpdate
  })

  /**
   * DELETE /property-viewing/:id
   * Deletes a PropertyViewing.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await propertyViewingService.withDB(db as any).delete(params.id);
      return { success: true, message: "PropertyViewing deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyViewing not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
