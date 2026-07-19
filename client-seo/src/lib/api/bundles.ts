import { apiClient } from "./client";

export interface BundleItem {
  id: string;
  bundleId: string;
  productId: string;
  product?: any;
  quantity: number;
  unitPrice: number;
  totalPrice: number;
}

export interface ProductBundle {
  id: string;
  orgId: string;
  name: string;
  description?: string;
  bundleType: string;
  totalPrice: number;
  currency: string;
  propertyId?: string;
  propertyType?: string;
  bedrooms?: number;
  originalPrice?: number;
  discountPct?: number;
  isActive: boolean;
  images?: any;
  items: BundleItem[];
  metadata?: any;
  createdAt: string;
  updatedAt: string;
}

export interface BundleCreate {
  name: string;
  description?: string;
  bundleType: string;
  totalPrice: number;
  currency: string;
  propertyId?: string;
  bedrooms?: number;
  items?: Array<{ productId: string; quantity: number; unitPrice: number }>;
}

export const bundlesApi = {
  getAll: async (params?: any) => {
    return apiClient.get<ProductBundle[]>("/bundles", params);
  },
  getById: async (id: string) => {
    return apiClient.get<ProductBundle>(`/bundles/${id}`);
  },
  create: async (data: BundleCreate) => {
    return apiClient.post<ProductBundle>("/bundles", data);
  },
  update: async (id: string, data: Partial<BundleCreate>) => {
    return apiClient.patch<ProductBundle>(`/bundles/${id}`, data);
  },
  delete: async (id: string) => {
    return apiClient.delete(`/bundles/${id}`);
  },
};
