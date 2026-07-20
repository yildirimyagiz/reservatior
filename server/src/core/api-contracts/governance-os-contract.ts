export interface GovernanceOSAPIContract {
  createPolicy(params: any): Promise<any>;
  getPolicy(policyId: string): Promise<any>;
  updatePolicy(policyId: string, params: any): Promise<any>;
  deletePolicy(policyId: string): Promise<any>;
  runComplianceCheck(params: any): Promise<any>;
  getComplianceReport(checkId: string): Promise<any>;
  createAudit(params: any): Promise<any>;
  getAudit(auditId: string): Promise<any>;
  updateAudit(auditId: string, params: any): Promise<any>;
}
