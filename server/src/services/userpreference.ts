import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class UserPreferenceService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.userPreference, "userPreference");
  }
}

export const userPreferenceService = new UserPreferenceService();
