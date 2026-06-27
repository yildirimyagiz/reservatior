import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class UserFinancialProfileService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.userFinancialProfile, "userFinancialProfile");
  }
}

export const userFinancialProfileService = new UserFinancialProfileService();
