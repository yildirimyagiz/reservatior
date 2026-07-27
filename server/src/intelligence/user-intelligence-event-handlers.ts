/**
 * User Intelligence Event Handlers
 * Handles user intelligence events and integrates with the event bus
 */

import { userIntelligenceAgent } from './user-intelligence-agent';
import { DomainEvents } from '../core/events/domain-events';

export class UserIntelligenceEventHandlers {
  /**
   * Handle user intelligence created event
   * Logs the completion of user intelligence profile creation
   */
  async handleUserIntelligenceCreated(event: any): Promise<void> {
    console.log(`[UserIntelligenceEventHandlers] User intelligence created for ${event.userId}`);
    // In production, this would:
    // - Update the user intelligence profile
    // - Trigger property recommendations
    // - Notify relevant agents
  }

  /**
   * Handle user investment profile created event
   * Logs the completion of user investment profile creation
   */
  async handleUserInvestmentProfileCreated(event: any): Promise<void> {
    console.log(`[UserIntelligenceEventHandlers] User investment profile created for ${event.userId}`);
    // In production, this would:
    // - Update the user investment profile
    // - Trigger investment opportunity matching
    // - Update portfolio recommendations
  }

  /**
   * Handle user behavior analyzed event
   * Logs the completion of user behavior analysis
   */
  async handleUserBehaviorAnalyzed(event: any): Promise<void> {
    console.log(`[UserIntelligenceEventHandlers] User behavior analyzed for ${event.userId}`);
    // In production, this would:
    // - Update user behavior patterns
    // - Adjust recommendation algorithms
    // - Update engagement scores
  }

  /**
   * Handle user preference updated event
   * Logs the update of user preferences
   */
  async handleUserPreferenceUpdated(event: any): Promise<void> {
    console.log(`[UserIntelligenceEventHandlers] User preference updated for ${event.userId}`);
    // In production, this would:
    // - Update user preferences
    // - Trigger property re-ranking
    // - Update recommendation engine
  }

  /**
   * Handle lead intelligence created event
   * Logs the completion of lead intelligence profile creation
   */
  async handleLeadIntelligenceCreated(event: any): Promise<void> {
    console.log(`[UserIntelligenceEventHandlers] Lead intelligence created for ${event.leadId}`);
    // In production, this would:
    // - Update the lead intelligence profile
    // - Trigger lead nurturing
    // - Update lead qualification
  }

  /**
   * Handle lead qualification updated event
   * Logs the update of lead qualification
   */
  async handleLeadQualificationUpdated(event: any): Promise<void> {
    console.log(`[UserIntelligenceEventHandlers] Lead qualification updated for ${event.leadId}`);
    // In production, this would:
    // - Update lead qualification
    // - Trigger agent assignment
    // - Update nurturing strategy
  }

  /**
   * Handle agent intelligence created event
   * Logs the completion of agent intelligence profile creation
   */
  async handleAgentIntelligenceCreated(event: any): Promise<void> {
    console.log(`[UserIntelligenceEventHandlers] Agent intelligence created for ${event.agentId}`);
    // In production, this would:
    // - Update the agent intelligence profile
    // - Trigger performance tracking
    // - Update agent ranking
  }

  /**
   * Handle agent performance updated event
   * Logs the update of agent performance
   */
  async handleAgentPerformanceUpdated(event: any): Promise<void> {
    console.log(`[UserIntelligenceEventHandlers] Agent performance updated for ${event.agentId}`);
    // In production, this would:
    // - Update agent performance metrics
    // - Trigger agent ranking updates
    // - Update commission calculations
  }

  /**
   * Handle user created event
   * Triggers user intelligence analysis
   */
  async handleUserCreated(event: any): Promise<void> {
    console.log(`[UserIntelligenceEventHandlers] User created for ${event.userId}, triggering intelligence analysis`);
    
    try {
      await userIntelligenceAgent.handleUserCreated(event);
    } catch (error) {
      console.error(`[UserIntelligenceEventHandlers] Failed to handle user created:`, error);
      throw error;
    }
  }
}

// Singleton instance
export const userIntelligenceEventHandlers = new UserIntelligenceEventHandlers();

/**
 * Event Bus Integration
 * Registers user intelligence event handlers
 */
export function registerUserIntelligenceEventHandlers(eventBus: any): void {
  eventBus.subscribe(DomainEvents.USER_INTELLIGENCE_CREATED, (event: any) => {
    userIntelligenceEventHandlers.handleUserIntelligenceCreated(event);
  });

  eventBus.subscribe(DomainEvents.USER_INVESTMENT_PROFILE_CREATED, (event: any) => {
    userIntelligenceEventHandlers.handleUserInvestmentProfileCreated(event);
  });

  eventBus.subscribe(DomainEvents.USER_BEHAVIOR_ANALYZED, (event: any) => {
    userIntelligenceEventHandlers.handleUserBehaviorAnalyzed(event);
  });

  eventBus.subscribe(DomainEvents.USER_PREFERENCE_UPDATED, (event: any) => {
    userIntelligenceEventHandlers.handleUserPreferenceUpdated(event);
  });

  eventBus.subscribe(DomainEvents.LEAD_INTELLIGENCE_CREATED, (event: any) => {
    userIntelligenceEventHandlers.handleLeadIntelligenceCreated(event);
  });

  eventBus.subscribe(DomainEvents.LEAD_QUALIFICATION_UPDATED, (event: any) => {
    userIntelligenceEventHandlers.handleLeadQualificationUpdated(event);
  });

  eventBus.subscribe(DomainEvents.AGENT_INTELLIGENCE_CREATED, (event: any) => {
    userIntelligenceEventHandlers.handleAgentIntelligenceCreated(event);
  });

  eventBus.subscribe(DomainEvents.AGENT_PERFORMANCE_UPDATED, (event: any) => {
    userIntelligenceEventHandlers.handleAgentPerformanceUpdated(event);
  });

  // Subscribe to user created to trigger intelligence analysis
  eventBus.subscribe(DomainEvents.USER_REGISTERED, (event: any) => {
    userIntelligenceEventHandlers.handleUserCreated(event);
  });

  console.log('[UserIntelligenceEventHandlers] Registered all user intelligence event handlers');
}
