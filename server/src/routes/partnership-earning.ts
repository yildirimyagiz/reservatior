import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { partnershipEarningService } from "../services/partnershipearning";
import { 
  PartnershipEarningPlainInputCreate, 
  PartnershipEarningPlainInputUpdate 
} from "../../generated/prismabox/PartnershipEarning";

export const partnershipEarningRoutes = new Elysia({ prefix: "/partnership-earning" })
  .use(authMiddleware)

  /**
   * GET /partnership-earning
   * Retrieves all PartnershipEarning with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return partnershipEarningService.getAll({
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
   * POST /partnership-earning
   * Creates a new PartnershipEarning.
   */
  .post("/", async ({ body, set }) => {
    const data = await partnershipEarningService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: PartnershipEarningPlainInputCreate
  })

  /**
   * GET /partnership-earning/:id
   * Retrieves a single PartnershipEarning by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await partnershipEarningService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "PartnershipEarning not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /partnership-earning/:id
   * Updates an existing PartnershipEarning.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await partnershipEarningService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "PartnershipEarning not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PartnershipEarningPlainInputUpdate
  })

  /**
   * DELETE /partnership-earning/:id
   * Deletes a PartnershipEarning.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await partnershipEarningService.delete(params.id);
      return { success: true, message: "PartnershipEarning deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PartnershipEarning not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
