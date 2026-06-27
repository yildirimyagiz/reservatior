import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class UserActivityLogService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.userActivityLog, "userActivityLog");
  }
}

export const userActivityLogService = new UserActivityLogService();
