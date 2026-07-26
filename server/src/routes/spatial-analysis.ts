import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { regionMiddleware } from "../middleware/region";

// ─── Spatial Analysis ─────────────────────────────────────────

export const spatialAnalysisRoutes = new Elysia({ prefix: "/spatial-analysis" })
  .use(authMiddleware)
  .use(regionMiddleware)

  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    if (orgId) where.orgId = orgId;

    const skip = (parseInt(page) - 1) * parseInt(limit);
    const take = parseInt(limit);

    const [data, total] = await Promise.all([
      (db as any).spatialAnalysis.findMany({
        where,
        skip,
        take,
        orderBy: { createdAt: "desc" },
      }),
      (db as any).spatialAnalysis.count({ where }),
    ]);

    return { data, total, page: parseInt(page), limit: take };
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
      propertyId: t.Optional(t.String()),
      status: t.Optional(t.String()),
    })),
  })

  .get("/:id", async ({ db, params, set }) => {
    const data = await (db as any).spatialAnalysis.findUnique({
      where: { id: params.id },
      include: {
        roomAnalyses: true,
        spatialAssets: true,
      },
    });
    if (!data) {
      set.status = 404;
      return { error: "SpatialAnalysis not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() }),
  })

  .post("/", async ({ orgId, db, body, set }) => {
    const data = await (db as any).spatialAnalysis.create({
      data: {
        orgId,
        propertyId: body.propertyId,
        status: "PENDING",
        metadata: { assets: body.assets },
      },
    });
    set.status = 201;
    return { data };
  }, {
    body: t.Object({
      propertyId: t.String(),
      assets: t.Array(t.String()),
    }),
  })

  .get("/:id/rooms", async ({ db, params, set }) => {
    const analysis = await (db as any).spatialAnalysis.findUnique({
      where: { id: params.id },
    });
    if (!analysis) {
      set.status = 404;
      return { error: "SpatialAnalysis not found" };
    }
    const data = await (db as any).roomAnalysis.findMany({
      where: { spatialAnalysisId: analysis.id },
      orderBy: { createdAt: "asc" },
    });
    return { data };
  }, {
    params: t.Object({ id: t.String() }),
  });

// ─── Property Health Reports ──────────────────────────────────

export const propertyHealthReportRoutes = new Elysia({ prefix: "/property-health-report" })
  .use(authMiddleware)
  .use(regionMiddleware)

  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    if (orgId) where.orgId = orgId;

    const skip = (parseInt(page) - 1) * parseInt(limit);
    const take = parseInt(limit);

    const [data, total] = await Promise.all([
      (db as any).propertyHealthReport.findMany({
        where,
        skip,
        take,
        orderBy: { createdAt: "desc" },
      }),
      (db as any).propertyHealthReport.count({ where }),
    ]);

    return { data, total, page: parseInt(page), limit: take };
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
      propertyId: t.Optional(t.String()),
    })),
  })

  .get("/compare", async ({ db, query, set }) => {
    const { baseline, current } = query as { baseline: string; current: string };
    const [baselineReport, currentReport] = await Promise.all([
      (db as any).propertyHealthReport.findUnique({ where: { id: baseline } }),
      (db as any).propertyHealthReport.findUnique({ where: { id: current } }),
    ]);
    if (!baselineReport || !currentReport) {
      set.status = 404;
      return { error: "One or both reports not found" };
    }
    const delta = currentReport.healthScore - baselineReport.healthScore;
    return { data: { baseline: baselineReport, current: currentReport, delta } };
  }, {
    query: t.Object({
      baseline: t.String(),
      current: t.String(),
    }),
  })

  .get("/:id", async ({ db, params, set }) => {
    const data = await (db as any).propertyHealthReport.findUnique({
      where: { id: params.id },
    });
    if (!data) {
      set.status = 404;
      return { error: "PropertyHealthReport not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() }),
  })

  .post("/", async ({ orgId, db, body, set }) => {
    const data = await (db as any).propertyHealthReport.create({
      data: {
        orgId,
        propertyId: body.propertyId,
        healthScore: body.healthScore ?? 0,
        structuralScore: body.structuralScore ?? 0,
        cosmeticScore: body.cosmeticScore ?? 0,
        systemsScore: body.systemsScore ?? 0,
        overallGrade: body.overallGrade ?? "PENDING",
        defects: body.defects ?? undefined,
        spatialAnalysisId: body.spatialAnalysisId ?? undefined,
        baselineId: body.baselineId ?? undefined,
      },
    });
    set.status = 201;
    return { data };
  }, {
    body: t.Object({
      propertyId: t.String(),
      spatialAnalysisId: t.Optional(t.String()),
      baselineId: t.Optional(t.String()),
      healthScore: t.Optional(t.Number()),
      structuralScore: t.Optional(t.Number()),
      cosmeticScore: t.Optional(t.Number()),
      systemsScore: t.Optional(t.Number()),
      overallGrade: t.Optional(t.String()),
      defects: t.Optional(t.Any()),
    }),
  });

// ─── Insurance Risk ───────────────────────────────────────────

export const insuranceRiskRoutes = new Elysia({ prefix: "/insurance-risk" })
  .use(authMiddleware)
  .use(regionMiddleware)

  .get("/:propertyId", async ({ db, params, set }) => {
    const data = await (db as any).insuranceRiskProfile.findFirst({
      where: { propertyId: params.propertyId },
      orderBy: { createdAt: "desc" },
    });
    if (!data) {
      set.status = 404;
      return { error: "InsuranceRiskProfile not found for this property" };
    }
    return { data };
  }, {
    params: t.Object({ propertyId: t.String() }),
  });

// ─── Insurance Products ───────────────────────────────────────

export const insuranceProductRoutes = new Elysia({ prefix: "/insurance-products" })
  .use(authMiddleware)
  .use(regionMiddleware)

  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    if (orgId) where.orgId = orgId;

    const skip = (parseInt(page) - 1) * parseInt(limit);
    const take = parseInt(limit);

    const [data, total] = await Promise.all([
      (db as any).insuranceProduct.findMany({
        where,
        skip,
        take,
        orderBy: { createdAt: "desc" },
      }),
      (db as any).insuranceProduct.count({ where }),
    ]);

    return { data, total, page: parseInt(page), limit: take };
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
      productType: t.Optional(t.String()),
      isActive: t.Optional(t.String()),
    })),
  });

