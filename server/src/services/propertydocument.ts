import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class PropertyDocumentService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.propertyDocument, "propertyDocument");
  }
}

export const propertyDocumentService = new PropertyDocumentService();
