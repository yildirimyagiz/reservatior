import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { scrapingJobService } from "../services/scrapingjob";
import { 
  ScrapingJobPlainInputCreate, 
  ScrapingJobPlainInputUpdate 
} from "../../generated/prismabox/ScrapingJob";
import { regionMiddleware } from "../middleware/region";

export const scrapingJobRoutes = new Elysia({ prefix: "/scraping-jobs" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /scraping-job
   * Retrieves all ScrapingJob with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return scrapingJobService.withDB(db as any).getAll({
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
   * POST /scraping-job
   * Creates a new ScrapingJob.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await scrapingJobService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: ScrapingJobPlainInputCreate
  })

  /**
   * GET /scraping-job/:id
   * Retrieves a single ScrapingJob by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await scrapingJobService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "ScrapingJob not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /scraping-job/:id
   * Updates an existing ScrapingJob.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await scrapingJobService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "ScrapingJob not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ScrapingJobPlainInputUpdate
  })

  /**
   * DELETE /scraping-job/:id
   * Deletes a ScrapingJob.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await scrapingJobService.withDB(db as any).delete(params.id);
      return { success: true, message: "ScrapingJob deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ScrapingJob not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
