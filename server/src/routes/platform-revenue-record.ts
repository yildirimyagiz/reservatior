import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { platformRevenueRecordService } from "../services/platformrevenuerecord";
import { 
  PlatformRevenueRecordPlainInputCreate, 
  PlatformRevenueRecordPlainInputUpdate 
} from "../../generated/prismabox/PlatformRevenueRecord";

export const platformRevenueRecordRoutes = new Elysia({ prefix: "/platform-revenue-record" })
  .use(authMiddleware)

  /**
   * GET /platform-revenue-record
   * Retrieves all PlatformRevenueRecord with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return platformRevenueRecordService.getAll({
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
   * POST /platform-revenue-record
   * Creates a new PlatformRevenueRecord.
   */
  .post("/", async ({ body, set }) => {
    const data = await platformRevenueRecordService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: PlatformRevenueRecordPlainInputCreate
  })

  /**
   * GET /platform-revenue-record/:id
   * Retrieves a single PlatformRevenueRecord by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await platformRevenueRecordService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "PlatformRevenueRecord not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /platform-revenue-record/:id
   * Updates an existing PlatformRevenueRecord.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await platformRevenueRecordService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "PlatformRevenueRecord not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PlatformRevenueRecordPlainInputUpdate
  })

  /**
   * DELETE /platform-revenue-record/:id
   * Deletes a PlatformRevenueRecord.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await platformRevenueRecordService.delete(params.id);
      return { success: true, message: "PlatformRevenueRecord deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PlatformRevenueRecord not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
