import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class MlsListingEnhancementService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.mlsListingEnhancement, "mlsListingEnhancement");
  }
}

export const mlsListingEnhancementService = new MlsListingEnhancementService();