// ─── Insurance Attachments ────────────────────────────────────

export const insuranceAttachmentRoutes = new Elysia({ prefix: "/insurance-attachments" })
  .use(authMiddleware)
  .use(regionMiddleware)

  .post("/", async ({ orgId, db, body, set }) => {
    const data = await (db as any).insuranceAttachment.create({
      data: {
        orgId,
        propertyId: body.propertyId,
        productId: body.productId,
        holderType: body.holderType,
        status: "PENDING",
      },
    });
    set.status = 201;
    return { data };
  }, {
    body: t.Object({
      propertyId: t.String(),
      productId: t.String(),
      holderType: t.String(),
    }),
  });

// ─── Spatial Assets ───────────────────────────────────────────

export const spatialAssetRoutes = new Elysia({ prefix: "/spatial-assets" })
  .use(authMiddleware)
  .use(regionMiddleware)

  .get("/:propertyId", async ({ db, params }) => {
    const data = await (db as any).spatialAsset.findMany({
      where: { propertyId: params.propertyId },
      orderBy: { createdAt: "desc" },
    });
    return { data };
  }, {
    params: t.Object({ propertyId: t.String() }),
  })

  .post("/", async ({ orgId, db, body, set }) => {
    const data = await (db as any).spatialAsset.create({
      data: {
        orgId,
        propertyId: body.propertyId,
        assetType: body.assetType,
        url: body.url,
        roomType: body.roomType ?? undefined,
      },
    });
    set.status = 201;
    return { data };
  }, {
    body: t.Object({
      propertyId: t.String(),
      assetType: t.String(),
      url: t.String(),
      roomType: t.Optional(t.String()),
    }),
  });

// ─── Media Localization ───────────────────────────────────────

export const mediaLocalizationRoutes = new Elysia({ prefix: "/media-localization" })
  .use(authMiddleware)
  .use(regionMiddleware)

  .get("/:assetId", async ({ db, params }) => {
    const data = await (db as any).mediaLocalization.findMany({
      where: { spatialAssetId: params.assetId },
      orderBy: { createdAt: "desc" },
    });
    return { data };
  }, {
    params: t.Object({ assetId: t.String() }),
  })

  .post("/generate", async ({ orgId, db, body, set }) => {
    const asset = await (db as any).spatialAsset.findUnique({
      where: { id: body.assetId },
    });
    if (!asset) {
      set.status = 404;
      return { error: "SpatialAsset not found" };
    }

    const created = await Promise.all(
      body.targetLanguages.map((lang: string) =>
        (db as any).mediaLocalization.create({
          data: {
            orgId,
            spatialAssetId: body.assetId,
            targetLanguage: lang,
            status: "PENDING",
          },
        })
      )
    );
    set.status = 201;
    return { data: created };
  }, {
    body: t.Object({
      assetId: t.String(),
      targetLanguages: t.Array(t.String()),
    }),
  });

// ─── Brochures ────────────────────────────────────────────────

export const brochureRoutes = new Elysia({ prefix: "/brochures" })
  .use(authMiddleware)
  .use(regionMiddleware)

  .get("/:propertyId", async ({ db, params }) => {
    const data = await (db as any).brochureAsset.findMany({
      where: { propertyId: params.propertyId },
      orderBy: { createdAt: "desc" },
    });
    return { data };
  }, {
    params: t.Object({ propertyId: t.String() }),
  })

  .post("/generate", async ({ orgId, db, body, set }) => {
    const created = await Promise.all(
      body.languages.map((lang: string) =>
        (db as any).brochureAsset.create({
          data: {
            orgId,
            propertyId: body.propertyId,
            language: lang,
            demographicTarget: body.demographicTarget ?? undefined,
            status: "PENDING",
          },
        })
      )
    );
    set.status = 201;
    return { data: created.length === 1 ? created[0] : created };
  }, {
    body: t.Object({
      propertyId: t.String(),
      languages: t.Array(t.String()),
      demographicTarget: t.Optional(t.String()),
    }),
  });
