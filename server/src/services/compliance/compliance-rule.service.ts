/**
 * Compliance Rule Service
 * 
 * Manages country-specific compliance rules for rental operations across 23 countries.
 * Handles rental law, tax, payment regulation, contract rules, and policy enforcement.
 */

import { prisma } from "../../lib/prisma";

export enum ComplianceCategory {
  RENTAL_LAW = "RENTAL_LAW",
  TAX = "TAX",
  PAYMENT_REGULATION = "PAYMENT_REGULATION",
  CONTRACT_RULES = "CONTRACT_RULES",
  DATA_PROTECTION = "DATA_PROTECTION",
  DISPUTE_RESOLUTION = "DISPUTE_RESOLUTION",
  SECURITY_DEPOSIT = "SECURITY_DEPOSIT",
  EVICTION_PROCESS = "EVICTION_PROCESS",
}

export enum ComplianceSeverity {
  INFO = "INFO",
  WARNING = "WARNING",
  ERROR = "ERROR",
  CRITICAL = "CRITICAL",
}

export interface ComplianceRule {
  id: string;
  country: string;
  region?: string;
  category: ComplianceCategory;
  ruleKey: string;
  description: string;
  severity: ComplianceSeverity;
  isActive: boolean;
  effectiveFrom: Date;
  effectiveTo?: Date;
  metadata: any;
}

export interface ComplianceCheck {
  ruleId: string;
  passed: boolean;
  severity: ComplianceSeverity;
  message: string;
  recommendation?: string;
  metadata?: any;
}

export class ComplianceRuleService {
  /**
   * Get active compliance rules for a country
   */
  async getActiveRules(country: string, category?: ComplianceCategory): Promise<ComplianceRule[]> {
    const where: any = {
      country,
      isActive: true,
      effectiveFrom: { lte: new Date() },
    };

    if (category) {
      where.category = category;
    }

    const rules = await prisma.complianceRule.findMany({
      where,
      orderBy: { severity: "desc" },
    });

    return rules.map((rule) => ({
      id: rule.id,
      country: rule.country,
      region: rule.region,
      category: rule.category as ComplianceCategory,
      ruleKey: rule.ruleKey,
      description: rule.description,
      severity: rule.severity as ComplianceSeverity,
      isActive: rule.isActive,
      effectiveFrom: rule.effectiveFrom,
      effectiveTo: rule.effectiveTo,
      metadata: rule.metadata,
    }));
  }

  /**
   * Check compliance for a rental transaction
   */
  async checkRentalCompliance(
    country: string,
    transactionData: any
  ): Promise<ComplianceCheck[]> {
    const rules = await this.getActiveRules(country);
    const checks: ComplianceCheck[] = [];

    for (const rule of rules) {
      const check = await this.evaluateRule(rule, transactionData);
      checks.push(check);
    }

    return checks;
  }

  /**
   * Evaluate a single compliance rule
   */
  private async evaluateRule(rule: ComplianceRule, data: any): Promise<ComplianceCheck> {
    switch (rule.category) {
      case ComplianceCategory.SECURITY_DEPOSIT:
        return this.evaluateDepositRule(rule, data);
      case ComplianceCategory.RENTAL_LAW:
        return this.evaluateRentalLawRule(rule, data);
      case ComplianceCategory.TAX:
        return this.evaluateTaxRule(rule, data);
      case ComplianceCategory.PAYMENT_REGULATION:
        return this.evaluatePaymentRule(rule, data);
      case ComplianceCategory.CONTRACT_RULES:
        return this.evaluateContractRule(rule, data);
      default:
        return {
          ruleId: rule.id,
          passed: true,
          severity: ComplianceSeverity.INFO,
          message: "Rule not implemented",
        };
    }
  }

  /**
   * Evaluate security deposit rules
   */
  private async evaluateDepositRule(rule: ComplianceRule, data: any): Promise<ComplianceCheck> {
    const { depositAmount, monthlyRent } = data;
    const maxDepositRatio = rule.metadata?.maxDepositRatio || 1; // Default: 1 month rent

    const depositRatio = depositAmount / monthlyRent;

    if (depositRatio > maxDepositRatio) {
      return {
        ruleId: rule.id,
        passed: false,
        severity: rule.severity,
        message: `Security deposit exceeds maximum allowed ratio of ${maxDepositRatio}x monthly rent`,
        recommendation: `Reduce deposit to ${maxDepositRatio}x monthly rent or less`,
        metadata: { currentRatio: depositRatio, maxRatio: maxDepositRatio },
      };
    }

    return {
      ruleId: rule.id,
      passed: true,
      severity: ComplianceSeverity.INFO,
      message: "Security deposit within allowed limits",
      metadata: { currentRatio: depositRatio, maxRatio: maxDepositRatio },
    };
  }

