import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { propertyInventoryService } from "../services/propertyinventory";
import { 
  PropertyInventoryPlainInputCreate, 
  PropertyInventoryPlainInputUpdate 
} from "../../generated/prismabox/PropertyInventory";

export const propertyInventoryRoutes = new Elysia({ prefix: "/property-inventory" })
  .use(authMiddleware)

  /**
   * GET /property-inventory
   * Retrieves all PropertyInventory with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return propertyInventoryService.getAll({
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
   * POST /property-inventory
   * Creates a new PropertyInventory.
   */
  .post("/", async ({ body, set }) => {
    const data = await propertyInventoryService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: PropertyInventoryPlainInputCreate
  })

  /**
   * GET /property-inventory/:id
   * Retrieves a single PropertyInventory by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await propertyInventoryService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "PropertyInventory not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /property-inventory/:id
   * Updates an existing PropertyInventory.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await propertyInventoryService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyInventory not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PropertyInventoryPlainInputUpdate
  })

  /**
   * DELETE /property-inventory/:id
   * Deletes a PropertyInventory.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await propertyInventoryService.delete(params.id);
      return { success: true, message: "PropertyInventory deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyInventory not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
