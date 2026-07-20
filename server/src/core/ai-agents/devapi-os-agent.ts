export interface DevAPIOSSAgent {
  optimizeAPI(params: { endpointId: string; usageData: any[] }): Promise<{ optimization: string; expectedImprovement: number }>;
  detectAnomalies(params: { apiKeyId: string; usagePattern: any[] }): Promise<{ anomalies: string[]; riskLevel: string }>;
}

export class MockDevAPIOSSAgent implements DevAPIOSSAgent {
  async optimizeAPI(params: any): Promise<any> {
    return { optimization: 'Add caching layer', expectedImprovement: 0.35 };
  }
  async detectAnomalies(params: any): Promise<any> {
    return { anomalies: [], riskLevel: 'low' };
  }
}