  /**
   * Evaluate rental law rules
   */
  private async evaluateRentalLawRule(rule: ComplianceRule, data: any): Promise<ComplianceCheck> {
    const { leaseDuration, noticePeriod } = data;
    const minLeaseDuration = rule.metadata?.minLeaseDuration || 6; // Default: 6 months
    const minNoticePeriod = rule.metadata?.minNoticePeriod || 30; // Default: 30 days

    if (leaseDuration < minLeaseDuration) {
      return {
        ruleId: rule.id,
        passed: false,
        severity: rule.severity,
        message: `Lease duration below minimum required ${minLeaseDuration} months`,
        recommendation: `Increase lease duration to at least ${minLeaseDuration} months`,
        metadata: { currentDuration: leaseDuration, minDuration: minLeaseDuration },
      };
    }

    if (noticePeriod < minNoticePeriod) {
      return {
        ruleId: rule.id,
        passed: false,
        severity: rule.severity,
        message: `Notice period below minimum required ${minNoticePeriod} days`,
        recommendation: `Increase notice period to at least ${minNoticePeriod} days`,
        metadata: { currentNotice: noticePeriod, minNotice: minNoticePeriod },
      };
    }

    return {
      ruleId: rule.id,
      passed: true,
      severity: ComplianceSeverity.INFO,
      message: "Rental law requirements met",
      metadata: { leaseDuration, noticePeriod },
    };
  }

  /**
   * Evaluate tax rules
   */
  private async evaluateTaxRule(rule: ComplianceRule, data: any): Promise<ComplianceCheck> {
    const { rentalIncome, taxRate } = data;
    const minTaxRate = rule.metadata?.minTaxRate || 0;
    const maxTaxRate = rule.metadata?.maxTaxRate || 100;

    if (taxRate < minTaxRate || taxRate > maxTaxRate) {
      return {
        ruleId: rule.id,
        passed: false,
        severity: rule.severity,
        message: `Tax rate ${taxRate}% outside allowed range (${minTaxRate}% - ${maxTaxRate}%)`,
        recommendation: `Adjust tax rate to be within ${minTaxRate}% - ${maxTaxRate}%`,
        metadata: { currentRate: taxRate, minRate: minTaxRate, maxRate: maxTaxRate },
      };
    }

    return {
      ruleId: rule.id,
      passed: true,
      severity: ComplianceSeverity.INFO,
      message: "Tax rate within allowed range",
      metadata: { taxRate, minTaxRate, maxTaxRate },
    };
  }

  /**
   * Evaluate payment regulation rules
   */
  private async evaluatePaymentRule(rule: ComplianceRule, data: any): Promise<ComplianceCheck> {
    const { paymentMethod, paymentFrequency } = data;
    const allowedPaymentMethods = rule.metadata?.allowedPaymentMethods || ["BANK_TRANSFER"];
    const allowedFrequencies = rule.metadata?.allowedFrequencies || ["MONTHLY"];

    if (!allowedPaymentMethods.includes(paymentMethod)) {
      return {
        ruleId: rule.id,
        passed: false,
        severity: rule.severity,
        message: `Payment method ${paymentMethod} not allowed`,
        recommendation: `Use one of: ${allowedPaymentMethods.join(", ")}`,
        metadata: { currentMethod: paymentMethod, allowedMethods: allowedPaymentMethods },
      };
    }

    if (!allowedFrequencies.includes(paymentFrequency)) {
      return {
        ruleId: rule.id,
        passed: false,
        severity: rule.severity,
        message: `Payment frequency ${paymentFrequency} not allowed`,
        recommendation: `Use one of: ${allowedFrequencies.join(", ")}`,
        metadata: { currentFrequency: paymentFrequency, allowedFrequencies },
      };
    }

    return {
      ruleId: rule.id,
      passed: true,
      severity: ComplianceSeverity.INFO,
      message: "Payment regulation requirements met",
      metadata: { paymentMethod, paymentFrequency },
    };
  }

