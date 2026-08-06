import { useTranslation } from "react-i18next";
import { useEffect, useRef, useState } from "react";
import { Property } from "@/lib/api/properties";
interface YandexMapViewProps {
  properties: Property[];
  onPropertySelect?: (property: Property) => void;
  apiKey: string;
}
declare global {
  interface Window {
    ymaps: any;
    initYandexMaps: () => void;
  }
}
export default function YandexMapView({
  properties,
  onPropertySelect,
  apiKey
}: YandexMapViewProps) {
  const {
    t
  } = useTranslation();
  const mapRef = useRef<HTMLDivElement>(null);
  const [mapLoaded, setMapLoaded] = useState(false);
  const [selectedProperty, setSelectedProperty] = useState<Property | null>(null);
  const mapRefCurrent = useRef<any>(null);
  const markersRef = useRef<any[]>([]);
  useEffect(() => {
    if (!apiKey) {
      console.error("Yandex Maps API key is required");
      return;
    }

    // Load Yandex Maps API
    const loadYandexMaps = () => {
      if (window.ymaps) {
        window.ymaps.ready(() => {
          setMapLoaded(true);
        });
        return;
      }
      const script = document.createElement("script");
      script.async = true;
      script.defer = true;
      script.src = `https://api-maps.yandex.ru/2.1/?apikey=${apiKey}&lang=en_US&load=package.full&onload=initYandexMaps`;
      window.initYandexMaps = () => {
        if (window.ymaps) {
          window.ymaps.ready(() => {
            setMapLoaded(true);
          });
        }
      };
      document.head.appendChild(script);
    };
    loadYandexMaps();
  }, [apiKey]);
  useEffect(() => {
    if (!mapLoaded || !mapRef.current || !window.ymaps) return;
    const ymaps = window.ymaps;

    // Clear existing map
    if (mapRefCurrent.current) {
      // Clear markers
      markersRef.current.forEach(marker => marker.setParent(null));
      markersRef.current = [];
      mapRefCurrent.current.destroy();
      mapRefCurrent.current = null;
    }

    // Create map
    const map = new ymaps.Map(mapRef.current, {
      center: [40.7648, -73.9656],
      // NYC based [lat, lng]
      zoom: 13,
      controls: ['zoomControl', 'typeSelector', 'fullscreenControl']
    }, {
      suppressMapOpenBlock: true
    });
    mapRefCurrent.current = map;

    // Create markers
    const bounds = map.getBounds();
    let hasValidBounds = false;
    properties.forEach(property => {
      if (property.lat && property.lng) {
        const position = [property.lat, property.lng]; // Yandex uses [lat, lng]

        const price = parseInt(property.listingPrice?.toString() || "0");
        const priceText = price >= 1000000 ? `$${(price / 1000000).toFixed(1)}M` : `$${(price / 1000).toFixed(0)}k`;

        // Balloon content
        const balloonContent = `
          <div style="padding: 12px; max-width: 250px; font-family: Arial, sans-serif;">
            <div style="font-weight: bold; margin-bottom: 8px; font-size: 14px;">${property.name}</div>
            <div style="font-size: 12px; color: #666; margin-bottom: 8px;">${property.addressLine1}, ${property.city}</div>
            <div style="display: flex; gap: 12px; font-size: 11px; color: #888; margin-bottom: 8px;">
              <span>🛏 ${property.bedrooms || 0}</span>
              <span>🚿 ${property.bathrooms || 0}</span>
              <span>📐 ${property.areaSqm || 0}m²</span>
            </div>
            <div style="font-weight: bold; color: #2563eb; font-size: 16px; margin-bottom: 4px;">$${price.toLocaleString()}</div>
            <div style="font-size: 11px; color: #666; padding: 4px 8px; background: #f3f4f6; border-radius: 4px; display: inline-block;">
              ${property.listingStatus}
            </div>
          </div>
        `;
        const placemark = new ymaps.Placemark(position, {
          balloonContent: balloonContent,
          hintContent: property.name
        }, {
          preset: 'islands#blueDotIcon',
          iconLayout: 'default#imageWithContent',
          iconImageHref: 'data:image/svg+xml;base64,' + btoa(`
            <svg width="40" height="40" viewBox="0 0 40 40" xmlns="http://www.w3.org/2000/svg">
              <defs>
                <linearGradient id="gradient" x1="0%" y1="0%" x2="100%" y2="100%">
                  <stop offset="0%" style="stop-color:#3b82f6;stop-opacity:1" />
                  <stop offset="100%" style="stop-color:#2563eb;stop-opacity:1" />
                </linearGradient>
              </defs>
              <circle cx="20" cy="20" r="18" fill="url(#gradient)" stroke="white" stroke-width="2"/>
              <text x="20" y="25" text-anchor="middle" fill="white" font-family="Arial" font-size="10" font-weight="bold">${priceText}</text>
            </svg>
          `),
          iconImageSize: [40, 40],
          iconImageOffset: [-20, -40]
        });
        placemark.events.add('click', () => {
          setSelectedProperty(property);
          onPropertySelect?.(property);
        });
        map.geoObjects.add(placemark);
        markersRef.current.push(placemark);

        // Update bounds
        if (!hasValidBounds) {
          bounds[0] = position;
          bounds[1] = position;
          hasValidBounds = true;
        } else {
          bounds[0][0] = Math.min(bounds[0][0], position[0]);
          bounds[0][1] = Math.min(bounds[0][1], position[1]);
          bounds[1][0] = Math.max(bounds[1][0], position[0]);
          bounds[1][1] = Math.max(bounds[1][1], position[1]);
        }
      }
    });

    // Zoom to fit all markers
    if (hasValidBounds && properties.length > 0) {
      map.setBounds(bounds, {
        checkZoomRange: true,
        zoomMargin: 50
      });
    }
    return () => {
      // Cleanup
      markersRef.current.forEach(marker => marker.setParent(null));
      markersRef.current = [];
      if (mapRefCurrent.current) {
        mapRefCurrent.current.destroy();
        mapRefCurrent.current = null;
      }
    };
  }, [mapLoaded, properties, onPropertySelect]);
  if (!apiKey) {
    return <div className="h-full w-full flex items-center justify-center bg-gray-100">
        <div className="text-center">
          <div className="text-red-500 mb-2">{t("client.src.yandex_maps_api_key")}</div>
          <p className="text-sm text-gray-600">{t("client.src.please_configure_your_yandex")}</p>
        </div>
      </div>;
  }
  return <div className="h-full w-full relative">
      {/* Yandex Maps Container */}
      <div ref={mapRef} className="h-full w-full" />
      
      {/* Loading State */}
      {!mapLoaded && <div className="absolute inset-0 bg-white/80 flex items-center justify-center">
          <div className="text-center">
            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-yellow-600 mx-auto mb-2"></div>
            <p className="text-sm text-gray-600">{t("client.src.loading_yandex_maps")}</p>
          </div>
        </div>}

      {/* Map Controls Overlay */}
      <div className="absolute top-4 left-4 bg-white rounded-lg shadow-lg p-2">
        <div className="text-xs text-gray-600">
          <div className="font-semibold">{t("client.src.yandex_maps")}</div>
          <div>{properties.length}{t("common.properties")}</div>
        </div>
      </div>

      {/* Selected Property Info */}
      {selectedProperty && <div className="absolute bottom-4 left-4 bg-white rounded-lg shadow-lg p-3 max-w-xs">
          <div className="text-sm">
            <div className="font-semibold mb-1">{selectedProperty.name}</div>
            <div className="text-gray-600">{selectedProperty.addressLine1}</div>
            <div className="text-blue-600 font-bold">
              ${parseInt(selectedProperty.listingPrice?.toString() || "0").toLocaleString()}
            </div>
          </div>
        </div>}
    </div>;
}