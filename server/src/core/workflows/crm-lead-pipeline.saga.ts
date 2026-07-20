/**
 * Saga: CRM Lead Pipeline
 *
 * Flow:
 *   crm.lead.created
 *       |
 *   [Lead scoring via AI]
 *       |
 *   crm.lead.scored
 *       |
 *   crm.lead.qualified (or crm.lead.unqualified)
 *       |
 *   crm.lead.converted → crm.deal.created
 *       |
 *   crm.deal.stage.changed
 *       |
 *   crm.deal.won (or crm.deal.lost)
 */

import { BaseSaga } from './saga-orchestrator';
import { eventBus } from '../events/event-bus';
import { DomainEvents, EventMessage } from '../events/domain-events';

export class CRMLeadPipelineSaga extends BaseSaga {
  public leadId: string;
  public orgId: string;

  constructor(leadId: string, orgId: string, sagaId?: string) {
    super(sagaId, { step: 'LEAD_CREATED', leadId, orgId });
    this.leadId = leadId;
    this.orgId = orgId;
  }

  protected async compensate(): Promise<void> {
    console.log(`[CRMLeadPipelineSaga] Compensating lead ${this.leadId}. Reverting to NEW...`);
    eventBus.publish(DomainEvents.CRM_LEAD_UNQUALIFIED, { leadId: this.leadId, reason: 'COMPENSATION' }, 'CRMOS', this.sagaId);
  }

  public async onLeadCreated() {
    console.log(`[CRMLeadPipelineSaga] Lead ${this.leadId} created. Running AI scoring...`);
    await this.transition({ step: 'SCORING' });

    // Simulate AI scoring delay
    setTimeout(() => {
      const score = Math.floor(Math.random() * 100);
      eventBus.publish(DomainEvents.CRM_LEAD_SCORED, {
        leadId: this.leadId,
        score,
        orgId: this.orgId,
      }, 'CRMOS', this.sagaId);
    }, 1000);
  }

  public async onLeadScored(msg: EventMessage) {
    const { score } = msg.payload;
    console.log(`[CRMLeadPipelineSaga] Lead ${this.leadId} scored: ${score}. Qualifying...`);
    await this.transition({ step: 'SCORING_COMPLETE', score });

    const qualified = score >= 50;
    const eventName = qualified ? DomainEvents.CRM_LEAD_QUALIFIED : DomainEvents.CRM_LEAD_UNQUALIFIED;
    eventBus.publish(eventName, { leadId: this.leadId, score, qualified, orgId: this.orgId }, 'CRMOS', this.sagaId);
  }

  public async onLeadQualified(msg: EventMessage) {
    console.log(`[CRMLeadPipelineSaga] Lead ${this.leadId} qualified. Converting to deal...`);
    await this.transition({ step: 'CONVERTING' });

    eventBus.publish(DomainEvents.CRM_LEAD_CONVERTED, {
      leadId: this.leadId,
      orgId: this.orgId,
      dealId: `deal_${this.leadId}`,
    }, 'CRMOS', this.sagaId);
  }

  public async onLeadConverted(msg: EventMessage) {
    console.log(`[CRMLeadPipelineSaga] Lead ${this.leadId} converted to deal ${msg.payload.dealId}. Creating deal...`);
    await this.transition({ step: 'DEAL_CREATED' });

    eventBus.publish(DomainEvents.CRM_DEAL_CREATED, {
      dealId: msg.payload.dealId,
      leadId: this.leadId,
      orgId: this.orgId,
    }, 'CRMOS', this.sagaId);
  }

  public async onDealWon(msg: EventMessage) {
    console.log(`[CRMLeadPipelineSaga] Deal ${msg.payload.dealId} WON! Pipeline COMPLETE.`);
    await this.complete();
  }

  public async onDealLost(msg: EventMessage) {
    console.log(`[CRMLeadPipelineSaga] Deal ${msg.payload.dealId} lost. Pipeline completed with LOSS.`);
    await this.complete();
  }
}

// ─── Registry ─────────────────────────────────────────────────────────────────
const activeSagas = new Map<string, CRMLeadPipelineSaga>();

export function registerCRMLeadPipelineListeners() {
  eventBus.subscribe(DomainEvents.CRM_LEAD_CREATED, (msg) => {
    const { leadId, orgId } = msg.payload;
    const saga = new CRMLeadPipelineSaga(leadId, orgId, msg.correlationId);
    activeSagas.set(saga.sagaId, saga);
    saga.onLeadCreated();
    console.log(`[CRMLeadPipelineSaga] Started for lead ${leadId}`);
  });

  eventBus.subscribe(DomainEvents.CRM_LEAD_SCORED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onLeadScored(msg);
  });

  eventBus.subscribe(DomainEvents.CRM_LEAD_QUALIFIED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onLeadQualified(msg);
  });

  eventBus.subscribe(DomainEvents.CRM_LEAD_CONVERTED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onLeadConverted(msg);
  });

  eventBus.subscribe(DomainEvents.CRM_DEAL_WON, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onDealWon(msg);
  });

  eventBus.subscribe(DomainEvents.CRM_DEAL_LOST, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onDealLost(msg);
  });
}
