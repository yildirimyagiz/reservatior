import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface MessageParticipantType {
  id: string;
  name: string;
  description?: string;
  canSendMessage: boolean;
  canReceiveMessage: boolean;
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface MessageParticipantTypesState {
  participantTypes: MessageParticipantType[];
  loading: boolean;
  error: string | null;
  selectedParticipantType: MessageParticipantType | null;
  filters: {
    search: string;
    canSendMessage: string;
    canReceiveMessage: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setParticipantTypes: (participantTypes: MessageParticipantType[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedParticipantType: (
    participantType: MessageParticipantType | null
  ) => void;
  setFilters: (
    filters: Partial<MessageParticipantTypesState["filters"]>
  ) => void;
  setPagination: (
    pagination: Partial<MessageParticipantTypesState["pagination"]>
  ) => void;
  addParticipantType: (participantType: MessageParticipantType) => void;
  updateParticipantType: (
    id: string,
    participantType: Partial<MessageParticipantType>
  ) => void;
  removeParticipantType: (id: string) => void;
  clearFilters: () => void;
}

export const useMessageParticipantTypesStore =
  create<MessageParticipantTypesState>()(
    devtools(
      (set) => ({
        participantTypes: [],
        loading: false,
        error: null,
        selectedParticipantType: null,
        filters: {
          search: "",
          canSendMessage: "all",
          canReceiveMessage: "all",
          isActive: "all",
        },
        pagination: {
          page: 1,
          limit: 20,
          total: 0,
        },
        setParticipantTypes: (participantTypes) => set({ participantTypes }),
        setLoading: (loading) => set({ loading }),
        setError: (error) => set({ error }),
        setSelectedParticipantType: (selectedParticipantType) =>
          set({ selectedParticipantType }),
        setFilters: (filters) =>
          set((state) => ({ filters: { ...state.filters, ...filters } })),
        setPagination: (pagination) =>
          set((state) => ({
            pagination: { ...state.pagination, ...pagination },
          })),
        addParticipantType: (participantType) =>
          set((state) => ({
            participantTypes: [...state.participantTypes, participantType],
          })),
        updateParticipantType: (id, updatedParticipantType) =>
          set((state) => ({
            participantTypes: state.participantTypes.map((pt) =>
              pt.id === id ? { ...pt, ...updatedParticipantType } : pt
            ),
          })),
        removeParticipantType: (id) =>
          set((state) => ({
            participantTypes: state.participantTypes.filter(
              (pt) => pt.id !== id
            ),
          })),
        clearFilters: () =>
          set({
            filters: {
              search: "",
              canSendMessage: "all",
              canReceiveMessage: "all",
              isActive: "all",
            },
          }),
      }),
      { name: "message-participant-types-store" }
    )
  );
