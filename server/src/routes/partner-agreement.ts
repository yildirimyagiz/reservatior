import { Elysia, t } from "elysia";
import { authMiddleware, hasPermission } from "../middleware/auth";
import { partnerAgreementService } from "../services/partner-agreement";

export const partnerAgreementRoutes = new Elysia({ prefix: "/partner-agreement" })
  .use(authMiddleware)

  /**
   * GET /partner-agreement/public
   * Returns generic/public tier pricing guidelines.
   */
  .get("/public", async () => {
    return {
      status: "success",
      tiers: [
        { name: "Basic Tiers", visible: true, dynamic: false },
        { name: "Enterprise Custom Tiers", visible: true, dynamic: true, description: "Requires secure agreement setup" }
      ]
    };
  })

  /**
   * GET /partner-agreement/stream
   * Stream partner agreement events and triggers (SSE).
   */
  .get("/stream", ({ set }) => {
    set.headers["content-type"] = "text/event-stream";
    set.headers["cache-control"] = "no-cache";
    set.headers["connection"] = "keep-alive";

    const stream = new ReadableStream({
      start(controller) {
        controller.enqueue(
          new TextEncoder().encode("data: " + JSON.stringify({ type: "SYSTEM", message: "SSE Yield Stream Connected" }) + "\n\n")
        );

        const interval = setInterval(() => {
          controller.enqueue(
            new TextEncoder().encode("data: " + JSON.stringify({ type: "HEARTBEAT", timestamp: Date.now() }) + "\n\n")
          );
        }, 15000);

        return () => {
          clearInterval(interval);
        };
      }
    });

    return new Response(stream);
  })

  /**
   * GET /partner-agreement/active
   * Retrieves the currently active Partner Agreement for the authenticated organization.
   */
  .get("/active", async ({ orgId, role, permissions, set }) => {
    if (!orgId) {
      set.status = 400;
      return { error: "No organization found for this user." };
    }

    const { prismaManager } = await import("../lib/prisma");
    const prisma = prismaManager.getClient() as any;

    const agreement = await prisma.partnerAgreement.findFirst({
      where: { tenantId: orgId },
      orderBy: { createdAt: "desc" }
    });

    if (!agreement) {
      return { data: null };
    }

    const isSuper = role === "SUPERADMIN" || role === "ADMIN";
    const canViewPrivate = permissions.includes("VIEW_PRIVATE_AGREEMENT") || isSuper;

    if (!canViewPrivate) {
      return {
        data: {
          id: agreement.id,
          tenantId: agreement.tenantId,
          status: agreement.status,
          createdAt: agreement.createdAt,
          updatedAt: agreement.updatedAt,
          encryptedTerms: "[PROTECTED: INSIGHTS & PRIVATE COMMISSIONS OBFUSCATED]"
        }
      };
    }

    // Decrypt if viewing private terms is authorized
    const decrypted = partnerAgreementService.decryptTerms(agreement.encryptedTerms);

    return {
      data: {
        id: agreement.id,
        tenantId: agreement.tenantId,
        status: agreement.status,
        createdAt: agreement.createdAt,
        updatedAt: agreement.updatedAt,
        terms: decrypted
      }
    };
  })

  /**
   * GET /partner-agreement/private/:id
   * Secure, tenant-isolated private contract details retrieval.
   * If user lacks VIEW_PRIVATE_AGREEMENT, masks the encrypted terms content.
   */
  .get("/private/:id", async ({ params, orgId, role, permissions, set }) => {
    if (!orgId) {
      set.status = 400;
      return { error: "No organization found for this user." };
    }

    const agreement = await partnerAgreementService.getById(params.id);
    if (!agreement) {
      set.status = 404;
      return { error: "Partner Agreement not found" };
    }

    // Hard Deny (cross-tenant direct access)
    const isSuper = role === "SUPERADMIN" || role === "ADMIN";
    if (agreement.tenantId !== orgId && !isSuper) {
      set.status = 403;
      return { error: "Forbidden: Cross-tenant access is strictly denied." };
    }

    // Check permission to view decrypted commercial terms
    const canViewPrivate = permissions.includes("VIEW_PRIVATE_AGREEMENT") || isSuper;
    
    if (!canViewPrivate) {
      // Masking the terms for secure masking
      return {
        data: {
          id: agreement.id,
          tenantId: agreement.tenantId,
          status: agreement.status,
          createdAt: agreement.createdAt,
          updatedAt: agreement.updatedAt,
          encryptedTerms: "[PROTECTED: INSIGHTS & PRIVATE COMMISSIONS OBFUSCATED]"
        }
      };
    }

    // Decrypt if viewing private terms is authorized
    const decrypted = partnerAgreementService.decryptTerms(agreement.encryptedTerms);

    return {
      data: {
        id: agreement.id,
        tenantId: agreement.tenantId,
        status: agreement.status,
        createdAt: agreement.createdAt,
        updatedAt: agreement.updatedAt,
        terms: decrypted
      }
    };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * POST /partner-agreement/transition/:id
   * Transitions agreement state.
   */
  .post("/transition/:id", async ({ params, body, orgId, set }) => {
    if (!orgId) {
      set.status = 400;
      return { error: "No organization found for this user." };
    }

    try {
      const updated = await partnerAgreementService.transitionState(params.id, body.nextState, orgId);
      return { data: updated };
    } catch (e: any) {
      set.status = 400;
      return { error: e.message || "State transition failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({ nextState: t.String() })
  })

  /**
   * POST /partner-agreement
   * Creates a new Partner Agreement with encrypted terms.
   */
  .post("/", async ({ body, orgId, userId, set }) => {
    if (!orgId) {
      set.status = 400;
      return { error: "No organization found for this user." };
    }

    // Encrypt the terms body
    const encryptedTerms = partnerAgreementService.encryptTerms(body.terms);

    const created = await partnerAgreementService.create({
      tenantId: orgId,
      userId: userId || "",
      status: "CREATED",
      encryptedTerms
    });

    set.status = 201;
    return { data: created };
  }, {
    body: t.Object({
      terms: t.Any()
    })
  });
