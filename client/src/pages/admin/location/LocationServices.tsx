import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Switch } from "@/components/ui/switch";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { locationsApi } from "@/lib/api/locations";
import { Map, MapPin, Navigation, Globe, Layers, Plus, Edit, Eye, Download, RefreshCw, CheckCircle, XCircle, Map as MapIcon, Route, Building, MoreHorizontal, Save, Loader2 } from "lucide-react";
interface LocationService {
  id: string;
  name: string;
  provider: "GOOGLE" | "OPENSTREETMAP" | "YANDEX" | "MAPBOX";
  type: "GEOCODING" | "DIRECTIONS" | "PLACES" | "STATIC_MAPS" | "GEOLOCATION";
  status: "ACTIVE" | "INACTIVE" | "ERROR";
  apiKey: string;
  quota: {
    daily: number;
    used: number;
    resetDate: string;
  };
  pricing: {
    perRequest: number;
    currency: string;
  };
  lastUsed?: string;
  errorCount: number;
  responseTime: number;
}
interface MapLayer {
  id: string;
  name: string;
  type: "BASE" | "OVERLAY" | "DATA";
  provider: string;
  url: string;
  zIndex: number;
  isVisible: boolean;
  opacity: number;
  style: string;
  attribution: string;
  createdAt: string;
  updatedAt: string;
}
interface Geofence {
  id: string;
  name: string;
  type: "CIRCLE" | "POLYGON" | "RECTANGLE";
  coordinates: any;
  radius?: number;
  isActive: boolean;
  description: string;
  createdAt: string;
  properties: Record<string, any>;
}
const MOCK_SERVICES: LocationService[] = [{
  id: "1",
  name: "Google Geocoding API",
  provider: "GOOGLE",
  type: "GEOCODING",
  status: "ACTIVE",
  apiKey: "AIzaSy...xyz",
  quota: {
    daily: 100000,
    used: 45234,
    resetDate: "2024-03-29"
  },
  pricing: {
    perRequest: 0.005,
    currency: "USD"
  },
  lastUsed: "2024-03-28T10:30:00Z",
  errorCount: 2,
  responseTime: 145
}, {
  id: "2",
  name: "OpenStreetMap Tiles",
  provider: "OPENSTREETMAP",
  type: "STATIC_MAPS",
  status: "ACTIVE",
  apiKey: "",
  quota: {
    daily: 0,
    used: 0,
    resetDate: ""
  },
  pricing: {
    perRequest: 0,
    currency: "USD"
  },
  lastUsed: "2024-03-28T10:25:00Z",
  errorCount: 0,
  responseTime: 89
}, {
  id: "3",
  name: "Mapbox Directions API",
  provider: "MAPBOX",
  type: "DIRECTIONS",
  status: "ERROR",
  apiKey: "pk.abc123...",
  quota: {
    daily: 50000,
    used: 48765,
    resetDate: "2024-03-29"
  },
  pricing: {
    perRequest: 0.01,
    currency: "USD"
  },
  lastUsed: "2024-03-28T09:45:00Z",
  errorCount: 15,
  responseTime: 234
}];
const MOCK_LAYERS: MapLayer[] = [{
  id: "1",
  name: "OpenStreetMap Base",
  type: "BASE",
  provider: "OpenStreetMap",
  url: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
  zIndex: 0,
  isVisible: true,
  opacity: 1,
  style: "standard",
  attribution: "© OpenStreetMap contributors",
  createdAt: "2024-03-15",
  updatedAt: "2024-03-28"
}, {
  id: "2",
  name: "Property Boundaries",
  type: "DATA",
  provider: "Internal",
  url: "/api/v1/maps/property-boundaries/{z}/{x}/{y}",
  zIndex: 10,
  isVisible: true,
  opacity: 0.7,
  style: "property-lines",
  attribution: "© Reservatior",
  createdAt: "2024-03-20",
  updatedAt: "2024-03-27"
}, {
  id: "3",
  name: "School Districts",
  type: "OVERLAY",
  provider: "External",
  url: "/api/v1/maps/school-districts/{z}/{x}/{y}",
  zIndex: 5,
  isVisible: false,
  opacity: 0.5,
  style: "school-zones",
  attribution: "© Department of Education",
  createdAt: "2024-03-18",
  updatedAt: "2024-03-25"
}];
const MOCK_GEOFENCES: Geofence[] = [{
  id: "1",
  name: "Downtown Business District",
  type: "POLYGON",
  coordinates: [[[-74.0060, 40.7128], [-74.0050, 40.7138], [-74.0040, 40.7128], [-74.0050, 40.7118], [-74.0060, 40.7128]]],
  isActive: true,
  description: t("admin.location.central_business_area_with"),
  createdAt: "2024-03-20",
  properties: {
    zoneType: "commercial",
    maxHeight: "50m",
    parkingRequired: true
  }
}, {
  id: "2",
  name: "School Zone - 500m Radius",
  type: "CIRCLE",
  coordinates: {
    lat: 40.7128,
    lng: -74.0060
  },
  radius: 500,
  isActive: true,
  description: t("admin.location.500_meter_radius_around"),
  createdAt: "2024-03-22",
  properties: {
    schoolType: "elementary",
    speedLimit: "25 mph",
    hours: "7AM-4PM"
  }
}];
export default function LocationServices() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const queryClient = useQueryClient();
  const [services, setServices] = useState<LocationService[]>(MOCK_SERVICES);
  const [geofences, setGeofences] = useState<Geofence[]>(MOCK_GEOFENCES);
  const [activeTab, setActiveTab] = useState("services");
  const [serviceDialogOpen, setServiceDialogOpen] = useState(false);

  const { data: layersData, isLoading: loadingLayers } = useQuery({
    queryKey: ['mapLayers'],
    queryFn: async () => {
      const res = await locationsApi.getMapLayers();
      const apiLayers = Array.isArray(res) ? res : ((res as any).data || []);
      
      return apiLayers.map((l: any) => ({
        id: l.id,
        name: l.name || "Unknown Layer",
        type: l.type || "BASE",
        provider: l.config?.provider || "Internal",
        url: l.config?.url || "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        zIndex: l.zIndex || 0,
        isVisible: l.isVisible || false,
        opacity: l.config?.opacity || 1,
        style: l.config?.style || "standard",
        attribution: l.config?.attribution || "© OpenStreetMap contributors",
        createdAt: l.createdAt || new Date().toISOString(),
        updatedAt: l.updatedAt || new Date().toISOString(),
      })) as MapLayer[];
    }
  });

  const layers = layersData && layersData.length > 0 ? layersData : MOCK_LAYERS;

  const updateLayerMutation = useMutation({
    mutationFn: async ({ id, data }: { id: string, data: any }) => {
      return await locationsApi.updateMapLayer(id, data);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['mapLayers'] });
    },
    onError: (error: any) => {
      toast({
        title: t("admin.location.error", "Error"),
        description: error.message,
        variant: "destructive"
      });
    }
  });
  const getProviderIcon = (provider: string) => {
    switch (provider) {
      case "GOOGLE":
        return <Globe className="w-4 h-4 text-blue-600" />;
      case "OPENSTREETMAP":
        return <Map className="w-4 h-4 text-green-600" />;
      case "YANDEX":
        return <Navigation className="w-4 h-4 text-yellow-600" />;
      case "MAPBOX":
        return <MapPin className="w-4 h-4 text-purple-600" />;
      default:
        return <MapIcon className="w-4 h-4 text-gray-600" />;
    }
  };
  const getStatusColor = (status: string) => {
    switch (status) {
      case "ACTIVE":
        return "bg-green-100 text-green-700";
      case "INACTIVE":
        return "bg-gray-100 text-gray-700";
      case "ERROR":
        return "bg-red-100 text-red-700";
      default:
        return "bg-gray-100 text-gray-700";
    }
  };
  const getTypeIcon = (type: string) => {
    switch (type) {
      case "GEOCODING":
        return <MapPin className="w-4 h-4" />;
      case "DIRECTIONS":
        return <Route className="w-4 h-4" />;
      case "PLACES":
        return <Building className="w-4 h-4" />;
      case "STATIC_MAPS":
        return <Map className="w-4 h-4" />;
      case "GEOLOCATION":
        return <Navigation className="w-4 h-4" />;
      default:
        return <MapIcon className="w-4 h-4" />;
    }
  };
  const getQuotaPercentage = (used: number, daily: number) => {
    if (daily === 0) return 0;
    return Math.round(used / daily * 100);
  };
  const toggleService = (serviceId: string) => {
    setServices(services.map(s => s.id === serviceId ? {
      ...s,
      status: s.status === "ACTIVE" ? "INACTIVE" : "ACTIVE" as any
    } : s));
    toast({
      title: t("admin.location.service_updated"),
      description: t("admin.location.service_status_has_been")
    });
  };
  const toggleLayer = (layer: MapLayer) => {
    updateLayerMutation.mutate({
      id: layer.id,
      data: { isVisible: !layer.isVisible }
    });
    toast({
      title: t("admin.location.layer_updated"),
      description: t("admin.location.layer_visibility_has_been")
    });
  };
  const toggleGeofence = (geofenceId: string) => {
    setGeofences(geofences.map(g => g.id === geofenceId ? {
      ...g,
      isActive: !g.isActive
    } : g));
    toast({
      title: t("admin.location.geofence_updated"),
      description: t("admin.location.geofence_status_has_been")
    });
  };
  const testService = (service: LocationService) => {
    toast({
      title: t("admin.location.test_started"),
      description: `Testing ${service.name}...`
    });
  };
  const stats = {
    totalServices: services.length,
    activeServices: services.filter(s => s.status === "ACTIVE").length,
    errorServices: services.filter(s => s.status === "ERROR").length,
    totalLayers: layers.length,
    activeLayers: layers.filter(l => l.isVisible).length,
    totalGeofences: geofences.length,
    activeGeofences: geofences.filter(g => g.isActive).length
  };
  return <PageShell title={t("admin.location.location_services")} description={t("admin.location.manage_map_providers_layers")}>
      <div className="space-y-6">
        {/* Stats Cards */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          <Card>
            <CardContent className="p-4">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-gray-600">{t("admin.location.active_services")}</p>
                  <p className="text-2xl font-bold text-green-600">{stats.activeServices}</p>
                  <p className="text-xs text-gray-500">{t("admin.location.of")}{stats.totalServices}{t("admin.location.total")}</p>
                </div>
                <CheckCircle className="w-8 h-8 text-green-600" />
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="p-4">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-gray-600">{t("admin.location.error_services")}</p>
                  <p className="text-2xl font-bold text-red-600">{stats.errorServices}</p>
                  <p className="text-xs text-red-500">{t("admin.location.requires_attention")}</p>
                </div>
                <XCircle className="w-8 h-8 text-red-600" />
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="p-4">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-gray-600">{t("admin.location.map_layers")}</p>
                  <p className="text-2xl font-bold text-blue-600">{stats.activeLayers}</p>
                  <p className="text-xs text-gray-500">{t("admin.location.of")}{stats.totalLayers}{t("admin.location.visible")}</p>
                </div>
                <Layers className="w-8 h-8 text-blue-600" />
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="p-4">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-gray-600">{t("admin.location.active_geofences")}</p>
                  <p className="text-2xl font-bold text-purple-600">{stats.activeGeofences}</p>
                  <p className="text-xs text-gray-500">{t("admin.location.of")}{stats.totalGeofences}{t("admin.location.total")}</p>
                </div>
                <MapPin className="w-8 h-8 text-purple-600" />
              </div>
            </CardContent>
          </Card>
        </div>

        {/* Tabs */}
        <Tabs value={activeTab} onValueChange={setActiveTab}>
          <TabsList className="grid w-full grid-cols-4">
            <TabsTrigger value="services">{t("admin.location.services")}</TabsTrigger>
            <TabsTrigger value="layers">{t("admin.location.map_layers")}</TabsTrigger>
            <TabsTrigger value="geofences">{t("admin.location.geofences")}</TabsTrigger>
            <TabsTrigger value="settings">{t("admin.location.settings")}</TabsTrigger>
          </TabsList>

          <TabsContent value="services" className="space-y-6">
            <div className="flex justify-between items-center">
              <h3 className="text-lg font-semibold">{t("admin.location.location_services")}</h3>
              <Button onClick={() => setServiceDialogOpen(true)}>
                <Plus className="w-4 h-4 mr-2" />{t("admin.location.add_service")}</Button>
            </div>

            <div className="space-y-4">
              {services.map(service => <Card key={service.id}>
                  <CardContent className="p-6">
                    <div className="flex items-center justify-between">
                      <div className="flex-1">
                        <div className="flex items-center gap-3 mb-2">
                          {getProviderIcon(service.provider)}
                          <div>
                            <h4 className="font-medium">{service.name}</h4>
                            <div className="flex items-center gap-2 text-sm text-gray-600">
                              {getTypeIcon(service.type)}
                              <span>{service.type}</span>
                              <Badge className={getStatusColor(service.status)}>
                                {service.status}
                              </Badge>
                            </div>
                          </div>
                        </div>
                        
                        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 text-sm">
                          <div>
                            <span className="text-gray-600">{t("admin.location.response_time")}</span>
                            <div className="font-medium">{service.responseTime}{t("admin.location.ms")}</div>
                          </div>
                          <div>
                            <span className="text-gray-600">{t("admin.location.error_count")}</span>
                            <div className="font-medium text-red-600">{service.errorCount}</div>
                          </div>
                          <div>
                            <span className="text-gray-600">{t("admin.location.api_usage")}</span>
                            <div className="font-medium">
                              {service.quota.used.toLocaleString()} / {service.quota.daily.toLocaleString()}
                            </div>
                          </div>
                          <div>
                            <span className="text-gray-600">{t("admin.location.cost")}</span>
                            <div className="font-medium">
                              ${service.pricing.perRequest}{t("admin.location.per_request")}</div>
                          </div>
                        </div>

                        {service.quota.daily > 0 && <div className="mt-3">
                            <div className="flex justify-between text-sm mb-1">
                              <span>{t("admin.location.quota_usage")}</span>
                              <span>{getQuotaPercentage(service.quota.used, service.quota.daily)}%</span>
                            </div>
                            <div className="w-full bg-gray-200 rounded-full h-2">
                              <div className={`h-2 rounded-full ${getQuotaPercentage(service.quota.used, service.quota.daily) > 80 ? "bg-red-600" : getQuotaPercentage(service.quota.used, service.quota.daily) > 60 ? "bg-yellow-600" : "bg-green-600"}`} style={{
                          width: `${getQuotaPercentage(service.quota.used, service.quota.daily)}%`
                        }}></div>
                            </div>
                          </div>}
                      </div>
                      
                      <div className="flex items-center gap-3">
                        <Switch checked={service.status === "ACTIVE"} onCheckedChange={() => toggleService(service.id)} />
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild>
                            <Button variant="ghost" size="sm">
                              <MoreHorizontal className="w-4 h-4" />
                            </Button>
                          </DropdownMenuTrigger>
                          <DropdownMenuContent>
                            <DropdownMenuItem onClick={() => testService(service)}>
                              <RefreshCw className="w-4 h-4 mr-2" />{t("admin.location.test_service")}</DropdownMenuItem>
                            <DropdownMenuItem>
                              <Edit className="w-4 h-4 mr-2" />{t("admin.location.edit")}</DropdownMenuItem>
                            <DropdownMenuItem>
                              <Eye className="w-4 h-4 mr-2" />{t("admin.location.view_logs")}</DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </div>
                    </div>
                  </CardContent>
                </Card>)}
            </div>
          </TabsContent>

          <TabsContent value="layers" className="space-y-6">
            <div className="flex justify-between items-center">
              <h3 className="text-lg font-semibold">{t("admin.location.map_layers")}</h3>
              <Button onClick={() => toast({
              title: t("admin.location.layer_manager_coming_soon")
            })}>
                <Plus className="w-4 h-4 mr-2" />{t("admin.location.add_layer")}</Button>
            </div>

            <div className="space-y-4">
              {loadingLayers ? (
                <div className="flex justify-center items-center py-12 text-muted-foreground">
                  <Loader2 className="w-8 h-8 animate-spin" />
                </div>
              ) : layers.map(layer => <Card key={layer.id}>
                  <CardContent className="p-6">
                    <div className="flex items-center justify-between">
                      <div className="flex-1">
                        <div className="flex items-center gap-3 mb-2">
                          <Layers className="w-5 h-5 text-blue-600" />
                          <div>
                            <h4 className="font-medium">{layer.name}</h4>
                            <div className="flex items-center gap-2 text-sm text-gray-600">
                              <Badge variant="outline">{layer.type}</Badge>
                              <span>{t("admin.location.provider")}{layer.provider}</span>
                              <span>{t("admin.location.zindex")}{layer.zIndex}</span>
                            </div>
                          </div>
                        </div>
                        
                        <div className="grid grid-cols-2 md:grid-cols-3 gap-4 text-sm">
                          <div>
                            <span className="text-gray-600">{t("admin.location.opacity")}</span>
                            <div className="font-medium">{layer.opacity * 100}%</div>
                          </div>
                          <div>
                            <span className="text-gray-600">{t("admin.location.style")}</span>
                            <div className="font-medium">{layer.style}</div>
                          </div>
                          <div>
                            <span className="text-gray-600">{t("admin.location.updated")}</span>
                            <div className="font-medium">
                              {new Date(layer.updatedAt).toLocaleDateString()}
                            </div>
                          </div>
                        </div>

                        <div className="mt-3">
                          <div className="text-xs text-gray-500 mb-1">{t("admin.location.url_template")}</div>
                          <div className="text-xs font-mono bg-gray-100 p-2 rounded">
                            {layer.url}
                          </div>
                        </div>
                      </div>
                      
                      <div className="flex items-center gap-3">
                        <Switch checked={layer.isVisible} onCheckedChange={() => toggleLayer(layer)} />
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild>
                            <Button variant="ghost" size="sm">
                              <MoreHorizontal className="w-4 h-4" />
                            </Button>
                          </DropdownMenuTrigger>
                          <DropdownMenuContent>
                            <DropdownMenuItem>
                              <Eye className="w-4 h-4 mr-2" />{t("admin.location.preview")}</DropdownMenuItem>
                            <DropdownMenuItem>
                              <Edit className="w-4 h-4 mr-2" />{t("admin.location.edit")}</DropdownMenuItem>
                            <DropdownMenuItem>
                              <Download className="w-4 h-4 mr-2" />{t("admin.location.export")}</DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </div>
                    </div>
                  </CardContent>
                </Card>)}
            </div>
          </TabsContent>

          <TabsContent value="geofences" className="space-y-6">
            <div className="flex justify-between items-center">
              <h3 className="text-lg font-semibold">{t("admin.location.geofences")}</h3>
              <Button onClick={() => toast({
              title: t("admin.location.geofence_editor_coming_soon")
            })}>
                <Plus className="w-4 h-4 mr-2" />{t("admin.location.create_geofence")}</Button>
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              {geofences.map(geofence => <Card key={geofence.id}>
                  <CardContent className="p-6">
                    <div className="flex items-center justify-between mb-4">
                      <div className="flex items-center gap-3">
                        <MapPin className="w-5 h-5 text-purple-600" />
                        <div>
                          <h4 className="font-medium">{geofence.name}</h4>
                          <div className="flex items-center gap-2 text-sm text-gray-600">
                            <Badge variant="outline">{geofence.type}</Badge>
                            {geofence.radius && <span>{t("admin.location.radius")}{geofence.radius}m</span>}
                          </div>
                        </div>
                      </div>
                      <Switch checked={geofence.isActive} onChange={() => toggleGeofence(geofence.id)} />
                    </div>
                    
                    <p className="text-sm text-gray-600 mb-3">{geofence.description}</p>
                    
                    <div className="space-y-2">
                      <div className="text-sm font-medium">{t("admin.location.properties")}</div>
                      <div className="grid grid-cols-2 gap-2 text-xs">
                        {Object.entries(geofence.properties).map(([key, value]) => <div key={key} className="bg-gray-100 p-2 rounded">
                            <div className="font-medium capitalize">{key}:</div>
                            <div>{String(value)}</div>
                          </div>)}
                      </div>
                    </div>
                    
                    <div className="flex justify-between items-center mt-4 text-xs text-gray-500">
                      <span>{t("admin.location.created")}{new Date(geofence.createdAt).toLocaleDateString()}</span>
                      <div className="flex gap-2">
                        <Button variant="outline" size="sm">
                          <Edit className="w-3 h-3 mr-1" />{t("admin.location.edit")}</Button>
                        <Button variant="outline" size="sm">
                          <Eye className="w-3 h-3 mr-1" />{t("admin.location.view")}</Button>
                      </div>
                    </div>
                  </CardContent>
                </Card>)}
            </div>
          </TabsContent>

          <TabsContent value="settings" className="space-y-6">
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              <Card>
                <CardHeader>
                  <CardTitle>{t("admin.location.general_settings")}</CardTitle>
                  <CardDescription>{t("admin.location.global_location_service_configuration")}</CardDescription>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div className="flex items-center justify-between">
                    <div>
                      <div className="font-medium">{t("admin.location.default_map_provider")}</div>
                      <div className="text-sm text-gray-600">{t("admin.location.primary_map_service")}</div>
                    </div>
                    <Select defaultValue="OPENSTREETMAP">
                      <SelectTrigger className="w-[150px]">
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="GOOGLE">{t("admin.location.google_maps")}</SelectItem>
                        <SelectItem value="OPENSTREETMAP">{t("admin.location.openstreetmap")}</SelectItem>
                        <SelectItem value="MAPBOX">{t("admin.location.mapbox")}</SelectItem>
                        <SelectItem value="YANDEX">{t("admin.location.yandex_maps")}</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                  <div className="flex items-center justify-between">
                    <div>
                      <div className="font-medium">{t("admin.location.cache_duration")}</div>
                      <div className="text-sm text-gray-600">{t("admin.location.how_long_to_cache")}</div>
                    </div>
                    <Select defaultValue="3600">
                      <SelectTrigger className="w-[150px]">
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="300">{t("admin.location.5_minutes")}</SelectItem>
                        <SelectItem value="1800">{t("admin.location.30_minutes")}</SelectItem>
                        <SelectItem value="3600">{t("admin.location.1_hour")}</SelectItem>
                        <SelectItem value="86400">{t("admin.location.24_hours")}</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                  <div className="flex items-center justify-between">
                    <div>
                      <div className="font-medium">{t("admin.location.enable_geolocation")}</div>
                      <div className="text-sm text-gray-600">{t("admin.location.user_location_tracking")}</div>
                    </div>
                    <Switch defaultChecked />
                  </div>
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle>{t("admin.location.api_configuration")}</CardTitle>
                  <CardDescription>{t("admin.location.api_keys_and_authentication")}</CardDescription>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div className="space-y-2">
                    <Label>{t("admin.location.google_maps_api_key")}</Label>
                    <Input type="password" placeholder={t("admin.location.enter_api_key")} />
                  </div>
                  <div className="space-y-2">
                    <Label>{t("admin.location.mapbox_access_token")}</Label>
                    <Input type="password" placeholder={t("admin.location.enter_access_token")} />
                  </div>
                  <div className="space-y-2">
                    <Label>{t("admin.location.yandex_api_key")}</Label>
                    <Input type="password" placeholder={t("admin.location.enter_api_key")} />
                  </div>
                  <Button className="w-full">
                    <Save className="w-4 h-4 mr-2" />{t("admin.location.save_configuration")}</Button>
                </CardContent>
              </Card>
            </div>
          </TabsContent>
        </Tabs>
      </div>

      {/* Add Service Dialog */}
      <Dialog open={serviceDialogOpen} onOpenChange={setServiceDialogOpen}>
        <DialogContent className="max-w-md">
          <DialogHeader>
            <DialogTitle>{t("admin.location.add_location_service")}</DialogTitle>
            <DialogDescription>{t("admin.location.configure_a_new_location")}</DialogDescription>
          </DialogHeader>
          <div className="py-4 space-y-4">
            <div className="space-y-2">
              <Label>{t("admin.location.service_name")}</Label>
              <Input placeholder={t("admin.location.enter_service_name")} />
            </div>
            <div className="space-y-2">
              <Label>{t("admin.location.provider")}</Label>
              <Select>
                <SelectTrigger>
                  <SelectValue placeholder={t("admin.location.select_provider")} />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="GOOGLE">{t("admin.location.google_maps")}</SelectItem>
                  <SelectItem value="OPENSTREETMAP">{t("admin.location.openstreetmap")}</SelectItem>
                  <SelectItem value="MAPBOX">{t("admin.location.mapbox")}</SelectItem>
                  <SelectItem value="YANDEX">{t("admin.location.yandex_maps")}</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div className="space-y-2">
              <Label>{t("admin.location.service_type")}</Label>
              <Select>
                <SelectTrigger>
                  <SelectValue placeholder={t("admin.location.select_type")} />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="GEOCODING">{t("admin.location.geocoding")}</SelectItem>
                  <SelectItem value="DIRECTIONS">{t("admin.location.directions")}</SelectItem>
                  <SelectItem value="PLACES">{t("admin.location.places")}</SelectItem>
                  <SelectItem value="STATIC_MAPS">{t("admin.location.static_maps")}</SelectItem>
                  <SelectItem value="GEOLOCATION">{t("admin.location.geolocation")}</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div className="space-y-2">
              <Label>{t("admin.location.api_key")}</Label>
              <Input type="password" placeholder={t("admin.location.enter_api_key")} />
            </div>
            <div className="flex items-center space-x-2">
              <Switch />
              <Label>{t("admin.location.enable_this_service")}</Label>
            </div>
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setServiceDialogOpen(false)}>{t("admin.location.cancel")}</Button>
            <Button onClick={() => setServiceDialogOpen(false)}>{t("admin.location.add_service")}</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </PageShell>;
}