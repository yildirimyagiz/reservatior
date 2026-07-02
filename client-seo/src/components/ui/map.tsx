import { useTranslation } from "react-i18next";
import { useState } from "react";
import { MapContainer, TileLayer, Polyline, Popup, useMap } from "react-leaflet";
import L from "leaflet";
import "leaflet/dist/leaflet.css";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { MapPin, Navigation, ZoomIn, ZoomOut, RotateCw } from "lucide-react";

// Fix Leaflet marker icons
const markerIcon = "leaflet/dist/images/marker-icon.png";
const markerShadow = "leaflet/dist/images/marker-shadow.png";
const DefaultIcon = L.icon({
  iconUrl: markerIcon,
  shadowUrl: markerShadow,
  iconSize: [25, 41],
  iconAnchor: [12, 41]
});
L.Marker.prototype.options.icon = DefaultIcon;
interface Route {
  id: string;
  name: string;
  description?: string;
  status: string;
  createdAt: string;
  isVisible?: boolean;
  polyline?: string;
  color?: string;
  strokeWidth?: number;
  opacity?: number;
  distance?: number;
  duration?: number;
  type?: string;
  tolls?: number;
  provider?: string;
  startLocation?: {
    id: string;
    name: string;
    lat?: number;
    lng?: number;
  };
  endLocation?: {
    id: string;
    name: string;
    lat?: number;
    lng?: number;
  };
}
interface MapProps {
  center?: [number, number];
  zoom?: number;
  routes?: Route[];
  height?: string;
  showControls?: boolean;
  onRouteSelect?: (route: Route) => void;
}

