import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { taxRecordService } from "../services/taxrecord";
import { 
  TaxRecordPlainInputCreate, 
  TaxRecordPlainInputUpdate 
} from "../../generated/prismabox/TaxRecord";

export const taxRecordRoutes = new Elysia({ prefix: "/tax-record" })
  .use(authMiddleware)

  /**
   * GET /tax-record
   * Retrieves all TaxRecord with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return taxRecordService.getAll({
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
   * POST /tax-record
   * Creates a new TaxRecord.
   */
  .post("/", async ({ body, set }) => {
    const data = await taxRecordService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: TaxRecordPlainInputCreate
  })

  /**
   * GET /tax-record/:id
   * Retrieves a single TaxRecord by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await taxRecordService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "TaxRecord not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /tax-record/:id
   * Updates an existing TaxRecord.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await taxRecordService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "TaxRecord not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: TaxRecordPlainInputUpdate
  })

  /**
   * DELETE /tax-record/:id
   * Deletes a TaxRecord.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await taxRecordService.delete(params.id);
      return { success: true, message: "TaxRecord deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "TaxRecord not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
