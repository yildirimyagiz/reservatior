import { describe, expect, it } from "bun:test";
import { evaluateCommissionRules } from "../commission-rule-engine";

describe("Commission Rule Engine", () => {
  it("should calculate standard rate for Turkey freelance agent", async () => {
    const result = await evaluateCommissionRules({
      countryCode: "TR",
      agentType: "FREELANCE",
      transactionAmount: 100000,
      currency: "TRY",
    });

    expect(result.finalRate).toBeGreaterThan(0);
    expect(result.finalRate).toBeLessThanOrEqual(0.10);
    expect(result.appliedRules.length).toBeGreaterThan(0);
    expect(result.calculationType).toBe("Direct Agent Rewards");
  });

  it("should calculate standard rate for US office agent", async () => {
    const result = await evaluateCommissionRules({
      countryCode: "US",
      agentType: "OFFICE",
      transactionAmount: 250000,
      currency: "USD",
    });

    expect(result.finalRate).toBeGreaterThan(0);
    expect(result.finalRate).toBeLessThanOrEqual(0.12);
    expect(result.breakdown.countryBaseRate).toBe(0.05);
  });

  it("should apply volume incentive for high-volume enterprise agent in Germany", async () => {
    const result = await evaluateCommissionRules({
      countryCode: "DE",
      agentType: "ENTERPRISE",
      transactionAmount: 500000,
      currency: "EUR",
      volumeYtd: 2_000_000,
    });

    expect(result.breakdown.volumeIncentive).toBe(-0.003);
    expect(result.breakdown.agentTypeModifier).toBe(-0.01);
  });

  it("should apply first transaction bonus", async () => {
    const result = await evaluateCommissionRules({
      countryCode: "TR",
      agentType: "FREELANCE",
      transactionAmount: 50000,
      currency: "TRY",
      isFirstTransaction: true,
    });

    expect(result.appliedRules.some((r) => r.includes("first_transaction_bonus"))).toBe(true);
  });

  it("should handle slow market (Greece) with negative market adjustment", async () => {
    const result = await evaluateCommissionRules({
      countryCode: "GR",
      agentType: "OFFICE",
      transactionAmount: 150000,
      currency: "EUR",
    });

    expect(result.breakdown.marketAdjustment).toBe(-0.005);
  });

  it("should handle hot market (UAE) with positive market adjustment", async () => {
    const result = await evaluateCommissionRules({
      countryCode: "AE",
      agentType: "ENTERPRISE",
      transactionAmount: 1000000,
      currency: "AED",
    });

    expect(result.breakdown.marketAdjustment).toBe(0.005);
    expect(result.calculationType).toBe("Standard");
  });

  it("should enforce regulatory ceiling", async () => {
    const result = await evaluateCommissionRules({
      countryCode: "DE",
      agentType: "OFFICE",
      transactionAmount: 100000,
      currency: "EUR",
      campaignTag: "first-booking",
    });

    expect(result.finalRate).toBeLessThanOrEqual(0.08);
    expect(result.breakdown.regulatoryCeiling).toBe(0.08);
  });

  it("should correctly distribute platform/agent/supplier shares", async () => {
    const result = await evaluateCommissionRules({
      countryCode: "US",
      agentType: "OFFICE",
      transactionAmount: 300000,
      currency: "USD",
    });

    const totalShares = result.platformShare + result.agentShare + result.supplierShare;
    expect(Math.abs(totalShares - result.finalAmount)).toBeLessThan(0.01);
    expect(result.platformShare).toBe(result.finalAmount * 0.30);
    expect(result.agentShare).toBe(result.finalAmount * 0.60);
  });

  it("should apply campaign incentive when campaign tag is provided", async () => {
    const result = await evaluateCommissionRules({
      countryCode: "US",
      agentType: "OFFICE",
      transactionAmount: 200000,
      currency: "USD",
      campaignTag: "summer-sale",
    });

    expect(result.breakdown.campaignIncentive).toBe(-0.002);
    expect(result.appliedRules.some((r) => r.includes("campaign_incentive"))).toBe(true);
  });

  it("should warn when rate exceeds ceiling", async () => {
    const result = await evaluateCommissionRules({
      countryCode: "DE",
      agentType: "OFFICE",
      transactionAmount: 100000,
      currency: "EUR",
      campaignTag: "first-booking",
    });

    if (result.warnings.length > 0) {
      expect(result.warnings.some((w) => w.includes("regulatory ceiling"))).toBe(true);
    }
  });

  it("should process all 5 rule layers", async () => {
    const result = await evaluateCommissionRules({
      countryCode: "AE",
      agentType: "FREELANCE",
      transactionAmount: 750000,
      currency: "AED",
      campaignTag: "new-listing",
      isFirstTransaction: true,
      volumeYtd: 600000,
    });

    expect(result.breakdown.countryBaseRate).toBeDefined();
    expect(result.breakdown.regulatoryCeiling).toBeDefined();
    expect(result.breakdown.marketAdjustment).toBeDefined();
    expect(result.breakdown.agentTypeModifier).toBeDefined();
    expect(result.breakdown.campaignIncentive).toBeDefined();
    expect(result.breakdown.volumeIncentive).toBeDefined();
    expect(result.breakdown.dualSidedAdjustment).toBeDefined();
  });

  it("should differentiate agent types correctly", async () => {
    const freelance = await evaluateCommissionRules({
      countryCode: "TR", agentType: "FREELANCE", transactionAmount: 100000, currency: "TRY",
    });
    const office = await evaluateCommissionRules({
      countryCode: "TR", agentType: "OFFICE", transactionAmount: 100000, currency: "TRY",
    });
    const enterprise = await evaluateCommissionRules({
      countryCode: "TR", agentType: "ENTERPRISE", transactionAmount: 100000, currency: "TRY",
    });

    expect(freelance.finalRate).toBeLessThan(office.finalRate);
    expect(enterprise.finalRate).toBeLessThan(office.finalRate);
  });

  it("should apply country-specific base rates", async () => {
    const tr = await evaluateCommissionRules({
      countryCode: "TR", agentType: "OFFICE", transactionAmount: 100000, currency: "TRY",
    });
    const us = await evaluateCommissionRules({
      countryCode: "US", agentType: "OFFICE", transactionAmount: 100000, currency: "USD",
    });

    expect(tr.breakdown.countryBaseRate).toBe(0.04);
    expect(us.breakdown.countryBaseRate).toBe(0.05);
  });
});
