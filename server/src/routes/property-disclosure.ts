import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { propertyDisclosureService } from "../services/propertydisclosure";
import { 
  PropertyDisclosurePlainInputCreate, 
  PropertyDisclosurePlainInputUpdate 
} from "../../generated/prismabox/PropertyDisclosure";

export const propertyDisclosureRoutes = new Elysia({ prefix: "/property-disclosure" })
  .use(authMiddleware)

  /**
   * GET /property-disclosure
   * Retrieves all PropertyDisclosure with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return propertyDisclosureService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await propertyDisclosureService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: PropertyDisclosurePlainInputCreate
  })

  /**
   * GET /property-disclosure/:id
   * Retrieves a single PropertyDisclosure by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await propertyDisclosureService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await propertyDisclosureService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await propertyDisclosureService.delete(params.id);
      return { success: true, message: "PropertyDisclosure deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyDisclosure not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
