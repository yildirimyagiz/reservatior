import { Elysia, t } from "elysia";
import { prismaManager } from "../lib/prisma";
import { rabbitMQService } from "../services/rabbitmq-service";

export const mlsSyncRoutes = new Elysia({ prefix: "/mls-sync" })
  .post("/trigger", async ({ body }) => {
    const db = prismaManager.getClient();
    const { connectionId } = body;

    const connection = await db.mLSConnection.findUnique({
      where: { id: connectionId }
    });

    if (!connection) {
      return { error: "MLS Connection not found" };
    }

    const job = await db.mLSSyncJob.create({
      data: {
        orgId: connection.orgId,
        connectionId: connection.id,
        status: "RUNNING",
        startedAt: new Date()
      }
    });

    // Mock fetching external listings
    const mockExtListings = Array.from({ length: 10 }).map((_, i) => ({
      connectionId: connection.id,
      orgId: connection.orgId,
      mlsNumber: `MLS-${connection.provider}-MANUAL-${i}-${Date.now()}`,
      status: "Active",
      price: 250000 + (Math.random() * 500000),
      photos: ["https://example.com/photo1.jpg"],
      syncJobId: job.id
    }));

    for (const listing of mockExtListings) {
      await rabbitMQService.publishToQueue('mls_sync_queue', listing);
    }

    return { 
      success: true, 
      message: `Sync triggered for connection ${connectionId}. Queued ${mockExtListings.length} items.`,
      jobId: job.id 
    };
  }, {
    body: t.Object({
      connectionId: t.String()
    })
  })
  .get("/status/:jobId", async ({ params }) => {
    const db = prismaManager.getClient();
    const job = await db.mLSSyncJob.findUnique({
      where: { id: params.jobId }
    });
    return { job };
  });
