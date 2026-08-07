import { PolicyOSClient } from './src/core/policy/policy-os.client';

async function runSimulation() {
  console.log("=== REOS v5 Policy OS JSON Logic Simulation ===");

  const ctxUK = { countryCode: 'UK', transactionAmount: 500000, propertyType: 'RESIDENTIAL' };
  const taxUK = await PolicyOSClient.getTaxRate(ctxUK);
  console.log(`[Test 1] UK Standard Tax: Expected 0.20, Got ${taxUK}`);

  const ctxLuxury = { countryCode: 'TR', transactionAmount: 2000000, propertyType: 'LUXURY' };
  const commLuxury = await PolicyOSClient.getCommissionRate(ctxLuxury);
  console.log(`[Test 2] TR Luxury Commission: Expected 0.02, Got ${commLuxury}`);

  const ctxComplianceDE = { countryCode: 'DE' }; // No userId provided
  const compDE = await PolicyOSClient.isPublishingAllowed(ctxComplianceDE);
  console.log(`[Test 3] DE KYC Enforcement (No User): Expected false, Got ${compDE}`);
  
  const ctxComplianceDE_Auth = { countryCode: 'DE', userId: 'user-123' };
  const compDEAuth = await PolicyOSClient.isPublishingAllowed(ctxComplianceDE_Auth);
  console.log(`[Test 4] DE KYC Enforcement (With User): Expected true, Got ${compDEAuth}`);
}

runSimulation().catch(console.error);
