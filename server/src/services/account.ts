import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AccountService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.account, "account");
  }
}

export const accountService = new AccountService();
