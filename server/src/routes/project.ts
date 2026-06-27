import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { regionMiddleware } from "../middleware/region";
import { projectService } from "../services/project";
import { 
  ProjectPlainInputCreate, 
  ProjectPlainInputUpdate 
} from "../../generated/prismabox/Project";

export const projectRoutes = new Elysia({ prefix: "/projects" })
  .use(regionMiddleware)

  /**
   * GET /project
   * Retrieves all Project with pagination and basic filtering. (Public for showcase)
   */
  .get("/", async ({ query, db }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    // For client-side viewing, we display all premium projects of that region database,
    // rather than restricting them to the logged-in agent's tenant organization.
    return projectService.withDB(db as any).getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { createdAt: "desc" },
      include: {
        property: {
          include: {
            documents: true
          }
        }
      }
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  .use(authMiddleware)

  /**
   * POST /project
   * Creates a new Project.
   */
  .post("/", async ({ orgId, body, set, db }) => {
    const data = await projectService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: ProjectPlainInputCreate
  })

  /**
   * GET /project/:id
   * Retrieves a single Project by ID.
   */
  .get("/:id", async ({ orgId, params, set, db }) => {
    const data = await projectService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Project not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /project/:id
   * Updates an existing Project.
   */
  .patch("/:id", async ({ orgId, params, body, set, db }) => {
    try {
      const data = await projectService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Project not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ProjectPlainInputUpdate
  })

  /**
   * DELETE /project/:id
   * Deletes a Project.
   */
  .delete("/:id", async ({ orgId, params, set, db }) => {
    try {
      await projectService.withDB(db as any).delete(params.id);
      return { success: true, message: "Project deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Project not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
