import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { valuationReportService } from "../services/valuationreport";
import { 
  ValuationReportPlainInputCreate, 
  ValuationReportPlainInputUpdate 
} from "../../generated/prismabox/ValuationReport";
import { regionMiddleware } from "../middleware/region";

export const valuationReportRoutes = new Elysia({ prefix: "/valuation-report" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /valuation-report
   * Retrieves all ValuationReport with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return valuationReportService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await valuationReportService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: ValuationReportPlainInputCreate
  })

  /**
   * GET /valuation-report/:id
   * Retrieves a single ValuationReport by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await valuationReportService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await valuationReportService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await valuationReportService.withDB(db as any).delete(params.id);
      return { success: true, message: "ValuationReport deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ValuationReport not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
