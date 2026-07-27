/**
 * Agent Governance v2 - Country-Aware Security & Permissions
 * 
 * Enterprise-grade agent security with country-specific rules:
 * - Which agent can use which tools in which countries
 * - Which data can be accessed in which countries
 * - Which actions require human approval per country
 * - Audit logging for all agent actions with country context
 * - Cross-country agent permissions for multi-country operations
 */

import { countryContextRegistry } from '../events/country/country-context';

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
  EXECUTE_TRANSACTION = 'EXECUTE_TRANSACTION',
  CROSS_COUNTRY_ACCESS = 'CROSS_COUNTRY_ACCESS',
  COUNTRY_SPECIFIC_ACTION = 'COUNTRY_SPECIFIC_ACTION'
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
  OPPORTUNITY_ENGINE = 'OpportunityEngine',
  KNOWLEDGE_GRAPH_AGENT = 'KnowledgeGraphAgent',
  VECTOR_SEARCH_AGENT = 'VectorSearchAgent'
}

export interface AgentActionRequest {
  agentName: AgentType;
  actionType: ActionType;
  country_code: string;
  targetResource: string;
  requiresHumanApproval: boolean;
  context?: Record<string, any>;
}

export interface CountryAgentPermissions {
  country_code: string;
  allowedActions: ActionType[];
  deniedActions: ActionType[];
  allowedResources: string[];
  deniedResources: string[];
  requiresApprovalFor: ActionType[];
  crossCountryAccess?: string[]; // Countries this agent can access
  specialRules?: Record<string, any>;
}

export interface GovernanceResult {
  approved: boolean;
  reason: string;
  requiresHumanApproval: boolean;
  country_code: string;
  auditLog: {
    agentName: string;
    actionType: string;
    country_code: string;
    targetResource: string;
    timestamp: Date;
    decision: string;
    reason: string;
  };
}

export class CountryAwareAgentGovernance {
  private agentPermissions: Map<AgentType, Map<string, CountryAgentPermissions>>; // agent -> country -> permissions
  private auditLog: Array<any>;

  constructor() {
    this.agentPermissions = new Map();
    this.auditLog = [];
    this.initializeDefaultPermissions();
  }

  /**
   * Initialize default country-specific agent permissions
   */
  private initializeDefaultPermissions() {
    const countries = ['TR', 'US', 'AE', 'GB'];

    // Initialize for each country
    countries.forEach(country => {
      this.initializeCountryPermissions(country);
    });

    console.log('[AgentGovernance] Default country-specific permissions initialized');
  }

  /**
   * Initialize permissions for a specific country
   */
  private initializeCountryPermissions(countryCode: string) {
    const countryMap = new Map<string, CountryAgentPermissions>();

    // Valuation Agent Permissions
    countryMap.set(AgentType.VALUATION_AGENT, {
      country_code: countryCode,
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
        ActionType.SEND_DIRECT_OFFER,
        ActionType.CROSS_COUNTRY_ACCESS
      ],
      allowedResources: [
        `Property_${countryCode}`,
        `MarketData_${countryCode}`,
        `ValuationResult_${countryCode}`
      ],
      deniedResources: [
        'OwnerContact',
        'FinanceDB',
        'CRM'
      ],
      requiresApprovalFor: [
        ActionType.WRITE
      ],
      crossCountryAccess: [],
      specialRules: {
        can_access_foreign_data: false,
        requires_local_knowledge: true
      }
    });

