import { DataLayer, GraphNode, GraphEdge } from './graph-layer-1-data';

export class RelationshipLayer {
  private dataLayer: DataLayer;
  
  constructor(dataLayer: DataLayer) {
    this.dataLayer = dataLayer;
  }

  discoverRelationships(): GraphEdge[] {
    const edges: GraphEdge[] = [];
    // Discover booking-agent relationships
    const bookings = this.dataLayer.getNodesByType('entity').filter(n => n.data.type === 'booking');
    const agents = this.dataLayer.getNodesByType('entity').filter(n => n.data.type === 'agent');
    
    bookings.forEach(booking => {
      const agent = agents.find(a => a.data.id === booking.data.agentId);
      if (agent) {
        edges.push({
          id: `${booking.id}-${agent.id}`,
          sourceId: booking.id,
          targetId: agent.id,
          type: 'managed_by',
          weight: 0.95,
          metadata: {}
        });
      }
    });
    return edges;
  }

  getRelationships(nodeId: string): GraphEdge[] {
    return this.dataLayer.getEdges(nodeId);
  }
}
