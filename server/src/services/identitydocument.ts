import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class IdentityDocumentService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.identityDocument, "identityDocument");
  }
}

export const identityDocumentService = new IdentityDocumentService();
