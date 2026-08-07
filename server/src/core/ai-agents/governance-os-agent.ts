export interface GovernanceOSAgent {
  analyzeCompliance(params: { policyId: string; data: any[] }): Promise<{ complianceScore: number; violations: string[] }>;
  recommendPolicy(params: { context: string; regulations: string[] }): Promise<{ policy: string; confidence: number }>;
}

export class MockGovernanceOSAgent implements GovernanceOSAgent {
  // NOTE (audit §6.A.3): this is a mock. It returns hardcoded scores with no
  // real analysis. The `simulated: true` marker prevents consumers from treating
  // these figures as real compliance health. Replace with a real engine before
  // exposing compliance dashboards as fact.
  async analyzeCompliance(params: any): Promise<any> {
    return { complianceScore: 0.92, violations: [], simulated: true };
  }
  async recommendPolicy(params: any): Promise<any> {
    return { policy: 'Recommended policy text', confidence: 0.88, simulated: true };
  }
}
