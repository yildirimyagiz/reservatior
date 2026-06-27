import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class PaymentService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.payment, "payment");
  }
}

export const paymentService = new PaymentService();
