import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class OwnershipVerificationDocumentService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.ownershipVerificationDocument, "ownershipVerificationDocument");
  }
}

export const ownershipVerificationDocumentService = new OwnershipVerificationDocumentService();
