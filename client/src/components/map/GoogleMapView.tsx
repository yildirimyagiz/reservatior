import { useTranslation } from "react-i18next";
import { useEffect, useRef, useState } from "react";
import { Property } from "@/lib/api/properties";
import { motion } from "framer-motion";
import { Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";
import { useNavigate } from "react-router-dom";
interface GoogleMapViewProps {
  properties: Property[];
  onPropertySelect?: (property: Property) => void;
  onPropertyClick?: (property: Property) => void;
  apiKey: string;
  height?: string;
  showControls?: boolean;
  provider?: string;
  center?: {
    lat: number;
    lng: number;
  };
  zoom?: number;
  selectedPropertyId?: string;
  showClusters?: boolean;
  enableHeatmap?: boolean;
}
declare global {
  interface Window {
    google: any;
    initGoogleMaps: () => void;
  }
}
export default function GoogleMapView({
  properties,
  onPropertySelect,
  onPropertyClick,
  apiKey,
  height = "400px",
  showControls = true,
  provider = "google",
  center,
  zoom = 10,
  selectedPropertyId,
  showClusters = false,
  enableHeatmap = false
}: GoogleMapViewProps) {
  const {
    t
  } = useTranslation();
  const mapRef = useRef<HTMLDivElement>(null);
  const [mapLoaded, setMapLoaded] = useState(false);
  const [selectedProperty, setSelectedProperty] = useState<Property | null>(null);
  const mapRefCurrent = useRef<any>(null);
  const markersRef = useRef<any[]>([]);
  const navigate = useNavigate();
  useEffect(() => {
    if (!apiKey) {
      console.error("Google Maps API key is required");
      return;
    }

    // Load Google Maps API
    const loadGoogleMaps = () => {
      if (window.google && window.google.maps) {
        console.log("Google Maps already loaded");
        setMapLoaded(true);
        return;
      }
      console.log("Loading Google Maps with API key:", apiKey ? "✓" : "✗");
      const script = document.createElement("script");
      script.async = true;
      script.defer = true;
      script.src = `https://maps.googleapis.com/maps/api/js?key=${apiKey}&libraries=places,marker&callback=initGoogleMaps`;
      window.initGoogleMaps = () => {
        console.log("Google Maps initialized successfully");
        setMapLoaded(true);
      };
      script.onerror = () => {
        console.error("Failed to load Google Maps script");
      };
      document.head.appendChild(script);
    };
    loadGoogleMaps();
  }, [apiKey]);
  useEffect(() => {
    if (!mapLoaded || !mapRef.current || !window.google || !window.google.maps) {
      console.log("Map not ready yet:", {
        mapLoaded,
        hasMapRef: !!mapRef.current,
        hasGoogle: !!window.google,
        hasGoogleMaps: !!window.google?.maps
      });
      return;
    }
    const google = window.google;
    const maps = google.maps;
    const mapOptions = {
      center: center || {
        lat: 40.7128,
        lng: -74.0060
      },
      // New York City (Default)
      zoom: zoom,
      mapId: "DEMO_MAP_ID", // Required for AdvancedMarkerElement
      mapTypeId: maps.MapTypeId.ROADMAP,
      disableDefaultUI: false,
      zoomControl: showControls,
      streetViewControl: false,
      fullscreenControl: false,
      mapTypeControl: false
    };
    let map = mapRefCurrent.current;
    if (!map) {
      console.log("Initializing Google Maps...");
      map = new maps.Map(mapRef.current, mapOptions);
      mapRefCurrent.current = map;
    } else {
      markersRef.current.forEach(marker => marker.setMap(null));
      markersRef.current = [];
      map.setOptions(mapOptions);
    }
    const bounds = new maps.LatLngBounds();
    properties.forEach(property => {
      if (property.lat && property.lng) {
        const position = {
          lat: property.lat,
          lng: property.lng
        };

        // Doping Check
        const isDoped = !!property.isDoped;
        const isSelected = selectedProperty?.id === property.id;
        const price = parseInt(property.listingPrice?.toString() || "0");
        const priceText = price >= 1000000 ? `$${(price / 1000000).toFixed(1)}M` : `$${(price / 1000).toFixed(0)}k`;

        // Custom Marker Content using DOM element (AdvancedMarkerElement requirement)
        const markerContent = document.createElement("div");
        markerContent.className = "flex flex-col items-center justify-center cursor-pointer";
        markerContent.innerHTML = `
          <div style="background-color: ${isSelected ? '#ea580c' : isDoped ? '#f59e0b' : '#7c3aed'}; 
                      border: ${isSelected ? '4px' : isDoped ? '3px' : '2px'} solid ${isSelected ? '#ffffff' : isDoped ? 'black' : 'white'}; 
                      border-radius: 50%; width: ${isSelected ? '34px' : isDoped ? '24px' : '18px'}; height: ${isSelected ? '34px' : isDoped ? '24px' : '18px'};
                      box-shadow: 0 4px 6px rgba(0,0,0,0.3);">
          </div>
          <div style="background: rgba(0,0,0,0.8); color: ${isSelected ? "white" : isDoped ? "#f59e0b" : "white"}; 
                      font-weight: 900; font-size: ${isSelected ? '12px' : '11px'}; padding: 2px 6px; 
                      border-radius: 4px; margin-top: 4px; white-space: nowrap;">
            ${priceText}
          </div>
        `;

        try {
          // AdvancedMarkerElement
          const AdvancedMarker = window.google.maps.marker?.AdvancedMarkerElement || window.google.maps.Marker;
          const marker = new AdvancedMarker({
            position,
            map,
            title: property.name,
            zIndex: isSelected ? 2000 : isDoped ? 1000 : 1,
            content: markerContent
          });
          
          marker.addListener("gmp-click", () => {
            setSelectedProperty(property);
            onPropertySelect?.(property);
          });
          
          markersRef.current.push(marker);
        } catch (e) {
          console.warn("Could not create marker (Map may be denied):", e);
        }
        bounds.extend(position);
      }
    });
    if (properties.length > 0) {
      map.fitBounds(bounds, {
        top: 60,
        right: 60,
        bottom: 60,
        left: 60
      });
    }
    return () => {
      markersRef.current.forEach(marker => marker.setMap(null));
      markersRef.current = [];
    };
  }, [mapLoaded, properties, onPropertySelect, selectedProperty?.id]);
  if (!apiKey) {
    return <div className="h-full w-full flex items-center justify-center bg-[#0a0b0d]">
        <div className="text-center p-8 border border-white/5 rounded-3xl bg-[#14151a]">
          <div className="text-rose-500 mb-4 text-2xl">⚠️</div>
          <p className="text-white font-black uppercase tracking-widest text-xs">{t("client.src.google_maps_api_key")}</p>
          <p className="text-slate-500 text-[10px] mt-2 font-medium">{t("client.src.please_check_your_env")}</p>
        </div>
      </div>;
  }
  return <div className="h-full w-full relative group">
      <div ref={mapRef} className="h-full w-full" />
      
      {!mapLoaded && <div className="absolute inset-0 bg-[#0a0b0d]/80 backdrop-blur-sm flex items-center justify-center z-50">
          <div className="text-center">
            <div className="w-12 h-12 border-2 border-violet-600/30 border-t-violet-500 rounded-full animate-spin mx-auto mb-4" />
            <p className="text-white text-[10px] font-black uppercase tracking-widest">{t("client.src.neural_maps_loading")}</p>
          </div>
        </div>}

      {/* Map Branding Overlay */}
      <div className="absolute top-4 left-1/2 -translate-x-1/2 pointer-events-none group-hover:opacity-100 opacity-60 transition-opacity">
         <div className="bg-slate-900/90 backdrop-blur-md border border-white/10 rounded-xl px-4 py-2 flex items-center gap-3">
            <div className="w-2 h-2 rounded-full bg-emerald-500 animate-pulse" />
            <span className="text-white text-[9px] font-black uppercase tracking-tighter italic">{t("client.src.google_maps_engine_active")}</span>
         </div>
      </div>

      {selectedProperty && <div className="absolute left-1/2 -translate-x-1/2 bottom-8 z-10 w-[340px]">
          <motion.div initial={{
        opacity: 0,
        x: -20
      }} animate={{
        opacity: 1,
        x: 0
      }}>
            <Card className="bg-[#14151a]/95 backdrop-blur-xl border-white/10 rounded-2xl p-4 shadow-3xl">
              <div className="flex justify-between items-start mb-3">
                <h4 className="font-black text-white text-sm">{selectedProperty.name}</h4>
                <Button size="icon" variant="ghost" className="h-6 w-6 text-slate-500" onClick={() => setSelectedProperty(null)}>✕</Button>
              </div>
              <div className="flex items-center gap-2 mb-4">
                <div className={cn("px-2 py-0.5 rounded text-[8px] font-black uppercase", selectedProperty.isDoped ? "bg-amber-500 text-black" : "bg-violet-600/20 text-violet-400")}>
                  {selectedProperty.isDoped ? "Doped" : selectedProperty.listingStatus}
                </div>
                <div className="text-white font-black text-sm ml-auto">
                   ${parseInt(selectedProperty.listingPrice?.toString() || "0").toLocaleString()}
                </div>
              </div>
              <Button size="sm" className="w-full bg-violet-600 hover:bg-violet-500 text-white font-black rounded-xl h-9 text-xs" onClick={() => navigate(`/properties/${selectedProperty.id}`)}>{t("client.src.view_details")}</Button>
            </Card>
          </motion.div>
        </div>}
    </div>;
}