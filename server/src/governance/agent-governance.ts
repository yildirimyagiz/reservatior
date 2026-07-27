/**
 * Agent Governance Layer - Security & Permissions
 * 
 * Enterprise-grade agent security to prevent unauthorized actions:
 * - Which agent can use which tools
 * - Which data can be accessed
 * - Which actions require human approval
 * - Audit logging for all agent actions
 */

export enum ActionType {
  READ = 'READ',
  WRITE = 'WRITE',
  EXECUTE_EXTERNAL = 'EXECUTE_EXTERNAL',
  UPDATE_FINANCE = 'UPDATE_FINANCE',
  SEND_EMAIL = 'SEND_EMAIL',
  SEND_SMS = 'SEND_SMS',
  UPDATE_CRM = 'UPDATE_CRM',
  DIRECT_DATABASE_WRITE = 'DIRECT_DATABASE_WRITE',
  API_ACCESS = 'API_ACCESS',
  SEND_DIRECT_OFFER = 'SEND_DIRECT_OFFER',
  UPDATE_OWNER_CONTACT = 'UPDATE_OWNER_CONTACT',
  EXECUTE_TRANSACTION = 'EXECUTE_TRANSACTION'
}

export enum AgentType {
  VALUATION_AGENT = 'ValuationAgent',
  COMMUNICATION_AGENT = 'CommunicationAgent',
  STRATEGIC_BRAIN = 'StrategicBrain',
  ACQUISITION_BRAIN = 'AcquisitionBrain',
  SIMULATION_AGENT = 'SimulationAgent',
  RANKING_ENGINE = 'RankingEngine',
  CAMPAIGN_AGENT = 'CampaignAgent',
  CRM_AGENT = 'CRMAgent',
  FINANCE_AGENT = 'FinanceAgent',
  SEO_INTELLIGENCE_AGENT = 'SEOIntelligenceAgent',
  MARKET_INTELLIGENCE_AGENT = 'MarketIntelligenceAgent',
  CONTENT_INTELLIGENCE_AGENT = 'ContentIntelligenceAgent'
}

export enum AgentStatus {
  ACTIVE = 'ACTIVE',
  PAUSED = 'PAUSED',
  DEPRECATED = 'DEPRECATED',
  BLOCKED = 'BLOCKED'
}

export interface AgentRegistry {
  id: string;
  name: AgentType;
  version: string;
  permissions: AgentPermissions;
  eventsConsumed: string[];
  eventsProduced: string[];
  costLimit: CostLimit;
  status: AgentStatus;
  createdAt: Date;
  updatedAt: Date;
}

export interface CostLimit {
  maxDailyCost: number;
  maxMonthlyCost: number;
  currentDailyCost: number;
  currentMonthlyCost: number;
  costPerAction: number;
  currency: string;
}

export interface AgentActionRequest {
  agentName: AgentType;
  actionType: ActionType;
  targetResource: string;
  requiresHumanApproval: boolean;
  context?: Record<string, any>;
}

export interface AgentPermissions {
  allowedActions: ActionType[];
  deniedActions: ActionType[];
  allowedResources: string[];
  deniedResources: string[];
  requiresApprovalFor: ActionType[];
}

export interface GovernanceResult {
  approved: boolean;
  reason: string;
  requiresHumanApproval: boolean;
  auditLog: {
    agentName: string;
    actionType: string;
    targetResource: string;
    timestamp: Date;
    decision: string;
    reason: string;
  };
}

export class AgentGovernance {
  private agentPermissions: Map<AgentType, AgentPermissions>;
  private agentRegistry: Map<AgentType, AgentRegistry>;
  private auditLog: Array<any>;
  private costTracking: Map<AgentType, CostLimit>;

  constructor() {
    this.agentPermissions = new Map();
    this.agentRegistry = new Map();
    this.auditLog = [];
    this.costTracking = new Map();
    this.initializeDefaultPermissions();
    this.initializeAgentRegistry();
  }

