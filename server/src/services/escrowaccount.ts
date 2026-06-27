import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class EscrowAccountService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.escrowAccount, "escrowAccount");
  }
}

export const escrowAccountService = new EscrowAccountService();
