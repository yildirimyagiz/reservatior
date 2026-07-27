/**
 * Agent Intelligence Event Handlers
 * Handles agent-related events and triggers Agent Passport updates
 */

import { agentIntelligenceAgent } from './agent-intelligence-agent';
import { DomainEvents } from '../core/events/domain-events';

export class AgentIntelligenceEventHandlers {
  /**
   * Handle agent status changed event
   */
  async handleAgentStatusChanged(event: any): Promise<void> {
    console.log(`[AgentIntelligenceEventHandlers] Agent status changed for agent ${event.agentId}`);
    try {
      await agentIntelligenceAgent.processAgentIntelligence({ agentId: event.agentId });
    } catch (error) {
      console.error(`[AgentIntelligenceEventHandlers] Failed to update agent intelligence:`, error);
    }
  }

  /**
   * Handle deal closed event (updates agent conversion rate & performance score)
   */
  async handleDealClosed(event: any): Promise<void> {
    if (event.agentId) {
      console.log(`[AgentIntelligenceEventHandlers] Deal closed for agent ${event.agentId}, recalculating performance`);
      try {
        await agentIntelligenceAgent.processAgentIntelligence({ agentId: event.agentId });
      } catch (error) {
        console.error(`[AgentIntelligenceEventHandlers] Failed to process deal closed for agent:`, error);
      }
    }
  }

  /**
   * Handle lead converted event
   */
  async handleLeadConverted(event: any): Promise<void> {
    if (event.agentId) {
      console.log(`[AgentIntelligenceEventHandlers] Lead converted by agent ${event.agentId}`);
      try {
        await agentIntelligenceAgent.processAgentIntelligence({ agentId: event.agentId });
      } catch (error) {
        console.error(`[AgentIntelligenceEventHandlers] Failed to process lead conversion for agent:`, error);
      }
    }
  }
}

export const agentIntelligenceEventHandlers = new AgentIntelligenceEventHandlers();

export function registerAgentIntelligenceEventHandlers(eventBus: any): void {
  eventBus.subscribe(DomainEvents.AGENT_STATUS_CHANGED, (event: any) => {
    agentIntelligenceEventHandlers.handleAgentStatusChanged(event);
  });

  eventBus.subscribe(DomainEvents.DEAL_CLOSED, (event: any) => {
    agentIntelligenceEventHandlers.handleDealClosed(event);
  });
}