  /**
   * Initialize default agent permissions
   */
  private initializeDefaultPermissions() {
    // Valuation Agent Permissions
    this.agentPermissions.set(AgentType.VALUATION_AGENT, {
      allowedActions: [
        ActionType.READ,
        ActionType.WRITE
      ],
      deniedActions: [
        ActionType.SEND_EMAIL,
        ActionType.SEND_SMS,
        ActionType.UPDATE_FINANCE,
        ActionType.UPDATE_OWNER_CONTACT,
        ActionType.EXECUTE_TRANSACTION,
        ActionType.SEND_DIRECT_OFFER
      ],
      allowedResources: [
        'Property',
        'MarketData',
        'ValuationResult'
      ],
      deniedResources: [
        'OwnerContact',
        'FinanceDB',
        'CRM'
      ],
      requiresApprovalFor: [
        ActionType.WRITE
      ]
    });

    // Communication Agent Permissions
    this.agentPermissions.set(AgentType.COMMUNICATION_AGENT, {
      allowedActions: [
        ActionType.READ,
        ActionType.WRITE
      ],
      deniedActions: [
        ActionType.EXECUTE_EXTERNAL,
        ActionType.UPDATE_FINANCE,
        ActionType.DIRECT_DATABASE_WRITE,
        ActionType.API_ACCESS,
        ActionType.EXECUTE_TRANSACTION
      ],
      allowedResources: [
        'OwnerContact',
        'MessageDraft'
      ],
      deniedResources: [
        'FinanceDB',
        'TransactionDB'
      ],
      requiresApprovalFor: [
        ActionType.SEND_EMAIL,
        ActionType.SEND_SMS
      ]
    });

    // Strategic Brain Permissions
    this.agentPermissions.set(AgentType.STRATEGIC_BRAIN, {
      allowedActions: [
        ActionType.READ,
        ActionType.WRITE
      ],
      deniedActions: [
        ActionType.SEND_DIRECT_OFFER,
        ActionType.EXECUTE_TRANSACTION,
        ActionType.UPDATE_FINANCE,
        ActionType.SEND_EMAIL,
        ActionType.SEND_SMS
      ],
      allowedResources: [
        'Property',
        'MarketData',
        'AnalysisResult'
      ],
      deniedResources: [
        'FinanceDB',
        'TransactionDB',
        'OwnerContact'
      ],
      requiresApprovalFor: [
        ActionType.WRITE
      ]
    });

    // Acquisition Brain Permissions
    this.agentPermissions.set(AgentType.ACQUISITION_BRAIN, {
      allowedActions: [
        ActionType.READ,
        ActionType.WRITE
      ],
      deniedActions: [
        ActionType.EXECUTE_TRANSACTION,
        ActionType.UPDATE_FINANCE,
        ActionType.SEND_DIRECT_OFFER
      ],
      allowedResources: [
        'Property',
        'FeatureStore',
        'OpportunityResult'
      ],
      deniedResources: [
        'FinanceDB',
        'TransactionDB'
      ],
      requiresApprovalFor: [
        ActionType.WRITE
      ]
    });

    // Simulation Agent Permissions
    this.agentPermissions.set(AgentType.SIMULATION_AGENT, {
      allowedActions: [
        ActionType.READ
      ],
      deniedActions: [
        ActionType.WRITE,
        ActionType.EXECUTE_EXTERNAL,
        ActionType.UPDATE_FINANCE,
        ActionType.EXECUTE_TRANSACTION,
        ActionType.SEND_EMAIL,
        ActionType.SEND_SMS
      ],
      allowedResources: [
        'Property',
        'MarketData',
        'SimulationResult'
      ],
      deniedResources: [
        'FinanceDB',
        'TransactionDB',
        'CRM',
        'OwnerContact'
      ],
      requiresApprovalFor: []
    });

    // Campaign Agent Permissions
    this.agentPermissions.set(AgentType.CAMPAIGN_AGENT, {
      allowedActions: [
        ActionType.READ,
        ActionType.WRITE
      ],
      deniedActions: [
        ActionType.EXECUTE_TRANSACTION,
        ActionType.UPDATE_FINANCE,
        ActionType.UPDATE_CRM
      ],
      allowedResources: [
        'Property',
        'CampaignData',
        'AdAccount'
      ],
      deniedResources: [
        'FinanceDB',
        'TransactionDB'
      ],
      requiresApprovalFor: [
        ActionType.WRITE
      ]
    });

    // CRM Agent Permissions
    this.agentPermissions.set(AgentType.CRM_AGENT, {
      allowedActions: [
        ActionType.READ,
        ActionType.WRITE
      ],
      deniedActions: [
        ActionType.EXECUTE_TRANSACTION,
        ActionType.UPDATE_FINANCE
      ],
      allowedResources: [
        'CRM',
        'OwnerContact',
        'LeadData'
      ],
      deniedResources: [
        'FinanceDB',
        'TransactionDB'
      ],
      requiresApprovalFor: [
        ActionType.WRITE
      ]
    });

    // Finance Agent Permissions
    this.agentPermissions.set(AgentType.FINANCE_AGENT, {
      allowedActions: [
        ActionType.READ,
        ActionType.WRITE
      ],
      deniedActions: [
        ActionType.EXECUTE_TRANSACTION,
        ActionType.SEND_EMAIL,
        ActionType.SEND_SMS
      ],
      allowedResources: [
        'FinanceDB',
        'TransactionDB',
        'CommissionData'
      ],
      deniedResources: [
        'OwnerContact',
        'CRM'
      ],
      requiresApprovalFor: [
        ActionType.WRITE,
        ActionType.UPDATE_FINANCE
      ]
    });

    console.log('[AgentGovernance] Default permissions initialized');
  }

