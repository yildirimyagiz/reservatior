import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class SupplierService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.supplier, "supplier");
  }

  async getWithProducts(supplierId: string) {
    return prisma.supplier.findUnique({
      where: { id: supplierId },
      include: { products: { where: { isActive: true } } }
    });
  }
}

export const supplierService = new SupplierService();
