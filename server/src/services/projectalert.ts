import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ProjectAlertService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.projectAlert, "projectAlert");
  }
}

export const projectAlertService = new ProjectAlertService();
