import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AIChatbotSessionService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.aIChatbotSession, "aIChatbotSession");
  }
}

export const aIChatbotSessionService = new AIChatbotSessionService();
