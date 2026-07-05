import { getExecutionLockConfig } from "./src/lib/config/execution-lock";
import { DisputeResolver } from "./src/core/dispute/resolver";
import { contractMutator } from "./src/services/contract-mutator";
import { prismaManager } from "./src/lib/prisma";

async function runExecutionLocksTest() {
  console.log("🚀 STARTING EXECUTION LOCKS & CONTRACT LIFECYCLE VALIDATION\n");

  try {
    // -------------------------------------------------------------
    // Test 1: Config Override Verification
    // -------------------------------------------------------------
    console.log("📁 1. Verifying Region-Specific Config Rules...");
    const trConfig = getExecutionLockConfig("TR");
    const aeConfig = getExecutionLockConfig("AE");
    const usConfig = getExecutionLockConfig("US");

    console.log(`[TR Config] forceEscrow: ${trConfig.forceEscrow}, threshold: ${trConfig.disputeConfidenceThreshold}`);
    console.log(`[AE Config] forceEscrow: ${aeConfig.forceEscrow}, threshold: ${aeConfig.disputeConfidenceThreshold}`);
    console.log(`[US Config] forceEscrow: ${usConfig.forceEscrow}, threshold: ${usConfig.disputeConfidenceThreshold}`);

    if (trConfig.disputeConfidenceThreshold !== 0.90 || !trConfig.forceEscrow) {
      throw new Error("❌ TR Config override failed");
    }
    if (aeConfig.disputeConfidenceThreshold !== 0.90 || !aeConfig.forceEscrow) {
      throw new Error("❌ AE Config override failed");
    }
    if (usConfig.disputeConfidenceThreshold !== 0.85 || usConfig.forceEscrow) {
      throw new Error("❌ US Default Config failed");
    }
    console.log("✅ Config override rules verification passed!\n");

    // -------------------------------------------------------------
    // Test 2: AI Dispute Threshold & Auto-Escalation Logic
    // -------------------------------------------------------------
    console.log("🤖 2. Testing AI Dispute Threshold Enforcement...");
    const trResolver = new DisputeResolver("TR");
    const usResolver = new DisputeResolver("US");

    // Mock high-confidence damage analysis: 95%
    const mockHighConfidence = {
      recommendedAction: "RELEASE_TO_LANDLORD" as const,
      splitRatio: 1.0,
      confidence: 0.95,
      reasoning: "Strong photographic evidence.",
      evidenceGaps: []
    };

    // Mock medium-confidence analysis: 88%
    const mockMedConfidence = {
      recommendedAction: "RELEASE_TO_LANDLORD" as const,
      splitRatio: 1.0,
      confidence: 0.88,
      reasoning: "Partial photographic evidence.",
      evidenceGaps: []
    };

    // TR threshold is 90% (0.90).
    // Med confidence (88%) in TR should auto-escalate to human.
    const trMedEnforced = (trResolver as any).enforceThreshold(mockMedConfidence);
    console.log(`[TR - 88% Conf] Resolved Action: ${trMedEnforced.recommendedAction}`);
    console.log(`[TR - 88% Conf] Reasoning: ${trMedEnforced.reasoning}`);
    if (trMedEnforced.recommendedAction !== "ESCALATE_HUMAN") {
      throw new Error("❌ TR 88% confidence should have auto-escalated to human review");
    }

    // US threshold is 85% (0.85).
    // Med confidence (88%) in US should pass and resolve.
    const usMedEnforced = (usResolver as any).enforceThreshold(mockMedConfidence);
    console.log(`[US - 88% Conf] Resolved Action: ${usMedEnforced.recommendedAction}`);
    if (usMedEnforced.recommendedAction !== "RELEASE_TO_LANDLORD") {
      throw new Error("❌ US 88% confidence should have resolved to LANDLORD");
    }

    // High confidence (95%) in TR should pass.
    const trHighEnforced = (trResolver as any).enforceThreshold(mockHighConfidence);
    console.log(`[TR - 95% Conf] Resolved Action: ${trHighEnforced.recommendedAction}`);
    if (trHighEnforced.recommendedAction !== "RELEASE_TO_LANDLORD") {
      throw new Error("❌ TR 95% confidence should have resolved to LANDLORD");
    }

    console.log("✅ AI Dispute confidence threshold enforcement verification passed!\n");

    // -------------------------------------------------------------
    // Test 3: Contract Mutator State Machine Preconditions
    // -------------------------------------------------------------
    console.log("🔄 3. Testing Contract State Transitions and Guards...");
    const prismaTr = prismaManager.getClient("TR");

    // Fetch an existing organization in TR database to avoid Fkey violation
    const existingOrg = await prismaTr.organization.findFirst();
    if (!existingOrg) {
      throw new Error("❌ No organization found in TR database to associate the test contract");
    }
    const orgId = existingOrg.id;
    const contract = await prismaTr.contract.create({
      data: {
        orgId,
        title: "Test State Machine Lifecycle",
        status: "DRAFT",
        type: "RENTAL_LEASE",
      }
    });

    console.log(`Created DRAFT Contract: ${contract.id}`);

    // DRAFT -> REVIEW (Allowed)
    console.log("Transitioning: DRAFT -> REVIEW");
    const afterReview = await contractMutator.withRegion("TR").transition(contract.id, "REVIEW", "CONTRACT_SUBMITTED_FOR_REVIEW");
    if (afterReview.status !== "REVIEW") {
      throw new Error("❌ Failed to transition from DRAFT to REVIEW");
    }

    // REVIEW -> APPROVED (Allowed)
    console.log("Transitioning: REVIEW -> APPROVED");
    const afterApproved = await contractMutator.withRegion("TR").transition(contract.id, "APPROVED", "CONTRACT_APPROVED");
    if (afterApproved.status !== "APPROVED") {
      throw new Error("❌ Failed to transition from REVIEW to APPROVED");
    }

    // APPROVED -> SIGNING (Allowed)
    console.log("Transitioning: APPROVED -> SIGNING");
    const afterSigning = await contractMutator.withRegion("TR").transition(contract.id, "SIGNING", "CONTRACT_SENT_FOR_SIGNING");
    if (afterSigning.status !== "SIGNING") {
      throw new Error("❌ Failed to transition from APPROVED to SIGNING");
    }

    // SIGNING -> ACTIVE (Should fail in TR because forceEscrow and requireSignatureBeforeActive are true)
    console.log("Transitioning: SIGNING -> ACTIVE (Expecting failure in TR)...");
    try {
      await contractMutator.withRegion("TR").transition(contract.id, "ACTIVE", "ALL_CONDITIONS_MET");
      throw new Error("❌ Expected transition to ACTIVE to fail due to missing escrow and signatures, but it succeeded!");
    } catch (e: any) {
      console.log(`Received Expected Failure: ${e.message}`);
      if (!e.message.includes("Contract cannot become ACTIVE")) {
        throw new Error(`❌ Unexpected error message: ${e.message}`);
      }
    }

    // Clean up
    console.log(`Cleaning up test contract: ${contract.id}`);
    await prismaTr.contractTransition.deleteMany({ where: { contractId: contract.id } });
    await prismaTr.contract.delete({ where: { id: contract.id } });

    console.log("\n🎉 ALL EXECUTION LOCK SYSTEM TESTS PASSED SUCCESSFULLY!");
  } catch (error) {
    console.error("❌ TEST FAILED:", error);
    process.exit(1);
  }
}

runExecutionLocksTest();
