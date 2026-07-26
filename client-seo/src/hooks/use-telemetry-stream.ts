"use client";

import { useEffect, useRef, useCallback, useState } from 'react';
import { useGrowthEngineStore } from '@/lib/store/growth-engine-store';
import type { TelemetryEvent } from '@/types/growth-engine';

export function useTelemetryStream(orgId: string, enabled = true) {
  const { appendLiveEvent, addTelemetryEvent } = useGrowthEngineStore();
  const eventSourceRef = useRef<EventSource | null>(null);
  const [connected, setConnected] = useState(false);

  const connect = useCallback(() => {
    if (!enabled || !orgId) return;
    const url = `${typeof window !== 'undefined' ? window.location.origin : ''}/api/telemetry/stream?orgId=${orgId}`;
    const es = new EventSource(url);
    eventSourceRef.current = es;

    es.onmessage = (event) => {
      try {
        const data: TelemetryEvent = JSON.parse(event.data);
        appendLiveEvent(data);
        addTelemetryEvent(data);
      } catch { /* ignore malformed */ }
    };

    es.onerror = () => {
      setConnected(false);
      es.close();
      setTimeout(connect, 5000);
    };

    es.onopen = () => setConnected(true);
  }, [orgId, enabled, appendLiveEvent, addTelemetryEvent]);

  useEffect(() => {
    connect();
    return () => {
      eventSourceRef.current?.close();
      setConnected(false);
    };
  }, [connect]);

  return { connected };
}
