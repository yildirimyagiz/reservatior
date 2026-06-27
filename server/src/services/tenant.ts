import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class TenantService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.tenant, "tenant");
  }

  async create(data: any) {
    const tenant = await super.create(data);
    // Calculate initial score after creation
    await this.calculateScore(tenant.id);
    return tenant;
  }

  async calculateScore(tenantId: string) {
    const tenant = await prisma.tenant.findUnique({
      where: { id: tenantId },
      include: {
        Payment: true,
        Lease: true
      }
    });

    if (!tenant) {
      throw new Error("Tenant not found");
    }

    // Calculate payment reliability score
    const totalPayments = tenant.Payment.length;
    const onTimePayments = tenant.Payment.filter(p => {
      if (!p.paymentDate || !p.dueDate) return false;
      return new Date(p.paymentDate) <= new Date(p.dueDate);
    }).length;
    const paymentReliability = totalPayments > 0 ? onTimePayments / totalPayments : 0;

    // Calculate payment history score (0-100)
    const paymentHistoryScore = paymentReliability * 100;

    // Calculate escrow score based on payment status
    const escrowScore = tenant.paymentStatus === 'PAID' ? 1.0 : 0.5;

    // Calculate compliance score
    const rightToRentCheck = (tenant as any).rightToRentCheck ? 15 : 0;
    const immigrationCheck = (tenant as any).immigrationCheck ? 15 : 0;
    const propertyCompliance = (tenant as any).propertyCompliance ? 10 : 0;
    const gasSafetyCheck = (tenant as any).gasSafetyCheck ? 10 : 0;
    const fireSafetyCheck = (tenant as any).fireSafetyCheck ? 10 : 0;
    const energyCertificate = (tenant as any).energyCertificate ? 10 : 0;
    const complianceScore = rightToRentCheck + immigrationCheck + propertyCompliance + gasSafetyCheck + fireSafetyCheck + energyCertificate;

    // Determine compliance status
    let complianceStatus = 'PENDING';
    if (complianceScore >= 60) complianceStatus = 'COMPLIANT';
    else if (complianceScore >= 30) complianceStatus = 'EXPIRING_SOON';
    else complianceStatus = 'NON_COMPLIANT';

    // Calculate overall score
    const creditScore = (tenant as any).creditScore || 0;
    const annualPaymentBonus = (tenant as any).annualPayment ? 10 : 0;
    const openBankingBonus = (tenant as any).openBankingConnected ? 5 : 0;

    const overallScore = (creditScore * 0.25) + (paymentHistoryScore * 0.25) + (paymentReliability * 100 * 0.15) + (escrowScore * 100 * 0.1) + (complianceScore * 0.15) + annualPaymentBonus + openBankingBonus;

    // Determine risk level
    let riskLevel = "MEDIUM";
    if (overallScore >= 80) riskLevel = "LOW";
    else if (overallScore >= 60) riskLevel = "MEDIUM";
    else if (overallScore >= 40) riskLevel = "HIGH";
    else riskLevel = "CRITICAL";

    // Update tenant with calculated scores
    const updated = await prisma.tenant.update({
      where: { id: tenantId },
      data: {
        paymentReliability,
        paymentHistoryScore,
        escrowScore,
        overallScore,
        riskLevel,
        overallComplianceScore: complianceScore,
        complianceStatus,
        latePaymentCount: totalPayments - onTimePayments,
        onTimePaymentCount: onTimePayments,
        totalPaymentAmount: tenant.Payment.reduce((sum, p) => sum + (p.amount || 0), 0),
        lastScoreUpdate: new Date()
      } as any
    });

    return updated;
  }

  async getScore(tenantId: string) {
    const tenant = await prisma.tenant.findUnique({
      where: { id: tenantId },
      select: {
        creditScore: true,
        profession: true,
        professionCategory: true,
        paymentMethod: true,
        paymentHistoryScore: true,
        depositStatus: true,
        escrowScore: true,
        overallScore: true,
        riskLevel: true,
        annualPayment: true,
        commissionHistory: true,
        incomeVerification: true,
        employmentStatus: true,
        employmentStartDate: true,
        monthlyIncome: true,
        bankAccountVerified: true,
        openBankingConnected: true,
        paymentReliability: true,
        latePaymentCount: true,
        onTimePaymentCount: true,
        totalPaymentAmount: true,
        lastScoreUpdate: true
      }
    } as any);

    if (!tenant) {
      return null;
    }

    return tenant;
  }
}

export const tenantService = new TenantService();
