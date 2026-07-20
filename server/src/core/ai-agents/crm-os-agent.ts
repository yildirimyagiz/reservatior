export interface CRMOSAgent {
  scoreLead(params: { leadId: string; leadData: any }): Promise<{ score: number; likelihood: string }>;
  recommendNextAction(params: { leadId: string; currentStage: string }): Promise<{ action: string; priority: string }>;
}

export class MockCRMOSAgent implements CRMOSAgent {
  async scoreLead(params: any): Promise<any> {
    return { score: 0.78, likelihood: 'high' };
  }
  async recommendNextAction(params: any): Promise<any> {
    return { action: 'Schedule follow-up call', priority: 'high' };
  }
}
