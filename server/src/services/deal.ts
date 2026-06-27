import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class DealService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.deal, "deal");
  }
}

export const dealService = new DealService();
