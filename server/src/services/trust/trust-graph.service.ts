import { prisma } from "../../lib/prisma";
import { TrustGraphNode, TrustGraphEdge } from "@prisma/client";

const ENTITY_TYPES = {
  TENANT: "TENANT",
  LANDLORD: "LANDLORD",
  AGENT: "AGENT",
  PROPERTY: "PROPERTY",
  CONTRACT: "CONTRACT",
  PAYMENT: "PAYMENT",
  MAINTENANCE: "MAINTENANCE",
  TRANSACTION: "TRANSACTION",
};

const EDGE_TYPES = {
  TENANT_RENTED_PROPERTY: "TENANT_RENTED_PROPERTY",
  LANDLORD_OWNS_PROPERTY: "LANDLORD_OWNS_PROPERTY",
  AGENT_MANAGED_PROPERTY: "AGENT_MANAGED_PROPERTY",
  AGENT_HANDLED_TRANSACTION: "AGENT_HANDLED_TRANSACTION",
  TENANT_PAID_LANDLORD: "TENANT_PAID_LANDLORD",
  PROPERTY_MAINTENANCE_REQUEST: "PROPERTY_MAINTENANCE_REQUEST",
  CONTRACT_SIGNED: "CONTRACT_SIGNED",
  PAYMENT_PROCESSED: "PAYMENT_PROCESSED",
};

