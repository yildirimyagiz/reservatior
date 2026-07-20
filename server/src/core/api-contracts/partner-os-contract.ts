export interface PartnerOSAPIContract {
  createPartner(params: any): Promise<any>;
  getPartner(partnerId: string): Promise<any>;
  updatePartner(partnerId: string, params: any): Promise<any>;
  deletePartner(partnerId: string): Promise<any>;
  createRelationship(params: any): Promise<any>;
  getRelationship(relationshipId: string): Promise<any>;
  updateRelationship(relationshipId: string, params: any): Promise<any>;
  signAgreement(partnerId: string, agreementId: string): Promise<any>;
  reviewPerformance(partnerId: string, review: any): Promise<any>;
}
