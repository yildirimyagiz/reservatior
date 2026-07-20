export interface DevAPIOSSAPIContract {
  createAPIKey(params: any): Promise<any>;
  getAPIKey(apiKeyId: string): Promise<any>;
  updateAPIKey(apiKeyId: string, params: any): Promise<any>;
  revokeAPIKey(apiKeyId: string): Promise<any>;
  getAPIUsage(apiKeyId: string): Promise<any>;
  setRateLimit(apiKeyId: string, limit: number): Promise<any>;
  getAPIDocumentation(): Promise<any>;
}
