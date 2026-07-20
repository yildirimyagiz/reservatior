import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class UserConsentService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.userConsent, "userConsent");
  }

  async getByUser(userId: string) {
    return this.model.findMany({ where: { userId }, orderBy: { createdAt: "desc" } });
  }

  async grantConsent(userId: string, consentType: string, granted: boolean) {
    const result = await this.model.upsert({
      where: { userId_consentType: { userId, consentType } } as any,
      update: { granted, updatedAt: new Date() },
      create: { userId, consentType, granted, createdAt: new Date() },
    }).catch(() => this.model.create({ data: { userId, consentType, granted, createdAt: new Date() } }));
    await eventBus.publish("USER_CONSENT_RECORDED", { id: result.id, userId, consentType, granted }, "UserOS");
    return result;
  }

  async withdrawConsent(userId: string, consentType: string) {
    return this.model.updateMany({ where: { userId, consentType }, data: { granted: false, withdrawnAt: new Date() } });
  }

  async bulkGrant(userId: string, consents: { consentType: string; granted: boolean }[]) {
    return Promise.all(consents.map(c => this.grantConsent(userId, c.consentType, c.granted)));
  }
}

export const userConsentService = new UserConsentService();
