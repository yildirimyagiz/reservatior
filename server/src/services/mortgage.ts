import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class MortgageService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.mortgage, "mortgage");
  }
}

export const mortgageService = new MortgageService();
