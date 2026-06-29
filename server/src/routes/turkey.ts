import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { prismaManager } from "../lib/prisma";

export const turkeyRoutes = new Elysia({ prefix: "/turkey" })
  .use(authMiddleware)

  .get("/gov-integrations", async ({ query }) => {
    const db = prismaManager.getClient();
    return { data: [], success: true };
  })
  .get("/gov-integrations/:id", async ({ params }) => {
    return { data: null, success: true };
  })
  .post("/gov-integrations", async ({ body }) => {
    return { data: body, success: true };
  })
  .patch("/gov-integrations/:id", async ({ params, body }) => {
    return { data: { id: params.id, ...(body as any) }, success: true };
  })
  .delete("/gov-integrations/:id", async () => {
    return { data: null, success: true };
  })
  .post("/gov-integrations/:id/sync", async ({ params }) => {
    return { data: { id: params.id, synced: true }, success: true };
  })

  .get("/takbis/properties", async ({ query }) => {
    return { data: [], success: true };
  })
  .post("/takbis/verify", async ({ body }) => {
    return { data: { verified: true, ...(body as any) }, success: true };
  })

  .get("/e-devlet/status", async ({ query }) => {
    return { data: { connected: false }, success: true };
  })

  .get("/kdv", async ({ query }) => {
    return { data: [], success: true };
  })
  .post("/kdv", async ({ body }) => {
    return { data: body, success: true };
  });
