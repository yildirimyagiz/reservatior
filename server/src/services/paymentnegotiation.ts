import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class PaymentNegotiationService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.paymentNegotiation, "paymentNegotiation");
  }
}

export const paymentNegotiationService = new PaymentNegotiationService();