  /**
   * Initialize agent registry with cost limits
   */
  private initializeAgentRegistry() {
    const now = new Date();

    // SEO Intelligence Agent
    this.agentRegistry.set(AgentType.SEO_INTELLIGENCE_AGENT, {
      id: 'seo-intelligence-v1',
      name: AgentType.SEO_INTELLIGENCE_AGENT,
      version: '1.0.0',
      permissions: this.agentPermissions.get(AgentType.SEO_INTELLIGENCE_AGENT) || this.createDefaultPermissions(),
      eventsConsumed: ['market.snapshot.created.v1', 'analytics.search.intent.detected.v1'],
      eventsProduced: ['seo.page.generated.v1', 'seo.page.updated.v1'],
      costLimit: {
        maxDailyCost: 100, // $100/day
        maxMonthlyCost: 3000, // $3000/month
        currentDailyCost: 0,
        currentMonthlyCost: 0,
        costPerAction: 0.05, // $0.05 per action
        currency: 'USD'
      },
      status: AgentStatus.ACTIVE,
      createdAt: now,
      updatedAt: now
    });

    // Market Intelligence Agent
    this.agentRegistry.set(AgentType.MARKET_INTELLIGENCE_AGENT, {
      id: 'market-intelligence-v1',
      name: AgentType.MARKET_INTELLIGENCE_AGENT,
      version: '1.0.0',
      permissions: this.agentPermissions.get(AgentType.MARKET_INTELLIGENCE_AGENT) || this.createDefaultPermissions(),
      eventsConsumed: ['listing.created.v1', 'listing.updated.v1', 'transaction.created.v1'],
      eventsProduced: ['market.trend.detected.v1', 'investment.signal.detected.v1'],
      costLimit: {
        maxDailyCost: 150, // $150/day
        maxMonthlyCost: 4500, // $4500/month
        currentDailyCost: 0,
        currentMonthlyCost: 0,
        costPerAction: 0.08, // $0.08 per action
        currency: 'USD'
      },
      status: AgentStatus.ACTIVE,
      createdAt: now,
      updatedAt: now
    });

    // Content Intelligence Agent
    this.agentRegistry.set(AgentType.CONTENT_INTELLIGENCE_AGENT, {
      id: 'content-intelligence-v1',
      name: AgentType.CONTENT_INTELLIGENCE_AGENT,
      version: '1.0.0',
      permissions: this.agentPermissions.get(AgentType.CONTENT_INTELLIGENCE_AGENT) || this.createDefaultPermissions(),
      eventsConsumed: ['seo.page.generated.v1', 'content.refresh.required.v1'],
      eventsProduced: ['ai.content.generated.v1', 'content.refreshed.v1'],
      costLimit: {
        maxDailyCost: 200, // $200/day
        maxMonthlyCost: 6000, // $6000/month
        currentDailyCost: 0,
        currentMonthlyCost: 0,
        costPerAction: 0.10, // $0.10 per action
        currency: 'USD'
      },
      status: AgentStatus.ACTIVE,
      createdAt: now,
      updatedAt: now
    });

    // Initialize cost tracking
    this.agentRegistry.forEach((registry, agentType) => {
      this.costTracking.set(agentType, registry.costLimit);
    });

    console.log('[AgentGovernance] Agent registry initialized with cost limits');
  }

