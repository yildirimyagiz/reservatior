/**
 * Reputation Graph Service
 * 
 * Extends Trust OS Trust Graph with advanced reputation analysis.
 * Builds relationship networks (Tenant → Property → Owner → Agent → Transaction)
 * and provides network analysis, influence scoring, path finding, and community detection.
 */

import { prisma } from "../../lib/prisma";
import { trustGraphService } from "../trust/trust-graph.service";

export enum EntityType {
  TENANT = "TENANT",
  LANDLORD = "LANDLORD",
  AGENT = "AGENT",
  PROPERTY = "PROPERTY",
  TRANSACTION = "TRANSACTION",
}

export enum EdgeType {
  TENANT_RENTED_PROPERTY = "TENANT_RENTED_PROPERTY",
  LANDLORD_OWNS_PROPERTY = "LANDLORD_OWNS_PROPERTY",
  AGENT_MANAGED_PROPERTY = "AGENT_MANAGED_PROPERTY",
  AGENT_MANAGED_TRANSACTION = "AGENT_MANAGED_TRANSACTION",
  TENANT_PAID_LANDLORD = "TENANT_PAID_LANDLORD",
  LANDLORD_HIRED_AGENT = "LANDLORD_HIRED_AGENT",
  PROPERTY_PART_OF_TRANSACTION = "PROPERTY_PART_OF_TRANSACTION",
  TENANT_REFERRED_BY_AGENT = "TENANT_REFERRED_BY_AGENT",
  LANDLORD_REFERRED_BY_AGENT = "LANDLORD_REFERRED_BY_AGENT",
}

export interface ReputationNode {
  id: string;
  entityType: EntityType;
  entityId: string;
  trustScore: number;
  influenceScore: number;
  reputationScore: number;
  metadata: any;
}

export interface ReputationEdge {
  id: string;
  fromNodeId: string;
  toNodeId: string;
  edgeType: EdgeType;
  trustWeight: number;
  interactionCount: number;
  lastInteraction: Date;
  metadata: any;
}

export interface ReputationPath {
  nodes: ReputationNode[];
  edges: ReputationEdge[];
  totalTrustScore: number;
  pathLength: number;
}

export class ReputationGraphService {
  /**
   * Build reputation graph for an entity
   */
  async buildReputationGraph(
    entityType: EntityType,
    entityId: string,
    maxDepth: number = 3
  ): Promise<{ nodes: ReputationNode[]; edges: ReputationEdge[] }> {
    // Start with the entity's trust graph node
    const startNode = await trustGraphService.createNode(entityType, entityId, {});
    
    // Get connected nodes up to maxDepth
    const nodes: ReputationNode[] = [];
    const edges: ReputationEdge[] = [];
    const visited = new Set<string>();
    const queue: { nodeId: string; depth: number }[] = [{ nodeId: startNode.id, depth: 0 }];

    while (queue.length > 0) {
      const { nodeId, depth } = queue.shift()!;
      
      if (depth >= maxDepth || visited.has(nodeId)) continue;
      visited.add(nodeId);

      const node = await this.getReputationNode(nodeId);
      if (node) nodes.push(node);

      const connectedEdges = await this.getConnectedEdges(nodeId);
      for (const edge of connectedEdges) {
        if (!visited.has(edge.toNodeId)) {
          queue.push({ nodeId: edge.toNodeId, depth: depth + 1 });
        }
        edges.push(edge);
      }
    }

    return { nodes, edges };
  }

  /**
   * Calculate influence score for an entity
   */
  async calculateInfluenceScore(
    entityType: EntityType,
    entityId: string
  ): Promise<number> {
    const graph = await this.buildReputationGraph(entityType, entityId, 2);
    
    let influenceScore = 0;
    const nodeMap = new Map(graph.nodes.map(n => [n.id, n]));
    
    for (const edge of graph.edges) {
      const fromNode = nodeMap.get(edge.fromNodeId);
      const toNode = nodeMap.get(edge.toNodeId);
      
      if (fromNode && toNode) {
        // Influence = trustWeight * (fromNode.trustScore + toNode.trustScore) / 2
        const edgeInfluence = edge.trustWeight * ((fromNode.trustScore + toNode.trustScore) / 2);
        influenceScore += edgeInfluence;
      }
    }

    // Normalize to 0-100
    return Math.min(influenceScore * 10, 100);
  }

