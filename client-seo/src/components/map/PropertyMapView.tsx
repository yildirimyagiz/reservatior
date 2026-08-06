import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { MapPin, Home, Bed, Bath, Square, Eye, Settings, Zap } from "lucide-react";
import { useMapProvider } from "./MapProvider";
import GoogleMapView from "./GoogleMapView";
import YandexMapView from "./YandexMapView";
import PropertyMapViewLeaflet from "./PropertyMapViewLeaflet";
import { cn } from "@/lib/utils";
import { Property } from "@/lib/api/properties";
import { m, AnimatePresence } from "framer-motion";
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
    apiKey,
    setProvider
  } = useMapProvider();
  const handlePropertySelect = (property: Property) => {
    setSelectedProperty(property);
    onPropertySelect?.(property);
  };

  // Sort properties: Doped ones first
  const sortedProperties = [...properties].sort((a, b) => (b.isDoped ? 1 : 0) - (a.isDoped ? 1 : 0));
  const renderMapProvider = () => {
    const commonProps = {
      properties: sortedProperties,
      onPropertySelect: handlePropertySelect
    };
    switch (provider) {
      case "google":
        return <GoogleMapView {...commonProps} apiKey={apiKey.google || ""} />;
      case "yandex":
        return <YandexMapView {...commonProps} apiKey={apiKey.yandex || ""} />;
      case "leaflet":
      default:
        return <PropertyMapViewLeaflet {...commonProps as any} />;
    }
  };
  return <div className="h-full w-full relative bg-[#0a0b0d]">
      {/* Map Provider Selector Toggle */}
      <div className="absolute top-4 left-4 z-10">
        <Button variant="outline" size="sm" onClick={() => setShowSettings(!showSettings)} className="bg-slate-900/90 backdrop-blur-md border-white/10 text-white hover:bg-slate-800">
          <Settings className="w-4 h-4 mr-2" />{t("client.src.map_settings")}</Button>
      </div>

      {/* Map Provider Selector Panel */}
      {showSettings && <div className="absolute top-16 left-4 z-10 w-48">
          <Card className="bg-slate-900/95 backdrop-blur-md border-white/10 shadow-2xl overflow-hidden rounded-2xl">
            <div className="p-3 border-b border-white/5 bg-white/5">
              <h3 className="font-black text-[10px] uppercase tracking-widest text-slate-400">{t("client.src.map_provider")}</h3>
            </div>
            <div className="p-2 space-y-1">
              {[{
            id: "google",
            label: t("client.src.google_maps"),
            icon: "🌍"
          }, {
            id: "yandex",
            label: t("client.src.yandex_maps"),
            icon: "🧭"
          }, {
            id: "leaflet",
            label: t("client.src.openstreetmap"),
            icon: "🗺️"
          }].map(p => <Button key={p.id} variant={provider === p.id ? "default" : "ghost"} size="sm" onClick={() => setProvider(p.id as any)} className={cn("w-full justify-start rounded-xl text-xs font-bold gap-2", provider === p.id ? "bg-violet-600 text-white" : "text-slate-400 hover:text-white")}>
                  <span className="text-sm">{p.icon}</span> {p.label}
                </Button>)}
            </div>
          </Card>
        </div>}

      {/* Map Container */}
      <div className="h-full w-full">
        {renderMapProvider()}
      </div>

      {/* Property List Sidebar (Neural Hub Design) */}
      <div className="absolute top-4 right-4 w-[340px] max-h-[calc(100vh-120px)] overflow-y-auto z-10 scrollbar-hide">
        <Card className="bg-[#14151a]/90 backdrop-blur-xl border-white/10 shadow-2xl rounded-3xl overflow-hidden">
          <CardContent className="p-5 space-y-5">
            <div className="flex items-center justify-between pb-2 border-b border-white/5">
              <div className="flex items-center gap-2">
                <Home className="w-4 h-4 text-violet-400" />
                <h3 className="font-black text-white text-sm uppercase tracking-tighter">{t("client.src.listings")}{properties.length})</h3>
              </div>
              <Badge variant="outline" className="text-[9px] font-black tracking-widest bg-white/5 border-white/5 text-slate-400 uppercase">
                {provider}
              </Badge>
            </div>
            
            <div className="space-y-4">
              {sortedProperties.map(property => <m.div key={property.id} layout initial={{
              opacity: 0,
              y: 10
            }} animate={{
              opacity: 1,
              y: 0
            }} className={cn("p-4 border rounded-2xl cursor-pointer transition-all duration-300 group relative overflow-hidden", selectedProperty?.id === property.id ? "bg-violet-600/10 border-violet-500/50 shadow-xl shadow-violet-900/5" : "bg-white/5 border-white/5 hover:border-white/10", property.isDoped ? "border-amber-500/40 bg-amber-500/5" : "")} onClick={() => handlePropertySelect(property)}>
                  {property.isDoped && <div className="absolute top-0 right-0 p-1 pointer-events-none">
                      <div className="bg-amber-500 text-black text-[8px] font-black px-2 py-0.5 rounded-bl-lg flex items-center gap-1">
                        <Zap className="w-2.5 h-2.5 fill-black" />{t("client.src.doped")}</div>
                    </div>}

                  <div className="flex justify-between items-start mb-2">
                    <h4 className={cn("font-bold text-sm truncate flex-1 tracking-tight group-hover:translate-x-1 transition-transform", selectedProperty?.id === property.id ? "text-violet-400" : "text-white")}>{property.name}</h4>
                    <Badge variant="outline" className={cn("text-[9px] font-black border-none px-2 h-5", property.listingStatus === "AVAILABLE" ? "bg-blue-500/20 text-blue-400" : "bg-slate-800 text-slate-400")}>
                      {property.listingStatus}
                    </Badge>
                  </div>
                  
                  <div className="text-xs text-slate-500 mb-3 flex items-center gap-1 font-medium">
                    <MapPin className="w-3 h-3" />
                    {property.city}
                  </div>
                  
                  <div className="flex items-center gap-4 text-[10px] text-slate-400 font-bold mb-4">
                    <div className="flex items-center gap-1.5"><Bed className="w-3.5 h-3.5" />{property.bedrooms || 0}</div>
                    <div className="flex items-center gap-1.5"><Bath className="w-3.5 h-3.5" />{property.bathrooms || 0}</div>
                    <div className="flex items-center gap-1.5"><Square className="w-3.5 h-3.5" />{property.areaSqm || 0}{t("client.src.m")}</div>
                  </div>
                  
                  <div className="flex justify-between items-center pt-3 border-t border-white/5">
                    <div className={cn("font-black text-base", property.isDoped ? "text-amber-400" : "text-violet-400 shadow-violet-900/10")}>
                      ${parseInt(property.listingPrice?.toString() || "0").toLocaleString()}
                    </div>
                    <Button size="sm" variant="ghost" className="h-8 text-[10px] font-black uppercase tracking-widest text-slate-400 group-hover:text-white transition-colors">
                      <Eye className="w-3.5 h-3.5 mr-1" />{t("common.view")}</Button>
                  </div>
                </m.div>)}
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Map Active Stats */}
      <div className="absolute bottom-6 left-6 z-10">
        <Card className="bg-[#14151a]/90 backdrop-blur-xl border-white/10 rounded-2xl shadow-2xl p-4">
          <div className="flex items-center gap-8">
            <div className="flex items-center gap-3">
               <div className="w-10 h-10 rounded-xl bg-violet-600/10 flex items-center justify-center text-violet-400"><MapPin className="w-5 h-5" /></div>
               <div><p className="text-[8px] font-black text-slate-500 uppercase tracking-widest">{t("client.src.konum")}</p><p className="text-sm font-black text-white">{properties.length}</p></div>
            </div>
            <div className="w-px h-8 bg-white/5" />
            <div className="flex items-center gap-3">
               <div className="w-10 h-10 rounded-xl bg-amber-500/10 flex items-center justify-center text-amber-500"><Zap className="w-5 h-5" /></div>
               <div><p className="text-[8px] font-black text-slate-500 uppercase tracking-widest">{t("client.src.doped")}</p><p className="text-sm font-black text-white">{properties.filter(p => p.isDoped).length}</p></div>
            </div>
          </div>
        </Card>
      </div>
    </div>;
}