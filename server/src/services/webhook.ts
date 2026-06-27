import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class WebhookService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.webhook, "webhook");
  }
}

export const webhookService = new WebhookService();
