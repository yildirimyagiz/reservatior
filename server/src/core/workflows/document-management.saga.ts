/**
 * Saga: Document Management
 * 
 * Flow:
 *   document.created
 *       |
 *   [Document processing]
 *       |
 *   document.signature_requested
 *       |
 *   [Signature collection]
 *       |
 *   document.approved
 *       |
 *   [Document finalized]
 */

import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { DomainEvents } from '../events/domain-events';

export class DocumentManagementSaga extends BaseSaga {
  public documentId: string;
  public documentType: string;
  public signers: Array<{ email: string; name: string }>;
  public organizationId: string;

  constructor(
    documentId: string,
    documentType: string,
    signers: Array<{ email: string; name: string }>,
    organizationId: string,
    sagaId?: string,
    localization?: LocalizationContext
  ) {
    super(sagaId, { step: 'DOCUMENT_CREATED', documentId, documentType, signers, organizationId }, localization);
    this.documentId = documentId;
    this.documentType = documentType;
    this.signers = signers;
    this.organizationId = organizationId;
  }

  protected async compensate(): Promise<void> {
    console.log(`[DocumentManagementSaga] Compensating document ${this.documentId}. Revoking signatures and cleaning up...`);
  }

  public async onCreated() {
    console.log(`[DocumentManagementSaga] Document ${this.documentId} created. Processing document...`);
    await this.transition({ step: 'PROCESSING_DOCUMENT' });

    // Simulate document processing
    setTimeout(() => {
      eventBus.publish(DomainEvents.DOCUMENT_SIGNATURE_REQUESTED, {
        documentId: this.documentId,
        documentType: this.documentType,
        signers: this.signers,
        requestedAt: new Date().toISOString(),
        localization: this.localization
      }, 'DocumentOS', this.sagaId);
    }, 1500);
  }

  public async onSignatureRequested(msg: EventMessage) {
    console.log(`[DocumentManagementSaga] Signature requested for document ${this.documentId}. Waiting for signatures...`);
    await this.transition({ step: 'COLLECTING_SIGNATURES' });
    // Saga parks here until all signatures are collected
  }

  public async onUpdated(msg: EventMessage) {
    console.log(`[DocumentManagementSaga] Document ${this.documentId} updated. Checking if all signatures collected...`);
    await this.transition({ step: 'VERIFYING_SIGNATURES' });

    // Simulate signature verification
    setTimeout(() => {
      eventBus.publish(DomainEvents.DOCUMENT_APPROVED, {
        documentId: this.documentId,
        approvedBy: 'system',
        approvedAt: new Date().toISOString(),
        localization: this.localization
      }, 'DocumentOS', this.sagaId);
    }, 1000);
  }

  public async onApproved(msg: EventMessage) {
    console.log(`[DocumentManagementSaga] Document ${this.documentId} approved. DOCUMENT SAGA COMPLETE.`);
    await this.complete();
  }

  public async onVersionCreated(msg: EventMessage) {
    console.log(`[DocumentManagementSaga] New version created for document ${this.documentId}.`);
    await this.transition({ step: 'VERSION_CREATED' });
  }

  public async onDeleted(msg: EventMessage) {
    console.log(`[DocumentManagementSaga] Document ${this.documentId} deleted. SAGA FAILED.`);
    await this.fail('Document was deleted');
  }
}

// ─── Registry ─────────────────────────────────────────────────────────────────
const activeSagas = new Map<string, DocumentManagementSaga>();

export function registerDocumentManagementListeners() {
  eventBus.subscribe(DomainEvents.DOCUMENT_CREATED, (msg) => {
    const { documentId, documentType, signers, organizationId } = msg.payload;
    const localization = msg.localization || {
      countryCode: 'US',
      language: 'en',
      currency: 'USD',
      timezone: 'America/New_York'
    };
    const saga = new DocumentManagementSaga(documentId, documentType, signers, organizationId, msg.correlationId, localization);
    activeSagas.set(saga.sagaId, saga);
    saga.onCreated();
    console.log(`[DocumentManagementSaga] ✅ Started for Document ${documentId}`);
  });

  eventBus.subscribe(DomainEvents.DOCUMENT_SIGNATURE_REQUESTED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onSignatureRequested(msg);
  });

  eventBus.subscribe(DomainEvents.DOCUMENT_UPDATED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onUpdated(msg);
  });

  eventBus.subscribe(DomainEvents.DOCUMENT_APPROVED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onApproved(msg);
  });

  eventBus.subscribe(DomainEvents.DOCUMENT_VERSION_CREATED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onVersionCreated(msg);
  });

  eventBus.subscribe(DomainEvents.DOCUMENT_DELETED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onDeleted(msg);
  });
}
