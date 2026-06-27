import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class IncludedServiceService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.includedService, "includedService");
  }
}

export const includedServiceService = new IncludedServiceService();
