import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class CommunicationLogService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.communicationLog, "communicationLog");
  }
}

export const communicationLogService = new CommunicationLogService();
