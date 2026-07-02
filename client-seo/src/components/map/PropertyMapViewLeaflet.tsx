import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { MapPin, Home, Bed, Bath, Square, Eye, Settings } from "lucide-react";
import { Property } from "@/pages-spa/client/property/Properties";
import { useMapProvider } from "./MapProvider";
import GoogleMapView from "./GoogleMapView";
import YandexMapView from "./YandexMapView";
import PropertyMapViewLeaflet from "./PropertyMapViewLeaflet";
interface PropertyMapViewProps {
  properties: Property[];
  onPropertySelect?: (property: Property) => void;
}
export default function PropertyMapView({
  properties,
  onPropertySelect
}: PropertyMapViewProps) {
  const {
    t
  } = useTranslation();
  const [selectedProperty, setSelectedProperty] = useState<Property | null>(null);
  const [showSettings, setShowSettings] = useState(false);
  const {
    provider,
    apiKey
  } = useMapProvider();
  const handlePropertySelect = (property: Property) => {
    setSelectedProperty(property);
    onPropertySelect?.(property);
  };
  const renderMapProvider = () => {
    const commonProps = {
      properties,
      onPropertySelect: handlePropertySelect
    };
    switch (provider) {
      case "google":
        return <GoogleMapView {...commonProps} apiKey={apiKey.google || ""} />;
      case "yandex":
        return <YandexMapView {...commonProps} apiKey={apiKey.yandex || ""} />;
      case "leaflet":
      default:
        return <PropertyMapViewLeaflet {...commonProps} />;
    }
  };
  return <div className="h-full w-full relative">
      {/* Map Provider Selector Toggle */}
      <div className="absolute top-4 left-4 z-10">
        <Button variant="outline" size="sm" onClick={() => setShowSettings(!showSettings)} className="bg-white/90 backdrop-blur-sm">
          <Settings className="w-4 h-4 mr-2" />{t("client.src.map_settings")}</Button>
      </div>

      {/* Map Provider Selector Panel */}
      {showSettings && <div className="absolute top-16 left-4 z-10">
          <div className="bg-white rounded-lg shadow-xl border">
            <div className="p-3 border-b">
              <h3 className="font-semibold text-sm">{t("client.src.map_provider")}</h3>
            </div>
            <div className="p-3 space-y-2">
              <div className="grid grid-cols-1 gap-2">
                <Button variant={provider === "google" ? "default" : "outline"} size="sm" onClick={() => {/* Provider change handled by MapProviderSelector */}} className="justify-start">{t("client.src.google_maps")}</Button>
                <Button variant={provider === "yandex" ? "default" : "outline"} size="sm" onClick={() => {/* Provider change handled by MapProviderSelector */}} className="justify-start">{t("client.src.yandex_maps")}</Button>
                <Button variant={provider === "leaflet" ? "default" : "outline"} size="sm" onClick={() => {/* Provider change handled by MapProviderSelector */}} className="justify-start">{t("client.src.openstreetmap")}</Button>
              </div>
            </div>
          </div>
        </div>}

      {/* Map Container */}
      <div className="h-full w-full">
        {renderMapProvider()}
      </div>

      {/* Property List Sidebar */}
      <div className="absolute top-4 right-4 w-80 max-h-[calc(100vh-120px)] overflow-y-auto z-10">
        <Card className="bg-white/95 backdrop-blur-sm">
          <CardContent className="p-4">
            <div className="flex items-center gap-2 mb-4">
              <Home className="w-5 h-5" />
              <h3 className="font-semibold">{t("client.src.properties")}{properties.length})</h3>
              <Badge variant="outline" className="text-xs">
                {provider === "google" ? "🌍" : provider === "yandex" ? "🧭" : "🗺️"} {provider}
              </Badge>
            </div>
            
            <div className="space-y-3">
              {properties.map(property => <div key={property.id} className={`p-3 border rounded-lg cursor-pointer transition-all hover:shadow-md ${selectedProperty?.id === property.id ? 'border-blue-500 bg-blue-50' : 'border-gray-200 hover:border-gray-300'}`} onClick={() => handlePropertySelect(property)}>
                  <div className="flex justify-between items-start mb-2">
                    <h4 className="font-medium text-sm truncate flex-1">{property.name}</h4>
                    <Badge variant="outline" className="text-xs">
                      {property.listingStatus}
                    </Badge>
                  </div>
                  
                  <div className="text-xs text-gray-600 mb-2">
                    <MapPin className="w-3 h-3 inline mr-1" />
                    {property.addressLine1}, {property.city}
                  </div>
                  
                  <div className="flex items-center gap-3 text-xs text-gray-500 mb-2">
                    <div className="flex items-center gap-1">
                      <Bed className="w-3 h-3" />
                      {property.bedrooms || 0}
                    </div>
                    <div className="flex items-center gap-1">
                      <Bath className="w-3 h-3" />
                      {property.bathrooms || 0}
                    </div>
                    <div className="flex items-center gap-1">
                      <Square className="w-3 h-3" />
                      {property.areaSqm || 0}{t("client.src.m")}</div>
                  </div>
                  
                  <div className="flex justify-between items-center">
                    <div className="font-bold text-green-600 text-sm">
                      ${(property.listingPrice || 0).toLocaleString()}
                    </div>
                    <Button size="sm" variant="outline" className="text-xs">
                      <Eye className="w-3 h-3 mr-1" />{t("client.src.view")}</Button>
                  </div>
                </div>)}
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Map Info */}
      <div className="absolute bottom-4 left-4 z-10">
        <Card className="bg-white/95 backdrop-blur-sm">
          <CardContent className="p-3">
            <div className="text-xs text-gray-600">
              <div>📍 {properties.length}{t("client.src.properties")}</div>
              <div>🗺️ {provider === "google" ? "Google Maps" : provider === "yandex" ? "Yandex Maps" : "OpenStreetMap"}</div>
              {provider === "google" && !apiKey.google && <div className="text-red-500">{t("client.src.api_key_required")}</div>}
              {provider === "yandex" && !apiKey.yandex && <div className="text-red-500">{t("client.src.api_key_required")}</div>}
            </div>
          </CardContent>
        </Card>
      </div>
    </div>;
}