  /**
   * Calculate overall reputation score
   */
  async calculateReputationScore(
    entityType: EntityType,
    entityId: string
  ): Promise<number> {
    const trustScore = await this.getEntityTrustScore(entityType, entityId);
    const influenceScore = await this.calculateInfluenceScore(entityType, entityId);
    const networkQuality = await this.calculateNetworkQuality(entityType, entityId);
    
    // Weighted average: Trust (50%), Influence (30%), Network Quality (20%)
    return (trustScore * 0.5) + (influenceScore * 0.3) + (networkQuality * 0.2);
  }

  /**
   * Calculate network quality score
   */
  private async calculateNetworkQuality(
    entityType: EntityType,
    entityId: string
  ): Promise<number> {
    const graph = await this.buildReputationGraph(entityType, entityId, 2);
    
    if (graph.nodes.length === 0) return 50;
    
    const avgTrustScore = graph.nodes.reduce((sum, n) => sum + n.trustScore, 0) / graph.nodes.length;
    const highTrustConnections = graph.nodes.filter(n => n.trustScore >= 75).length;
    const lowTrustConnections = graph.nodes.filter(n => n.trustScore < 50).length;
    
    // Network quality based on average trust and ratio of high/low trust connections
    const qualityScore = avgTrustScore * 0.6 + 
      (highTrustConnections / graph.nodes.length) * 30 - 
      (lowTrustConnections / graph.nodes.length) * 20;
    
    return Math.max(0, Math.min(qualityScore, 100));
  }

  /**
   * Find trust path between two entities
   */
  async findTrustPath(
    fromEntityType: EntityType,
    fromEntityId: string,
    toEntityType: EntityType,
    toEntityId: string,
    maxHops: number = 5
  ): Promise<ReputationPath | null> {
    const fromNode = await trustGraphService.createNode(fromEntityType, fromEntityId, {});
    const toNode = await trustGraphService.createNode(toEntityType, toEntityId, {});
    
    const visited = new Set<string>();
    const queue: { nodeId: string; path: string[]; edges: ReputationEdge[] }[] = [
      { nodeId: fromNode.id, path: [fromNode.id], edges: [] }
    ];

    while (queue.length > 0) {
      const { nodeId, path, edges } = queue.shift()!;
      
      if (nodeId === toNode.id) {
        const nodes = await Promise.all(path.map(id => this.getReputationNode(id)));
        const validNodes = nodes.filter((n): n is ReputationNode => n !== null);
        
        const totalTrustScore = validNodes.reduce((sum, n) => sum + n.trustScore, 0) / validNodes.length;
        
        return {
          nodes: validNodes,
          edges,
          totalTrustScore,
          pathLength: path.length - 1,
        };
      }

      if (path.length > maxHops || visited.has(nodeId)) continue;
      visited.add(nodeId);

      const connectedEdges = await this.getConnectedEdges(nodeId);
      for (const edge of connectedEdges) {
        if (!visited.has(edge.toNodeId)) {
          queue.push({
            nodeId: edge.toNodeId,
            path: [...path, edge.toNodeId],
            edges: [...edges, edge],
          });
        }
      }
    }

    return null;
  }

