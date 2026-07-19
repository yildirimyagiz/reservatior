import { Elysia, t } from "elysia";
import { authMiddleware, hasPermission } from "../middleware/auth";
import { incomeCertificateService } from "../services/income-certificate";

const publicCertificateRoutes = new Elysia({ prefix: "/certificates" })
  .get("/verify/:number", async ({ params, set }) => {
    const data = await incomeCertificateService.verify(params.number);
    if (!data) {
      set.status = 404;
      return { error: "Certificate not found" };
    }
    return { data };
  }, {
    params: t.Object({ number: t.String() }),
    detail: {
      summary: "Verify Certificate",
      description: "Public verification of an Income Ready Certificate",
      tags: ["Commerce OS"]
    }
  });

const authenticatedCertificateRoutes = new Elysia({ prefix: "/certificates" })
  .use(authMiddleware)

  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return incomeCertificateService.getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { createdAt: "desc" },
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
      tier: t.Optional(t.String()),
      status: t.Optional(t.String()),
      propertyId: t.Optional(t.String()),
    })),
    detail: {
      summary: "List Certificates",
      description: "List all Income Ready Certificates",
      tags: ["Commerce OS"]
    }
  })

  .get("/property/:propertyId", async ({ params }) => {
    return incomeCertificateService.getAll({
      where: { propertyId: params.propertyId },
      orderBy: { createdAt: "desc" },
    });
  }, {
    params: t.Object({ propertyId: t.String() }),
    detail: {
      summary: "Get Certificate by Property",
      description: "Get certificates for a specific property",
      tags: ["Commerce OS"]
    }
  })

  .get("/:id", async ({ params, set }) => {
    const data = await incomeCertificateService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Certificate not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() }),
    detail: {
      summary: "Get Certificate",
      description: "Get a single certificate by ID",
      tags: ["Commerce OS"]
    }
  })

  .post("/issue", async ({ body, set }) => {
    const data = await incomeCertificateService.issueCertificate(
      body.propertyId,
      body.tier,
      body.orgId
    );
    set.status = 201;
    return { data };
  }, {
    body: t.Object({
      propertyId: t.String(),
      tier: t.String(),
      orgId: t.String(),
    }),
    beforeHandle: hasPermission("COMMERCE_MANAGE"),
    detail: {
      summary: "Issue Certificate",
      description: "Issue an Income Ready Certificate for a property",
      tags: ["Commerce OS"]
    }
  })

  .patch("/:id/upgrade", async ({ params, body, set }) => {
    try {
      const data = await incomeCertificateService.upgradeTier(params.id, body.tier);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Certificate not found or upgrade failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({ tier: t.String() }),
    beforeHandle: hasPermission("COMMERCE_MANAGE"),
    detail: {
      summary: "Upgrade Certificate Tier",
      description: "Upgrade a certificate to a higher tier",
      tags: ["Commerce OS"]
    }
  });

export { publicCertificateRoutes, authenticatedCertificateRoutes as incomeCertificateRoutes };
