import { BaseDomainEvent } from "../events/catalog";
import { BaseDecisionNode, DecisionNodeResult } from "./nodes/base-node";
import { ConfidenceNode } from "./nodes/confidence-node";
import { PricingNode } from "./nodes/pricing-node";
import { ConversionNode } from "./nodes/conversion-node";
import { OpportunityNode } from "./nodes/opportunity-node";
import { DecisionJournalService } from "./decision-journal";
import { executionPlanner } from "./execution-planner";

// Simple in-memory cache for event decisions (event type + entity id)
const decisionCache = new Map<string, any>();

export class DecisionGraph {
  private nodes: BaseDecisionNode[] = [];

  constructor() {
    // Register the core AI Gateway Node
    this.registerNode(new ConfidenceNode());
    
    // Specialized Decision Nodes
    this.registerNode(new ConversionNode());
    this.registerNode(new PricingNode());
    
    // The capstone node: Opportunity Generation
    this.registerNode(new OpportunityNode());
    
    // Future specialized nodes:
    // this.registerNode(new ContractNode());
    // this.registerNode(new ContractNode());
    // this.registerNode(new FraudNode());
  }

  registerNode(node: BaseDecisionNode) {
    this.nodes.push(node);
    console.log(`[DecisionGraph] Registered Node: ${node.name}`);
  }

  /**
   * Hybrid Processing: 
   * Runs the graph to get an immediate snapshot for the UI, 
   * but delegates heavy Graph DB mutations to background tasks.
   */
  async processEventSync(event: BaseDomainEvent) {
    const cacheKey = `${event.eventName}_${event.entityId}`;
    
    // 1. Check Decision Cache (Lightweight Lookup)
    if (decisionCache.has(cacheKey)) {
      console.log(`[DecisionGraph] Cache hit for ${cacheKey}`);
      return decisionCache.get(cacheKey);
    }

    console.log(`[DecisionGraph] Sync processing: ${event.eventName}`);
    const snapshot: any = {
      opportunities: [],
      currentScore: 0,
      nextBestAction: null
    };

    // Process nodes (Lightweight mathematical evaluation)
    for (const node of this.nodes) {
      try {
        const result = await node.process(event);
        if (result) {
          if (node.name === "OpportunityNode") {
            snapshot.currentScore = result.metadata?.opportunityScore || 0;
            snapshot.opportunities = result.metadata?.proposedActions || [];
            if (snapshot.opportunities.length > 0) {
              // Sort by priority to find next best action
              const sorted = [...snapshot.opportunities].sort((a,b) => b.priority - a.priority);
              snapshot.nextBestAction = sorted[0].action;
            }
          }
          
          // 2. Fire and forget Async Tasks (Heavy computation, DB writes)
          this.executeAsyncTask(event, node, result);
        }
      } catch (err) {
        console.error(`[DecisionGraph] Error in sync node ${node.name}:`, err);
      }
    }

    // Cache the snapshot temporarily (TTL: 60s)
    decisionCache.set(cacheKey, snapshot);
    setTimeout(() => decisionCache.delete(cacheKey), 60000);

    return snapshot;
  }

  /**
   * Async Heavy Lifting (Eventual Consistency)
   */
  private async executeAsyncTask(event: BaseDomainEvent, node: BaseDecisionNode, result: DecisionNodeResult) {
    // In production, this would publish to a dedicated RabbitMQ worker queue.
    // Here we use a detached promise chain to simulate async background processing.
    Promise.resolve().then(async () => {
      try {
        await DecisionJournalService.logDecision({
          eventName: event.eventName,
          decision: result.decision,
          reason: result.reason,
          confidence: result.confidence,
          revenueImpact: result.revenueImpact,
          outcome: result.outcomeExpected,
        });

        if (result.metadata?.proposedActions) {
          executionPlanner.planExecution(result);
        }
        
        // TODO: trigger KnowledgeGraph.updateDecay() and evaluate Contract Mutations.
      } catch (err) {
        console.error(`[DecisionGraph-Async] Error logging background tasks:`, err);
      }
    });
  }

  // Legacy entrypoint for pure async message bus consumers
  async processEvent(event: BaseDomainEvent) {
    return this.processEventSync(event);
  }
}

// Singleton instance
export const decisionGraph = new DecisionGraph();
