import { apiClient } from "./client";

export interface IdentityDocument {
  id: string;
  reservationId: string;
  documentType: "PASSPORT" | "NATIONAL_ID" | "DRIVERS_LICENSE" | "OTHER";
  documentNumber: string;
  issuerCountry: string;
  status: "VERIFIED" | "PENDING" | "REJECTED";
  verifiedAt?: string;
  expiryDate?: string;
  documentUrl?: string; // Reference to Attachment
}

export interface StayOccupant {
  id: string;
  reservationId: string;
  name: string;
  idNumber?: string;
  idType?: "PASSPORT" | "NATIONAL_ID";
  nationality?: string;
  birthDate?: string;
  gender?: string;
  isMinor: boolean;
  relationToGuest?: "FRIEND" | "SPOUSE" | "CHILD" | "OTHER";
}

export interface PoliceReport {
  id: string;
  orgId: string;
  propertyId: string;
  reservationId: string;
  reportType: "KBS" | "GIYKIMBIL" | "CSI" | "POLICE";
  status: "PENDING" | "REPORTED" | "FAILED" | "ACCEPTED";
  submittedAt?: string;
  referenceNumber?: string;
  responseContent?: any;
  errorMessage?: string;
}

export const identityComplianceApi = {
  // Identity & Verification
  getIdentityDocuments: (reservationId: string) => 
    apiClient.get<IdentityDocument[]>("/identity/documents", { reservationId }),
  verifyDocument: (reservationId: string, data: any) =>
    apiClient.post<IdentityDocument>(`/identity/reservations/${reservationId}/verify`, data),

  // Stay Occupants
  getOccupants: (reservationId: string) => 
    apiClient.get<StayOccupant[]>("/identity/occupants", { reservationId }),
  updateOccupant: (id: string, data: Partial<StayOccupant>) =>
    apiClient.patch<StayOccupant>(`/identity/occupants/${id}`, data),

  // Police Reporting (KBS/GIYKIMBIL)
  getPoliceReports: (params?: { propertyId?: string; status?: string }) => 
    apiClient.get<PoliceReport[]>("/identity/police-reports", params),
  submitPoliceReport: (reservationId: string) => 
    apiClient.post<PoliceReport>(`/identity/reservations/${reservationId}/report-to-police`),
  getReportHistory: (propertyId: string) => 
    apiClient.get<PoliceReport[]>(`/identity/properties/${propertyId}/report-history`),

  // ID Extraction (AI-powered)
  extractIdData: (documentAttachmentId: string) => 
    apiClient.post(`/identity/extract-id`, { attachmentId: documentAttachmentId }),
};
