import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AmbassadorContractService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.ambassadorContract, "ambassadorContract");
  }
}

export const ambassadorContractService = new AmbassadorContractService();
