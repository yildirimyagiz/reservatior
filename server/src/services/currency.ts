import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class CurrencyService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.currency, "currency");
  }
}

export const currencyService = new CurrencyService();
