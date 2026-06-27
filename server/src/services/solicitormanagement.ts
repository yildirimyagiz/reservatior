import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class SolicitorManagementService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.solicitorManagement, "solicitorManagement");
  }
}

export const solicitorManagementService = new SolicitorManagementService();
