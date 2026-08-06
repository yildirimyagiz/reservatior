import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { prisma } from "../lib/prisma";
import { triggerStreamRoutes } from "./system/trigger-stream";

export const systemRoutes = new Elysia({ prefix: "/system" })
  .use(triggerStreamRoutes)
  .use(authMiddleware)

  // ─── AUTOMATION EXECUTIONS ───────────────────────────────────────────────────

  .get("/automation-executions", async ({ query }) => {
    const { orgId, ruleId, status, page = "1", limit = "50" } = query as any;
    const skip = (parseInt(page) - 1) * parseInt(limit);
    const where: any = {};
    if (orgId) where.orgId = orgId;
    if (ruleId) where.ruleId = ruleId;
    if (status) where.status = status;
    const [data, total] = await Promise.all([
      prisma.automationExecution.findMany({
        where,
        skip,
        take: parseInt(limit),
        orderBy: { executedAt: "desc" },
        include: { rule: true },
      }),
      prisma.automationExecution.count({ where }),
    ]);
    return { data, total, page: parseInt(page), limit: parseInt(limit) };
  })

  .post(
    "/automation-executions",
    async ({ body, set }) => {
      const execution = await prisma.automationExecution.create({
        data: body as any,
      });
      set.status = 201;
      return { data: execution };
    },
    {
      // Schema matches AutomationExecution prisma model fields
      body: t.Object({
        orgId: t.String(),
        ruleId: t.String(),
        executionData: t.Any(),
        triggerEvent: t.Optional(t.Any()),
        status: t.Optional(t.String()),
        processingTimeMs: t.Optional(t.Number()),
      }),
    }
  )

  .get("/automation-executions/:id", async ({ params, set }) => {
    const execution = await prisma.automationExecution.findUnique({
      where: { id: params.id },
      include: { rule: true },
    });
    if (!execution) {
      set.status = 404;
      return { error: "Automation execution not found" };
    }
    return { data: execution };
  })

  // ─── AUTOMATION TASKS ────────────────────────────────────────────────────────
  // Note: AutomationTask maps to "automation_tasks" table; no orgId filtering here.

  .get("/automation-tasks", async ({ query }) => {
    const { taskType, status } = query as any;
    const where: any = {};
    if (taskType) where.taskType = taskType;
    if (status) where.status = status;
    const data = await prisma.automationTask.findMany({
      where,
      orderBy: { createdAt: "desc" },
    });
    return { data };
  })

  // ─── TASKS ───────────────────────────────────────────────────────────────────

  .get("/tasks", async ({ query }) => {
    const {
      orgId,
      assignedToUserId,
      status,
      priority,
      page = "1",
      limit = "50",
    } = query as any;
    const skip = (parseInt(page) - 1) * parseInt(limit);
    const where: any = {};
    if (orgId) where.orgId = orgId;
    if (assignedToUserId) where.assignedToUserId = assignedToUserId;
    if (status) where.status = status;
    if (priority) where.priority = priority;
    const [data, total] = await Promise.all([
      prisma.task.findMany({
        where,
        skip,
        take: parseInt(limit),
        orderBy: { createdAt: "desc" },
      }),
      prisma.task.count({ where }),
    ]);
    return { data, total, page: parseInt(page), limit: parseInt(limit) };
  })

  .post(
    "/tasks",
    async ({ body, set }) => {
      const task = await prisma.task.create({ data: body as any });
      set.status = 201;
      return { data: task };
    },
    {
      body: t.Object({
        orgId: t.String(),
        type: t.String(),
        title: t.String(),
        description: t.Optional(t.String()),
        assignedToUserId: t.Optional(t.String()),
        status: t.Optional(t.String()),
        priority: t.Optional(t.String()),
        dueAt: t.Optional(t.String()),
      }),
    }
  )

  .get("/tasks/:id", async ({ params, set }) => {
    const task = await prisma.task.findUnique({ where: { id: params.id } });
    if (!task) {
      set.status = 404;
      return { error: "Task not found" };
    }
    return { data: task };
  })

  .patch(
    "/tasks/:id",
    async ({ params, body }) => {
      const task = await prisma.task.update({
        where: { id: params.id },
        data: body as any,
      });
      return { data: task };
    },
    {
      body: t.Partial(
        t.Object({
          title: t.String(),
          description: t.String(),
          status: t.String(),
          priority: t.String(),
          dueAt: t.String(),
        })
      ),
    }
  )

  .delete("/tasks/:id", async ({ params }) => {
    await prisma.task.update({
      where: { id: params.id },
      data: { deletedAt: new Date() },
    });
    return { message: "Task deleted" };
  })

  // ─── LANGUAGES ───────────────────────────────────────────────────────────────

  .get("/languages", async ({ query }) => {
    const { isActive, page = "1", limit = "50" } = query as any;
    const skip = (parseInt(page) - 1) * parseInt(limit);
    const where: any = {};
    if (isActive !== undefined) where.isActive = isActive === "true";
    const [data, total] = await Promise.all([
      prisma.language.findMany({
        where,
        skip,
        take: parseInt(limit),
        orderBy: { name: "asc" },
      }),
      prisma.language.count({ where }),
    ]);
    return { data, total, page: parseInt(page), limit: parseInt(limit) };
  })

  .post(
    "/languages",
    async ({ body, set }) => {
      const language = await prisma.language.create({ data: body as any });
      set.status = 201;
      return { data: language };
    },
    {
      body: t.Object({
        code: t.String(),
        name: t.String(),
        nativeName: t.String(),
        isRTL: t.Optional(t.Boolean()),
        isActive: t.Optional(t.Boolean()),
      }),
    }
  )

  .get("/languages/:id", async ({ params, set }) => {
    const language = await prisma.language.findUnique({
      where: { id: params.id },
    });
    if (!language) {
      set.status = 404;
      return { error: "Language not found" };
    }
    return { data: language };
  })

  .patch(
    "/languages/:id",
    async ({ params, body }) => {
      const language = await prisma.language.update({
        where: { id: params.id },
        data: body as any,
      });
      return { data: language };
    },
    {
      body: t.Partial(
        t.Object({
          name: t.String(),
          nativeName: t.String(),
          code: t.String(),
          isRTL: t.Boolean(),
          isActive: t.Boolean(),
        })
      ),
    }
  )

  .delete("/languages/:id", async ({ params }) => {
    await prisma.language.update({
      where: { id: params.id },
      data: { deletedAt: new Date() },
    });
    return { message: "Language deleted" };
  })

  // ─── HEALTH CHECKS ───────────────────────────────────────────────────────────

  .get("/health", async ({ query }) => {
    const { orgId, serviceName, status } = query as any;
    const where: any = {};
    if (orgId) where.orgId = orgId;
    if (serviceName) where.serviceName = serviceName;
    if (status) where.status = status;
    const data = await prisma.healthCheck.findMany({
      where,
      orderBy: { checkedAt: "desc" },
      take: 100,
    });
    return { data };
  })

  .post(
    "/health",
    async ({ body, set }) => {
      const check = await prisma.healthCheck.create({ data: body as any });
      set.status = 201;
      return { data: check };
    },
    {
      body: t.Object({
        serviceName: t.String(),
        componentName: t.String(),
        status: t.String(),
        responseTime: t.Optional(t.Number()),
        details: t.Optional(t.Any()),
        errorMessage: t.Optional(t.String()),
        orgId: t.Optional(t.String()),
      }),
    }
  )

  .get("/health/:id", async ({ params, set }) => {
    const check = await prisma.healthCheck.findUnique({
      where: { id: params.id },
    });
    if (!check) {
      set.status = 404;
      return { error: "Health check not found" };
    }
    return { data: check };
  })

  // ─── ACTIVE TRIGGER TASKS ────────────────────────────────────────────────────
  // Serves the task list the mobile SystemTriggerProvider polls as an SSE fallback.

  .get("/triggers", async ({ query }) => {
    const { orgId } = query as any;
    const where: any = {};
    if (orgId && orgId !== "global") where.orgId = orgId;

    const tasks = await prisma.aiServiceTask.findMany({
      where,
      orderBy: { createdAt: "desc" },
      take: 10,
    });

    const data = tasks.map((task: any) => ({
      id: task.id,
      source: "ai-service-task",
      type: task.taskType,
      status: task.status,
      title: task.taskType,
      description: task.errorMessage || "AI task in progress",
      createdAt: task.createdAt.toISOString(),
      progress: task.progress ?? 0,
    }));

    return { success: true, data };
  });