import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class DocumentTemplateService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.documentTemplate, "documentTemplate");
  }
}

export const documentTemplateService = new DocumentTemplateService();
