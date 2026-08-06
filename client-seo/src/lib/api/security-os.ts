import { getLocalizationHeaders } from "./localization-helper";

async function unwrap<T>(res: Response): Promise<T> {
  if (!res.ok) throw new Error(`Security OS API error: ${res.status}`);
  const json = await res.json();
  return (json.data ?? json) as T;
}

export const securityOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/security-os/dashboard?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    return unwrap<{
      securityScore: number;
      activeThreats: number;
      resolvedIncidents: number;
      compliance: number;
      kycStats?: any;
      fraudAlerts?: any[];
      recentAudits?: any[];
      activePolicies?: any[];
    }>(res);
  },

  getThreatTrends: async (orgId: string) => {
    const res = await fetch(`/api/v1/security-os/threat-trends?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    return unwrap<{ month: string; threats: number }[]>(res);
  },

  getSecurityEvents: async (orgId: string) => {
    const res = await fetch(`/api/v1/security-os/security-events?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    return unwrap<{ type: string; count: number }[]>(res);
  },

  // ─── KYC ────────────────────────────────────────────────────
  listKyc: async (orgId: string, params?: { status?: string; page?: number; limit?: number }) => {
    const qs = new URLSearchParams({ orgId: orgId || "", ...(params as any) });
    const res = await fetch(`/api/v1/security-os/kyc?${qs}`, { headers: getLocalizationHeaders() });
    return unwrap(res);
  },
  submitKyc: async (data: { userId: string; orgId: string; documentType: string; documentNumber?: string; documentUrl?: string }) => {
    const res = await fetch(`/api/v1/security-os/kyc`, {
      method: "POST",
      headers: { "Content-Type": "application/json", ...getLocalizationHeaders() },
      body: JSON.stringify(data),
    });
    return unwrap(res);
  },
  approveKyc: async (id: string) => {
    const res = await fetch(`/api/v1/security-os/kyc/${id}/approve`, {
      method: "POST",
      headers: getLocalizationHeaders(),
    });
    return unwrap(res);
  },
  rejectKyc: async (id: string, reason?: string) => {
    const res = await fetch(`/api/v1/security-os/kyc/${id}/reject`, {
      method: "POST",
      headers: { "Content-Type": "application/json", ...getLocalizationHeaders() },
      body: JSON.stringify({ reason }),
    });
    return unwrap(res);
  },

  // ─── Fraud Detection ────────────────────────────────────────
  listFraud: async (orgId: string) => {
    const res = await fetch(`/api/v1/security-os/fraud?orgId=${orgId}`, { headers: getLocalizationHeaders() });
    return unwrap(res);
  },
  flagFraud: async (data: { orgId: string; entityType: string; entityId: string; riskLevel: string; description: string }) => {
    const res = await fetch(`/api/v1/security-os/fraud/flag`, {
      method: "POST",
      headers: { "Content-Type": "application/json", ...getLocalizationHeaders() },
      body: JSON.stringify(data),
    });
    return unwrap(res);
  },
  resolveFraud: async (id: string, resolution: string) => {
    const res = await fetch(`/api/v1/security-os/fraud/${id}/resolve`, {
      method: "POST",
      headers: { "Content-Type": "application/json", ...getLocalizationHeaders() },
      body: JSON.stringify({ resolution }),
    });
    return unwrap(res);
  },

  // ─── Audit Log ──────────────────────────────────────────────
  listAudits: async (orgId: string, params?: { page?: number; limit?: number }) => {
    const qs = new URLSearchParams({ orgId: orgId || "", ...(params as any) });
    const res = await fetch(`/api/v1/security-os/audit?${qs}`, { headers: getLocalizationHeaders() });
    return unwrap(res);
  },
  logAudit: async (data: { orgId: string; userId: string; action: string; resource: string; resourceId?: string; ipAddress?: string }) => {
    const res = await fetch(`/api/v1/security-os/audit/log`, {
      method: "POST",
      headers: { "Content-Type": "application/json", ...getLocalizationHeaders() },
      body: JSON.stringify(data),
    });
    return unwrap(res);
  },

  // ─── Security Policies ──────────────────────────────────────
  listPolicies: async (orgId: string) => {
    const res = await fetch(`/api/v1/security-os/policies?orgId=${orgId}`, { headers: getLocalizationHeaders() });
    return unwrap(res);
  },
  createPolicy: async (data: { orgId: string; name: string; policyType: string; description?: string }) => {
    const res = await fetch(`/api/v1/security-os/policies`, {
      method: "POST",
      headers: { "Content-Type": "application/json", ...getLocalizationHeaders() },
      body: JSON.stringify(data),
    });
    return unwrap(res);
  },
  togglePolicy: async (id: string, isActive: boolean) => {
    const res = await fetch(`/api/v1/security-os/policies/${id}/toggle`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json", ...getLocalizationHeaders() },
      body: JSON.stringify({ isActive }),
    });
    return unwrap(res);
  },

  // ─── Rust Security Engine Bridge ─────────────────────────────
  engineHealth: async () => {
    const res = await fetch(`/api/v1/security-engine/health`, { headers: getLocalizationHeaders() });
    return unwrap<{ status: string; version: string; online: boolean }>(res);
  },
  engineStats: async () => {
    const res = await fetch(`/api/v1/security-engine/stats`, { headers: getLocalizationHeaders() });
    return unwrap<{ total_events: number; by_category: Record<string, number>; by_severity: Record<string, number> }>(res);
  },
  engineSeverity: async () => {
    const res = await fetch(`/api/v1/security-engine/severity-distribution`, { headers: getLocalizationHeaders() });
    return unwrap<{ informational: number; low: number; medium: number; high: number; critical: number }>(res);
  },
  engineEvents: async (limit = 50, category?: string) => {
    const qs = new URLSearchParams({ limit: String(limit) });
    if (category) qs.set("category", category);
    const res = await fetch(`/api/v1/security-engine/events?${qs}`, { headers: getLocalizationHeaders() });
    return unwrap<any[]>(res);
  },
  engineEventById: async (id: string) => {
    const res = await fetch(`/api/v1/security-engine/events/${id}`, { headers: getLocalizationHeaders() });
    return unwrap<any>(res);
  },
  engineStreamUrl: () => `/api/v1/security-engine/stream`,
};
