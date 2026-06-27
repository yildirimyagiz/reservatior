import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { vendorProfileService } from "../services/vendorprofile";
import { 
  VendorProfilePlainInputCreate, 
  VendorProfilePlainInputUpdate 
} from "../../generated/prismabox/VendorProfile";

export const vendorProfileRoutes = new Elysia({ prefix: "/vendor-profiles" })
  .use(authMiddleware)

  /**
   * GET /vendor-profile
   * Retrieves all VendorProfile with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return vendorProfileService.getAll({
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
   * POST /vendor-profile
   * Creates a new VendorProfile.
   */
  .post("/", async ({ body, set }) => {
    const data = await vendorProfileService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: VendorProfilePlainInputCreate
  })

  /**
   * GET /vendor-profile/:id
   * Retrieves a single VendorProfile by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await vendorProfileService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "VendorProfile not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /vendor-profile/:id
   * Updates an existing VendorProfile.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await vendorProfileService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "VendorProfile not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: VendorProfilePlainInputUpdate
  })

  /**
   * DELETE /vendor-profile/:id
   * Deletes a VendorProfile.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await vendorProfileService.delete(params.id);
      return { success: true, message: "VendorProfile deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "VendorProfile not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
