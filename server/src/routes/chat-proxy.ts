import { Elysia, t } from "elysia";
import { ChatRelay } from "../services/bot/chat-relay";
import { prismaManager } from "../lib/prisma";

export const chatProxyRoutes = new Elysia({ prefix: "/chat-proxy" })
  /**
   * Endpoint to send a message via proxy.
   * Can be used to send a message from Buyer to Seller, or from Seller to Buyer.
   */
  .post(
    "/send",
    async ({ body, request }) => {
      const { sessionId, content, role, regionCode } = body;
      
      if (role === "USER") {
        const result = await ChatRelay.relayMessageFromBuyer(sessionId, content, regionCode);
        return { success: true, result };
      } else if (role === "ASSISTANT" || role === "SELLER") {
        const result = await ChatRelay.relayMessageFromSeller(sessionId, content, regionCode);
        return { success: true, result };
      } else {
        return new Response(JSON.stringify({ error: "Invalid role" }), { status: 400 });
      }
    },
    {
      body: t.Object({
        sessionId: t.String(),
        content: t.String(),
        role: t.String(), // "USER" or "ASSISTANT"
        regionCode: t.Optional(t.String({ default: "TR" })),
      }),
      detail: {
        tags: ["ChatProxy"],
        summary: "Send a proxy chat message",
      },
    }
  )
  
  /**
   * Endpoint to retrieve a chat session and its history
   */
  .get(
    "/session/:sessionId",
    async ({ params, query }) => {
      const db = prismaManager.getClient(query.regionCode as string || "TR");
      
      const session = await db.aIChatbotSession.findUnique({
        where: { sessionId: params.sessionId },
        include: {
          messages: {
            orderBy: { createdAt: "asc" }
          }
        }
      });
      
      if (!session) {
        return new Response(JSON.stringify({ error: "Session not found" }), { status: 404 });
      }
      
      return { success: true, data: session };
    },
    {
      params: t.Object({
        sessionId: t.String()
      }),
      query: t.Object({
        regionCode: t.Optional(t.String())
      }),
      detail: {
        tags: ["ChatProxy"],
        summary: "Get proxy chat session history",
      },
    }
  );
