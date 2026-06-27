import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ExportJobService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.exportJob, "exportJob");
  }
}

export const exportJobService = new ExportJobService();
