export interface TrustOSAgent {
  calculateTrustScore(params: { entityId: string; entityType: string; activityData: any[] }): Promise<{ score: number; factors: string[] }>;
  detectAnomalies(params: { entityId: string; behaviorData: any[] }): Promise<{ anomalies: string[]; riskLevel: string }>;
}

export class MockTrustOSAgent implements TrustOSAgent {
  async calculateTrustScore(params: any): Promise<any> {
    return { score: 0.85, factors: ['Consistent activity', 'Positive reviews', 'Verified identity'] };
  }
  async detectAnomalies(params: any): Promise<any> {
    return { anomalies: [], riskLevel: 'low' };
  }
}
