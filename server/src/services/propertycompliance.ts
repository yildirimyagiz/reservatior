import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class PropertyComplianceService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.propertyCompliance, "propertyCompliance");
  }
}

export const propertyComplianceService = new PropertyComplianceService();
