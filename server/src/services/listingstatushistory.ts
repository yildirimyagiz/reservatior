import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ListingStatusHistoryService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.listingStatusHistory, "listingStatusHistory");
  }
}

export const listingStatusHistoryService = new ListingStatusHistoryService();
