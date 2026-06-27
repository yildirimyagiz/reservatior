import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class WebhookDeliveryService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.webhookDelivery, "webhookDelivery");
  }
}

export const webhookDeliveryService = new WebhookDeliveryService();
