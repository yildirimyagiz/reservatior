import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { propertyDisclosureService } from "../services/propertydisclosure";
import { 
  PropertyDisclosurePlainInputCreate, 
  PropertyDisclosurePlainInputUpdate 
} from "../../generated/prismabox/PropertyDisclosure";
import { regionMiddleware } from "../middleware/region";

export const propertyDisclosureRoutes = new Elysia({ prefix: "/property-disclosure" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /property-disclosure
   * Retrieves all PropertyDisclosure with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return propertyDisclosureService.withDB(db as any).getAll({
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
   * POST /property-disclosure
   * Creates a new PropertyDisclosure.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await propertyDisclosureService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: PropertyDisclosurePlainInputCreate
  })

  /**
   * GET /property-disclosure/:id
   * Retrieves a single PropertyDisclosure by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await propertyDisclosureService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "PropertyDisclosure not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /property-disclosure/:id
   * Updates an existing PropertyDisclosure.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await propertyDisclosureService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyDisclosure not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PropertyDisclosurePlainInputUpdate
  })

  /**
   * DELETE /property-disclosure/:id
   * Deletes a PropertyDisclosure.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await propertyDisclosureService.withDB(db as any).delete(params.id);
      return { success: true, message: "PropertyDisclosure deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyDisclosure not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
