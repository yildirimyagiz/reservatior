import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { prismaManager } from "../lib/prisma";

export const tax1099Routes = new Elysia({ prefix: "/tax-1099" })
  .use(authMiddleware)

  .get("/", async ({ query }) => {
    const db = prismaManager.getClient();
    return { data: [], success: true };
  })
  .get("/:id", async ({ params }) => {
    return { data: null, success: true };
  })
  .post("/", async ({ body }) => {
    return { data: body, success: true };
  })
  .patch("/:id", async ({ params, body }) => {
    return { data: { id: params.id, ...(body as any) }, success: true };
  })
  .delete("/:id", async () => {
    return { data: null, success: true };
  })
  .patch("/:id/submit", async ({ params }) => {
    return { data: { id: params.id, submitted: true }, success: true };
  })
  .get("/year/:taxYear", async ({ params }) => {
    return { data: [], success: true };
  })
  .post("/generate", async ({ body }) => {
    return { data: { generated: true, ...(body as any) }, success: true };
  })
  .get("/export", async ({ query }) => {
    return { data: { url: "" }, success: true };
  });
