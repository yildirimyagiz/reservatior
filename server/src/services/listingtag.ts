import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ListingTagService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.listingTag, "listingTag");
  }
}

export const listingTagService = new ListingTagService();
