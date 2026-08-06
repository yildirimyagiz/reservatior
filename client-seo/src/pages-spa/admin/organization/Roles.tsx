"use client";

import { t } from"i18next";
import { useTranslation } from"react-i18next";
import { useState, useEffect } from"react";
import { PageShell } from "@/pages-spa/admin/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Badge } from"@/components/ui/badge";
import { Button } from"@/components/ui/button";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from"@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { Users, Plus, MoreHorizontal, Edit, Trash2, Activity, Shield, Search, Eye } from"lucide-react";
import { useToast } from"@/hooks/use-toast";
import { apiClient } from"@/lib/api/client";
type MemberRoleKey = 'OWNER' | 'VENDOR_MANAGER' | 'AGENCY_ADMIN' | 'AGENT' | 'ACCOUNTANT' | 'MAINTENANCE' | 'TENANT_GUEST' | 'ORG_ADMIN' | 'READ_ONLY';
interface Role {
 id: string;
 orgId: string;
 key: MemberRoleKey;
 name: string;
 createdAt: Date;
 updatedAt: Date;
 deletedAt?: Date;
 locationId?: string;
 permissions: RolePermission[];
 organization: {
 name: string;
 };
 _count?: {
 users: number;
 };
}
interface Permission {
 id: string;
 key: string;
 name: string;
 description?: string;
 createdAt: Date;
 updatedAt: Date;
 deletedAt?: Date;
}
interface RolePermission {
 id: string;
 roleId: string;
 permissionId: string;
 permission: Permission;
}
export default function Roles() {
 const {
 t
 } = useTranslation();
 const [roles, setRoles] = useState<Role[]>([]);
 const [permissions, setPermissions] = useState<Permission[]>([]);
 const [loading, setLoading] = useState(true);
 const [isCreateDialogOpen, setIsCreateDialogOpen] = useState(false);
 const [isEditDialogOpen, setIsEditDialogOpen] = useState(false);
 const [selectedRole, setSelectedRole] = useState<Role | null>(null);
 const [searchTerm, setSearchTerm] = useState('');
 const [orgFilter, setOrgFilter] = useState<string>('all');
 const {
 toast
 } = useToast();
 const [createData, setCreateData] = useState({
 name: '',
 key: 'AGENT' as MemberRoleKey,
 orgId: '',
 locationId: '',
 permissionIds: [] as string[]
 });
 const [editData, setEditData] = useState({
 name: '',
 permissionIds: [] as string[]
 });
 useEffect(() => {
 fetchRoles();
 fetchPermissions();
 }, [orgFilter]);
 const fetchRoles = async () => {
 try {
 const params = new URLSearchParams();
 if (orgFilter !== 'all') params.append('orgId', orgFilter);
 const response = await apiClient.get<{
 data: Role[];
 }>(`/roles?${params}`);
 setRoles(response.data);
 } catch (error) {
 toast({
 title: t("admin_organization_error"),
 description: t("admin_organization_failed_to_fetch_roles"),
 variant:"destructive"
 });
 } finally {
 setLoading(false);
 }
 };
 const fetchPermissions = async () => {
 try {
 const response = await apiClient.get<{
 data: Permission[];
 }>('/permissions');
 setPermissions(response.data);
 } catch (error) {
 toast({
 title: t("admin_organization_error"),
 description: t("admin_organization_failed_to_fetch_permissions"),
 variant:"destructive"
 });
 }
 };
 const createRole = async () => {
 try {
 const response = (await apiClient.post('/role', createData)) as {
 data: Role;
 };
 setRoles([...roles, response.data]);
 setIsCreateDialogOpen(false);
 setCreateData({
 name: '',
 key: 'AGENT',
 orgId: '',
 locationId: '',
 permissionIds: []
 });
 toast({
 title: t("admin_organization_success"),
 description: t("admin_organization_role_created_successfully")
 });
 } catch (error) {
 toast({
 title: t("admin_organization_error"),
 description: t("admin_organization_failed_to_create_role"),
 variant:"destructive"
 });
 }
 };
 const updateRole = async () => {
 if (!selectedRole) return;
 try {
 await apiClient.put(`/role/${selectedRole.id}`, editData);
 setRoles(roles.map(role => role.id === selectedRole.id ? {
 ...role,
 ...editData
 } : role));
 setIsEditDialogOpen(false);
 setSelectedRole(null);
 toast({
 title: t("admin_organization_success"),
 description: t("admin_organization_role_updated_successfully")
 });
 } catch (error) {
 toast({
 title: t("admin_organization_error"),
 description: t("admin_organization_failed_to_update_role"),
 variant:"destructive"
 });
 }
 };
 const deleteRole = async (roleId: string) => {
 try {
 await apiClient.delete(`/role/${roleId}`);
 setRoles(roles.filter(role => role.id !== roleId));
 toast({
 title: t("admin_organization_success"),
 description: t("admin_organization_role_deleted_successfully")
 });
 } catch (error) {
 toast({
 title: t("admin_organization_error"),
 description: t("admin_organization_failed_to_delete_role"),
 variant:"destructive"
 });
 }
 };
 const openEditDialog = (role: Role) => {
 setSelectedRole(role);
 setEditData({
 name: role.name,
 permissionIds: role.permissions.map(rp => rp.permissionId)
 });
 setIsEditDialogOpen(true);
 };
 const getRoleKeyColor = (key: MemberRoleKey) => {
 switch (key) {
 case 'OWNER':
 return 'bg-red-500';
 case 'ORG_ADMIN':
 return 'bg-muted0';
 case 'AGENCY_ADMIN':
 return 'bg-muted0';
 case 'VENDOR_MANAGER':
 return 'bg-blue-500';
 case 'AGENT':
 return 'bg-orange-500';
 case 'ACCOUNTANT':
 return 'bg-yellow-500';
 case 'MAINTENANCE':
 return 'bg-card/10';
 case 'TENANT_GUEST':
 return 'bg-pink-500';
 case 'READ_ONLY':
 return 'bg-muted0';
 default:
 return 'bg-card/10';
 }
 };
 const filteredRoles = roles.filter(role => {
 const matchesSearch = role.name.toLowerCase().includes(searchTerm.toLowerCase()) || role.key.toLowerCase().includes(searchTerm.toLowerCase());
 return matchesSearch;
 });
 const totalRoles = roles.length;
 const activeRoles = roles.filter(role => !role.deletedAt).length;
 const systemRoles = roles.filter(role => ['OWNER', 'ORG_ADMIN'].includes(role.key)).length;
 const customRoles = roles.filter(role => !['OWNER', 'ORG_ADMIN'].includes(role.key)).length;
 if (loading) {
 return <PageShell title={t("admin_organization_roles_management")}>
 <div className="flex items-center justify-center h-64">
 <Activity className="h-8 w-8 animate-spin" />
 </div>
 </PageShell>;
 }
 return <PageShell title={t("admin_organization_roles_management")}>
 <div className="space-y-6">
 {/* Overview Cards */}
 <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_organization_total_roles")}</CardTitle>
 <Shield className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold">{totalRoles}</div>
 <p className="text-xs text-muted-foreground">{t("admin_organization_defined_roles")}</p>
 </CardContent>
 </Card>

 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_organization_active_roles")}</CardTitle>
 <Shield className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-blue-600">{activeRoles}</div>
 <p className="text-xs text-muted-foreground">{t("admin_organization_not_deleted")}</p>
 </CardContent>
 </Card>

 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_organization_system_roles")}</CardTitle>
 <Shield className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-red-600">{systemRoles}</div>
 <p className="text-xs text-muted-foreground">{t("admin_organization_builtin_roles")}</p>
 </CardContent>
 </Card>

 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_organization_custom_roles")}</CardTitle>
 <Shield className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-muted-foreground">{customRoles}</div>
 <p className="text-xs text-muted-foreground">{t("admin_organization_userdefined")}</p>
 </CardContent>
 </Card>
 </div>

 {/* Filters and Actions */}
 <div className="flex justify-between items-center">
 <div className="flex gap-4">
 <div className="relative">
 <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
 <Input placeholder={t("admin_organization_search_roles")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-8 w-64" />
 </div>
 <Select value={orgFilter} onValueChange={setOrgFilter}>
 <SelectTrigger className="w-[150px]">
 <SelectValue placeholder={t("admin_organization_organization")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="all">{t("admin_organization_all_organizations")}</SelectItem>
 {/* Add organization options here */}
 </SelectContent>
 </Select>
 </div>
 <Dialog open={isCreateDialogOpen} onOpenChange={setIsCreateDialogOpen}>
 <DialogTrigger asChild>
 <Button>
 <Plus className="h-4 w-4 mr-2" />{t("admin_organization_create_role")}</Button>
 </DialogTrigger>
 <DialogContent className="max-w-2xl">
 <DialogHeader>
 <DialogTitle>{t("admin_organization_create_new_role")}</DialogTitle>
 <DialogDescription>{t("admin_organization_define_a_new_role")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-2 gap-4">
 <div className="grid gap-2">
 <Label htmlFor="roleName">{t("admin_organization_role_name")}</Label>
 <Input id="roleName" value={createData.name} onChange={e => setCreateData({
 ...createData,
 name: e.target.value
 })} placeholder={t("admin_organization_eg_senior_agent")} required />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="roleKey">{t("admin_organization_role_key")}</Label>
 <Select value={createData.key} onValueChange={value => setCreateData({
 ...createData,
 key: value as MemberRoleKey
 })}>
 <SelectTrigger>
 <SelectValue />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="AGENT">{t("admin_organization_agent")}</SelectItem>
 <SelectItem value="ACCOUNTANT">{t("admin_organization_accountant")}</SelectItem>
 <SelectItem value="MAINTENANCE">{t("admin_organization_maintenance")}</SelectItem>
 <SelectItem value="TENANT_GUEST">{t("admin_organization_tenant_guest")}</SelectItem>
 <SelectItem value="READ_ONLY">{t("admin_organization_read_only")}</SelectItem>
 <SelectItem value="VENDOR_MANAGER">{t("admin_organization_vendor_manager")}</SelectItem>
 <SelectItem value="AGENCY_ADMIN">{t("admin_organization_agency_admin")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="grid gap-2">
 <Label htmlFor="orgId">{t("admin_organization_organization")}</Label>
 <Input id="orgId" value={createData.orgId} onChange={e => setCreateData({
 ...createData,
 orgId: e.target.value
 })} placeholder={t("admin_organization_organization_id")} required />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="locationId">{t("admin_organization_location_optional")}</Label>
 <Input id="locationId" value={createData.locationId} onChange={e => setCreateData({
 ...createData,
 locationId: e.target.value
 })} placeholder={t("admin_organization_location_id")} />
 </div>
 </div>
 <div className="grid gap-2">
 <Label>{t("admin_organization_permissions")}</Label>
 <div className="grid grid-cols-2 gap-2 max-h-48 overflow-y-auto border rounded-xl p-4">
 {permissions.map(permission => <div key={permission.id} className="flex items-center space-x-2">
 <input type="checkbox" id={`perm-${permission.id}`} checked={createData.permissionIds.includes(permission.id)} onChange={e => {
 if (e.target.checked) {
 setCreateData({
 ...createData,
 permissionIds: [...createData.permissionIds, permission.id]
 });
 } else {
 setCreateData({
 ...createData,
 permissionIds: createData.permissionIds.filter(id => id !== permission.id)
 });
 }
 }} className="rounded-lg" />
 <label htmlFor={`perm-${permission.id}`} className="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70">
 {permission.name}
 </label>
 </div>)}
 </div>
 </div>
 </div>
 <DialogFooter>
 <Button onClick={createRole}>{t("admin_organization_create_role")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </div>

 {/* Edit Role Dialog */}
 <Dialog open={isEditDialogOpen} onOpenChange={setIsEditDialogOpen}>
 <DialogContent className="max-w-2xl">
 <DialogHeader>
 <DialogTitle>{t("admin_organization_edit_role")}</DialogTitle>
 <DialogDescription>{t("admin_organization_update_role_name_and")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid gap-2">
 <Label htmlFor="editRoleName">{t("admin_organization_role_name")}</Label>
 <Input id="editRoleName" value={editData.name} onChange={e => setEditData({
 ...editData,
 name: e.target.value
 })} />
 </div>
 <div className="grid gap-2">
 <Label>{t("admin_organization_permissions")}</Label>
 <div className="grid grid-cols-2 gap-2 max-h-48 overflow-y-auto border rounded-xl p-4">
 {permissions.map(permission => <div key={permission.id} className="flex items-center space-x-2">
 <input type="checkbox" id={`edit-perm-${permission.id}`} checked={editData.permissionIds.includes(permission.id)} onChange={e => {
 if (e.target.checked) {
 setEditData({
 ...editData,
 permissionIds: [...editData.permissionIds, permission.id]
 });
 } else {
 setEditData({
 ...editData,
 permissionIds: editData.permissionIds.filter(id => id !== permission.id)
 });
 }
 }} className="rounded-lg" />
 <label htmlFor={`edit-perm-${permission.id}`} className="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70">
 {permission.name}
 </label>
 </div>)}
 </div>
 </div>
 </div>
 <DialogFooter>
 <Button onClick={updateRole}>{t("admin_organization_update_role")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>

 {/* Roles Table */}
 <Card>
 <CardHeader>
 <CardTitle>{t("admin_organization_roles")}</CardTitle>
 <p className="text-sm text-muted-foreground">{t("admin_organization_manage_roles_and_their")}</p>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_organization_role")}</TableHead>
 <TableHead>{t("admin_organization_key")}</TableHead>
 <TableHead>{t("admin_organization_organization")}</TableHead>
 <TableHead>{t("admin_organization_permissions")}</TableHead>
 <TableHead>{t("admin_organization_users")}</TableHead>
 <TableHead>{t("admin_organization_created")}</TableHead>
 <TableHead>{t("admin_organization_status")}</TableHead>
 <TableHead className="text-right">{t("admin_organization_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {filteredRoles.map(role => <TableRow key={role.id}>
 <TableCell className="font-medium">
 <div className="flex items-center gap-2">
 <Shield className="h-4 w-4 text-muted-foreground" />
 {role.name}
 </div>
 </TableCell>
 <TableCell>
 <Badge variant="outline" className="text-xs">
 <div className={`w-2 h-2 rounded-full ${getRoleKeyColor(role.key)} mr-1`} />
 {role.key.replace('_', ' ').toLowerCase()}
 </Badge>
 </TableCell>
 <TableCell>
 {role.organization?.name || 'Unknown'}
 </TableCell>
 <TableCell>
 <div className="flex flex-wrap gap-1">
 {role.permissions.slice(0, 3).map(rp => <Badge key={rp.id} variant="secondary" className="text-xs">
 {rp.permission.name}
 </Badge>)}
 {role.permissions.length > 3 && <Badge variant="secondary" className="text-xs">
 +{role.permissions.length - 3}{t("admin_organization_more")}</Badge>}
 </div>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-1">
 <Users className="h-3 w-3 text-muted-foreground" />
 {role._count?.users || 0}
 </div>
 </TableCell>
 <TableCell>
 {new Date(role.createdAt).toLocaleDateString()}
 </TableCell>
 <TableCell>
 {role.deletedAt ? <Badge variant="destructive" className="text-xs">{t("admin_organization_deleted")}</Badge> : <Badge variant="default" className="text-xs">{t("admin_organization_active")}</Badge>}
 </TableCell>
 <TableCell className="text-right">
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="ghost" className="h-8 w-8 p-0" aria-label={t("common.more")}>
 <MoreHorizontal className="h-4 w-4" />
 </Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent align="end">
 <DropdownMenuLabel>{t("admin_organization_actions")}</DropdownMenuLabel>
 <DropdownMenuItem onClick={() => openEditDialog(role)}>
 <Edit className="h-4 w-4 mr-2" />{t("admin_organization_edit_role")}</DropdownMenuItem>
 <DropdownMenuItem>
 <Eye className="h-4 w-4 mr-2" />{t("admin_organization_view_details")}</DropdownMenuItem>
 <DropdownMenuItem>
 <Users className="h-4 w-4 mr-2" />{t("admin_organization_manage_users")}</DropdownMenuItem>
 <DropdownMenuSeparator />
 <DropdownMenuItem onClick={() => deleteRole(role.id)} className="text-red-600">
 <Trash2 className="h-4 w-4 mr-2" />{t("admin_organization_delete_role")}</DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </CardContent>
 </Card>

 {/* Role Distribution */}
 <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
 <Card>
 <CardHeader>
 <CardTitle>{t("admin_organization_role_key_distribution")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-3">
 {['OWNER', 'ORG_ADMIN', 'AGENCY_ADMIN', 'VENDOR_MANAGER', 'AGENT', 'ACCOUNTANT', 'MAINTENANCE', 'TENANT_GUEST', 'READ_ONLY'].map(key => {
 const count = roles.filter(role => role.key === key).length;
 if (count === 0) return null;
 return <div key={key} className="animate-in fade-in slide-in-from-bottom-4 duration-700 flex justify-between items-center">
 <span className="text-sm flex items-center gap-2">
 <div className={`w-2 h-2 rounded-full ${getRoleKeyColor(key as MemberRoleKey)}`} />
 {key.replace('_', ' ').toLowerCase()}
 </span>
 <span className="font-medium">{count}</span>
 </div>;
 })}
 </div>
 </CardContent>
 </Card>

 <Card>
 <CardHeader>
 <CardTitle>{t("admin_organization_permission_overview")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-4">
 <div className="text-center">
 <div className="text-2xl font-bold text-muted-foreground">
 {permissions.length}
 </div>
 <p className="text-sm text-muted-foreground">{t("admin_organization_total_permissions")}</p>
 </div>
 <div className="text-center">
 <div className="text-2xl font-bold text-blue-600">
 {roles.reduce((acc, role) => acc + role.permissions.length, 0)}
 </div>
 <p className="text-sm text-muted-foreground">{t("admin_organization_permission_assignments")}</p>
 </div>
 </div>
 </CardContent>
 </Card>

 <Card>
 <CardHeader>
 <CardTitle>{t("admin_organization_role_status")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-3">
 <div className="flex justify-between items-center">
 <span className="text-sm flex items-center gap-2">
 <div className="w-2 h-2 rounded-full bg-blue-500" />{t("admin_organization_active")}</span>
 <span className="font-medium">{activeRoles}</span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm flex items-center gap-2">
 <div className="w-2 h-2 rounded-full bg-red-500" />{t("admin_organization_deleted")}</span>
 <span className="font-medium">{totalRoles - activeRoles}</span>
 </div>
 </div>
 </CardContent>
 </Card>
 </div>
 </div>
 </PageShell>;
}