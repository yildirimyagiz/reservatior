import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class SecurityPolicyService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.securityPolicy, "securityPolicy");
  }

  async getByOrg(orgId: string) {
    return this.model.findMany({
      where: { orgId },
      orderBy: { createdAt: "desc" },
    });
  }

  async getActivePolicies(orgId: string) {
    return this.model.findMany({
      where: { orgId, isActive: true },
      orderBy: { createdAt: "desc" },
    });
  }

  async createPolicy(data: {
    orgId: string;
    name: string;
    description?: string;
    policyType: string;
    rules?: any;
  }) {
    const result = await this.model.create({
      data: {
        ...data,
        isActive: true,
        createdAt: new Date(),
      },
    });

    await eventBus.publish({
      type: DomainEvents.SECURITY_POLICY_CREATED,
      payload: { id: result.id, name: data.name, policyType: data.policyType },
      source: "SecurityOS",
    });

    return result;
  }

  async togglePolicy(id: string, isActive: boolean) {
    return this.model.update({
      where: { id },
      data: { isActive },
    });
  }
}

export const securityPolicyService = new SecurityPolicyService();
