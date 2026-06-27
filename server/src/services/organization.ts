import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class OrganizationService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.organization, "organization");
  }
}

export const organizationService = new OrganizationService();
