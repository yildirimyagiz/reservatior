import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class SubscriptionService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.subscription, "subscription");
  }
}

export const subscriptionService = new SubscriptionService();
