import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { prismaManager } from "../lib/prisma";

export const marketAnalysisRoutes = new Elysia({ prefix: "/market-analysis" })
  .use(authMiddleware)

  .get("/neighborhoods", async ({ query }) => {
    const db = prismaManager.getClient();
    return { data: [], success: true };
  })
  .post("/neighborhoods", async ({ body }) => {
    return { data: body, success: true };
  })
  .patch("/neighborhoods/:id", async ({ params, body }) => {
    return { data: { id: params.id, ...(body as any) }, success: true };
  })
  .delete("/neighborhoods/:id", async () => {
    return { data: null, success: true };
  })

  .get("/trends", async ({ query }) => {
    return { data: [], success: true };
  })
  .post("/trends", async ({ body }) => {
    return { data: body, success: true };
  })

  .get("/comparables", async ({ query }) => {
    return { data: [], success: true };
  })
  .post("/comparables", async ({ body }) => {
    return { data: body, success: true };
  })

  .get("/price-history", async ({ query }) => {
    return { data: [], success: true };
  });
