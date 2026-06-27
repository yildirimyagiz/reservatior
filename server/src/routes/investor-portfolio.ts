import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { investorPortfolioService } from "../services/investorportfolio";
import { 
  InvestorPortfolioPlainInputCreate, 
  InvestorPortfolioPlainInputUpdate 
} from "../../generated/prismabox/InvestorPortfolio";

export const investorPortfolioRoutes = new Elysia({ prefix: "/investor-portfolios" })
  .use(authMiddleware)

  /**
   * GET /investor-portfolio
   * Retrieves all InvestorPortfolio with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return investorPortfolioService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await investorPortfolioService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: InvestorPortfolioPlainInputCreate
  })

  /**
   * GET /investor-portfolio/:id
   * Retrieves a single InvestorPortfolio by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await investorPortfolioService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await investorPortfolioService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await investorPortfolioService.delete(params.id);
      return { success: true, message: "InvestorPortfolio deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "InvestorPortfolio not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
