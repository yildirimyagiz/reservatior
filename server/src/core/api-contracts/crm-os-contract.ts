export interface CRMOSAPIContract {
  createLead(params: any): Promise<any>;
  getLead(leadId: string): Promise<any>;
  updateLead(leadId: string, params: any): Promise<any>;
  deleteLead(leadId: string): Promise<any>;
  qualifyLead(leadId: string): Promise<any>;
  convertLead(leadId: string): Promise<any>;
  createContact(params: any): Promise<any>;
  getContact(contactId: string): Promise<any>;
  updateContact(contactId: string, params: any): Promise<any>;
  deleteContact(contactId: string): Promise<any>;
  createOpportunity(params: any): Promise<any>;
  getOpportunity(opportunityId: string): Promise<any>;
  updateOpportunity(opportunityId: string, params: any): Promise<any>;
}
