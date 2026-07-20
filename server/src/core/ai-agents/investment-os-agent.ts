export interface InvestmentOSAgent {
  analyzeRisk(params: { investmentId: string; marketData: any[] }): Promise<{ riskScore: number; riskLevel: string }>;
  predictReturns(params: { investmentId: string; historicalData: any[] }): Promise<{ expectedReturn: number; timeframe: string }>;
}

export class MockInvestmentOSAgent implements InvestmentOSAgent {
  async analyzeRisk(params: any): Promise<any> {
    return { riskScore: 0.35, riskLevel: 'medium' };
  }
  async predictReturns(params: any): Promise<any> {
    return { expectedReturn: 0.12, timeframe: '12 months' };
  }
}
