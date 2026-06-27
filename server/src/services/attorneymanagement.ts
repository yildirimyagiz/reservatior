import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AttorneyManagementService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.attorneyManagement, "attorneyManagement");
  }
}

export const attorneyManagementService = new AttorneyManagementService();
