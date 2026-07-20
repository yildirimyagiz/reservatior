/**
 * Document Compliance Saga
 *
 * Flow: document uploaded → log upload, check compliance requirements
 *       contract created → log creation, trigger signature workflow
 */
import { eventBus } from "../events/event-bus";
import { DomainEvents, EventMessage } from "../events/domain-events";

export function registerDocumentComplianceListeners() {
  eventBus.subscribe(DomainEvents.DOCUMENT_UPLOADED, async (msg: EventMessage) => {
    const { documentId, orgId, documentType } = msg.payload;
    console.log(`[DocumentComplianceSaga] 📄 Document uploaded: ${documentId} (type: ${documentType})`);

    eventBus.publish(DomainEvents.AUDIT_LOG_CREATED, {
      action: "DOCUMENT_UPLOADED",
      documentId,
      documentType,
      orgId,
      timestamp: new Date(),
    }, "DocumentOS", msg.correlationId);
  });

  eventBus.subscribe(DomainEvents.CONTRACT_CREATED, async (msg: EventMessage) => {
    const { contractId, orgId, partyIds } = msg.payload;
    console.log(`[DocumentComplianceSaga] 📝 Contract created: ${contractId} (${partyIds?.length} parties)`);

    eventBus.publish(DomainEvents.AUDIT_LOG_CREATED, {
      action: "CONTRACT_CREATED",
      contractId,
      partyIds,
      orgId,
      timestamp: new Date(),
    }, "DocumentOS", msg.correlationId);

    eventBus.publish(DomainEvents.SIGNATURE_REQUESTED, {
      contractId,
      orgId,
      partyIds,
      requestedAt: new Date(),
    }, "DocumentOS", msg.correlationId);
  });

  eventBus.subscribe(DomainEvents.DOCUMENT_ANALYZED, async (msg: EventMessage) => {
    const { documentId, orgId, result } = msg.payload;
    console.log(`[DocumentComplianceSaga] 🔍 Document analyzed: ${documentId} — status: ${result}`);

    eventBus.publish(DomainEvents.AUDIT_LOG_CREATED, {
      action: "DOCUMENT_ANALYZED",
      documentId,
      result,
      orgId,
      timestamp: new Date(),
    }, "DocumentOS", msg.correlationId);
  });
}
