import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { prismaManager } from "../lib/prisma";

export const strRoutes = new Elysia({ prefix: "/str" })
  .use(authMiddleware)

  .get("/rentals", async ({ query }) => {
    const db = prismaManager.getClient();
    return { data: [], success: true };
  })
  .get("/rentals/:id", async ({ params }) => {
    return { data: null, success: true };
  })
  .post("/rentals", async ({ body }) => {
    return { data: body, success: true };
  })
  .patch("/rentals/:id", async ({ params, body }) => {
    return { data: { id: params.id, ...(body as any) }, success: true };
  })
  .delete("/rentals/:id", async () => {
    return { data: null, success: true };
  })

  .get("/regulations", async ({ query }) => {
    return { data: [], success: true };
  })
  .post("/regulations", async ({ body }) => {
    return { data: body, success: true };
  })
  .patch("/regulations/:id", async ({ params, body }) => {
    return { data: { id: params.id, ...(body as any) }, success: true };
  })

  .get("/licenses", async ({ query }) => {
    return { data: [], success: true };
  })
  .post("/licenses", async ({ body }) => {
    return { data: body, success: true };
  })
  .patch("/licenses/:id", async ({ params, body }) => {
    return { data: { id: params.id, ...(body as any) }, success: true };
  })
  .post("/licenses/:id/renew", async ({ params }) => {
    return { data: { id: params.id, renewed: true }, success: true };
  })

  .get("/analytics", async ({ query }) => {
    return { data: {}, success: true };
  });
