/**
 * Prompt Versioning - Prompt Management
 * 
 * Manages prompt versions for AI agents:
 * - Version control for prompts (system.md, user.md, examples.md)
 * - A/B testing for prompt variations
 * - Performance tracking per prompt version
 * - Rollback capabilities
 * - Template management
 */

export interface PromptDefinition {
  promptId: string;
  agentName: string;
  promptType: 'SYSTEM' | 'USER' | 'EXAMPLES' | 'TOOL' | 'SCHEMA';
  version: string;
  status: 'ACTIVE' | 'DEPRECATED' | 'EXPERIMENTAL';
  
  // Prompt content
  content: string;
  template?: string;
  variables?: string[];
  
  // Performance metrics
  performanceMetrics?: {
    averageQuality: number;
    averageRelevance: number;
    totalUsage: number;
    successRate: number;
  };
  
  // Metadata
  createdAt: Date;
  updatedAt: Date;
  createdBy: string;
  description: string;
  tags: string[];
}

export interface PromptVersion {
  promptId: string;
  version: string;
  changelog: string;
  breakingChanges: boolean;
  releasedAt: Date;
  releasedBy: string;
}

export class PromptVersioning {
  private prompts: Map<string, PromptDefinition>;
  private promptVersions: Map<string, PromptVersion[]>;
  private activePrompts: Map<string, string>; // agentName:promptType -> promptId

  constructor() {
    this.prompts = new Map();
    this.promptVersions = new Map();
    this.activePrompts = new Map();
    this.initializeDefaultPrompts();
  }

  /**
   * Initialize default prompts
   */
  private initializeDefaultPrompts() {
    // Strategic Brain System Prompt v1.0
    this.registerPrompt({
      promptId: 'strategic-brain-system-v1.0',
      agentName: 'StrategicBrain',
      promptType: 'SYSTEM',
      version: '1.0',
      status: 'ACTIVE',
      content: `You are a strategic real estate investment advisor. Analyze the following property opportunity and provide strategic recommendations.

Focus on actionable insights that can guide investment decisions. Be specific but concise.

Always provide responses in the specified JSON format with these fields:
- recommendedStrategy: One of: NORMAL_SALE, LUXURY_RENTAL, CORPORATE_TENANT, FURNISHED_RENTAL, SHORT_TERM_RENTAL, HOLD_FOR_APPRECIATION
- whyScore: Brief explanation of why this property received this score
- regionalStrengths: What makes this location strong for investment
- targetCustomerSegments: Array of target customer segments
- recommendedSalesStrategy: Specific approach for marketing and selling this property
- riskFactors: Array of potential risks
- timingRecommendations: When and how quickly to act on this opportunity`,
      variables: ['propertyDetails', 'marketContext', 'opportunityScore'],
      createdAt: new Date(),
      updatedAt: new Date(),
      createdBy: 'system',
      description: 'System prompt for Strategic Brain agent',
      tags: ['strategic', 'analysis', 'investment']
    });

    // Strategic Brain User Prompt Template v1.0
    this.registerPrompt({
      promptId: 'strategic-brain-user-v1.0',
      agentName: 'StrategicBrain',
      promptType: 'USER',
      version: '1.0',
      status: 'ACTIVE',
      content: `PROPERTY DETAILS:
- Location: {{location}}
- Type: {{propertyType}}
- Price: {{price}}
- Size: {{size}} sqm
- Rooms: {{rooms}}
- Features: {{features}}

MARKET CONTEXT:
- Area: {{areaName}}
- Average Price: {{averagePrice}}
- Price Trend: {{priceTrend}}
- Demand Level: {{demandLevel}}
- Competition: {{competitionLevel}}

OPPORTUNITY SCORE ANALYSIS:
- Overall Score: {{overallScore}}/100
- Opportunity Tier: {{opportunityTier}}
- Acquisition Urgency: {{acquisitionUrgency}}

COMPONENT SCORES:
- Yield Score: {{yieldScore}}/100 (Weight: {{yieldWeight}}%)
- Price Gap Score: {{priceGapScore}}/100 (Weight: {{priceGapWeight}}%)
- Demand Score: {{demandScore}}/100 (Weight: {{demandWeight}}%)
- Vacancy Score: {{vacancyScore}}/100 (Weight: {{vacancyWeight}}%)
- Risk Score: {{riskScore}}/100 (Weight: {{riskWeight}}%)
- Liquidity Score: {{liquidityScore}}/100 (Weight: {{liquidityWeight}}%)

Please provide a strategic analysis in the JSON format specified in the system prompt.`,
      template: 'user_template',
      variables: ['location', 'propertyType', 'price', 'size', 'rooms', 'features', 'areaName', 'averagePrice', 'priceTrend', 'demandLevel', 'competitionLevel', 'overallScore', 'opportunityTier', 'acquisitionUrgency', 'yieldScore', 'yieldWeight', 'priceGapScore', 'priceGapWeight', 'demandScore', 'demandWeight', 'vacancyScore', 'vacancyWeight', 'riskScore', 'riskWeight', 'liquidityScore', 'liquidityWeight'],
      createdAt: new Date(),
      updatedAt: new Date(),
      createdBy: 'system',
      description: 'User prompt template for Strategic Brain',
      tags: ['strategic', 'template', 'user']
    });

    console.log('[PromptVersioning] Default prompts initialized');
  }

