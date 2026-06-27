import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class PropertyOfferService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.propertyOffer, "propertyOffer");
  }
}

export const propertyOfferService = new PropertyOfferService();
