import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class OrgSubscriptionService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.orgSubscription, "orgSubscription");
  }
}

export const orgSubscriptionService = new OrgSubscriptionService();