    // Strategic Brain Permissions
    countryMap.set(AgentType.STRATEGIC_BRAIN, {
      country_code: countryCode,
      allowedActions: [
        ActionType.READ,
        ActionType.WRITE,
        ActionType.COUNTRY_SPECIFIC_ACTION
      ],
      deniedActions: [
        ActionType.SEND_DIRECT_OFFER,
        ActionType.EXECUTE_TRANSACTION,
        ActionType.UPDATE_FINANCE,
        ActionType.SEND_EMAIL,
        ActionType.SEND_SMS,
        ActionType.DIRECT_DATABASE_WRITE
      ],
      allowedResources: [
        `Property_${countryCode}`,
        `MarketData_${countryCode}`,
        `AnalysisResult_${countryCode}`,
        `CountryContext_${countryCode}`
      ],
      deniedResources: [
        'FinanceDB',
        'TransactionDB',
        'OwnerContact'
      ],
      requiresApprovalFor: [
        ActionType.WRITE
      ],
      crossCountryAccess: [],
      specialRules: {
        requires_country_context: true,
        cultural_consideration_required: true
      }
    });

    // Opportunity Engine Permissions
    countryMap.set(AgentType.OPPORTUNITY_ENGINE, {
      country_code: countryCode,
      allowedActions: [
        ActionType.READ,
        ActionType.WRITE,
        ActionType.COUNTRY_SPECIFIC_ACTION
      ],
      deniedActions: [
        ActionType.SEND_EMAIL,
        ActionType.SEND_SMS,
        ActionType.UPDATE_FINANCE,
        ActionType.EXECUTE_TRANSACTION,
        ActionType.SEND_DIRECT_OFFER,
        ActionType.CROSS_COUNTRY_ACCESS
      ],
      allowedResources: [
        `Property_${countryCode}`,
        `MarketData_${countryCode}`,
        `OpportunityResult_${countryCode}`,
        `CountryContext_${countryCode}`
      ],
      deniedResources: [
        'FinanceDB',
        'TransactionDB',
        'OwnerContact'
      ],
      requiresApprovalFor: [
        ActionType.WRITE
      ],
      crossCountryAccess: [],
      specialRules: {
        uses_country_specific_weights: true,
        applies_country_risk_factors: true
      }
    });

    // Simulation Agent Permissions
    countryMap.set(AgentType.SIMULATION_AGENT, {
      country_code: countryCode,
      allowedActions: [
        ActionType.READ,
        ActionType.COUNTRY_SPECIFIC_ACTION
      ],
      deniedActions: [
        ActionType.WRITE,
        ActionType.EXECUTE_EXTERNAL,
        ActionType.UPDATE_FINANCE,
        ActionType.EXECUTE_TRANSACTION,
        ActionType.SEND_EMAIL,
        ActionType.SEND_SMS,
        ActionType.CROSS_COUNTRY_ACCESS
      ],
      allowedResources: [
        `Property_${countryCode}`,
        `MarketData_${countryCode}`,
        `SimulationResult_${countryCode}`,
        `CountryContext_${countryCode}`
      ],
      deniedResources: [
        'FinanceDB',
        'TransactionDB',
        'CRM',
        'OwnerContact'
      ],
      requiresApprovalFor: [],
      crossCountryAccess: [],
      specialRules: {
        uses_country_market_dynamics: true,
        applies_country_taxation_rules: true
      }
    });

    // Ranking Engine Permissions
    countryMap.set(AgentType.RANKING_ENGINE, {
      country_code: countryCode,
      allowedActions: [
        ActionType.READ,
        ActionType.WRITE,
        ActionType.COUNTRY_SPECIFIC_ACTION
      ],
      deniedActions: [
        ActionType.EXECUTE_TRANSACTION,
        ActionType.UPDATE_FINANCE,
        ActionType.SEND_EMAIL,
        ActionType.SEND_SMS,
        ActionType.CROSS_COUNTRY_ACCESS
      ],
      allowedResources: [
        `Property_${countryCode}`,
        `MarketData_${countryCode}`,
        `RankingResult_${countryCode}`,
        `CountryContext_${countryCode}`
      ],
      deniedResources: [
        'FinanceDB',
        'TransactionDB',
        'OwnerContact'
      ],
      requiresApprovalFor: [
        ActionType.WRITE
      ],
      crossCountryAccess: [],
      specialRules: {
        uses_country_specific_weights: true,
        applies_country_user_preferences: true
      }
    });

