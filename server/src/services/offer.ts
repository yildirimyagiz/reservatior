import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class OfferService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.offer, "offer");
  }
}

export const offerService = new OfferService();
