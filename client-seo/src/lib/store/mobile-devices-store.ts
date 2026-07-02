import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface MobileDevice {
  id: string;
  userId: string;
  deviceId: string;
  deviceType: string;
  platform: string;
  version: string;
  pushToken?: string;
  isActive: boolean;
  lastActive: Date;
  ipAddress?: string;
  location?: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface MobileDevicesState {
  devices: MobileDevice[];
  loading: boolean;
  error: string | null;
  selectedDevice: MobileDevice | null;
  filters: {
    search: string;
    userId: string;
    deviceType: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setDevices: (devices: MobileDevice[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedDevice: (device: MobileDevice | null) => void;
  setFilters: (filters: Partial<MobileDevicesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<MobileDevicesState["pagination"]>
  ) => void;
  addDevice: (device: MobileDevice) => void;
  updateDevice: (id: string, device: Partial<MobileDevice>) => void;
  removeDevice: (id: string) => void;
  clearFilters: () => void;
}

export const useMobileDevicesStore = create<MobileDevicesState>()(
  devtools(
    (set) => ({
      devices: [],
      loading: false,
      error: null,
      selectedDevice: null,
      filters: {
        search: "",
        userId: "all",
        deviceType: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setDevices: (devices) => set({ devices }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedDevice: (selectedDevice) => set({ selectedDevice }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addDevice: (device) =>
        set((state) => ({ devices: [...state.devices, device] })),
      updateDevice: (id, updatedDevice) =>
        set((state) => ({
          devices: state.devices.map((d) =>
            d.id === id ? { ...d, ...updatedDevice } : d
          ),
        })),
      removeDevice: (id) =>
        set((state) => ({
          devices: state.devices.filter((d) => d.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            userId: "all",
            deviceType: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "mobile-devices-store" }
  )
);
