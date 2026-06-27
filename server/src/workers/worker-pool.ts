import { rabbitMQService } from "../services/rabbitmq-service";
import { handleOfferCreated } from "./handlers/offer-negotiator";
import { handleEmergencyMaintenance } from "./handlers/vendor-dispatcher";
import { handleTenantRiskScoring } from "./handlers/tenant-risk-scorer";
import { handleListingMarketingBlitz } from "./handlers/listing-marketing-blitz";
import { handleSmartKeyProvision } from "./handlers/smart-key-provisioner";
import { handleLeaseRenewal } from "./handlers/lease-renewal-agent";
import { handleArrearsChaser } from "./handlers/arrears-ai-chaser";
import { handleSmartContractGeneration } from "./handlers/smart-contract-generator";
import { handleInvoiceOcrVerification } from "./handlers/invoice-ocr-verifier";
import { handleTaxAnomalyDetection } from "./handlers/tax-anomaly-detector";
import { handleComplianceRenewal } from "./handlers/compliance-renewal-agent";
import { handleDocumentExpiry } from "./handlers/document-expiry-revoker";
import { handleSecurityAlertEscalation } from "./handlers/security-alert-escalator";
import { handleViewingFeedbackAnalysis } from "./handlers/viewing-feedback-analyzer";

export async function startWorkerPool() {
  console.log("[WorkerPool] Starting background autonomous workers...");

  // Register Handlers
  const routes: Record<string, (data: any) => Promise<void>> = {
    "OFFER_CREATED": handleOfferCreated,
    "MAINTENANCE_CREATED": handleEmergencyMaintenance,
    "TENANT_APPLICATION_SUBMITTED": handleTenantRiskScoring,
    "PROPERTY_STATUS_CHANGED": handleListingMarketingBlitz,
    "VIEWING_SCHEDULED": handleSmartKeyProvision,
    "VIEWING_COMPLETED": handleViewingFeedbackAnalysis,
    "TENANT_APPLICATION_APPROVED": handleSmartContractGeneration,
    "LEASE_EXPIRY_APPROACHING": handleLeaseRenewal,
    "RENT_PAYMENT_OVERDUE": handleArrearsChaser,
    "INVOICE_UPLOADED": handleInvoiceOcrVerification,
    "QUARTERLY_TAX_REVIEW": handleTaxAnomalyDetection,
    "COMPLIANCE_EXPIRY_APPROACHING": handleComplianceRenewal,
    "DOCUMENT_EXPIRED": handleDocumentExpiry,
    "SECURITY_INCIDENT_CREATED": handleSecurityAlertEscalation,
  };

  // 1. Hook up RabbitMQ if connected (or Fallback In-Memory internally in the service)
  for (const [event, handler] of Object.entries(routes)) {
    await rabbitMQService.consumeQueue(event, async (msg, data) => {
       await handler(data);
    });
  }

  console.log("[WorkerPool] Ready and listening for events.");
}
