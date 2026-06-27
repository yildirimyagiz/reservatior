import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { solicitorManagementService } from "../services/solicitormanagement";
import { 
  SolicitorManagementPlainInputCreate, 
  SolicitorManagementPlainInputUpdate 
} from "../../generated/prismabox/SolicitorManagement";

export const solicitorManagementRoutes = new Elysia({ prefix: "/solicitor-managements" })
  .use(authMiddleware)

  /**
   * GET /solicitor-management
   * Retrieves all SolicitorManagement with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return solicitorManagementService.getAll({
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
   * POST /solicitor-management
   * Creates a new SolicitorManagement.
   */
  .post("/", async ({ body, set }) => {
    const data = await solicitorManagementService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: SolicitorManagementPlainInputCreate
  })

  /**
   * GET /solicitor-management/:id
   * Retrieves a single SolicitorManagement by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await solicitorManagementService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "SolicitorManagement not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /solicitor-management/:id
   * Updates an existing SolicitorManagement.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await solicitorManagementService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "SolicitorManagement not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: SolicitorManagementPlainInputUpdate
  })

  /**
   * DELETE /solicitor-management/:id
   * Deletes a SolicitorManagement.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await solicitorManagementService.delete(params.id);
      return { success: true, message: "SolicitorManagement deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "SolicitorManagement not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
