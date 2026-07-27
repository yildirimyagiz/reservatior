/**
 * Agent Registry - Versioning System
 * 
 * Manages agent versions, models, and configurations:
 * - Track agent versions (v1.0, v1.1, v1.2, etc.)
 * - Model version management (gemini-2.5-flash, gemini-3.0, etc.)
 * - Configuration versioning
 * - A/B testing support
 * - Rollback capabilities
 */

export interface AgentDefinition {
  agentId: string;
  agentName: string;
  agentType: string;
  version: string;
  status: 'ACTIVE' | 'DEPRECATED' | 'DISABLED' | 'EXPERIMENTAL';
  
  // Model configuration
  modelProvider: string;
  modelName: string;
  modelVersion: string;
  
  // Capabilities
  capabilities: string[];
  
  // Configuration
  config: Record<string, any>;
  
  // Performance metrics
  performanceMetrics?: {
    averageAccuracy: number;
    averageResponseTime: number;
    totalExecutions: number;
    successRate: number;
  };
  
  // Metadata
  createdAt: Date;
  updatedAt: Date;
  createdBy: string;
  description: string;
}

export interface AgentVersion {
  agentId: string;
  version: string;
  changelog: string;
  breakingChanges: boolean;
  migrationRequired: boolean;
  releasedAt: Date;
  releasedBy: string;
}

export class AgentRegistry {
  private agents: Map<string, AgentDefinition>;
  private agentVersions: Map<string, AgentVersion[]>;
  private activeAgents: Map<string, string>; // agentName -> agentId

  constructor() {
    this.agents = new Map();
    this.agentVersions = new Map();
    this.activeAgents = new Map();
    this.initializeDefaultAgents();
  }

  /**
   * Initialize default agents
   */
  private initializeDefaultAgents() {
    // Opportunity Engine v1.0
    this.registerAgent({
      agentId: 'opportunity-engine-v1.0',
      agentName: 'OpportunityEngine',
      agentType: 'SCORING_ENGINE',
      version: '1.0',
      status: 'ACTIVE',
      modelProvider: 'INTERNAL',
      modelName: 'mathematical-scoring',
      modelVersion: '1.0',
      capabilities: ['opportunity_scoring', 'risk_assessment', 'yield_calculation'],
      config: {
        weights: {
          yield: 0.25,
          priceGap: 0.20,
          demand: 0.20,
          vacancy: 0.10,
          risk: 0.15,
          liquidity: 0.10
        }
      },
      createdAt: new Date(),
      updatedAt: new Date(),
      createdBy: 'system',
      description: 'Mathematical opportunity scoring engine'
    });

    // Strategic Brain v1.0
    this.registerAgent({
      agentId: 'strategic-brain-v1.0',
      agentName: 'StrategicBrain',
      agentType: 'AI_AGENT',
      version: '1.0',
      status: 'ACTIVE',
      modelProvider: 'GOOGLE',
      modelName: 'gemini-2.5-flash',
      modelVersion: '2.5-flash',
      capabilities: ['strategic_analysis', 'explanation_generation', 'recommendation'],
      config: {
        temperature: 0.7,
        maxTokens: 1000,
        responseFormat: 'JSON'
      },
      createdAt: new Date(),
      updatedAt: new Date(),
      createdBy: 'system',
      description: 'Gemini AI-powered strategic analysis'
    });

    // Simulation Agent v1.0
    this.registerAgent({
      agentId: 'simulation-agent-v1.0',
      agentName: 'SimulationAgent',
      agentType: 'SIMULATION_ENGINE',
      version: '1.0',
      status: 'ACTIVE',
      modelProvider: 'INTERNAL',
      modelName: 'scenario-simulator',
      modelVersion: '1.0',
      capabilities: ['scenario_simulation', 'profit_projection', 'risk_analysis'],
      config: {
        scenarios: ['NORMAL_SALE', 'LUXURY_RENTAL', 'CORPORATE_TENANT', 'SHORT_TERM_RENTAL']
      },
      createdAt: new Date(),
      updatedAt: new Date(),
      createdBy: 'system',
      description: 'Commercial scenario simulation engine'
    });

    console.log('[AgentRegistry] Default agents initialized');
  }

  /**
   * Register new agent
   */
  registerAgent(agent: AgentDefinition): void {
    if (this.agents.has(agent.agentId)) {
      throw new Error(`Agent ${agent.agentId} already exists`);
    }

    this.agents.set(agent.agentId, agent);
    
    // If status is ACTIVE, set as active agent for this type
    if (agent.status === 'ACTIVE') {
      this.activeAgents.set(agent.agentName, agent.agentId);
    }

    // Initialize version history
    if (!this.agentVersions.has(agent.agentName)) {
      this.agentVersions.set(agent.agentName, []);
    }

    this.agentVersions.get(agent.agentName)!.push({
      agentId: agent.agentId,
      version: agent.version,
      changelog: 'Initial version',
      breakingChanges: false,
      migrationRequired: false,
      releasedAt: agent.createdAt,
      releasedBy: agent.createdBy
    });

    console.log(`[AgentRegistry] Registered agent: ${agent.agentName} v${agent.version}`);
  }

