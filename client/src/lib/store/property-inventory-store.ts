import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface PropertyInventory {
  id: string;
  propertyId: string;
  name: string;
  category: string;
  description?: string;
  quantity: number;
  unit: string;
  condition: "excellent" | "good" | "fair" | "poor";
  location?: string;
  purchaseDate?: Date;
  purchasePrice?: number;
  currentValue?: number;
  currency: string;
  photos: string[];
  notes?: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface PropertyInventoryState {
  inventory: PropertyInventory[];
  loading: boolean;
  error: string | null;
  selectedInventory: PropertyInventory | null;
  filters: {
    search: string;
    propertyId: string;
    category: string;
    condition: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setInventory: (inventory: PropertyInventory[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedInventory: (inventory: PropertyInventory | null) => void;
  setFilters: (filters: Partial<PropertyInventoryState["filters"]>) => void;
  setPagination: (
    pagination: Partial<PropertyInventoryState["pagination"]>
  ) => void;
  addInventory: (inventory: PropertyInventory) => void;
  updateInventory: (id: string, inventory: Partial<PropertyInventory>) => void;
  removeInventory: (id: string) => void;
  clearFilters: () => void;
}

export const usePropertyInventoryStore = create<PropertyInventoryState>()(
  devtools(
    (set) => ({
      inventory: [],
      loading: false,
      error: null,
      selectedInventory: null,
      filters: {
        search: "",
        propertyId: "all",
        category: "all",
        condition: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setInventory: (inventory) => set({ inventory }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedInventory: (selectedInventory) => set({ selectedInventory }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addInventory: (inventory) =>
        set((state) => ({ inventory: [...state.inventory, inventory] })),
      updateInventory: (id, updatedInventory) =>
        set((state) => ({
          inventory: state.inventory.map((i) =>
            i.id === id ? { ...i, ...updatedInventory } : i
          ),
        })),
      removeInventory: (id) =>
        set((state) => ({
          inventory: state.inventory.filter((i) => i.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            propertyId: "all",
            category: "all",
            condition: "all",
          },
        }),
    }),
    { name: "property-inventory-store" }
  )
);
