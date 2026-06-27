import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class OfflineSyncQueueService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.offlineSyncQueue, "offlineSyncQueue");
  }
}

export const offlineSyncQueueService = new OfflineSyncQueueService();
