import { prisma } from "../lib/prisma";

export class NotificationCenterService {
  async getDashboard(orgId: string) {
    const [totalNotifications, unreadCount, totalMessages, channelStats, recentNotifications] = await Promise.all([
      prisma.notification.count(),
      prisma.notification.count({ where: { status: "QUEUED" } }),
      prisma.message.count(),
      prisma.notification.groupBy({ by: ["status"], _count: { id: true } }),
      prisma.notification.findMany({ orderBy: { createdAt: "desc" }, take: 10 }),
    ]);
    return {
      totalNotifications,
      unreadCount,
      totalMessages,
      channelStats: channelStats.map(s => ({ status: s.status, count: s._count.id })),
      recentNotifications,
    };
  }

  async getNotifications(params?: { skip?: number; take?: number; status?: string; userId?: string }) {
    return prisma.notification.findMany({
      where: {
        ...(params?.status && { status: params.status }),
        ...(params?.userId && { userId: params.userId }),
      },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 20,
    });
  }

  async getNotificationStats() {
    const [total, byStatus, byRuleKey] = await Promise.all([
      prisma.notification.count(),
      prisma.notification.groupBy({ by: ["status"], _count: { id: true } }),
      prisma.notification.groupBy({ by: ["ruleKey"], _count: { id: true }, take: 10 }),
    ]);
    return {
      total,
      byStatus: byStatus.map(s => ({ status: s.status, count: s._count.id })),
      byRuleKey: byRuleKey.map(r => ({ ruleKey: r.ruleKey, count: r._count.id })),
    };
  }

  async getMessages(threadId?: string, params?: { skip?: number; take?: number }) {
    return prisma.message.findMany({
      where: { ...(threadId && { threadId }) },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 50,
    });
  }

  async getMessageStats() {
    const [total, unreadCount, byType] = await Promise.all([
      prisma.message.count(),
      prisma.message.count({ where: { isRead: false } }),
      prisma.message.groupBy({ by: ["senderType"], _count: { id: true } }),
    ]);
    return { total, unreadCount, byType: byType.map(t => ({ senderType: t.senderType, count: t._count.id })) };
  }

  async getCommunicationLogs(params?: { skip?: number; take?: number; type?: string }) {
    return prisma.communicationLog.findMany({
      where: { ...(params?.type && { type: params.type }) },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 50,
    });
  }

  async getTemplates() {
    return prisma.communicationTemplate.findMany({
      orderBy: { createdAt: "desc" },
    });
  }

  async getChannels() {
    return prisma.channel.findMany({
      orderBy: { name: "asc" },
    });
  }

  async createNotification(data: { userId?: string; title: string; body: string; status?: string; ruleKey?: string; data?: any }) {
    return prisma.notification.create({
      data: {
        ...data,
        status: data.status ?? "QUEUED",
        deliveries: [],
        userPreferences: {},
        createdAt: new Date(),
      },
    });
  }

  async markAsRead(id: string) {
    return prisma.notification.update({
      where: { id },
      data: { status: "READ" },
    });
  }

  async sendMessage(data: { senderId: string; threadId?: string; body: string; subject?: string }) {
    return prisma.message.create({
      data: {
        ...data,
        senderType: "USER",
        isRead: false,
        createdAt: new Date(),
      },
    });
  }
}

export const notificationCenterService = new NotificationCenterService();
