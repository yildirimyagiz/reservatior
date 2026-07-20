import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class UserDeviceService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.userDevice, "userDevice");
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
    super(prisma.userSession, "userSession");
  }

  async getByUser(userId: string) {
    return this.model.findMany({ where: { userId }, orderBy: { createdAt: "desc" } });
  }

  async createSession(userId: string, data: { ipAddress?: string; userAgent?: string }) {
    return this.model.create({ data: { userId, ...data, createdAt: new Date(), expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000) } });
  }

  async revokeSession(id: string) {
    return this.model.update({ where: { id }, data: { revokedAt: new Date() } });
  }

  async revokeAllSessions(userId: string) {
    return this.model.updateMany({ where: { userId, revokedAt: null }, data: { revokedAt: new Date() } });
  }
}

export const userDeviceService = new UserDeviceService();
export const userSessionService = new UserSessionService();
