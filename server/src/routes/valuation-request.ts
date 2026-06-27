import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { valuationRequestService } from "../services/valuationrequest";
import { 
  ValuationRequestPlainInputCreate, 
  ValuationRequestPlainInputUpdate 
} from "../../generated/prismabox/ValuationRequest";

export const valuationRequestRoutes = new Elysia({ prefix: "/valuation-request" })
  .use(authMiddleware)

  /**
   * GET /valuation-request
   * Retrieves all ValuationRequest with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return valuationRequestService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await valuationRequestService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: ValuationRequestPlainInputCreate
  })

  /**
   * GET /valuation-request/:id
   * Retrieves a single ValuationRequest by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await valuationRequestService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await valuationRequestService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await valuationRequestService.delete(params.id);
      return { success: true, message: "ValuationRequest deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ValuationRequest not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
