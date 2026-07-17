import { BaseSaga } from './saga-orchestrator';
import { eventBus } from '../events/event-bus';
import { EventMessage } from '../events/domain-events';

export class InviteAgentWorkflow extends BaseSaga {
  public agentId: string;

  constructor(agentId: string, sagaId?: string) {
    super(sagaId, { step: 'INVITED' });
    this.agentId = agentId;
  }

  protected async compensate(): Promise<void> {
    console.log(`[InviteAgentWorkflow] Compensating... Rolling back agent profile ${this.agentId}`);
    // e.g., Set agent status to FAILED, delete partial imports.
  }

  /**
   * Called when Agent accepts the WhatsApp invite
   */
  public async handleAgentAccepted(msg: EventMessage) {
    console.log(`[InviteAgentWorkflow ${this.sagaId}] Agent ${this.agentId} accepted the invite!`);
    await this.transition({ step: 'ACCEPTED' });

    // 1. Tell Listing OS to import their listings
    // We emit an internal command or event that Listing OS listens to.
    console.log(`[InviteAgentWorkflow] ↳ Triggering MLS Import for agent...`);
    // Assuming some mock command dispatch or direct service call
    setTimeout(() => {
      eventBus.publish('listing.imported', { agentId: this.agentId, count: 14 }, "ListingOS", this.sagaId);
    }, 1000);
  }

  /**
   * Called when Listing OS finishes importing the properties
   */
  public async handleListingImported(msg: EventMessage) {
    console.log(`[InviteAgentWorkflow ${this.sagaId}] Listings imported successfully. Count: ${msg.payload.count}`);
    await this.transition({ step: 'LISTINGS_IMPORTED' });

    // 2. Tell AI OS to generate Ads
    console.log(`[InviteAgentWorkflow] ↳ Triggering AI Reel Generation...`);
    setTimeout(() => {
      eventBus.publish('ad.generated', { agentId: this.agentId, videos: 3 }, "AI-OS", this.sagaId);
    }, 1500);
  }

  public async handleAdGenerated(msg: EventMessage) {
    console.log(`[InviteAgentWorkflow ${this.sagaId}] AI Ads generated!`);
    await this.transition({ step: 'ADS_READY' });

    // 3. For the sake of the workflow demo, we skip deal.closed and jump to offering commission
    console.log(`[InviteAgentWorkflow] ↳ Triggering Finance Commission Installment Offer...`);
    setTimeout(() => {
      eventBus.publish('commission.installment.offered', { agentId: this.agentId, amount: 15000 }, "FinanceOS", this.sagaId);
    }, 1000);
  }

  public async handleCommissionOffered(msg: EventMessage) {
    console.log(`[InviteAgentWorkflow ${this.sagaId}] Commission Offer sent to Agent! WORKFLOW COMPLETE.`);
    await this.complete();
  }
}

// ─── Saga Registry / Event Router ──────────────────────────────────────────

const activeSagas = new Map<string, InviteAgentWorkflow>();

export function registerInviteAgentWorkflowListeners() {
  
  // Starter Event
  eventBus.subscribe('agent.invited', (msg) => {
    const { agentId } = msg.payload;
    const saga = new InviteAgentWorkflow(agentId, msg.correlationId);
    activeSagas.set(saga.sagaId, saga);
    console.log(`[SagaRouter] Started InviteAgentWorkflow for Agent ${agentId} (SagaID: ${saga.sagaId})`);
  });

  eventBus.subscribe('agent.accepted', (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.handleAgentAccepted(msg);
  });

  eventBus.subscribe('listing.imported', (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.handleListingImported(msg);
  });

  eventBus.subscribe('ad.generated', (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.handleAdGenerated(msg);
  });

  eventBus.subscribe('commission.installment.offered', (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.handleCommissionOffered(msg);
  });
}
