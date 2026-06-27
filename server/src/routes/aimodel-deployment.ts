import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aIModelDeploymentService } from "../services/aimodeldeployment";
import { 
  AIModelDeploymentPlainInputCreate, 
  AIModelDeploymentPlainInputUpdate 
} from "../../generated/prismabox/AIModelDeployment";

export const aimodelDeploymentRoutes = new Elysia({ prefix: "/ai-model-deployments" })
  .use(authMiddleware)

  /**
   * GET /aimodel-deployment
   * Retrieves all AIModelDeployment with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return aIModelDeploymentService.getAll({
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
   * POST /aimodel-deployment
   * Creates a new AIModelDeployment.
   */
  .post("/", async ({ body, set }) => {
    const data = await aIModelDeploymentService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AIModelDeploymentPlainInputCreate
  })

  /**
   * GET /aimodel-deployment/:id
   * Retrieves a single AIModelDeployment by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await aIModelDeploymentService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AIModelDeployment not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /aimodel-deployment/:id
   * Updates an existing AIModelDeployment.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await aIModelDeploymentService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AIModelDeployment not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AIModelDeploymentPlainInputUpdate
  })

  /**
   * DELETE /aimodel-deployment/:id
   * Deletes a AIModelDeployment.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await aIModelDeploymentService.delete(params.id);
      return { success: true, message: "AIModelDeployment deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AIModelDeployment not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
