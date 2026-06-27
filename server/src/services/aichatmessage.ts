import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AIChatMessageService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.aIChatMessage, "aIChatMessage");
  }
}

export const aIChatMessageService = new AIChatMessageService();
