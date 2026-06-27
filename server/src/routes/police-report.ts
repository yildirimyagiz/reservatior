import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { policeReportService } from "../services/policereport";
import { 
  PoliceReportPlainInputCreate, 
  PoliceReportPlainInputUpdate 
} from "../../generated/prismabox/PoliceReport";
import { regionMiddleware } from "../middleware/region";

export const policeReportRoutes = new Elysia({ prefix: "/police-report" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /police-report
   * Retrieves all PoliceReport with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return policeReportService.withDB(db as any).getAll({
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
   * POST /police-report
   * Creates a new PoliceReport.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await policeReportService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: PoliceReportPlainInputCreate
  })

  /**
   * GET /police-report/:id
   * Retrieves a single PoliceReport by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await policeReportService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "PoliceReport not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /police-report/:id
   * Updates an existing PoliceReport.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await policeReportService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "PoliceReport not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PoliceReportPlainInputUpdate
  })

  /**
   * DELETE /police-report/:id
   * Deletes a PoliceReport.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await policeReportService.withDB(db as any).delete(params.id);
      return { success: true, message: "PoliceReport deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PoliceReport not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
