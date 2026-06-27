import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ContractVersionService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.contractVersion, "contractVersion");
  }
}

export const contractVersionService = new ContractVersionService();
