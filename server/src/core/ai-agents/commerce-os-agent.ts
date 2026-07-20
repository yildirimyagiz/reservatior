export interface CommerceOSAgent {
  recommendProducts(params: { userId: string; browsingHistory: any[] }): Promise<{ products: string[]; confidence: number }>;
  predictDemand(params: { productId: string; historicalData: any[] }): Promise<{ demand: number; timeframe: string }>;
}

export class MockCommerceOSAgent implements CommerceOSAgent {
  async recommendProducts(params: any): Promise<any> {
    return { products: ['product-1', 'product-2', 'product-3'], confidence: 0.87 };
  }
  async predictDemand(params: any): Promise<any> {
    return { demand: 150, timeframe: '30 days' };
  }
}
