import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class QuoteService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.quote, "quote");
  }
}

export const quoteService = new QuoteService();
