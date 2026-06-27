import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AgencyService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.agency, "agency");
  }
}

export const agencyService = new AgencyService();
