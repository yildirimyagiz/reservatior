import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class MortgageOfferService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.mortgageOffer, "mortgageOffer");
  }
}

export const mortgageOfferService = new MortgageOfferService();
