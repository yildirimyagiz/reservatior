
import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class MLSExternalListingService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.mLSExternalListing, "mLSExternalListing");
  }
}

export const mLSExternalListingService = new MLSExternalListingService();
