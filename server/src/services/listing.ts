import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ListingService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.listing, "listing");
  }
}

export const listingService = new ListingService();
