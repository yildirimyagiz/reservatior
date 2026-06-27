import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { propertyOwnershipTransferService } from "../services/propertyownershiptransfer";
import { 
  PropertyOwnershipTransferPlainInputCreate, 
  PropertyOwnershipTransferPlainInputUpdate 
} from "../../generated/prismabox/PropertyOwnershipTransfer";
import { regionMiddleware } from "../middleware/region";

export const propertyOwnershipTransferRoutes = new Elysia({ prefix: "/property-ownership-transfer" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /property-ownership-transfer
   * Retrieves all PropertyOwnershipTransfer with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return propertyOwnershipTransferService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await propertyOwnershipTransferService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: PropertyOwnershipTransferPlainInputCreate
  })

  /**
   * GET /property-ownership-transfer/:id
   * Retrieves a single PropertyOwnershipTransfer by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await propertyOwnershipTransferService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await propertyOwnershipTransferService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await propertyOwnershipTransferService.withDB(db as any).delete(params.id);
      return { success: true, message: "PropertyOwnershipTransfer deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyOwnershipTransfer not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
