import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { vendorEarningService } from "../services/vendorearning";
import { 
  VendorEarningPlainInputCreate, 
  VendorEarningPlainInputUpdate 
} from "../../generated/prismabox/VendorEarning";

export const vendorEarningRoutes = new Elysia({ prefix: "/vendor-earning" })
  .use(authMiddleware)

  /**
   * GET /vendor-earning
   * Retrieves all VendorEarning with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return vendorEarningService.getAll({
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
   * POST /vendor-earning
   * Creates a new VendorEarning.
   */
  .post("/", async ({ body, set }) => {
    const data = await vendorEarningService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: VendorEarningPlainInputCreate
  })

  /**
   * GET /vendor-earning/:id
   * Retrieves a single VendorEarning by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await vendorEarningService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "VendorEarning not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /vendor-earning/:id
   * Updates an existing VendorEarning.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await vendorEarningService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "VendorEarning not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: VendorEarningPlainInputUpdate
  })

  /**
   * DELETE /vendor-earning/:id
   * Deletes a VendorEarning.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await vendorEarningService.delete(params.id);
      return { success: true, message: "VendorEarning deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "VendorEarning not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
