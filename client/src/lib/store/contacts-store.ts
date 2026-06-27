import { create } from "zustand";
import { devtools } from "zustand/middleware";
import { Contact } from "../api/contacts";

export interface ContactsState {
  contacts: Contact[];
  loading: boolean;
  error: string | null;
  selectedContact: Contact | null;
  filters: {
    search: string;
    contactType: string;
    status: string;
    city: string;
    tags: string[];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setContacts: (contacts: Contact[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedContact: (contact: Contact | null) => void;
  setFilters: (filters: Partial<ContactsState["filters"]>) => void;
  setPagination: (pagination: Partial<ContactsState["pagination"]>) => void;
  addContact: (contact: Contact) => void;
  updateContact: (id: string, contact: Partial<Contact>) => void;
  removeContact: (id: string) => void;
  clearFilters: () => void;
}

export const useContactsStore = create<ContactsState>()(
  devtools(
    (set) => ({
      contacts: [],
      loading: false,
      error: null,
      selectedContact: null,
      filters: {
        search: "",
        contactType: "all",
        status: "all",
        city: "all",
        tags: [],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setContacts: (contacts) => set({ contacts }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedContact: (selectedContact) => set({ selectedContact }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addContact: (contact) =>
        set((state) => ({ contacts: [...state.contacts, contact] })),
      updateContact: (id, updatedContact) =>
        set((state) => ({
          contacts: state.contacts.map((c) =>
            c.id === id ? { ...c, ...updatedContact } : c
          ),
        })),
      removeContact: (id) =>
        set((state) => ({
          contacts: state.contacts.filter((c) => c.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            contactType: "all",
            status: "all",
            city: "all",
            tags: [],
          },
        }),
    }),
    { name: "contacts-store" }
  )
);
