import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aIFraudDetectionService } from "../services/aifrauddetection";
import { 
  AIFraudDetectionPlainInputCreate, 
  AIFraudDetectionPlainInputUpdate 
} from "../../generated/prismabox/AIFraudDetection";

export const aifraudDetectionRoutes = new Elysia({ prefix: "/ai-fraud-detections" })
  .use(authMiddleware)

  /**
   * GET /aifraud-detection
   * Retrieves all AIFraudDetection with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return aIFraudDetectionService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await aIFraudDetectionService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AIFraudDetectionPlainInputCreate
  })

  /**
   * GET /aifraud-detection/:id
   * Retrieves a single AIFraudDetection by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await aIFraudDetectionService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await aIFraudDetectionService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await aIFraudDetectionService.delete(params.id);
      return { success: true, message: "AIFraudDetection deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AIFraudDetection not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
