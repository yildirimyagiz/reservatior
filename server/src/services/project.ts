import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ProjectService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.project, 'project');
  }
}

export const projectService = new ProjectService();