  /**
   * Detect communities in the reputation graph
   */
  async detectCommunities(
    entityType: EntityType,
    entityId: string,
    minCommunitySize: number = 3
  ): Promise<ReputationNode[][]> {
    const graph = await this.buildReputationGraph(entityType, entityId, 3);
    
    // Simple community detection using connected components
    const visited = new Set<string>();
    const communities: ReputationNode[][] = [];

    for (const node of graph.nodes) {
      if (visited.has(node.id)) continue;
      
      const community: ReputationNode[] = [];
      const queue = [node.id];
      visited.add(node.id);

      while (queue.length > 0) {
        const nodeId = queue.shift()!;
        const currentNode = graph.nodes.find(n => n.id === nodeId);
        if (currentNode) community.push(currentNode);

        const connectedEdges = graph.edges.filter(e => e.fromNodeId === nodeId);
        for (const edge of connectedEdges) {
          if (!visited.has(edge.toNodeId)) {
            visited.add(edge.toNodeId);
            queue.push(edge.toNodeId);
          }
        }
      }

      if (community.length >= minCommunitySize) {
        communities.push(community);
      }
    }

    return communities;
  }

  /**
   * Get reputation node
   */
  private async getReputationNode(nodeId: string): Promise<ReputationNode | null> {
    const node = await prisma.trustGraphNode.findUnique({
      where: { id: nodeId },
    });

    if (!node) return null;

    const influenceScore = await this.calculateInfluenceScore(
      node.entityType as EntityType,
      node.entityId
    );

    return {
      id: node.id,
      entityType: node.entityType as EntityType,
      entityId: node.entityId,
      trustScore: node.trustScore,
      influenceScore,
      reputationScore: (node.trustScore + influenceScore) / 2,
      metadata: node.nodeData,
    };
  }

  /**
   * Get connected edges for a node
   */
  private async getConnectedEdges(nodeId: string): Promise<ReputationEdge[]> {
    const edges = await prisma.trustGraphEdge.findMany({
      where: { fromNodeId: nodeId },
    });

    return edges.map(edge => ({
      id: edge.id,
      fromNodeId: edge.fromNodeId,
      toNodeId: edge.toNodeId,
      edgeType: edge.edgeType as EdgeType,
      trustWeight: edge.trustWeight,
      interactionCount: 1,
      lastInteraction: edge.createdAt,
      metadata: edge.edgeData,
    }));
  }

  /**
   * Get entity trust score
   */
  private async getEntityTrustScore(
    entityType: EntityType,
    entityId: string
  ): Promise<number> {
    switch (entityType) {
      case EntityType.TENANT:
        const tenantProfile = await prisma.tenantTrustProfile.findUnique({
          where: { tenantId: entityId },
        });
        return tenantProfile?.overallScore || 50;
      
      case EntityType.LANDLORD:
        const landlordProfile = await prisma.landlordTrustProfile.findUnique({
          where: { landlordId: entityId },
        });
        return landlordProfile?.overallScore || 50;
      
      case EntityType.AGENT:
        const agentProfile = await prisma.agentReputationProfile.findUnique({
          where: { agentId: entityId },
        });
        return agentProfile?.overallScore || 50;
      
      case EntityType.PROPERTY:
        const propertyProfile = await prisma.propertyTrustProfile.findUnique({
          where: { propertyId: entityId },
        });
        return propertyProfile?.overallScore || 50;
      
      case EntityType.TRANSACTION:
        const transactionProfile = await prisma.transactionTrustProfile.findUnique({
          where: { transactionId: entityId },
        });
        return transactionProfile?.overallScore || 50;
      
      default:
        return 50;
    }
  }

  /**
   * Get reputation summary for an entity
   */
  async getReputationSummary(
    entityType: EntityType,
    entityId: string
  ): Promise<any> {
    const trustScore = await this.getEntityTrustScore(entityType, entityId);
    const influenceScore = await this.calculateInfluenceScore(entityType, entityId);
    const reputationScore = await this.calculateReputationScore(entityType, entityId);
    const graph = await this.buildReputationGraph(entityType, entityId, 2);
    const communities = await this.detectCommunities(entityType, entityId);

    return {
      entityType,
      entityId,
      trustScore,
      influenceScore,
      reputationScore,
      networkSize: graph.nodes.length,
      connectionCount: graph.edges.length,
      communityCount: communities.length,
      avgConnectionTrust: graph.nodes.length > 0 
        ? graph.nodes.reduce((sum, n) => sum + n.trustScore, 0) / graph.nodes.length 
        : 0,
    };
  }
}

export const reputationGraphService = new ReputationGraphService();
