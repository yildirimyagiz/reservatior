import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class BrandAmbassadorService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.brandAmbassador, "brandAmbassador");
  }
}

export const brandAmbassadorService = new BrandAmbassadorService();
