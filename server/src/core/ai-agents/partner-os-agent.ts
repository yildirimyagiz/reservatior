export interface PartnerOSAgent {
  evaluatePartner(params: { partnerId: string; performanceData: any[] }): Promise<{ score: number; recommendations: string[] }>;
  matchPartner(params: { requirements: any[]; partnerProfiles: any[] }): Promise<{ matches: any[]; confidence: number }>;
}

export class MockPartnerOSAgent implements PartnerOSAgent {
  async evaluatePartner(params: any): Promise<any> {
    return { score: 0.87, recommendations: ['Increase collaboration', 'Improve response time'] };
  }
  async matchPartner(params: any): Promise<any> {
    return { matches: [{ partnerId: 'partner-1', fit: 0.92 }], confidence: 0.89 };
  }
}
