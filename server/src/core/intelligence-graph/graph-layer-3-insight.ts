import { DataLayer } from './graph-layer-1-data';

export interface Insight {
  id: string;
  type: 'pattern' | 'anomaly';
  title: string;
  confidence: number;
}

export class InsightLayer {
  private dataLayer: DataLayer;
  private insights = new Map<string, Insight>();

  constructor(dataLayer: DataLayer) {
    this.dataLayer = dataLayer;
  }

  generateInsights(): Insight[] {
    const insights: Insight[] = [];
    insights.push({
      id: 'insight-1',
      type: 'pattern',
      title: 'High-performing agents detected',
      confidence: 0.92,
    });
    insights.forEach(i => this.insights.set(i.id, i));
    return insights;
  }

  getInsights(): Insight[] {
    return Array.from(this.insights.values());
  }
}
