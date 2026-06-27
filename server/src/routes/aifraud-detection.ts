import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aIFraudDetectionService } from "../services/aifrauddetection";
import { 
  AIFraudDetectionPlainInputCreate, 
  AIFraudDetectionPlainInputUpdate 
} from "../../generated/prismabox/AIFraudDetection";
import { regionMiddleware } from "../middleware/region";

export const aifraudDetectionRoutes = new Elysia({ prefix: "/ai-fraud-detections" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /aifraud-detection
   * Retrieves all AIFraudDetection with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return aIFraudDetectionService.withDB(db as any).getAll({
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
   * POST /aifraud-detection
   * Creates a new AIFraudDetection.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await aIFraudDetectionService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AIFraudDetectionPlainInputCreate
  })

  /**
   * GET /aifraud-detection/:id
   * Retrieves a single AIFraudDetection by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await aIFraudDetectionService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AIFraudDetection not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /aifraud-detection/:id
   * Updates an existing AIFraudDetection.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await aIFraudDetectionService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AIFraudDetection not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AIFraudDetectionPlainInputUpdate
  })

  /**
   * DELETE /aifraud-detection/:id
   * Deletes a AIFraudDetection.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await aIFraudDetectionService.withDB(db as any).delete(params.id);
      return { success: true, message: "AIFraudDetection deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AIFraudDetection not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
