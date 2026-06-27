import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class SocialImpactCounterService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.socialImpactCounter, "socialImpactCounter");
  }
}

export const socialImpactCounterService = new SocialImpactCounterService();
