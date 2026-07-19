import { create } from "zustand";
import { devtools } from "zustand/middleware";
import type { IncomeReadyCertificate } from "@/lib/api/certificates";

export interface CertificatesState {
  certificates: IncomeReadyCertificate[];
  loading: boolean;
  error: string | null;
  selectedCertificate: IncomeReadyCertificate | null;
  filters: {
    search: string;
    tier: string;
    status: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setCertificates: (certificates: IncomeReadyCertificate[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedCertificate: (certificate: IncomeReadyCertificate | null) => void;
  setFilters: (filters: Partial<CertificatesState["filters"]>) => void;
  setPagination: (pagination: Partial<CertificatesState["pagination"]>) => void;
  addCertificate: (certificate: IncomeReadyCertificate) => void;
  updateCertificate: (id: string, certificate: Partial<IncomeReadyCertificate>) => void;
  removeCertificate: (id: string) => void;
  clearFilters: () => void;
}

export const useCertificatesStore = create<CertificatesState>()(
  devtools(
    (set) => ({
      certificates: [],
      loading: false,
      error: null,
      selectedCertificate: null,
      filters: {
        search: "",
        tier: "all",
        status: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setCertificates: (certificates) => set({ certificates }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedCertificate: (selectedCertificate) => set({ selectedCertificate }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addCertificate: (certificate) =>
        set((state) => ({ certificates: [...state.certificates, certificate] })),
      updateCertificate: (id, updatedCertificate) =>
        set((state) => ({
          certificates: state.certificates.map((c) =>
            c.id === id ? { ...c, ...updatedCertificate } : c
          ),
        })),
      removeCertificate: (id) =>
        set((state) => ({
          certificates: state.certificates.filter((c) => c.id !== id),
        })),
      clearFilters: () =>
        set({ filters: { search: "", tier: "all", status: "all" } }),
    }),
    { name: "certificates-store" }
  )
);
