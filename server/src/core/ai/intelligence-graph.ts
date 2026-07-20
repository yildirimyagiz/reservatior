/**
 * Intelligence Graph — Central AI Decision System (Deep)
 *
 * Listens to ALL domain events across 21 OS modules and maintains a "neural"
 * graph of entity relationships. Provides cross-module correlation, trust
 * scoring, demand signals, risk assessment, and revenue optimization.
 *
 * Value chain: User → Trust → Transaction → Property → Finance → Operations
 *              → Commerce → Demand → Investment
 */

import { eventBus } from '../events/event-bus';
import { DomainEvents, EventMessage } from '../events/domain-events';
import { v4 as uuidv4 } from 'uuid';

// ─── Types ────────────────────────────────────────────────────────────────────

export interface EntityNode {
  id: string;
  type: string;
  orgId?: string;
  signals: Map<string, number>;
  connections: Set<string>;
  lastUpdated: Date;
  metadata: Record<string, any>;
}

export interface AIInsight {
  id: string;
  type: 'ANALYSIS' | 'PREDICTION' | 'RECOMMENDATION' | 'ALERT' | 'CORRELATION';
  severity: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL';
  entityType: string;
  entityId: string;
  confidence: number;
  insight: string;
  data?: any;
  sourceModules: string[];
  createdAt: Date;
}

export interface TrustScore {
  userId: string;
  overall: number;       // 0-100
  identity: number;      // KYC verified
  transaction: number;   // payment reliability
  behavior: number;      // activity patterns
  social: number;        // reviews, relationships
  risk: number;          // fraud/security signals (inverse)
  factors: string[];
  calculatedAt: Date;
}

export interface DemandSignal {
  propertyType: string;
  location: string;
  demandLevel: 'LOW' | 'MODERATE' | 'HIGH' | 'SURGING';
  searchVolume: number;
  bookingRate: number;
  pricePerception: number; // how price relates to demand
  seasonality: string;
  confidence: number;
}

export interface RiskAssessment {
  entityId: string;
  entityType: string;
  overallRisk: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL';
  fraudRisk: number;
  complianceRisk: number;
  operationalRisk: number;
  financialRisk: number;
  factors: string[];
  recommendedActions: string[];
  assessedAt: Date;
}

export interface RevenueInsight {
  orgId: string;
  totalRevenue: number;
  projectedRevenue: number;
  topRevenueStreams: { name: string; amount: number; growth: number }[];
  optimizationOpportunities: string[];
  churnRisk: number;
  ltv: number; // lifetime value
}

// ─── Intelligence Graph ───────────────────────────────────────────────────────

export class IntelligenceGraph {
  private nodes: Map<string, EntityNode> = new Map();
  private insights: AIInsight[] = [];
  private eventCounts: Map<string, number> = new Map();
  private eventHistory: Map<string, { timestamp: Date; payload: any }[]> = new Map();
  private trustScores: Map<string, TrustScore> = new Map();
  private demandSignals: Map<string, DemandSignal> = new Map();
  private riskAssessments: Map<string, RiskAssessment> = new Map();
  private maxInsights = 5000;
  private maxEventHistory = 10000;
  private maxNodes = 50000;

  constructor() {
    this.setupListeners();
  }

  private setupListeners() {
    eventBus.subscribe('*', async (event: any) => {
      const eventType = event?.type || event;
      const payload = event?.payload || event;
      this.processEvent(eventType, payload);
    });
  }

