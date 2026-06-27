import { MarketplaceEngine } from "./marketplace-engine";

async function testProductionCompletion() {
  console.log("=== STARTING MARKETPLACE OS PRODUCTION COMPLETION TEST ===");

  // 1. Test Supply Quality & Trust Governance Engine
  console.log("\n--- 1. Testing Supply Quality & Trust Governance Engine ---");
  
  const highTrustResult = await MarketplaceEngine.evaluatePropertyTrust(
    "prop_001",
    "org_001",
    95,    // cleanliness
    90,    // host reliability
    0,     // cancellations
    true,  // inspection verified
    0      // disputes
  );
  console.log("High Trust (Tier A expected):", JSON.stringify(highTrustResult, null, 2));

  const mediumTrustResult = await MarketplaceEngine.evaluatePropertyTrust(
    "prop_002",
    "org_001",
    70,    // cleanliness
    75,    // host reliability
    2,     // cancellations
    true,  // inspection verified
    1      // disputes
  );
  console.log("Medium Trust (Tier B expected):", JSON.stringify(mediumTrustResult, null, 2));

  const lowTrustResult = await MarketplaceEngine.evaluatePropertyTrust(
    "prop_003",
    "org_001",
    40,    // cleanliness
    50,    // host reliability
    6,     // cancellations
    false, // inspection verified
    4      // disputes
  );
  console.log("Low Trust (Tier C expected):", JSON.stringify(lowTrustResult, null, 2));

  // 2. Test Legal & Compliance Validation Engine
  console.log("\n--- 2. Testing Legal & Compliance Validation Engine ---");

  const trApproved = MarketplaceEngine.validateCompliance(
    5000,   // amount
    "Turkey",
    true,   // host license verified
    "TR"    // jurisdiction
  );
  console.log("TR Compliant Booking:", JSON.stringify(trApproved, null, 2));

  const missingLicense = MarketplaceEngine.validateCompliance(
    12000,
    "Germany",
    false,  // license NOT verified
    "EU"
  );
  console.log("Blocked Booking (No License):", JSON.stringify(missingLicense, null, 2));

  const highValueEu = MarketplaceEngine.validateCompliance(
    35000,  // high value
    "France",
    true,   // license verified
    "EU"
  );
  console.log("Flagged High Value EU Booking:", JSON.stringify(highValueEu, null, 2));

  // 3. Test Closed-Loop Learning Feedback Engine
  console.log("\n--- 3. Testing Closed-Loop Learning Feedback Engine ---");

  const feedbackSuccess = await MarketplaceEngine.submitLearningFeedback(
    "dec_001",
    true,   // conversion success
    120.50, // margin realized
    0.0,    // cancellation cost
    0.0,    // dispute penalty
    false   // fallback failure
  );
  console.log("Feedback Output (High reward expected):", JSON.stringify(feedbackSuccess, null, 2));

  const feedbackFailure = await MarketplaceEngine.submitLearningFeedback(
    "dec_002",
    false,  // conversion failed
    0.0,
    150.00, // host cancellation cost
    50.00,  // dispute penalty
    true    // fallback failed
  );
  console.log("Feedback Output (Negative reward expected):", JSON.stringify(feedbackFailure, null, 2));

  console.log("\n=== MARKETPLACE OS PRODUCTION COMPLETION TEST COMPLETED ===");
}

testProductionCompletion().catch(console.error);
