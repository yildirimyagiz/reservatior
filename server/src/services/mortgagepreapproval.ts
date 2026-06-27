import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class MortgagePreApprovalService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.mortgagePreApproval, "mortgagePreApproval");
  }
}

export const mortgagePreApprovalService = new MortgagePreApprovalService();
