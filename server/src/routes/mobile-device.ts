import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { mobileDeviceService } from "../services/mobiledevice";
import { 
  MobileDevicePlainInputCreate, 
  MobileDevicePlainInputUpdate 
} from "../../generated/prismabox/MobileDevice";

export const mobileDeviceRoutes = new Elysia({ prefix: "/mobile-devices" })
  .use(authMiddleware)

  /**
   * GET /mobile-device
   * Retrieves all MobileDevice with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return mobileDeviceService.getAll({
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
   * POST /mobile-device
   * Creates a new MobileDevice.
   */
  .post("/", async ({ body, set }) => {
    const data = await mobileDeviceService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: MobileDevicePlainInputCreate
  })

  /**
   * GET /mobile-device/:id
   * Retrieves a single MobileDevice by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await mobileDeviceService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "MobileDevice not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /mobile-device/:id
   * Updates an existing MobileDevice.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await mobileDeviceService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "MobileDevice not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: MobileDevicePlainInputUpdate
  })

  /**
   * DELETE /mobile-device/:id
   * Deletes a MobileDevice.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await mobileDeviceService.delete(params.id);
      return { success: true, message: "MobileDevice deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "MobileDevice not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
