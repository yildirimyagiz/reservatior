/**
 * Intelligence Graph Layer 1: Data Layer
 * Foundation layer that ingests and normalizes data from all OS modules
 */

export interface GraphNode {
  id: string;
  type: 'entity' | 'event' | 'metric' | 'relationship';
  sourceOS: string;
  data: any;
  timestamp: string;
  metadata: Record<string, any>;
}

export interface GraphEdge {
  id: string;
  sourceId: string;
  targetId: string;
  type: string;
  weight: number;
  metadata: Record<string, any>;
}

export class DataLayer {
  private nodes: Map<string, GraphNode> = new Map();
  private edges: Map<string, GraphEdge> = new Map();

  /**
   * Ingest data from OS modules
   */
  ingestNode(node: GraphNode): void {
    this.nodes.set(node.id, node);
  }

  /**
   * Create relationship between nodes
   */
  createEdge(edge: GraphEdge): void {
    this.edges.set(edge.id, edge);
  }

  /**
   * Get node by ID
   */
  getNode(id: string): GraphNode | undefined {
    return this.nodes.get(id);
  }

  /**
   * Get edges for a node
   */
  getEdges(nodeId: string): GraphEdge[] {
    return Array.from(this.edges.values()).filter(
      edge => edge.sourceId === nodeId || edge.targetId === nodeId
    );
  }

  /**
   * Get all nodes from a specific OS
   */
  getNodesByOS(sourceOS: string): GraphNode[] {
    return Array.from(this.nodes.values()).filter(node => node.sourceOS === sourceOS);
  }

  /**
   * Query nodes by type
   */
  getNodesByType(type: GraphNode['type']): GraphNode[] {
    return Array.from(this.nodes.values()).filter(node => node.type === type);
  }

  /**
   * Get graph statistics
   */
  getStats() {
    return {
      totalNodes: this.nodes.size,
      totalEdges: this.edges.size,
      nodesByType: {
        entity: this.getNodesByType('entity').length,
        event: this.getNodesByType('event').length,
        metric: this.getNodesByType('metric').length,
        relationship: this.getNodesByType('relationship').length,
      },
      nodesByOS: {
        BookingOS: this.getNodesByOS('BookingOS').length,
        FinanceOS: this.getNodesByOS('FinanceOS').length,
        ListingOS: this.getNodesByOS('ListingOS').length,
        IdentityOS: this.getNodesByOS('IdentityOS').length,
        AgentOS: this.getNodesByOS('AgentOS').length,
        DocumentOS: this.getNodesByOS('DocumentOS').length,
        AnalyticsOS: this.getNodesByOS('AnalyticsOS').length,
        NotificationOS: this.getNodesByOS('NotificationOS').length,
        LocalizationOS: this.getNodesByOS('LocalizationOS').length,
      },
    };
  }

  /**
   * Clear all data
   */
  clear(): void {
    this.nodes.clear();
    this.edges.clear();
  }
}
