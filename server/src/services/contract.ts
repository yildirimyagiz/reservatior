import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ContractService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.contract, "contract");
  }
}

export const contractService = new ContractService();