  /**
   * Get agent by ID
   */
  getAgent(agentId: string): AgentDefinition | undefined {
    return this.agents.get(agentId);
  }

  /**
   * Get active agent by name
   */
  getActiveAgent(agentName: string): AgentDefinition | undefined {
    const agentId = this.activeAgents.get(agentName);
    if (!agentId) return undefined;
    return this.agents.get(agentId);
  }

  /**
   * Get all agents
   */
  getAllAgents(): AgentDefinition[] {
    return Array.from(this.agents.values());
  }

  /**
   * Get agents by type
   */
  getAgentsByType(agentType: string): AgentDefinition[] {
    return Array.from(this.agents.values()).filter(
      agent => agent.agentType === agentType
    );
  }

  /**
   * Get agents by status
   */
  getAgentsByStatus(status: 'ACTIVE' | 'DEPRECATED' | 'DISABLED' | 'EXPERIMENTAL'): AgentDefinition[] {
    return Array.from(this.agents.values()).filter(
      agent => agent.status === status
    );
  }

  /**
   * Update agent
   */
  updateAgent(agentId: string, updates: Partial<AgentDefinition>): void {
    const agent = this.agents.get(agentId);
    if (!agent) {
      throw new Error(`Agent ${agentId} not found`);
    }

    const updatedAgent = {
      ...agent,
      ...updates,
      updatedAt: new Date()
    };

    this.agents.set(agentId, updatedAgent);

    // Update active agent if status changed to ACTIVE
    if (updates.status === 'ACTIVE') {
      this.activeAgents.set(agent.agentName, agentId);
    }

    console.log(`[AgentRegistry] Updated agent: ${agentId}`);
  }

  /**
   * Deprecate agent
   */
  deprecateAgent(agentId: string, reason: string): void {
    const agent = this.agents.get(agentId);
    if (!agent) {
      throw new Error(`Agent ${agentId} not found`);
    }

    this.updateAgent(agentId, {
      status: 'DEPRECATED',
      description: `${agent.description} (DEPRECATED: ${reason})`
    });

    // Remove from active agents if it was active
    if (this.activeAgents.get(agent.agentName) === agentId) {
      this.activeAgents.delete(agent.agentName);
    }

    console.log(`[AgentRegistry] Deprecated agent: ${agentId}`);
  }

  /**
   * Create new version of agent
   */
  createAgentVersion(
    agentName: string,
    newVersion: string,
    changelog: string,
    breakingChanges: boolean = false,
    releasedBy: string = 'system'
  ): AgentDefinition {
    const currentAgent = this.getActiveAgent(agentName);
    if (!currentAgent) {
      throw new Error(`No active agent found for ${agentName}`);
    }

    const newAgentId = `${agentName.toLowerCase()}-v${newVersion.replace(/\./g, '-')}`;
    
    const newAgent: AgentDefinition = {
      ...currentAgent,
      agentId: newAgentId,
      version: newVersion,
      status: 'EXPERIMENTAL', // New versions start as experimental
      createdAt: new Date(),
      updatedAt: new Date(),
      createdBy: releasedBy
    };

    this.registerAgent(newAgent);

    // Add version history
    this.agentVersions.get(agentName)!.push({
      agentId: newAgentId,
      version: newVersion,
      changelog,
      breakingChanges,
      migrationRequired: breakingChanges,
      releasedAt: new Date(),
      releasedBy
    });

    console.log(`[AgentRegistry] Created new version: ${agentName} v${newVersion}`);

    return newAgent;
  }

  /**
   * Activate agent version
   */
  activateAgentVersion(agentName: string, version: string): void {
    const agentId = `${agentName.toLowerCase()}-v${version.replace(/\./g, '-')}`;
    const agent = this.agents.get(agentId);
    
    if (!agent) {
      throw new Error(`Agent ${agentName} v${version} not found`);
    }

    // Deactivate current active agent
    const currentActiveId = this.activeAgents.get(agentName);
    if (currentActiveId) {
      this.updateAgent(currentActiveId, { status: 'DEPRECATED' });
    }

    // Activate new version
    this.updateAgent(agentId, { status: 'ACTIVE' });
    this.activeAgents.set(agentName, agentId);

    console.log(`[AgentRegistry] Activated ${agentName} v${version}`);
  }

