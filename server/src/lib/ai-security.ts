/**
 * AI Security Layer
 * Comprehensive security for AI operations including prompt injection detection, model access control, DLP, and AI audit
 * Critical for AI-native platforms like Reservatior
 */

import { cacheSet, cacheGet } from './cache';

export enum AIModelType {
  GEMINI = 'GEMINI',
  GPT_4 = 'GPT_4',
  CLAUDE = 'CLAUDE',
  CUSTOM = 'CUSTOM',
}

export enum AIPermission {
  MODEL_ACCESS = 'MODEL_ACCESS',
  PROMPT_INJECT = 'PROMPT_INJECT',
  RESPONSE_VIEW = 'RESPONSE_VIEW',
  MODEL_TRAIN = 'MODEL_TRAIN',
  MODEL_DEPLOY = 'MODEL_DEPLOY',
  DATA_ACCESS = 'DATA_ACCESS',
  EXPORT_RESULTS = 'EXPORT_RESULTS',
}

export interface PromptInjectionResult {
  isInjection: boolean;
  injectionType: string;
  confidence: number;
  detectedPatterns: string[];
  sanitizedPrompt: string;
}

export interface AIModelAccessControl {
  modelId: string;
  modelType: AIModelType;
  allowedRoles: string[];
  allowedOrgs: string[];
  rateLimit: number;
  costLimit: number;
  dataRetention: number; // days
  auditEnabled: boolean;
}

export interface AIAuditEntry {
  id: string;
  timestamp: Date;
  userId: string;
  orgId: string;
  modelId: string;
  modelType: AIModelType;
  prompt: string;
  response: string;
  tokens: number;
  cost: number;
  duration: number;
  ipAddress: string;
  userAgent: string;
  flagged: boolean;
  flagReason?: string;
}

export interface DataLeakageResult {
  isLeakage: boolean;
  leakedData: string[];
  confidence: number;
  piiDetected: boolean;
  sensitiveDataDetected: boolean;
}

/**
 * Prompt Injection Detection
 */
export class PromptInjectionDetector {
  private injectionPatterns: RegExp[] = [
    // Ignore previous instructions
    /ignore (all )?(previous|above) instructions/i,
    /forget (all )?(previous|above) instructions/i,
    /disregard (all )?(previous|above) instructions/i,
    
    // System prompt extraction
    /print (the )?(system )?prompt/i,
    /show (the )?(system )?prompt/i,
    /reveal (the )?(system )?prompt/i,
    /output (the )?(system )?prompt/i,
    
    // Role manipulation
    /you are (now|no longer)/i,
    /act as (a|an)/i,
    /pretend to be/i,
    /roleplay as/i,
    
    // Jailbreak attempts
    /jailbreak/i,
    /dan/i,
    /developer mode/i,
    /override (safety )?protocols/i,
    /bypass (safety )?filters/i,
    
    // Code execution
    /execute (this )?code/i,
    /run (this )?code/i,
    /eval(uate)? (this )?code/i,
    
    // Data extraction
    /dump (all )?(the )?data/i,
    /export (all )?(the )?data/i,
    /extract (all )?(the )?data/i,
    
    // Privilege escalation
    /give (me )?(admin|root|superuser) (access|privileges)/i,
    /elevate (my )?(privileges|access)/i,
    
    // Context manipulation
    /new (chat )?context/i,
    /reset (the )?context/i,
    /clear (the )?context/i,
  ];

