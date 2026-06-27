import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { prisma } from "../lib/prisma";
import { Phi3Service } from "../services/phi3";
import { AIStagerService } from "../services/ai-stager";
import { GeminiService } from "../services/gemini";
import { AiTaskType } from "@prisma/client";
import { GeminiOpsNotificationCoordinator } from "../services/ai/gemini-ops-coordinator";
import { regionMiddleware } from "../middleware/region";

export const aiRoutes = new Elysia({ prefix: "/ai" })
  .use(authMiddleware)
  .use(regionMiddleware)

  // ─── CHATBOT SESSIONS ───────────────────────

  // GET /ai/sessions
  .get("/sessions", async ({ orgId: contextOrgId, db, query }) => {
    const { orgId, userId, status } = query as any;
    const where: any = {};
    if (orgId) where.orgId = orgId;
    if (userId) where.userId = userId;
    if (status) where.status = status;
    const data = await prisma.aIChatbotSession.findMany({
      where,
      orderBy: { startedAt: "desc" },
      take: 50,
    });
    return { data };
  })

  // POST /ai/sessions
  .post(
    "/sessions",
    async ({ orgId: contextOrgId, db, body, set }) => {
      const data = body as any;
      const session = await prisma.aIChatbotSession.create({
        data: {
          sessionId: data.sessionId ?? crypto.randomUUID(),
          conversationHistory: [],
          startedAt: new Date(),
          lastActivityAt: new Date(),
          ...data,
        },
      });
      set.status = 201;
      return { data: session };
    },
    {
      body: t.Object({
        orgId: t.Optional(t.String()),
        userId: t.Optional(t.String()),
        contactId: t.Optional(t.String()),
        sessionId: t.Optional(t.String()),
        intent: t.Optional(t.String()),
      }),
    }
  )

  // GET /ai/sessions/:sessionId
  .get("/sessions/:sessionId", async ({ orgId: contextOrgId, db, params, set }) => {
    const session = await prisma.aIChatbotSession.findUnique({
      where: { sessionId: params.sessionId },
      include: { messages: { orderBy: { createdAt: "asc" } }, handoffs: true },
    });
    if (!session) { set.status = 404; return { error: "Oturum bulunamadı" }; }
    return { data: session };
  })

  // PATCH /ai/sessions/:sessionId
  .patch(
    "/sessions/:sessionId",
    async ({ orgId: contextOrgId, db, params, body }) => {
      const session = await prisma.aIChatbotSession.update({
        where: { sessionId: params.sessionId },
        data: { lastActivityAt: new Date(), ...(body as any) },
      });
      return { data: session };
    },
    {
      body: t.Partial(t.Object({
        status: t.String(),
        intent: t.String(),
        confidence: t.Number(),
        satisfaction: t.Number(),
        endedAt: t.String(),
        conversationHistory: t.Any(),
      })),
    }
  )

  // ─── MESSAGES ──────────────────────────────

  // GET /ai/sessions/:sessionId/messages
  .get("/sessions/:sessionId/messages", async ({ orgId: contextOrgId, db, params }) => {
    const messages = await prisma.aIChatMessage.findMany({
      where: { sessionId: params.sessionId },
      orderBy: { createdAt: "asc" },
    });
    return { data: messages };
  })

  // POST /ai/sessions/:sessionId/messages
  .post(
    "/sessions/:sessionId/messages",
    async ({ orgId: contextOrgId, db, params, body, set }) => {
      const message = await prisma.aIChatMessage.create({
        data: { sessionId: params.sessionId, ...(body as any) },
      });
      await prisma.aIChatbotSession.update({
        where: { sessionId: params.sessionId },
        data: { lastActivityAt: new Date() },
      });
      set.status = 201;
      return { data: message };
    },
    {
      body: t.Object({
        role: t.String(),           // USER | ASSISTANT | SYSTEM
        content: t.String(),
        moduleType: t.String(),     // SALES_ASSISTANT | PAYMENT_NEGOTIATION | ...
        orgId: t.Optional(t.String()),
        listingId: t.Optional(t.String()),
        reservationId: t.Optional(t.String()),
        isAI: t.Optional(t.Boolean()),
        language: t.Optional(t.String()),
        paymentAgreed: t.Optional(t.Boolean()),
        paymentPlan: t.Optional(t.Any()),
        securityFlag: t.Optional(t.Boolean()),
        securityReason: t.Optional(t.String()),
        escalationTag: t.Optional(t.String()),
        escalationTopic: t.Optional(t.String()),
        piiDetected: t.Optional(t.Boolean()),
        piiTypes: t.Optional(t.Array(t.String())),
        tokenCount: t.Optional(t.Number()),
        processingMs: t.Optional(t.Number()),
        metadata: t.Optional(t.Any()),
      }),
    }
  )

  // ─── HANDOFFS ──────────────────────────────

  // POST /ai/sessions/:sessionId/handoff
  .post(
    "/sessions/:sessionId/handoff",
    async ({ orgId: contextOrgId, db, params, body, set }) => {
      const handoff = await prisma.aIChatHandoff.create({
        data: { sessionId: params.sessionId, ...(body as any) },
      });
      await prisma.aIChatbotSession.update({
        where: { sessionId: params.sessionId },
        data: { status: "TRANSFERRED", transferredTo: (body as any).handoffTo },
      });
      set.status = 201;
      return { data: handoff };
    },
    {
      body: t.Object({
        orgId: t.Optional(t.String()),
        handoffReason: t.String(),
        handoffTo: t.String(),
        notes: t.Optional(t.String()),
      }),
    }
  )

  // ─── AI PROPERTY VALUATIONS ────────────────

  // GET /ai/valuations
  .get("/valuations", async ({ orgId: contextOrgId, db, query }) => {
    const { orgId, propertyId } = query as any;
    const where: any = {};
    if (orgId) where.orgId = orgId;
    if (propertyId) where.propertyId = propertyId;
    const data = await prisma.aIPropertyValuation.findMany({
      where,
      orderBy: { valuationDate: "desc" },
      take: 50,
    });
    return { data };
  })

  // POST /ai/valuations
  .post(
    "/valuations",
    async ({ orgId: contextOrgId, db, body, set }) => {
      const valuation = await prisma.aIPropertyValuation.create({ data: body as any });
      set.status = 201;
      return { data: valuation };
    },
    {
      body: t.Object({
        orgId: t.Optional(t.String()),
        modelId: t.String(),
        propertyId: t.String(),
        predictedValue: t.Number(),
        confidenceScore: t.Number(),
        valuationDate: t.String(),
        inputFeatures: t.Any(),
        comparableSales: t.Optional(t.Any()),
        marketTrends: t.Optional(t.Any()),
      }),
    }
  )

  // ─── PRICE OPTIMIZATIONS ───────────────────

  // GET /ai/price-optimizations
  .get("/price-optimizations", async ({ orgId: contextOrgId, db, query }) => {
    const { orgId, listingId } = query as any;
    const where: any = {};
    if (orgId) where.orgId = orgId;
    if (listingId) where.listingId = listingId;
    const data = await prisma.aIPriceOptimization.findMany({
      where,
      orderBy: { generatedAt: "desc" },
      take: 50,
    });
    return { data };
  })

  // POST /ai/price-optimizations
  .post(
    "/price-optimizations",
    async ({ orgId: contextOrgId, db, body, set }) => {
      const opt = await prisma.aIPriceOptimization.create({ data: body as any });
      set.status = 201;
      return { data: opt };
    },
    {
      body: t.Object({
        orgId: t.Optional(t.String()),
        listingId: t.String(),
        currentPrice: t.Number(),
        recommendedPrice: t.Number(),
        priceRange: t.Any(),
        factors: t.Any(),
        comparableData: t.Any(),
        marketTrends: t.Any(),
        confidence: t.Number(),
        generatedAt: t.String(),
      }),
    }
  )

  // PATCH /ai/price-optimizations/:id/apply
  .patch("/price-optimizations/:id/apply", async ({ orgId: contextOrgId, db, params }) => {
    const opt = await prisma.aIPriceOptimization.update({
      where: { id: params.id },
      data: { isApplied: true, appliedAt: new Date() },
    });
    return { data: opt };
  })

  // ─── TENANT SCREENINGS ─────────────────────

  // POST /ai/tenant-screenings
  .post(
    "/tenant-screenings",
    async ({ orgId: contextOrgId, db, body, set }) => {
      const screening = await prisma.aITenantScreening.create({ data: body as any });
      set.status = 201;
      return { data: screening };
    },
    {
      body: t.Object({
        orgId: t.Optional(t.String()),
        applicationId: t.String(),
        overallScore: t.Number(),
        riskAssessment: t.String(),
        creditScore: t.Optional(t.Number()),
        incomeStability: t.Optional(t.Number()),
        rentalHistory: t.Optional(t.Number()),
        backgroundCheck: t.Optional(t.Number()),
        riskFactors: t.Any(),
        recommendations: t.Any(),
        screenedAt: t.String(),
      }),
    }
  )

  // ─── LEAD SCORES ───────────────────────────

  // GET /ai/lead-scores
  .get("/lead-scores", async ({ orgId: contextOrgId, db, query }) => {
    const { orgId, leadId } = query as any;
    const where: any = {};
    if (orgId) where.orgId = orgId;
    if (leadId) where.leadId = leadId;
    const data = await prisma.aILeadScore.findMany({
      where,
      orderBy: { scoredAt: "desc" },
      include: { lead: true },
    });
    return { data };
  })

  // POST /ai/lead-scores
  .post(
    "/lead-scores",
    async ({ orgId: contextOrgId, db, body, set }) => {
      const score = await prisma.aILeadScore.create({ data: body as any });
      set.status = 201;
      return { data: score };
    },
    {
      body: t.Object({
        orgId: t.Optional(t.String()),
        modelId: t.String(),
        leadId: t.String(),
        score: t.Number(),
        scoreBreakdown: t.Any(),
        confidence: t.Number(),
        scoredAt: t.String(),
        featuresUsed: t.Any(),
      }),
    }
  )

  // ─── MARKET ANALYSIS ───────────────────────

  // GET /ai/market-analyses
  .get("/market-analyses", async ({ orgId: contextOrgId, db, query }) => {
    const { orgId, location, analysisType } = query as any;
    const where: any = {};
    if (orgId) where.orgId = orgId;
    if (location) where.location = { contains: location, mode: "insensitive" };
    if (analysisType) where.analysisType = analysisType;
    const data = await prisma.aIMarketAnalysis.findMany({
      where,
      orderBy: { generatedAt: "desc" },
      take: 50,
    });
    return { data };
  })

  // ─── FRAUD DETECTION ───────────────────────

  // GET /ai/fraud-detections
  .get("/fraud-detections", async ({ orgId: contextOrgId, db, query }) => {
    const { orgId, entityType, riskCategory } = query as any;
    const where: any = {};
    if (orgId) where.orgId = orgId;
    if (entityType) where.entityType = entityType;
    if (riskCategory) where.riskCategory = riskCategory;
    const data = await prisma.aIFraudDetection.findMany({
      where,
      orderBy: { detectedAt: "desc" },
      take: 100,
    });
    return { data };
  })

  // ─── RECOMMENDATIONS ───────────────────────

  // GET /ai/recommendations
  .get("/recommendations", async ({ orgId: contextOrgId, db, query }) => {
    const { orgId, userId } = query as any;
    const where: any = {};
    if (orgId) where.orgId = orgId;
    if (userId) where.userId = userId;
    const data = await prisma.aIRecommendation.findMany({
      where: { ...where, OR: [{ expiresAt: null }, { expiresAt: { gt: new Date() } }] },
      orderBy: { generatedAt: "desc" },
      take: 20,
    });
    return { data };
  })

  // ─── PREDICTIVE MAINTENANCE ────────────────

  // GET /ai/predictive-maintenance
  .get("/predictive-maintenance", async ({ orgId: contextOrgId, db, query }) => {
    const { orgId, propertyId, riskLevel } = query as any;
    const where: any = {};
    if (orgId) where.orgId = orgId;
    if (propertyId) where.propertyId = propertyId;
    if (riskLevel) where.riskLevel = riskLevel;
    const data = await prisma.aIPredictiveMaintenance.findMany({
      where,
      orderBy: { generatedAt: "desc" },
      include: { property: true },
    });
    return { data };
  })

  // ─── SENTIMENT ANALYSIS ────────────────────

  // POST /ai/sentiment-analyses
  .post(
    "/sentiment-analyses",
    async ({ orgId: contextOrgId, db, body, set }) => {
      const analysis = await prisma.aISentimentAnalysis.create({ data: body as any });
      set.status = 201;
      return { data: analysis };
    },
    {
      body: t.Object({
        orgId: t.Optional(t.String()),
        contentType: t.String(),
        contentId: t.String(),
        contentText: t.String(),
        sentiment: t.String(),
        sentimentScore: t.Number(),
        confidence: t.Number(),
        analyzedAt: t.String(),
        keyPhrases: t.Optional(t.Any()),
        emotions: t.Optional(t.Any()),
      }),
    }
  )
  // ─── AI MODELS ───────────────────────────────────────────────────────────────

  .get("/models", async ({ orgId: contextOrgId, db, query }) => {
    const { orgId, modelType, status } = query as any;
    const where: any = {};
    if (orgId) where.orgId = orgId;
    if (modelType) where.modelType = modelType;
    if (status) where.status = status;
    const data = await prisma.aIModel.findMany({
      where, orderBy: { createdAt: "desc" },
      include: { deployments: true, _count: { select: { predictions: true } } },
    });
    return { data };
  })

  .post("/models", async ({ orgId: contextOrgId, db, body, set }) => {
    const model = await prisma.aIModel.create({ data: body as any });
    set.status = 201;
    return { data: model };
  }, {
    body: t.Object({
      modelName: t.String(), modelVersion: t.String(), modelType: t.String(), provider: t.String(),
      orgId: t.Optional(t.String()), endpointUrl: t.Optional(t.String()),
      status: t.Optional(t.String()), accuracy: t.Optional(t.Number()),
      config: t.Optional(t.Any()), metadata: t.Optional(t.Any()),
    }),
  })

  .get("/models/:id", async ({ orgId: contextOrgId, db, params, set }) => {
    const model = await prisma.aIModel.findUnique({
      where: { id: params.id },
      include: { deployments: true, predictions: { take: 10, orderBy: { createdAt: "desc" } } },
    });
    if (!model) { set.status = 404; return { error: "AI model not found" }; }
    return { data: model };
  })

  .patch("/models/:id", async ({ orgId: contextOrgId, db, params, body }) => {
    const model = await prisma.aIModel.update({ where: { id: params.id }, data: body as any });
    return { data: model };
  }, {
    body: t.Partial(t.Object({
      status: t.String(), accuracy: t.Number(), lastTrainedAt: t.String(), config: t.Any(),
    })),
  })

  .delete("/models/:id", async ({ orgId: contextOrgId, db, params }) => {
    await prisma.aIModel.delete({ where: { id: params.id } });
    return { message: "AI model deleted" };
  })

  // ─── AI MODEL DEPLOYMENTS ────────────────────────────────────────────────────

  .get("/deployments", async ({ orgId: contextOrgId, db, query }) => {
    const { orgId, modelId, environment, status } = query as any;
    const where: any = {};
    if (orgId) where.orgId = orgId;
    if (modelId) where.modelId = modelId;
    if (environment) where.environment = environment;
    if (status) where.status = status;
    const data = await prisma.aIModelDeployment.findMany({
      where, orderBy: { createdAt: "desc" },
      include: { model: true },
    });
    return { data };
  })

  .post("/deployments", async ({ orgId: contextOrgId, db, body, set }) => {
    const dep = await prisma.aIModelDeployment.create({ data: body as any, include: { model: true } });
    set.status = 201;
    return { data: dep };
  }, {
    body: t.Object({
      modelId: t.String(), deploymentId: t.String(), environment: t.String(),
      orgId: t.Optional(t.String()), status: t.Optional(t.String()),
      deployedAt: t.Optional(t.String()), config: t.Optional(t.Any()),
    }),
  })

  .get("/deployments/:id", async ({ orgId: contextOrgId, db, params, set }) => {
    const dep = await prisma.aIModelDeployment.findUnique({
      where: { id: params.id }, include: { model: true },
    });
    if (!dep) { set.status = 404; return { error: "Deployment not found" }; }
    return { data: dep };
  })

  .patch("/deployments/:id", async ({ orgId: contextOrgId, db, params, body }) => {
    const dep = await prisma.aIModelDeployment.update({ where: { id: params.id }, data: body as any });
    return { data: dep };
  }, {
    body: t.Partial(t.Object({
      status: t.String(), lastHealthCheck: t.String(), metrics: t.Any(),
    })),
  })

  // ─── AI PREDICTIONS ──────────────────────────────────────────────────────────

  .get("/predictions", async ({ orgId: contextOrgId, db, query }) => {
    const { orgId, modelId, status } = query as any;
    const where: any = {};
    if (orgId) where.orgId = orgId;
    if (modelId) where.modelId = modelId;
    if (status) where.status = status;
    const data = await prisma.aIPrediction.findMany({
      where, orderBy: { createdAt: "desc" }, take: 100,
      include: { model: true },
    });
    return { data };
  })

  .post("/predictions", async ({ orgId: contextOrgId, db, body, set }) => {
    const pred = await prisma.aIPrediction.create({ data: body as any });
    set.status = 201;
    return { data: pred };
  }, {
    body: t.Object({
      modelId: t.String(), inputData: t.Any(), outputData: t.Any(),
      orgId: t.Optional(t.String()), requestId: t.Optional(t.String()),
      confidence: t.Optional(t.Number()), processingTimeMs: t.Optional(t.Number()),
      status: t.Optional(t.String()),
    }),
  })

  // ─── AI IMAGE ANALYSIS ───────────────────────────────────────────────────────

  .get("/image-analyses", async ({ orgId: contextOrgId, db, query }) => {
    const { orgId, propertyId, photoId, analysisType } = query as any;
    const where: any = {};
    if (orgId) where.orgId = orgId;
    if (propertyId) where.propertyId = propertyId;
    if (photoId) where.photoId = photoId;
    if (analysisType) where.analysisType = analysisType;
    const data = await prisma.aIImageAnalysis.findMany({
      where, orderBy: { analyzedAt: "desc" },
      include: { property: true },
    });
    return { data };
  })

  .post("/image-analyses", async ({ orgId: contextOrgId, db, body, set }) => {
    const analysis = await prisma.aIImageAnalysis.create({ data: body as any });
    set.status = 201;
    return { data: analysis };
  }, {
    body: t.Object({
      propertyId: t.String(), analysisType: t.String(), analyzedAt: t.String(), confidence: t.Number(),
      orgId: t.Optional(t.String()), photoId: t.Optional(t.String()),
      detectedRooms: t.Optional(t.Any()), qualityScore: t.Optional(t.Number()),
      styleTags: t.Optional(t.Any()), colorPalette: t.Optional(t.Any()),
      lightingQuality: t.Optional(t.Number()), recommendations: t.Optional(t.Any()),
    }),
  })

  .get("/image-analyses/:id", async ({ orgId: contextOrgId, db, params, set }) => {
    const analysis = await prisma.aIImageAnalysis.findUnique({
      where: { id: params.id }, include: { property: true },
    });
    if (!analysis) { set.status = 404; return { error: "Image analysis not found" }; }
    return { data: analysis };
  })

  // ─── AI LEAD SCORING MODELS ──────────────────────────────────────────────────

  .get("/lead-scoring-models", async ({ orgId: contextOrgId, db, query }) => {
    const { orgId, isActive } = query as any;
    const where: any = {};
    if (orgId) where.orgId = orgId;
    if (isActive !== undefined) where.isActive = isActive === "true";
    const data = await prisma.aILeadScoring.findMany({
      where, orderBy: { createdAt: "desc" },
      include: { scores: { take: 5 } },
    });
    return { data };
  })

  .post("/lead-scoring-models", async ({ orgId: contextOrgId, db, body, set }) => {
    const model = await prisma.aILeadScoring.create({ data: body as any });
    set.status = 201;
    return { data: model };
  }, {
    body: t.Object({
      modelName: t.String(), modelVersion: t.String(), accuracy: t.Number(),
      lastTrainedAt: t.String(), features: t.Any(), scoringLogic: t.Any(),
      orgId: t.Optional(t.String()), isActive: t.Optional(t.Boolean()),
    }),
  })

  .get("/lead-scoring-models/:id", async ({ orgId: contextOrgId, db, params, set }) => {
    const model = await prisma.aILeadScoring.findUnique({
      where: { id: params.id }, include: { scores: { take: 20 } },
    });
    if (!model) { set.status = 404; return { error: "Lead scoring model not found" }; }
    return { data: model };
  })

  .patch("/lead-scoring-models/:id", async ({ orgId: contextOrgId, db, params, body }) => {
    const model = await prisma.aILeadScoring.update({ where: { id: params.id }, data: body as any });
    return { data: model };
  }, {
    body: t.Partial(t.Object({
      isActive: t.Boolean(), accuracy: t.Number(), lastTrainedAt: t.String(),
      features: t.Any(), scoringLogic: t.Any(),
    })),
  })

  // ─── AI PROPERTY DESCRIPTIONS ────────────────────────────────────────────────

  .get("/property-descriptions", async ({ orgId: contextOrgId, db, query }) => {
    const { orgId, propertyId, isApproved } = query as any;
    const where: any = {};
    if (orgId) where.orgId = orgId;
    if (propertyId) where.propertyId = propertyId;
    if (isApproved !== undefined) where.isApproved = isApproved === "true";
    const data = await prisma.aIPropertyDescription.findMany({
      where, orderBy: { generatedAt: "desc" },
      include: { property: true },
    });
    return { data };
  })

  .post("/property-descriptions", async ({ orgId: contextOrgId, db, body, set }) => {
    const desc = await prisma.aIPropertyDescription.create({ data: body as any });
    set.status = 201;
    return { data: desc };
  }, {
    body: t.Object({
      propertyId: t.String(), generatedDescription: t.String(), tone: t.String(),
      targetAudience: t.String(), keyFeatures: t.Any(), seoKeywords: t.Any(),
      qualityScore: t.Number(), generatedAt: t.String(),
      orgId: t.Optional(t.String()), originalDescription: t.Optional(t.String()),
      isApproved: t.Optional(t.Boolean()),
    }),
  })

  .patch("/property-descriptions/:id", async ({ orgId: contextOrgId, db, params, body }) => {
    const desc = await prisma.aIPropertyDescription.update({ where: { id: params.id }, data: body as any });
    return { data: desc };
  }, {
    body: t.Partial(t.Object({
      isApproved: t.Boolean(), approvedBy: t.String(), approvedAt: t.String(),
    })),
  })

  // ─── AI VALUATION MODELS ─────────────────────────────────────────────────────

  .get("/valuation-models", async ({ orgId: contextOrgId, db, query }) => {
    const { orgId, isActive } = query as any;
    const where: any = {};
    if (orgId) where.orgId = orgId;
    if (isActive !== undefined) where.isActive = isActive === "true";
    const data = await prisma.aIValuationModel.findMany({
      where, orderBy: { lastTrainedAt: "desc" },
    });
    return { data };
  })

  .post("/valuation-models", async ({ orgId: contextOrgId, db, body, set }) => {
    const model = await prisma.aIValuationModel.create({ data: body as any });
    set.status = 201;
    return { data: model };
  }, {
    body: t.Object({
      modelName: t.String(), modelVersion: t.String(), accuracy: t.Number(),
      lastTrainedAt: t.String(), features: t.Any(), hyperparameters: t.Any(),
      trainingMetrics: t.Any(), orgId: t.Optional(t.String()), isActive: t.Optional(t.Boolean()),
    }),
  })

  .patch("/valuation-models/:id", async ({ orgId: contextOrgId, db, params, body }) => {
    const model = await prisma.aIValuationModel.update({ where: { id: params.id }, data: body as any });
    return { data: model };
  }, {
    body: t.Partial(t.Object({ isActive: t.Boolean(), accuracy: t.Number(), lastTrainedAt: t.String() })),
  })

  // ─── ML CONFIGURATION ────────────────────────────────────────────────────────

  .get("/ml-config", async () => {
    const config = await prisma.mLConfiguration.findUnique({ where: { id: "singleton" } });
    return { data: config };
  })

  .put("/ml-config", async ({ orgId: contextOrgId, db, body }) => {
    const config = await prisma.mLConfiguration.upsert({
      where: { id: "singleton" },
      update: body as any,
      create: { id: "singleton", ...(body as any) },
    });
    return { data: config };
  }, {
    body: t.Partial(t.Object({
      enableAutoTagging: t.Boolean(), qualityThreshold: t.Number(),
      enableMLFeatures: t.Boolean(), maxTagsPerImage: t.Number(),
      analysisMode: t.String(), allowedModels: t.Array(t.String()),
      customSettings: t.Any(), updatedBy: t.String(),
    })),
  })

  // ─── ML MODELS ───────────────────────────────────────────────────────────────

  .get("/ml-models", async ({ orgId: contextOrgId, db, query }) => {
    const { modelType, isActive } = query as any;
    const where: any = {};
    if (modelType) where.modelType = modelType;
    if (isActive !== undefined) where.isActive = isActive === "true";
    const data = await prisma.mLModel.findMany({ where, orderBy: { createdAt: "desc" } });
    return { data };
  })

  .post("/ml-models", async ({ orgId: contextOrgId, db, body, set }) => {
    const model = await prisma.mLModel.create({ data: body as any });
    set.status = 201;
    return { data: model };
  }, {
    body: t.Object({
      modelName: t.String(), modelType: t.String(), version: t.String(), trainingData: t.Any(),
      accuracy: t.Optional(t.Number()), modelPath: t.Optional(t.String()),
      isActive: t.Optional(t.Boolean()),
    }),
  })

  .patch("/ml-models/:id", async ({ orgId: contextOrgId, db, params, body }) => {
    const model = await prisma.mLModel.update({ where: { id: params.id }, data: body as any });
    return { data: model };
  }, {
    body: t.Partial(t.Object({ isActive: t.Boolean(), accuracy: t.Number(), modelPath: t.String() })),
  })

  // ─── PREDICTIVE MODELS ───────────────────────────────────────────────────────

  .get("/predictive-models", async ({ orgId: contextOrgId, db, query }) => {
    const { orgId, modelType } = query as any;
    const where: any = {};
    if (orgId) where.orgId = orgId;
    if (modelType) where.modelType = modelType;
    const data = await prisma.predictiveModel.findMany({ where, orderBy: { lastTrained: "desc" } });
    return { data };
  })

  .post("/predictive-models", async ({ orgId: contextOrgId, db, body, set }) => {
    const model = await prisma.predictiveModel.create({ data: body as any });
    set.status = 201;
    return { data: model };
  }, {
    body: t.Object({
      orgId: t.String(), modelType: t.String(), trainingData: t.Any(), parameters: t.Any(),
      accuracy: t.Optional(t.Number()), lastTrained: t.Optional(t.String()),
    }),
  })

  .patch("/predictive-models/:id", async ({ orgId: contextOrgId, db, params, body }) => {
    const model = await prisma.predictiveModel.update({ where: { id: params.id }, data: body as any });
    return { data: model };
  }, {
    body: t.Partial(t.Object({ accuracy: t.Number(), lastTrained: t.String(), parameters: t.Any() })),
  })

  .delete("/predictive-models/:id", async ({ orgId: contextOrgId, db, params }) => {
    await prisma.predictiveModel.delete({ where: { id: params.id } });
    return { message: "Predictive model deleted" };
  })

  .get("/status", async () => {
    const [totalSessions, activeSessions, totalValuations, pendingTasks] = await Promise.all([
      prisma.aIChatbotSession.count(),
      prisma.aIChatbotSession.count({ where: { status: "ACTIVE" } }),
      prisma.aIPropertyValuation.count(),
      prisma.aIChatbotSession.count({ where: { status: "PENDING" } })
    ]);

    return {
      status: "online",
      uptime: process.uptime(),
      metrics: {
        totalSessions,
        activeSessions,
        totalValuations,
        pendingTasks
      },
      models: {
        valuation: "GPT-4o",
        chatbot: "GPT-4o-mini",
        recommendation: "Custom-ML"
      },
      lastHeartbeat: new Date()
    };
  })
  
  // ─── GEMINI HUB SEARCH ───────────────────────────────────────────────────────

  .post("/gemini-hub", async ({ orgId: contextOrgId, db, body, user }) => {
    const { query, history } = body as any;
    const result = await GeminiService.withDB(db as any).processHubSearch(query, user, history);
    return { data: result };
  }, {
    body: t.Object({
      query: t.String(),
      history: t.Optional(t.Any())
    })
  })

  // ─── GEMINI OTONOM OPERASYONEL TAKİP (OPS TRACKING) ──────────────────────────

  .post("/ops-track/trigger", async ({ orgId: contextOrgId, db, body, set, headers }) => {
    const { sourceType, sourceId } = body as any;
    const region = headers["x-region"] || "US";

    let result = null;
    if (sourceType === "TASK") {
      result = await GeminiOpsNotificationCoordinator.withDB(db as any).trackTaskGPS(sourceId, region);
    } else if (sourceType === "KBS_LOG") {
      result = await GeminiOpsNotificationCoordinator.withDB(db as any).trackKbsStatus(sourceId, region);
    } else if (sourceType === "ESCROW") {
      result = await GeminiOpsNotificationCoordinator.withDB(db as any).trackEscrowChange(sourceId, region);
    } else if (sourceType === "HOST_PENALTY") {
      result = await GeminiOpsNotificationCoordinator.withDB(db as any).trackHostPenalty(sourceId, region);
    } else {
      set.status = 400;
      return { error: `Invalid sourceType: ${sourceType}` };
    }

    return { success: true, data: result };
  }, {
    body: t.Object({
      sourceType: t.String(),
      sourceId: t.String()
    })
  })

  // ─── AI TRANSLATION ──────────────────────────────────────────────────────────
  
  .post("/translate", async ({ orgId: contextOrgId, db, body, set }) => {
    const { text, targetLang = "tr" } = body as any;
    if (!text) { set.status = 400; return { error: "Metin gerekli" }; }
    
    // Check local Phi-3 first
    const isPhi3Available = await Phi3Service.withDB(db as any).checkAvailability();
    if (isPhi3Available) {
      const translation = await Phi3Service.withDB(db as any).translate(text, targetLang);
      return { 
        data: { translation },
        provider: "local-phi3",
        status: "success"
      };
    }
    
    // Fallback or RunPod could go here if implemented
    return { 
      error: "Yerel çeviri servisi şu an kullanılamıyor.", 
      status: "fallback_required" 
    };
  }, {
    body: t.Object({
      text: t.String(),
      targetLang: t.Optional(t.String())
    })
  })

  // ─── SUPERCHARGE (ATLASVS INTEGRATION) ────

  .post("/supercharge/staging", async ({ orgId: contextOrgId, db, body }) => {
    return await AIStagerService.withDB(db as any).stageImage(body as any);
  }, {
    body: t.Object({
      propertyId: t.String(),
      orgId: t.String(),
      imageUrl: t.String(),
      style: t.Optional(t.String()),
      roomType: t.Optional(t.String()),
      denoisingStrength: t.Optional(t.Number())
    })
  })

  .post("/supercharge/reels", async ({ orgId: contextOrgId, db, body }) => {
    return await AIStagerService.withDB(db as any).generateNeuralReels(body as any);
  }, {
    body: t.Object({
      propertyId: t.String(),
      orgId: t.String(),
      photos: t.Array(t.String())
    })
  })

  .get("/supercharge/tasks/:taskId", async ({ orgId: contextOrgId, db, params, set }) => {
    const task = await prisma.aiServiceTask.findUnique({
      where: { id: params.taskId }
    });
    if (!task) { set.status = 404; return { error: "Task not found" }; }
    return { data: task };
  })
  
  .get("/supercharge/property/:propertyId/latest", async ({ orgId: contextOrgId, db, params }) => {
    const tasks = await prisma.aiServiceTask.findMany({
      where: { propertyId: params.propertyId },
      orderBy: { createdAt: "desc" },
      take: 10
    });
    return { data: tasks };
  })

  // ─── ESTATE CONCIERGE (GEMINI) ─────────────────────────────────────────────
  
  .post("/concierge", async ({ orgId: contextOrgId, db, body, set }) => {
    try {
      const { message, chatHistory } = body as any;
      const { GoogleGenerativeAI } = require('@google/generative-ai');
      
      const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || '');
      // Using gemini-2.5-flash for fast responses
      const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash" });
      
      const prompt = `You are a professional Real Estate Concierge named "Estate Concierge". You manage properties, tenants, and real estate portfolios. Answer concisely, professionally, and in the language the user speaks.
      
User message: ${message}`;
      
      const result = await model.generateContent(prompt);
      const response = await result.response;
      const text = response.text();
      
      return { reply: text };
    } catch (e: any) {
      set.status = 500;
      return { error: e.message };
    }
  }, {
    body: t.Object({
      message: t.String(),
      chatHistory: t.Optional(t.Any())
    })
  });
