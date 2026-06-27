import { Elysia, t } from "elysia";
import { globalSearchService } from "../services/search";
import { regionMiddleware } from "../middleware/region";

export const searchRoutes = new Elysia({ prefix: "/search" })
  .use(regionMiddleware)
  /**
   * GET /api/v1/search/global
   * Performs a federated search across all active country databases.
   */
  .get(
    "/global",
    async ({ orgId, db, query }) => {
      const { keyword, type, bedrooms, limit } = query;

      const results = await globalSearchService.withDB(db as any).searchProperties({
        keyword: keyword as string,
        type: type as string,
        bedrooms: bedrooms ? parseInt(bedrooms as string, 10) : undefined,
        limit: limit ? parseInt(limit as string, 10) : 50,
      });

      return {
        count: results.length,
        data: results,
      };
    },
    {
      query: t.Object({
        keyword: t.Optional(t.String()),
        type: t.Optional(t.String()),
        bedrooms: t.Optional(t.String()),
        limit: t.Optional(t.String()),
      }),
    }
  );
