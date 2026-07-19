import { apiClient } from "./client";

export interface Product {
  id: string;
  orgId: string;
  name: string;
  description?: string;
  category: string;
  sku?: string;
  price: number;
  currency: string;
  images?: any;
  attributes?: any;
  supplierId?: string;
  supplier?: any;
  status: string;
  isActive: boolean;
  weight?: number;
  dimensions?: any;
  commissionRate?: number;
  wholesalePrice?: number;
  retailPrice?: number;
  metadata?: any;
  createdAt: string;
  updatedAt: string;
}

export interface ProductCreate {
  name: string;
  category: string;
  price: number;
  description?: string;
  supplierId?: string;
  sku?: string;
  commissionRate?: number;
}

export const productsApi = {
  getAll: async (params?: any) => {
    return apiClient.get<Product[]>("/products", params);
  },
  getById: async (id: string) => {
    return apiClient.get<Product>(`/products/${id}`);
  },
  getByCategory: async (category: string) => {
    return apiClient.get<Product[]>(`/products/category/${category}`);
  },
  create: async (data: ProductCreate) => {
    return apiClient.post<Product>("/products", data);
  },
  update: async (id: string, data: Partial<ProductCreate>) => {
    return apiClient.patch<Product>(`/products/${id}`, data);
  },
  delete: async (id: string) => {
    return apiClient.delete(`/products/${id}`);
  },
};
