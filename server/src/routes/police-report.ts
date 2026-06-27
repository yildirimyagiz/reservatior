import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { policeReportService } from "../services/policereport";
import { 
  PoliceReportPlainInputCreate, 
  PoliceReportPlainInputUpdate 
} from "../../generated/prismabox/PoliceReport";

export const policeReportRoutes = new Elysia({ prefix: "/police-report" })
  .use(authMiddleware)

  /**
   * GET /police-report
   * Retrieves all PoliceReport with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return policeReportService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await policeReportService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: PoliceReportPlainInputCreate
  })

  /**
   * GET /police-report/:id
   * Retrieves a single PoliceReport by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await policeReportService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await policeReportService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await policeReportService.delete(params.id);
      return { success: true, message: "PoliceReport deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PoliceReport not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
