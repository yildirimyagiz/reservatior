const SECURITY_OS_API_URL = process.env.SECURITY_OS_API_URL || "http://localhost:8081";
const SECURITY_OS_TIMEOUT = Number(process.env.SECURITY_OS_TIMEOUT || 4000);

export interface SecurityEngineHealth {
  status: string;
  version: string;
}

export interface SecurityEngineEvent {
  id: string;
  timestamp: string;
  category: string;
  action: string;
  severity: string;
  confidence: number;
  source: Record<string, any>;
  title: string;
  description: string;
  metadata: Record<string, any>;
  risk_score: number;
  mitre_tactic?: string | null;
  mitre_technique?: string | null;
  mitre_id?: string | null;
  tags: string[];
  tenant_id?: string | null;
}

export interface SecurityEngineStats {
  total_events: number;
  by_category: Record<string, number>;
  by_severity: Record<string, number>;
}

export class SecurityOsBridgeService {
  private baseUrl: string;
  private timeout: number;
  private engineOnline: boolean = false;
  private lastChecked: number = 0;

  constructor(baseUrl = SECURITY_OS_API_URL, timeout = SECURITY_OS_TIMEOUT) {
    this.baseUrl = baseUrl.replace(/\/$/, "");
    this.timeout = timeout;
  }

  async isOnline(): Promise<boolean> {
    const now = Date.now();
    if (now - this.lastChecked < 5000) return this.engineOnline;
    try {
      await this.health();
      this.engineOnline = true;
    } catch {
      this.engineOnline = false;
    }
    this.lastChecked = now;
    return this.engineOnline;
  }

  async health(): Promise<SecurityEngineHealth> {
    const res = await this.request("/api/health");
    return res as SecurityEngineHealth;
  }

  async getEvents(params: { limit?: number; category?: string } = {}): Promise<SecurityEngineEvent[]> {
    const qs = new URLSearchParams();
    if (params.limit) qs.set("limit", String(params.limit));
    if (params.category) qs.set("category", params.category);
    const res = await this.request(`/api/events${qs.toString() ? `?${qs}` : ""}`);
    return res as SecurityEngineEvent[];
  }

  async getStats(): Promise<SecurityEngineStats> {
    const res = await this.request("/api/stats");
    return res as SecurityEngineStats;
  }

  async getSeverityDistribution(): Promise<Record<string, number>> {
    const res = await this.request("/api/severity-distribution");
    return res as Record<string, number>;
  }

  async getEventById(id: string): Promise<SecurityEngineEvent | null> {
    try {
      const res = await this.request(`/api/events/${id}`);
      return res as SecurityEngineEvent;
    } catch {
      return null;
    }
  }

  /** Open a ReadableStream that relays the Rust engine's SSE feed. */
  stream(): ReadableStream<Uint8Array> {
    const controller = new AbortController();
    const baseUrl = this.baseUrl;
    return new ReadableStream<Uint8Array>({
      async start(streamController) {
        let res: Response;
        try {
          res = await fetch(`${baseUrl}/api/stream`, {
            signal: controller.signal,
            headers: { Accept: "text/event-stream" },
          });
        } catch (err: any) {
          streamController.enqueue(
            new TextEncoder().encode(
              `data: ${JSON.stringify({ type: "ERROR", message: `Security engine unreachable: ${err?.message ?? err}` })}\n\n`
            )
          );
          streamController.close();
          return;
        }

        if (!res.ok || !res.body) {
          streamController.enqueue(
            new TextEncoder().encode(
              `data: ${JSON.stringify({ type: "ERROR", message: `Security engine stream failed: ${res.status}` })}\n\n`
            )
          );
          streamController.close();
          return;
        }

        const reader = res.body.getReader();
        try {
          while (true) {
            const { done, value } = await reader.read();
            if (done) break;
            streamController.enqueue(value);
          }
        } catch (err: any) {
          streamController.enqueue(
            new TextEncoder().encode(
              `data: ${JSON.stringify({ type: "ERROR", message: `Stream interrupted: ${err?.message ?? err}` })}\n\n`
            )
          );
        } finally {
          reader.releaseLock();
          streamController.close();
        }
      },
      cancel() {
        controller.abort();
      },
    });
  }

  private async request(path: string): Promise<unknown> {
    const res = await fetch(`${this.baseUrl}${path}`, {
      signal: AbortSignal.timeout(this.timeout),
    });
    if (!res.ok) {
      throw new Error(`Security engine ${path} failed: ${res.status} ${res.statusText}`);
    }
    return res.json();
  }
}

export const securityOsBridgeService = new SecurityOsBridgeService();
