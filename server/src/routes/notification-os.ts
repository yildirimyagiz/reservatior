import { Elysia, t } from "elysia";
import { notificationCenterService } from "../services/notification-center-service";

export const notificationOSRoutes = new Elysia({ prefix: "/notification-os" })

  .get("/dashboard", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await notificationCenterService.getDashboard(orgId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "Notification OS Dashboard", tags: ["Notification OS"] },
  })

  .get("/notifications", async ({ query, set }) => {
    try {
      const { page, limit, status, userId } = query;
      const data = await notificationCenterService.getNotifications({
        skip: ((parseInt(page as string) || 1) - 1) * (parseInt(limit as string) || 20),
        take: parseInt(limit as string) || 20,
        status: status as string,
        userId: userId as string,
      });
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      status: t.Optional(t.String()),
      userId: t.Optional(t.String()),
    }),
    detail: { summary: "List Notifications", tags: ["Notification OS"] },
  })

  .post("/notifications", async ({ body, set }) => {
    try {
      const data = await notificationCenterService.createNotification(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      title: t.String(),
      body: t.String(),
      userId: t.Optional(t.String()),
      status: t.Optional(t.String()),
      ruleKey: t.Optional(t.String()),
      data: t.Optional(t.Any()),
    }),
    detail: { summary: "Create Notification", tags: ["Notification OS"] },
  })

  .get("/notifications/stats", async ({ set }) => {
    try {
      const data = await notificationCenterService.getNotificationStats();
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Notification Statistics", tags: ["Notification OS"] },
  })

  .patch("/notifications/:id/read", async ({ params, set }) => {
    try {
      const data = await notificationCenterService.markAsRead(params.id);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    detail: { summary: "Mark Notification as Read", tags: ["Notification OS"] },
  })

  .get("/messages", async ({ query, set }) => {
    try {
      const { threadId, page, limit } = query;
      const data = await notificationCenterService.getMessages(threadId as string, {
        skip: ((parseInt(page as string) || 1) - 1) * (parseInt(limit as string) || 50),
        take: parseInt(limit as string) || 50,
      });
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({
      threadId: t.Optional(t.String()),
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
    }),
    detail: { summary: "List Messages", tags: ["Notification OS"] },
  })

  .post("/messages", async ({ body, set }) => {
    try {
      const data = await notificationCenterService.sendMessage(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      senderId: t.String(),
      body: t.String(),
      threadId: t.Optional(t.String()),
      subject: t.Optional(t.String()),
    }),
    detail: { summary: "Send Message", tags: ["Notification OS"] },
  })

  .get("/messages/stats", async ({ set }) => {
    try {
      const data = await notificationCenterService.getMessageStats();
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Message Statistics", tags: ["Notification OS"] },
  })

  .get("/logs", async ({ query, set }) => {
    try {
      const { page, limit, type } = query;
      const data = await notificationCenterService.getCommunicationLogs({
        skip: ((parseInt(page as string) || 1) - 1) * (parseInt(limit as string) || 50),
        take: parseInt(limit as string) || 50,
        type: type as string,
      });
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      type: t.Optional(t.String()),
    }),
    detail: { summary: "Communication Logs", tags: ["Notification OS"] },
  })

  .get("/templates", async ({ set }) => {
    try {
      const data = await notificationCenterService.getTemplates();
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "List Communication Templates", tags: ["Notification OS"] },
  })

  .get("/channels", async ({ set }) => {
    try {
      const data = await notificationCenterService.getChannels();
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "List Communication Channels", tags: ["Notification OS"] },
  });