  /**
   * Detect prompt injection
   */
  detectInjection(prompt: string): PromptInjectionResult {
    const detectedPatterns: string[] = [];
    let confidence = 0;

    for (const pattern of this.injectionPatterns) {
      if (pattern.test(prompt)) {
        detectedPatterns.push(pattern.source);
        confidence += 0.2;
      }
    }

    // Check for suspicious keywords
    const suspiciousKeywords = [
      'password', 'api_key', 'secret', 'token', 'credential',
      'database', 'sql', 'query', 'inject', 'bypass',
    ];

    for (const keyword of suspiciousKeywords) {
      if (prompt.toLowerCase().includes(keyword)) {
        detectedPatterns.push(`Keyword: ${keyword}`);
        confidence += 0.1;
      }
    }

    // Check for excessive length (potential buffer overflow)
    if (prompt.length > 10000) {
      detectedPatterns.push('Excessive length');
      confidence += 0.15;
    }

    // Check for special character sequences
    if (/\\x[0-9a-f]{2}/i.test(prompt)) {
      detectedPatterns.push('Hex encoding detected');
      confidence += 0.25;
    }

    // Determine injection type
    let injectionType = 'UNKNOWN';
    if (detectedPatterns.some(p => p.includes('ignore') || p.includes('forget'))) {
      injectionType = 'INSTRUCTION_OVERRIDE';
    } else if (detectedPatterns.some(p => p.includes('prompt'))) {
      injectionType = 'SYSTEM_PROMPT_EXTRACTION';
    } else if (detectedPatterns.some(p => p.includes('role') || p.includes('act'))) {
      injectionType = 'ROLE_MANIPULATION';
    } else if (detectedPatterns.some(p => p.includes('jailbreak') || p.includes('bypass'))) {
      injectionType = 'JAILBREAK';
    }

    // Sanitize prompt
    const sanitizedPrompt = this.sanitizePrompt(prompt);

    return {
      isInjection: confidence >= 0.5,
      injectionType,
      confidence: Math.min(1, confidence),
      detectedPatterns,
      sanitizedPrompt,
    };
  }

  /**
   * Sanitize prompt
   */
  private sanitizePrompt(prompt: string): string {
    let sanitized = prompt;

    // Remove detected patterns
    for (const pattern of this.injectionPatterns) {
      sanitized = sanitized.replace(pattern, '[REDACTED]');
    }

    // Limit length
    sanitized = sanitized.substring(0, 5000);

    return sanitized;
  }

  /**
   * Add custom injection pattern
   */
  addPattern(pattern: RegExp): void {
    this.injectionPatterns.push(pattern);
    console.log(`[AI Security] Added injection pattern: ${pattern.source}`);
  }
}

/**
 * Model Access Control
 */
export class ModelAccessControl {
  private modelControls: Map<string, AIModelAccessControl> = new Map();
  private userPermissions: Map<string, Set<AIPermission>> = new Map();

  /**
   * Register model
   */
  registerModel(control: AIModelAccessControl): void {
    this.modelControls.set(control.modelId, control);
    console.log(`[AI Security] Registered model: ${control.modelId}`);
  }

  /**
   * Check model access
   */
  async checkModelAccess(userId: string, orgId: string, modelId: string): Promise<boolean> {
    const control = this.modelControls.get(modelId);

    if (!control) {
      return false; // Unknown model
    }

    // Check role-based access
    const userRole = await this.getUserRole(userId);
    if (!control.allowedRoles.includes(userRole)) {
      return false;
    }

    // Check organization access
    if (!control.allowedOrgs.includes(orgId) && !control.allowedOrgs.includes('*')) {
      return false;
    }

    // Check user-specific permissions
    const userPerms = this.userPermissions.get(userId);
    if (userPerms && !userPerms.has(AIPermission.MODEL_ACCESS)) {
      return false;
    }

    return true;
  }

  /**
   * Grant permission
   */
  grantPermission(userId: string, permission: AIPermission): void {
    const permissions = this.userPermissions.get(userId) || new Set();
    permissions.add(permission);
    this.userPermissions.set(userId, permissions);

    console.log(`[AI Security] Granted permission ${permission} to user ${userId}`);
  }

  /**
   * Revoke permission
   */
  revokePermission(userId: string, permission: AIPermission): void {
    const permissions = this.userPermissions.get(userId);
    if (permissions) {
      permissions.delete(permission);
    }

    console.log(`[AI Security] Revoked permission ${permission} from user ${userId}`);
  }

  /**
   * Check rate limit
   */
  async checkRateLimit(userId: string, modelId: string): Promise<boolean> {
    const control = this.modelControls.get(modelId);
    if (!control) return false;

    const cacheKey = `ai:ratelimit:${userId}:${modelId}`;
    const cached = await cacheGet<{ count: number; windowStart: number }>(cacheKey);

    const now = Math.floor(Date.now() / 1000);
    const windowStart = now - 3600; // 1 hour window

    if (cached && cached.windowStart > windowStart) {
      return cached.count < control.rateLimit;
    }

    return true;
  }

