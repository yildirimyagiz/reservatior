import { apiClient } from "./client";

export interface ExchangeRate {
  id: string;
  orgId: string;
  baseCurrency: string;
  quoteCurrency: string;
  rate: number;
  asOfDate: string;
  source?: string;
  isActive?: boolean;
  createdAt: string;
}

export const exchangeRatesApi = {
  getAll: (params?: { fromCurrency?: string; toCurrency?: string; fromDate?: string; toDate?: string; page?: number; limit?: number }) =>
    apiClient.get("/exchange-rates", params),
  getById: (id: string) => apiClient.get(`/exchange-rates/${id}`),
  create: (data: Partial<ExchangeRate>) => apiClient.post("/exchange-rates", data),
  update: (id: string, data: Partial<ExchangeRate>) => apiClient.patch(`/exchange-rates/${id}`, data),
  delete: (id: string) => apiClient.delete(`/exchange-rates/${id}`),
  getByPair: (baseCurrency: string, quoteCurrency: string, params?: any) =>
    apiClient.get(`/exchange-rates/pair/${baseCurrency}/${quoteCurrency}`, params),
  getLatest: (baseCurrency: string, quoteCurrency: string) =>
    apiClient.get(`/exchange-rates/latest/${baseCurrency}/${quoteCurrency}`),
  getActive: (params?: { baseCurrency?: string; quoteCurrency?: string; page?: number; limit?: number }) =>
    apiClient.get("/exchange-rates/active", params),
  convert: (params: { baseCurrency: string; quoteCurrency: string; amount: number; date?: string }) =>
    apiClient.get("/exchange-rates/convert", params),
  getSummary: (params?: { fromDate?: string; toDate?: string }) =>
    apiClient.get("/exchange-rates/summary", params),
};
