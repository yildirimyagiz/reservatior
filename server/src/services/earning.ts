import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class EarningService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.earning, "earning");
  }
}

export const earningService = new EarningService();
