import { apiClient } from "./client";

export enum ExtraChargeType {
  CLEANING = "cleaning",
  DAMAGE = "damage",
  EARLY_CHECKIN = "early_checkin",
  LATE_CHECKOUT = "late_checkout",
  PARKING = "parking",
  PET = "pet",
  OTHER = "other",
}

export interface ExtraCharge {
  id: string;
  propertyId: string;
  reservationId?: string;
  name: string;
  description?: string;
  amount: number;
  chargeType: ExtraChargeType | string;
  isPaid: boolean;
  icon?: string;
  logo?: string;
  createdAt: string;
  updatedAt: string;
  reservation?: {
    id: string;
    propertyId: string;
  };
}

export const extraChargeApi = {
  getCharges: (params?: { reservationId?: string; orgId?: string; page?: number; limit?: number }) => 
    apiClient.get<{ data: ExtraCharge[]; pagination: any }>("/extra-charges", params),
    
  getCharge: (id: string) => 
    apiClient.get<{ data: ExtraCharge }>("/extra-charges/" + id),
    
  createCharge: (data: Partial<ExtraCharge> & { reservationId: string; name: string; amount: number }) => 
    apiClient.post<{ data: ExtraCharge }>("/extra-charges", data),
    
  updateCharge: (id: string, data: Partial<ExtraCharge>) => 
    apiClient.patch<{ data: ExtraCharge }>("/extra-charges/" + id, data),
    
  deleteCharge: (id: string) => 
    apiClient.delete("/extra-charges/" + id, { data: { tags: [] } } as any),
};
