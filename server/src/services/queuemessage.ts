import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class QueueMessageService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.queueMessage, "queueMessage");
  }
}

export const queueMessageService = new QueueMessageService();
