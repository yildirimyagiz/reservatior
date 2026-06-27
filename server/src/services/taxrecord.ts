import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { globalTaxRegulationService } from "./globaltaxregulation";

export class TaxRecordService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.taxRecord, "taxRecord");
  }

  /**
   * Automatically record tax for a transaction based on property regulations
   */
  async createFromTransaction(params: {
    orgId: string,
    propertyId: string,
    amount: number,
    transactionId: string,
    recordType: string
  }) {
    const { orgId, propertyId, amount, transactionId, recordType } = params;
    
    // Get the property to know the country
    const property = await prisma.property.findUnique({ where: { id: propertyId } });
    if (!property || !property.country) return null;

    // Calculate tax using the new engine
    const taxResult = globalTaxRegulationService.calculateTax(amount, property.country);

    // Create the tax record
    return prisma.taxRecord.create({
      data: {
        orgId,
        propertyId,
        transactionId,
        recordType,
        profileData: {
          calculation: taxResult,
          appliedRate: taxResult.rate,
          baseAmount: amount,
          taxAmount: taxResult.tax,
          currency: property.currency
        },
        categoryData: {
            taxAuthority: (globalTaxRegulationService.getDefaultRates(property.country)[0]?.taxAuthority || "Standard"),
            taxType: (globalTaxRegulationService.getDefaultRates(property.country)[0]?.taxType || "VAT")
        },
        isActive: true
      }
    });
  }
}

export const taxRecordService = new TaxRecordService();