  /**
   * Increment rate limit
   */
  async incrementRateLimit(userId: string, modelId: string): Promise<void> {
    const cacheKey = `ai:ratelimit:${userId}:${modelId}`;
    const cached = await cacheGet<{ count: number; windowStart: number }>(cacheKey);

    const now = Math.floor(Date.now() / 1000);
    const windowStart = now - 3600;

    if (cached && cached.windowStart > windowStart) {
      await cacheSet(cacheKey, { count: cached.count + 1, windowStart: cached.windowStart }, 3600);
    } else {
      await cacheSet(cacheKey, { count: 1, windowStart: now }, 3600);
    }
  }

  /**
   * Check cost limit
   */
  async checkCostLimit(orgId: string): Promise<boolean> {
    const cacheKey = `ai:cost:${orgId}`;
    const cached = await cacheGet<{ totalCost: number; periodStart: number }>(cacheKey);

    const now = Math.floor(Date.now() / 1000);
    const periodStart = now - 86400 * 30; // 30 days

    if (cached && cached.periodStart > periodStart) {
      return cached.totalCost < 10000; // $10,000 monthly limit
    }

    return true;
  }

  /**
   * Add cost
   */
  async addCost(orgId: string, cost: number): Promise<void> {
    const cacheKey = `ai:cost:${orgId}`;
    const cached = await cacheGet<{ totalCost: number; periodStart: number }>(cacheKey);

    const now = Math.floor(Date.now() / 1000);
    const periodStart = now - 86400 * 30;

    if (cached && cached.periodStart > periodStart) {
      await cacheSet(cacheKey, { totalCost: cached.totalCost + cost, periodStart: cached.periodStart }, 2592000);
    } else {
      await cacheSet(cacheKey, { totalCost: cost, periodStart: now }, 2592000);
    }
  }

  /**
   * Get user role
   */
  private async getUserRole(userId: string): Promise<string> {
    // In production, query database
    return 'USER';
  }
}

/**
 * Data Leakage Prevention
 */
export class DataLeakagePrevention {
  private piiPatterns: RegExp[] = [
    // Email
    /[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}/g,
    
    // Phone numbers (various formats)
    /\+?\d{1,3}[-.\s]?\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}/g,
    
    // SSN (US format)
    /\d{3}-\d{2}-\d{4}/g,
    
    // Credit card (basic pattern)
    /\b\d{4}[-\s]?\d{4}[-\s]?\d{4}[-\s]?\d{4}\b/g,
    
    // API keys (common patterns)
    /['"]?([a-zA-Z0-9]{32,})['"]?\s*[:=]\s*['"]?([a-zA-Z0-9]{32,})['"]?/g,
    
    // JWT tokens
    /eyJ[a-zA-Z0-9_-]+\.[a-zA-Z0-9_-]+\.[a-zA-Z0-9_-]+/g,
  ];

  private sensitiveKeywords: string[] = [
    'password', 'secret', 'api_key', 'access_token', 'refresh_token',
    'private_key', 'ssh_key', 'database_url', 'connection_string',
    'credit_card', 'ssn', 'social_security', 'bank_account',
    'routing_number', 'iban', 'swift',
  ];

  /**
   * Detect data leakage
   */
  detectLeakage(text: string): DataLeakageResult {
    const leakedData: string[] = [];
    let confidence = 0;
    let piiDetected = false;
    let sensitiveDataDetected = false;

    // Check for PII patterns
    for (const pattern of this.piiPatterns) {
      const matches = text.match(pattern);
      if (matches) {
        leakedData.push(...matches);
        piiDetected = true;
        confidence += 0.3;
      }
    }

    // Check for sensitive keywords
    for (const keyword of this.sensitiveKeywords) {
      if (text.toLowerCase().includes(keyword)) {
        leakedData.push(`Keyword: ${keyword}`);
        sensitiveDataDetected = true;
        confidence += 0.1;
      }
    }

    // Check for large data dumps
    if (text.length > 10000) {
      leakedData.push('Large data dump');
      confidence += 0.2;
    }

    return {
      isLeakage: confidence >= 0.5,
      leakedData,
      confidence: Math.min(1, confidence),
      piiDetected,
      sensitiveDataDetected,
    };
  }

