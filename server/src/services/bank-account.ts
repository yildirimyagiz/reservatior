import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class BankAccountService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.bankAccount, "bankAccount");
  }

  async setDefaultForPayouts(orgId: string, bankAccountId: string) {
    await this.model.updateMany({
      where: { orgId, isDefaultForPayouts: true },
      data: { isDefaultForPayouts: false },
    });

    return this.model.update({
      where: { id: bankAccountId },
      data: { isDefaultForPayouts: true },
    });
  }

  async setDefaultForReceipts(orgId: string, bankAccountId: string) {
    await this.model.updateMany({
      where: { orgId, isDefaultForReceipts: true },
      data: { isDefaultForReceipts: false },
    });

    return this.model.update({
      where: { id: bankAccountId },
      data: { isDefaultForReceipts: true },
    });
  }

  async getOrgAccounts(orgId: string) {
    return this.model.findMany({
      where: { orgId },
      orderBy: { createdAt: "desc" },
    });
  }

  async verifyAccount(bankAccountId: string, verifiedBy: string) {
    return this.model.update({
      where: { id: bankAccountId },
      data: {
        status: "ACTIVE",
        verifiedAt: new Date(),
        verifiedBy,
      },
    });
  }
}

export const bankAccountService = new BankAccountService();
