import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { prismaManager } from "../lib/prisma";

export const identityComplianceRoutes = new Elysia({ prefix: "/identity" })
  .use(authMiddleware)

  .get("/documents", async ({ query }) => {
    const db = prismaManager.getClient();
    return { data: [], success: true };
  })
  .post("/reservations/:reservationId/verify", async ({ params, body }) => {
    return { data: { reservationId: params.reservationId, ...(body as any) }, success: true };
  })

  .get("/occupants", async ({ query }) => {
    return { data: [], success: true };
  })
  .patch("/occupants/:id", async ({ params, body }) => {
    return { data: { id: params.id, ...(body as any) }, success: true };
  })

  .get("/police-reports", async ({ query }) => {
    return { data: [], success: true };
  })
  .post("/reservations/:reservationId/report-to-police", async ({ params }) => {
    return { data: { reservationId: params.reservationId, reported: true }, success: true };
  })
  .get("/properties/:propertyId/report-history", async ({ params }) => {
    return { data: [], success: true };
  })

  .post("/extract-id", async ({ body }) => {
    return { data: { extracted: true, ...(body as any) }, success: true };
  });