  private processEvent(event: string, payload: any) {
    const count = this.eventCounts.get(event) || 0;
    this.eventCounts.set(event, count + 1);

    // Store event history for trend analysis
    if (!this.eventHistory.has(event)) {
      this.eventHistory.set(event, []);
    }
    const history = this.eventHistory.get(event)!;
    history.push({ timestamp: new Date(), payload });
    if (history.length > 500) {
      this.eventHistory.set(event, history.slice(-500));
    }

    const entityType = this.extractEntityType(event);
    const entityId = payload?.id || payload?.userId || payload?.propertyId || payload?.dealId || payload?.bookingId;

    if (entityType && entityId) {
      const node = this.getOrCreateNode(entityType, entityId, payload.orgId);

      const signalKey = event;
      const currentSignal = node.signals.get(signalKey) || 0;
      node.signals.set(signalKey, currentSignal + 1);
      node.lastUpdated = new Date();

      // Update metadata from payload
      Object.keys(payload).forEach(k => {
        if (typeof payload[k] === 'string' || typeof payload[k] === 'number') {
          node.metadata[k] = payload[k];
        }
      });

      // Detect entity connections
      this.detectConnections(entityType, entityId, event, payload);

      // Run pattern detection
      this.detectPatterns(entityType, entityId, node, event, payload);

      // Cross-module correlation (every 50 events to avoid perf hit)
      if (count % 50 === 0 && count > 0) {
        this.runCrossModuleCorrelation();
      }

      // Trust score recalculation on relevant events
      if (this.isTrustRelevantEvent(event) && payload.userId) {
        this.recalculateTrustScore(payload.userId);
      }

      // Demand signal updates on booking/search events
      if (this.isDemandRelevantEvent(event)) {
        this.updateDemandSignals(event, payload);
      }

      // Risk assessment on security/compliance events
      if (this.isRiskRelevantEvent(event)) {
        this.updateRiskAssessment(event, payload);
      }
    }
  }

  private extractEntityType(event: string): string | null {
    const e = event.toUpperCase();
    if (e.includes('USER') || e.includes('AGENT') || e.includes('IDENTITY') || e.includes('SESSION') || e.includes('SSO')) return 'user';
    if (e.includes('PROPERTY') || e.includes('LISTING')) return 'property';
    if (e.includes('DEAL') || e.includes('INVESTMENT') || e.includes('VALUATION')) return 'deal';
    if (e.includes('BOOKING') || e.includes('VIEWING') || e.includes('TENANT')) return 'booking';
    if (e.includes('CAMPAIGN') || e.includes('AD_') || e.includes('AUDIENCE') || e.includes('ATTRIBUTION')) return 'campaign';
    if (e.includes('MAINTENANCE') || e.includes('INSPECTION') || e.includes('CLEANING') || e.includes('OPERATIONS')) return 'maintenance';
    if (e.includes('KYC') || e.includes('FRAUD') || e.includes('SECURITY') || e.includes('ACCESS_LOG')) return 'security';
    if (e.includes('LEASE') || e.includes('RENT')) return 'tenant';
    if (e.includes('CONTRACT') || e.includes('DOCUMENT') || e.includes('SIGNATURE')) return 'contract';
    if (e.includes('PAYMENT') || e.includes('COMMISSION') || e.includes('ESCROW') || e.includes('INVOICE')) return 'finance';
    if (e.includes('PARTNER') || e.includes('SUPPLIER') || e.includes('AGREEMENT')) return 'partner';
    if (e.includes('GOVERNANCE') || e.includes('COMPLIANCE') || e.includes('AUDIT')) return 'governance';
    if (e.includes('NOTIFICATION') || e.includes('MESSAGE') || e.includes('EMAIL')) return 'communication';
    if (e.includes('ANALYTICS') || e.includes('REPORT') || e.includes('METRIC') || e.includes('KPI')) return 'analytics';
    if (e.includes('WEBHOOK') || e.includes('API_KEY') || e.includes('INTEGRATION')) return 'integration';
    if (e.includes('EXCHANGE_RATE') || e.includes('TAX') || e.includes('LOCALIZATION')) return 'localization';
    if (e.includes('PRODUCT') || e.includes('ORDER') || e.includes('COMMERCE') || e.includes('ASSET')) return 'commerce';
    if (e.includes('SEARCH') || e.includes('SAVED_SEARCH')) return 'search';
    if (e.includes('CONSENT') || e.includes('PRIVACY')) return 'privacy';
    return null;
  }

  private getOrCreateNode(type: string, id: string, orgId?: string): EntityNode {
    const key = `${type}:${id}`;
    let node = this.nodes.get(key);
    if (!node) {
      if (this.nodes.size >= this.maxNodes) {
        // Evict oldest nodes
        const sorted = Array.from(this.nodes.entries())
          .sort((a, b) => a[1].lastUpdated.getTime() - b[1].lastUpdated.getTime());
        for (let i = 0; i < 1000; i++) {
          this.nodes.delete(sorted[i][0]);
        }
      }
      node = {
        id,
        type,
        orgId,
        signals: new Map(),
        connections: new Set(),
        lastUpdated: new Date(),
        metadata: {},
      };
      this.nodes.set(key, node);
    }
    return node;
  }

