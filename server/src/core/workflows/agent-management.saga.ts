/**
 * Saga: Agent Management
 * 
 * Flow:
 *   agent.invited
 *       |
 *   [Send invitation via WhatsApp/Email]
 *       |
 *   agent.accepted
 *       |
 *   [Verification process]
 *       |
 *   agent.verified
 *       |
 *   [Import listings]
 *       |
 *   agent.imported
 *       |
 *   [Agent fully onboarded]
 */

import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { DomainEvents } from '../events/domain-events';

export class AgentManagementSaga extends BaseSaga {
  public agentId: string;
  public email: string;
  public phone: string;
  public organizationId: string;

  constructor(
    agentId: string,
    email: string,
    phone: string,
    organizationId: string,
    sagaId?: string,
    localization?: LocalizationContext
  ) {
    super(sagaId, { step: 'AGENT_INVITED', agentId, email, phone, organizationId }, localization);
    this.agentId = agentId;
    this.email = email;
    this.phone = phone;
    this.organizationId = organizationId;
  }

  protected async compensate(): Promise<void> {
    console.log(`[AgentManagementSaga] Compensating agent ${this.agentId}. Revoking invitation and cleaning up...`);
  }

  public async onInvited() {
    console.log(`[AgentManagementSaga] Agent ${this.agentId} invited. Sending invitation...`);
    await this.transition({ step: 'SENDING_INVITATION' });

    // Simulate sending invitation via WhatsApp/Email
    setTimeout(() => {
      eventBus.publish(DomainEvents.AGENT_ACCEPTED, {
        agentId: this.agentId,
        email: this.email,
        phone: this.phone,
        acceptedAt: new Date().toISOString(),
        localization: this.localization
      }, 'AgentOS', this.sagaId);
    }, 2000);
  }

  public async onAccepted(msg: EventMessage) {
    console.log(`[AgentManagementSaga] Agent ${this.agentId} accepted invitation. Starting verification...`);
    await this.transition({ step: 'VERIFYING_AGENT' });

    // Simulate verification process
    setTimeout(() => {
      eventBus.publish(DomainEvents.AGENT_VERIFIED, {
        agentId: this.agentId,
        verifiedAt: new Date().toISOString(),
        verificationMethod: 'document_check',
        localization: this.localization
      }, 'AgentOS', this.sagaId);
    }, 1500);
  }

  public async onVerified(msg: EventMessage) {
    console.log(`[AgentManagementSaga] Agent ${this.agentId} verified. Importing listings...`);
    await this.transition({ step: 'IMPORTING_LISTINGS' });

    // Trigger listing import process
    setTimeout(() => {
      eventBus.publish(DomainEvents.LISTING_IMPORTED, {
        agentId: this.agentId,
        listingCount: 5,
        listingIds: ['listing_1', 'listing_2', 'listing_3', 'listing_4', 'listing_5'],
        localization: this.localization
      }, 'ListingOS', this.sagaId);
    }, 1000);
  }

  public async onImported(msg: EventMessage) {
    console.log(`[AgentManagementSaga] Listings imported for agent ${this.agentId}. AGENT SAGA COMPLETE.`);
    await this.complete();
  }

  public async onInvitationFailed(msg: EventMessage) {
    console.log(`[AgentManagementSaga] Invitation failed for agent ${this.agentId}. SAGA FAILED.`);
    await this.fail('Agent invitation failed');
  }

  public async onVerificationFailed(msg: EventMessage) {
    console.log(`[AgentManagementSaga] Verification failed for agent ${this.agentId}. SAGA FAILED.`);
    await this.fail('Agent verification failed');
  }
}

// ─── Registry ─────────────────────────────────────────────────────────────────
const activeSagas = new Map<string, AgentManagementSaga>();

export function registerAgentManagementListeners() {
  eventBus.subscribe(DomainEvents.AGENT_INVITED, (msg) => {
    const { agentId, email, phone, organizationId } = msg.payload;
    const localization = msg.localization || {
      countryCode: 'US',
      language: 'en',
      currency: 'USD',
      timezone: 'America/New_York'
    };
    const saga = new AgentManagementSaga(agentId, email, phone, organizationId, msg.correlationId, localization);
    activeSagas.set(saga.sagaId, saga);
    saga.onInvited();
    console.log(`[AgentManagementSaga] ✅ Started for Agent ${agentId}`);
  });

  eventBus.subscribe(DomainEvents.AGENT_ACCEPTED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onAccepted(msg);
  });

  eventBus.subscribe(DomainEvents.AGENT_VERIFIED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onVerified(msg);
  });

  eventBus.subscribe(DomainEvents.AGENT_IMPORTED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onImported(msg);
  });
}
