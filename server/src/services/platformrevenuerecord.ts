import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class PlatformRevenueRecordService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.platformRevenueRecord, "platformRevenueRecord");
  }
}

export const platformRevenueRecordService = new PlatformRevenueRecordService();
