"use client";

import { useState, useCallback, useRef } from 'react';

export type AIStreamEvent = 
  | { type: 'stage:started'; data: { message: string; query: string; timestamp: string } }
  | { type: 'stage:intent'; data: { filters: Record<string, unknown>; routeUsed: string; isDowngraded: boolean } }
  | { type: 'stage:properties'; data: { count: number; properties: unknown[] } }
  | { type: 'stage:analysis'; data: { text: string; marketContext: Record<string, unknown> } }
  | { type: 'stage:credits'; data: { creditsRemaining?: number; costCharged?: number } }
  | { type: 'stage:upsell'; data: { message: string; requiresTopUp: boolean } }
  | { type: 'stage:complete'; data: Record<string, unknown> }
  | { type: 'stage:error'; data: { error: string } };

export function useAIStreamSearch() {
  const [isStreaming, setIsStreaming] = useState(false);
  const [events, setEvents] = useState<AIStreamEvent[]>([]);
  const [error, setError] = useState<string | null>(null);
  const abortControllerRef = useRef<AbortController | null>(null);

  const streamSearch = useCallback(async (query: string) => {
    if (!query.trim()) {
      setError('Query is required');
      return;
    }

    setIsStreaming(true);
    setError(null);
    setEvents([]);
    
    abortControllerRef.current = new AbortController();

    try {
      const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3000';
      const response = await fetch(
        `${API_URL}/api/v1/ai-search/stream?query=${encodeURIComponent(query)}`,
        {
          signal: abortControllerRef.current.signal,
          headers: {
            'Accept': 'text/event-stream',
            'Cache-Control': 'no-cache',
          },
        }
      );

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }

      const reader = response.body?.getReader();
      const decoder = new TextDecoder();

      if (!reader) {
        throw new Error('No response body');
      }

      let buffer = '';

      while (true) {
        const { done, value } = await reader.read();
        
        if (done) break;

        buffer += decoder.decode(value, { stream: true });
        
        const lines = buffer.split('\n');
        buffer = lines.pop() || '';

        for (const line of lines) {
          if (line.startsWith('event: ')) {
            const eventType = line.slice(7);
            const nextLine = lines[lines.indexOf(line) + 1];
            
            if (nextLine?.startsWith('data: ')) {
              try {
                const data = JSON.parse(nextLine.slice(6));
                setEvents(prev => [...prev, { type: eventType as AIStreamEvent['type'], data }]);
              } catch (e) {
                console.error('Failed to parse SSE data:', e);
              }
            }
          }
        }
      }

      setIsStreaming(false);
    } catch (err: unknown) {
      if (err instanceof Error && err.name === 'AbortError') {
        console.log('Stream aborted');
      } else {
        const errorMessage = err instanceof Error ? err.message : 'Search failed';
        setError(errorMessage);
        setEvents(prev => [...prev, { type: 'stage:error', data: { error: errorMessage } }]);
      }
      setIsStreaming(false);
    }
  }, []);

  const abort = useCallback(() => {
    abortControllerRef.current?.abort();
    setIsStreaming(false);
  }, []);

  const reset = useCallback(() => {
    setEvents([]);
    setError(null);
    setIsStreaming(false);
  }, []);

  return {
    isStreaming,
    events,
    error,
    streamSearch,
    abort,
    reset,
  };
}
