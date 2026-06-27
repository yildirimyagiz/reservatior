import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AIChatHandoffService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.aIChatHandoff, "aIChatHandoff");
  }
}

export const aIChatHandoffService = new AIChatHandoffService();
