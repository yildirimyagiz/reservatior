import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { regionMiddleware } from "../middleware/region";
import { securityOsBridgeService } from "../services/security-os-bridge";
import { WormAuditLogService } from "../services/worm-audit-log-service";
import { SecretKmsVaultService } from "../services/secret-kms-vault-service";
import { AiTrustedPipelineService } from "../services/ai-trusted-pipeline-service";
import { RuntimeIntegrityService } from "../services/runtime-integrity-service";

export const securityEngineRoutes = new Elysia({ prefix: "/security-engine" })
  .use(authMiddleware)
  .use(regionMiddleware)

  .get("/health", async ({ set }) => {
    try {
      const data = await securityOsBridgeService.health();
      return { success: true, data: { ...data, online: true } };
    } catch (error: any) {
      return {
        success: false,
        data: { status: "offline", online: false, error: error.message },
      };
    }
  }, {
    detail: { summary: "Security Engine Health", tags: ["Security OS"] },
  })

  .get("/events", async ({ query, set }) => {
    try {
      const limit = parseInt((query as any).limit || "50");
      const category = (query as any).category;
      const data = await securityOsBridgeService.getEvents({
        limit: Math.min(Math.max(limit, 1), 1000),
        category,
      });
      return { success: true, data };
    } catch (error: any) {
      set.status = 502;
      return { success: false, error: `Security engine unreachable: ${error.message}` };
    }
  }, {
    query: t.Object({
      limit: t.Optional(t.String()),
      category: t.Optional(t.String()),
    }),
    detail: { summary: "Security Engine Events", tags: ["Security OS"] },
  })

  .get("/events/:id", async ({ params, set }) => {
    try {
      const data = await securityOsBridgeService.getEventById(params.id);
      if (!data) {
        set.status = 404;
        return { success: false, error: "Event not found" };
      }
      return { success: true, data };
    } catch (error: any) {
      set.status = 502;
      return { success: false, error: `Security engine unreachable: ${error.message}` };
    }
  }, {
    params: t.Object({ id: t.String() }),
    detail: { summary: "Security Engine Event by ID", tags: ["Security OS"] },
  })

  .get("/stats", async ({ set }) => {
    try {
      const data = await securityOsBridgeService.getStats();
      return { success: true, data };
    } catch (error: any) {
      set.status = 502;
      return { success: false, error: `Security engine unreachable: ${error.message}` };
    }
  }, {
    detail: { summary: "Security Engine Stats", tags: ["Security OS"] },
  })

  .get("/severity-distribution", async ({ set }) => {
    try {
      const data = await securityOsBridgeService.getSeverityDistribution();
      return { success: true, data };
    } catch (error: any) {
      set.status = 502;
      return { success: false, error: `Security engine unreachable: ${error.message}` };
    }
  }, {
    detail: { summary: "Security Engine Severity Distribution", tags: ["Security OS"] },
  })

  .get("/stream", ({ set }) => {
    set.headers["content-type"] = "text/event-stream";
    set.headers["cache-control"] = "no-cache";
    set.headers["connection"] = "keep-alive";

    const stream = securityOsBridgeService.stream();
    return new Response(stream);
  }, {
    detail: { summary: "Security Engine Live Stream (SSE)", description: "Relays the Rust security engine's real-time event feed", tags: ["Security OS"] },
  })

  .get("/integrity", async () => {
    const data = await RuntimeIntegrityService.getInstance().diagnoseRuntimeIntegrity();
    return { success: true, data };
  }, {
    detail: { summary: "Host Runtime Integrity Diagnostics (TPM / IMA / dm-verity)", tags: ["Enterprise Security"] },
  })

  .get("/audit/verify-worm", async () => {
    const data = await WormAuditLogService.getInstance().verifyLedgerIntegrity();
    return { success: true, data };
  }, {
    detail: { summary: "Verify Tamper-Evident WORM Audit Trail & Merkle Root", tags: ["Enterprise Security"] },
  })

  .get("/kms/diagnostics", () => {
    const data = SecretKmsVaultService.getInstance().getVaultDiagnostics();
    return { success: true, data };
  }, {
    detail: { summary: "Secret Management Vault & Envelope Encryption Status", tags: ["Enterprise Security"] },
  })

  .post("/ai-pipeline/validate", async ({ body, set }) => {
    try {
      const b = body as any;
      const report = await AiTrustedPipelineService.getInstance().validateAiPipeline(
        b.tenantId || "SYSTEM",
        b.modelId || "NOVA_ROADX_DEFAULT_MODEL",
        b.datasetPayload || {},
        b.provenanceSignature || "",
        b.featureVectors
      );
      return { success: report.isApproved, report };
    } catch (error: any) {
      set.status = 400;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      tenantId: t.Optional(t.String()),
      modelId: t.Optional(t.String()),
      datasetPayload: t.Optional(t.Any()),
      provenanceSignature: t.Optional(t.String()),
      featureVectors: t.Optional(t.Array(t.Number())),
    }),
    detail: { summary: "Validate AI Trusted Pipeline & Provenance Signatures", tags: ["Enterprise Security"] },
  });
