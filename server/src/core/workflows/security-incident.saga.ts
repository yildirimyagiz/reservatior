import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { DomainEvents } from '../events/domain-events';

export class SecurityIncidentSaga extends BaseSaga {
  public incidentId: string;
  public organizationId: string;

  constructor(incidentId: string, organizationId: string, sagaId?: string, localization?: LocalizationContext) {
    super(sagaId, { step: 'SECURITY_ALERT_TRIGGERED', incidentId, organizationId }, localization);
    this.incidentId = incidentId;
    this.organizationId = organizationId;
  }

  protected async compensate(): Promise<void> {
    console.log(`[SecurityIncidentSaga] Compensating incident ${this.incidentId}. Rolling back...`);
  }

  public async onSecurityAlertTriggered() {
    console.log(`[SecurityIncidentSaga] Security alert triggered for ${this.incidentId}. Creating incident...`);
    await this.transition({ step: 'CREATING_INCIDENT' });
    setTimeout(() => {
      eventBus.publish(DomainEvents.SECURITY_INCIDENT_CREATED, { incidentId: this.incidentId, severity: 'high', localization: this.localization }, 'SecurityOS', this.sagaId);
    }, 1000);
  }

  public async onIncidentCreated(msg: EventMessage) {
    console.log(`[SecurityIncidentSaga] Incident created. Running security scan...`);
    await this.transition({ step: 'RUNNING_SECURITY_SCAN' });
    setTimeout(() => {
      eventBus.publish(DomainEvents.SECURITY_SCAN_COMPLETED, { incidentId: this.incidentId, result: 'resolved', localization: this.localization }, 'SecurityOS', this.sagaId);
    }, 2000);
  }

  public async onScanCompleted(msg: EventMessage) {
    console.log(`[SecurityIncidentSaga] Security scan completed. SECURITY SAGA COMPLETE.`);
    await this.complete();
  }
}

const activeSagas = new Map<string, SecurityIncidentSaga>();

export function registerSecurityIncidentListeners() {
  eventBus.subscribe(DomainEvents.SECURITY_ALERT_TRIGGERED, (msg) => {
    const saga = new SecurityIncidentSaga(msg.payload.incidentId, msg.payload.organizationId, msg.correlationId, msg.localization);
    activeSagas.set(saga.sagaId, saga);
    saga.onSecurityAlertTriggered();
  });
  eventBus.subscribe(DomainEvents.SECURITY_INCIDENT_CREATED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onIncidentCreated(msg);
  });
  eventBus.subscribe(DomainEvents.SECURITY_SCAN_COMPLETED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onScanCompleted(msg);
  });
}
