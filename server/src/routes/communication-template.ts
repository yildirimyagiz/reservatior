import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { communicationTemplateService } from "../services/communicationtemplate";
import { 
  CommunicationTemplatePlainInputCreate, 
  CommunicationTemplatePlainInputUpdate 
} from "../../generated/prismabox/CommunicationTemplate";

export const communicationTemplateRoutes = new Elysia({ prefix: "/communication-templates" })
  .use(authMiddleware)

  /**
   * GET /communication-template
   * Retrieves all CommunicationTemplate with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return communicationTemplateService.getAll({
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
   * POST /communication-template
   * Creates a new CommunicationTemplate.
   */
  .post("/", async ({ body, set }) => {
    const data = await communicationTemplateService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: CommunicationTemplatePlainInputCreate
  })

  /**
   * GET /communication-template/:id
   * Retrieves a single CommunicationTemplate by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await communicationTemplateService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "CommunicationTemplate not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /communication-template/:id
   * Updates an existing CommunicationTemplate.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await communicationTemplateService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "CommunicationTemplate not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: CommunicationTemplatePlainInputUpdate
  })

  /**
   * DELETE /communication-template/:id
   * Deletes a CommunicationTemplate.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await communicationTemplateService.delete(params.id);
      return { success: true, message: "CommunicationTemplate deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "CommunicationTemplate not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
