/**
 * Policy OS Client Stub
 * The central nervous system for all REOS business decisions.
 * Every OS module must query this client instead of hardcoding rules.
 */

import { RuleEngine, PolicyRule } from './rule-engine';

export interface PolicyContext {
  countryCode: string;
  userId?: string;
  partnerId?: string;
  transactionAmount?: number;
  propertyType?: string;
}

// In a real system, these rules would be fetched from a database (e.g., PostgreSQL).
// We initialize them here to demonstrate the Policy OS dynamic rule engine.
const defaultRules: PolicyRule[] = [
  {
    id: 'tax-uk',
    name: 'UK Tax Rate',
    type: 'TAX',
    condition: { "==": [{ "var": "countryCode" }, "UK"] },
    result: 0.20,
    priority: 100
  },
  {
    id: 'tax-tr',
    name: 'TR Tax Rate',
    type: 'TAX',
    condition: { "==": [{ "var": "countryCode" }, "TR"] },
    result: 0.18,
    priority: 100
  },
  {
    id: 'tax-ae',
    name: 'UAE Tax Rate',
    type: 'TAX',
    condition: { "==": [{ "var": "countryCode" }, "AE"] },
    result: 0.00,
    priority: 100
  },
  {
    id: 'tax-default',
    name: 'Default Tax Rate',
    type: 'TAX',
    condition: true, // Always matches
    result: 0.08,
    priority: 1
  },
  {
    id: 'comm-luxury',
    name: 'Luxury High Value Commission',
    type: 'COMMISSION',
    condition: {
      "and": [
        { "==": [{ "var": "propertyType" }, "LUXURY"] },
        { ">": [{ "var": "transactionAmount" }, 1000000] }
      ]
    },
    result: 0.02,
    priority: 200
  },
  {
    id: 'comm-default',
    name: 'Default Commission',
    type: 'COMMISSION',
    condition: true,
    result: 0.03,
    priority: 1
  },
  {
    id: 'comp-de',
    name: 'Germany KYC Enforcement',
    type: 'COMPLIANCE',
    condition: {
      "and": [
        { "==": [{ "var": "countryCode" }, "DE"] },
        { "==": [{ "var": "userId" }, null] }
      ]
    },
    result: false, // Not allowed
    priority: 200
  },
  {
    id: 'comp-default',
    name: 'Default Compliance Allowed',
    type: 'COMPLIANCE',
    condition: true,
    result: true,
    priority: 1
  }
];

const ruleEngine = new RuleEngine(defaultRules);

export class PolicyOSClient {
  
  /**
   * Queries the Tax Rules policy engine.
   */
  static async getTaxRate(context: PolicyContext): Promise<number> {
    console.log(`[PolicyOS] Evaluating Tax Rules via RuleEngine for context:`, context);
    const result = ruleEngine.evaluate(context as any, 'TAX');
    return result !== null ? result : 0.08;
  }

  /**
   * Queries the Commission Rules policy engine.
   */
  static async getCommissionRate(context: PolicyContext): Promise<number> {
    console.log(`[PolicyOS] Evaluating Commission Rules via RuleEngine for context:`, context);
    const result = ruleEngine.evaluate(context as any, 'COMMISSION');
    return result !== null ? result : 0.03;
  }

  /**
   * Queries the Compliance Rules engine.
   */
  static async isPublishingAllowed(context: PolicyContext): Promise<boolean> {
    console.log(`[PolicyOS] Evaluating Compliance Rules via RuleEngine for context:`, context);
    const result = ruleEngine.evaluate(context as any, 'COMPLIANCE');
    return result !== null ? result : true;
  }
}
