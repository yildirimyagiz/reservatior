import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { prismaManager } from "../lib/prisma";

export const securityRoutes = new Elysia({ prefix: "/security" })
  .use(authMiddleware)

  .get("/2fa/setup", async () => {
    return { data: { secret: "", qrCode: "" }, success: true };
  })
  .post("/2fa/verify", async ({ body }) => {
    return { data: { verified: true }, success: true };
  })
  .post("/2fa/disable", async ({ body }) => {
    return { data: { disabled: true }, success: true };
  })

  .post("/biometric/enable", async ({ body }) => {
    return { data: { enabled: true, ...(body as any) }, success: true };
  })

  .get("/sessions", async () => {
    const db = prismaManager.getClient();
    return { data: [], success: true };
  })
  .delete("/sessions/:id", async ({ params }) => {
    return { data: null, success: true };
  });
