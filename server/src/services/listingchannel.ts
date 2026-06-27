import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ListingChannelService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.listingChannel, "listingChannel");
  }
}

export const listingChannelService = new ListingChannelService();