  /**
   * Register new prompt
   */
  registerPrompt(prompt: PromptDefinition): void {
    if (this.prompts.has(prompt.promptId)) {
      throw new Error(`Prompt ${prompt.promptId} already exists`);
    }

    this.prompts.set(prompt.promptId, prompt);
    
    // If status is ACTIVE, set as active prompt for this agent:type
    if (prompt.status === 'ACTIVE') {
      const key = `${prompt.agentName}:${prompt.promptType}`;
      this.activePrompts.set(key, prompt.promptId);
    }

    // Initialize version history
    const key = `${prompt.agentName}:${prompt.promptType}`;
    if (!this.promptVersions.has(key)) {
      this.promptVersions.set(key, []);
    }

    this.promptVersions.get(key)!.push({
      promptId: prompt.promptId,
      version: prompt.version,
      changelog: 'Initial version',
      breakingChanges: false,
      releasedAt: prompt.createdAt,
      releasedBy: prompt.createdBy
    });

    console.log(`[PromptVersioning] Registered prompt: ${prompt.agentName} ${prompt.promptType} v${prompt.version}`);
  }

  /**
   * Get prompt by ID
   */
  getPrompt(promptId: string): PromptDefinition | undefined {
    return this.prompts.get(promptId);
  }

  /**
   * Get active prompt for agent and type
   */
  getActivePrompt(agentName: string, promptType: string): PromptDefinition | undefined {
    const key = `${agentName}:${promptType}`;
    const promptId = this.activePrompts.get(key);
    if (!promptId) return undefined;
    return this.prompts.get(promptId);
  }

  /**
   * Get all prompts for agent
   */
  getPromptsForAgent(agentName: string): PromptDefinition[] {
    return Array.from(this.prompts.values()).filter(
      prompt => prompt.agentName === agentName
    );
  }

  /**
   * Get prompts by type
   */
  getPromptsByType(promptType: string): PromptDefinition[] {
    return Array.from(this.prompts.values()).filter(
      prompt => prompt.promptType === promptType
    );
  }

  /**
   * Update prompt
   */
  updatePrompt(promptId: string, updates: Partial<PromptDefinition>): void {
    const prompt = this.prompts.get(promptId);
    if (!prompt) {
      throw new Error(`Prompt ${promptId} not found`);
    }

    const updatedPrompt = {
      ...prompt,
      ...updates,
      updatedAt: new Date()
    };

    this.prompts.set(promptId, updatedPrompt);

    // Update active prompt if status changed to ACTIVE
    if (updates.status === 'ACTIVE') {
      const key = `${prompt.agentName}:${prompt.promptType}`;
      this.activePrompts.set(key, promptId);
    }

    console.log(`[PromptVersioning] Updated prompt: ${promptId}`);
  }

