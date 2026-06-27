import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class SocialAccountMetricService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.socialAccountMetric, "socialAccountMetric");
  }
}

export const socialAccountMetricService = new SocialAccountMetricService();
