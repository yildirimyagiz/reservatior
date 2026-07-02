import api from '@/lib/api';
import { useEffect, useRef, useCallback } from 'react';


export interface TelemetryEvent {
  eventName: string;
  entityId: string;
  entityType: string;
  source: string;
  payload?: any;
}

/**
 * useTelemetry Hook
 * Provides an event-batching mechanism for the frontend to feed the AI Decision Graph.
 * Flushes events every 3 seconds or when the batch size hits 10.
 */
export function useTelemetry() {
  const eventQueue = useRef<TelemetryEvent[]>([]);
  const flushTimeout = useRef<number | null>(null);

  const flush = useCallback(async () => {
    if (eventQueue.current.length === 0) return;

    // Snapshot the current queue and clear it immediately
    const batch = [...eventQueue.current];
    eventQueue.current = [];

    if (flushTimeout.current) {
      clearTimeout(flushTimeout.current);
      flushTimeout.current = null;
    }

    try {
      // If we had a batch endpoint we could send the array.
      // For now, we fire them off in parallel to the telemetry API.
      await Promise.all(
        batch.map((event) => api.post('/telemetry/event', event))
      );
      console.log(`[Telemetry] Flushed ${batch.length} events to Decision Graph.`);
    } catch (error) {
      console.error('[Telemetry] Failed to send telemetry batch:', error);
      // Optional: push them back into the queue for a retry
      // eventQueue.current = [...batch, ...eventQueue.current];
    }
  }, []);

  const trackEvent = useCallback(
    (event: Omit<TelemetryEvent, 'source'>) => {
      eventQueue.current.push({ ...event, source: 'WEB_CLIENT' });

      // If we hit 10 events, flush immediately
      if (eventQueue.current.length >= 10) {
        flush();
      } else if (!flushTimeout.current) {
        // Otherwise, schedule a flush in 3 seconds
        flushTimeout.current = window.setTimeout(flush, 3000);
      }
    },
    [flush]
  );

  // Flush remaining events on unmount
  useEffect(() => {
    return () => {
      if (eventQueue.current.length > 0) {
        flush();
      }
    };
  }, [flush]);

  return { trackEvent, flush };
}
