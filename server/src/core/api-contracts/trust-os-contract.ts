export interface TrustOSAPIContract {
  calculateTrustScore(entityId: string, entityType: string): Promise<any>;
  requestVerification(entityId: string, entityType: string): Promise<any>;
  approveVerification(verificationId: string): Promise<any>;
  rejectVerification(verificationId: string, reason: string): Promise<any>;
  submitReview(params: any): Promise<any>;
}
