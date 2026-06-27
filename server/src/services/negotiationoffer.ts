import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class NegotiationOfferService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.negotiationOffer, "negotiationOffer");
  }
}

export const negotiationOfferService = new NegotiationOfferService();