  // ─── Connection Detection ─────────────────────────────────────────────────

  private detectConnections(entityType: string, entityId: string, event: string, payload: any) {
    const sourceKey = `${entityType}:${entityId}`;

    // Cross-reference IDs from payload to create connections
    const refs: Record<string, string> = {
      userId: 'user',
      propertyId: 'property',
      dealId: 'deal',
      bookingId: 'booking',
      campaignId: 'campaign',
      agentId: 'user',
      orgId: 'organization',
      partnerId: 'partner',
      vendorId: 'partner',
      inspectorId: 'user',
      tenantId: 'user',
      landlordId: 'user',
      buyerId: 'user',
      sellerId: 'user',
    };

    for (const [field, targetType] of Object.entries(refs)) {
      const refId = payload[field];
      if (refId && refId !== entityId) {
        const targetKey = `${targetType}:${refId}`;
        const sourceNode = this.nodes.get(sourceKey);
        if (sourceNode) {
          sourceNode.connections.add(targetKey);
        }
        // Bidirectional
        const targetNode = this.getOrCreateNode(targetType, refId, payload.orgId);
        targetNode.connections.add(sourceKey);
      }
    }
  }

  // ─── Pattern Detection (Deep) ─────────────────────────────────────────────

  private detectPatterns(entityType: string, entityId: string, node: EntityNode, event: string, payload: any) {
    const totalSignals = Array.from(node.signals.values()).reduce((a, b) => a + b, 0);

    // High engagement detection
    if (totalSignals > 10 && totalSignals % 10 === 0) {
      this.addInsight({
        type: 'ANALYSIS',
        severity: 'LOW',
        entityType,
        entityId,
        confidence: 0.85,
        insight: `High engagement: ${totalSignals} events from ${entityType} ${entityId}`,
        data: { eventCounts: Object.fromEntries(node.signals), connections: Array.from(node.connections) },
        sourceModules: this.extractSourceModules(node),
      });
    }

    // CTR drops for campaigns
    if (entityType === 'campaign' && event.includes('IMPRESSION')) {
      const clickCount = node.signals.get('ADS_EVENT_TRACKED') || 0;
      const impressionCount = node.signals.get('CAMPAIGN_IMPRESSION') || 0;
      if (impressionCount > 100 && clickCount / impressionCount < 0.01) {
        this.addInsight({
          type: 'RECOMMENDATION',
          severity: 'HIGH',
          entityType,
          entityId,
          confidence: 0.9,
          insight: `CTR below 1% for campaign ${entityId}. Consider A/B testing new creatives.`,
          sourceModules: ['AdsOS'],
        });
      }
    }

    // Maintenance backlog detection
    if (entityType === 'maintenance' && event.includes('MAINTENANCE')) {
      const overdueCount = node.signals.get('OPERATIONS_MAINTENANCE_COMPLETED') || 0;
      const scheduledCount = node.signals.get('OPERATIONS_MAINTENANCE_SCHEDULED') || 0;
      if (scheduledCount > 5 && overdueCount < scheduledCount * 0.3) {
        this.addInsight({
          type: 'ALERT',
          severity: 'MEDIUM',
          entityType,
          entityId,
          confidence: 0.88,
          insight: `Maintenance completion rate below 30% for property ${entityId}`,
          data: { scheduled: scheduledCount, completed: overdueCount },
          sourceModules: ['OperationsOS'],
        });
      }
    }

    // Security brute-force detection
    if (entityType === 'security' && event.includes('FAILED')) {
      const failCount = node.signals.get('SECURITY_FAILED_LOGIN') || 0;
      if (failCount > 5) {
        this.addInsight({
          type: 'ALERT',
          severity: 'CRITICAL',
          entityType,
          entityId,
          confidence: 0.98,
          insight: `Possible brute-force attack: ${failCount} failed attempts for user ${entityId}`,
          sourceModules: ['SecurityOS', 'IdentityOS'],
        });
      }
    }

    // Fraud pattern detection
    if (entityType === 'security' && event.includes('FRAUD')) {
      this.addInsight({
        type: 'ALERT',
        severity: 'CRITICAL',
        entityType,
        entityId,
        confidence: payload.riskScore || 0.9,
        insight: `Fraud alert raised: ${payload.reason || 'Suspicious activity detected'}`,
        data: payload,
        sourceModules: ['SecurityOS'],
      });
    }

    // Investment opportunity detection
    if (entityType === 'deal' && event.includes('DEAL_CREATED')) {
      this.addInsight({
        type: 'CORRELATION',
        severity: 'MEDIUM',
        entityType,
        entityId,
        confidence: 0.7,
        insight: `New investment opportunity: ${payload.name} ($${payload.investmentAmount || 0})`,
        data: payload,
        sourceModules: ['InvestmentOS'],
      });
    }

    // Compliance failure cascade detection
    if (entityType === 'governance' && event.includes('COMPLIANCE_CHECK_FAILED')) {
      // Check if this entity has had multiple compliance failures
      const failCount = node.signals.get('COMPLIANCE_CHECK_FAILED') || 0;
      if (failCount >= 3) {
        this.addInsight({
          type: 'ALERT',
          severity: 'HIGH',
          entityType,
          entityId,
          confidence: 0.95,
          insight: `Repeated compliance failures (${failCount}) for ${entityType} ${entityId}. Immediate review required.`,
          data: { failureCount: failCount },
          sourceModules: ['GovernanceOS'],
        });
      }
    }

    // Partner churn detection
    if (entityType === 'partner' && event.includes('PARTNER')) {
      const lastUpdate = node.lastUpdated.getTime();
      const daysSinceActivity = (Date.now() - lastUpdate) / (24 * 60 * 60 * 1000);
      if (daysSinceActivity > 30 && totalSignals < 5) {
        this.addInsight({
          type: 'PREDICTION',
          severity: 'MEDIUM',
          entityType,
          entityId,
          confidence: 0.75,
          insight: `Partner ${entityId} shows low activity (${totalSignals} events, ${Math.round(daysSinceActivity)} days idle). Churn risk.`,
          sourceModules: ['PartnerOS'],
        });
      }
    }

    // Document expiry detection
    if (entityType === 'contract' && event.includes('DOCUMENT_UPLOADED')) {
      if (payload.expiresAt) {
        const daysUntilExpiry = (new Date(payload.expiresAt).getTime() - Date.now()) / (24 * 60 * 60 * 1000);
        if (daysUntilExpiry < 30 && daysUntilExpiry > 0) {
          this.addInsight({
            type: 'ALERT',
            severity: 'MEDIUM',
            entityType,
            entityId,
            confidence: 0.95,
            insight: `Document expiring in ${Math.round(daysUntilExpiry)} days: ${payload.documentType || 'Unknown'}`,
            data: { expiresAt: payload.expiresAt, daysRemaining: Math.round(daysUntilExpiry) },
            sourceModules: ['DocumentOS'],
          });
        }
      }
    }
  }

