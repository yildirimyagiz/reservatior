import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class SocialImpactRecordService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.socialImpactRecord, "socialImpactRecord");
  }
}

export const socialImpactRecordService = new SocialImpactRecordService();
