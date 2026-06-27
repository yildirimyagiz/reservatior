import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class DocumentService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.document, "document");
  }
}

export const documentService = new DocumentService();