  private extractSourceModules(node: EntityNode): string[] {
    const modules = new Set<string>();
    for (const [event] of node.signals) {
      const e = event.toUpperCase();
      if (e.startsWith('USER_') || e.startsWith('AGENT_') || e.startsWith('IDENTITY_')) modules.add('UserOS');
      if (e.startsWith('LISTING_') || e.startsWith('PROPERTY_')) modules.add('ListingOS');
      if (e.startsWith('BOOKING_')) modules.add('BookingOS');
      if (e.startsWith('DEAL_') || e.startsWith('INVESTMENT_')) modules.add('InvestmentOS');
      if (e.startsWith('ADS_') || e.startsWith('CAMPAIGN_') || e.startsWith('AD_')) modules.add('AdsOS');
      if (e.startsWith('OPERATIONS_') || e.startsWith('MAINTENANCE_')) modules.add('OperationsOS');
      if (e.startsWith('SECURITY_') || e.startsWith('KYC_') || e.startsWith('FRAUD_')) modules.add('SecurityOS');
      if (e.startsWith('GOVERNANCE_') || e.startsWith('COMPLIANCE_')) modules.add('GovernanceOS');
      if (e.startsWith('PARTNER_')) modules.add('PartnerOS');
      if (e.startsWith('ANALYTICS_') || e.startsWith('REPORT_')) modules.add('AnalyticsOS');
      if (e.startsWith('DOCUMENT_') || e.startsWith('CONTRACT_')) modules.add('DocumentOS');
      if (e.startsWith('NOTIFICATION_') || e.startsWith('MESSAGE_')) modules.add('NotificationOS');
      if (e.startsWith('FINANCE_') || e.startsWith('ESCROW_')) modules.add('FinanceOS');
    }
    return Array.from(modules);
  }

