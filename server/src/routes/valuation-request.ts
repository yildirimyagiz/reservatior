import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { valuationRequestService } from "../services/valuationrequest";
import { 
  ValuationRequestPlainInputCreate, 
  ValuationRequestPlainInputUpdate 
} from "../../generated/prismabox/ValuationRequest";
import { regionMiddleware } from "../middleware/region";

export const valuationRequestRoutes = new Elysia({ prefix: "/valuation-request" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /valuation-request
   * Retrieves all ValuationRequest with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return valuationRequestService.withDB(db as any).getAll({
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
   * POST /valuation-request
   * Creates a new ValuationRequest.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await valuationRequestService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: ValuationRequestPlainInputCreate
  })

  /**
   * GET /valuation-request/:id
   * Retrieves a single ValuationRequest by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await valuationRequestService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "ValuationRequest not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /valuation-request/:id
   * Updates an existing ValuationRequest.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await valuationRequestService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "ValuationRequest not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ValuationRequestPlainInputUpdate
  })

  /**
   * DELETE /valuation-request/:id
   * Deletes a ValuationRequest.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await valuationRequestService.withDB(db as any).delete(params.id);
      return { success: true, message: "ValuationRequest deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ValuationRequest not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