    // Knowledge Graph Agent Permissions
    countryMap.set(AgentType.KNOWLEDGE_GRAPH_AGENT, {
      country_code: countryCode,
      allowedActions: [
        ActionType.READ,
        ActionType.WRITE
      ],
      deniedActions: [
        ActionType.SEND_EMAIL,
        ActionType.SEND_SMS,
        ActionType.UPDATE_FINANCE,
        ActionType.EXECUTE_TRANSACTION,
        ActionType.SEND_DIRECT_OFFER,
        ActionType.CROSS_COUNTRY_ACCESS
      ],
      allowedResources: [
        `Property_${countryCode}`,
        `KnowledgeGraph_${countryCode}`,
        `RelationshipData_${countryCode}`
      ],
      deniedResources: [
        'FinanceDB',
        'TransactionDB',
        'OwnerContact'
      ],
      requiresApprovalFor: [
        ActionType.WRITE
      ],
      crossCountryAccess: [],
      specialRules: {
        country_specific_graph: true,
        data_sovereignty_enforced: true
      }
    });

    // Vector Search Agent Permissions
    countryMap.set(AgentType.VECTOR_SEARCH_AGENT, {
      country_code: countryCode,
      allowedActions: [
        ActionType.READ,
        ActionType.WRITE
      ],
      deniedActions: [
        ActionType.SEND_EMAIL,
        ActionType.SEND_SMS,
        ActionType.UPDATE_FINANCE,
        ActionType.EXECUTE_TRANSACTION,
        ActionType.SEND_DIRECT_OFFER,
        ActionType.CROSS_COUNTRY_ACCESS
      ],
      allowedResources: [
        `Property_${countryCode}`,
        `VectorIndex_${countryCode}`,
        `EmbeddingData_${countryCode}`
      ],
      deniedResources: [
        'FinanceDB',
        'TransactionDB',
        'OwnerContact'
      ],
      requiresApprovalFor: [
        ActionType.WRITE
      ],
      crossCountryAccess: [],
      specialRules: {
        country_specific_embeddings: true,
        data_sovereignty_enforced: true
      }
    });

