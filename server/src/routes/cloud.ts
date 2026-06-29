import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { prismaManager } from "../lib/prisma";

export const cloudRoutes = new Elysia({ prefix: "/cloud" })
  .use(authMiddleware)

  .get("/services", async () => {
    const db = prismaManager.getClient();
    return { data: [], success: true };
  })
  .post("/services/deploy", async ({ body }) => {
    return { data: { status: "ACTIVE", ...(body as any) }, success: true };
  })
  .post("/services/stop", async ({ body }) => {
    return { data: { status: "STOPPED", ...(body as any) }, success: true };
  });
