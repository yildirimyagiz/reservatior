import { useEffect, useRef } from 'react';
import { io, Socket } from 'socket.io-client';
import { useToast } from '@/hooks/use-toast';

export function useReservatiorEvents() {
  const socketRef = useRef<Socket | null>(null);
  const { toast } = useToast();

  useEffect(() => {
    // Connect to WebSocket Gateway (defaulting to 3002)
    const SOCKET_URL = process.env.NEXT_PUBLIC_WS_URL || 'http://localhost:3002';
    
    const socket = io(SOCKET_URL, {
      transports: ['websocket'],
      autoConnect: true,
    });

    socketRef.current = socket;

    socket.on('connect', () => {
      console.log('[useEvents] Connected to WebSocket Gateway');
    });

    // Listen to generic notification events from the Gateway
    socket.on('notification:new', (event: { type: string; payload: any }) => {
      console.log('[useEvents] notification:new received:', event);
      
      if (event.type === 'CommissionCreated') {
        const amount = event.payload.amount || event.payload.commissionAmount || 0;
        toast({
          title: "🎉 New Commission Available!",
          description: `You earned $${Number(amount).toLocaleString()} from Deal ${event.payload.dealId || event.payload.listingId || ''}. Would you like an early payout?`,
          variant: "default",
          duration: 8000,
        });
      }

      if (event.type === 'AD_GENERATED' || event.type === 'AdGenerated') {
        toast({
          title: "🤖 AI Ad Generated",
          description: `New creative generated for listing ${event.payload.listingId}. Check your inbox.`,
          variant: "default",
        });
      }
    });

    return () => {
      socket.disconnect();
    };
  }, [toast]);

  return {
    socket: socketRef.current
  };
}