  /**
   * Create default permissions for new agents
   */
  private createDefaultPermissions(): AgentPermissions {
    return {
      allowedActions: [ActionType.READ],
      deniedActions: [
        ActionType.EXECUTE_TRANSACTION,
        ActionType.UPDATE_FINANCE,
        ActionType.SEND_DIRECT_OFFER
      ],
      allowedResources: ['Property', 'MarketData'],
      deniedResources: ['FinanceDB', 'TransactionDB'],
      requiresApprovalFor: [ActionType.WRITE]
    };
  }

  /**
   * Validate agent action request with cost check
   */
  validate(request: AgentActionRequest): GovernanceResult {
    // Check if agent is active
    const registry = this.agentRegistry.get(request.agentName);
    if (registry && registry.status !== AgentStatus.ACTIVE) {
      const result = this.createGovernanceResult(
        false,
        `Agent ${request.agentName} is ${registry.status}`,
        request
      );
      this.logAudit(result.auditLog);
      return result;
    }

    // Check cost limit before action
    const costCheck = this.checkCostLimit(request.agentName);
    if (!costCheck.canExecute) {
      const result = this.createGovernanceResult(
        false,
        `Agent ${request.agentName} has exceeded cost limit: ${costCheck.reason}`,
        request
      );
      this.logAudit(result.auditLog);
      return result;
    }

    const permissions = this.agentPermissions.get(request.agentName);
    
    if (!permissions) {
      const result = this.createGovernanceResult(false, `Agent ${request.agentName} not found in governance registry`, request);
      this.logAudit(result.auditLog);
      return result;
    }

    // Check if action is explicitly denied
    if (permissions.deniedActions.includes(request.actionType)) {
      const result = this.createGovernanceResult(
        false,
        `⛔ Governance Security Violation: ${request.agentName} cannot perform ${request.actionType}`,
        request
      );
      this.logAudit(result.auditLog);
      return result;
    }

    // Check if action is allowed
    if (!permissions.allowedActions.includes(request.actionType)) {
      const result = this.createGovernanceResult(
        false,
        `Action ${request.actionType} not in allowed list for ${request.agentName}`,
        request
      );
      this.logAudit(result.auditLog);
      return result;
    }

    // Check resource access
    if (this.isResourceDenied(request.targetResource, permissions.deniedResources)) {
      const result = this.createGovernanceResult(
        false,
        `Resource ${request.targetResource} is denied for ${request.agentName}`,
        request
      );
      this.logAudit(result.auditLog);
      return result;
    }

    // Check if human approval is required
    const requiresApproval = permissions.requiresApprovalFor.includes(request.actionType);
    
    const result = this.createGovernanceResult(
      true,
      requiresApproval ? 'Action approved but requires human confirmation' : 'Action approved',
      request,
      requiresApproval
    );
    
    this.logAudit(result.auditLog);
    return result;
  }

  /**
   * Check if agent can execute action based on cost limits
   */
  checkCostLimit(agentName: AgentType): { canExecute: boolean; reason?: string } {
    const costLimit = this.costTracking.get(agentName);
    
    if (!costLimit) {
      return { canExecute: true };
    }

    // Check daily limit
    if (costLimit.currentDailyCost >= costLimit.maxDailyCost) {
      return {
        canExecute: false,
        reason: `Daily cost limit reached ($${costLimit.currentDailyCost} / $${costLimit.maxDailyCost})`
      };
    }

    // Check monthly limit
    if (costLimit.currentMonthlyCost >= costLimit.maxMonthlyCost) {
      return {
        canExecute: false,
        reason: `Monthly cost limit reached ($${costLimit.currentMonthlyCost} / $${costLimit.maxMonthlyCost})`
      };
    }

    return { canExecute: true };
  }

  /**
   * Track cost for agent action
   */
  trackCost(agentName: AgentType, actionCount: number = 1): void {
    const costLimit = this.costTracking.get(agentName);
    
    if (!costLimit) {
      return;
    }

    const actionCost = costLimit.costPerAction * actionCount;
    
    costLimit.currentDailyCost += actionCost;
    costLimit.currentMonthlyCost += actionCost;

    // Update registry
    const registry = this.agentRegistry.get(agentName);
    if (registry) {
      registry.costLimit = { ...costLimit };
      registry.updatedAt = new Date();
    }

    // Check if limits exceeded after tracking
    const costCheck = this.checkCostLimit(agentName);
    if (!costCheck.canExecute && costCheck.reason) {
      this.pauseAgent(agentName, costCheck.reason);
    }
  }

