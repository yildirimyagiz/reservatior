/**
 * Intelligence Graph — Central AI Decision System
 *
 * Listens to ALL domain events and maintains a "neural" graph of entity
 * relationships (users, properties, agents, campaigns). Provides analysis,
 * prediction, and recommendation methods that emit AI-generated insights
 * back to the event bus.
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
}

export interface AIInsight {
  id: string;
  type: 'ANALYSIS' | 'PREDICTION' | 'RECOMMENDATION';
  entityType: string;
  entityId: string;
  confidence: number;
  insight: string;
  data?: any;
  createdAt: Date;
}

// ─── Intelligence Graph ───────────────────────────────────────────────────────

export class IntelligenceGraph {
  private nodes: Map<string, EntityNode> = new Map();
  private insights: AIInsight[] = [];
  private eventCounts: Map<string, number> = new Map();
  private maxInsights = 1000;

  constructor() {
    this.setupListeners();
  }

  private setupListeners() {
    eventBus.subscribe('*', (event: string, payload: any) => {
      this.processEvent(event, payload);
    });
  }

  private processEvent(event: string, payload: any) {
    const count = this.eventCounts.get(event) || 0;
    this.eventCounts.set(event, count + 1);

    const entityType = this.extractEntityType(event);
    const entityId = payload?.id || payload?.userId || payload?.propertyId || payload?.dealId || payload?.bookingId;

    if (entityType && entityId) {
      const node = this.getOrCreateNode(entityType, entityId, payload.orgId);
      
      const signalKey = event;
      const currentSignal = node.signals.get(signalKey) || 0;
      node.signals.set(signalKey, currentSignal + 1);
      node.lastUpdated = new Date();

      this.detectPatterns(entityType, entityId, node, event, payload);
    }
  }

  private extractEntityType(event: string): string | null {
    if (event.includes('USER') || event.includes('AGENT')) return 'user';
    if (event.includes('PROPERTY') || event.includes('LISTING')) return 'property';
    if (event.includes('DEAL') || event.includes('INVESTMENT') || event.includes('VALUATION')) return 'deal';
    if (event.includes('BOOKING') || event.includes('VIEWING')) return 'booking';
    if (event.includes('CAMPAIGN') || event.includes('AD_')) return 'campaign';
    if (event.includes('MAINTENANCE') || event.includes('INSPECTION') || event.includes('CLEANING')) return 'maintenance';
    if (event.includes('KYC') || event.includes('FRAUD') || event.includes('SECURITY')) return 'security';
    if (event.includes('TENANT') || event.includes('LEASE')) return 'tenant';
    if (event.includes('CONTRACT')) return 'contract';
    if (event.includes('PAYMENT') || event.includes('COMMISSION')) return 'finance';
    return null;
  }

  private getOrCreateNode(type: string, id: string, orgId?: string): EntityNode {
    const key = `${type}:${id}`;
    let node = this.nodes.get(key);
    if (!node) {
      node = {
        id,
        type,
        orgId,
        signals: new Map(),
        connections: new Set(),
        lastUpdated: new Date(),
      };
      this.nodes.set(key, node);
    }
    return node;
  }

  private detectPatterns(entityType: string, entityId: string, node: EntityNode, event: string, payload: any) {
    // Engagement spikes: high event frequency from a single entity
    const totalSignals = Array.from(node.signals.values()).reduce((a, b) => a + b, 0);
    if (totalSignals > 10) {
      this.addInsight({
        type: 'ANALYSIS',
        entityType,
        entityId,
        confidence: 0.85,
        insight: `High engagement detected: ${totalSignals} events from ${entityType} ${entityId}`,
        data: { eventCounts: Object.fromEntries(node.signals) },
      });
    }

    // CTR drops for campaigns
    if (entityType === 'campaign' && event.includes('IMPRESSION')) {
      const clickCount = node.signals.get('CAMPAIGN_CLICKED') || 0;
      const impressionCount = node.signals.get('CAMPAIGN_IMPRESSION') || 0;
      if (impressionCount > 100 && clickCount / impressionCount < 0.01) {
        this.addInsight({
          type: 'RECOMMENDATION',
          entityType,
          entityId,
          confidence: 0.9,
          insight: `CTR below 1% for campaign ${entityId}. Consider A/B testing new creatives.`,
        });
      }
    }

    // Maintenance backlog detection
    if (entityType === 'maintenance' && event === 'MAINTENANCE_SCHEDULED') {
      const overdueCount = node.signals.get('MAINTENANCE_OVERDUE') || 0;
      if (overdueCount > 3) {
        this.addInsight({
          type: 'ALERT',
          entityType,
          entityId,
          confidence: 0.95,
          insight: `Maintenance backlog: ${overdueCount} overdue items for property ${entityId}`,
        });
      }
    }

    // Security brute-force detection
    if (entityType === 'security' && event.includes('FAILED')) {
      const failCount = node.signals.get('SECURITY_FAILED_LOGIN') || 0;
      if (failCount > 5) {
        this.addInsight({
          type: 'ALERT',
          entityType,
          entityId,
          confidence: 0.98,
          insight: `Possible brute-force attack: ${failCount} failed attempts for user ${entityId}`,
        });
      }
    }
  }

  private addInsight(insight: Omit<AIInsight, 'id' | 'createdAt'>) {
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

  // ─── Public API ─────────────────────────────────────────────────────────────

  analyze(entityType: string, entityId: string): AIInsight[] {
    const key = `${entityType}:${entityId}`;
    const node = this.nodes.get(key);
    if (!node) return [];

    return this.insights.filter(i => i.entityType === entityType && i.entityId === entityId);
  }

  predict(entityType: string, entityId: string): { trend: string; confidence: number } {
    const key = `${entityType}:${entityId}`;
    const node = this.nodes.get(key);
    if (!node) return { trend: 'insufficient_data', confidence: 0 };

    const totalSignals = Array.from(node.signals.values()).reduce((a, b) => a + b, 0);
    const timeSinceUpdate = Date.now() - node.lastUpdated.getTime();
    const daysSinceUpdate = timeSinceUpdate / (24 * 60 * 60 * 1000);

    if (totalSignals > 20 && daysSinceUpdate < 7) {
      return { trend: 'active', confidence: 0.8 };
    } else if (totalSignals > 5) {
      return { trend: 'moderate', confidence: 0.6 };
    } else if (daysSinceUpdate > 30) {
      return { trend: 'inactive', confidence: 0.7 };
    }

    return { trend: 'low_activity', confidence: 0.5 };
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

  getStats() {
    return {
      nodeCount: this.nodes.size,
      insightCount: this.insights.length,
      eventCounts: Object.fromEntries(this.eventCounts),
      topEvents: Array.from(this.eventCounts.entries())
        .sort((a, b) => b[1] - a[1])
        .slice(0, 20),
    };
  }

  private linearRegression(history: { timestamp: Date; value: number }[]): { slope: number; intercept: number } {
    const n = history.length;
    if (n < 2) return { slope: 0, intercept: 0 };

    const startTime = history[0].timestamp.getTime();
    const points = history.map((h, i) => ({
      x: (h.timestamp.getTime() - startTime) / (24 * 60 * 60 * 1000),
      y: h.value,
    }));

    const sumX = points.reduce((a, p) => a + p.x, 0);
    const sumY = points.reduce((a, p) => a + p.y, 0);
    const sumXY = points.reduce((a, p) => a + p.x * p.y, 0);
    const sumX2 = points.reduce((a, p) => a + p.x * p.x, 0);

    const denominator = n * sumX2 - sumX * sumX;
    if (denominator === 0) return { slope: 0, intercept: sumY / n };

    const slope = (n * sumXY - sumX * sumY) / denominator;
    const intercept = (sumY - slope * sumX) / n;

    return { slope, intercept };
  }
}

export const intelligenceGraph = new IntelligenceGraph();
