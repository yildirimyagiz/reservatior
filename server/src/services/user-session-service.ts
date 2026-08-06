import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class UserDeviceService extends BaseService<any, any, any> {
  constructor() {
    super((prisma as any).userDevice, "userDevice");
  }

  async getByUser(userId: string) {
    return this.model.findMany({ where: { userId }, orderBy: { lastSeenAt: "desc" } });
  }

  async registerDevice(userId: string, data: { deviceType: string; deviceName?: string; fingerprint?: string }) {
    return this.model.create({ data: { userId, ...data, lastSeenAt: new Date(), createdAt: new Date() } });
  }

  async revokeDevice(id: string) {
    return this.model.update({ where: { id }, data: { revokedAt: new Date() } });
  }
}

export class UserSessionService extends BaseService<any, any, any> {
  constructor() {
    super((prisma as any).userSession, "userSession");
  }

  async getByUser(userId: string) {
    return this.model.findMany({ where: { userId }, orderBy: { createdAt: "desc" } });
  }

  async createSession(userId: string, data: { ipAddress?: string; userAgent?: string }) {
    const result = await this.model.create({ data: { userId, ...data, createdAt: new Date(), expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000) } });
    await eventBus.publish("USER_SESSION_STARTED", { id: result.id, userId, deviceInfo: data.userAgent }, "UserOS");
    return result;
  }

  async revokeSession(id: string) {
    const result = await this.model.update({ where: { id }, data: { revokedAt: new Date() } });
    await eventBus.publish(DomainEvents.SESSION_REVOKED, { id }, "UserOS");
    return result;
  }

  async revokeAllSessions(userId: string) {
    return this.model.updateMany({ where: { userId, revokedAt: null }, data: { revokedAt: new Date() } });
  }
}

export const userDeviceService = new UserDeviceService();
export const userSessionService = new UserSessionService();