  /**
   * Pause agent due to cost limit violation
   */
  pauseAgent(agentName: AgentType, reason: string): void {
    const registry = this.agentRegistry.get(agentName);
    
    if (!registry) {
      return;
    }

    registry.status = AgentStatus.PAUSED;
    registry.updatedAt = new Date();

    console.log(`[AgentGovernance] ⚠️ Agent ${agentName} paused due to: ${reason}`);
    
    // Notify admin (in production, this would send actual notification)
    this.notifyAdmin(agentName, 'PAUSED', reason);
  }

  /**
   * Resume agent
   */
  resumeAgent(agentName: AgentType): void {
    const registry = this.agentRegistry.get(agentName);
    
    if (!registry) {
      return;
    }

    registry.status = AgentStatus.ACTIVE;
    registry.updatedAt = new Date();

    console.log(`[AgentGovernance] Agent ${agentName} resumed`);
  }

  /**
   * Get cost statistics for all agents
   */
  getCostStatistics(): {
    totalDailyCost: number;
    totalMonthlyCost: number;
    agentCosts: Record<string, {
      currentDailyCost: number;
      currentMonthlyCost: number;
      maxDailyCost: number;
      maxMonthlyCost: number;
      utilizationDaily: number;
      utilizationMonthly: number;
      status: AgentStatus;
    }>;
  } {
    let totalDailyCost = 0;
    let totalMonthlyCost = 0;
    const agentCosts: Record<string, any> = {};

    this.costTracking.forEach((costLimit, agentName) => {
      totalDailyCost += costLimit.currentDailyCost;
      totalMonthlyCost += costLimit.currentMonthlyCost;

      const registry = this.agentRegistry.get(agentName);
      
      agentCosts[agentName] = {
        currentDailyCost: costLimit.currentDailyCost,
        currentMonthlyCost: costLimit.currentMonthlyCost,
        maxDailyCost: costLimit.maxDailyCost,
        maxMonthlyCost: costLimit.maxMonthlyCost,
        utilizationDaily: (costLimit.currentDailyCost / costLimit.maxDailyCost) * 100,
        utilizationMonthly: (costLimit.currentMonthlyCost / costLimit.maxMonthlyCost) * 100,
        status: registry?.status || AgentStatus.ACTIVE
      };
    });

    return {
      totalDailyCost,
      totalMonthlyCost,
      agentCosts
    };
  }

  /**
   * Reset daily costs (should be called daily)
   */
  resetDailyCosts(): void {
    this.costTracking.forEach((costLimit, agentName) => {
      costLimit.currentDailyCost = 0;
      
      const registry = this.agentRegistry.get(agentName);
      if (registry) {
        registry.costLimit = { ...costLimit };
        registry.updatedAt = new Date();
      }
    });

    console.log('[AgentGovernance] Daily costs reset for all agents');
  }

  /**
   * Reset monthly costs (should be called monthly)
   */
  resetMonthlyCosts(): void {
    this.costTracking.forEach((costLimit, agentName) => {
      costLimit.currentMonthlyCost = 0;
      
      const registry = this.agentRegistry.get(agentName);
      if (registry) {
        registry.costLimit = { ...costLimit };
        registry.updatedAt = new Date();
      }
    });

    console.log('[AgentGovernance] Monthly costs reset for all agents');
  }

  /**
   * Notify admin about agent status change
   */
  private notifyAdmin(agentName: AgentType, status: string, reason: string): void {
    // In production, this would send actual notification
    console.log(`[AgentGovernance] Admin Notification: Agent ${agentName} status changed to ${status}. Reason: ${reason}`);
  }

  /**
   * Check if resource is denied
   */
  private isResourceDenied(targetResource: string, deniedResources: string[]): boolean {
    return deniedResources.some(denied => targetResource.includes(denied));
  }

  /**
   * Create governance result
   */
  private createGovernanceResult(
    approved: boolean,
    reason: string,
    request: AgentActionRequest,
    requiresHumanApproval: boolean = false
  ): GovernanceResult {
    return {
      approved,
      reason,
      requiresHumanApproval,
      auditLog: {
        agentName: request.agentName,
        actionType: request.actionType,
        targetResource: request.targetResource,
        timestamp: new Date(),
        decision: approved ? 'APPROVED' : 'DENIED',
        reason
      }
    };
  }

