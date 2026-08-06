import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class UserNotificationService extends BaseService<any, any, any> {
  constructor() {
    super((prisma as any).userNotification, "userNotification");
  }

  async getByUser(userId: string, params?: { unreadOnly?: boolean; limit?: number }) {
    return this.model.findMany({
      where: { userId, ...(params?.unreadOnly && { readAt: null }) },
      orderBy: { createdAt: "desc" },
      take: params?.limit ?? 20,
    });
  }

  async createNotification(userId: string, data: { title: string; message: string; type?: string; metadata?: any }) {
    return this.model.create({ data: { userId, ...data, createdAt: new Date() } });
  }

  async markRead(id: string) {
    return this.model.update({ where: { id }, data: { readAt: new Date() } });
  }

  async markAllRead(userId: string) {
    return this.model.updateMany({ where: { userId, readAt: null }, data: { readAt: new Date() } });
  }

  async dismiss(id: string) {
    return this.model.update({ where: { id }, data: { dismissedAt: new Date() } });
  }

  async getUnreadCount(userId: string) {
    return this.model.count({ where: { userId, readAt: null } });
  }
}

export const userNotificationService = new UserNotificationService();
