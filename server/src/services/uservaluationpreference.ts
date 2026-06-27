import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class UserValuationPreferenceService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.userValuationPreference, "userValuationPreference");
  }
}

export const userValuationPreferenceService = new UserValuationPreferenceService();
