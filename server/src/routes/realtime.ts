import { Elysia, t } from "elysia";
import { jwt } from "@elysiajs/jwt";
import { RealtimeService } from "../services/realtime";
import { Phi3Service } from "../services/phi3";

// Map to track if a session is currently being handled by a human
// sessionId (userId) -> { isHumanHandled: boolean, agentId?: string }
const SESSION_STATES = new Map<string, { isHumanHandled: boolean, agentId?: string }>();

// List of connected agents (to broadcast user messages to them)
const CONNECTED_AGENTS = new Set<string>();

export const realtimeRoutes = new Elysia({ prefix: "/ws" })
  .use(jwt({ name: "jwt", secret: process.env.JWT_SECRET ?? "secret" }))
  
  // Endpoint to get a short-lived WS token
  .get("/token", async ({ jwt, headers, set }) => {
    return { 
      data: { 
        token: await jwt.sign({ sub: 'temp-auth-user' }),
        expiresIn: 3600
      } 
    };
  })

  // The WebSocket handler
  .ws("/connect", {
    async open(ws) {
      const { userId, orgId, role = 'USER' } = ws.data.query as { userId: string, orgId?: string, role?: string };
      
      if (!userId) {
        ws.close();
        return;
      }

      (ws.data as any).userId = userId;
      (ws.data as any).role = role;
      
      RealtimeService.addConnection(userId, ws);

      // Define which roles are considered "Agents" who can reply to users
      const AGENT_ROLES = ['OWNER', 'AGENCY_ADMIN', 'AGENT', 'ORG_ADMIN', 'VENDOR_MANAGER'];
      if (AGENT_ROLES.includes(role)) {
        CONNECTED_AGENTS.add(userId);
        console.log(`[Realtime] ${role} ${userId} connected as Support Agent. Total agents: ${CONNECTED_AGENTS.size}`);
      }
      
      ws.send(JSON.stringify({ 
        type: 'connection', 
        status: 'connected',
        welcome: role === 'TENANT_GUEST' || role === 'READ_ONLY' 
          ? 'Reservatior Neural Link established. AI Concierge at your service.' 
          : `Mission Control: ${role} Online.`
      }));
    },
    
    async message(ws, message: any) {
      const userId = (ws.data as any).userId;
      const role = (ws.data as any).role;
      const data = message as any;
      
      if (data.type === 'chat_message') {
        // 1. Send feedback to the user
        ws.send(JSON.stringify({
          type: 'chat_ack',
          content: 'Delivered',
          timestamp: new Date().toISOString()
        }));

        // 2. Broadcast to all active agents so they can reply
        CONNECTED_AGENTS.forEach(agentId => {
          if (agentId !== userId) {
            RealtimeService.sendToUser(agentId, 'user_chat_message', {
              userId,
              content: data.content,
              timestamp: data.timestamp
            });
          }
        });

        // 3. AI Support Logic (Phi-3)
        const sessionState = SESSION_STATES.get(userId) || { isHumanHandled: false };
        if (!sessionState.isHumanHandled) {
          // Send "typing" indicator
          ws.send(JSON.stringify({ type: 'typing_indicator', active: true, origin: 'PHI3' }));

          try {
            const aiResponse = await Phi3Service.generateResponse(data.content);
            
            // Send final AI response
            ws.send(JSON.stringify({
              type: 'chat_response',
              origin: 'AI_AGENT',
              content: aiResponse,
              timestamp: new Date().toISOString()
            }));
          } finally {
            ws.send(JSON.stringify({ type: 'typing_indicator', active: false, origin: 'PHI3' }));
          }
        }
      }

      // 4. Agent interventions
      if (data.type === 'agent_reply') {
        const targetUserId = data.targetUserId;
        const replyContent = data.content;
        
        // Mark session as human-handled to stop AI responses
        SESSION_STATES.set(targetUserId, { isHumanHandled: true, agentId: userId });

        // Forward message to the user
        RealtimeService.sendToUser(targetUserId, 'chat_response', {
          origin: 'HUMAN_AGENT',
          agentId: userId,
          content: replyContent,
          timestamp: new Date().toISOString()
        });
      }
    },
    
    close(ws) {
      const userId = (ws.data as any).userId;
      const role = (ws.data as any).role;
      if (userId) {
        RealtimeService.removeConnection(userId, ws);
        if (role !== 'USER') {
          CONNECTED_AGENTS.delete(userId);
        }
      }
    },
    
    query: t.Object({
      userId: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
      token: t.Optional(t.String()),
      role: t.Optional(t.String())
    })
  });
