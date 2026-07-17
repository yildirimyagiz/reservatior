/**
 * Saga: Agent Onboarding
 * 
 * Flow:
 *   agent.invited
 *       |
 *   [WhatsApp/Email Invite Sent]
 *       |
 *   agent.accepted (webhook)
 *       |
 *   listing.imported (→ hands off to ListingPipelineSaga)
 */

import { BaseSaga, SagaStatus } from './saga-orchestrator';
import { eventBus } from '../events/event-bus';
import { DomainEvents, EventMessage } from '../events/domain-events';

export class AgentOnboardingSaga extends BaseSaga {
  public agentId: string;

  constructor(agentId: string, sagaId?: string) {
    super(sagaId, { step: 'INVITED', agentId });
    this.agentId = agentId;
  }

  protected async compensate(): Promise<void> {
    console.log(`[AgentOnboardingSaga] Compensating for agent ${this.agentId}. Rolling back invitations...`);
  }

  public async onInvited() {
    console.log(`[AgentOnboardingSaga] Invite dispatched to Agent ${this.agentId}.`);
    await this.transition({ step: 'INVITE_SENT' });
    // Trigger external notification (WhatsApp/Email)
    // In a real impl this calls NotificationService
  }

  public async onAccepted(msg: EventMessage) {
    console.log(`[AgentOnboardingSaga] Agent ${this.agentId} accepted. Importing MLS listings...`);
    await this.transition({ step: 'ACCEPTED' });

    // Hand off to Listing OS — emit event for ListingPipelineSaga to pick up
    setTimeout(() => {
      eventBus.publish(DomainEvents.LISTING_IMPORTED, { agentId: this.agentId, count: 14, source: 'NWMLS' }, 'ListingOS', this.sagaId);
    }, 1000);
  }
}

// ─── Registry ─────────────────────────────────────────────────────────────────
const activeSagas = new Map<string, AgentOnboardingSaga>();

export function registerAgentOnboardingListeners() {
  eventBus.subscribe(DomainEvents.AGENT_INVITED, (msg) => {
    const { agentId } = msg.payload;
    const saga = new AgentOnboardingSaga(agentId, msg.correlationId);
    activeSagas.set(saga.sagaId, saga);
    saga.onInvited();
    console.log(`[AgentOnboardingSaga] ✅ Started for Agent ${agentId}`);
  });

  eventBus.subscribe(DomainEvents.AGENT_ACCEPTED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (!saga) return;
    saga.onAccepted(msg);
  });
}
