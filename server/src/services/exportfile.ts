import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ExportFileService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.exportFile, "exportFile");
  }
}

export const exportFileService = new ExportFileService();
