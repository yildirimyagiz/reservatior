import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { prismaManager } from "../lib/prisma";

export const salesProcessRoutes = new Elysia({ prefix: "/sales-process" })
  .use(authMiddleware)

  .get("/stages", async ({ query }) => {
    const db = prismaManager.getClient();
    return { data: [], success: true };
  })
  .post("/stages", async ({ body }) => {
    return { data: body, success: true };
  })
  .patch("/stages/:id", async ({ params, body }) => {
    return { data: { id: params.id, ...(body as any) }, success: true };
  })
  .delete("/stages/:id", async () => {
    return { data: null, success: true };
  })

  .get("/negotiations", async ({ query }) => {
    return { data: [], success: true };
  })
  .get("/negotiations/:id", async ({ params }) => {
    return { data: null, success: true };
  })
  .post("/negotiations", async ({ body }) => {
    return { data: body, success: true };
  })
  .patch("/negotiations/:id", async ({ params, body }) => {
    return { data: { id: params.id, ...(body as any) }, success: true };
  })
  .patch("/negotiations/:id/advance", async ({ params }) => {
    return { data: { id: params.id, advanced: true }, success: true };
  })

  .get("/offers", async ({ query }) => {
    return { data: [], success: true };
  })
  .post("/offers", async ({ body }) => {
    return { data: body, success: true };
  })
  .patch("/offers/:id", async ({ params, body }) => {
    return { data: { id: params.id, ...(body as any) }, success: true };
  })
  .patch("/offers/:id/accept", async ({ params }) => {
    return { data: { id: params.id, accepted: true }, success: true };
  })
  .patch("/offers/:id/reject", async ({ params, body }) => {
    return { data: { id: params.id, rejected: true, ...(body as any) }, success: true };
  });
