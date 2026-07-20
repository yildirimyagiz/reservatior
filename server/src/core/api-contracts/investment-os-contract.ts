export interface InvestmentOSAPIContract {
  createInvestment(params: any): Promise<any>;
  getInvestment(investmentId: string): Promise<any>;
  updateInvestment(investmentId: string, params: any): Promise<any>;
  deleteInvestment(investmentId: string): Promise<any>;
  approveInvestment(investmentId: string): Promise<any>;
  fundInvestment(investmentId: string, amount: number): Promise<any>;
  returnInvestment(investmentId: string): Promise<any>;
  distributeDividend(investmentId: string, amount: number): Promise<any>;
}
