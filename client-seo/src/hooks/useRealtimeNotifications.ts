import { useBfcache } from '@/hooks/use-bfcache';
import { useEffect, useState, useCallback, useRef } from 'react';

export interface Notification {
  id: string;
  type: 'info' | 'success' | 'warning' | 'error';
  title: string;
  message: string;
  timestamp: Date;
  read: boolean;
  actionUrl?: string;
}

export function useRealtimeNotifications() {
  const [notifications, setNotifications] = useState<Notification[]>([]);
  const [isConnected, setIsConnected] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const eventSourceRef = useRef<EventSource | null>(null);

  const connect = useCallback(() => {
    if (eventSourceRef.current) {
      eventSourceRef.current.close();
    }

    const apiUrl = process.env.NEXT_PUBLIC_API_URL || '';
    const sseUrl = `${apiUrl}/api/v1/notifications/stream`;

    try {
      const eventSource = new EventSource(sseUrl);
      eventSourceRef.current = eventSource;

      eventSource.onopen = () => {
        setIsConnected(true);
        setError(null);
      };

      eventSource.onerror = (err) => {
        setIsConnected(false);
        setError('Connection failed');
        console.error('SSE connection error:', err);
      };

      eventSource.addEventListener('notification', (event) => {
        try {
          const data = JSON.parse(event.data);
          const notification: Notification = {
            id: data.id || Date.now().toString(),
            type: data.type || 'info',
            title: data.title || 'Notification',
            message: data.message || '',
            timestamp: new Date(data.timestamp || Date.now()),
            read: false,
            actionUrl: data.actionUrl,
          };
          setNotifications((prev) => [notification, ...prev]);
        } catch (parseError) {
          console.error('Failed to parse notification:', parseError);
        }
      });

      eventSource.addEventListener('heartbeat', () => {
        setIsConnected(true);
      });

    } catch (err) {
      setError('Failed to connect to notification server');
      console.error('SSE setup error:', err);
    }
  }, []);

  const disconnect = useCallback(() => {
    if (eventSourceRef.current) {
      eventSourceRef.current.close();
      eventSourceRef.current = null;
    }
    setIsConnected(false);
  }, []);

  const markAsRead = useCallback((id: string) => {
    setNotifications((prev) =>
      prev.map((n) => (n.id === id ? { ...n, read: true } : n))
    );
  }, []);

  const markAllAsRead = useCallback(() => {
    setNotifications((prev) => prev.map((n) => ({ ...n, read: true })));
  }, []);

  const clearNotifications = useCallback(() => {
    setNotifications([]);
  }, []);

  useBfcache(() => disconnect());

  useEffect(() => {
    connect();
    return () => {
      disconnect();
    };
  }, [connect, disconnect]);

  const unreadCount = notifications.filter((n) => !n.read).length;

  return {
    notifications,
    unreadCount,
    isConnected,
    error,
    markAsRead,
    markAllAsRead,
    clearNotifications,
    reconnect: connect,
  };
}
