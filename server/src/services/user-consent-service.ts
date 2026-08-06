import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class UserConsentService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.consent as any, "consent");
  }

  async getByUser(userId: string) {
    return this.model.findMany({ 
      where: { userId, entityType: "USER" }, 
      orderBy: { createdAt: "desc" } 
    });
  }

  async grantConsent(userId: string, consentType: string, granted: boolean) {
    const existing = await this.model.findFirst({
      where: { userId, consentType, entityType: "USER" }
    });

    const status = granted ? "ACTIVE" : "REVOKED";

    let result;
    if (existing) {
      result = await this.model.update({
        where: { id: existing.id },
        data: { status, updatedAt: new Date() }
      });
    } else {
      result = await this.model.create({
        data: {
          entityId: userId,
          userId: userId,
          entityType: "USER",
          consentType: consentType as any,
          consentPurpose: "GENERAL",
          consentChannel: "WEB",
          consentMethod: "WEB_FORM",
          status,
          createdAt: new Date(),
        }
      });
    }

    await eventBus.publish("USER_CONSENT_RECORDED", { id: result.id, userId, consentType, granted }, "UserOS");
    return result;
  }

  async withdrawConsent(userId: string, consentType: string) {
    return this.model.updateMany({ 
      where: { userId, consentType, entityType: "USER" }, 
      data: { status: "REVOKED", revokedAt: new Date() } 
    });
  }

  async bulkGrant(userId: string, consents: { consentType: string; granted: boolean }[]) {
    return Promise.all(consents.map(c => this.grantConsent(userId, c.consentType, c.granted)));
  }
}

export const userConsentService = new UserConsentService();
