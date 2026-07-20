export interface AIOSAPIContract {
  createModel(params: any): Promise<any>;
  getModel(modelId: string): Promise<any>;
  trainModel(modelId: string, params: any): Promise<any>;
  makePrediction(modelId: string, input: any): Promise<any>;
  generateInsight(params: any): Promise<any>;
}
