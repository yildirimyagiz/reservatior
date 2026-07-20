export interface AdsOSAPIContract {
  createCampaign(params: any): Promise<any>;
  getCampaign(campaignId: string): Promise<any>;
  updateCampaign(campaignId: string, params: any): Promise<any>;
  pauseCampaign(campaignId: string): Promise<any>;
  resumeCampaign(campaignId: string): Promise<any>;
  updateBudget(campaignId: string, budget: number): Promise<any>;
  createAd(params: any): Promise<any>;
}
