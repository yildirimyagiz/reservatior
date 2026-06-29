import { Elysia, t } from "elysia";
import { AISearchEngine } from "../services/ai/ai-search-engine";
import { optionalAuthMiddleware } from "../middleware/auth";

export const aiSearchRoutes = new Elysia({ prefix: "/ai-search" })
  .use(optionalAuthMiddleware)
  .post("/", async ({ body, set, user }) => {
    try {
      const { query } = body as { query: string };
      if (!query) {
        set.status = 400;
        return { error: "Query is required" };
      }
      
      const result = await AISearchEngine.processSearch(query, user);
      return result;
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    body: t.Object({
      query: t.String()
    })
  });
