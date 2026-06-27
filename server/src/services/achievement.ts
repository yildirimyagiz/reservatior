import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AchievementService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.achievement, "achievement");
  }
}

export const achievementService = new AchievementService();
