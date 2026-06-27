import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { mortgagePreApprovalService } from "../services/mortgagepreapproval";
import { 
  MortgagePreApprovalPlainInputCreate, 
  MortgagePreApprovalPlainInputUpdate 
} from "../../generated/prismabox/MortgagePreApproval";

export const mortgagePreApprovalRoutes = new Elysia({ prefix: "/mortgage-pre-approvals" })
  .use(authMiddleware)

  /**
   * GET /mortgage-pre-approval
   * Retrieves all MortgagePreApproval with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return mortgagePreApprovalService.getAll({
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
   * POST /mortgage-pre-approval
   * Creates a new MortgagePreApproval.
   */
  .post("/", async ({ body, set }) => {
    const data = await mortgagePreApprovalService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: MortgagePreApprovalPlainInputCreate
  })

  /**
   * GET /mortgage-pre-approval/:id
   * Retrieves a single MortgagePreApproval by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await mortgagePreApprovalService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "MortgagePreApproval not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /mortgage-pre-approval/:id
   * Updates an existing MortgagePreApproval.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await mortgagePreApprovalService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "MortgagePreApproval not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: MortgagePreApprovalPlainInputUpdate
  })

  /**
   * DELETE /mortgage-pre-approval/:id
   * Deletes a MortgagePreApproval.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await mortgagePreApprovalService.delete(params.id);
      return { success: true, message: "MortgagePreApproval deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "MortgagePreApproval not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
