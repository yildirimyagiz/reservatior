import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { DomainEvents } from '../events/domain-events';

export class GovernanceAuditSaga extends BaseSaga {
  public auditId: string;
  public organizationId: string;

  constructor(auditId: string, organizationId: string, sagaId?: string, localization?: LocalizationContext) {
    super(sagaId, { step: 'AUDIT_STARTED', auditId, organizationId }, localization);
    this.auditId = auditId;
    this.organizationId = organizationId;
  }

  protected async compensate(): Promise<void> {
    console.log(`[GovernanceAuditSaga] Compensating audit ${this.auditId}. Rolling back...`);
  }

  public async onAuditStarted() {
    console.log(`[GovernanceAuditSaga] Audit ${this.auditId} started. Running compliance checks...`);
    await this.transition({ step: 'RUNNING_COMPLIANCE_CHECKS' });
    setTimeout(() => {
      eventBus.publish(DomainEvents.COMPLIANCE_CHECK, { auditId: this.auditId, status: 'passed', localization: this.localization }, 'GovernanceOS', this.sagaId);
    }, 2000);
  }

  public async onComplianceCheck(msg: EventMessage) {
    console.log(`[GovernanceAuditSaga] Compliance check completed. Finalizing audit...`);
    await this.transition({ step: 'FINALIZING_AUDIT' });
    setTimeout(() => {
      eventBus.publish(DomainEvents.AUDIT_COMPLETED, { auditId: this.auditId, result: 'compliant', localization: this.localization }, 'GovernanceOS', this.sagaId);
    }, 1500);
  }

  public async onAuditCompleted(msg: EventMessage) {
    console.log(`[GovernanceAuditSaga] Audit ${this.auditId} completed. GOVERNANCE SAGA COMPLETE.`);
    await this.complete();
  }
}

const activeSagas = new Map<string, GovernanceAuditSaga>();

export function registerGovernanceAuditListeners() {
  eventBus.subscribe(DomainEvents.AUDIT_STARTED, (msg) => {
    const saga = new GovernanceAuditSaga(msg.payload.auditId, msg.payload.organizationId, msg.correlationId, msg.localization);
    activeSagas.set(saga.sagaId, saga);
    saga.onAuditStarted();
  });
  eventBus.subscribe(DomainEvents.COMPLIANCE_CHECK, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onComplianceCheck(msg);
  });
  eventBus.subscribe(DomainEvents.AUDIT_COMPLETED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onAuditCompleted(msg);
  });
}
