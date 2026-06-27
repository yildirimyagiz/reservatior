import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AccessLogService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.accessLog, "accessLog");
  }
}

export const accessLogService = new AccessLogService();