  /**
   * Create new version of prompt
   */
  createPromptVersion(
    agentName: string,
    promptType: string,
    newVersion: string,
    newContent: string,
    changelog: string,
    breakingChanges: boolean = false,
    releasedBy: string = 'system'
  ): PromptDefinition {
    const currentPrompt = this.getActivePrompt(agentName, promptType);
    if (!currentPrompt) {
      throw new Error(`No active prompt found for ${agentName} ${promptType}`);
    }

    const newPromptId = `${agentName.toLowerCase()}-${promptType.toLowerCase()}-v${newVersion.replace(/\./g, '-')}`;
    
    const newPrompt: PromptDefinition = {
      ...currentPrompt,
      promptId: newPromptId,
      version: newVersion,
      content: newContent,
      status: 'EXPERIMENTAL',
      createdAt: new Date(),
      updatedAt: new Date(),
      createdBy: releasedBy
    };

    this.registerPrompt(newPrompt);

    // Add version history
    const key = `${agentName}:${promptType}`;
    this.promptVersions.get(key)!.push({
      promptId: newPromptId,
      version: newVersion,
      changelog,
      breakingChanges,
      releasedAt: new Date(),
      releasedBy
    });

    console.log(`[PromptVersioning] Created new version: ${agentName} ${promptType} v${newVersion}`);

    return newPrompt;
  }

  /**
   * Activate prompt version
   */
  activatePromptVersion(agentName: string, promptType: string, version: string): void {
    const promptId = `${agentName.toLowerCase()}-${promptType.toLowerCase()}-v${version.replace(/\./g, '-')}`;
    const prompt = this.prompts.get(promptId);
    
    if (!prompt) {
      throw new Error(`Prompt ${agentName} ${promptType} v${version} not found`);
    }

    // Deactivate current active prompt
    const key = `${agentName}:${promptType}`;
    const currentActiveId = this.activePrompts.get(key);
    if (currentActiveId) {
      this.updatePrompt(currentActiveId, { status: 'DEPRECATED' });
    }

    // Activate new version
    this.updatePrompt(promptId, { status: 'ACTIVE' });
    this.activePrompts.set(key, promptId);

    console.log(`[PromptVersioning] Activated ${agentName} ${promptType} v${version}`);
  }

  /**
   * Rollback to previous prompt version
   */
  rollbackPrompt(agentName: string, promptType: string, targetVersion?: string): void {
    const key = `${agentName}:${promptType}`;
    const versions = this.promptVersions.get(key);
    
    if (!versions || versions.length === 0) {
      throw new Error(`No version history found for ${agentName} ${promptType}`);
    }

    let targetVersionInfo: PromptVersion;
    
    if (targetVersion) {
      targetVersionInfo = versions.find(v => v.version === targetVersion)!;
      if (!targetVersionInfo) {
        throw new Error(`Version ${targetVersion} not found for ${agentName} ${promptType}`);
      }
    } else {
      // Rollback to previous version
      const currentPrompt = this.getActivePrompt(agentName, promptType);
      const currentVersion = currentPrompt?.version;
      const currentIndex = versions.findIndex(v => v.version === currentVersion);
      
      if (currentIndex <= 0) {
        throw new Error(`No previous version to rollback to for ${agentName} ${promptType}`);
      }
      
      targetVersionInfo = versions[currentIndex - 1];
    }

    this.activatePromptVersion(agentName, promptType, targetVersionInfo.version);
    console.log(`[PromptVersioning] Rolled back ${agentName} ${promptType} to v${targetVersionInfo.version}`);
  }

  /**
   * Get version history
   */
  getVersionHistory(agentName: string, promptType: string): PromptVersion[] {
    const key = `${agentName}:${promptType}`;
    return this.promptVersions.get(key) || [];
  }

  /**
   * Update prompt performance metrics
   */
  updatePerformanceMetrics(promptId: string, metrics: {
    averageQuality?: number;
    averageRelevance?: number;
    totalUsage?: number;
    successRate?: number;
  }): void {
    const prompt = this.prompts.get(promptId);
    if (!prompt) {
      throw new Error(`Prompt ${promptId} not found`);
    }

    const currentMetrics = prompt.performanceMetrics || {
      averageQuality: 0,
      averageRelevance: 0,
      totalUsage: 0,
      successRate: 0
    };

    const updatedMetrics = {
      ...currentMetrics,
      ...metrics
    };

    this.updatePrompt(promptId, { performanceMetrics: updatedMetrics });
  }

