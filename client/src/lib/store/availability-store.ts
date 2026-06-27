import { create } from 'zustand';
import { devtools } from 'zustand/middleware';
import { availabilityApi, Availability, AvailabilityFilters, AvailabilityAnalytics } from '@/lib/api/availability-enhanced';

interface AvailabilityStore {
  // State
  availabilities: Availability[];
  selectedAvailability: Availability | null;
  loading: boolean;
  error: string | null;
  filters: AvailabilityFilters;
  analytics: AvailabilityAnalytics | null;
  
  // Actions
  fetchAvailabilities: () => Promise<void>;
  fetchAvailabilitiesByProperty: (propertyId: string) => Promise<void>;
  fetchAvailabilitiesByDateRange: (filters: AvailabilityFilters) => Promise<void>;
  createAvailability: (data: Partial<Availability>) => Promise<void>;
  updateAvailability: (id: string, data: Partial<Availability>) => Promise<void>;
  deleteAvailability: (id: string) => Promise<void>;
  fetchAnalytics: (filters: AvailabilityFilters) => Promise<void>;
  bulkUpdate: (request: any) => Promise<void>;
  setSelectedAvailability: (availability: Availability | null) => void;
  setFilters: (filters: Partial<AvailabilityFilters>) => void;
  clearFilters: () => void;
  reset: () => void;
}

const initialState: AvailabilityFilters = {
  propertyId: undefined,
  startDate: undefined,
  endDate: undefined,
  isBlocked: undefined,
  isBooked: undefined,
  minPrice: undefined,
  maxPrice: undefined,
  minUnits: undefined,
  maxUnits: undefined
};

export const useAvailabilityStore = create<AvailabilityStore>()(
  devtools(
    (set, get) => ({
      // Initial state
      availabilities: [],
      selectedAvailability: null,
      loading: false,
      error: null,
      filters: initialState,
      analytics: null,

      // Fetch all availabilities
      fetchAvailabilities: async () => {
        set({ loading: true, error: null });
        
        try {
          const response = await availabilityApi.getAll();
          set({ 
            availabilities: response.data,
            loading: false 
          });
        } catch (error) {
          set({ 
            error: error instanceof Error ? error.message : 'Failed to fetch availabilities',
            loading: false 
          });
        }
      },

      // Fetch availabilities by property
      fetchAvailabilitiesByProperty: async (propertyId: string) => {
        set({ loading: true, error: null });
        
        try {
          const response = await availabilityApi.getByProperty(propertyId);
          set({ 
            availabilities: response.data,
            loading: false 
          });
        } catch (error) {
          set({ 
            error: error instanceof Error ? error.message : 'Failed to fetch property availabilities',
            loading: false 
          });
        }
      },

      // Fetch availabilities by date range
      fetchAvailabilitiesByDateRange: async (filters: AvailabilityFilters) => {
        set({ loading: true, error: null });
        
        try {
          const response = await availabilityApi.getByDateRange(filters);
          set({ 
            availabilities: response.data,
            loading: false 
          });
        } catch (error) {
          set({ 
            error: error instanceof Error ? error.message : 'Failed to fetch date range availabilities',
            loading: false 
          });
        }
      },

      // Create availability
      createAvailability: async (data: Partial<Availability>) => {
        set({ loading: true, error: null });
        
        try {
          const response = await availabilityApi.create(data);
          set(state => ({ 
            availabilities: [...state.availabilities, response.data],
            loading: false 
          }));
        } catch (error) {
          set({ 
            error: error instanceof Error ? error.message : 'Failed to create availability',
            loading: false 
          });
        }
      },

      // Update availability
      updateAvailability: async (id: string, data: Partial<Availability>) => {
        set({ loading: true, error: null });
        
        try {
          const response = await availabilityApi.update(id, data);
          set(state => ({
            availabilities: state.availabilities.map(avail => 
              avail.id === id ? response.data : avail
            ),
            selectedAvailability: state.selectedAvailability?.id === id ? response.data : state.selectedAvailability,
            loading: false
          }));
        } catch (error) {
          set({ 
            error: error instanceof Error ? error.message : 'Failed to update availability',
            loading: false 
          });
        }
      },

      // Delete availability
      deleteAvailability: async (id: string) => {
        set({ loading: true, error: null });
        
        try {
          await availabilityApi.delete(id);
          set(state => ({
            availabilities: state.availabilities.filter(avail => avail.id !== id),
            selectedAvailability: state.selectedAvailability?.id === id ? null : state.selectedAvailability,
            loading: false
          }));
        } catch (error) {
          set({ 
            error: error instanceof Error ? error.message : 'Failed to delete availability',
            loading: false 
          });
        }
      },

      // Fetch analytics
      fetchAnalytics: async (filters: AvailabilityFilters) => {
        set({ loading: true, error: null });
        
        try {
          const response = await availabilityApi.getAnalytics(filters);
          set({ 
            analytics: response.data,
            loading: false 
          });
        } catch (error) {
          set({ 
            error: error instanceof Error ? error.message : 'Failed to fetch analytics',
            loading: false 
          });
        }
      },

      // Bulk update
      bulkUpdate: async (request: any) => {
        set({ loading: true, error: null });
        
        try {
          await availabilityApi.bulkUpdate(request);
          
          // Refresh the availabilities after bulk update
          await get().fetchAvailabilitiesByDateRange(get().filters);
          
          set({ loading: false });
        } catch (error) {
          set({ 
            error: error instanceof Error ? error.message : 'Failed to bulk update availabilities',
            loading: false 
          });
        }
      },

      // Set selected availability
      setSelectedAvailability: (availability: Availability | null) => {
        set({ selectedAvailability: availability });
      },

      // Set filters
      setFilters: (filters: Partial<AvailabilityFilters>) => {
        set(state => ({ 
          filters: { ...state.filters, ...filters }
        }));
      },

      // Clear filters
      clearFilters: () => {
        set({ filters: initialState });
      },

      // Reset store
      reset: () => {
        set({
          availabilities: [],
          selectedAvailability: null,
          loading: false,
          error: null,
          filters: initialState,
          analytics: null
        });
      }
    }),
    {
      name: 'availability-store'
    }
  )
);

// Selectors for common use cases
export const useAvailabilityData = () => {
  const { availabilities, loading, error } = useAvailabilityStore();
  return { availabilities, loading, error };
};

export const useAvailabilityFilters = () => {
  const { filters, setFilters, clearFilters } = useAvailabilityStore();
  return { filters, setFilters, clearFilters };
};

export const useAvailabilityActions = () => {
  const {
    fetchAvailabilities,
    fetchAvailabilitiesByProperty,
    fetchAvailabilitiesByDateRange,
    createAvailability,
    updateAvailability,
    deleteAvailability,
    fetchAnalytics,
    bulkUpdate
  } = useAvailabilityStore();
  
  return {
    fetchAvailabilities,
    fetchAvailabilitiesByProperty,
    fetchAvailabilitiesByDateRange,
    createAvailability,
    updateAvailability,
    deleteAvailability,
    fetchAnalytics,
    bulkUpdate
  };
};

export const useAvailabilityAnalytics = () => {
  const { analytics, loading, error, fetchAnalytics } = useAvailabilityStore();
  return { analytics, loading, error, fetchAnalytics };
};

export const useSelectedAvailability = () => {
  const { selectedAvailability, setSelectedAvailability } = useAvailabilityStore();
  return { selectedAvailability, setSelectedAvailability };
};
