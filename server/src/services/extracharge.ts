import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ExtraChargeService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.extraCharge, "extraCharge");
  }
}

export const extraChargeService = new ExtraChargeService();
