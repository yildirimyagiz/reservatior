import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class QueueConfigurationService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.queueConfiguration, "queueConfiguration");
  }
}

export const queueConfigurationService = new QueueConfigurationService();
