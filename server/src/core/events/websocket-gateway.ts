import { Server } from 'socket.io';
import { eventBus } from './event-bus';

let io: Server;

export function initWebSocketGateway(port: number = 3002) {
  io = new Server(port, {
    cors: {
      origin: "*", // allow all for dev
      methods: ["GET", "POST"]
    }
  });

  console.log(`[WebSocket] Gateway listening on port ${port}`);

  io.on('connection', (socket) => {
    console.log(`[WebSocket] Client connected: ${socket.id}`);
    
    socket.on('disconnect', () => {
      console.log(`[WebSocket] Client disconnected: ${socket.id}`);
    });
  });

  // Subscribe to EventBus and forward to WebSocket clients
  const eventsToForward = [
    'CommissionCreated',
    'CommissionAdvanceOffered',
    'CommissionAdvanceAccepted',
    'CommissionPaid',
    'LeadCreated',
    'AdGenerated',
    'PropertyStatusChanged'
  ];

  for (const eventName of eventsToForward) {
    eventBus.subscribe(eventName, async (payload) => {
      console.log(`[WebSocket Gateway] Forwarding ${eventName} to clients as notification:new`);
      
      // Frontend should only know about "notification:new", not domain boundaries
      io.emit('notification:new', {
        type: eventName,
        payload
      });
    });
  }
}

export function getSocketServer(): Server {
  if (!io) {
    throw new Error("WebSocket Gateway not initialized");
  }
  return io;
}
