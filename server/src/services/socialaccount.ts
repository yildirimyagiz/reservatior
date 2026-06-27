import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class SocialAccountService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.socialAccount, "socialAccount");
  }
}

export const socialAccountService = new SocialAccountService();
