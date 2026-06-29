import { Elysia, t } from "elysia";
import { decisionGraph } from "../core/decision/decision-graph";
import { executionPlanner } from "../core/decision/execution-planner";

export const telemetryRoutes = new Elysia({ prefix: "/telemetry" })
  /**
   * Hybrid Sync Endpoint:
   * Client pushes events here. We return a lightweight Opportunity Snapshot instantly (<200ms)
   * while the heavy graph calculations happen in the background.
   */
  .post(
    "/event",
    async ({ body }) => {
      // Pass the event to the Decision Graph's Sync entrypoint
      const snapshot = await decisionGraph.processEventSync({
        id: crypto.randomUUID(),
        eventName: body.eventName as any,
        entityId: body.entityId,
        entityType: body.entityType,
        source: body.source,
        payload: body.payload,
        timestamp: new Date(),
      });

      return {
        success: true,
        snapshot, // { currentScore, nextBestAction, opportunities }
      };
    },
    {
      body: t.Object({
        eventName: t.String(),
        entityId: t.String(),
        entityType: t.String(),
        source: t.String(),
        payload: t.Optional(t.Any()),
      }),
    }
  )
  
  /**
   * Snapshot API:
   * Best current hypothesis of system. Fetches cached/recent opportunities 
   * without recalculating the entire graph.
   */
  .get("/opportunities", async ({ query }) => {
    // Read from the Execution Planner queue
    const allTasks = executionPlanner.getQueue();
    
    // Filter out completed tasks, just get pending opportunities
    const pendingTasks = allTasks.filter(t => t.status === "PENDING");
    
    return {
      success: true,
      opportunities: pendingTasks,
    };
  });
