"use client";

import { t } from"i18next";
import { useState } from"react";
import { useTranslation } from"react-i18next";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Badge } from"@/components/ui/badge";
import { Button } from"@/components/ui/button";
import { Input } from"@/components/ui/input";
import { Tabs, TabsContent, TabsList, TabsTrigger } from"@/components/ui/tabs";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Switch } from"@/components/ui/switch";
import { Users, Shield, Eye, Edit, Plus, Search, Unlock, AlertTriangle, CheckCircle, Clock, UserCheck, UserX, Mail, Phone, MapPin, Globe, Bell, Monitor, Smartphone, Tablet, Trash2, Ban, Crown } from"lucide-react";
import { useToast } from"@/hooks/use-toast";
import { apiClient } from"@/lib/api/client";
import { useQuery, useMutation, useQueryClient } from"@tanstack/react-query";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from"@/components/ui/dialog";
import { Label } from"@/components/ui/label";
import { usersApi } from"@/lib/api/users";

interface UserPermission {
 id: string;
 userId: string;
 userName: string;
 userEmail: string;
 role: string;
 permissions: {
 module: string;
 actions: ('READ' | 'WRITE' | 'DELETE' | 'ADMIN')[];
 }[];
 grantedBy: string;
 grantedAt: string;
 expiresAt?: string;
 isActive: boolean;
 lastUsed?: string;
 restrictions: {
 ipWhitelist: string[];
 timeRestrictions: {
 start: string;
 end: string;
 days: string[];
 }[];
 locationRestrictions: string[];
 };
}
interface UserPreference {
 id: string;
 userId: string;
 userName: string;
 category: 'UI' | 'NOTIFICATIONS' | 'PRIVACY' | 'SECURITY' | 'ACCESSIBILITY';
 settings: {
 theme: 'LIGHT' | 'DARK' | 'AUTO';
 language: string;
 timezone: string;
 dateFormat: string;
 currency: string;
 emailNotifications: boolean;
 pushNotifications: boolean;
 smsNotifications: boolean;
 twoFactorEnabled: boolean;
 sessionTimeout: number;
 autoLock: boolean;
 fontSize: 'SMALL' | 'MEDIUM' | 'LARGE';
 highContrast: boolean;
 screenReader: boolean;
 };
 devicePreferences: {
 deviceId: string;
 deviceType: 'DESKTOP' | 'MOBILE' | 'TABLET';
 lastActive: string;
 pushToken?: string;
 biometricEnabled: boolean;
 }[];
 updatedAt: string;
 updatedBy: string;
}
interface Role {
 id: string;
 name: string;
 description: string;
 level: number;
 permissions: string[];
 userCount: number;
 isActive: boolean;
 createdAt: string;
 systemRole: boolean;
}
interface AccessLog {
 id: string;
 userId: string;
 userName: string;
 action: string;
 resource: string;
 ipAddress: string;
 userAgent: string;
 location: {
 country: string;
 city: string;
 };
 timestamp: string;
 success: boolean;
 errorMessage?: string;
 sessionId: string;
}
interface SecurityAlert {
 id: string;
 userId: string;
 userName: string;
 type: 'FAILED_LOGIN' | 'SUSPICIOUS_ACTIVITY' | 'PERMISSION_ESCALATION' | 'DATA_ACCESS' | 'BRUTE_FORCE';
 severity: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL';
 description: string;
 ipAddress: string;
 timestamp: string;
 status: 'OPEN' | 'INVESTIGATING' | 'RESOLVED' | 'FALSE_POSITIVE';
 assignedTo?: string;
 resolvedAt?: string;
 resolution?: string;
}
export default function UserManagement() {
 const { toast } = useToast();
 const queryClient = useQueryClient();
 const [editingId, setEditingId] = useState<string | null>(null);
 const [isEditOpen, setIsEditOpen] = useState(false);
 const [editFormData, setEditFormData] = useState({
 email: '',
 name: '',
 phone: '',
 locale: 'en-US',
 timezone: 'America/New_York'
 });

 const updateMutation = useMutation({
 mutationFn: async (data: any) => apiClient.put(`/admin/usermanagement/${data.id}`, data),
 onSuccess: () => { toast({ title:"Updated", description:"Record updated successfully" }); queryClient.invalidateQueries(); setEditingId(null); },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });

 const openEditDialog = (permission: UserPermission) => {
 setEditingId(permission.id);
 setEditFormData({
 email: permission.userEmail,
 name: permission.userName,
 phone: '',
 locale: 'en-US',
 timezone: 'America/New_York'
 });
 setIsEditOpen(true);
 };

 const handleEditSubmit = () => {
 updateMutation.mutate({
 id: editingId,
 ...editFormData
 });
 setIsEditOpen(false);
 };

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/admin/usermanagement/${id}`),
 onSuccess: () => { toast({ title:"Deleted", description:"Record deleted successfully" }); queryClient.invalidateQueries(); },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });
 
 const [isAddOpen, setIsAddOpen] = useState(false);
 const [searchTerm, setSearchTerm] = useState("");

 const [newUser, setNewUser] = useState({
 email: '',
 name: '',
 phone: '',
 locale: 'en-US',
 timezone: 'America/New_York'
 });

 const createMutation = useMutation({
 mutationFn: async (data: any) => {
 return usersApi.create(data);
 },
 onSuccess: () => {
 setIsAddOpen(false);
 toast({ title:"Success", description:"User created successfully" });
 // Should refetch data but there's a lot going on in this component
 },
 onError: (err: any) => {
 toast({ title:"Error", description: err.message ||"Failed to create user", variant:"destructive" });
 }
 });
 
 const [roleFilter, setRoleFilter] = useState("ALL");
 const [statusFilter, setStatusFilter] = useState("ALL");
 const { t } = useTranslation();

 const fetchUserManagementData = async (): Promise<{ permissions: UserPermission[], preferences: UserPreference[], roles: Role[], accessLogs: AccessLog[], securityAlerts: SecurityAlert[] }> => {
 try {
 const [permissionsRes, preferencesRes, rolesRes, logsRes, alertsRes] = await Promise.all([
 apiClient.get('/admin/users/permissions') as Promise<{ data: UserPermission[] }>,
 apiClient.get('/admin/users/preferences') as Promise<{ data: UserPreference[] }>,
 apiClient.get('/admin/users/roles') as Promise<{ data: Role[] }>,
 apiClient.get('/admin/users/access-logs') as Promise<{ data: AccessLog[] }>,
 apiClient.get('/admin/users/security-alerts') as Promise<{ data: SecurityAlert[] }>
 ]);
 return {
 permissions: permissionsRes.data || [],
 preferences: preferencesRes.data || [],
 roles: rolesRes.data || [],
 accessLogs: logsRes.data || [],
 securityAlerts: alertsRes.data || []
 };
 } catch (error) {
 toast({
 title: t("admin_users_error"),
 description: t("admin_users_failed_to_fetch_user"),
 variant:"destructive"
 });
 return {
 permissions: [],
 preferences: [],
 roles: [],
 accessLogs: [],
 securityAlerts: []
 };
 }
 };

 const { data, isLoading: loading } = useQuery({
 queryKey: ['userManagementData'],
 queryFn: fetchUserManagementData
 });

 const permissions = data?.permissions || [];
 const preferences = data?.preferences || [];
 const roles = data?.roles || [];
 const accessLogs = data?.accessLogs || [];
 const securityAlerts = data?.securityAlerts || [];
 const getSeverityColor = (severity: string) => {
 switch (severity) {
 case 'LOW': return 'bg-yellow-500';
 case 'MEDIUM': return 'bg-orange-500';
 case 'HIGH': return 'bg-red-500';
 case 'CRITICAL': return 'bg-red-600';
 default: return 'bg-white/10';
 }
 };

 const getLocalizedType = (type: string) => {
 const map: Record<string, string> = {
 'FAILED_LOGIN': t('admin_users_type_failed_login', 'Başarısız Giriş'),
 'SUSPICIOUS_ACTIVITY': t('admin_users_type_suspicious', 'Şüpheli Aktivite'),
 'PERMISSION_ESCALATION': t('admin_users_type_permission_escalation', 'Yetki Yükseltme'),
 'DATA_ACCESS': t('admin_users_type_data_access', 'Veri Erişimi'),
 'BRUTE_FORCE': t('admin_users_type_brute_force', 'Kaba Kuvvet Saldırısı')
 };
 return map[type] || type.replace('_', ' ');
 };

 const getLocalizedSeverity = (severity: string) => {
 const map: Record<string, string> = {
 'LOW': t('admin_users_severity_low', 'Düşük'),
 'MEDIUM': t('admin_users_severity_medium', 'Orta'),
 'HIGH': t('admin_users_severity_high', 'Yüksek'),
 'CRITICAL': t('admin_users_severity_critical', 'Kritik')
 };
 return map[severity] || severity;
 };

 const getLocalizedStatus = (status: string) => {
 const map: Record<string, string> = {
 'OPEN': t('admin_users_status_open', 'Açık'),
 'INVESTIGATING': t('admin_users_status_investigating', 'İnceleniyor'),
 'RESOLVED': t('admin_users_status_resolved', 'Çözüldü'),
 'FALSE_POSITIVE': t('admin_users_status_false_positive', 'Hatalı Alarm')
 };
 return map[status] || status.replace('_', ' ');
 };
const getRoleLevelColor = (level: number) => {
 if (level >= 90) return 'bg-muted0';
 if (level >= 70) return 'bg-red-500';
 if (level >= 50) return 'bg-orange-500';
 if (level >= 30) return 'bg-yellow-500';
 return 'bg-green-500';
 };
 const filteredPermissions = permissions.filter(permission => {
 const matchesSearch = permission.userName.toLowerCase().includes(searchTerm.toLowerCase()) || permission.userEmail.toLowerCase().includes(searchTerm.toLowerCase()) || permission.role.toLowerCase().includes(searchTerm.toLowerCase());
 const matchesRole = roleFilter ==="ALL" || permission.role === roleFilter;
 const matchesStatus = statusFilter ==="ALL" || statusFilter ==="ACTIVE" && permission.isActive || statusFilter ==="INACTIVE" && !permission.isActive;
 return matchesSearch && matchesRole && matchesStatus;
 });
 const activeUsers = permissions.filter(p => p.isActive).length;
 const criticalAlerts = securityAlerts.filter(a => a.severity === 'CRITICAL' && a.status === 'OPEN').length;
 const totalRoles = roles.length;
 const recentLogins = accessLogs.filter(log => log.action === 'LOGIN' && log.success && new Date(log.timestamp) > new Date(Date.now() - 24 * 60 * 60 * 1000)).length;
 if (loading) {
 return <div className="p-6 space-y-6 min-h-screen">
 <div className="flex items-center justify-center h-64">
 <Users className="h-8 w-8 animate-spin" />
 </div>
 </div>;
 }
 return <div className="p-6 space-y-6 min-h-screen">
 <div className="space-y-6">
 {/* Overview Cards */}
 <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium text-foreground">{t('admin_users_activeUsers')}</CardTitle>
 <UserCheck className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-green-600">{activeUsers}</div>
 <p className="text-xs text-muted-foreground">
 {t('admin_users_ofTotal', {
 count: permissions.length
 })}
 </p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium text-foreground">{t('admin_users_criticalAlerts')}</CardTitle>
 <AlertTriangle className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-red-600">{criticalAlerts}</div>
 <p className="text-xs text-muted-foreground">
 {t('admin_users_immediateAttention')}
 </p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium text-foreground">{t('admin_users_totalRoles')}</CardTitle>
 <Shield className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold">{totalRoles}</div>
 <p className="text-xs text-muted-foreground">
 {t('admin_users_activeCount', {
 count: roles.filter(r => r.isActive).length
 })}
 </p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium text-foreground">{t('admin_users_recentLogins')}</CardTitle>
 <Clock className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-slate-600">{recentLogins}</div>
 <p className="text-xs text-muted-foreground">
 {t('admin_users_last24Hours')}
 </p>
 </CardContent>
 </Card>
 </div>

 <Tabs defaultValue="permissions" className="space-y-4">
 <TabsList>
 <TabsTrigger value="permissions">{t('permissions')}</TabsTrigger>
 <TabsTrigger value="preferences">{t('admin_users_preferences')}</TabsTrigger>
 <TabsTrigger value="roles">{t('admin_users_roles')}</TabsTrigger>
 <TabsTrigger value="access-logs">{t('admin_users_accessLogs')}</TabsTrigger>
 <TabsTrigger value="security">{t('security')}</TabsTrigger>
 </TabsList>

 <TabsContent value="permissions" className="space-y-4">
 <div className="flex justify-between items-center">
 <div className="flex gap-2">
 <div className="relative">
 <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
 <Input placeholder={t('admin_users_searchUsers')} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-8 w-64" />
 </div>
 <Select value={roleFilter} onValueChange={setRoleFilter}>
 <SelectTrigger className="w-40">
 <SelectValue />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="ALL">{t('admin_users_allRoles')}</SelectItem>
 {roles.map(role => <SelectItem key={role.id} value={role.name}>{role.name}</SelectItem>)}
 </SelectContent>
 </Select>
 <Select value={statusFilter} onValueChange={setStatusFilter}>
 <SelectTrigger className="w-32">
 <SelectValue />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="ALL">{t('admin_users_allStatus')}</SelectItem>
 <SelectItem value="ACTIVE">{t('active')}</SelectItem>
 <SelectItem value="INACTIVE">{t('inactive')}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 
 <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
 <DialogTrigger asChild>
 <Button>
 <Plus className="h-4 w-4 mr-2" />
 {t('admin_users_grantPermission')}
 </Button>
 </DialogTrigger>
 
 <DialogContent className="sm:max-w-[500px] bg-card text-card-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_auto_create_new_user", "Create New User")}</DialogTitle>
 <DialogDescription>{t("admin_auto_fill_in_the_user_details_this_maps_direc", "Fill in the user details. This maps directly to the backend User model.")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="email" className="text-right text-xs">{t("admin_auto_email", "Email *")}</Label>
 <Input id="email" type="email" className="col-span-3 h-10" value={newUser.email} onChange={e => setNewUser({...newUser, email: e.target.value})} placeholder="user@example.com" />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="name" className="text-right text-xs">{t("admin_auto_name", "Name")}</Label>
 <Input id="name" className="col-span-3 h-10" value={newUser.name} onChange={e => setNewUser({...newUser, name: e.target.value})} placeholder="John Doe" />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="phone" className="text-right text-xs">{t("admin_auto_phone", "Phone")}</Label>
 <Input id="phone" className="col-span-3 h-10" value={newUser.phone} onChange={e => setNewUser({...newUser, phone: e.target.value})} placeholder="+1 555-0123" />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="locale" className="text-right text-xs">{t("admin_auto_locale", "Locale")}</Label>
 <Select value={newUser.locale} onValueChange={(v) => setNewUser({...newUser, locale: v})}>
 <SelectTrigger className="col-span-3 h-10"><SelectValue placeholder="Select Locale" /></SelectTrigger>
 <SelectContent>
 <SelectItem value="en-US">English (US)</SelectItem>
 <SelectItem value="tr-TR">Turkish</SelectItem>
 <SelectItem value="fr-FR">French</SelectItem>
 <SelectItem value="de-DE">German</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="timezone" className="text-right text-xs">{t("admin_auto_timezone", "Timezone")}</Label>
 <Select value={newUser.timezone} onValueChange={(v) => setNewUser({...newUser, timezone: v})}>
 <SelectTrigger className="col-span-3 h-10"><SelectValue placeholder="Select Timezone" /></SelectTrigger>
 <SelectContent>
 <SelectItem value="America/New_York">Eastern Time (ET)</SelectItem>
 <SelectItem value="Europe/Istanbul">Istanbul (TRT)</SelectItem>
 <SelectItem value="Europe/London">London (GMT)</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 <DialogFooter>
 <Button variant="outline" onClick={() => setIsAddOpen(false)}>Cancel</Button>
 <Button onClick={() => createMutation.mutate(newUser)} disabled={createMutation.isPending || !newUser.email}>
 {createMutation.isPending ?"Saving..." :"Create User"}
 </Button>
 </DialogFooter>
 </DialogContent>
 
 </Dialog>

 <Dialog open={isEditOpen} onOpenChange={setIsEditOpen}>
 <DialogContent className="sm:max-w-[500px] bg-card text-card-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_auto_edit_user", "Edit User")}</DialogTitle>
 <DialogDescription>{t("admin_auto_update_the_user_details", "Update the user details.")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="edit-email" className="text-right text-xs">{t("admin_auto_email", "Email *")}</Label>
 <Input id="edit-email" type="email" className="col-span-3 h-10" value={editFormData.email} onChange={e => setEditFormData({...editFormData, email: e.target.value})} placeholder="user@example.com" />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="edit-name" className="text-right text-xs">{t("admin_auto_name", "Name")}</Label>
 <Input id="edit-name" className="col-span-3 h-10" value={editFormData.name} onChange={e => setEditFormData({...editFormData, name: e.target.value})} placeholder="John Doe" />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="edit-phone" className="text-right text-xs">{t("admin_auto_phone", "Phone")}</Label>
 <Input id="edit-phone" className="col-span-3 h-10" value={editFormData.phone} onChange={e => setEditFormData({...editFormData, phone: e.target.value})} placeholder="+1 555-0123" />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="edit-locale" className="text-right text-xs">{t("admin_auto_locale", "Locale")}</Label>
 <Select value={editFormData.locale} onValueChange={(v) => setEditFormData({...editFormData, locale: v})}>
 <SelectTrigger className="col-span-3 h-10"><SelectValue placeholder="Select Locale" /></SelectTrigger>
 <SelectContent>
 <SelectItem value="en-US">English (US)</SelectItem>
 <SelectItem value="tr-TR">Turkish</SelectItem>
 <SelectItem value="fr-FR">French</SelectItem>
 <SelectItem value="de-DE">German</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="edit-timezone" className="text-right text-xs">{t("admin_auto_timezone", "Timezone")}</Label>
 <Select value={editFormData.timezone} onValueChange={(v) => setEditFormData({...editFormData, timezone: v})}>
 <SelectTrigger className="col-span-3 h-10"><SelectValue placeholder="Select Timezone" /></SelectTrigger>
 <SelectContent>
 <SelectItem value="America/New_York">Eastern Time (ET)</SelectItem>
 <SelectItem value="Europe/Istanbul">Istanbul (TRT)</SelectItem>
 <SelectItem value="Europe/London">London (GMT)</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 <DialogFooter>
 <Button variant="outline" onClick={() => setIsEditOpen(false)}>Cancel</Button>
 <Button onClick={handleEditSubmit} disabled={updateMutation.isPending}>
 {updateMutation.isPending ?"Saving..." :"Save Changes"}
 </Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 
 </div>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t('permissions')}</CardTitle>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t('admin_users_user')}</TableHead>
 <TableHead>{t('admin_users_email')}</TableHead>
 <TableHead>{t('role')}</TableHead>
 <TableHead>{t('permissions')}</TableHead>
 <TableHead>{t('admin_users_status')}</TableHead>
 <TableHead>{t('admin_users_grantedBy')}</TableHead>
 <TableHead>{t('admin_users_expires')}</TableHead>
 <TableHead>{t('admin_users_lastUsed')}</TableHead>
 <TableHead>{t('admin_users_actions')}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {filteredPermissions.map(permission => <TableRow key={permission.id}>
 <TableCell className="font-medium">{permission.userName}</TableCell>
 <TableCell>
 <div className="flex items-center gap-1">
 <Mail className="h-3 w-3 text-muted-foreground" />
 {permission.userEmail}
 </div>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 <div className={`w-2 h-2 rounded-full ${getRoleLevelColor(roles.find(r => r.name === permission.role)?.level || 0)}`} />
 <Badge variant="outline">{permission.role}</Badge>
 </div>
 </TableCell>
 <TableCell>
 <div className="space-y-1">
 {permission.permissions.slice(0, 2).map((perm, idx) => <div key={idx} className="text-sm">
 <span className="font-medium">{perm.module}</span>: {perm.actions.join(', ')}
 </div>)}
 {permission.permissions.length > 2 && <div className="text-xs text-muted-foreground">
 +{permission.permissions.length - 2}{t("admin_users_more")}</div>}
 </div>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 {permission.isActive ? <CheckCircle className="h-4 w-4 text-green-600" /> : <UserX className="h-4 w-4 text-red-600" />}
 <span className="capitalize">{permission.isActive ? t('active') : t('inactive')}</span>
 </div>
 </TableCell>
 <TableCell>{permission.grantedBy}</TableCell>
 <TableCell>
 {permission.expiresAt ? <div className={new Date(permission.expiresAt) < new Date() ?"text-red-600 font-medium" :""}>
 {new Date(permission.expiresAt).toLocaleDateString()}
 </div> : <span className="text-muted-foreground">{t('common.never')}</span>}
 </TableCell>
 <TableCell>
 {permission.lastUsed ? new Date(permission.lastUsed).toLocaleDateString() : t('common.never')}
 </TableCell>
 <TableCell>
 <div className="flex gap-1">
 <Button variant="ghost" size="sm" onClick={() => setEditingId(permission.id)}>
 <Eye className="h-4 w-4" />
 </Button>
 <Button variant="ghost" size="sm" onClick={() => openEditDialog(permission)}>
 <Edit className="h-4 w-4" />
 </Button>
 <Button variant="ghost" size="sm" onClick={() => deleteMutation.mutate(permission.id)}>
 {permission.isActive ? <Ban className="h-4 w-4" /> : <Unlock className="h-4 w-4" />}
 </Button>
 </div>
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </CardContent>
 </Card>
 </TabsContent>

 <TabsContent value="preferences" className="space-y-4">
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_users_user_preferences")}</CardTitle>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t('admin_users_user')}</TableHead>
 <TableHead>{t('admin_users_theme')}</TableHead>
 <TableHead>{t('admin_users_language')}</TableHead>
 <TableHead>{t('admin_users_notifications')}</TableHead>
 <TableHead>{t('twoFactor')}</TableHead>
 <TableHead>{t('admin_users_devices')}</TableHead>
 <TableHead>{t('admin_users_lastUpdated')}</TableHead>
 <TableHead>{t('admin_users_actions')}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {preferences.map(preference => <TableRow key={preference.id}>
 <TableCell className="font-medium">{preference.userName}</TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 {preference.settings.theme === 'DARK' ? <Monitor className="h-4 w-4" /> : preference.settings.theme === 'LIGHT' ? <Monitor className="h-4 w-4" /> : <Monitor className="h-4 w-4" />}
 <span className="capitalize">{preference.settings.theme.toLowerCase()}</span>
 </div>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-1">
 <Globe className="h-3 w-3 text-muted-foreground" />
 {preference.settings.language}
 </div>
 </TableCell>
 <TableCell>
 <div className="space-y-1">
 <div className="flex items-center gap-1">
 <Mail className={`h-3 w-3 ${preference.settings.emailNotifications ? 'text-green-600' : 'text-muted-foreground'}`} />
 <span className="text-xs">{t("admin_users_email")}</span>
 </div>
 <div className="flex items-center gap-1">
 <Bell className={`h-3 w-3 ${preference.settings.pushNotifications ? 'text-green-600' : 'text-muted-foreground'}`} />
 <span className="text-xs">{t("admin_users_push")}</span>
 </div>
 <div className="flex items-center gap-1">
 <Phone className={`h-3 w-3 ${preference.settings.smsNotifications ? 'text-green-600' : 'text-muted-foreground'}`} />
 <span className="text-xs">{t("admin_users_sms")}</span>
 </div>
 </div>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 {preference.settings.twoFactorEnabled ? <Shield className="h-4 w-4 text-green-600" /> : <Shield className="h-4 w-4 text-muted-foreground" />}
 <span className={preference.settings.twoFactorEnabled ? 'text-green-600' : 'text-muted-foreground'}>
 {preference.settings.twoFactorEnabled ? t('admin_users_status_enabled') : t('admin_users_status_disabled')}
 </span>
 </div>
 </TableCell>
 <TableCell>
 <div className="space-y-1">
 {preference.devicePreferences.slice(0, 2).map((device, idx) => <div key={idx} className="flex items-center gap-1">
 {device.deviceType === 'MOBILE' ? <Smartphone className="h-3 w-3" /> : device.deviceType === 'TABLET' ? <Tablet className="h-3 w-3" /> : <Monitor className="h-3 w-3" />}
 <span className="text-xs">{device.deviceType}</span>
 </div>)}
 {preference.devicePreferences.length > 2 && <div className="text-xs text-muted-foreground">
 +{preference.devicePreferences.length - 2}{t("admin_users_more")}</div>}
 </div>
 </TableCell>
 <TableCell>{new Date(preference.updatedAt).toLocaleDateString()}</TableCell>
 <TableCell>
 <div className="flex gap-1">
 <Button variant="ghost" size="sm">
 <Eye className="h-4 w-4" />
 </Button>
 <Button variant="ghost" size="sm">
 <Edit className="h-4 w-4" />
 </Button>
 </div>
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </CardContent>
 </Card>
 </TabsContent>

 <TabsContent value="roles" className="space-y-4">
 <div className="flex justify-end">
 <Button>
 <Plus className="h-4 w-4 mr-2" />
 {t('admin_users_createRole')}
 </Button>
 </div>

 <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
 {roles.map(role => <Card key={role.id} className="bg-card border-border">
 <CardHeader>
 <div className="flex items-center justify-between">
 <div className="flex items-center gap-2">
 {role.systemRole ? <Crown className="h-4 w-4 text-yellow-500" /> : <Shield className="h-4 w-4" />}
 <CardTitle className="text-lg text-foreground">{role.name}</CardTitle>
 </div>
 <Switch checked={role.isActive} />
 </div>
 </CardHeader>
 <CardContent>
 <div className="space-y-3">
 <p className="text-sm text-muted-foreground">{role.description}</p>
 
 <div className="flex justify-between items-center">
 <span className="text-sm font-medium text-foreground">{t('admin_users_status_level')}</span>
 <Badge className={getRoleLevelColor(role.level)}>{role.level}</Badge>
 </div>
 
 <div className="flex justify-between items-center">
 <span className="text-sm font-medium text-foreground">{t('users')}</span>
 <span className="text-sm">{role.userCount}</span>
 </div>
 
 <div>
 <span className="text-sm font-medium text-foreground">{t('permissions')} ({role.permissions.length})</span>
 <div className="mt-1 space-y-1">
 {role.permissions.slice(0, 3).map((permission, idx) => <div key={idx} className="text-xs bg-card px-2 py-1 rounded-lg">
 {permission}
 </div>)}
 {role.permissions.length > 3 && <div className="text-xs text-muted-foreground">
 +{role.permissions.length - 3}{t("admin_users_more")}</div>}
 </div>
 </div>
 
 <div className="flex justify-between items-center pt-2 border-t">
 <span className="text-xs text-muted-foreground">
 {t('common.created')} {new Date(role.createdAt).toLocaleDateString()}
 </span>
 <div className="flex gap-1">
 <Button variant="ghost" size="sm">
 <Edit className="h-4 w-4" />
 </Button>
 {!role.systemRole && <Button variant="ghost" size="sm">
 <Trash2 className="h-4 w-4" />
 </Button>}
 </div>
 </div>
 </div>
 </CardContent>
 </Card>)}
 </div>
 </TabsContent>

 <TabsContent value="access-logs" className="space-y-4">
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t('admin_users_accessLogs')}</CardTitle>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t('admin_users_user')}</TableHead>
 <TableHead>{t('action')}</TableHead>
 <TableHead>{t('admin_users_resource')}</TableHead>
 <TableHead>{t('admin_users_ipAddress')}</TableHead>
 <TableHead>{t('admin_users_location')}</TableHead>
 <TableHead>{t('admin_users_status')}</TableHead>
 <TableHead>{t('admin_users_timestamp')}</TableHead>
 <TableHead>{t('admin_users_actions')}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {accessLogs.slice(0, 20).map(log => <TableRow key={log.id}>
 <TableCell className="font-medium">{log.userName}</TableCell>
 <TableCell>
 <Badge variant="outline">{log.action}</Badge>
 </TableCell>
 <TableCell className="font-mono text-sm max-w-xs truncate">
 {log.resource}
 </TableCell>
 <TableCell className="font-mono text-sm">{log.ipAddress}</TableCell>
 <TableCell>
 <div className="flex items-center gap-1">
 <MapPin className="h-3 w-3 text-muted-foreground" />
 <span className="text-sm">{log.location.city}, {log.location.country}</span>
 </div>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 {log.success ? <CheckCircle className="h-4 w-4 text-green-600" /> : <AlertTriangle className="h-4 w-4 text-red-600" />}
 <span className={log.success ? 'text-green-600' : 'text-red-600'}>
 {log.success ? t('success') : t('failed')}
 </span>
 </div>
 </TableCell>
 <TableCell>{new Date(log.timestamp).toLocaleString()}</TableCell>
 <TableCell>
 <Button variant="ghost" size="sm">
 <Eye className="h-4 w-4" />
 </Button>
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </CardContent>
 </Card>
 </TabsContent>

 <TabsContent value="security" className="space-y-4">
 <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t('admin_users_security_alerts')}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-3">
 {securityAlerts.slice(0, 10).map(alert => <div key={alert.id} className="flex justify-between items-start p-3 border rounded-lg">
 <div className="flex-1">
 <div className="flex items-center gap-2 mb-1">
 <div className={`w-2 h-2 rounded-full ${getSeverityColor(alert.severity)}`} />
 <span className="font-medium">{alert.userName}</span>
 <Badge variant="outline">{getLocalizedType(alert.type)}</Badge>
 </div>
 <p className="text-sm text-muted-foreground mb-1">{alert.description}</p>
 <div className="flex items-center gap-2 text-xs text-muted-foreground">
 <span>{alert.ipAddress}</span>
 <span>•</span>
 <span>{new Date(alert.timestamp).toLocaleString()}</span>
 </div>
 </div>
 <div className="flex flex-col items-end gap-1">
 <Badge className={getSeverityColor(alert.severity)}>
 {getLocalizedSeverity(alert.severity)}
 </Badge>
 <Badge variant="outline">{getLocalizedStatus(alert.status)}</Badge>
 </div>
 </div>)}
 </div>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t('overview')}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-4">
 <div className="grid grid-cols-2 gap-4">
 <div className="text-center p-3 border rounded-lg">
 <div className="text-2xl font-bold text-green-600">
 {securityAlerts.filter(a => a.status === 'RESOLVED').length}
 </div>
 <div className="text-sm text-muted-foreground">{t('admin_users_status_resolved')}</div>
 </div>
 <div className="text-center p-3 border rounded-lg">
 <div className="text-2xl font-bold text-red-600">
 {securityAlerts.filter(a => a.status === 'OPEN').length}
 </div>
 <div className="text-sm text-muted-foreground">{t('admin_users_status_open')}</div>
 </div>
 </div>
 
 <div className="space-y-2">
 <h4 className="font-medium">{t('admin_users_security_alertTypes')}</h4>
 {['FAILED_LOGIN', 'SUSPICIOUS_ACTIVITY', 'PERMISSION_ESCALATION', 'DATA_ACCESS'].map(type => {
 const count = securityAlerts.filter(a => a.type === type).length;
 return <div key={type} className="flex justify-between items-center">
 <span className="text-sm">{getLocalizedType(type)}</span>
 <Badge variant="outline">{count}</Badge>
 </div>;
 })}
 </div>
 </div>
 </CardContent>
 </Card>
 </div>
 </TabsContent>
 </Tabs>
 </div>
 </div>;
}