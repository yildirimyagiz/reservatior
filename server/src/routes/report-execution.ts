import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { reportExecutionService } from "../services/reportexecution";
import { 
  ReportExecutionPlainInputCreate, 
  ReportExecutionPlainInputUpdate 
} from "../../generated/prismabox/ReportExecution";

export const reportExecutionRoutes = new Elysia({ prefix: "/report-executions" })
  .use(authMiddleware)

  /**
   * GET /report-execution
   * Retrieves all ReportExecution with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return reportExecutionService.getAll({
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
   * POST /report-execution
   * Creates a new ReportExecution.
   */
  .post("/", async ({ body, set }) => {
    const data = await reportExecutionService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: ReportExecutionPlainInputCreate
  })

  /**
   * GET /report-execution/:id
   * Retrieves a single ReportExecution by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await reportExecutionService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "ReportExecution not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /report-execution/:id
   * Updates an existing ReportExecution.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await reportExecutionService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "ReportExecution not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ReportExecutionPlainInputUpdate
  })

  /**
   * DELETE /report-execution/:id
   * Deletes a ReportExecution.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await reportExecutionService.delete(params.id);
      return { success: true, message: "ReportExecution deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ReportExecution not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
