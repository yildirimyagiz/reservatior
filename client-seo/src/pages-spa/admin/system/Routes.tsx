"use client";

import { t } from"i18next";
import { useTranslation } from"react-i18next";
import { useState, useEffect } from"react";
import { Button } from"@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Badge } from"@/components/ui/badge";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from"@/components/ui/dialog";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Textarea } from"@/components/ui/textarea";
import { Switch } from"@/components/ui/switch";
import { useToast } from"@/hooks/use-toast";
import { Plus, Edit, Trash2, MapPin, Car, Footprints, Bike, Bus, Plane, Navigation, Download, Eye, EyeOff } from"lucide-react";
import { routesApi } from"@/lib/api/routes";
interface Route {
 id: string;
 name: string;
 description?: string;
 status: string;
 createdAt: string;
 isVisible: boolean;
 orgId: string;
 startLocationId: string;
 endLocationId: string;
 startLocation: string;
 endLocation: string;
 waypoints?: any[];
 provider?: string;
 polyline?: any;
 color: string;
 distance?: number;
 duration?: number;
 type: string;
 tolls?: number;
 strokeWidth: number;
 opacity: number;
}
const ROUTE_TYPES = [{
 value:"DRIVING",
 label: t("admin_system_driving"),
 icon: Car
}, {
 value:"WALKING",
 label: t("admin_system_walking"),
 icon: Footprints
}, {
 value:"CYCLING",
 label: t("admin_system_cycling"),
 icon: Bike
}, {
 value:"TRANSIT",
 label: t("admin_system_transit"),
 icon: Bus
}, {
 value:"FLIGHT",
 label: t("admin_system_flight"),
 icon: Plane
}];
const MAP_PROVIDERS = [{
 value:"GOOGLE_MAPS",
 label: t("admin_system_google_maps")
}, {
 value:"MAPBOX",
 label: t("admin_system_mapbox")
}, {
 value:"OPENSTREETMAP",
 label: t("admin_system_openstreetmap")
}, {
 value:"HERE_MAPS",
 label: t("admin_system_here_maps")
}, {
 value:"BING_MAPS",
 label: t("admin_system_bing_maps")
}];
export default function Routes() {
 const {
 t
 } = useTranslation();
 const [routes, setRoutes] = useState<Route[]>([]);
 const [loading, setLoading] = useState(true);
 const [createDialogOpen, setCreateDialogOpen] = useState(false);
 const [editDialogOpen, setEditDialogOpen] = useState(false);
 const [currentRoute, setCurrentRoute] = useState<Route | null>(null);
 const {
 toast
 } = useToast();
 const [formData, setFormData] = useState({
 orgId:"",
 name:"",
 type:"",
 startLocationId:"",
 endLocationId:"",
 waypoints:"",
 provider:"GOOGLE_MAPS",
 isVisible: true,
 color:"#3B82F6",
 strokeWidth: 4,
 opacity: 0.8
 });
 useEffect(() => {
 loadRoutes();
 }, []);
 const loadRoutes = async () => {
 try {
 const response = await routesApi.getAll();
 setRoutes((response as any).data || []);
 } catch (error) {
 toast({
 title: t("admin_system_error"),
 description: t("admin_system_failed_to_load_routes"),
 variant:"destructive"
 });
 } finally {
 setLoading(false);
 }
 };
 const handleCreate = async () => {
 try {
 const waypoints = formData.waypoints ? JSON.parse(formData.waypoints) : undefined;
 await routesApi.create({
 orgId: formData.orgId,
 name: formData.name,
 type: formData.type,
 startLocationId: formData.startLocationId,
 endLocationId: formData.endLocationId,
 waypoints,
 provider: formData.provider,
 isVisible: formData.isVisible,
 color: formData.color,
 strokeWidth: formData.strokeWidth,
 opacity: formData.opacity
 });
 toast({
 title: t("admin_system_success"),
 description: t("admin_system_route_created_successfully")
 });
 setCreateDialogOpen(false);
 resetForm();
 loadRoutes();
 } catch (error) {
 toast({
 title: t("admin_system_error"),
 description: t("admin_system_failed_to_create_route"),
 variant:"destructive"
 });
 }
 };
 const handleUpdate = async () => {
 if (!currentRoute) return;
 try {
 const waypoints = formData.waypoints ? JSON.parse(formData.waypoints) : undefined;
 await routesApi.update(currentRoute.id, {
 name: formData.name,
 type: formData.type,
 startLocationId: formData.startLocationId,
 endLocationId: formData.endLocationId,
 waypoints,
 provider: formData.provider,
 isVisible: formData.isVisible,
 color: formData.color,
 strokeWidth: formData.strokeWidth,
 opacity: formData.opacity
 });
 toast({
 title: t("admin_system_success"),
 description: t("admin_system_route_updated_successfully")
 });
 setEditDialogOpen(false);
 resetForm();
 loadRoutes();
 } catch (error) {
 toast({
 title: t("admin_system_error"),
 description: t("admin_system_failed_to_update_route"),
 variant:"destructive"
 });
 }
 };
 const handleDelete = async (id: string) => {
 if (!confirm(t("admin_system_are_you_sure_delete","Silmek istediğinize emin misiniz?"))) return;
 try {
 await routesApi.delete(id);
 toast({
 title: t("admin_system_success"),
 description: t("admin_system_route_deleted_successfully")
 });
 loadRoutes();
 } catch (error) {
 toast({
 title: t("admin_system_error"),
 description: t("admin_system_failed_to_delete_route"),
 variant:"destructive"
 });
 }
 };
 const toggleVisibility = async (route: Route) => {
 try {
 await routesApi.update(route.id, {
 isVisible: !route.isVisible
 });
 loadRoutes();
 } catch (error) {
 toast({
 title: t("admin_system_error"),
 description: t("admin_system_failed_to_update_route"),
 variant:"destructive"
 });
 }
 };
 const exportRoute = async (route: Route, format:"json" |"gpx" |"kml") => {
 try {
 const data = await routesApi.exportRoute(route.id, format);
 const blob = new Blob([data as any], {
 type:"application/octet-stream"
 });
 const url = window.URL.createObjectURL(blob);
 const a = document.createElement("a");
 a.href = url;
 a.download = `${route.name}.${format}`;
 document.body.appendChild(a);
 a.click();
 document.body.removeChild(a);
 window.URL.revokeObjectURL(url);
 toast({
 title: t("admin_system_success"),
 description: `Route exported as ${format}`
 });
 } catch (error) {
 toast({
 title: t("admin_system_error"),
 description: t("admin_system_failed_to_export_route"),
 variant:"destructive"
 });
 }
 };
 const openEditDialog = (route: Route) => {
 setCurrentRoute(route);
 setFormData({
 orgId: route.orgId,
 name: route.name,
 type: route.type,
 startLocationId: route.startLocationId,
 endLocationId: route.endLocationId,
 waypoints: route.waypoints ? JSON.stringify(route.waypoints, null, 2) :"",
 provider: route.provider ||"",
 isVisible: route.isVisible,
 color: route.color ||"#3B82F6",
 strokeWidth: route.strokeWidth,
 opacity: route.opacity
 });
 setEditDialogOpen(true);
 };
 const resetForm = () => {
 setFormData({
 orgId:"",
 name:"",
 type:"",
 startLocationId:"",
 endLocationId:"",
 waypoints:"",
 provider:"GOOGLE_MAPS",
 isVisible: true,
 color:"#3B82F6",
 strokeWidth: 4,
 opacity: 0.8
 });
 setCurrentRoute(null);
 };
 if (loading) {
 return <div className="p-6 flex items-center justify-center min-h-[400px]">{t("admin_system_loading_routes")}</div>;
 }
 return <div className="p-6">
 <div className="container mx-auto space-y-8">
 <div className="flex justify-between items-center mb-6">
 <div>
 <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_system_routes")}</h1>
 <p className="text-muted-foreground">{t("admin_system_manage_your_navigation_routes")}</p>
 </div>
 <Button onClick={() => setCreateDialogOpen(true)}>
 <Plus className="w-4 h-4 mr-2" />{t("admin_system_add_route")}</Button>
 </div>

 <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
 {routes.map(route => {
 const routeType = ROUTE_TYPES.find(t => t.value === route.type);
 const Icon = routeType?.icon || Navigation;
 return <Card key={route.id} className="animate-in fade-in slide-in-from-bottom-4 duration-700 relative">
 <CardHeader className="pb-3">
 <div className="flex items-center justify-between">
 <div className="flex items-center gap-2">
 <Icon className="w-5 h-5" />
 <CardTitle className="text-lg">{route.name}</CardTitle>
 </div>
 <div className="flex gap-1">
 <Button variant="ghost" size="sm" onClick={() => toggleVisibility(route)}>
 {route.isVisible ? <Eye className="w-4 h-4" /> : <EyeOff className="w-4 h-4" />}
 </Button>
 <Button variant="ghost" size="sm" onClick={() => openEditDialog(route)}>
 <Edit className="w-4 h-4" />
 </Button>
 <Button variant="ghost" size="sm" onClick={() => handleDelete(route.id)}>
 <Trash2 className="w-4 h-4" />
 </Button>
 </div>
 </div>
 <div className="flex gap-2">
 <Badge variant="secondary">
 {routeType?.label || route.type}
 </Badge>
 <Badge variant="outline">{route.provider}</Badge>
 {!route.isVisible && <Badge variant="destructive">{t("admin_system_hidden")}</Badge>}
 </div>
 </CardHeader>
 <CardContent>
 <div className="space-y-2">
 <div className="flex items-center gap-2 text-sm text-muted-foreground">
 <MapPin className="w-4 h-4" />{t("admin_system_from")}{route.startLocationId}
 </div>
 <div className="flex items-center gap-2 text-sm text-muted-foreground">
 <Navigation className="w-4 h-4" />{t("admin_system_to")}{route.endLocationId}
 </div>
 {route.distance && <div className="text-sm text-muted-foreground">{t("admin_system_distance")}{route.distance.toFixed(1)}{t("admin_system_miles")}</div>}
 {route.duration && <div className="text-sm text-muted-foreground">{t("admin_system_duration")}{Math.floor(route.duration / 60)}{t("admin_auto_m", "m")}{""}
 {route.duration % 60}{t("admin_auto_s", "s")}</div>}
 {route.tolls && <div className="text-sm text-muted-foreground">{t("admin_system_tolls")}{route.tolls.toFixed(2)}
 </div>}
 <div className="flex items-center gap-2">
 <div className="w-4 h-4 rounded-lg" style={{
 backgroundColor: route.color
 }} />
 <span className="text-sm text-muted-foreground">{t("admin_system_width")}{route.strokeWidth}{t("admin_system_px_opacity")}{route.opacity}
 </span>
 </div>
 <div className="flex gap-2 pt-2">
 <Button variant="outline" size="sm" onClick={() => exportRoute(route,"json")}>
 <Download className="w-4 h-4 mr-1" />{t("admin_system_json")}</Button>
 <Button variant="outline" size="sm" onClick={() => exportRoute(route,"gpx")}>
 <Download className="w-4 h-4 mr-1" />{t("admin_system_gpx")}</Button>
 <Button variant="outline" size="sm" onClick={() => exportRoute(route,"kml")}>
 <Download className="w-4 h-4 mr-1" />{t("admin_system_kml")}</Button>
 </div>
 </div>
 </CardContent>
 </Card>;
 })}
 </div>

 {/* Create Dialog */}
 <Dialog open={createDialogOpen} onOpenChange={setCreateDialogOpen}>
 <DialogContent className="sm:max-w-[600px]">
 <DialogHeader>
 <DialogTitle>{t("admin_system_create_route")}</DialogTitle>
 <DialogDescription>{t("admin_system_add_a_new_navigation")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid gap-2">
 <Label htmlFor="name">{t("admin_system_route_name")}</Label>
 <Input id="name" value={formData.name} onChange={e => setFormData({
 ...formData,
 name: e.target.value
 })} placeholder={t("admin_system_route_name")} />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="type">{t("admin_system_route_type")}</Label>
 <Select value={formData.type} onValueChange={value => setFormData({
 ...formData,
 type: value
 })}>
 <SelectTrigger>
 <SelectValue placeholder={t("admin_system_select_route_type")} />
 </SelectTrigger>
 <SelectContent>
 {ROUTE_TYPES.map(type => <SelectItem key={type.value} value={type.value}>
 <div className="flex items-center gap-2">
 <type.icon className="w-4 h-4" />
 {type.label}
 </div>
 </SelectItem>)}
 </SelectContent>
 </Select>
 </div>
 <div className="grid gap-2">
 <Label htmlFor="provider">{t("admin_system_map_provider")}</Label>
 <Select value={formData.provider} onValueChange={value => setFormData({
 ...formData,
 provider: value
 })}>
 <SelectTrigger>
 <SelectValue placeholder={t("admin_system_select_map_provider")} />
 </SelectTrigger>
 <SelectContent>
 {MAP_PROVIDERS.map(provider => <SelectItem key={provider.value} value={provider.value}>
 {provider.label}
 </SelectItem>)}
 </SelectContent>
 </Select>
 </div>
 <div className="grid gap-2">
 <Label htmlFor="startLocationId">{t("admin_system_start_location_id")}</Label>
 <Input id="startLocationId" value={formData.startLocationId} onChange={e => setFormData({
 ...formData,
 startLocationId: e.target.value
 })} placeholder={t("admin_system_start_location_id")} />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="endLocationId">{t("admin_system_end_location_id")}</Label>
 <Input id="endLocationId" value={formData.endLocationId} onChange={e => setFormData({
 ...formData,
 endLocationId: e.target.value
 })} placeholder={t("admin_system_end_location_id")} />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="waypoints">{t("admin_system_waypoints_json_array")}</Label>
 <Textarea id="waypoints" value={formData.waypoints} onChange={e => setFormData({
 ...formData,
 waypoints: e.target.value
 })} placeholder={t("admin_system_location1_location2")} rows={3} />
 </div>
 <div className="grid grid-cols-3 gap-4">
 <div className="grid gap-2">
 <Label htmlFor="color">{t("admin_system_color")}</Label>
 <Input id="color" type="color" value={formData.color} onChange={e => setFormData({
 ...formData,
 color: e.target.value
 })} />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="strokeWidth">{t("admin_system_stroke_width")}</Label>
 <Input id="strokeWidth" type="number" value={formData.strokeWidth} onChange={e => setFormData({
 ...formData,
 strokeWidth: parseInt(e.target.value)
 })} min="1" max="10" />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="opacity">{t("admin_system_opacity")}</Label>
 <Input id="opacity" type="number" value={formData.opacity} onChange={e => setFormData({
 ...formData,
 opacity: parseFloat(e.target.value)
 })} min="0" max="1" step="0.1" />
 </div>
 </div>
 <div className="flex items-center gap-2">
 <Switch id="isVisible" checked={formData.isVisible} onCheckedChange={checked => setFormData({
 ...formData,
 isVisible: checked
 })} />
 <Label htmlFor="isVisible">{t("admin_system_visible_on_map")}</Label>
 </div>
 </div>
 <DialogFooter>
 <Button variant="outline" onClick={() => setCreateDialogOpen(false)}>{t("admin_system_cancel")}</Button>
 <Button onClick={handleCreate}>{t("admin_system_create_route")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>

 {/* Edit Dialog */}
 <Dialog open={editDialogOpen} onOpenChange={setEditDialogOpen}>
 <DialogContent className="sm:max-w-[600px]">
 <DialogHeader>
 <DialogTitle>{t("admin_system_edit_route")}</DialogTitle>
 <DialogDescription>{t("admin_system_update_route_configuration")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid gap-2">
 <Label htmlFor="name">{t("admin_system_route_name")}</Label>
 <Input id="name" value={formData.name} onChange={e => setFormData({
 ...formData,
 name: e.target.value
 })} placeholder={t("admin_system_route_name")} />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="type">{t("admin_system_route_type")}</Label>
 <Select value={formData.type} onValueChange={value => setFormData({
 ...formData,
 type: value
 })}>
 <SelectTrigger>
 <SelectValue placeholder={t("admin_system_select_route_type")} />
 </SelectTrigger>
 <SelectContent>
 {ROUTE_TYPES.map(type => <SelectItem key={type.value} value={type.value}>
 <div className="flex items-center gap-2">
 <type.icon className="w-4 h-4" />
 {type.label}
 </div>
 </SelectItem>)}
 </SelectContent>
 </Select>
 </div>
 <div className="grid gap-2">
 <Label htmlFor="provider">{t("admin_system_map_provider")}</Label>
 <Select value={formData.provider} onValueChange={value => setFormData({
 ...formData,
 provider: value
 })}>
 <SelectTrigger>
 <SelectValue placeholder={t("admin_system_select_map_provider")} />
 </SelectTrigger>
 <SelectContent>
 {MAP_PROVIDERS.map(provider => <SelectItem key={provider.value} value={provider.value}>
 {provider.label}
 </SelectItem>)}
 </SelectContent>
 </Select>
 </div>
 <div className="grid gap-2">
 <Label htmlFor="startLocationId">{t("admin_system_start_location_id")}</Label>
 <Input id="startLocationId" value={formData.startLocationId} onChange={e => setFormData({
 ...formData,
 startLocationId: e.target.value
 })} placeholder={t("admin_system_start_location_id")} />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="endLocationId">{t("admin_system_end_location_id")}</Label>
 <Input id="endLocationId" value={formData.endLocationId} onChange={e => setFormData({
 ...formData,
 endLocationId: e.target.value
 })} placeholder={t("admin_system_end_location_id")} />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="waypoints">{t("admin_system_waypoints_json_array")}</Label>
 <Textarea id="waypoints" value={formData.waypoints} onChange={e => setFormData({
 ...formData,
 waypoints: e.target.value
 })} placeholder={t("admin_system_location1_location2")} rows={3} />
 </div>
 <div className="grid grid-cols-3 gap-4">
 <div className="grid gap-2">
 <Label htmlFor="color">{t("admin_system_color")}</Label>
 <Input id="color" type="color" value={formData.color} onChange={e => setFormData({
 ...formData,
 color: e.target.value
 })} />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="strokeWidth">{t("admin_system_stroke_width")}</Label>
 <Input id="strokeWidth" type="number" value={formData.strokeWidth} onChange={e => setFormData({
 ...formData,
 strokeWidth: parseInt(e.target.value)
 })} min="1" max="10" />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="opacity">{t("admin_system_opacity")}</Label>
 <Input id="opacity" type="number" value={formData.opacity} onChange={e => setFormData({
 ...formData,
 opacity: parseFloat(e.target.value)
 })} min="0" max="1" step="0.1" />
 </div>
 </div>
 <div className="flex items-center gap-2">
 <Switch id="isVisible" checked={formData.isVisible} onCheckedChange={checked => setFormData({
 ...formData,
 isVisible: checked
 })} />
 <Label htmlFor="isVisible">{t("admin_system_visible_on_map")}</Label>
 </div>
 </div>
 <DialogFooter>
 <Button variant="outline" onClick={() => setEditDialogOpen(false)}>{t("admin_system_cancel")}</Button>
 <Button onClick={handleUpdate}>{t("admin_system_update_route")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </div>
 </div>;
}