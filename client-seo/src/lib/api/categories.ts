import { apiClient } from "./client";

export interface CategoryTranslation {
  languageCode: string;
  name: string;
  description?: string;
}

export interface Category {
  id: string;
  slug: string;
  parentId?: string;
  icon?: string;
  imageUrl?: string;
  translations: CategoryTranslation[];
  children?: Category[];
}

export const categoriesApi = {
  getCategories: async (lang: string = "en") => {
    const { data } = await apiClient.get<{ data: Category[] }>(`/categories?lang=${lang}`);
    return data;
  },

  createCategory: async (categoryData: Partial<Category>) => {
    const { data } = await apiClient.post<{ data: Category }>("/categories", categoryData);
    return data;
  },

  assignToListing: async (listingId: string, categoryId: string) => {
    const { data } = await apiClient.patch<{ data: any }>("/categories/assign", {
      listingId,
      categoryId
    });
    return data;
  }
};
