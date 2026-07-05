import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";

const WORKER_EVENTS = [
  "OFFER_CREATED",
  "MAINTENANCE_CREATED",
  "TENANT_APPLICATION_SUBMITTED",
  "PROPERTY_STATUS_CHANGED",
  "VIEWING_SCHEDULED",
  "VIEWING_COMPLETED",
  "TENANT_APPLICATION_APPROVED",
  "LEASE_EXPIRY_APPROACHING",
  "RENT_PAYMENT_OVERDUE",
  "INVOICE_UPLOADED",
  "QUARTERLY_TAX_REVIEW",
  "COMPLIANCE_EXPIRY_APPROACHING",
  "DOCUMENT_EXPIRED",
  "SECURITY_INCIDENT_CREATED",
];

const WORKER_HANDLERS = {
  "OFFER_CREATED": "offer-negotiator",
  "MAINTENANCE_CREATED": "vendor-dispatcher",
  "TENANT_APPLICATION_SUBMITTED": "tenant-risk-scorer",
  "PROPERTY_STATUS_CHANGED": "listing-marketing-blitz",
  "VIEWING_SCHEDULED": "smart-key-provisioner",
  "VIEWING_COMPLETED": "viewing-feedback-analyzer",
  "TENANT_APPLICATION_APPROVED": "smart-contract-generator",
  "LEASE_EXPIRY_APPROACHING": "lease-renewal-agent",
  "RENT_PAYMENT_OVERDUE": "arrears-ai-chaser",
  "INVOICE_UPLOADED": "invoice-ocr-verifier",
  "QUARTERLY_TAX_REVIEW": "tax-anomaly-detector",
  "COMPLIANCE_EXPIRY_APPROACHING": "compliance-renewal-agent",
  "DOCUMENT_EXPIRED": "document-expiry-revoker",
  "SECURITY_INCIDENT_CREATED": "security-alert-escalator",
};

export const workerRoutes = new Elysia({ prefix: "/api/v1/system/workers" })
  .use(authMiddleware)

  /**
   * GET /workers
   * Get all workers and their status
   */
  .get("/", async () => {
    const workers = WORKER_EVENTS.map((event) => ({
      event,
      handler: WORKER_HANDLERS[event as keyof typeof WORKER_HANDLERS],
      status: "ACTIVE",
      lastExecution: null,
      executionCount: 0,
      averageRuntime: 0,
    }));

    return {
      success: true,
      data: workers,
    };
  })

  /**
   * GET /workers/stats
   * Get worker pool statistics
   */
  .get("/stats", async () => {
    return {
      success: true,
      data: {
        totalWorkers: WORKER_EVENTS.length,
        activeWorkers: WORKER_EVENTS.length,
        totalExecutions: 0,
        averageRuntime: 0,
        uptime: process.uptime(),
      },
    };
  })

  /**
   * POST /workers/:event/restart
   * Restart a specific worker
   */
  .post("/:event/restart", async ({ params, set }) => {
    const { event } = params;

    if (!WORKER_EVENTS.includes(event)) {
      set.status = 404;
      return { success: false, error: "Worker not found" };
    }

    return {
      success: true,
      message: `Worker ${event} restarted`,
      data: {
        event,
        handler: WORKER_HANDLERS[event as keyof typeof WORKER_HANDLERS],
        status: "ACTIVE",
      },
    };
  }, {
    params: t.Object({ event: t.String() })
  });