    // Store permissions for this country
    countryMap.forEach((permissions, agentType) => {
      if (!this.agentPermissions.has(agentType as AgentType)) {
        this.agentPermissions.set(agentType as AgentType, new Map());
      }
      this.agentPermissions.get(agentType as AgentType)?.set(countryCode, permissions);
    });
  }

  /**
   * Validate agent action request with country context
   */
  validate(request: AgentActionRequest): GovernanceResult {
    const countryPermissions = this.agentPermissions.get(request.agentName)?.get(request.country_code);
    
    if (!countryPermissions) {
      const result = this.createGovernanceResult(
        false,
        `Agent ${request.agentName} not registered for country ${request.country_code}`,
        request
      );
      this.logAudit(result.auditLog);
      return result;
    }

    // Check if action is explicitly denied
    if (countryPermissions.deniedActions.includes(request.actionType)) {
      const result = this.createGovernanceResult(
        false,
        `⛔ Governance Security Violation: ${request.agentName} cannot perform ${request.actionType} in ${request.country_code}`,
        request
      );
      this.logAudit(result.auditLog);
      return result;
    }

    // Check if action is allowed
    if (!countryPermissions.allowedActions.includes(request.actionType)) {
      const result = this.createGovernanceResult(
        false,
        `Action ${request.actionType} not in allowed list for ${request.agentName} in ${request.country_code}`,
        request
      );
      this.logAudit(result.auditLog);
      return result;
    }

    // Check resource access
    if (this.isResourceDenied(request.targetResource, countryPermissions.deniedResources)) {
      const result = this.createGovernanceResult(
        false,
        `Resource ${request.targetResource} is denied for ${request.agentName} in ${request.country_code}`,
        request
      );
      this.logAudit(result.auditLog);
      return result;
    }

    // Check cross-country access
    if (request.actionType === ActionType.CROSS_COUNTRY_ACCESS) {
      if (!countryPermissions.crossCountryAccess || countryPermissions.crossCountryAccess.length === 0) {
        const result = this.createGovernanceResult(
          false,
          `Agent ${request.agentName} does not have cross-country access in ${request.country_code}`,
          request
        );
        this.logAudit(result.auditLog);
        return result;
      }
    }

    // Check if human approval is required
    const requiresApproval = countryPermissions.requiresApprovalFor.includes(request.actionType);
    
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
      country_code: request.country_code,
      auditLog: {
        agentName: request.agentName,
        actionType: request.actionType,
        country_code: request.country_code,
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
    console.log(`[AgentGovernance] Audit: ${auditLog.agentName} - ${auditLog.actionType} - ${auditLog.country_code} - ${auditLog.decision}`);
  }

  /**
   * Get audit log with country filters
   */
  getAuditLog(filters?: {
    agentName?: AgentType;
    actionType?: ActionType;
    country_code?: string;
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

    if (filters?.country_code) {
      filteredLog = filteredLog.filter(log => log.country_code === filters.country_code);
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
   * Update agent permissions for a specific country
   */
  updateCountryPermissions(
    agentName: AgentType,
    countryCode: string,
    permissions: Partial<CountryAgentPermissions>
  ): void {
    const countryMap = this.agentPermissions.get(agentName);
    
    if (!countryMap) {
      throw new Error(`Agent ${agentName} not found`);
    }

    const current = countryMap.get(countryCode);
    
    if (!current) {
      throw new Error(`Agent ${agentName} not registered for country ${countryCode}`);
    }

    countryMap.set(countryCode, {
      ...current,
      ...permissions
    });

    console.log(`[AgentGovernance] Updated permissions for ${agentName} in ${countryCode}`);
  }

  /**
   * Get agent permissions for a specific country
   */
  getCountryPermissions(agentName: AgentType, countryCode: string): CountryAgentPermissions | undefined {
    return this.agentPermissions.get(agentName)?.get(countryCode);
  }

  /**
   * Get all agent permissions across all countries
   */
  getAllAgentPermissions(): Map<AgentType, Map<string, CountryAgentPermissions>> {
    return new Map(this.agentPermissions);
  }

  /**
   * Grant cross-country access to an agent
   */
  grantCrossCountryAccess(agentName: AgentType, countryCode: string, allowedCountries: string[]): void {
    const countryMap = this.agentPermissions.get(agentName);
    
    if (!countryMap) {
      throw new Error(`Agent ${agentName} not found`);
    }

    const permissions = countryMap.get(countryCode);
    
    if (!permissions) {
      throw new Error(`Agent ${agentName} not registered for country ${countryCode}`);
    }

    permissions.crossCountryAccess = allowedCountries;
    permissions.allowedActions.push(ActionType.CROSS_COUNTRY_ACCESS);

    console.log(`[AgentGovernance] Granted cross-country access to ${agentName} in ${countryCode} for: ${allowedCountries.join(', ')}`);
  }

  /**
   * Revoke cross-country access from an agent
   */
  revokeCrossCountryAccess(agentName: AgentType, countryCode: string): void {
    const countryMap = this.agentPermissions.get(agentName);
    
    if (!countryMap) {
      throw new Error(`Agent ${agentName} not found`);
    }

    const permissions = countryMap.get(countryCode);
    
    if (!permissions) {
      throw new Error(`Agent ${agentName} not registered for country ${countryCode}`);
    }

    permissions.crossCountryAccess = [];
    permissions.allowedActions = permissions.allowedActions.filter(action => action !== ActionType.CROSS_COUNTRY_ACCESS);

    console.log(`[AgentGovernance] Revoked cross-country access from ${agentName} in ${countryCode}`);
  }

  /**
   * Clear audit log
   */
  clearAuditLog(): void {
    this.auditLog = [];
    console.log('[AgentGovernance] Audit log cleared');
  }

  /**
   * Get governance statistics with country breakdown
   */
  getGovernanceStats() {
    const totalActions = this.auditLog.length;
    const approvedActions = this.auditLog.filter(log => log.decision === 'APPROVED').length;
    const deniedActions = this.auditLog.filter(log => log.decision === 'DENIED').length;

    const agentActionCounts = this.auditLog.reduce((counts, log) => {
      counts[log.agentName] = (counts[log.agentName] || 0) + 1;
      return counts;
    }, {} as Record<string, number>);

    const countryActionCounts = this.auditLog.reduce((counts, log) => {
      counts[log.country_code] = (counts[log.country_code] || 0) + 1;
      return counts;
    }, {} as Record<string, number>);

    const countryAgentCounts: Record<string, number> = {};
    this.agentPermissions.forEach((countryMap, agentName) => {
      countryMap.forEach((_, countryCode) => {
        const key = `${countryCode}_${agentName}`;
        countryAgentCounts[key] = (countryAgentCounts[key] || 0) + 1;
      });
    });

    return {
      totalActions,
      approvedActions,
      deniedActions,
      approvalRate: totalActions > 0 ? (approvedActions / totalActions) * 100 : 0,
      agentActionCounts,
      countryActionCounts,
      countryAgentCounts,
      totalAgents: this.agentPermissions.size,
      totalCountries: this.agentPermissions.size > 0 ? this.agentPermissions.values().next().value?.size || 0 : 0
    };
  }

  /**
   * Add new agent to governance for a country
   */
  addAgentToCountry(agentName: AgentType, countryCode: string, permissions: CountryAgentPermissions): void {
    if (!this.agentPermissions.has(agentName)) {
      this.agentPermissions.set(agentName, new Map());
    }

    const countryMap = this.agentPermissions.get(agentName);
    
    if (countryMap?.has(countryCode)) {
      throw new Error(`Agent ${agentName} already registered for country ${countryCode}`);
    }

    countryMap?.set(countryCode, permissions);
    console.log(`[AgentGovernance] Added ${agentName} to ${countryCode}`);
  }

  /**
   * Remove agent from governance for a country
   */
  removeAgentFromCountry(agentName: AgentType, countryCode: string): void {
    const countryMap = this.agentPermissions.get(agentName);
    
    if (!countryMap) {
      throw new Error(`Agent ${agentName} not found`);
    }

    if (!countryMap.has(countryCode)) {
      throw new Error(`Agent ${agentName} not registered for country ${countryCode}`);
    }

    countryMap.delete(countryCode);

    // Remove agent entirely if no countries left
    if (countryMap.size === 0) {
      this.agentPermissions.delete(agentName);
    }

    console.log(`[AgentGovernance] Removed ${agentName} from ${countryCode}`);
  }

  /**
   * Validate country-specific special rules
   */
  validateSpecialRules(request: AgentActionRequest): {
    valid: boolean;
    violations: string[];
  } {
    const permissions = this.agentPermissions.get(request.agentName)?.get(request.country_code);
    
    if (!permissions || !permissions.specialRules) {
      return { valid: true, violations: [] };
    }

    const violations: string[] = [];

    // Check country context requirement
    if (permissions.specialRules.requires_country_context) {
      const countryContext = countryContextRegistry.getContext(request.country_code);
      if (!countryContext) {
        violations.push(`Country context not available for ${request.country_code}`);
      }
    }

    // Check data sovereignty
    if (permissions.specialRules.data_sovereignty_enforced) {
      if (request.targetResource && !request.targetResource.includes(request.country_code)) {
        violations.push(`Data sovereignty violation: accessing resource outside ${request.country_code}`);
      }
    }

    return {
      valid: violations.length === 0,
      violations
    };
  }
}

export const countryAwareAgentGovernance = new CountryAwareAgentGovernance();
