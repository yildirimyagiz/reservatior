import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "@/pages/client/layout/PageShell";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { MoreHorizontal, Search, Filter, MapPin, Route as RouteIcon, Eye, Edit, Trash2, Navigation, Layers, Globe, Zap, Activity, Shield, Maximize, Compass, ArrowUpRight, Database, Cpu } from "lucide-react";
import { Input } from "@/components/ui/input";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api";
import { motion, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
import { useQuery } from "@tanstack/react-query";
import { mapLayersApi } from "@/lib/api/map-layers";
import { routesApi } from "@/lib/api/routes";

// Types
type MapLayerType = "BASE" | "PROPERTY" | "LISTING" | "ROUTE" | "HEATMAP" | "CLUSTER" | "BOUNDARY" | "TRAFFIC";
type LocationType = "PROPERTY" | "LISTING" | "OFFICE" | "LANDMARK" | "SCHOOL" | "HOSPITAL" | "PARK" | "SHOPPING" | "RESTAURANT" | "TRANSPORT";
interface MapLayer {
  id: string;
  name: string;
  type: MapLayerType;
  description?: string;
  isActive: boolean;
  createdAt: string;
  zIndex: number;
  opacity: number;
}
interface RouteInfo {
  id: string;
  name: string;
  description?: string;
  distance?: number;
  estimatedTime?: number;
  isActive: boolean;
  createdAt: string;
}
interface Location {
  id: string;
  name: string;
  address: string;
  latitude: number;
  longitude: number;
  type: LocationType;
  isStandardized: boolean;
  createdAt: string;
}
export default function MapServices() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [activeTab, setActiveTab] = useState<"layers" | "routes" | "locations">("layers");
  const [searchTerm, setSearchTerm] = useState("");

  const { data: rawLayers = [], isLoading: isLoadingLayers } = useQuery({
    queryKey: ['map-layers'],
    queryFn: async () => {
      try {
        const res = await mapLayersApi.getAll();
        return (res as any).data || res || [];
      } catch (e) {
        return MOCK_LAYERS;
      }
    }
  });

  const { data: rawRoutes = [], isLoading: isLoadingRoutes } = useQuery({
    queryKey: ['routes'],
    queryFn: async () => {
      try {
        const res = await routesApi.getAll();
        return (res as any).data || res || [];
      } catch (e) {
        return MOCK_ROUTES;
      }
    }
  });

  const { data: rawLocations = [], isLoading: isLoadingLocations } = useQuery({
    queryKey: ['locations'],
    queryFn: async () => {
      try {
        const res = await apiClient.get('/locations');
        return (res as any).data || res || [];
      } catch (e) {
        return MOCK_LOCATIONS;
      }
    }
  });

  const mapLayers = Array.isArray(rawLayers) ? rawLayers : [];
  const routes = Array.isArray(rawRoutes) ? rawRoutes : [];
  const locations = Array.isArray(rawLocations) ? rawLocations : [];

  const filteredLayers = mapLayers.filter((layer: any) => (layer.name || "").toLowerCase().includes(searchTerm.toLowerCase()) || (layer.description || "").toLowerCase().includes(searchTerm.toLowerCase()));
  const filteredRoutes = routes.filter((route: any) => (route.name || "").toLowerCase().includes(searchTerm.toLowerCase()) || (route.description || "").toLowerCase().includes(searchTerm.toLowerCase()));
  const filteredLocations = locations.filter((location: any) => (location.name || "").toLowerCase().includes(searchTerm.toLowerCase()) || (location.address || "").toLowerCase().includes(searchTerm.toLowerCase()));
  const stats = [{
    label: t("client.src.active_feeds"),
    value: mapLayers.filter(l => l.isActive).length,
    icon: Zap
  }, {
    label: t("client.src.grid_coverage"),
    value: locations.length > 0 ? `${(locations.filter(l => l.isStandardized).length / locations.length * 100).toFixed(0)}%` : "0%",
    icon: Globe
  }, {
    label: t("client.src.syncstatus"),
    value: "STABLE",
    icon: Activity
  }, {
    label: t("client.src.spatialnodes"),
    value: locations.length,
    icon: Compass
  }];
  const LayerCard = ({
    layer
  }: {
    layer: any;
  }) => {
    const {
      t
    } = useTranslation();
    return <motion.div layout initial={{
      opacity: 0,
      y: 20
    }} animate={{
      opacity: 1,
      y: 0
    }} className="bg-[#1a1b1e]/60 border border-white/5 rounded-[32px] p-8 backdrop-blur-3xl shadow-xl group hover:bg-white/5 transition-all">
      <div className="flex items-start justify-between mb-6">
         <div className="flex items-center gap-4">
            <div className="h-14 w-14 rounded-2xl bg-blue-600/10 border border-blue-500/20 flex items-center justify-center shadow-2xl group-hover:scale-110 transition-transform">
               <Layers className="w-7 h-7 text-blue-400" />
            </div>
            <div>
               <h3 className="text-lg font-black text-white italic tracking-tighter leading-none mb-1 group-hover:text-blue-400 transition-colors">{layer.name}</h3>
               <span className="text-[9px] font-black text-slate-500 tracking-widest italic">{layer.type}{t("client.src.protocol")}</span>
            </div>
         </div>
         <Badge className={cn("px-3 py-1 rounded-full border text-[8px] font-black  tracking-widest italic", layer.isActive ? "bg-emerald-500/10 text-emerald-400 border-emerald-500/20" : "bg-slate-500/10 text-slate-400 border-white/5")}>
            {layer.isActive ? "ONLINE" : "OFFLINE"}
         </Badge>
      </div>

      <p className="text-[10px] font-bold text-slate-500 tracking-widest leading-relaxed italic mb-8 line-clamp-2">{layer.description || "GEOGRAPHIC DATA OVERLAY NODE."}</p>

      <div className="flex items-center justify-between pt-6 border-t border-white/5">
         <div className="flex flex-col gap-1">
            <span className="text-[8px] font-black text-slate-600 italic">{t("client.src.opacity")}{Math.round(layer.opacity * 100)}%</span>
            <div className="w-24 bg-white/5 h-1 rounded-full overflow-hidden">
               <div className="bg-blue-500 h-full" style={{
              width: `${layer.opacity * 100}%`
            }} />
            </div>
         </div>
         <div className="flex items-center gap-2">
            <Button variant="ghost" size="sm" className="h-10 w-10 p-0 text-slate-500 hover:text-white">
               <Edit className="w-4 h-4" />
            </Button>
            <Button variant="ghost" size="sm" className="h-10 w-10 p-0 text-slate-500 hover:text-red-500">
               <Trash2 className="w-4 h-4" />
            </Button>
         </div>
      </div>
    </motion.div>;
  };
  const RouteCard = ({
    route
  }: {
    route: any;
  }) => {
    const {
      t
    } = useTranslation();
    return <motion.div layout initial={{
      opacity: 0,
      x: -20
    }} animate={{
      opacity: 1,
      x: 0
    }} className="bg-[#1a1b1e]/40 border border-white/5 rounded-[40px] p-10 backdrop-blur-3xl shadow-3xl group hover:bg-white/5 transition-all relative overflow-hidden">
      <div className="absolute top-0 right-0 p-10 opacity-5 pointer-events-none group-hover:opacity-10 transition-opacity">
         <RouteIcon className="w-32 h-32 text-blue-500" />
      </div>

      <div className="flex items-center justify-between mb-8 relative z-10">
         <div className="flex items-center gap-6">
            <div className="h-16 w-16 rounded-3xl bg-black/60 border border-white/10 flex items-center justify-center shadow-2xl">
               <Navigation className="w-8 h-8 text-blue-400" />
            </div>
            <div>
               <h3 className="text-xl font-black text-white italic tracking-tighter mb-1">{route.name}</h3>
               <p className="text-[10px] font-bold text-slate-500 tracking-widest italic">{(route.distance || 0).toFixed(1)}{t("client.src.km")}{route.estimatedTime || 0}{t("client.src.min")}</p>
            </div>
         </div>
         <Badge className="bg-blue-600/10 text-blue-400 border-blue-500/20 text-[8px] font-black px-3 py-1">{t("client.src.optimized")}</Badge>
      </div>

      <p className="text-[10px] font-bold text-slate-600 tracking-widest italic mb-10 leading-relaxed">{route.description || "AUTOMATED NAVIGATION PATHWAY."}</p>

      <div className="flex gap-4 relative z-10">
         <Button className="flex-1 h-14 rounded-2xl bg-white text-black hover:bg-slate-200 font-black italic tracking-widest text-[10px]">{t("client.src.initialize_navigation")}</Button>
         <Button variant="outline" className="h-14 w-14 rounded-2xl border-white/10 bg-white/5 text-slate-500 hover:text-blue-500"><Maximize className="w-5 h-5" /></Button>
      </div>
    </motion.div>;
  };
  const LocationNode = ({
    loc
  }: {
    loc: any;
  }) => {
    const {
      t
    } = useTranslation();
    return <div className="bg-[#1a1b1e]/60 border border-white/5 rounded-3xl p-6 flex flex-col md:flex-row items-center justify-between gap-6 hover:bg-white/5 transition-all group">
       <div className="flex items-center gap-6">
          <div className="h-14 w-14 rounded-2xl bg-black/40 border border-white/5 flex items-center justify-center group-hover:scale-110 transition-transform">
             <MapPin className="w-6 h-6 text-emerald-400" />
          </div>
          <div>
             <h4 className="text-sm font-black text-white italic tracking-tight mb-1">{loc.name}</h4>
             <p className="text-[10px] font-bold text-slate-500 tracking-widest italic">{loc.address}</p>
          </div>
       </div>

       <div className="flex items-center gap-12">
          <div className="text-right flex flex-col items-end">
             <span className="text-[8px] font-black text-slate-600 italic mb-1">{t("client.src.coordinates")}</span>
             <code className="text-[10px] font-mono text-blue-400/80">{(loc.latitude || 0).toFixed(4)}, {(loc.longitude || 0).toFixed(4)}</code>
          </div>
          <div className="flex items-center gap-3">
             <Button variant="ghost" size="sm" className="h-12 px-6 text-[10px] font-black italic tracking-widest hover:bg-blue-600 hover:text-white rounded-xl transition-all">{t("client.src.regeoconfigure")}</Button>
             <DropdownMenu>
                <DropdownMenuTrigger asChild>
                   <Button variant="outline" size="sm" className="h-12 w-12 rounded-xl border-white/5 bg-white/2"><MoreHorizontal className="w-4 h-4" /></Button>
                </DropdownMenuTrigger>
                <DropdownMenuContent className="bg-[#1a1b1e] border-white/10 italic font-bold text-[10px]">
                   <DropdownMenuItem className="focus:bg-blue-600">{t("client.src.preview_hub")}</DropdownMenuItem>
                   <DropdownMenuItem className="focus:bg-red-600 text-red-500">{t("client.src.erase_node")}</DropdownMenuItem>
                </DropdownMenuContent>
             </DropdownMenu>
          </div>
       </div>
    </div>;
  };
  return <PageShell title={t("client.src.neural_geography")} description={t("client.src.metropolitan_logicmapping_spatial_synchronization")}>
      <div className="space-y-12">
        {/* Hub Stats */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
           {stats.map((stat, idx) => <Card key={idx} className="bg-[#1a1b1e]/60 border-white/5 border-l border-t rounded-[32px] p-10 shadow-3xl relative group hover:bg-white/5 transition-all">
                <div className="absolute top-0 right-0 p-8 opacity-5 text-blue-500 group-hover:scale-110 transition-transform">
                   <stat.icon className="w-16 h-16" />
                </div>
                <p className="text-[10px] font-black text-slate-500 tracking-widest italic mb-2 leading-none">{stat.label}</p>
                <h3 className="text-4xl font-black text-white italic tracking-tighter leading-none">{stat.value}</h3>
             </Card>)}
        </div>

        {/* Tab Interface */}
        <div className="flex flex-col gap-10">
           <div className="flex flex-wrap items-center justify-between gap-6 border-b border-white/5 pb-8">
              <div className="flex items-center gap-3 bg-[#1a1b1e]/40 p-2 rounded-2xl border border-white/5">
                 {[{
              id: "layers",
              label: t("client.src.layers"),
              icon: Layers
            }, {
              id: "routes",
              label: t("client.src.routes"),
              icon: RouteIcon
            }, {
              id: "locations",
              label: t("client.src.locations"),
              icon: MapPin
            }].map(tab => <Button key={tab.id} onClick={() => setActiveTab(tab.id as any)} variant="ghost" className={cn("h-12 px-8 rounded-xl text-[10px] font-black  italic tracking-widest transition-all", activeTab === tab.id ? "bg-blue-600 text-white shadow-xl shadow-blue-600/20" : "text-slate-500 hover:text-slate-300")}>
                     <tab.icon className="w-4 h-4 mr-2" /> {tab.label}
                   </Button>)}
              </div>
              
              <div className="relative group min-w-[300px]">
                 <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-600 group-focus-within:text-blue-500 transition-colors" />
                 <input placeholder={t("client.src.search_spatial_nodes")} className="w-full h-12 pl-12 pr-6 bg-black/40 border border-white/5 rounded-xl text-[10px] font-black tracking-widest italic text-white placeholder:text-slate-700 outline-none focus:border-blue-500/30 transition-all" value={searchTerm} onChange={e => setSearchTerm(e.target.value)} />
              </div>
           </div>

           <div className="min-h-[600px]">
              <AnimatePresence mode="wait">
                 {activeTab === "layers" && <motion.div key="layers" initial={{
              opacity: 0,
              y: 10
            }} animate={{
              opacity: 1,
              y: 0
            }} exit={{
              opacity: 0,
              y: -10
            }} className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                       {filteredLayers.map(layer => <LayerCard key={layer.id} layer={layer} />)}
                       <motion.div whileHover={{
                scale: 1.02
              }} className="border-2 border-dashed border-white/5 rounded-[32px] flex flex-col items-center justify-center gap-4 py-20 bg-white/1 hover:bg-blue-600/5 hover:border-blue-500/20 transition-all cursor-pointer group">
                          <div className="h-16 w-16 rounded-full bg-blue-600/10 flex items-center justify-center group-hover:scale-110 transition-transform">
                             <Zap className="w-8 h-8 text-blue-500" />
                          </div>
                          <span className="text-[10px] font-black text-slate-500 tracking-widest italic">{t("client.src.inject_new_data_layer")}</span>
                       </motion.div>
                    </motion.div>}

                 {activeTab === "routes" && <motion.div key="routes" initial={{
              opacity: 0,
              x: 20
            }} animate={{
              opacity: 1,
              x: 0
            }} exit={{
              opacity: 0,
              x: -20
            }} className="grid grid-cols-1 lg:grid-cols-2 gap-10">
                       {filteredRoutes.map(route => <RouteCard key={route.id} route={route} />)}
                    </motion.div>}

                 {activeTab === "locations" && <motion.div key="locations" initial={{
              opacity: 0
            }} animate={{
              opacity: 1
            }} exit={{
              opacity: 0
            }} className="space-y-6">
                       {filteredLocations.map(loc => <LocationNode key={loc.id} loc={loc} />)}
                    </motion.div>}
              </AnimatePresence>
           </div>
        </div>
      </div>
    </PageShell>;
}
const MOCK_LAYERS: MapLayer[] = [{
  id: "1",
  name: "THERMAL_DENSITY_GRID",
  type: "HEATMAP",
  isActive: true,
  createdAt: "2024-01-10",
  description: t("client.src.infrared_building_efficiency_overlay"),
  zIndex: 1,
  opacity: 0.8
}, {
  id: "2",
  name: "ZONING_CORE_NODES",
  type: "BOUNDARY",
  isActive: true,
  createdAt: "2024-01-12",
  description: t("client.src.official_metropolitan_zoning_boundaries"),
  zIndex: 2,
  opacity: 0.6
}, {
  id: "3",
  name: "TERRAIN_ELEVATION_8K",
  type: "BASE",
  isActive: false,
  createdAt: "2024-01-15",
  description: t("client.src.highresolution_topography_map_cluster"),
  zIndex: 0,
  opacity: 1.0
}];
const MOCK_ROUTES: RouteInfo[] = [{
  id: "1",
  name: "HUB_TO_PERIMETER",
  distance: 12.5,
  estimatedTime: 45,
  isActive: true,
  createdAt: "2024-01-20",
  description: t("client.src.primary_maintenance_logistics_corridor")
}, {
  id: "2",
  name: "DOWNTOWN_LOGIC_PATH",
  distance: 4.2,
  estimatedTime: 12,
  isActive: true,
  createdAt: "2024-01-22",
  description: t("client.src.rapid_transit_property_inspection")
}];
const MOCK_LOCATIONS: Location[] = [{
  id: "1",
  name: "SUNSET_TERMINAL",
  address: "777 Logic Way, Sector 4",
  type: "PROPERTY",
  latitude: 34.0522,
  longitude: -118.2437,
  isStandardized: true,
  createdAt: "2024-01-25"
}, {
  id: "2",
  name: "NEXUS_AMENITY_CENTER",
  address: "101 Data St, Core Hub",
  type: "AMENITY" as any,
  latitude: 34.0522,
  longitude: -118.2437,
  isStandardized: false,
  createdAt: "2024-01-26"
}];