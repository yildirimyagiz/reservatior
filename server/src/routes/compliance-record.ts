import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { complianceRecordService } from "../services/compliancerecord";
import { 
  ComplianceRecordPlainInputCreate, 
  ComplianceRecordPlainInputUpdate 
} from "../../generated/prismabox/ComplianceRecord";

export const complianceRecordRoutes = new Elysia({ prefix: "/compliance-record" })
  .use(authMiddleware)

  /**
   * GET /compliance-record
   * Retrieves all ComplianceRecord with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return complianceRecordService.getAll({
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
   * POST /compliance-record
   * Creates a new ComplianceRecord.
   */
  .post("/", async ({ body, set }) => {
    const data = await complianceRecordService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: ComplianceRecordPlainInputCreate
  })

  /**
   * GET /compliance-record/:id
   * Retrieves a single ComplianceRecord by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await complianceRecordService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "ComplianceRecord not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /compliance-record/:id
   * Updates an existing ComplianceRecord.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await complianceRecordService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "ComplianceRecord not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ComplianceRecordPlainInputUpdate
  })

  /**
   * DELETE /compliance-record/:id
   * Deletes a ComplianceRecord.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await complianceRecordService.delete(params.id);
      return { success: true, message: "ComplianceRecord deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ComplianceRecord not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
