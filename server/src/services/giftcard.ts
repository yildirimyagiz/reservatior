import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class GiftCardService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.giftCard, "giftCard");
  }
}

export const giftCardService = new GiftCardService();
