import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface SignatureSigner {
  id: string;
  requestId: string;
  email: string;
  name: string;
  order: number;
  status: "pending" | "signed" | "declined";
  signedAt?: Date;
  ipAddress?: string;
  userAgent?: string;
  signature?: {
    type: string;
    data: string;
    timestamp: Date;
  };
  metadata: Record<string, any>;
  createdAt: Date;
  updatedAt: Date;
}

export interface SignatureSignersState {
  signers: SignatureSigner[];
  loading: boolean;
  error: string | null;
  selectedSigner: SignatureSigner | null;
  filters: {
    search: string;
    requestId: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setSigners: (signers: SignatureSigner[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedSigner: (signer: SignatureSigner | null) => void;
  setFilters: (filters: Partial<SignatureSignersState["filters"]>) => void;
  setPagination: (
    pagination: Partial<SignatureSignersState["pagination"]>
  ) => void;
  addSigner: (signer: SignatureSigner) => void;
  updateSigner: (id: string, signer: Partial<SignatureSigner>) => void;
  removeSigner: (id: string) => void;
  clearFilters: () => void;
}

export const useSignatureSignersStore = create<SignatureSignersState>()(
  devtools(
    (set) => ({
      signers: [],
      loading: false,
      error: null,
      selectedSigner: null,
      filters: {
        search: "",
        requestId: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setSigners: (signers) => set({ signers }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedSigner: (selectedSigner) => set({ selectedSigner }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addSigner: (signer) =>
        set((state) => ({ signers: [...state.signers, signer] })),
      updateSigner: (id, updatedSigner) =>
        set((state) => ({
          signers: state.signers.map((s) =>
            s.id === id ? { ...s, ...updatedSigner } : s
          ),
        })),
      removeSigner: (id) =>
        set((state) => ({
          signers: state.signers.filter((s) => s.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            requestId: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "signature-signers-store" }
  )
);