export const trustGraphService = {
  async createNode(entityType: string, entityId: string, nodeData?: any): Promise<TrustGraphNode> {
    const existingNode = await prisma.trustGraphNode.findUnique({
      where: {
        entityType_entityId: {
          entityType,
          entityId,
        },
      },
    });

    if (existingNode) {
      return existingNode;
    }

    return await prisma.trustGraphNode.create({
      data: {
        entityType,
        entityId,
        nodeData: nodeData || {},
        trustScore: 50,
        riskLevel: "UNKNOWN",
      },
    });
  },

  async updateNodeScore(entityType: string, entityId: string, trustScore: number, riskLevel?: string): Promise<TrustGraphNode | null> {
    const node = await prisma.trustGraphNode.findUnique({
      where: {
        entityType_entityId: {
          entityType,
          entityId,
        },
      },
    });

    if (!node) {
      return await this.createNode(entityType, entityId, { trustScore, riskLevel });
    }

    return await prisma.trustGraphNode.update({
      where: { id: node.id },
      data: {
        trustScore: Math.round(trustScore * 100) / 100,
        riskLevel: riskLevel || "UNKNOWN",
        nodeData: {
          ...(node.nodeData as any),
          trustScore,
          riskLevel,
          lastUpdated: new Date().toISOString(),
        },
      },
    });
  },

  async createEdge(fromEntityType: string, fromEntityId: string, toEntityType: string, toEntityId: string, edgeType: string, edgeData?: any, trustWeight: number = 0.5): Promise<TrustGraphEdge> {
    const fromNode = await this.createNode(fromEntityType, fromEntityId);
    const toNode = await this.createNode(toEntityType, toEntityId);

    const existingEdge = await prisma.trustGraphEdge.findFirst({
      where: {
        fromNodeId: fromNode.id,
        toNodeId: toNode.id,
        edgeType,
      },
    });

    if (existingEdge) {
      return await prisma.trustGraphEdge.update({
        where: { id: existingEdge.id },
        data: {
          trustWeight: Math.min(1, Math.max(0, trustWeight)),
          edgeData: edgeData || existingEdge.edgeData,
        },
      });
    }

    return await prisma.trustGraphEdge.create({
      data: {
        fromNodeId: fromNode.id,
        toNodeId: toNode.id,
        edgeType,
        edgeData: edgeData || {},
        trustWeight: Math.min(1, Math.max(0, trustWeight)),
        riskLevel: "UNKNOWN",
      },
    });
  },

  async getNode(entityType: string, entityId: string): Promise<TrustGraphNode | null> {
    return await prisma.trustGraphNode.findUnique({
      where: {
        entityType_entityId: {
          entityType,
          entityId,
        },
      },
      include: {
        outgoingEdges: {
          include: {
            toNode: true,
          },
        },
        incomingEdges: {
          include: {
            fromNode: true,
          },
        },
      },
    });
  },

  async getEdges(fromEntityType?: string, fromEntityId?: string, toEntityType?: string, toEntityId?: string, edgeType?: string): Promise<TrustGraphEdge[]> {
    const where: any = {};

    if (fromEntityType && fromEntityId) {
      const fromNode = await prisma.trustGraphNode.findUnique({
        where: {
          entityType_entityId: {
            entityType: fromEntityType,
            entityId: fromEntityId,
          },
        },
      });
      if (fromNode) where.fromNodeId = fromNode.id;
    }

    if (toEntityType && toEntityId) {
      const toNode = await prisma.trustGraphNode.findUnique({
        where: {
          entityType_entityId: {
            entityType: toEntityType,
            entityId: toEntityId,
          },
        },
      });
      if (toNode) where.toNodeId = toNode.id;
    }

    if (edgeType) where.edgeType = edgeType;

    return await prisma.trustGraphEdge.findMany({
      where,
      include: {
        fromNode: true,
        toNode: true,
      },
    });
  },

  async calculateTrustPropagation(startEntityType: string, startEntityId: string, maxDepth: number = 3): Promise<Map<string, number>> {
    const trustScores = new Map<string, number>();
    const visited = new Set<string>();
    const queue: { nodeId: string; depth: number; accumulatedTrust: number }[] = [];

    const startNode = await this.getNode(startEntityType, startEntityId);
    if (!startNode) return trustScores;

    queue.push({ nodeId: startNode.id, depth: 0, accumulatedTrust: startNode.trustScore });
    visited.add(startNode.id);
    trustScores.set(`${startNode.entityType}:${startEntityId}`, startNode.trustScore);

    while (queue.length > 0) {
      const { nodeId, depth, accumulatedTrust } = queue.shift()!;

      if (depth >= maxDepth) continue;

      const node = await prisma.trustGraphNode.findUnique({
        where: { id: nodeId },
        include: {
          outgoingEdges: {
            include: {
              toNode: true,
            },
          },
        },
      });

      if (!node) continue;

      for (const edge of node.outgoingEdges) {
        const toNode = edge.toNode;
        const edgeKey = `${toNode.entityType}:${toNode.entityId}`;

        if (!visited.has(toNode.id)) {
          visited.add(toNode.id);
          const propagatedTrust = accumulatedTrust * edge.trustWeight * 0.9; // Decay factor
          trustScores.set(edgeKey, propagatedTrust);
          queue.push({ nodeId: toNode.id, depth: depth + 1, accumulatedTrust: propagatedTrust });
        }
      }
    }

    return trustScores;
  },

  async detectTrustAnomalies(threshold: number = 30): Promise<TrustGraphNode[]> {
    const nodes = await prisma.trustGraphNode.findMany({
      where: {
        trustScore: {
          lt: threshold,
        },
      },
    });

    return nodes;
  },

  async getTrustPath(fromEntityType: string, fromEntityId: string, toEntityType: string, toEntityId: string): Promise<TrustGraphNode[]> {
    const fromNode = await this.getNode(fromEntityType, fromEntityId);
    const toNode = await this.getNode(toEntityType, toEntityId);

    if (!fromNode || !toNode) return [];

    const visited = new Set<string>();
    const queue: { nodeId: string; path: TrustGraphNode[] }[] = [];
    queue.push({ nodeId: fromNode.id, path: [fromNode] });
    visited.add(fromNode.id);

    while (queue.length > 0) {
      const { nodeId, path } = queue.shift()!;

      if (nodeId === toNode.id) {
        return path;
      }

      const node = await prisma.trustGraphNode.findUnique({
        where: { id: nodeId },
        include: {
          outgoingEdges: {
            include: {
              toNode: true,
            },
          },
        },
      });

      if (!node) continue;

      for (const edge of node.outgoingEdges) {
        if (!visited.has(edge.toNodeId)) {
          visited.add(edge.toNodeId);
          queue.push({ nodeId: edge.toNodeId, path: [...path, edge.toNode] });
        }
      }
    }

    return [];
  },

  async getGraphStatistics() {
    const nodeCount = await prisma.trustGraphNode.count();
    const edgeCount = await prisma.trustGraphEdge.count();
    const avgTrustScore = await prisma.trustGraphNode.aggregate({
      _avg: {
        trustScore: true,
      },
    });

    const nodesByType = await prisma.trustGraphNode.groupBy({
      by: ["entityType"],
      _count: {
        id: true,
      },
    });

    const edgesByType = await prisma.trustGraphEdge.groupBy({
      by: ["edgeType"],
      _count: {
        id: true,
      },
    });

    return {
      nodeCount,
      edgeCount,
      averageTrustScore: avgTrustScore._avg.trustScore || 0,
      nodesByType: nodesByType.reduce((acc, item) => {
        acc[item.entityType] = item._count.id;
        return acc;
      }, {} as Record<string, number>),
      edgesByType: edgesByType.reduce((acc, item) => {
        acc[item.edgeType] = item._count.id;
        return acc;
      }, {} as Record<string, number>),
    };
  },

  async deleteNode(entityType: string, entityId: string): Promise<boolean> {
    const node = await prisma.trustGraphNode.findUnique({
      where: {
        entityType_entityId: {
          entityType,
          entityId,
        },
      },
    });

    if (!node) return false;

    await prisma.trustGraphEdge.deleteMany({
      where: {
        OR: [
          { fromNodeId: node.id },
          { toNodeId: node.id },
        ],
      },
    });

    await prisma.trustGraphNode.delete({
      where: { id: node.id },
    });

    return true;
  },
};
