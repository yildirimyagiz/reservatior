import { useState, useCallback, useRef } from "react";

const API_URL = import.meta.env.VITE_API_URL || "http://localhost:3000";

/**
 * SSE event types emitted by the AI Search stream endpoint.
 */
export type AIStreamStage =
  | "stage:started"
  | "stage:intent"
  | "stage:properties"
  | "stage:analysis"
  | "stage:credits"
  | "stage:upsell"
  | "stage:complete"
  | "stage:error";

export interface AIStreamProperty {
  id: string;
  title: string;
  location: string;
  price: string;
  image: string;
  summary: string | null;
}

export interface AIStreamEvent {
  stage: AIStreamStage;
  data: any;
  timestamp: number;
}

export interface AIStreamState {
  isStreaming: boolean;
  currentStage: AIStreamStage | null;
  events: AIStreamEvent[];
  
  // Parsed progressive data
  filters: any | null;
  routeUsed: string | null;
  isDowngraded: boolean;
  properties: AIStreamProperty[];
  analysisText: string;
  creditsRemaining: number | null;
  costCharged: number;
  marketContext: any | null;
  isUpsellTriggered: boolean;
  upsellMessage: string | null;
  error: string | null;
  
  // Full final result
  completeResult: any | null;
}

const initialState: AIStreamState = {
  isStreaming: false,
  currentStage: null,
  events: [],
  filters: null,
  routeUsed: null,
  isDowngraded: false,
  properties: [],
  analysisText: "",
  creditsRemaining: null,
  costCharged: 0,
  marketContext: null,
  isUpsellTriggered: false,
  upsellMessage: null,
  error: null,
  completeResult: null,
};

/**
 * React hook for consuming SSE-based AI search results.
 * 
 * Usage:
 *   const { streamSearch, state, abort } = useAISearchStream();
 *   
 *   // Start streaming
 *   streamSearch("apartments in Istanbul under 50000");
 *   
 *   // Read progressive results
 *   state.properties   // updates as properties arrive
 *   state.analysisText // updates when AI text arrives
 *   state.currentStage // which stage we're at
 *   
 *   // Abort if needed
 *   abort();
 */
export function useAISearchStream() {
  const [state, setState] = useState<AIStreamState>(initialState);
  const abortRef = useRef<AbortController | null>(null);

  const abort = useCallback(() => {
    abortRef.current?.abort();
    setState(prev => ({ ...prev, isStreaming: false }));
  }, []);

  const streamSearch = useCallback(async (query: string) => {
    // Abort any existing stream
    abortRef.current?.abort();
    const controller = new AbortController();
    abortRef.current = controller;

    // Reset state
    setState({ ...initialState, isStreaming: true });

    try {
      const url = `${API_URL}/api/v1/ai-search/stream?query=${encodeURIComponent(query)}`;
      const response = await fetch(url, {
        signal: controller.signal,
        headers: { "Accept": "text/event-stream" }
      });

      if (!response.ok) {
        throw new Error(`Stream failed: ${response.status}`);
      }

      const reader = response.body?.getReader();
      if (!reader) throw new Error("No readable stream");

      const decoder = new TextDecoder();
      let buffer = "";

      while (true) {
        const { done, value } = await reader.read();
        if (done) break;

        buffer += decoder.decode(value, { stream: true });
        
        // Parse SSE events from buffer
        const lines = buffer.split("\n");
        buffer = lines.pop() || ""; // Keep incomplete line in buffer

        let currentEvent: string | null = null;
        let currentData: string = "";

        for (const line of lines) {
          if (line.startsWith("event: ")) {
            currentEvent = line.slice(7).trim();
          } else if (line.startsWith("data: ")) {
            currentData = line.slice(6).trim();
          } else if (line === "" && currentEvent && currentData) {
            // Complete event received
            try {
              const parsed = JSON.parse(currentData);
              const event: AIStreamEvent = {
                stage: currentEvent as AIStreamStage,
                data: parsed,
                timestamp: Date.now()
              };

              setState(prev => processEvent(prev, event));
            } catch (e) {
              console.warn("[AISearchStream] Failed to parse event:", currentData);
            }
            currentEvent = null;
            currentData = "";
          }
        }
      }

      // Stream finished
      setState(prev => ({ ...prev, isStreaming: false }));

    } catch (err: any) {
      if (err.name === "AbortError") return; // Intentional abort
      console.error("[AISearchStream] Error:", err);
      setState(prev => ({
        ...prev,
        isStreaming: false,
        error: err.message || "Connection failed"
      }));
    }
  }, []);

  return { streamSearch, state, abort };
}

/**
 * Process each SSE event into the accumulated state.
 */
function processEvent(prev: AIStreamState, event: AIStreamEvent): AIStreamState {
  const next = {
    ...prev,
    currentStage: event.stage,
    events: [...prev.events, event]
  };

  switch (event.stage) {
    case "stage:intent":
      next.filters = event.data.filters;
      next.routeUsed = event.data.routeUsed;
      next.isDowngraded = event.data.isDowngraded || false;
      break;

    case "stage:properties":
      next.properties = event.data.properties || [];
      break;

    case "stage:analysis":
      next.analysisText = event.data.text || "";
      next.marketContext = event.data.marketContext || null;
      break;

    case "stage:credits":
      next.creditsRemaining = event.data.creditsRemaining ?? null;
      next.costCharged = event.data.costCharged || 0;
      break;

    case "stage:upsell":
      next.isUpsellTriggered = true;
      next.upsellMessage = event.data.message || null;
      break;

    case "stage:complete":
      next.completeResult = event.data;
      break;

    case "stage:error":
      next.error = event.data.error || "Unknown error";
      break;
  }

  return next;
}
