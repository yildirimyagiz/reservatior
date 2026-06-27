import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class SocialPostService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.socialPost, "socialPost");
  }
}

export const socialPostService = new SocialPostService();
