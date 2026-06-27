import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class SocialAIContentService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.socialAIContent, "socialAIContent");
  }
}

export const socialAIContentService = new SocialAIContentService();
