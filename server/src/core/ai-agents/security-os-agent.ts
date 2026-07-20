export interface SecurityOSAgent {
  detectThreat(params: { systemData: any[]; patterns: any[] }): Promise<{ threats: string[]; riskLevel: string }>;
  recommendAction(params: { incidentId: string; threatType: string }): Promise<{ action: string; priority: string }>;
}

export class MockSecurityOSAgent implements SecurityOSAgent {
  async detectThreat(params: any): Promise<any> {
    return { threats: [], riskLevel: 'low' };
  }
  async recommendAction(params: any): Promise<any> {
    return { action: 'Block IP address', priority: 'high' };
  }
}