  // ─── Trust Scoring ───────────────────────────────────────────────────────

  private isTrustRelevantEvent(event: string): boolean {
    const e = event.toUpperCase();
    return e.includes('USER') || e.includes('KYC') || e.includes('BOOKING') || e.includes('PAYMENT') ||
      e.includes('FRAUD') || e.includes('REVIEW') || e.includes('SESSION') || e.includes('IDENTITY') ||
      e.includes('CONSENT') || e.includes('AGENT');
  }

  private recalculateTrustScore(userId: string) {
    const userNodes = Array.from(this.nodes.entries())
      .filter(([k]) => k.startsWith('user:') || k.includes(`:${userId}`));

    const totalEvents = userNodes.reduce((sum, [, n]) =>
      sum + Array.from(n.signals.values()).reduce((a, b) => a + b, 0), 0);

    // Identity: KYC/SSO signals
    let identity = 50;
    const kycApproved = userNodes.some(([, n]) => (n.signals.get('KYC_APPROVED') || 0) > 0);
    const ssoConnected = userNodes.some(([, n]) => (n.signals.get('IDENTITY_USER_SSO_CONNECTED') || 0) || (n.signals.get('USER_SSO_CONNECTED') || 0) > 0);
    if (kycApproved) identity += 30;
    if (ssoConnected) identity += 10;
    if (totalEvents > 20) identity += 10;
    identity = Math.min(100, identity);

    // Transaction: payment/booking patterns
    let transaction = 50;
    const hasBookings = userNodes.some(([, n]) => (n.signals.get('BOOKING_CREATED') || 0) > 0);
    const hasPayments = userNodes.some(([, n]) => (n.signals.get('ESCROW_CREATED') || 0) > 0);
    if (hasBookings) transaction += 20;
    if (hasPayments) transaction += 20;
    const fraudAlerts = userNodes.reduce((sum, [, n]) => sum + (n.signals.get('FRAUD_ALERT_RAISED') || 0), 0);
    if (fraudAlerts > 0) transaction -= fraudAlerts * 20;
    transaction = Math.max(0, Math.min(100, transaction));

    // Behavior: activity consistency
    let behavior = 50;
    if (totalEvents > 50) behavior += 20;
    else if (totalEvents > 20) behavior += 10;
    const lastActive = userNodes.reduce((latest, [, n]) => Math.max(latest, n.lastUpdated.getTime()), 0);
    const daysSinceActive = (Date.now() - lastActive) / (24 * 60 * 60 * 1000);
    if (daysSinceActive < 7) behavior += 15;
    else if (daysSinceActive > 30) behavior -= 15;
    behavior = Math.max(0, Math.min(100, behavior));

    // Social: reviews, relationships
    let social = 50;
    const hasReviews = userNodes.some(([, n]) => (n.signals.get('VENDOR_RATED') || 0) > 0);
    const hasRelationships = userNodes.some(([, n]) => (n.signals.get('USER_RELATIONSHIP_CREATED') || 0) > 0);
    if (hasReviews) social += 15;
    if (hasRelationships) social += 15;
    social = Math.min(100, social);

    // Risk: fraud/security (inverse)
    let risk = 10;
    if (fraudAlerts > 0) risk += fraudAlerts * 25;
    const securityIncidents = userNodes.reduce((sum, [, n]) => sum + (n.signals.get('SECURITY_INCIDENT_CREATED') || 0), 0);
    if (securityIncidents > 0) risk += securityIncidents * 20;
    risk = Math.min(100, risk);

    const overall = Math.round(
      (identity * 0.25) + (transaction * 0.25) + (behavior * 0.2) + (social * 0.15) + ((100 - risk) * 0.15)
    );

    const factors: string[] = [];
    if (kycApproved) factors.push('KYC verified');
    if (ssoConnected) factors.push('SSO connected');
    if (hasBookings) factors.push('Has booking history');
    if (hasPayments) factors.push('Has payment history');
    if (fraudAlerts > 0) factors.push(`${fraudAlerts} fraud alert(s)`);
    if (totalEvents > 50) factors.push('High activity level');
    if (daysSinceActive < 7) factors.push('Recently active');

    this.trustScores.set(userId, {
      userId,
      overall,
      identity,
      transaction,
      behavior,
      social,
      risk,
      factors,
      calculatedAt: new Date(),
    });

    // Emit trust score update
    if (overall < 30) {
      this.addInsight({
        type: 'ALERT',
        severity: 'HIGH',
        entityType: 'user',
        entityId: userId,
        confidence: 0.85,
        insight: `Low trust score (${overall}/100) for user ${userId}. Review recommended.`,
        data: { identity, transaction, behavior, social, risk, factors },
        sourceModules: ['IdentityOS', 'SecurityOS'],
      });
    }
  }