  /**
   * Evaluate contract rules
   */
  private async evaluateContractRule(rule: ComplianceRule, data: any): Promise<ComplianceCheck> {
    const { contractType, hasDigitalSignature, hasRequiredClauses } = data;
    const requiresDigitalSignature = rule.metadata?.requiresDigitalSignature || false;
    const requiredClauses = rule.metadata?.requiredClauses || [];

    if (requiresDigitalSignature && !hasDigitalSignature) {
      return {
        ruleId: rule.id,
        passed: false,
        severity: rule.severity,
        message: "Digital signature required",
        recommendation: "Obtain digital signature for contract",
        metadata: { hasDigitalSignature },
      };
    }

    const missingClauses = requiredClauses.filter(
      (clause: string) => !hasRequiredClauses?.includes(clause)
    );

    if (missingClauses.length > 0) {
      return {
        ruleId: rule.id,
        passed: false,
        severity: rule.severity,
        message: `Missing required contract clauses: ${missingClauses.join(", ")}`,
        recommendation: `Add missing clauses: ${missingClauses.join(", ")}`,
        metadata: { missingClauses, requiredClauses },
      };
    }

    return {
      ruleId: rule.id,
      passed: true,
      severity: ComplianceSeverity.INFO,
      message: "Contract requirements met",
      metadata: { contractType, hasDigitalSignature, hasRequiredClauses },
    };
  }

  /**
   * Create a new compliance rule
   */
  async createRule(ruleData: Omit<ComplianceRule, "id">): Promise<ComplianceRule> {
    const rule = await prisma.complianceRule.create({
      data: {
        country: ruleData.country,
        region: ruleData.region,
        category: ruleData.category,
        ruleKey: ruleData.ruleKey,
        description: ruleData.description,
        severity: ruleData.severity,
        isActive: ruleData.isActive,
        effectiveFrom: ruleData.effectiveFrom,
        effectiveTo: ruleData.effectiveTo,
        metadata: ruleData.metadata,
      },
    });

    return {
      id: rule.id,
      country: rule.country,
      region: rule.region,
      category: rule.category as ComplianceCategory,
      ruleKey: rule.ruleKey,
      description: rule.description,
      severity: rule.severity as ComplianceSeverity,
      isActive: rule.isActive,
      effectiveFrom: rule.effectiveFrom,
      effectiveTo: rule.effectiveTo,
      metadata: rule.metadata,
    };
  }

  /**
   * Update a compliance rule
   */
  async updateRule(
    id: string,
    ruleData: Partial<Omit<ComplianceRule, "id">>
  ): Promise<ComplianceRule> {
    const rule = await prisma.complianceRule.update({
      where: { id },
      data: {
        ...(ruleData.country && { country: ruleData.country }),
        ...(ruleData.region !== undefined && { region: ruleData.region }),
        ...(ruleData.category && { category: ruleData.category }),
        ...(ruleData.ruleKey && { ruleKey: ruleData.ruleKey }),
        ...(ruleData.description && { description: ruleData.description }),
        ...(ruleData.severity && { severity: ruleData.severity }),
        ...(ruleData.isActive !== undefined && { isActive: ruleData.isActive }),
        ...(ruleData.effectiveFrom && { effectiveFrom: ruleData.effectiveFrom }),
        ...(ruleData.effectiveTo !== undefined && { effectiveTo: ruleData.effectiveTo }),
        ...(ruleData.metadata !== undefined && { metadata: ruleData.metadata }),
      },
    });

    return {
      id: rule.id,
      country: rule.country,
      region: rule.region,
      category: rule.category as ComplianceCategory,
      ruleKey: rule.ruleKey,
      description: rule.description,
      severity: rule.severity as ComplianceSeverity,
      isActive: rule.isActive,
      effectiveFrom: rule.effectiveFrom,
      effectiveTo: rule.effectiveTo,
      metadata: rule.metadata,
    };
  }

  /**
   * Delete a compliance rule
   */
  async deleteRule(id: string): Promise<void> {
    await prisma.complianceRule.delete({
      where: { id },
    });
  }

  /**
   * Get compliance summary for a country
   */
  async getComplianceSummary(country: string): Promise<any> {
    const rules = await this.getActiveRules(country);
    const summary = {
      totalRules: rules.length,
      byCategory: {} as Record<string, number>,
      bySeverity: {} as Record<string, number>,
    };

    for (const rule of rules) {
      summary.byCategory[rule.category] = (summary.byCategory[rule.category] || 0) + 1;
      summary.bySeverity[rule.severity] = (summary.bySeverity[rule.severity] || 0) + 1;
    }

    return summary;
  }
}

export const complianceRuleService = new ComplianceRuleService();
