import { Elysia, t } from "elysia";
import { kycVerificationService } from "../services/kyc-verification-service";
import { fraudDetectionService } from "../services/fraud-detection-service";
import { accessAuditService } from "../services/access-audit-service";
import { securityPolicyService } from "../services/security-policy-service";

export const securityOSRoutes = new Elysia({ prefix: "/security-os" })

  .get("/dashboard", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }

      const [kycStats, fraudAlerts, recentAudits, activePolicies, allPolicies] = await Promise.all([
        kycVerificationService.getStats(orgId).catch(() => ({ total: 0, byStatus: [] })),
        fraudDetectionService.getActiveAlerts(orgId).catch(() => []),
        accessAuditService.getRecentActivity(orgId, 10).catch(() => []),
        securityPolicyService.getActivePolicies(orgId).catch(() => []),
        securityPolicyService.getByOrg(orgId).catch(() => []),
      ]);

      const activeThreats = fraudAlerts.filter((f: any) => f.status !== "RESOLVED").length;
      const resolvedIncidents = fraudAlerts.filter((f: any) => f.status === "RESOLVED").length;
      const policyCount = allPolicies.length || 1;
      const compliance = Math.round((activePolicies.length / policyCount) * 100);
      const securityScore = Math.max(
        0,
        Math.min(100, 100 - activeThreats * 5 + (kycStats.total ? 10 : 0) - (compliance < 60 ? 15 : 0))
      );

      return {
        success: true,
        data: {
          securityScore,
          activeThreats,
          resolvedIncidents,
          compliance,
          kycStats,
          fraudAlerts,
          recentAudits,
          activePolicies,
        },
      };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "Security OS Dashboard", tags: ["Security OS"] },
  })

  .get("/threat-trends", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }

      const [fraudAlerts, audits] = await Promise.all([
        fraudDetectionService.getActiveAlerts(orgId).catch(() => []),
        accessAuditService.getByOrg(orgId, { take: 1000 }).catch(() => []),
      ]);

      const months: { month: string; threats: number }[] = [];
      const now = new Date();
      for (let i = 5; i >= 0; i--) {
        const d = new Date(now.getFullYear(), now.getMonth() - i, 1);
        const key = `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}`;
        const monthLabel = d.toLocaleString("en-US", { month: "short" });
        const fraudCount = fraudAlerts.filter((f: any) => {
          const c = new Date(f.createdAt);
          return `${c.getFullYear()}-${String(c.getMonth() + 1).padStart(2, "0")}` === key;
        }).length;
        const auditCount = audits.filter((a: any) => {
          const c = new Date(a.createdAt);
          return `${c.getFullYear()}-${String(c.getMonth() + 1).padStart(2, "0")}` === key;
        }).length;
        months.push({ month: monthLabel, threats: fraudCount + auditCount });
      }

      return { success: true, data: months };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "Security Threat Trends", tags: ["Security OS"] },
  })

  .get("/security-events", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }

      const audits = await accessAuditService.getByOrg(orgId, { take: 2000 }).catch(() => []);

      const byType: Record<string, number> = {};
      for (const a of audits) {
        const type = a.action || a.resource || "unknown";
        byType[type] = (byType[type] || 0) + 1;
      }

      const data = Object.entries(byType)
        .map(([type, count]) => ({ type, count }))
        .sort((a, b) => b.count - a.count)
        .slice(0, 12);

      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "Security Events Breakdown", tags: ["Security OS"] },
  })

  .get("/kyc", async ({ query, set }) => {
    try {
      const { orgId, status, page, limit } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await kycVerificationService.getByOrg(orgId, {
        skip: ((parseInt(page as string) || 1) - 1) * (parseInt(limit as string) || 20),
        take: parseInt(limit as string) || 20,
        status: status as string,
      });
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({
      orgId: t.String(),
      status: t.Optional(t.String()),
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
    }),
    detail: { summary: "List KYC Verifications", tags: ["Security OS"] },
  })

  .post("/kyc", async ({ body, set }) => {
    try {
      const data = await kycVerificationService.submitVerification(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      userId: t.String(),
      orgId: t.String(),
      documentType: t.String(),
      documentNumber: t.Optional(t.String()),
      documentUrl: t.Optional(t.String()),
    }),
    detail: { summary: "Submit KYC Verification", tags: ["Security OS"] },
  })

  .post("/kyc/:id/approve", async ({ params, set }) => {
    try {
      const data = await kycVerificationService.approveVerification(params.id);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    detail: { summary: "Approve KYC", tags: ["Security OS"] },
  })

  .post("/kyc/:id/reject", async ({ params, body, set }) => {
    try {
      const { reason } = body as any;
      const data = await kycVerificationService.rejectVerification(params.id, reason);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({ reason: t.Optional(t.String()) }),
    detail: { summary: "Reject KYC", tags: ["Security OS"] },
  })

  .get("/fraud", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await fraudDetectionService.getActiveAlerts(orgId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "Get Fraud Alerts", tags: ["Security OS"] },
  })

  .post("/fraud/flag", async ({ body, set }) => {
    try {
      const data = await fraudDetectionService.flagSuspiciousActivity(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      entityType: t.String(),
      entityId: t.String(),
      riskLevel: t.String(),
      description: t.String(),
    }),
    detail: { summary: "Flag Suspicious Activity", tags: ["Security OS"] },
  })

  .post("/fraud/:id/resolve", async ({ params, body, set }) => {
    try {
      const { resolution } = body as any;
      const data = await fraudDetectionService.resolveAlert(params.id, resolution);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({ resolution: t.String() }),
    detail: { summary: "Resolve Fraud Alert", tags: ["Security OS"] },
  })

  .get("/audit", async ({ query, set }) => {
    try {
      const { orgId, page, limit } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await accessAuditService.getByOrg(orgId, {
        skip: ((parseInt(page as string) || 1) - 1) * (parseInt(limit as string) || 20),
        take: parseInt(limit as string) || 20,
      });
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({
      orgId: t.String(),
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
    }),
    detail: { summary: "Get Access Audit Logs", tags: ["Security OS"] },
  })

  .post("/audit/log", async ({ body, set }) => {
    try {
      const data = await accessAuditService.logAccess(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      userId: t.String(),
      action: t.String(),
      resource: t.String(),
      resourceId: t.Optional(t.String()),
      ipAddress: t.Optional(t.String()),
    }),
    detail: { summary: "Log Access Event", tags: ["Security OS"] },
  })

  .get("/policies", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await securityPolicyService.getByOrg(orgId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "List Security Policies", tags: ["Security OS"] },
  })

  .post("/policies", async ({ body, set }) => {
    try {
      const data = await securityPolicyService.createPolicy(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      name: t.String(),
      description: t.Optional(t.String()),
      policyType: t.String(),
    }),
    detail: { summary: "Create Security Policy", tags: ["Security OS"] },
  })

  .patch("/policies/:id/toggle", async ({ params, body, set }) => {
    try {
      const { isActive } = body as any;
      const data = await securityPolicyService.togglePolicy(params.id, isActive);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({ isActive: t.Boolean() }),
    detail: { summary: "Toggle Security Policy", tags: ["Security OS"] },
  });