  /**
   * Log audit entry
   */
  private logAudit(auditLog: any) {
    this.auditLog.push(auditLog);
    console.log(`[AgentGovernance] Audit: ${auditLog.agentName} - ${auditLog.actionType} - ${auditLog.decision}`);
  }

  /**
   * Get audit log
   */
  getAuditLog(filters?: {
    agentName?: AgentType;
    actionType?: ActionType;
    decision?: string;
    startDate?: Date;
    endDate?: Date;
  }): any[] {
    let filteredLog = [...this.auditLog];

    if (filters?.agentName) {
      filteredLog = filteredLog.filter(log => log.agentName === filters.agentName);
    }

    if (filters?.actionType) {
      filteredLog = filteredLog.filter(log => log.actionType === filters.actionType);
    }

    if (filters?.decision) {
      filteredLog = filteredLog.filter(log => log.decision === filters.decision);
    }

    if (filters?.startDate) {
      filteredLog = filteredLog.filter(log => log.timestamp >= filters.startDate!);
    }

    if (filters?.endDate) {
      filteredLog = filteredLog.filter(log => log.timestamp <= filters.endDate!);
    }

    return filteredLog;
  }

  /**
   * Update agent permissions
   */
  updateAgentPermissions(agentName: AgentType, permissions: Partial<AgentPermissions>): void {
    const current = this.agentPermissions.get(agentName);
    
    if (!current) {
      throw new Error(`Agent ${agentName} not found`);
    }

    this.agentPermissions.set(agentName, {
      ...current,
      ...permissions
    });

    console.log(`[AgentGovernance] Updated permissions for ${agentName}`);
  }

  /**
   * Get agent permissions
   */
  getAgentPermissions(agentName: AgentType): AgentPermissions | undefined {
    return this.agentPermissions.get(agentName);
  }

  /**
   * Get all agent permissions
   */
  getAllAgentPermissions(): Map<AgentType, AgentPermissions> {
    return new Map(this.agentPermissions);
  }

  /**
   * Clear audit log
   */
  clearAuditLog(): void {
    this.auditLog = [];
    console.log('[AgentGovernance] Audit log cleared');
  }

  /**
   * Get governance statistics
   */
  getGovernanceStats() {
    const totalActions = this.auditLog.length;
    const approvedActions = this.auditLog.filter(log => log.decision === 'APPROVED').length;
    const deniedActions = this.auditLog.filter(log => log.decision === 'DENIED').length;

    const agentActionCounts = this.auditLog.reduce((counts, log) => {
      counts[log.agentName] = (counts[log.agentName] || 0) + 1;
      return counts;
    }, {} as Record<string, number>);

    const costStats = this.getCostStatistics();

    return {
      totalActions,
      approvedActions,
      deniedActions,
      approvalRate: totalActions > 0 ? (approvedActions / totalActions) * 100 : 0,
      agentActionCounts,
      totalAgents: this.agentPermissions.size,
      costStatistics: costStats
    };
  }

  /**
   * Get agent registry
   */
  getAgentRegistry(agentName: AgentType): AgentRegistry | undefined {
    return this.agentRegistry.get(agentName);
  }

  /**
   * Get all agent registries
   */
  getAllAgentRegistries(): Map<AgentType, AgentRegistry> {
    return new Map(this.agentRegistry);
  }

  /**
   * Add new agent to governance
   */
  addAgent(agentName: AgentType, permissions: AgentPermissions): void {
    if (this.agentPermissions.has(agentName)) {
      throw new Error(`Agent ${agentName} already exists`);
    }

    this.agentPermissions.set(agentName, permissions);
    console.log(`[AgentGovernance] Added new agent: ${agentName}`);
  }

  /**
   * Remove agent from governance
   */
  removeAgent(agentName: AgentType): void {
    if (!this.agentPermissions.has(agentName)) {
      throw new Error(`Agent ${agentName} not found`);
    }

    this.agentPermissions.delete(agentName);
    console.log(`[AgentGovernance] Removed agent: ${agentName}`);
  }
}

export const agentGovernance = new AgentGovernance();
