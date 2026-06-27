import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { financialRecordService } from "../services/financialrecord";
import { 
  FinancialRecordPlainInputCreate, 
  FinancialRecordPlainInputUpdate 
} from "../../generated/prismabox/FinancialRecord";

export const financialRecordRoutes = new Elysia({ prefix: "/financial-record" })
  .use(authMiddleware)

  /**
   * GET /financial-record
   * Retrieves all FinancialRecord with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return financialRecordService.getAll({
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
   * POST /financial-record
   * Creates a new FinancialRecord.
   */
  .post("/", async ({ body, set }) => {
    const data = await financialRecordService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: FinancialRecordPlainInputCreate
  })

  /**
   * GET /financial-record/:id
   * Retrieves a single FinancialRecord by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await financialRecordService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "FinancialRecord not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /financial-record/:id
   * Updates an existing FinancialRecord.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await financialRecordService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "FinancialRecord not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: FinancialRecordPlainInputUpdate
  })

  /**
   * DELETE /financial-record/:id
   * Deletes a FinancialRecord.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await financialRecordService.delete(params.id);
      return { success: true, message: "FinancialRecord deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "FinancialRecord not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
