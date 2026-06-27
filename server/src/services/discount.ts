import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class DiscountService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.discount, "discount");
  }
}

export const discountService = new DiscountService();
