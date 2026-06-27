import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class PaymentInstallmentService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.paymentInstallment, "paymentInstallment");
  }
}

export const paymentInstallmentService = new PaymentInstallmentService();