  // ─── Demand Signals ──────────────────────────────────────────────────────

  private isDemandRelevantEvent(event: string): boolean {
    const e = event.toUpperCase();
    return e.includes('BOOKING') || e.includes('SEARCH') || e.includes('VIEWING') ||
      e.includes('LISTING') || e.includes('SAVED_SEARCH');
  }

  private updateDemandSignals(event: string, payload: any) {
    const key = payload.propertyType || payload.location || 'general';
    const existing = this.demandSignals.get(key) || {
      propertyType: payload.propertyType || 'unknown',
      location: payload.location || 'unknown',
      demandLevel: 'MODERATE' as const,
      searchVolume: 0,
      bookingRate: 0,
      pricePerception: 0,
      seasonality: 'unknown',
      confidence: 0.5,
    };

    if (event.includes('BOOKING_CREATED') || event.includes('BOOKING')) {
      existing.bookingRate += 1;
    }
    if (event.includes('SEARCH') || event.includes('SAVED_SEARCH')) {
      existing.searchVolume += 1;
    }

    // Update demand level
    const totalDemand = existing.searchVolume + existing.bookingRate;
    if (totalDemand > 100) existing.demandLevel = 'SURGING';
    else if (totalDemand > 50) existing.demandLevel = 'HIGH';
    else if (totalDemand > 20) existing.demandLevel = 'MODERATE';
    else existing.demandLevel = 'LOW';

    existing.confidence = Math.min(0.95, 0.5 + (totalDemand * 0.01));
    this.demandSignals.set(key, existing);

    // Emit demand insights
    if (existing.demandLevel === 'SURGING') {
      this.addInsight({
        type: 'CORRELATION',
        severity: 'HIGH',
        entityType: 'demand',
        entityId: key,
        confidence: existing.confidence,
        insight: `Surging demand detected for ${existing.propertyType} in ${existing.location}. Consider increasing listings or adjusting pricing.`,
        data: existing,
        sourceModules: ['BookingOS', 'ListingOS'],
      });
    }
  }

  // ─── Risk Assessment ─────────────────────────────────────────────────────

  private isRiskRelevantEvent(event: string): boolean {
    const e = event.toUpperCase();
    return e.includes('FRAUD') || e.includes('KYC') || e.includes('SECURITY') ||
      e.includes('COMPLIANCE') || e.includes('ACCESS_LOG') || e.includes('FAILED');
  }

  private updateRiskAssessment(event: string, payload: any) {
    const entityId = payload.userId || payload.id || 'unknown';
    const existing = this.riskAssessments.get(entityId) || {
      entityId,
      entityType: 'user',
      overallRisk: 'LOW' as const,
      fraudRisk: 0,
      complianceRisk: 0,
      operationalRisk: 0,
      financialRisk: 0,
      factors: [] as string[],
      recommendedActions: [] as string[],
      assessedAt: new Date(),
    };

    if (event.includes('FRAUD')) existing.fraudRisk = Math.min(100, existing.fraudRisk + 25);
    if (event.includes('KYC_REJECTED')) existing.complianceRisk = Math.min(100, existing.complianceRisk + 30);
    if (event.includes('COMPLIANCE_CHECK_FAILED')) existing.complianceRisk = Math.min(100, existing.complianceRisk + 15);
    if (event.includes('SECURITY')) existing.operationalRisk = Math.min(100, existing.operationalRisk + 10);
    if (event.includes('FAILED_LOGIN') || event.includes('FAILED')) existing.financialRisk = Math.min(100, existing.financialRisk + 5);

    // Normalize overall risk
    const maxRisk = Math.max(existing.fraudRisk, existing.complianceRisk, existing.operationalRisk, existing.financialRisk);
    if (maxRisk > 75) existing.overallRisk = 'CRITICAL';
    else if (maxRisk > 50) existing.overallRisk = 'HIGH';
    else if (maxRisk > 25) existing.overallRisk = 'MEDIUM';
    else existing.overallRisk = 'LOW';

    existing.assessedAt = new Date();
    this.riskAssessments.set(entityId, existing);

    if (existing.overallRisk === 'CRITICAL') {
      this.addInsight({
        type: 'ALERT',
        severity: 'CRITICAL',
        entityType: existing.entityType,
        entityId,
        confidence: 0.95,
        insight: `CRITICAL risk level for ${entityId}. Immediate action required.`,
        data: existing,
        sourceModules: ['SecurityOS', 'GovernanceOS'],
      });
    }
  }

