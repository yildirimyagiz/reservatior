import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";
import { mLSSyncOrchestrator } from "../services/mls-sync-orchestrator";
import { nwmlsProvider } from "../services/nwmls-provider";
import { regionMiddleware } from "../middleware/region";

export const mlsRoutes = new Elysia({ prefix: "/mls" })
  .use(regionMiddleware)

  // GET /mls/connections
  .get("/connections", async () => {
    const connections = await prisma.mLSConnection.findMany({
      include: {
        _count: {
          select: { externalListings: true }
        }
      }
    });

    return {
      success: true,
      data: connections.map(c => ({
        ...c,
        totalListings: c._count.externalListings
      }))
    };
  })

  // POST /mls/connections
  .post("/connections", async ({ db, body, set }) => {
    try {
      const connection = await prisma.mLSConnection.create({
        data: body as any
      });
      return { success: true, data: connection };
    } catch (e) {
      set.status = 500;
      return { success: false, error: (e as any).message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      provider: t.String(),
      name: t.String(),
      baseUrl: t.Optional(t.String()),
      isEnabled: t.Boolean()
    })
  })

  // PATCH /mls/connections/:id
  .patch("/connections/:id", async ({ params, body, set }) => {
    try {
      const connection = await prisma.mLSConnection.update({
        where: { id: params.id },
        data: body as any
      });
      return { success: true, data: connection };
    } catch (e) {
      set.status = 404;
      return { success: false, error: "MLS Connection not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Partial(t.Object({
      name: t.Optional(t.String()),
      baseUrl: t.Optional(t.String()),
      isEnabled: t.Optional(t.Boolean()),
      credentials: t.Optional(t.Any())
    }))
  })

  // DELETE /mls/connections/:id
  .delete("/connections/:id", async ({ params, set }) => {
    try {
      await prisma.mLSConnection.delete({
        where: { id: params.id }
      });
      return { success: true, message: "MLS Connection deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { success: false, error: "MLS Connection not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  })

  // POST /mls/connections/:id/sync
  .post("/connections/:id/sync", async ({ db, params, body }) => {
    const { id } = params;
    const { orgId } = body;
    
    try {
      const result = await mLSSyncOrchestrator.triggerSync(id, orgId);
      return result;
    } catch (e) {
       return { success: false, error: (e as any).message };
    }
  }, {
    body: t.Object({
       orgId: t.String()
    })
  })

  // GET /mls/sync-jobs
  .get("/sync-jobs", async () => {
    const jobs = await prisma.mLSSyncJob.findMany({
      orderBy: { createdAt: "desc" },
      take: 20,
      include: {
        connection: { select: { name: true } }
      }
    });
    return { 
      success: true, 
      data: jobs.map(j => ({ ...j, connectionName: j.connection.name })) 
    };
  })

  // GET /mls/external-listings
  .get("/external-listings", async () => {
    const listings = await prisma.mLSExternalListing.findMany({
      orderBy: { createdAt: "desc" },
      take: 100,
      include: {
        connection: { select: { name: true } }
      }
    });
    return {
      success: true,
      data: listings.map(l => ({
        ...l,
        connectionName: l.connection.name,
        // Map raw data to UI fields for display
        mlsId: l.externalId,
        address: (l.raw as any).location?.address || (l.raw as any).title || "N/A",
        price: (l.raw as any).price?.amount || (l.raw as any).price || 0,
        bedrooms: (l.raw as any).property?.bedrooms || 0,
        bathrooms: (l.raw as any).property?.bathrooms || 0,
        syncedAt: l.updatedAt.toISOString()
      }))
    };
  })

  // GET /mls/data-mappings
  .get("/data-mappings", async () => {
    const mappings = await prisma.mlsDataMapping.findMany();
    return { success: true, data: mappings };
  })

  // POST /mls/convert
  .post("/convert", async ({ db, body, set }) => {
    const { externalListingId, orgId, userId } = body;
    try {
      const result = await mLSSyncOrchestrator.convertToLocalListing(externalListingId, orgId, userId);
      return result;
    } catch (e) {
      set.status = 500;
      return { success: false, error: (e as any).message };
    }
  }, {
    body: t.Object({
       externalListingId: t.String(),
       orgId: t.String(),
       userId: t.String()
    })
  })

  // ──────────────────────────────────────────────────
  // NWMLS (Seattle MLS) — One-Click Import Endpoints
  // ──────────────────────────────────────────────────

  // GET /mls/nwmls/preview?input=2232728
  // Önizleme — sisteme kaydetmeden ilan bilgisini getirir
  .get("/nwmls/preview", async ({ query, set }) => {
    try {
      const result = await nwmlsProvider.previewListing(query.input);
      return { success: true, data: result };
    } catch (e) {
      set.status = 400;
      return { success: false, error: (e as any).message };
    }
  }, {
    query: t.Object({
      input: t.String()
    })
  })

  // POST /mls/nwmls/import — Tek tıkla import
  .post("/nwmls/import", async ({ body, set }) => {
    try {
      const result = await nwmlsProvider.importListing(body.input, body.orgId, body.userId);
      if (!result.success) {
        set.status = 409; // Conflict for duplicates
      }
      return result;
    } catch (e) {
      set.status = 500;
      return { success: false, error: (e as any).message };
    }
  }, {
    body: t.Object({
      input: t.String(),  // MLS # veya NWMLS URL
      orgId: t.String(),
      userId: t.String()
    })
  })

  // POST /mls/nwmls/resync — Mevcut ilanı yeniden senkronize et
  .post("/nwmls/resync", async ({ body, set }) => {
    try {
      const result = await nwmlsProvider.resyncListing(body.mlsNumber, body.orgId);
      return result;
    } catch (e) {
      set.status = 500;
      return { success: false, error: (e as any).message };
    }
  }, {
    body: t.Object({
      mlsNumber: t.String(),
      orgId: t.String()
    })
  });
