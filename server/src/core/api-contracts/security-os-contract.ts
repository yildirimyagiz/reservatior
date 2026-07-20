export interface SecurityOSAPIContract {
  createIncident(params: any): Promise<any>;
  getIncident(incidentId: string): Promise<any>;
  updateIncident(incidentId: string, params: any): Promise<any>;
  resolveIncident(incidentId: string): Promise<any>;
  runSecurityScan(params: any): Promise<any>;
  getSecurityReport(scanId: string): Promise<any>;
  grantAccess(resourceId: string, userId: string): Promise<any>;
  revokeAccess(resourceId: string, userId: string): Promise<any>;
}
