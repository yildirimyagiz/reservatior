import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { valuationReportService } from "../services/valuationreport";
import { 
  ValuationReportPlainInputCreate, 
  ValuationReportPlainInputUpdate 
} from "../../generated/prismabox/ValuationReport";

export const valuationReportRoutes = new Elysia({ prefix: "/valuation-report" })
  .use(authMiddleware)

  /**
   * GET /valuation-report
   * Retrieves all ValuationReport with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return valuationReportService.getAll({
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
   * POST /valuation-report
   * Creates a new ValuationReport.
   */
  .post("/", async ({ body, set }) => {
    const data = await valuationReportService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: ValuationReportPlainInputCreate
  })

  /**
   * GET /valuation-report/:id
   * Retrieves a single ValuationReport by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await valuationReportService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "ValuationReport not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /valuation-report/:id
   * Updates an existing ValuationReport.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await valuationReportService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "ValuationReport not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ValuationReportPlainInputUpdate
  })

  /**
   * DELETE /valuation-report/:id
   * Deletes a ValuationReport.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await valuationReportService.delete(params.id);
      return { success: true, message: "ValuationReport deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ValuationReport not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
