import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class SocialInboundMessageService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.socialInboundMessage, "socialInboundMessage");
  }
}

export const socialInboundMessageService = new SocialInboundMessageService();
