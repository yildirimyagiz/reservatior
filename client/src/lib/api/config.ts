import { apiClient } from "./client";

export interface Region {
  code: string;
  name: string;
  currency: string;
  language: string;
  timezone: string;
}

export const configApi = {
  getRegions: async () => {
    const { data } = await apiClient.get<any>("/config/regions");
    return data;
  },
  getRegion: async (countryCode: string) => {
    const { data } = await apiClient.get<any>(`/config/regions/${countryCode}`);
    return data;
  },
};
