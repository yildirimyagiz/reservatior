import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Attachment {
  id: string;
  name: string;
  originalName: string;
  mimeType: string;
  size: number;
  url: string;
  path: string;
  description?: string;
  isPublic: boolean;
  uploadedBy: string;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AttachmentsState {
  attachments: Attachment[];
  loading: boolean;
  error: string | null;
  selectedAttachment: Attachment | null;
  filters: {
    search: string;
    mimeType: string;
    isPublic: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setAttachments: (attachments: Attachment[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedAttachment: (attachment: Attachment | null) => void;
  setFilters: (filters: Partial<AttachmentsState["filters"]>) => void;
  setPagination: (pagination: Partial<AttachmentsState["pagination"]>) => void;
  addAttachment: (attachment: Attachment) => void;
  updateAttachment: (id: string, attachment: Partial<Attachment>) => void;
  removeAttachment: (id: string) => void;
  clearFilters: () => void;
}

export const useAttachmentsStore = create<AttachmentsState>()(
  devtools(
    (set) => ({
      attachments: [],
      loading: false,
      error: null,
      selectedAttachment: null,
      filters: {
        search: "",
        mimeType: "all",
        isPublic: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setAttachments: (attachments) => set({ attachments }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedAttachment: (selectedAttachment) =>
        set({ selectedAttachment }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addAttachment: (attachment) =>
        set((state) => ({ attachments: [...state.attachments, attachment] })),
      updateAttachment: (id, updatedAttachment) =>
        set((state) => ({
          attachments: state.attachments.map((a) =>
            a.id === id ? { ...a, ...updatedAttachment } : a
          ),
        })),
      removeAttachment: (id) =>
        set((state) => ({
          attachments: state.attachments.filter((a) => a.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            mimeType: "all",
            isPublic: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "attachments-store" }
  )
);