  /**
   * Render prompt with variables
   */
  renderPrompt(promptId: string, variables: Record<string, any>): string {
    const prompt = this.prompts.get(promptId);
    if (!prompt) {
      throw new Error(`Prompt ${promptId} not found`);
    }

    let renderedContent = prompt.content;

    // Replace variables
    for (const [key, value] of Object.entries(variables)) {
      const placeholder = `{{${key}}}`;
      renderedContent = renderedContent.replace(new RegExp(placeholder, 'g'), String(value));
    }

    return renderedContent;
  }

  /**
   * A/B test setup for prompts
   */
  setupABTest(
    agentName: string,
    promptType: string,
    versionA: string,
    versionB: string,
    trafficSplit: number = 50
  ): void {
    console.log(`[PromptVersioning] A/B test setup for ${agentName} ${promptType}: v${versionA} (${trafficSplit}%) vs v${versionB} (${100 - trafficSplit}%)`);
  }

  /**
   * Get prompt comparison
   */
  comparePrompts(promptIds: string[]): Array<{
    promptId: string;
    version: string;
    quality: number;
    relevance: number;
    successRate: number;
    totalUsage: number;
  }> {
    return promptIds.map(promptId => {
      const prompt = this.prompts.get(promptId);
      if (!prompt) {
        throw new Error(`Prompt ${promptId} not found`);
      }

      const metrics = prompt.performanceMetrics || {
        averageQuality: 0,
        averageRelevance: 0,
        totalUsage: 0,
        successRate: 0
      };

      return {
        promptId,
        version: prompt.version,
        quality: metrics.averageQuality,
        relevance: metrics.averageRelevance,
        successRate: metrics.successRate,
        totalUsage: metrics.totalUsage
      };
    });
  }

  /**
   * Get registry statistics
   */
  getRegistryStats() {
    const allPrompts = this.getAllPrompts();
    
    const statusCounts = allPrompts.reduce((counts, prompt) => {
      counts[prompt.status] = (counts[prompt.status] || 0) + 1;
      return counts;
    }, {} as Record<string, number>);

    const typeCounts = allPrompts.reduce((counts, prompt) => {
      counts[prompt.promptType] = (counts[prompt.promptType] || 0) + 1;
      return counts;
    }, {} as Record<string, number>);

    return {
      totalPrompts: allPrompts.length,
      activePrompts: statusCounts['ACTIVE'] || 0,
      experimentalPrompts: statusCounts['EXPERIMENTAL'] || 0,
      deprecatedPrompts: statusCounts['DEPRECATED'] || 0,
      statusDistribution: statusCounts,
      typeDistribution: typeCounts,
      totalAgents: new Set(allPrompts.map(p => p.agentName)).size
    };
  }

  /**
   * Get all prompts
   */
  getAllPrompts(): PromptDefinition[] {
    return Array.from(this.prompts.values());
  }

  /**
   * Search prompts by tags
   */
  searchPromptsByTags(tags: string[]): PromptDefinition[] {
    return Array.from(this.prompts.values()).filter(prompt =>
      tags.some(tag => prompt.tags.includes(tag))
    );
  }

  /**
   * Export prompt configuration
   */
  exportPromptConfiguration(agentName: string): any {
    const prompts = this.getPromptsForAgent(agentName);
    
    return {
      agentName,
      prompts: prompts.map(prompt => ({
        promptType: prompt.promptType,
        version: prompt.version,
        content: prompt.content,
        variables: prompt.variables,
        status: prompt.status
      })),
      exportedAt: new Date()
    };
  }

  /**
   * Import prompt configuration
   */
  importPromptConfiguration(config: any): void {
    const { agentName, prompts } = config;
    
    for (const promptConfig of prompts) {
      const promptId = `${agentName.toLowerCase()}-${promptConfig.promptType.toLowerCase()}-v${promptConfig.version.replace(/\./g, '-')}`;
      
      this.registerPrompt({
        promptId,
        agentName,
        promptType: promptConfig.promptType,
        version: promptConfig.version,
        status: promptConfig.status,
        content: promptConfig.content,
        variables: promptConfig.variables,
        createdAt: new Date(),
        updatedAt: new Date(),
        createdBy: 'import',
        description: `Imported ${promptConfig.promptType} prompt`,
        tags: ['imported']
      });
    }

    console.log(`[PromptVersioning] Imported ${prompts.length} prompts for ${agentName}`);
  }
}

export const promptVersioning = new PromptVersioning();
