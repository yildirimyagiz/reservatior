import { InsightLayer } from './graph-layer-3-insight';

export class ActionLayer {
  private insightLayer: InsightLayer;
  private actions = new Map();

  constructor(insightLayer: InsightLayer) {
    this.insightLayer = insightLayer;
  }

  generateActions() {
    const insights = this.insightLayer.getInsights();
    return insights.map(i => ({ id: `action-${i.id}`, type: 'recommendation', status: 'pending' }));
  }

  getActions() {
    return Array.from(this.actions.values());
  }
}
