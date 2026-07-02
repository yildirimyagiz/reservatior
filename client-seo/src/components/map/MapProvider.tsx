 "use client"
 import { createContext, useContext, ReactNode, useState } from "react";

export type MapProviderType = "google" | "yandex" | "leaflet";

interface MapProviderContextType {
  provider: MapProviderType;
  setProvider: (provider: MapProviderType) => void;
  apiKey: {
    google?: string;
    yandex?: string;
  };
  setApiKey: (provider: MapProviderType, key: string) => void;
}

const MapProviderContext = createContext<MapProviderContextType | undefined>(undefined);

export function MapProviderWrapper({ children }: { children: ReactNode }) {
  const [provider, setProvider] = useState<MapProviderType>("google");
  
  // Google Maps API key - a real key is required
  const [apiKey, setApiKey] = useState({
    google: process.env.NEXT_PUBLIC_GOOGLE_MAPS_API_KEY || "AIzaSyDummyKeyForTesting",
    yandex: process.env.NEXT_PUBLIC_YANDEX_MAPS_API_KEY || "dummy-yandex-key",
  });

  const handleSetApiKey = (provider: MapProviderType, key: string) => {
    setApiKey(prev => ({ ...prev, [provider]: key }));
  };

  return (
    <MapProviderContext.Provider value={{
      provider,
      setProvider,
      apiKey,
      setApiKey: handleSetApiKey,
    }}>
      {children}
    </MapProviderContext.Provider>
  );
}

export function useMapProvider() {
  const context = useContext(MapProviderContext);
  if (context === undefined) {
    throw new Error("useMapProvider must be used within a MapProviderWrapper");
  }
  return context;
}
