import { PrismaClient, KnowledgeEdge, KnowledgeNode, GraphRelationType, Prisma } from "@prisma/client";

const prisma = new PrismaClient();

export type EdgeWithTarget = KnowledgeEdge & { targetNode: KnowledgeNode };

export interface WorkingSet {
  nodes: KnowledgeNode[];
  edges: CalculatedKnowledgeEdge[];
}

export interface CalculatedKnowledgeEdge extends EdgeWithTarget {
  ageInDays: number;
  effectiveWeight: number;
  traversalScore: number;
}

export class KnowledgeGraphService {
  /**
   * Exponential decay calculation: weight * e^(-decayFactor * age)
   */
  static calculateDecay(edge: EdgeWithTarget, contextScore: number = 1.0, freshnessBoost: number = 1.0): CalculatedKnowledgeEdge {
    const now = new Date().getTime();
    const lastObserved = new Date(edge.lastObservedAt).getTime();
    const ageInDays = Math.max(0, (now - lastObserved) / (1000 * 60 * 60 * 24));

    // e^(-decayFactor * age)
    const exponentialDecay = Math.exp(-edge.decayFactor * ageInDays);
    const effectiveWeight = edge.weight * exponentialDecay;

    // TraversalScore = effectiveWeight * confidence * contextScore * freshness
    const traversalScore = effectiveWeight * edge.confidence * contextScore * freshnessBoost;

    return {
      ...edge,
      ageInDays,
      effectiveWeight,
      traversalScore,
    };
  }

  /**
   * Extracts a Working Set (localized subgraph) for an active session to prevent full DB traversal.
   */
  static async extractWorkingSet(userId: string, contextLabels: string[] = []): Promise<WorkingSet> {
    console.log(`[KnowledgeGraph] Extracting Working Set for User: ${userId}`);
    
    // 1. Find User Node
    // @ts-ignore - Prisma client cache issue in IDE
    const userNode = await prisma.knowledgeNode.findUnique({
      where: { entityType_entityId: { entityType: "USER", entityId: userId } },
      include: {
        outgoingEdges: {
          include: { targetNode: true },
          where: { validTo: null } // Only valid edges
        }
      }
    });

    if (!userNode) return { nodes: [], edges: [] };

    const rawEdges = userNode.outgoingEdges;
    const nodesMap = new Map<string, KnowledgeNode>();
    nodesMap.set(userNode.id, userNode);

    // 2. Calculate dynamic TraversalScores for edges and map target nodes
    const calculatedEdges: CalculatedKnowledgeEdge[] = rawEdges.map((edge: any) => {
      // Mock contextScore if it matches current contextLabels (e.g. search intent)
      const isContextRelevant = contextLabels.some(label => 
        (edge.metadata as any)?.context?.includes(label)
      );
      const contextScore = isContextRelevant ? 1.2 : 0.8;
      
      const calcEdge = this.calculateDecay(edge, contextScore, 1.0);
      nodesMap.set(calcEdge.targetNode.id, calcEdge.targetNode);
      return calcEdge;
    });

    // 3. Filter out irrelevant edges based on TraversalScore threshold
    const filteredEdges = calculatedEdges.filter(e => e.traversalScore > 0.2);

    return {
      nodes: Array.from(nodesMap.values()),
      edges: filteredEdges,
    };
  }
}
