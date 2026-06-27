import { Elysia, t } from "elysia";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export const triggerRoutes = new Elysia({ prefix: "/api/v1/system/triggers" })
  .get("/", async ({ query }) => {
    const { orgId, userId } = query;

    let aiTasks: any[] = [];
    let systemTasks: any[] = [];
    let conciergeRequests: any[] = [];
    let mlsJobs: any[] = [];

    // 1. Fetch AI Service Tasks (High-Impact / User-Facing Only)
    // Sadece kullanıcının bilmesi gereken "gereklilikler" arayüze yansıtılır
    if (orgId) {
      aiTasks = await prisma.aiServiceTask.findMany({
        where: { 
          orgId, 
          status: { in: ["QUEUED", "PROCESSING", "COMPLETED", "FAILED"] },
          taskType: { in: ["CONCIERGE_DISPATCH", "FAILOVER_SEARCH", "PROPERTY_VALUATION", "SMART_CONTRACT_GENERATION", "AI_PHOTO_STAGING", "MARKETING_BROCHURE_GEN", "MLS_SYNC"] } // Gürültü yaratan PRICING_OPTIMIZATION vb. gizlendi, yeni WOW görevleri eklendi.
        },
        orderBy: { createdAt: "desc" },
        take: 5,
      });

      // 2. Fetch System Tasks (Only those needing review or critical actions)
      systemTasks = await prisma.task.findMany({
        where: { 
          orgId, 
          status: { in: ["REVIEW", "BLOCKED"] } // Sadece kullanıcı müdahalesi veya acil inceleme gerekenler
        },
        orderBy: { createdAt: "desc" },
        take: 5,
      });

      // 3. Fetch running MLS Sync Jobs
      mlsJobs = await prisma.mLSSyncJob.findMany({
        where: { orgId, status: { in: ["RUNNING", "PENDING"] } },
        orderBy: { startedAt: "desc" },
        take: 3,
      });
    }

    // 3. Fetch Concierge Requests if userId is provided
    if (userId) {
      conciergeRequests = await prisma.conciergeRequest.findMany({
        where: { userId },
        orderBy: { createdAt: "desc" },
        take: 10,
      });
    }

    // Standardize the format for the frontend
    const standardizedAiTasks = aiTasks.map(t => ({
      id: t.id,
      source: "AI_SERVICE",
      type: t.taskType,
      status: t.status === "COMPLETED" ? "FULFILLED" : t.status,
      title: `AI Operation: ${t.taskType.replace(/_/g, " ")}`,
      description: t.errorMessage || "Processing neural weights...",
      createdAt: t.createdAt,
      progress: t.progress || (t.status === "PROCESSING" ? 50 : (t.status === "COMPLETED" ? 100 : 10))
    }));

    const standardizedSystemTasks = systemTasks.map(t => ({
      id: t.id,
      source: "SYSTEM_TASK",
      type: t.type,
      status: t.status,
      title: t.title,
      description: t.description || "System assigned task",
      createdAt: t.createdAt,
      progress: t.status === "IN_PROGRESS" ? 50 : 10
    }));

    const formattedConcierge = conciergeRequests.map(req => ({
      id: req.id,
      source: "CONCIERGE",
      type: req.requestType,
      status: req.status,
      title: `Concierge: ${req.requestType}`,
      description: req.message,
      createdAt: req.createdAt,
      progress: req.status === "COMPLETED" ? 100 : req.status === "IN_PROGRESS" ? 60 : 20,
    }));

    const formattedMlsJobs = mlsJobs.map((job) => ({
      id: job.id,
      source: "SYSTEM_TASK",
      type: "MLS_SYNC",
      status: job.status,
      title: "Harici İlan Senkronizasyonu",
      description: "MLS platformlarından binlerce ilan otomatik olarak platforma çekiliyor...",
      createdAt: job.startedAt || new Date(),
      progress: job.status === "COMPLETED" ? 100 : job.status === "RUNNING" ? 45 : 10,
    }));

    // Combine all and sort by date descending
    const allTriggers = [
      ...standardizedAiTasks,
      ...standardizedSystemTasks,
      ...formattedConcierge,
      ...formattedMlsJobs,
    ]
      .sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime())
      .slice(0, 15);

    return {
      success: true,
      data: allTriggers
    };
  }, {
    query: t.Object({
      orgId: t.Optional(t.String()),
      userId: t.Optional(t.String())
    })
  });
