import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { propertyOwnershipTransferService } from "../services/propertyownershiptransfer";
import { 
  PropertyOwnershipTransferPlainInputCreate, 
  PropertyOwnershipTransferPlainInputUpdate 
} from "../../generated/prismabox/PropertyOwnershipTransfer";

export const propertyOwnershipTransferRoutes = new Elysia({ prefix: "/property-ownership-transfer" })
  .use(authMiddleware)

  /**
   * GET /property-ownership-transfer
   * Retrieves all PropertyOwnershipTransfer with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return propertyOwnershipTransferService.getAll({
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
   * POST /property-ownership-transfer
   * Creates a new PropertyOwnershipTransfer.
   */
  .post("/", async ({ body, set }) => {
    const data = await propertyOwnershipTransferService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: PropertyOwnershipTransferPlainInputCreate
  })

  /**
   * GET /property-ownership-transfer/:id
   * Retrieves a single PropertyOwnershipTransfer by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await propertyOwnershipTransferService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "PropertyOwnershipTransfer not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /property-ownership-transfer/:id
   * Updates an existing PropertyOwnershipTransfer.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await propertyOwnershipTransferService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyOwnershipTransfer not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PropertyOwnershipTransferPlainInputUpdate
  })

  /**
   * DELETE /property-ownership-transfer/:id
   * Deletes a PropertyOwnershipTransfer.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await propertyOwnershipTransferService.delete(params.id);
      return { success: true, message: "PropertyOwnershipTransfer deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyOwnershipTransfer not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