  /**
   * Rollback to previous version
   */
  rollbackAgent(agentName: string, targetVersion?: string): void {
    const versions = this.agentVersions.get(agentName);
    if (!versions || versions.length === 0) {
      throw new Error(`No version history found for ${agentName}`);
    }

    let targetVersionInfo: AgentVersion;
    
    if (targetVersion) {
      targetVersionInfo = versions.find(v => v.version === targetVersion)!;
      if (!targetVersionInfo) {
        throw new Error(`Version ${targetVersion} not found for ${agentName}`);
      }
    } else {
      // Rollback to previous version
      const currentVersion = this.getActiveAgent(agentName)?.version;
      const currentIndex = versions.findIndex(v => v.version === currentVersion);
      
      if (currentIndex <= 0) {
        throw new Error(`No previous version to rollback to for ${agentName}`);
      }
      
      targetVersionInfo = versions[currentIndex - 1];
    }

    this.activateAgentVersion(agentName, targetVersionInfo.version);
    console.log(`[AgentRegistry] Rolled back ${agentName} to v${targetVersionInfo.version}`);
  }

  /**
   * Get version history
   */
  getVersionHistory(agentName: string): AgentVersion[] {
    return this.agentVersions.get(agentName) || [];
  }

  /**
   * Update agent performance metrics
   */
  updatePerformanceMetrics(agentId: string, metrics: {
    averageAccuracy?: number;
    averageResponseTime?: number;
    totalExecutions?: number;
    successRate?: number;
  }): void {
    const agent = this.agents.get(agentId);
    if (!agent) {
      throw new Error(`Agent ${agentId} not found`);
    }

    const currentMetrics = agent.performanceMetrics || {
      averageAccuracy: 0,
      averageResponseTime: 0,
      totalExecutions: 0,
      successRate: 0
    };

    const updatedMetrics = {
      ...currentMetrics,
      ...metrics
    };

    this.updateAgent(agentId, { performanceMetrics: updatedMetrics });
  }

  /**
   * Get agent comparison
   */
  compareAgents(agentIds: string[]): Array<{
    agentId: string;
    version: string;
    accuracy: number;
    responseTime: number;
    successRate: number;
  }> {
    return agentIds.map(agentId => {
      const agent = this.agents.get(agentId);
      if (!agent) {
        throw new Error(`Agent ${agentId} not found`);
      }

      const metrics = agent.performanceMetrics || {
        averageAccuracy: 0,
        averageResponseTime: 0,
        successRate: 0
      };

      return {
        agentId,
        version: agent.version,
        accuracy: metrics.averageAccuracy,
        responseTime: metrics.averageResponseTime,
        successRate: metrics.successRate
      };
    });
  }

  /**
   * Get registry statistics
   */
  getRegistryStats() {
    const allAgents = this.getAllAgents();
    
    const statusCounts = allAgents.reduce((counts, agent) => {
      counts[agent.status] = (counts[agent.status] || 0) + 1;
      return counts;
    }, {} as Record<string, number>);

    const typeCounts = allAgents.reduce((counts, agent) => {
      counts[agent.agentType] = (counts[agent.agentType] || 0) + 1;
      return counts;
    }, {} as Record<string, number>);

    return {
      totalAgents: allAgents.length,
      activeAgents: statusCounts['ACTIVE'] || 0,
      experimentalAgents: statusCounts['EXPERIMENTAL'] || 0,
      deprecatedAgents: statusCounts['DEPRECATED'] || 0,
      disabledAgents: statusCounts['DISABLED'] || 0,
      statusDistribution: statusCounts,
      typeDistribution: typeCounts,
      totalAgentTypes: Object.keys(typeCounts).length
    };
  }

  /**
   * Switch agent model (e.g., gemini-2.5-flash to gemini-3.0)
   */
  switchAgentModel(agentName: string, newModel: string, newModelVersion: string): void {
    const agent = this.getActiveAgent(agentName);
    if (!agent) {
      throw new Error(`No active agent found for ${agentName}`);
    }

    this.updateAgent(agent.agentId, {
      modelName: newModel,
      modelVersion: newModelVersion
    });

    console.log(`[AgentRegistry] Switched ${agentName} to model: ${newModel} (${newModelVersion})`);
  }

  /**
   * A/B test setup
   */
  setupABTest(agentName: string, versionA: string, versionB: string, trafficSplit: number = 50): void {
    // TODO: Implement A/B testing logic
    console.log(`[AgentRegistry] A/B test setup for ${agentName}: ${versionA} (${trafficSplit}%) vs ${versionB} (${100 - trafficSplit}%)`);
  }
}

export const agentRegistry = new AgentRegistry();
