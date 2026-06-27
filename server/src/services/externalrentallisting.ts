import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ExternalRentalListingService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.externalRentalListing, "externalRentalListing");
  }
}

export const externalRentalListingService = new ExternalRentalListingService();
