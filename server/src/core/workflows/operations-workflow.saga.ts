import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { DomainEvents } from '../events/domain-events';

export class OperationsWorkflowSaga extends BaseSaga {
  public workflowId: string;
  public organizationId: string;

  constructor(workflowId: string, organizationId: string, sagaId?: string, localization?: LocalizationContext) {
    super(sagaId, { step: 'WORKFLOW_STARTED', workflowId, organizationId }, localization);
    this.workflowId = workflowId;
    this.organizationId = organizationId;
  }

  protected async compensate(): Promise<void> {
    console.log(`[OperationsWorkflowSaga] Compensating workflow ${this.workflowId}. Rolling back...`);
  }

  public async onWorkflowStarted() {
    console.log(`[OperationsWorkflowSaga] Workflow ${this.workflowId} started. Assigning tasks...`);
    await this.transition({ step: 'ASSIGNING_TASKS' });
    setTimeout(() => {
      eventBus.publish(DomainEvents.WORKFLOW_COMPLETED, { workflowId: this.workflowId, status: 'completed', localization: this.localization }, 'OperationsOS', this.sagaId);
    }, 2000);
  }

  public async onWorkflowCompleted(msg: EventMessage) {
    console.log(`[OperationsWorkflowSaga] Workflow ${this.workflowId} completed. OPERATIONS SAGA COMPLETE.`);
    await this.complete();
  }
}

const activeSagas = new Map<string, OperationsWorkflowSaga>();

export function registerOperationsWorkflowListeners() {
  eventBus.subscribe(DomainEvents.WORKFLOW_STARTED, (msg) => {
    const saga = new OperationsWorkflowSaga(msg.payload.workflowId, msg.payload.organizationId, msg.correlationId, msg.localization);
    activeSagas.set(saga.sagaId, saga);
    saga.onWorkflowStarted();
  });
  eventBus.subscribe(DomainEvents.WORKFLOW_COMPLETED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onWorkflowCompleted(msg);
  });
}