  // ─── Cross-Module Correlation ────────────────────────────────────────────

  private runCrossModuleCorrelation() {
    const userNodes = Array.from(this.nodes.entries()).filter(([k]) => k.startsWith('user:'));

    for (const [key, node] of userNodes.slice(0, 50)) {
      const userId = node.id;
      const connectedTypes = new Set<string>();
      for (const conn of node.connections) {
        const type = conn.split(':')[0];
        connectedTypes.add(type);
      }

      // Multi-OS engagement: user active across 5+ modules
      if (connectedTypes.size >= 5) {
        this.addInsight({
          type: 'CORRELATION',
          severity: 'LOW',
          entityType: 'user',
          entityId: userId,
          confidence: 0.8,
          insight: `Power user detected: active across ${connectedTypes.size} OS modules (${Array.from(connectedTypes).join(', ')})`,
          data: { connectedModules: Array.from(connectedTypes), connectionCount: node.connections.size },
          sourceModules: this.extractSourceModules(node),
        });
      }

      // Revenue opportunity: user with high trust but low commerce activity
      const trustScore = this.trustScores.get(userId);
      if (trustScore && trustScore.overall > 70) {
        const hasCommerce = connectedTypes.has('commerce') || connectedTypes.has('campaign');
        if (!hasCommerce && connectedTypes.size > 3) {
          this.addInsight({
            type: 'RECOMMENDATION',
            severity: 'MEDIUM',
            entityType: 'user',
            entityId: userId,
            confidence: 0.7,
            insight: `High-trust user (${trustScore.overall}/100) with no commerce engagement. Revenue opportunity.`,
            data: { trustScore: trustScore.overall, activeModules: Array.from(connectedTypes) },
            sourceModules: ['IdentityOS', 'CommerceOS'],
          });
        }
      }
    }

    // Property cross-module insights
    const propertyNodes = Array.from(this.nodes.entries()).filter(([k]) => k.startsWith('property:'));
    for (const [key, node] of propertyNodes.slice(0, 50)) {
      const connectedTypes = new Set<string>();
      for (const conn of node.connections) {
        connectedTypes.add(conn.split(':')[0]);
      }

      // Property with operations issues but no maintenance attention
      const hasOperations = connectedTypes.has('maintenance');
      const hasSecurity = connectedTypes.has('security');
      if (hasSecurity && !hasOperations) {
        this.addInsight({
          type: 'CORRELATION',
          severity: 'MEDIUM',
          entityType: 'property',
          entityId: node.id,
          confidence: 0.75,
          insight: `Property has security events but no maintenance activity. Risk of unresolved issues.`,
          data: { connectedModules: Array.from(connectedTypes) },
          sourceModules: ['SecurityOS', 'OperationsOS'],
        });
      }
    }
  }

  // ─── Insight Management ──────────────────────────────────────────────────

  private addInsight(insight: Omit<AIInsight, 'id' | 'createdAt'>) {
    // Dedup: skip if same insight for same entity in last hour
    const recentDupe = this.insights.find(i =>
      i.entityType === insight.entityType &&
      i.entityId === insight.entityId &&
      i.insight === insight.insight &&
      (Date.now() - i.createdAt.getTime()) < 3600000
    );
    if (recentDupe) return;

    const fullInsight: AIInsight = {
      ...insight,
      id: uuidv4(),
      createdAt: new Date(),
    };

    this.insights.push(fullInsight);
    if (this.insights.length > this.maxInsights) {
      this.insights = this.insights.slice(-this.maxInsights);
    }

    eventBus.publish('AI_INSIGHT_GENERATED', fullInsight);
  }

  // ─── Public API ──────────────────────────────────────────────────────────