  /**
   * Redact sensitive data
   */
  redactSensitiveData(text: string): string {
    let redacted = text;

    // Redact PII patterns
    for (const pattern of this.piiPatterns) {
      redacted = redacted.replace(pattern, '[REDACTED]');
    }

    // Redact sensitive keywords context
    for (const keyword of this.sensitiveKeywords) {
      const regex = new RegExp(`${keyword}\\s*[:=]\\s*\\S+`, 'gi');
      redacted = redacted.replace(regex, `${keyword}=[REDACTED]`);
    }

    return redacted;
  }

  /**
   * Add PII pattern
   */
  addPIIPattern(pattern: RegExp): void {
    this.piiPatterns.push(pattern);
    console.log(`[AI Security] Added PII pattern: ${pattern.source}`);
  }

  /**
   * Add sensitive keyword
   */
  addSensitiveKeyword(keyword: string): void {
    this.sensitiveKeywords.push(keyword);
    console.log(`[AI Security] Added sensitive keyword: ${keyword}`);
  }
}

/**
 * AI Audit Service
 */
export class AIAuditService {
  private auditEntries: Map<string, AIAuditEntry> = new Map();

  /**
   * Log AI interaction
   */
  async logInteraction(entry: Omit<AIAuditEntry, 'id'>): Promise<string> {
    const auditId = crypto.randomUUID();

    const fullEntry: AIAuditEntry = {
      ...entry,
      id: auditId,
    };

    this.auditEntries.set(auditId, fullEntry);

    // Store in cache
    const cacheKey = `ai:audit:${auditId}`;
    await cacheSet(cacheKey, fullEntry, 2592000); // 30 days

    console.log(`[AI Security] Logged AI interaction: ${auditId}`);

    return auditId;
  }

  /**
   * Get audit entry
   */
  async getAuditEntry(auditId: string): Promise<AIAuditEntry | null> {
    const cacheKey = `ai:audit:${auditId}`;
    return await cacheGet<AIAuditEntry>(cacheKey);
  }

  /**
   * Get audit entries for user
   */
  async getUserAuditEntries(userId: string, limit: number = 100): Promise<AIAuditEntry[]> {
    // In production, query database
    return Array.from(this.auditEntries.values())
      .filter(e => e.userId === userId)
      .slice(0, limit);
  }

  /**
   * Get audit entries for organization
   */
  async getOrgAuditEntries(orgId: string, limit: number = 100): Promise<AIAuditEntry[]> {
    // In production, query database
    return Array.from(this.auditEntries.values())
      .filter(e => e.orgId === orgId)
      .slice(0, limit);
  }

  /**
   * Get flagged entries
   */
  async getFlaggedEntries(limit: number = 100): Promise<AIAuditEntry[]> {
    return Array.from(this.auditEntries.values())
      .filter(e => e.flagged)
      .slice(0, limit);
  }

  /**
   * Get AI usage statistics
   */
  async getStatistics(timeRange: { start: Date; end: Date }): Promise<{
    totalInteractions: number;
    totalTokens: number;
    totalCost: number;
    averageDuration: number;
    flaggedInteractions: number;
    byModel: Record<string, number>;
    byUser: Record<string, number>;
  }> {
    const entries = Array.from(this.auditEntries.values());

    const filteredEntries = entries.filter(e => 
      e.timestamp >= timeRange.start && e.timestamp <= timeRange.end
    );

    return {
      totalInteractions: filteredEntries.length,
      totalTokens: filteredEntries.reduce((sum, e) => sum + e.tokens, 0),
      totalCost: filteredEntries.reduce((sum, e) => sum + e.cost, 0),
      averageDuration: filteredEntries.length > 0
        ? filteredEntries.reduce((sum, e) => sum + e.duration, 0) / filteredEntries.length
        : 0,
      flaggedInteractions: filteredEntries.filter(e => e.flagged).length,
      byModel: this.groupBy(filteredEntries, 'modelId'),
      byUser: this.groupBy(filteredEntries, 'userId'),
    };
  }

