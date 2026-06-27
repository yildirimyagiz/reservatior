import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { projectAlertService } from "../services/projectalert";
import { 
  ProjectAlertPlainInputCreate, 
  ProjectAlertPlainInputUpdate 
} from "../../generated/prismabox/ProjectAlert";

export const projectAlertRoutes = new Elysia({ prefix: "/project-alerts" })
  .use(authMiddleware)

  /**
   * GET /project-alert
   * Retrieves all ProjectAlert with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return projectAlertService.getAll({
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
   * POST /project-alert
   * Creates a new ProjectAlert.
   */
  .post("/", async ({ body, set }) => {
    const data = await projectAlertService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: ProjectAlertPlainInputCreate
  })

  /**
   * GET /project-alert/:id
   * Retrieves a single ProjectAlert by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await projectAlertService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "ProjectAlert not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /project-alert/:id
   * Updates an existing ProjectAlert.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await projectAlertService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "ProjectAlert not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ProjectAlertPlainInputUpdate
  })

  /**
   * DELETE /project-alert/:id
   * Deletes a ProjectAlert.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await projectAlertService.delete(params.id);
      return { success: true, message: "ProjectAlert deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ProjectAlert not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