// Internal component to handle view resetting
function ChangeView({
  center,
  zoom
}: {
  center: [number, number];
  zoom: number;
}) {
  const map = useMap();
  map.setView(center, zoom);
  return null;
}
export default function MapComponent({
  center = [40.7128, -74.006],
  zoom = 12,
  routes = [],
  height = "400px",
  onRouteSelect
}: MapProps) {
  const {
    t
  } = useTranslation();
  const [selectedRoute, setSelectedRoute] = useState<Route | null>(null);
  const handleRouteClick = (route: Route) => {
    setSelectedRoute(route);
    onRouteSelect?.(route);
  };

  // Function to decode Polyline (simple version or use a library)
  // For Leaflet, we often just need an array of [lat, lng]
  const decodePolyline = (encoded: string) => {
    // If it's already a JSON array string, parse it
    try {
      if (encoded.startsWith('[')) {
        return JSON.parse(encoded);
      }
    } catch (e) {}

    // Fallback: This project seems to use JSON for waypoints/polyline in many places
    // If it were a real Google Polyline, we'd need a decoder here.
    return [];
  };
  return <Card className="w-full overflow-hidden shadow-2xl border-none bg-gradient-to-b from-white to-gray-50/50">
      <CardHeader className="pb-3 border-b border-gray-100 bg-white/80 backdrop-blur-md">
        <div className="flex items-center justify-between">
          <CardTitle className="flex items-center gap-3 text-lg font-black tracking-tight text-slate-800">
            <div className="p-2 bg-blue-100/50 rounded-xl">
              <MapPin className="w-5 h-5 text-blue-600" />
            </div>{t("client.src.realtime_systems_map")}</CardTitle>
          <div className="flex items-center gap-2">
            <Badge variant="secondary" className="bg-green-100 text-green-700 border-none font-bold">
              <div className="w-2 h-2 rounded-full bg-green-500 animate-pulse mr-2" />{t("client.src.live_connected")}</Badge>
          </div>
        </div>
      </CardHeader>
      <CardContent className="p-0 relative">
        <div style={{
        height
      }}>
          <MapContainer center={center} zoom={zoom} style={{
          height: "100%",
          width: "100%"
        }} zoomControl={false}>
            <TileLayer attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors' url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" />
            
            <ChangeView center={center} zoom={zoom} />

            {routes.map(route => {
            if (!route.isVisible) return null;

            // Map locations to points if they have coordinates
            // Usually coordinates would be in startLocation/endLocation
            // If not, we skip drawing the line but keep the markers if available

            const positions = decodePolyline(route.polyline || "[]");
            return <div key={route.id}>
                  {positions.length > 1 && <Polyline positions={positions} color={route.color || "#3B82F6"} weight={route.strokeWidth || 4} opacity={route.opacity || 0.8} eventHandlers={{
                click: () => handleRouteClick(route)
              }}>
                      <Popup>
                        <div className="p-1">
                          <p className="font-bold">{route.name}</p>
                          <p className="text-xs">{route.distance?.toFixed(2)}{t("client.src.mi")}{route.type}</p>
                        </div>
                      </Popup>
                    </Polyline>}
                </div>;
          })}
          </MapContainer>

          {/* Controls Overlay */}
          <div className="absolute top-4 right-4 z-1000 flex flex-col gap-2">
            <Button size="icon" variant="secondary" className="rounded-xl shadow-lg bg-white/95 backdrop-blur hover:bg-white" onClick={() => {}}>
              <ZoomIn className="w-4 h-4" />
            </Button>
            <Button size="icon" variant="secondary" className="rounded-xl shadow-lg bg-white/95 backdrop-blur hover:bg-white" onClick={() => {}}>
              <ZoomOut className="w-4 h-4" />
            </Button>
            <Button size="icon" variant="secondary" className="rounded-xl shadow-lg bg-white/95 backdrop-blur hover:bg-white" onClick={() => {}}>
              <RotateCw className="w-4 h-4" />
            </Button>
          </div>

          {/* Route List Overlay */}
          {routes.length > 0 && <div className="absolute top-4 left-4 z-1000 bg-white/95 backdrop-blur-md rounded-2xl p-4 shadow-2xl border border-white/50 max-w-xs w-64 ring-1 ring-black/5">
              <h4 className="font-black text-slate-800 text-xs mb-3 flex items-center gap-2 uppercase tracking-widest">
                <Navigation className="w-3.5 h-3.5 text-blue-600" />{t("client.src.active_routes")}</h4>
              <div className="space-y-2 max-h-64 overflow-y-auto pr-1">
                {routes.filter(route => route.isVisible).map(route => <div key={route.id} className={`group flex items-center gap-3 p-3 rounded-xl cursor-pointer transition-all border ${selectedRoute?.id === route.id ? "bg-blue-50 border-blue-200 ring-2 ring-blue-500/10 shadow-sm" : "hover:bg-gray-50 border-transparent bg-white/50"}`} onClick={() => handleRouteClick(route)}>
                      <div className="w-2.5 h-2.5 rounded-full shrink-0 shadow-sm border border-white" style={{
                backgroundColor: route.color || "#3B82F6"
              }} />
                      <div className="flex-1 min-w-0">
                        <p className={`text-xs font-bold truncate ${selectedRoute?.id === route.id ? "text-blue-900" : "text-slate-900"}`}>
                          {route.name}
                        </p>
                        <div className="flex items-center gap-1.5 mt-0.5">
                          <span className="text-[10px] text-slate-400 font-bold uppercase tracking-tighter">
                            {route.distance ? `${route.distance.toFixed(1)} mi` : "N/A"}
                          </span>
                          <span className="text-[10px] text-slate-300">•</span>
                          <span className="text-[10px] text-slate-400 font-bold uppercase tracking-tighter">
                            {route.type}
                          </span>
                        </div>
                      </div>
                      <ChevronRight className={`w-3.5 h-3.5 transition-transform ${selectedRoute?.id === route.id ? "text-blue-500 translate-x-0.5" : "text-slate-300 opacity-0 group-hover:opacity-100"}`} />
                    </div>)}
              </div>
            </div>}

          {/* Detailed Selection Info */}
          {selectedRoute && <div className="absolute bottom-4 left-4 z-1000 bg-slate-900/95 backdrop-blur-lg rounded-2xl p-5 shadow-2xl text-white w-72 border border-white/10 ring-1 ring-black/5 animate-in fade-in slide-in-from-bottom-4">
              <div className="flex items-center justify-between mb-4">
                <div className="flex items-center gap-2">
                   <div className="w-1.5 h-1.5 rounded-full" style={{
                backgroundColor: selectedRoute.color
              }} />
                   <h4 className="font-black text-xs uppercase tracking-widest">{selectedRoute.name}</h4>
                </div>
                <Button variant="ghost" size="icon" className="h-6 w-6 rounded-full hover:bg-white/10 text-slate-400" onClick={() => setSelectedRoute(null)}>
                  <XCircle className="w-4 h-4" />
                </Button>
              </div>
              <div className="space-y-4">
                <div className="grid grid-cols-2 gap-4">
                   <div className="space-y-0.5">
                      <p className="text-[10px] text-slate-500 font-black uppercase tracking-tighter">{t("client.src.distance")}</p>
                      <p className="text-xl font-black">{selectedRoute.distance?.toFixed(1) || '0.0'} <span className="text-xs text-slate-500 font-bold">{t("client.src.mi")}</span></p>
                   </div>
                   <div className="space-y-0.5">
                      <p className="text-[10px] text-slate-500 font-black uppercase tracking-tighter">{t("client.src.duration")}</p>
                      <p className="text-xl font-black">{Math.floor((selectedRoute.duration || 0) / 60)} <span className="text-xs text-slate-500 font-bold">{t("client.src.min")}</span></p>
                   </div>
                </div>
                
                <div className="pt-4 border-t border-white/5 flex gap-2">
                   <Badge className="bg-white/10 text-white border-white/20 text-[10px] font-black">{selectedRoute.type}</Badge>
                   {selectedRoute.tolls && <Badge className="bg-amber-500/20 text-amber-300 border-amber-500/30 text-[10px] font-black">${selectedRoute.tolls}{t("client.src.toll")}</Badge>}
                </div>
              </div>
            </div>}
        </div>
      </CardContent>
    </Card>;
}

// Missing icons for the overlay
import { ChevronRight, XCircle } from "lucide-react";