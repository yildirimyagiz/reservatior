import { Elysia, t } from "elysia";
import { globalSearchService } from "../services/search";

export const searchRoutes = new Elysia({ prefix: "/search" })
  /**
   * GET /api/v1/search/global
   * Performs a federated search across all active country databases.
   */
  .get(
    "/global",
    async ({ query }) => {
      const { keyword, type, bedrooms, limit } = query;

      const results = await globalSearchService.searchProperties({
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
