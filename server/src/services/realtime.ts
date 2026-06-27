import { ElysiaWS } from "elysia/ws";

export class RealtimeService {
  // Map of userId to a set of active WebSocket connections
  private static connections = new Map<string, Set<ElysiaWS<any, any>>>();

  static addConnection(userId: string, ws: ElysiaWS<any, any>) {
    if (!this.connections.has(userId)) {
      this.connections.set(userId, new Set());
    }
    this.connections.get(userId)?.add(ws);
    console.log(`[Realtime] User ${userId} connected. Total connections for user: ${this.connections.get(userId)?.size}`);
  }

  static removeConnection(userId: string, ws: ElysiaWS<any, any>) {
    const userConnections = this.connections.get(userId);
    if (userConnections) {
      userConnections.delete(ws);
      if (userConnections.size === 0) {
        this.connections.delete(userId);
      }
    }
    console.log(`[Realtime] User ${userId} disconnected.`);
  }

  static sendToUser(userId: string, type: string, data: any) {
    const userConnections = this.connections.get(userId);
    if (userConnections) {
      const message = JSON.stringify({ type, data, timestamp: new Date().toISOString() });
      userConnections.forEach((ws) => {
        try {
          ws.send(message);
        } catch (e) {
          console.error(`[Realtime] Failed to send message to user ${userId}:`, e);
        }
      });
      return true;
    }
    return false;
  }

  static broadcast(type: string, data: any) {
    const message = JSON.stringify({ type, data, timestamp: new Date().toISOString() });
    this.connections.forEach((sockets) => {
      sockets.forEach((ws) => {
        try {
          ws.send(message);
        } catch (e) {
          // Ignore
        }
      });
    });
  }
}