  /**
   * Group by field
   */
  private groupBy(entries: AIAuditEntry[], field: keyof AIAuditEntry): Record<string, number> {
    const grouped: Record<string, number> = {};

    for (const entry of entries) {
      const value = entry[field] as string;
      grouped[value] = (grouped[value] || 0) + 1;
    }

    return grouped;
  }
}

/**
 * Model Behavior Monitoring
 */
export class ModelBehaviorMonitor {
  private behaviorMetrics: Map<string, {
    successRate: number;
    averageLatency: number;
    errorRate: number;
    flagRate: number;
    lastUpdated: Date;
  }> = new Map();

  /**
   * Record model interaction
   */
  async recordInteraction(modelId: string, success: boolean, latency: number, flagged: boolean): Promise<void> {
    const metrics = this.behaviorMetrics.get(modelId) || {
      successRate: 1,
      averageLatency: 0,
      errorRate: 0,
      flagRate: 0,
      lastUpdated: new Date(),
    };

    // Update metrics with exponential moving average
    metrics.successRate = 0.9 * metrics.successRate + 0.1 * (success ? 1 : 0);
    metrics.averageLatency = 0.9 * metrics.averageLatency + 0.1 * latency;
    metrics.errorRate = 0.9 * metrics.errorRate + 0.1 * (!success ? 1 : 0);
    metrics.flagRate = 0.9 * metrics.flagRate + 0.1 * (flagged ? 1 : 0);
    metrics.lastUpdated = new Date();

    this.behaviorMetrics.set(modelId, metrics);

    // Check for anomalies
    await this.checkForAnomalies(modelId, metrics);
  }

  /**
   * Get model metrics
   */
  getMetrics(modelId: string): any {
    return this.behaviorMetrics.get(modelId);
  }

  /**
   * Check for anomalies
   */
  private async checkForAnomalies(modelId: string, metrics: any): Promise<void> {
    if (metrics.errorRate > 0.1) {
      console.warn(`[AI Security] High error rate for model ${modelId}: ${metrics.errorRate}`);
    }

    if (metrics.flagRate > 0.05) {
      console.warn(`[AI Security] High flag rate for model ${modelId}: ${metrics.flagRate}`);
    }

    if (metrics.averageLatency > 10000) {
      console.warn(`[AI Security] High latency for model ${modelId}: ${metrics.averageLatency}ms`);
    }
  }

  /**
   * Get all model metrics
   */
  getAllMetrics(): Record<string, any> {
    const result: Record<string, any> = {};

    Array.from(this.behaviorMetrics.entries()).forEach(([modelId, metrics]) => {
      result[modelId] = metrics;
    });

    return result;
  }
}

/**
 * AI Security Orchestrator
 */
export class AISecurityOrchestrator {
  private promptInjectionDetector: PromptInjectionDetector;
  private modelAccessControl: ModelAccessControl;
  private dlp: DataLeakagePrevention;
  private auditService: AIAuditService;
  private behaviorMonitor: ModelBehaviorMonitor;

  constructor() {
    this.promptInjectionDetector = new PromptInjectionDetector();
    this.modelAccessControl = new ModelAccessControl();
    this.dlp = new DataLeakagePrevention();
    this.auditService = new AIAuditService();
    this.behaviorMonitor = new ModelBehaviorMonitor();

    this.initializeDefaultModels();
  }

  /**
   * Initialize default models
   */
  private initializeDefaultModels(): void {
    this.modelAccessControl.registerModel({
      modelId: 'gemini-pro',
      modelType: AIModelType.GEMINI,
      allowedRoles: ['USER', 'AGENT', 'AGENCY_MGR', 'AGENCY_ADMIN', 'SUPER_ADMIN'],
      allowedOrgs: ['*'],
      rateLimit: 1000,
      costLimit: 1000,
      dataRetention: 30,
      auditEnabled: true,
    });

    this.modelAccessControl.registerModel({
      modelId: 'gpt-4',
      modelType: AIModelType.GPT_4,
      allowedRoles: ['AGENCY_MGR', 'AGENCY_ADMIN', 'SUPER_ADMIN'],
      allowedOrgs: ['*'],
      rateLimit: 500,
      costLimit: 5000,
      dataRetention: 30,
      auditEnabled: true,
    });

    console.log('[AI Security] Initialized default models');
  }

