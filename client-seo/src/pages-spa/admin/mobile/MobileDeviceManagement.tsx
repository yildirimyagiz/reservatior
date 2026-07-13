"use client";
import { apiClient } from '@/lib/api/client';

import { t } from"i18next";
import { useTranslation } from"react-i18next";
import { useState } from"react";
import { PageShell } from"../../client/layout/PageShell";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from"@/components/ui/card";
import { Button } from"@/components/ui/button";
import { Badge } from"@/components/ui/badge";
import { Label } from"@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from"@/components/ui/dialog";
import { Tabs, TabsContent, TabsList, TabsTrigger } from"@/components/ui/tabs";
import { Switch } from"@/components/ui/switch";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { useToast } from"@/hooks/use-toast";
import { useQuery, useMutation, useQueryClient } from"@tanstack/react-query";
import { mobileDevicesApi } from"@/lib/api/mobile-devices";
import { Smartphone, Tablet, Monitor, Laptop, Watch, Activity, Wifi, Battery, MapPin, Shield, AlertTriangle, CheckCircle, XCircle, RefreshCw, Eye, Edit, MoreHorizontal, Ban, Lock, Unlock, Settings, Plus, Loader2 } from"lucide-react";
interface MobileDevice {
 id: string;
 userId: string;
 userName: string;
 deviceName: string;
 deviceType:"PHONE" |"TABLET" |"DESKTOP" |"LAPTOP" |"WATCH";
 platform:"IOS" |"ANDROID" |"WINDOWS" |"MACOS" |"LINUX";
 osVersion: string;
 appVersion: string;
 deviceId: string;
 pushToken?: string;
 lastActive: string;
 isActive: boolean;
 isTrusted: boolean;
 location?: {
 latitude: number;
 longitude: number;
 address: string;
 };
 batteryLevel?: number;
 networkType:"WIFI" |"CELLULAR" |"NONE";
 ipAddress: string;
 createdAt: string;
 lastSync: string;
 securityStatus:"SECURE" |"WARNING" |"COMPROMISED";
 permissions: string[];
}
interface DevicePolicy {
 id: string;
 name: string;
 description: string;
 type:"SECURITY" |"ACCESS" |"DATA" |"NOTIFICATIONS";
 isActive: boolean;
 platforms: string[];
 settings: Record<string, any>;
 createdAt: string;
 updatedAt: string;
}
const MOCK_DEVICES: MobileDevice[] = [{
 id:"1",
 userId:"user-1",
 userName:"John Doe",
 deviceName:"iPhone 14 Pro",
 deviceType:"PHONE",
 platform:"IOS",
 osVersion:"17.2.1",
 appVersion:"2.1.0",
 deviceId:"ios-abc123-def456",
 pushToken:"apns-token-123",
 lastActive:"2024-03-28T10:30:00Z",
 isActive: true,
 isTrusted: true,
 location: {
 latitude: 40.7128,
 longitude: -74.0060,
 address:"New York, NY, USA"
 },
 batteryLevel: 85,
 networkType:"WIFI",
 ipAddress:"192.168.1.100",
 createdAt:"2024-03-15",
 lastSync:"2024-03-28T10:25:00Z",
 securityStatus:"SECURE",
 permissions: ["location","notifications","camera","microphone"]
}, {
 id:"2",
 userId:"user-2",
 userName:"Jane Smith",
 deviceName:"Samsung Galaxy S23",
 deviceType:"PHONE",
 platform:"ANDROID",
 osVersion:"14.0",
 appVersion:"2.1.0",
 deviceId:"android-xyz789-uvw012",
 pushToken:"fcm-token-456",
 lastActive:"2024-03-28T09:45:00Z",
 isActive: true,
 isTrusted: true,
 location: {
 latitude: 34.0522,
 longitude: -118.2437,
 address:"Los Angeles, CA, USA"
 },
 batteryLevel: 62,
 networkType:"CELLULAR",
 ipAddress:"192.168.1.101",
 createdAt:"2024-03-10",
 lastSync:"2024-03-28T09:40:00Z",
 securityStatus:"SECURE",
 permissions: ["location","notifications","camera"]
}, {
 id:"3",
 userId:"user-3",
 userName:"Bob Johnson",
 deviceName:"iPad Air",
 deviceType:"TABLET",
 platform:"IOS",
 osVersion:"17.1",
 appVersion:"2.0.5",
 deviceId:"ios-ipad-345678",
 pushToken:"apns-token-ipad-789",
 lastActive:"2024-03-27T18:30:00Z",
 isActive: false,
 isTrusted: false,
 networkType:"WIFI",
 ipAddress:"192.168.1.102",
 createdAt:"2024-03-05",
 lastSync:"2024-03-27T18:25:00Z",
 securityStatus:"WARNING",
 permissions: ["notifications","camera"]
}, {
 id:"4",
 userId:"user-4",
 userName:"Alice Brown",
 deviceName:"MacBook Pro",
 deviceType:"LAPTOP",
 platform:"MACOS",
 osVersion:"14.2.1",
 appVersion:"2.1.0",
 deviceId:"macos-mbp-901234",
 lastActive:"2024-03-28T08:15:00Z",
 isActive: true,
 isTrusted: true,
 networkType:"WIFI",
 ipAddress:"192.168.1.103",
 createdAt:"2024-03-20",
 lastSync:"2024-03-28T08:10:00Z",
 securityStatus:"SECURE",
 permissions: ["notifications","camera","microphone","location"]
}];
const MOCK_POLICIES: DevicePolicy[] = [{
 id:"1",
 name:"Mobile Security Policy",
 description: t("admin_mobile_enforce_security_requirements_for"),
 type:"SECURITY",
 isActive: true,
 platforms: ["IOS","ANDROID"],
 settings: {
 requirePasscode: true,
 minPasscodeLength: 6,
 requireBiometric: false,
 autoLockMinutes: 5,
 allowJailbreak: false,
 allowRoot: false
 },
 createdAt:"2024-03-01",
 updatedAt:"2024-03-25"
}, {
 id:"2",
 name:"Data Access Policy",
 description: t("admin_mobile_control_data_access_on"),
 type:"DATA",
 isActive: true,
 platforms: ["IOS","ANDROID","MACOS","WINDOWS"],
 settings: {
 allowOfflineAccess: true,
 syncInterval: 30,
 maxOfflineDays: 7,
 encryptLocalData: true,
 allowScreenshots: true
 },
 createdAt:"2024-03-01",
 updatedAt:"2024-03-20"
}];
export default function MobileDeviceManagement() {
 const {
 t
 } = useTranslation();
 const {
 toast
 } = useToast();
 const queryClient = useQueryClient();
 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/unknown/${id}`),
 onSuccess: () => {
 toast({ title:"Deleted", description:"Record deleted successfully" });
 queryClient.invalidateQueries();
 },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });
 

 const [policies, setPolicies] = useState<DevicePolicy[]>(MOCK_POLICIES);
 const [activeTab, setActiveTab] = useState("devices");
 const [selectedDevice, setSelectedDevice] = useState<MobileDevice | null>(null);
 const [filterPlatform, setFilterPlatform] = useState("all");
 const [filterStatus, setFilterStatus] = useState("all");

 const { data: devicesData, isLoading, refetch } = useQuery({
 queryKey: ['mobileDevices'],
 queryFn: async () => {
 const res = await mobileDevicesApi.getAll();
 const apiDevices = Array.isArray(res) ? res : ((res as any).data || []);
 
 // Map API devices to UI devices, supplementing missing fields with defaults/mock data
 return apiDevices.map((d: any) => ({
 id: d.id,
 userId: d.userId,
 userName: d.user?.name || 'Unknown User',
 deviceName: d.model || 'Unknown Device',
 deviceType: (d.platform === 'IOS' || d.platform === 'ANDROID') ? 'PHONE' : 'DESKTOP',
 platform: d.platform as any,
 osVersion: d.osVersion || 'Unknown',
 appVersion: d.appVersion || 'Unknown',
 deviceId: d.deviceId,
 ipAddress: '192.168.1.1',
 lastLocation: 'Unknown',
 lastSyncAt: d.lastSeenAt || d.createdAt,
 isActive: d.isActive,
 isTrusted: true,
 securityStatus: 'SECURE',
 batteryLevel: 100,
 networkType: 'WIFI',
 })) as MobileDevice[];
 }
 });

 const devices = devicesData || MOCK_DEVICES;

 const updateDeviceMutation = useMutation({
 mutationFn: async ({ id, data }: { id: string, data: any }) => {
 return await mobileDevicesApi.update(id, data);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['mobileDevices'] });
 },
 onError: (error: any) => {
 toast({
 title: t("admin_mobile_error","Hata"),
 description: error.message,
 variant:"destructive"
 });
 }
 });

 const deleteDeviceMutation = useMutation({
 mutationFn: async (id: string) => {
 return await mobileDevicesApi.delete(id);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['mobileDevices'] });
 }
 });
 const getDeviceIcon = (deviceType: string) => {
 switch (deviceType) {
 case"PHONE":
 return <Smartphone className="w-4 h-4" />;
 case"TABLET":
 return <Tablet className="w-4 h-4" />;
 case"DESKTOP":
 return <Monitor className="w-4 h-4" />;
 case"LAPTOP":
 return <Laptop className="w-4 h-4" />;
 case"WATCH":
 return <Watch className="w-4 h-4" />;
 default:
 return <Smartphone className="w-4 h-4" />;
 }
 };
 const getPlatformIcon = (platform: string) => {
 switch (platform) {
 case"IOS":
 return <Smartphone className="w-4 h-4 text-slate-600" />;
 case"ANDROID":
 return <Smartphone className="w-4 h-4 text-green-600" />;
 case"WINDOWS":
 return <Monitor className="w-4 h-4 text-slate-600" />;
 case"MACOS":
 return <Laptop className="w-4 h-4 text-muted-foreground" />;
 case"LINUX":
 return <Monitor className="w-4 h-4 text-orange-600" />;
 default:
 return <Smartphone className="w-4 h-4 text-muted-foreground" />;
 }
 };
 const getSecurityColor = (status: string) => {
 switch (status) {
 case"SECURE":
 return"bg-green-100 text-green-700";
 case"WARNING":
 return"bg-yellow-100 text-yellow-700";
 case"COMPROMISED":
 return"bg-red-100 text-red-700";
 default:
 return"bg-card text-slate-300";
 }
 };
 const getNetworkIcon = (networkType: string) => {
 switch (networkType) {
 case"WIFI":
 return <Wifi className="w-4 h-4 text-slate-600" />;
 case"CELLULAR":
 return <Activity className="w-4 h-4 text-green-600" />;
 case"NONE":
 return <Wifi className="w-4 h-4 text-muted-foreground" />;
 default:
 return <Wifi className="w-4 h-4 text-muted-foreground" />;
 }
 };
 const getBatteryColor = (level: number) => {
 if (level > 60) return"text-green-600";
 if (level > 30) return"text-yellow-600";
 return"text-red-600";
 };
 const toggleDeviceStatus = (device: MobileDevice) => {
 updateDeviceMutation.mutate({
 id: device.id,
 data: { isActive: !device.isActive }
 });
 toast({
 title: t("admin_mobile_device_updated"),
 description: t("admin_mobile_device_status_has_been")
 });
 };
 const toggleDeviceTrust = (deviceId: string) => {
 // Note: isTrusted is not on backend yet, we simulate it
 toast({
 title: t("admin_mobile_trust_status_updated"),
 description: t("admin_mobile_device_trust_status_has")
 });
 };
 const revokeDevice = (device: MobileDevice) => {
 deleteDeviceMutation.mutate(device.id);
 toast({
 title: t("admin_mobile_device_revoked"),
 description: t("admin_mobile_device_access_has_been")
 });
 };
 const syncDevice = () => {
 refetch();
 toast({
 title: t("admin_mobile_sync_started"),
 description: t("admin_mobile_device_synchronization_has_been")
 });
 };
 const filteredDevices = devices.filter(device => {
 const matchesPlatform = filterPlatform ==="all" || device.platform === filterPlatform;
 const matchesStatus = filterStatus ==="all" || filterStatus ==="active" && device.isActive || filterStatus ==="inactive" && !device.isActive || filterStatus ==="trusted" && device.isTrusted;
 return matchesPlatform && matchesStatus;
 });
 const stats = {
 totalDevices: devices.length,
 activeDevices: devices.filter(d => d.isActive).length,
 trustedDevices: devices.filter(d => d.isTrusted).length,
 secureDevices: devices.filter(d => d.securityStatus ==="SECURE").length,
 warningDevices: devices.filter(d => d.securityStatus ==="WARNING").length,
 compromisedDevices: devices.filter(d => d.securityStatus ==="COMPROMISED").length,
 iosDevices: devices.filter(d => d.platform ==="IOS").length,
 androidDevices: devices.filter(d => d.platform ==="ANDROID").length
 };
 return <PageShell title={t("admin_mobile_mobile_device_management")} description={t("admin_mobile_manage_and_monitor_mobile")}>
 <div className="space-y-6">
 {/* Stats Cards */}
 <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
 <Card>
 <CardContent className="p-4">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-sm font-medium text-muted-foreground">{t("admin_mobile_total_devices")}</p>
 <p className="text-2xl font-bold">{stats.totalDevices}</p>
 <p className="text-xs text-muted-foreground">{t("admin_mobile_all_platforms")}</p>
 </div>
 <Smartphone className="w-8 h-8 text-slate-600" />
 </div>
 </CardContent>
 </Card>
 <Card>
 <CardContent className="p-4">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-sm font-medium text-muted-foreground">{t("admin_mobile_active_devices")}</p>
 <p className="text-2xl font-bold text-green-600">{stats.activeDevices}</p>
 <p className="text-xs text-muted-foreground">{t("admin_mobile_currently_online")}</p>
 </div>
 <Activity className="w-8 h-8 text-green-600" />
 </div>
 </CardContent>
 </Card>
 <Card>
 <CardContent className="p-4">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-sm font-medium text-muted-foreground">{t("admin_mobile_security_issues")}</p>
 <p className="text-2xl font-bold text-orange-600">{stats.warningDevices + stats.compromisedDevices}</p>
 <p className="text-xs text-orange-500">{t("admin_mobile_requires_attention")}</p>
 </div>
 <AlertTriangle className="w-8 h-8 text-orange-600" />
 </div>
 </CardContent>
 </Card>
 <Card>
 <CardContent className="p-4">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-sm font-medium text-muted-foreground">{t("admin_mobile_trusted_devices")}</p>
 <p className="text-2xl font-bold text-slate-600">{stats.trustedDevices}</p>
 <p className="text-xs text-muted-foreground">{t("admin_mobile_verified_devices")}</p>
 </div>
 <Shield className="w-8 h-8 text-slate-600" />
 </div>
 </CardContent>
 </Card>
 </div>

 {/* Filters and Actions */}
 <div className="flex flex-col sm:flex-row gap-4 items-start sm:items-center justify-between">
 <div className="flex flex-col sm:flex-row gap-4 flex-1">
 <Select value={filterPlatform} onValueChange={setFilterPlatform}>
 <SelectTrigger className="w-[150px]">
 <SelectValue placeholder={t("admin_mobile_platform")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="all">{t("admin_mobile_all_platforms")}</SelectItem>
 <SelectItem value="IOS">{t("admin_mobile_ios")}</SelectItem>
 <SelectItem value="ANDROID">{t("admin_mobile_android")}</SelectItem>
 <SelectItem value="MACOS">{t("admin_mobile_macos")}</SelectItem>
 <SelectItem value="WINDOWS">{t("admin_mobile_windows")}</SelectItem>
 </SelectContent>
 </Select>
 <Select value={filterStatus} onValueChange={setFilterStatus}>
 <SelectTrigger className="w-[150px]">
 <SelectValue placeholder={t("admin_mobile_status")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="all">{t("admin_mobile_all_status")}</SelectItem>
 <SelectItem value="active">{t("admin_mobile_active")}</SelectItem>
 <SelectItem value="inactive">{t("admin_mobile_inactive")}</SelectItem>
 <SelectItem value="trusted">{t("admin_mobile_trusted")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <Button onClick={() => toast({
 title: t("admin_mobile_policy_editor_coming_soon")
 })}>
 <Settings className="w-4 h-4 mr-2" />{t("admin_mobile_device_policies")}</Button>
 </div>

 {/* Tabs */}
 <Tabs value={activeTab} onValueChange={setActiveTab}>
 <TabsList className="grid w-full grid-cols-3">
 <TabsTrigger value="devices">{t("admin_mobile_devices")}</TabsTrigger>
 <TabsTrigger value="policies">{t("admin_mobile_policies")}</TabsTrigger>
 <TabsTrigger value="monitoring">{t("admin_mobile_monitoring")}</TabsTrigger>
 </TabsList>

 <TabsContent value="devices" className="space-y-6">
 <Card>
 <CardHeader>
 <CardTitle>{t("admin_mobile_registered_devices")}{filteredDevices.length})</CardTitle>
 <CardDescription>{t("admin_mobile_manage_and_monitor_all")}</CardDescription>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_mobile_device")}</TableHead>
 <TableHead>{t("admin_mobile_user")}</TableHead>
 <TableHead>{t("admin_mobile_platform")}</TableHead>
 <TableHead>{t("admin_mobile_status")}</TableHead>
 <TableHead>{t("admin_mobile_security")}</TableHead>
 <TableHead>{t("admin_mobile_last_active")}</TableHead>
 <TableHead>{t("admin_mobile_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {isLoading ? (
 <TableRow>
 <TableCell colSpan={8} className="text-center py-12 text-muted-foreground">
 <Loader2 className="w-6 h-6 animate-spin mx-auto mb-2" />
 {t("admin_mobile_loading","Yükleniyor...")}
 </TableCell>
 </TableRow>
 ) : filteredDevices.length === 0 ? (
 <TableRow>
 <TableCell colSpan={8} className="text-center py-12 text-muted-foreground">
 {t("admin_mobile_no_devices_found","Cihaz bulunamadı")}
 </TableCell>
 </TableRow>
 ) : (
 filteredDevices.map(device => <TableRow key={device.id}>
 <TableCell>
 <div className="flex items-center gap-3">
 {getDeviceIcon(device.deviceType)}
 <div>
 <div className="font-medium">{device.deviceName}</div>
 <div className="text-sm text-muted-foreground">
 {device.platform} {device.osVersion}{t("admin_mobile_app_v")}{device.appVersion}
 </div>
 </div>
 </div>
 </TableCell>
 <TableCell>
 <div>
 <div className="font-medium">{device.userName}</div>
 <div className="text-sm text-muted-foreground">{device.userId}</div>
 </div>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 {getPlatformIcon(device.platform)}
 <Badge variant="outline">{device.platform}</Badge>
 </div>
 </TableCell>
 <TableCell>
 <div className="space-y-1">
 <div className="flex items-center gap-2">
 <Switch checked={device.isActive} onCheckedChange={() => toggleDeviceStatus(device)} />
 <Badge variant={device.isActive ?"default" :"secondary"}>
 {device.isActive ?"Active" :"Inactive"}
 </Badge>
 </div>
 <div className="flex items-center gap-2">
 {device.isTrusted ? <Shield className="w-3 h-3 text-green-600" /> : <AlertTriangle className="w-3 h-3 text-yellow-600" />}
 <Badge variant={device.isTrusted ?"default" :"secondary"}>
 {device.isTrusted ?"Trusted" :"Untrusted"}
 </Badge>
 </div>
 </div>
 </TableCell>
 <TableCell>
 <Badge className={getSecurityColor(device.securityStatus)}>
 {device.securityStatus}
 </Badge>
 </TableCell>
 <TableCell>
 <div className="text-sm">
 <div>{new Date(device.lastActive).toLocaleDateString()}</div>
 <div className="text-muted-foreground">
 {new Date(device.lastActive).toLocaleTimeString()}
 </div>
 </div>
 </TableCell>
 <TableCell>
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="ghost" size="sm">
 <MoreHorizontal className="w-4 h-4" />
 </Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent>
 <DropdownMenuItem onClick={() => setSelectedDevice(device)}>
 <Eye className="w-4 h-4 mr-2" />{t("admin_mobile_view_details")}</DropdownMenuItem>
 <DropdownMenuItem onClick={() => syncDevice()}>
 <RefreshCw className="w-4 h-4 mr-2" />{t("admin_mobile_sync_device")}</DropdownMenuItem>
 <DropdownMenuItem onClick={() => toggleDeviceStatus(device)}>
 {device.isActive ? <Ban className="w-4 h-4 mr-2" /> : <CheckCircle className="w-4 h-4 mr-2" />}
 {device.isActive ? t("admin_mobile_suspend_access") : t("admin_mobile_activate_access")}
 </DropdownMenuItem>
 <DropdownMenuItem onClick={() => toggleDeviceTrust(device.id)}>
 {device.isTrusted ? <Unlock className="w-4 h-4 mr-2" /> : <Lock className="w-4 h-4 mr-2" />}
 {device.isTrusted ? t("admin_mobile_revoke_trust") : t("admin_mobile_mark_as_trusted")}
 </DropdownMenuItem>
 <DropdownMenuItem className="text-red-600" onClick={() => revokeDevice(device)}>
 <XCircle className="w-4 h-4 mr-2" />{t("admin_mobile_wipe_device")}
 </DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 </TableCell>
 </TableRow>)
 )}
 </TableBody>
 </Table>
 </CardContent>
 </Card>
 </TabsContent>

 <TabsContent value="policies" className="space-y-6">
 <div className="flex justify-between items-center">
 <h3 className="text-lg font-semibold">{t("admin_mobile_device_policies")}</h3>
 <Button>
 <Plus className="w-4 h-4 mr-2" />{t("admin_mobile_add_policy")}</Button>
 </div>

 <div className="space-y-4">
 {policies.map(policy => <Card key={policy.id}>
 <CardContent className="p-6">
 <div className="flex items-center justify-between">
 <div className="flex-1">
 <div className="flex items-center gap-3 mb-2">
 <h4 className="font-medium">{policy.name}</h4>
 <Badge variant="outline">{policy.type}</Badge>
 <Badge variant={policy.isActive ?"default" :"secondary"}>
 {policy.isActive ?"Active" :"Inactive"}
 </Badge>
 </div>
 <p className="text-sm text-muted-foreground mb-3">{policy.description}</p>
 <div className="flex flex-wrap gap-2">
 {policy.platforms.map((platform, index) => <Badge key={index} variant="outline" className="text-xs">
 {platform}
 </Badge>)}
 </div>
 </div>
 <div className="flex items-center gap-3">
 <Switch checked={policy.isActive} onCheckedChange={() => {
 setPolicies(policies.map(p => p.id === policy.id ? {
 ...p,
 isActive: !p.isActive
 } : p));
 }} />
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="ghost" size="sm">
 <MoreHorizontal className="w-4 h-4" />
 </Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent>
 <DropdownMenuItem>
 <Edit className="w-4 h-4 mr-2" />{t("admin_mobile_edit_policy")}</DropdownMenuItem>
 <DropdownMenuItem>
 <Eye className="w-4 h-4 mr-2" />{t("admin_mobile_view_settings")}</DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 </div>
 </div>
 </CardContent>
 </Card>)}
 </div>
 </TabsContent>

 <TabsContent value="monitoring" className="space-y-6">
 <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
 <Card>
 <CardHeader>
 <CardTitle>{t("admin_mobile_platform_distribution")}</CardTitle>
 <CardDescription>{t("admin_mobile_device_platform_breakdown")}</CardDescription>
 </CardHeader>
 <CardContent>
 <div className="space-y-4">
 <div className="flex items-center justify-between">
 <div className="flex items-center gap-2">
 <Smartphone className="w-4 h-4 text-slate-600" />
 <span>{t("admin_mobile_ios")}</span>
 </div>
 <div className="flex items-center gap-2">
 <div className="w-32 bg-card rounded-full h-2">
 <div className="bg-slate-600 h-2 rounded-full" style={{
 width: `${stats.iosDevices / stats.totalDevices * 100}%`
 }}></div>
 </div>
 <span className="text-sm font-medium">{stats.iosDevices}</span>
 </div>
 </div>
 <div className="flex items-center justify-between">
 <div className="flex items-center gap-2">
 <Smartphone className="w-4 h-4 text-green-600" />
 <span>{t("admin_mobile_android")}</span>
 </div>
 <div className="flex items-center gap-2">
 <div className="w-32 bg-card rounded-full h-2">
 <div className="bg-green-600 h-2 rounded-full" style={{
 width: `${stats.androidDevices / stats.totalDevices * 100}%`
 }}></div>
 </div>
 <span className="text-sm font-medium">{stats.androidDevices}</span>
 </div>
 </div>
 <div className="flex items-center justify-between">
 <div className="flex items-center gap-2">
 <Laptop className="w-4 h-4 text-muted-foreground" />
 <span>{t("admin_mobile_desktop")}</span>
 </div>
 <div className="flex items-center gap-2">
 <div className="w-32 bg-card rounded-full h-2">
 <div className="bg-white/10 h-2 rounded-full" style={{
 width: `${(stats.totalDevices - stats.iosDevices - stats.androidDevices) / stats.totalDevices * 100}%`
 }}></div>
 </div>
 <span className="text-sm font-medium">{stats.totalDevices - stats.iosDevices - stats.androidDevices}</span>
 </div>
 </div>
 </div>
 </CardContent>
 </Card>

 <Card>
 <CardHeader>
 <CardTitle>{t("admin_mobile_security_status")}</CardTitle>
 <CardDescription>{t("admin_mobile_device_security_overview")}</CardDescription>
 </CardHeader>
 <CardContent>
 <div className="space-y-4">
 <div className="flex items-center justify-between">
 <div className="flex items-center gap-2">
 <CheckCircle className="w-4 h-4 text-green-600" />
 <span>{t("admin_mobile_secure")}</span>
 </div>
 <Badge className="bg-green-100 text-green-700">{stats.secureDevices}</Badge>
 </div>
 <div className="flex items-center justify-between">
 <div className="flex items-center gap-2">
 <AlertTriangle className="w-4 h-4 text-yellow-600" />
 <span>{t("admin_mobile_warning")}</span>
 </div>
 <Badge className="bg-yellow-100 text-yellow-700">{stats.warningDevices}</Badge>
 </div>
 <div className="flex items-center justify-between">
 <div className="flex items-center gap-2">
 <XCircle className="w-4 h-4 text-red-600" />
 <span>{t("admin_mobile_compromised")}</span>
 </div>
 <Badge className="bg-red-100 text-red-700">{stats.compromisedDevices}</Badge>
 </div>
 </div>
 </CardContent>
 </Card>
 </div>
 </TabsContent>
 </Tabs>
 </div>

 {/* Device Details Dialog */}
 <Dialog open={!!selectedDevice} onOpenChange={() => setSelectedDevice(null)}>
 <DialogContent className="max-w-2xl">
 <DialogHeader>
 <DialogTitle>{t("admin_mobile_device_details")}</DialogTitle>
 <DialogDescription>{t("admin_mobile_complete_device_information_and")}</DialogDescription>
 </DialogHeader>
 {selectedDevice && <div className="py-4 space-y-6">
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_mobile_device_name")}</Label>
 <div className="font-medium">{selectedDevice.deviceName}</div>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_mobile_device_type")}</Label>
 <div className="flex items-center gap-2">
 {getDeviceIcon(selectedDevice.deviceType)}
 <span>{selectedDevice.deviceType}</span>
 </div>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_mobile_platform")}</Label>
 <div className="flex items-center gap-2">
 {getPlatformIcon(selectedDevice.platform)}
 <span>{selectedDevice.platform} {selectedDevice.osVersion}</span>
 </div>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_mobile_app_version")}</Label>
 <div className="font-medium">{selectedDevice.appVersion}</div>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_mobile_device_id")}</Label>
 <div className="font-mono text-sm">{selectedDevice.deviceId}</div>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_mobile_ip_address")}</Label>
 <div className="font-mono text-sm">{selectedDevice.ipAddress}</div>
 </div>
 </div>

 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_mobile_network_type")}</Label>
 <div className="flex items-center gap-2">
 {getNetworkIcon(selectedDevice.networkType)}
 <span>{selectedDevice.networkType}</span>
 </div>
 </div>
 {selectedDevice.batteryLevel && <div className="space-y-2">
 <Label>{t("admin_mobile_battery_level")}</Label>
 <div className="flex items-center gap-2">
 <Battery className={`w-4 h-4 ${getBatteryColor(selectedDevice.batteryLevel)}`} />
 <span className={getBatteryColor(selectedDevice.batteryLevel)}>
 {selectedDevice.batteryLevel}%
 </span>
 </div>
 </div>}
 <div className="space-y-2">
 <Label>{t("admin_mobile_security_status")}</Label>
 <Badge className={getSecurityColor(selectedDevice.securityStatus)}>
 {selectedDevice.securityStatus}
 </Badge>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_mobile_trust_status")}</Label>
 <Badge variant={selectedDevice.isTrusted ?"default" :"secondary"}>
 {selectedDevice.isTrusted ?"Trusted" :"Untrusted"}
 </Badge>
 </div>
 </div>

 {selectedDevice.location && <div className="space-y-2">
 <Label>{t("admin_mobile_last_known_location")}</Label>
 <div className="flex items-center gap-2 p-3 bg-card rounded-lg">
 <MapPin className="w-4 h-4 text-slate-600" />
 <span>{selectedDevice.location.address}</span>
 </div>
 </div>}

 <div className="space-y-2">
 <Label>{t("admin_mobile_permissions")}</Label>
 <div className="flex flex-wrap gap-2">
 {selectedDevice.permissions.map((permission, index) => <Badge key={index} variant="outline" className="text-xs">
 {permission}
 </Badge>)}
 </div>
 </div>
 </div>}
 <DialogFooter>
 <Button variant="outline" onClick={() => setSelectedDevice(null)}>{t("admin_mobile_close")}</Button>
 <Button onClick={() => selectedDevice && syncDevice()}>
 <RefreshCw className="w-4 h-4 mr-2" />{t("admin_mobile_sync_device")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </PageShell>;
}