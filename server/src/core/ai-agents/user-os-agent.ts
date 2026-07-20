export interface UserOSAgent {
  analyzeUserBehavior(params: { userId: string; activityData: any[] }): Promise<{ riskScore: number; insights: string[] }>;
  recommendPersonalization(params: { userId: string; context: string }): Promise<{ recommendations: string[] }>;
}

export class MockUserOSAgent implements UserOSAgent {
  async analyzeUserBehavior(params: any): Promise<any> {
    return { riskScore: 0.15, insights: ['User shows consistent activity pattern'] };
  }
  async recommendPersonalization(params: any): Promise<any> {
    return { recommendations: ['Enable dark mode', 'Show personalized dashboard'] };
  }
}
