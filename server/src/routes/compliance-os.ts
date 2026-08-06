import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";
import { complianceRuleService, ComplianceCategory, ComplianceSeverity } from "../services/compliance/compliance-rule.service";

/**
 * Compliance OS - Country-specific rental regulations
 * Handles rental law, tax, payment regulation, contract rules, and policy enforcement
 * across 23 countries (US, TR, AE, GB, DE, FR, ES, IT, NL, etc.)
 */
export const complianceOSRoutes = new Elysia({
  prefix: "/api/v1/compliance-os",
})
  // Get active compliance rules for a country
  .get("/rules/:country", async ({ params, query }) => {
    try {
      const rules = await complianceRuleService.getActiveRules(
        params.country,
        query.category as ComplianceCategory
      );
      return { success: true, rules };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ country: t.String() }),
    query: t.Object({ category: t.Optional(t.String()) }),
    detail: { summary: "Get Compliance Rules", tags: ["Compliance OS"] },
  })

  // Check compliance for a rental transaction
  .post("/check/:country", async ({ params, body }) => {
    try {
      const checks = await complianceRuleService.checkRentalCompliance(
        params.country,
        body
      );
      return { success: true, checks };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ country: t.String() }),
    body: t.Object({
      depositAmount: t.Number(),
      monthlyRent: t.Number(),
      leaseDuration: t.Number(),
      noticePeriod: t.Number(),
      rentalIncome: t.Number(),
      taxRate: t.Number(),
      paymentMethod: t.String(),
      paymentFrequency: t.String(),
      contractType: t.String(),
      hasDigitalSignature: t.Boolean(),
      hasRequiredClauses: t.Optional(t.Array(t.String())),
    }),
    detail: { summary: "Check Rental Compliance", tags: ["Compliance OS"] },
  })

  // Create a new compliance rule
  .post("/rules", async ({ body }) => {
    try {
      const rule = await complianceRuleService.createRule({
        country: body.country,
        region: body.region,
        category: body.category as ComplianceCategory,
        ruleKey: body.ruleKey,
        description: body.description,
        severity: body.severity as ComplianceSeverity,
        isActive: body.isActive ?? true,
        effectiveFrom: body.effectiveFrom ? new Date(body.effectiveFrom) : new Date(),
        effectiveTo: body.effectiveTo ? new Date(body.effectiveTo) : undefined,
        metadata: body.metadata,
      });
      return { success: true, rule };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      country: t.String(),
      region: t.Optional(t.String()),
      category: t.String(),
      ruleKey: t.String(),
      description: t.String(),
      severity: t.String(),
      isActive: t.Optional(t.Boolean()),
      effectiveFrom: t.Optional(t.String()),
      effectiveTo: t.Optional(t.String()),
      metadata: t.Optional(t.Any()),
    }),
    detail: { summary: "Create Compliance Rule", tags: ["Compliance OS"] },
  })

  // Update a compliance rule
  .put("/rules/:id", async ({ params, body }) => {
    try {
      const updateData: any = {};
      if (body.country !== undefined) updateData.country = body.country;
      if (body.region !== undefined) updateData.region = body.region;
      if (body.category !== undefined) updateData.category = body.category as ComplianceCategory;
      if (body.ruleKey !== undefined) updateData.ruleKey = body.ruleKey;
      if (body.description !== undefined) updateData.description = body.description;
      if (body.severity !== undefined) updateData.severity = body.severity as ComplianceSeverity;
      if (body.isActive !== undefined) updateData.isActive = body.isActive;
      if (body.effectiveFrom !== undefined) updateData.effectiveFrom = new Date(body.effectiveFrom);
      if (body.effectiveTo !== undefined) updateData.effectiveTo = new Date(body.effectiveTo);
      if (body.metadata !== undefined) updateData.metadata = body.metadata;
      
      const rule = await complianceRuleService.updateRule(params.id, updateData);
      return { success: true, rule };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      country: t.Optional(t.String()),
      region: t.Optional(t.String()),
      category: t.Optional(t.String()),
      ruleKey: t.Optional(t.String()),
      description: t.Optional(t.String()),
      severity: t.Optional(t.String()),
      isActive: t.Optional(t.Boolean()),
      effectiveFrom: t.Optional(t.String()),
      effectiveTo: t.Optional(t.String()),
      metadata: t.Optional(t.Any()),
    }),
    detail: { summary: "Update Compliance Rule", tags: ["Compliance OS"] },
  })

  // Delete a compliance rule
  .delete("/rules/:id", async ({ params }) => {
    try {
      await complianceRuleService.deleteRule(params.id);
      return { success: true, message: "Rule deleted" };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    detail: { summary: "Delete Compliance Rule", tags: ["Compliance OS"] },
  })

  // Get compliance summary for a country
  .get("/summary/:country", async ({ params }) => {
    try {
      const summary = await complianceRuleService.getComplianceSummary(params.country);
      return { success: true, summary };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ country: t.String() }),
    detail: { summary: "Get Compliance Summary", tags: ["Compliance OS"] },
  })

  // Get compliance dashboard
  .get("/dashboard", async ({ query }) => {
    try {
      const where: any = {};
      if (query.orgId) where.orgId = query.orgId;

      const [rules, checks] = await Promise.all([
        prisma.complianceRule.findMany({
          where: { isActive: true },
          take: 100,
        }),
        prisma.complianceRuleCheck.findMany({
          where,
          orderBy: { checkedAt: "desc" },
          take: 50,
        }),
      ]);

      const totalRules = rules.length;
      const byCountry = rules.reduce((acc: Record<string, number>, r: any) => {
        acc[r.country] = (acc[r.country] || 0) + 1;
        return acc;
      }, {} as Record<string, number>);

      const passedChecks = checks.filter((c: any) => c.passed).length;
      const failedChecks = checks.filter((c: any) => !c.passed).length;
      const criticalIssues = checks.filter((c: any) => !c.passed && c.severity === "CRITICAL").length;

      return {
        kpis: {
          totalRules,
          countriesCovered: Object.keys(byCountry).length,
          totalChecks: checks.length,
          passedChecks,
          failedChecks,
          passRate: checks.length > 0 ? Math.round((passedChecks / checks.length) * 100) : 100,
          criticalIssues,
        },
        recentActivity: checks.slice(0, 10).map((c: any) => ({
          id: c.id,
          title: `${c.entityType} compliance check`,
          subtitle: c.passed ? "Passed" : "Failed",
          value: c.severity,
          timeAgo: c.checkedAt.toISOString(),
        })),
        alerts: [
          ...criticalIssues > 0
            ? [{ type: "error" as const, title: `${criticalIssues} critical issue(s)`, message: "Immediate attention required" }]
            : [],
          ...failedChecks > 5
            ? [{ type: "warning" as const, title: `${failedChecks} failed check(s)`, message: "Review compliance issues" }]
            : [],
        ],
      };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.Optional(t.String()) }),
    detail: { summary: "Compliance Dashboard", tags: ["Compliance OS"] },
  });
