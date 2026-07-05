 "use client"
 import { useEffect } from "react";
import { useTranslation } from "react-i18next";
import { useRegionsStore } from "@/lib/store/regions-store";
import { apiClient } from '@/lib/api/client';

/**
 * GeoInit Component
 * 
 * Silently detects the user's IP region from the backend if no region is currently selected.
 * Updates the global region state and i18n language accordingly.
 */
export function GeoInit() {
  const { selectedRegion, loadRegions, setSelectedRegion } = useRegionsStore();
  const { i18n } = useTranslation();

  useEffect(() => {
    async function initializeGeo() {
      if (selectedRegion) {
        // We already have a selected region. Do not forcefully override user's language preference.
        return;
      }

      try {
        // 1. Fetch available regions into the store
        await loadRegions();

        // 2. Detect IP location
        const geoRes = await apiClient.get<any>("/config/geo");
        const detectedCountry = geoRes.country || "US";

        // 3. Set the region based on IP
        setSelectedRegion(detectedCountry);
        
        // 4. Update language based on region only if not explicitly set by user
        const savedLang = localStorage.getItem("reservatior_lang") || localStorage.getItem("i18nextLng");
        if (!savedLang) {
          if (detectedCountry === "TR") i18n.changeLanguage("tr");
          else if (detectedCountry === "US") i18n.changeLanguage("en");
        }
        
        console.log(`🌍 GeoInit: Automatically selected region [${detectedCountry}] based on IP.`);
      } catch (error) {
        console.error("GeoInit: Failed to initialize regional data", error);
      }
    }

    initializeGeo();
  }, [selectedRegion, loadRegions, setSelectedRegion, i18n]);

  return null; // Silent component
}
