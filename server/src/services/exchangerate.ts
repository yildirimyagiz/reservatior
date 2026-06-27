import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ExchangeRateService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.exchangeRate, "exchangeRate");
  }
}

export const exchangeRateService = new ExchangeRateService();