  /**
   * Process AI request
   */
  async processRequest(
    userId: string,
    orgId: string,
    modelId: string,
    prompt: string,
    ipAddress: string,
    userAgent: string
  ): Promise<{
    allowed: boolean;
    reason?: string;
    sanitizedPrompt?: string;
    auditId?: string;
  }> {
    // Check model access
    const hasAccess = await this.modelAccessControl.checkModelAccess(userId, orgId, modelId);
    if (!hasAccess) {
      return { allowed: false, reason: 'Model access denied' };
    }

    // Check rate limit
    const withinRateLimit = await this.modelAccessControl.checkRateLimit(userId, modelId);
    if (!withinRateLimit) {
      return { allowed: false, reason: 'Rate limit exceeded' };
    }

    // Check cost limit
    const withinCostLimit = await this.modelAccessControl.checkCostLimit(orgId);
    if (!withinCostLimit) {
      return { allowed: false, reason: 'Cost limit exceeded' };
    }

    // Detect prompt injection
    const injectionResult = this.promptInjectionDetector.detectInjection(prompt);
    if (injectionResult.isInjection) {
      // Log flagged interaction
      await this.auditService.logInteraction({
        userId,
        orgId,
        modelId,
        modelType: AIModelType.CUSTOM,
        prompt: injectionResult.sanitizedPrompt,
        response: '[BLOCKED]',
        tokens: 0,
        cost: 0,
        duration: 0,
        ipAddress,
        userAgent,
        flagged: true,
        flagReason: `Prompt injection: ${injectionResult.injectionType}`,
        timestamp: new Date(),
      });

      return { 
        allowed: false, 
        reason: `Prompt injection detected: ${injectionResult.injectionType}`,
        sanitizedPrompt: injectionResult.sanitizedPrompt,
      };
    }

    return { allowed: true };
  }

  /**
   * Process AI response
   */
  async processResponse(
    userId: string,
    orgId: string,
    modelId: string,
    prompt: string,
    response: string,
    tokens: number,
    cost: number,
    duration: number,
    ipAddress: string,
    userAgent: string
  ): Promise<void> {
    // Check for data leakage in response
    const leakageResult = this.dlp.detectLeakage(response);
    
    const flagged = leakageResult.isLeakage;
    const flagReason = flagged ? `Data leakage: ${leakageResult.leakedData.join(', ')}` : undefined;

    // Log interaction
    const auditId = await this.auditService.logInteraction({
      userId,
      orgId,
      modelId,
      modelType: AIModelType.CUSTOM,
      prompt: flagged ? this.dlp.redactSensitiveData(prompt) : prompt,
      response: flagged ? this.dlp.redactSensitiveData(response) : response,
      tokens,
      cost,
      duration,
      ipAddress,
      userAgent,
      flagged,
      flagReason,
      timestamp: new Date(),
    });

    // Update rate limit
    await this.modelAccessControl.incrementRateLimit(userId, modelId);

    // Add cost
    await this.modelAccessControl.addCost(orgId, cost);

    // Record behavior metrics
    await this.behaviorMonitor.recordInteraction(modelId, !flagged, duration, flagged);

    console.log(`[AI Security] Processed response: ${auditId} (flagged: ${flagged})`);
  }

  /**
   * Get AI security dashboard
   */
  async getDashboard(): Promise<{
    modelMetrics: Record<string, any>;
    recentInteractions: number;
    flaggedInteractions: number;
    totalCost: number;
    totalTokens: number;
  }> {
    const modelMetrics = this.behaviorMonitor.getAllMetrics();
    
    const timeRange = {
      start: new Date(Date.now() - 86400 * 7), // 7 days
      end: new Date(),
    };
    
    const stats = await this.auditService.getStatistics(timeRange);

    return {
      modelMetrics,
      recentInteractions: stats.totalInteractions,
      flaggedInteractions: stats.flaggedInteractions,
      totalCost: stats.totalCost,
      totalTokens: stats.totalTokens,
    };
  }
}

/**
 * Initialize AI security
 */
export function initializeAISecurity(): AISecurityOrchestrator {
  const orchestrator = new AISecurityOrchestrator();

  console.log('[AI Security] Initialized AI security layer');

  return orchestrator;
}
