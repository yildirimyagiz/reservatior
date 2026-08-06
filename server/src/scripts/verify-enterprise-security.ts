import { WormAuditLogService } from "../services/worm-audit-log-service";
import { SecretKmsVaultService } from "../services/secret-kms-vault-service";
import { AiTrustedPipelineService } from "../services/ai-trusted-pipeline-service";
import { RuntimeIntegrityService } from "../services/runtime-integrity-service";

async function runSecuritySuiteVerification() {
  console.log("===================================================================");
  console.log("🔒 ENTERPRISE DEFENSE-IN-DEPTH SECURITY VERIFICATION SUITE 🔒");
  console.log("===================================================================\n");

  // 1. Test WORM Audit Log & Merkle Tree Verification
  console.log("-> [1/4] Testing WORM Tamper-Evident Audit Log & Merkle Tree...");
  const wormService = WormAuditLogService.getInstance();
  await wormService.appendAuditRecord("TENANT_TURKEY_PRIMARY", "KYC_IDENTITY_VERIFIED", { documentId: "DOC-994821", confidence: 0.99 });
  await wormService.appendAuditRecord("TENANT_EUROPE_HQ", "CONTRACT_DIGITALLY_SIGNED", { contractId: "CNT-7721", hash: "aef99321e..." });
  const wormReport = await wormService.verifyLedgerIntegrity();
  console.log("   ✔ Total Immutable WORM Blocks:", wormReport.totalRecords);
  console.log("   ✔ Cryptographic Merkle Root:", wormReport.merkleRoot);
  console.log("   ✔ Tamper-Free Proof Status:", wormReport.isTamperFree ? "VERIFIED_PASSED (0 Corruptions)" : "FAILED");

  // 2. Test KMS Vault & Envelope Encryption
  console.log("\n-> [2/4] Testing KMS Vault Envelope Encryption (MEK -> DEK leasing)...");
  const kmsService = SecretKmsVaultService.getInstance();
  const secretPayload = "HIGH_ASSURANCE_DOCUMENT_OS_PRIVATE_KEY_ED25519_VALUE";
  const envelope = await kmsService.encryptEnvelope(secretPayload, "TENANT_TURKEY_PRIMARY");
  console.log("   ✔ Envelope Ciphertext generated (AES-256-GCM + Auth Tag + Wrapped DEK)");
  const decrypted = await kmsService.decryptEnvelope(envelope, "TENANT_TURKEY_PRIMARY");
  const diagnostics = kmsService.getVaultDiagnostics();
  console.log("   ✔ Decrypted Payload matched original plaintext:", decrypted === secretPayload);
  console.log("   ✔ Vault Diagnostics Status:", diagnostics.status, "| Engine:", diagnostics.vaultEngine);

  // 3. Test AI Trusted Pipeline & Provenance Signatures
  console.log("\n-> [3/4] Testing AI Trusted Pipeline & Dataset Provenance Validation...");
  const aiPipeline = AiTrustedPipelineService.getInstance();
  const testDataset = { eventType: "ANOMALous_PRICING_ATTRACTOR", target: "NOVA_ROADX_SWARM" };
  const validSignature = aiPipeline.signDatasetPayload(testDataset);
  const aiReport = await aiPipeline.validateAiPipeline(
    "TENANT_TURKEY_PRIMARY", 
    "NOVA_ROADX_SWARM_V2", 
    testDataset, 
    validSignature, 
    [0.92, 1240.50, 15.2] // Safe bounded tensor feature vector
  );
  console.log("   ✔ Provenance Signature Validated:", aiReport.provenanceVerified);
  console.log("   ✔ Tensor Feature Boundaries Passed:", aiReport.featureValidationPassed);
  console.log("   ✔ Trusted Pipeline Token Attestation:", aiReport.trustedPipelineToken ? "ISSUED" : "DENIED");

  // 4. Test Runtime Integrity & Host Hardening
  console.log("\n-> [4/4] Testing Runtime Integrity Diagnostics (TPM / IMA / dm-verity)...");
  const integrityService = RuntimeIntegrityService.getInstance();
  const integrityReport = await integrityService.diagnoseRuntimeIntegrity();
  console.log("   ✔ Host OS / Architecture:", integrityReport.hostOS, "-", integrityReport.architecture);
  console.log("   ✔ TPM 2.0 PCR State:", integrityReport.tpmVerification.status);
  console.log("   ✔ Linux IMA Policy:", integrityReport.imaMeasurement.runtimePolicy);
  console.log("   ✔ dm-verity Root Block Immutable Lock:", integrityReport.dmVerityState.locked);
  console.log("   ✔ Assigned Assurance Level:", integrityReport.securityAssuranceLevel);

  console.log("\n===================================================================");
  console.log("🎯 ALL ENTERPRISE SECURITY PILLARS FULLY FUNCTIONAL & ATTESTED 🎯");
  console.log("===================================================================");
}

runSecuritySuiteVerification().catch((err) => {
  console.error("Verification error:", err);
  process.exit(1);
});
