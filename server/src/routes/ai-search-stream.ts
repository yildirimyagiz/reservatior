import { Elysia, t } from "elysia";
import { AISearchEngine } from "../services/ai/ai-search-engine";
import { optionalAuthMiddleware } from "../middleware/auth";

/**
 * SSE-based AI Search endpoint.
 * This is an ALTERNATIVE to the existing POST /ai-search.
 * The original POST endpoint remains fully intact and functional.
 * 
 * Flow:
 *   1. Client opens GET /ai-search/stream?query=...
 *   2. Server sends progressive SSE events as each stage completes
 *   3. Client renders results in real-time
 * 
 * Event types:
 *   - stage:intent      → Intent analysis complete
 *   - stage:routing     → Route decision made
 *   - stage:properties  → DB properties fetched
 *   - stage:analysis    → AI analysis text ready
 *   - stage:credits     → Credit info
 *   - stage:complete    → Full final payload
 *   - stage:error       → Error occurred
 */
export const aiSearchStreamRoutes = new Elysia({ prefix: "/ai-search" })
  .use(optionalAuthMiddleware)
  .get("/stream", async function* ({ query: params, set, user }) {
    const searchQuery = (params as any).query;
    const clientIp = (params as any).clientIp || "unknown";

    if (!searchQuery) {
      yield formatSSE("stage:error", { error: "Query is required" });
      return;
    }

    set.headers["Content-Type"] = "text/event-stream";
    set.headers["Cache-Control"] = "no-cache";
    set.headers["Connection"] = "keep-alive";
    set.headers["X-Accel-Buffering"] = "no";

    // Stage 1: Acknowledge
    yield formatSSE("stage:started", {
      message: "Processing your query...",
      query: searchQuery,
      timestamp: new Date().toISOString()
    });

    try {
      // Stage 2: Run the full search (reuses existing engine - no duplication)
      const result = await AISearchEngine.processSearch(searchQuery, user, clientIp);

      // Stage 3: Emit intent/filters
      yield formatSSE("stage:intent", {
        filters: result.filters,
        routeUsed: result.routeUsed,
        isDowngraded: result.isDowngraded
      });

      // Stage 4: Emit properties
      if (result.properties && result.properties.length > 0) {
        yield formatSSE("stage:properties", {
          count: result.properties.length,
          properties: result.properties
        });
      }

      // Stage 5: Emit AI analysis text
      yield formatSSE("stage:analysis", {
        text: result.text,
        marketContext: result.marketContext
      });

      // Stage 6: Emit credit info
      if (result.creditsRemaining !== undefined || result.costCharged) {
        yield formatSSE("stage:credits", {
          creditsRemaining: result.creditsRemaining,
          costCharged: result.costCharged
        });
      }

      // Stage 7: Upsell trigger
      if (result.isUpsellTriggered) {
        yield formatSSE("stage:upsell", {
          message: result.text,
          requiresTopUp: result.requiresTopUp
        });
      }

      // Stage 8: Complete with full payload
      yield formatSSE("stage:complete", result);

    } catch (error: any) {
      console.error("[AI Search Stream] Error:", error);
      yield formatSSE("stage:error", {
        error: error.message || "Search operation failed"
      });
    }
  }, {
    query: t.Object({
      query: t.String(),
      clientIp: t.Optional(t.String())
    })
  });


/**
 * Format data as an SSE event string.
 */
function formatSSE(event: string, data: any): string {
  return `event: ${event}\ndata: ${JSON.stringify(data)}\n\n`;
}
