import { Elysia, t } from "elysia";
import { authMiddleware, hasPermission } from "../middleware/auth";
import { financialAuditLogService } from "../services/financial-audit-log";

export const financialAuditLogRoutes = new Elysia({ prefix: "/financial-audit-log" })
  .use(authMiddleware)

  .post("/", async ({ body, set }) => {
    const data = await financialAuditLogService.log(body);
    set.status = 201;
    return { data };
  }, {
    body: t.Object({
      orgId: t.Optional(t.String()),
      action: t.String(),
      entityType: t.String(),
      entityId: t.String(),
      userId: t.Optional(t.String()),
      actorType: t.Optional(t.String()),
      amount: t.Optional(t.Number()),
      currency: t.Optional(t.String()),
      oldAmount: t.Optional(t.Number()),
      newAmount: t.Optional(t.Number()),
      oldStatus: t.Optional(t.String()),
      newStatus: t.Optional(t.String()),
      oldValues: t.Optional(t.Any()),
      newValues: t.Optional(t.Any()),
      reservationId: t.Optional(t.String()),
      leaseId: t.Optional(t.String()),
      escrowId: t.Optional(t.String()),
      paymentId: t.Optional(t.String()),
      ipAddress: t.Optional(t.String()),
      idempotencyKey: t.Optional(t.String()),
    }),
    beforeHandle: hasPermission("AUDIT_LOGS_VIEW"),
    detail: {
      summary: "Create Audit Log Entry",
      description: "Log a new financial audit trail entry",
      tags: ["Financial Audit"]
    }
  })

  .get("/entity/:entityType/:entityId", async ({ params }) => {
    return financialAuditLogService.getEntityAuditTrail(
      params.entityType,
      params.entityId
    );
  }, {
    params: t.Object({
      entityType: t.String(),
      entityId: t.String(),
    }),
    detail: {
      summary: "Get Entity Audit Trail",
      description: "Retrieve the audit trail for a specific entity",
      tags: ["Financial Audit"]
    }
  })

  .get("/org/:orgId", async ({ params, query }) => {
    return financialAuditLogService.getOrgAuditTrail(params.orgId, {
      action: query.action as string | undefined,
      entityType: query.entityType as string | undefined,
      from: query.from as string | undefined,
      to: query.to as string | undefined,
      page: parseInt(query.page as string) || 1,
      limit: parseInt(query.limit as string) || 20,
    });
  }, {
    params: t.Object({ orgId: t.String() }),
    query: t.Object({
      action: t.Optional(t.String()),
      entityType: t.Optional(t.String()),
      from: t.Optional(t.String()),
      to: t.Optional(t.String()),
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
    }),
    detail: {
      summary: "Get Organization Audit Trail",
      description: "Retrieve the financial audit trail for an organization with filtering and pagination",
      tags: ["Financial Audit"]
    }
  })

  .get("/org/:orgId/summary", async ({ params, query }) => {
    return financialAuditLogService.getFinancialSummary(params.orgId, {
      from: query.from as string | undefined,
      to: query.to as string | undefined,
    });
  }, {
    params: t.Object({ orgId: t.String() }),
    query: t.Object({
      from: t.Optional(t.String()),
      to: t.Optional(t.String()),
    }),
    detail: {
      summary: "Get Financial Summary",
      description: "Get a financial summary for an organization based on audit log data",
      tags: ["Financial Audit"]
    }
  })

  .post("/org/:orgId/verify", async ({ params, body }) => {
    return financialAuditLogService.verifyIntegrity(
      params.orgId,
      body.from,
      body.to
    );
  }, {
    params: t.Object({ orgId: t.String() }),
    body: t.Object({
      from: t.Optional(t.String()),
      to: t.Optional(t.String()),
    }),
    beforeHandle: hasPermission("AUDIT_LOGS_VIEW"),
    detail: {
      summary: "Verify Audit Integrity",
      description: "Verify the integrity of financial audit logs for an organization",
      tags: ["Financial Audit"]
    }
  });
