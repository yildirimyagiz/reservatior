// Utility to create multiple stores at once
export function createBatchStores(storeNames: string[]) {
  const stores: Record<string, any> = {};
  
  storeNames.forEach(name => {
    stores[name] = {
      items: [],
      loading: false,
      error: null,
      selectedItem: null,
      filters: {},
      pagination: { page: 1, limit: 10, total: 0 },
      setItems: () => {},
      setLoading: () => {},
      setError: () => {},
      setSelectedItem: () => {}
    };
  });
  
  return stores;
}
