import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { investorPortfolioService } from "../services/investorportfolio";
import { 
  InvestorPortfolioPlainInputCreate, 
  InvestorPortfolioPlainInputUpdate 
} from "../../generated/prismabox/InvestorPortfolio";
import { regionMiddleware } from "../middleware/region";

export const investorPortfolioRoutes = new Elysia({ prefix: "/investor-portfolios" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /investor-portfolio
   * Retrieves all InvestorPortfolio with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return investorPortfolioService.withDB(db as any).getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { id: "desc" }
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  /**
   * POST /investor-portfolio
   * Creates a new InvestorPortfolio.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await investorPortfolioService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: InvestorPortfolioPlainInputCreate
  })

  /**
   * GET /investor-portfolio/:id
   * Retrieves a single InvestorPortfolio by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await investorPortfolioService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "InvestorPortfolio not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /investor-portfolio/:id
   * Updates an existing InvestorPortfolio.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await investorPortfolioService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "InvestorPortfolio not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: InvestorPortfolioPlainInputUpdate
  })

  /**
   * DELETE /investor-portfolio/:id
   * Deletes a InvestorPortfolio.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await investorPortfolioService.withDB(db as any).delete(params.id);
      return { success: true, message: "InvestorPortfolio deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "InvestorPortfolio not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
