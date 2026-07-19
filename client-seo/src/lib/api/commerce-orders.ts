import { apiClient } from "./client";

export interface CommerceOrderItem {
  id: string;
  orderId: string;
  productId?: string;
  bundleId?: string;
  productName: string;
  quantity: number;
  unitPrice: number;
  totalPrice: number;
}

export interface CommerceOrder {
  id: string;
  orgId: string;
  orderNumber: string;
  status: string;
  buyerType: string;
  buyerId?: string;
  buyerName: string;
  buyerEmail?: string;
  agentId?: string;
  bundleId?: string;
  propertyId?: string;
  subtotal: number;
  discount: number;
  tax: number;
  total: number;
  currency: string;
  paymentMethod?: string;
  paymentStatus: string;
  paidAt?: string;
  paymentRef?: string;
  deliveryAddress?: string;
  deliveryDate?: string;
  installationDate?: string;
  financingOption?: string;
  items: CommerceOrderItem[];
  metadata?: any;
  createdAt: string;
  updatedAt: string;
}

export interface CommerceOrderCreate {
  buyerName: string;
  buyerEmail?: string;
  buyerType: string;
  buyerId?: string;
  agentId?: string;
  bundleId?: string;
  propertyId?: string;
  subtotal: number;
  discount?: number;
  tax?: number;
  total: number;
  currency: string;
  paymentMethod?: string;
  items?: Array<{ productName: string; quantity: number; unitPrice: number }>;
}

export const commerceOrdersApi = {
  getAll: async (params?: any) => {
    return apiClient.get<CommerceOrder[]>("/commerce-orders", params);
  },
  getById: async (id: string) => {
    return apiClient.get<CommerceOrder>(`/commerce-orders/${id}`);
  },
  create: async (data: CommerceOrderCreate) => {
    return apiClient.post<CommerceOrder>("/commerce-orders", data);
  },
  updateStatus: async (id: string, status: string) => {
    return apiClient.patch<CommerceOrder>(`/commerce-orders/${id}/status`, { status });
  },
  delete: async (id: string) => {
    return apiClient.delete(`/commerce-orders/${id}`);
  },
};