  analyze(entityType: string, entityId: string): AIInsight[] {
    return this.insights.filter(i => i.entityType === entityType && i.entityId === entityId);
  }

  predict(entityType: string, entityId: string): { trend: string; confidence: number; factors: string[] } {
    const key = `${entityType}:${entityId}`;
    const node = this.nodes.get(key);
    if (!node) return { trend: 'insufficient_data', confidence: 0, factors: [] };

    const totalSignals = Array.from(node.signals.values()).reduce((a, b) => a + b, 0);
    const timeSinceUpdate = Date.now() - node.lastUpdated.getTime();
    const daysSinceUpdate = timeSinceUpdate / (24 * 60 * 60 * 1000);

    const factors: string[] = [];
    if (totalSignals > 20) factors.push('High event volume');
    if (node.connections.size > 5) factors.push('Multi-module engagement');
    if (daysSinceUpdate < 7) factors.push('Recently active');

    if (totalSignals > 20 && daysSinceUpdate < 7) {
      return { trend: 'active', confidence: 0.8, factors };
    } else if (totalSignals > 5) {
      return { trend: 'moderate', confidence: 0.6, factors };
    } else if (daysSinceUpdate > 30) {
      return { trend: 'inactive', confidence: 0.7, factors: ['Long idle period'] };
    }

    return { trend: 'low_activity', confidence: 0.5, factors };
  }

  recommend(orgId: string): AIInsight[] {
    return this.insights
      .filter(i => {
        const key = `${i.entityType}:${i.entityId}`;
        const node = this.nodes.get(key);
        return node?.orgId === orgId;
      })
      .filter(i => i.type === 'RECOMMENDATION')
      .slice(-10);
  }

  getTrustScore(userId: string): TrustScore | undefined {
    return this.trustScores.get(userId);
  }

  getDemandSignals(): DemandSignal[] {
    return Array.from(this.demandSignals.values());
  }

  getRiskAssessments(): RiskAssessment[] {
    return Array.from(this.riskAssessments.values());
  }

  getHighRiskEntities(): RiskAssessment[] {
    return Array.from(this.riskAssessments.values())
      .filter(r => r.overallRisk === 'HIGH' || r.overallRisk === 'CRITICAL');
  }

  getTopTrustedUsers(limit: number = 10): TrustScore[] {
    return Array.from(this.trustScores.values())
      .sort((a, b) => b.overall - a.overall)
      .slice(0, limit);
  }

  getEntityTypeStats(): Record<string, number> {
    const stats: Record<string, number> = {};
    for (const [, node] of this.nodes) {
      stats[node.type] = (stats[node.type] || 0) + 1;
    }
    return stats;
  }

  getCrossModuleConnections(): { entity: string; connections: string[]; moduleCount: number }[] {
    const results: { entity: string; connections: string[]; moduleCount: number }[] = [];
    for (const [key, node] of this.nodes) {
      if (node.connections.size > 2) {
        const modules = new Set<string>();
        for (const conn of node.connections) {
          modules.add(conn.split(':')[0]);
        }
        if (modules.size >= 3) {
          results.push({
            entity: key,
            connections: Array.from(node.connections),
            moduleCount: modules.size,
          });
        }
      }
    }
    return results.sort((a, b) => b.moduleCount - a.moduleCount).slice(0, 50);
  }

  getStats() {
    const insightsByType: Record<string, number> = {};
    const insightsBySeverity: Record<string, number> = {};
    for (const insight of this.insights) {
      insightsByType[insight.type] = (insightsByType[insight.type] || 0) + 1;
      insightsBySeverity[insight.severity] = (insightsBySeverity[insight.severity] || 0) + 1;
    }

    return {
      nodeCount: this.nodes.size,
      insightCount: this.insights.length,
      trustScoreCount: this.trustScores.size,
      demandSignalCount: this.demandSignals.size,
      riskAssessmentCount: this.riskAssessments.size,
      highRiskCount: this.getHighRiskEntities().length,
      insightsByType,
      insightsBySeverity,
      eventTypeCount: this.eventCounts.size,
      totalEvents: Array.from(this.eventCounts.values()).reduce((a, b) => a + b, 0),
      topEvents: Array.from(this.eventCounts.entries())
        .sort((a, b) => b[1] - a[1])
        .slice(0, 20),
      entityTypes: this.getEntityTypeStats(),
    };
  }
}

export const intelligenceGraph = new IntelligenceGraph();
