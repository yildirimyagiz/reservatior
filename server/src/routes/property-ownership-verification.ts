import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { propertyOwnershipVerificationService } from "../services/propertyownershipverification";
import { 
  PropertyOwnershipVerificationPlainInputCreate, 
  PropertyOwnershipVerificationPlainInputUpdate 
} from "../../generated/prismabox/PropertyOwnershipVerification";

export const propertyOwnershipVerificationRoutes = new Elysia({ prefix: "/property-ownership-verification" })
  .use(authMiddleware)

  /**
   * GET /property-ownership-verification
   * Retrieves all PropertyOwnershipVerification with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return propertyOwnershipVerificationService.getAll({
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
   * POST /property-ownership-verification
   * Creates a new PropertyOwnershipVerification.
   */
  .post("/", async ({ body, set }) => {
    const data = await propertyOwnershipVerificationService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: PropertyOwnershipVerificationPlainInputCreate
  })

  /**
   * GET /property-ownership-verification/:id
   * Retrieves a single PropertyOwnershipVerification by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await propertyOwnershipVerificationService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "PropertyOwnershipVerification not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /property-ownership-verification/:id
   * Updates an existing PropertyOwnershipVerification.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await propertyOwnershipVerificationService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyOwnershipVerification not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PropertyOwnershipVerificationPlainInputUpdate
  })

  /**
   * DELETE /property-ownership-verification/:id
   * Deletes a PropertyOwnershipVerification.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await propertyOwnershipVerificationService.delete(params.id);
      return { success: true, message: "PropertyOwnershipVerification deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyOwnershipVerification not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
