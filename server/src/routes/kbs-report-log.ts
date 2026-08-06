import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { kbsReportLogService } from "../services/kbs-report-log";
import { GeminiOpsNotificationCoordinator } from "../services/ai/gemini-ops-coordinator";

export const kbsReportLogRoutes = new Elysia({ prefix: "/kbs-report-log" })
  .use(authMiddleware)

  /**
   * GET /kbs-report-log
   * Retrieves all KbsReportLog with pagination and filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return kbsReportLogService.getAll({
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
   * POST /kbs-report-log
   * Creates a new KbsReportLog record.
   */
  .post("/", async ({ body, set, headers }) => {
    const data = await kbsReportLogService.create(body);
    const region = headers["x-region"] || "US";
    if (data.status === "FAILED") {
      GeminiOpsNotificationCoordinator.trackKbsStatus(data.id, region).catch(err => {
        console.error("❌ Failed to trigger trackKbsStatus in post handler:", err);
      });
    }
    set.status = 201;
    return { data };
  })

  /**
   * GET /kbs-report-log/:id
   * Retrieves a single KbsReportLog by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await kbsReportLogService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "KbsReportLog not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /kbs-report-log/:id
   * Updates an existing KbsReportLog.
   */
  .patch("/:id", async ({ params, body, set, headers }) => {
    try {
      const data = await kbsReportLogService.update(params.id, body);
      const region = headers["x-region"] || "US";
      if ((body as any).status === "FAILED") {
        GeminiOpsNotificationCoordinator.trackKbsStatus(params.id, region).catch(err => {
          console.error("❌ Failed to trigger trackKbsStatus in patch handler:", err);
        });
      }
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "KbsReportLog not found or update failed" };
    }
  })

  /**
   * DELETE /kbs-report-log/:id
   * Deletes a KbsReportLog.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await kbsReportLogService.delete(params.id);
      return { success: true, message: "KbsReportLog deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "KbsReportLog not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
