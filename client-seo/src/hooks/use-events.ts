import { useEffect, useRef } from 'react';
import type { Socket } from 'socket.io-client';
import { useToast } from '@/hooks/use-toast';

export function useReservatiorEvents() {
  const socketRef = useRef<Socket | null>(null);
  const { toast } = useToast();

  useEffect(() => {
    let cancelled = false;
    const SOCKET_URL = process.env.NEXT_PUBLIC_WS_URL || 'http://localhost:3002';
    let socket: Socket | null = null;

    import('socket.io-client').then(({ io }) => {
      if (cancelled) return;
      socket = io(SOCKET_URL, {
        transports: ['websocket'],
        autoConnect: true,
      });

      socketRef.current = socket;

      socket.on('connect', () => {
        console.log('[useEvents] Connected to WebSocket Gateway');
      });

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
    });

    return () => {
      cancelled = true;
      socketRef.current?.disconnect();
      socket?.disconnect();
    };
  }, [toast]);

  return {
    socket: socketRef.current
  };
}
