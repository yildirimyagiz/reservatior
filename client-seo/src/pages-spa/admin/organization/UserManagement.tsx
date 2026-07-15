"use client";
import React from 'react';
import { useMutation, useQueryClient } from '@tanstack/react-query';

import { t } from"i18next";
import { useTranslation } from"react-i18next";
import { useState, useEffect } from"react";
import { PageShell } from"../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Badge } from"@/components/ui/badge";
import { Button } from"@/components/ui/button";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from"@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { Users, UserPlus, MoreHorizontal, Activity, Search, Eye, Edit, Trash2, Shield, Mail, Phone, CheckCircle, XCircle } from"lucide-react";
import { useToast } from"@/hooks/use-toast";
import { apiClient } from"@/lib/api/client";
import Image from"next/image";
interface User {
 id: string;
 email: string;
 firstName: string;
 lastName: string;
 avatar?: string;
 status: 'ACTIVE' | 'INACTIVE' | 'SUSPENDED' | 'PENDING';
 role: 'SUPER_ADMIN' | 'ORG_ADMIN' | 'AGENT' | 'STAFF' | 'CLIENT';
 orgId?: string;
 phone?: string;
 title?: string;
 department?: string;
 lastLoginAt?: Date;
 emailVerified: boolean;
 phoneVerified: boolean;
 twoFactorEnabled: boolean;
 permissions: string[];
 teams: {
 id: string;
 name: string;
 role: string;
 }[];
 createdAt: Date;
 updatedAt: Date;
 organization?: {
 name: string;
 };
}
export default function UserManagement() {
 const { toast } = useToast();
 const queryClient = useQueryClient();
 const [editingId, setEditingId] = React.useState<string | null>(null);

 const updateMutation = useMutation({
 mutationFn: async (data: any) => apiClient.put(`/admin/usermanagement/${data.id}`, data),
 onSuccess: () => { toast({ title:"Updated", description:"Record updated successfully" }); queryClient.invalidateQueries(); setEditingId(null); },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/admin/usermanagement/${id}`),
 onSuccess: () => { toast({ title:"Deleted", description:"Record deleted successfully" }); queryClient.invalidateQueries(); },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });
 
 const {
 t
 } = useTranslation();
 const [users, setUsers] = useState<User[]>([]);
 const [loading, setLoading] = useState(true);
 const [isInviteDialogOpen, setIsInviteDialogOpen] = useState(false);
 const [isEditDialogOpen, setIsEditDialogOpen] = useState(false);
 const [selectedUser, setSelectedUser] = useState<User | null>(null);
 const [searchTerm, setSearchTerm] = useState('');
 const [statusFilter, setStatusFilter] = useState<string>('all');
 const [roleFilter, setRoleFilter] = useState<string>('all');
 const [orgFilter] = useState<string>('all');
 const [inviteData, setInviteData] = useState({
 email: '',
 firstName: '',
 lastName: '',
 role: 'STAFF',
 orgId: '',
 title: '',
 department: ''
 });
 const [editData, setEditData] = useState({
 firstName: '',
 lastName: '',
 role: 'STAFF',
 title: '',
 department: '',
 phone: ''
 });
 useEffect(() => {
 fetchUsers();
 }, [statusFilter, roleFilter, orgFilter]);
 const fetchUsers = async () => {
 try {
 const params = new URLSearchParams();
 if (statusFilter !== 'all') params.append('status', statusFilter);
 if (roleFilter !== 'all') params.append('role', roleFilter);
 if (orgFilter !== 'all') params.append('orgId', orgFilter);
 const response = (await apiClient.get(`/users?${params}`)) as {
 data: User[];
 };
 setUsers(response.data);
 } catch (error) {
 toast({
 title: t("admin_organization_error"),
 description: t("admin_organization_failed_to_fetch_users"),
 variant:"destructive"
 });
 } finally {
 setLoading(false);
 }
 };
 const inviteUser = async () => {
 try {
 const response = (await apiClient.post('/users/invite', inviteData)) as {
 data: User;
 };
 setUsers([...users, response.data]);
 setIsInviteDialogOpen(false);
 setInviteData({
 email: '',
 firstName: '',
 lastName: '',
 role: 'STAFF',
 orgId: '',
 title: '',
 department: ''
 });
 toast({
 title: t("admin_organization_success"),
 description: t("admin_organization_user_invitation_sent_successfully")
 });
 } catch (error) {
 toast({
 title: t("admin_organization_error"),
 description: t("admin_organization_failed_to_send_invitation"),
 variant:"destructive"
 });
 }
 };
 const updateUser = async () => {
 if (!selectedUser) return;
 try {
 await apiClient.put(`/users/${selectedUser.id}`, editData);
 setUsers(users.map(user => user.id === selectedUser.id ? {
 ...user,
 ...(editData as any)
 } : user));
 setIsEditDialogOpen(false);
 setSelectedUser(null);
 toast({
 title: t("admin_organization_success"),
 description: t("admin_organization_user_updated_successfully")
 });
 } catch (error) {
 toast({
 title: t("admin_organization_error"),
 description: t("admin_organization_failed_to_update_user"),
 variant:"destructive"
 });
 }
 };
 const updateUserStatus = async (userId: string, status: string) => {
 try {
 await apiClient.put(`/users/${userId}`, {
 status
 });
 setUsers(users.map(user => user.id === userId ? {
 ...user,
 status: status as any
 } : user));
 toast({
 title: t("admin_organization_success"),
 description: t("admin_organization_user_status_updated_successfully")
 });
 } catch (error) {
 toast({
 title: t("admin_organization_error"),
 description: t("admin_organization_failed_to_update_user"),
 variant:"destructive"
 });
 }
 };
 const openEditDialog = (user: User) => {
 setSelectedUser(user);
 setEditData({
 firstName: user.firstName,
 lastName: user.lastName,
 role: user.role,
 title: user.title || '',
 department: user.department || '',
 phone: user.phone || ''
 });
 setIsEditDialogOpen(true);
 };
 const getStatusColor = (status: string) => {
 switch (status) {
 case 'ACTIVE':
 return 'bg-green-500';
 case 'INACTIVE':
 return 'bg-white/10';
 case 'SUSPENDED':
 return 'bg-red-500';
 case 'PENDING':
 return 'bg-yellow-500';
 default:
 return 'bg-white/10';
 }
 };
 const getRoleColor = (role: string) => {
 switch (role) {
 case 'SUPER_ADMIN':
 return 'bg-red-500';
 case 'ORG_ADMIN':
 return 'bg-muted0';
 case 'AGENT':
 return 'bg-muted0';
 case 'STAFF':
 return 'bg-green-500';
 case 'CLIENT':
 return 'bg-orange-500';
 default:
 return 'bg-white/10';
 }
 };
 const filteredUsers = users.filter(user => {
 const matchesSearch = `${user.firstName} ${user.lastName}`.toLowerCase().includes(searchTerm.toLowerCase()) || user.email.toLowerCase().includes(searchTerm.toLowerCase());
 return matchesSearch;
 });
 const activeUsers = users.filter(user => user.status === 'ACTIVE').length;
 const totalUsers = users.length;
 const verifiedUsers = users.filter(user => user.emailVerified).length;
 const twoFactorUsers = users.filter(user => user.twoFactorEnabled).length;
 if (loading) {
 return <PageShell title={t("admin_organization_user_management")}>
 <div className="flex items-center justify-center h-64">
 <Activity className="h-8 w-8 animate-spin" />
 </div>
 </PageShell>;
 }
 return <PageShell title={t("admin_organization_user_management")}>
 <div className="space-y-6">
 {/* Overview Cards */}
 <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_organization_total_users")}</CardTitle>
 <Users className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold">{totalUsers}</div>
 <p className="text-xs text-muted-foreground">{t("admin_organization_registered_accounts")}</p>
 </CardContent>
 </Card>

 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_organization_active_users")}</CardTitle>
 <CheckCircle className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-green-600">{activeUsers}</div>
 <p className="text-xs text-muted-foreground">{t("admin_organization_currently_active")}</p>
 </CardContent>
 </Card>

 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_organization_verified_users")}</CardTitle>
 <Shield className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-slate-600">{verifiedUsers}</div>
 <p className="text-xs text-muted-foreground">{t("admin_organization_email_verified")}</p>
 </CardContent>
 </Card>

 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_organization_2fa_enabled")}</CardTitle>
 <Shield className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-slate-600">{twoFactorUsers}</div>
 <p className="text-xs text-muted-foreground">{t("admin_organization_twofactor_auth")}</p>
 </CardContent>
 </Card>
 </div>

 {/* Filters and Actions */}
 <div className="flex justify-between items-center">
 <div className="flex gap-4">
 <div className="relative">
 <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
 <Input placeholder={t("admin_organization_search_users")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-8 w-64" />
 </div>
 <Select value={statusFilter} onValueChange={setStatusFilter}>
 <SelectTrigger className="w-[120px]">
 <SelectValue placeholder={t("admin_organization_status")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="all">{t("admin_organization_all_status")}</SelectItem>
 <SelectItem value="ACTIVE">{t("admin_organization_active")}</SelectItem>
 <SelectItem value="INACTIVE">{t("admin_organization_inactive")}</SelectItem>
 <SelectItem value="SUSPENDED">{t("admin_organization_suspended")}</SelectItem>
 <SelectItem value="PENDING">{t("admin_organization_pending")}</SelectItem>
 </SelectContent>
 </Select>
 <Select value={roleFilter} onValueChange={setRoleFilter}>
 <SelectTrigger className="w-[130px]">
 <SelectValue placeholder={t("admin_organization_role")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="all">{t("admin_organization_all_roles")}</SelectItem>
 <SelectItem value="SUPER_ADMIN">{t("admin_organization_super_admin")}</SelectItem>
 <SelectItem value="ORG_ADMIN">{t("admin_organization_org_admin")}</SelectItem>
 <SelectItem value="AGENT">{t("admin_organization_agent")}</SelectItem>
 <SelectItem value="STAFF">{t("admin_organization_staff")}</SelectItem>
 <SelectItem value="CLIENT">{t("admin_organization_client")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <Dialog open={isInviteDialogOpen} onOpenChange={setIsInviteDialogOpen}>
 <DialogTrigger asChild>
 <Button>
 <UserPlus className="h-4 w-4 mr-2" />{t("admin_organization_invite_user")}</Button>
 </DialogTrigger>
 <DialogContent className="max-w-lg">
 <DialogHeader>
 <DialogTitle>{t("admin_organization_invite_new_user")}</DialogTitle>
 <DialogDescription>{t("admin_organization_send_an_invitation_to")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-2 gap-4">
 <div className="grid gap-2">
 <Label htmlFor="firstName">{t("admin_organization_first_name")}</Label>
 <Input id="firstName" value={inviteData.firstName} onChange={e => setInviteData({
 ...inviteData,
 firstName: e.target.value
 })} required />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="lastName">{t("admin_organization_last_name")}</Label>
 <Input id="lastName" value={inviteData.lastName} onChange={e => setInviteData({
 ...inviteData,
 lastName: e.target.value
 })} required />
 </div>
 </div>
 <div className="grid gap-2">
 <Label htmlFor="email">{t("admin_organization_email_address")}</Label>
 <Input id="email" type="email" value={inviteData.email} onChange={e => setInviteData({
 ...inviteData,
 email: e.target.value
 })} required />
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="grid gap-2">
 <Label htmlFor="role">{t("admin_organization_role")}</Label>
 <Select value={inviteData.role} onValueChange={value => setInviteData({
 ...inviteData,
 role: value
 })}>
 <SelectTrigger>
 <SelectValue />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="CLIENT">{t("admin_organization_client")}</SelectItem>
 <SelectItem value="STAFF">{t("admin_organization_staff")}</SelectItem>
 <SelectItem value="AGENT">{t("admin_organization_agent")}</SelectItem>
 <SelectItem value="ORG_ADMIN">{t("admin_organization_org_admin")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="grid gap-2">
 <Label htmlFor="orgId">{t("admin_organization_organization")}</Label>
 <Input id="orgId" value={inviteData.orgId} onChange={e => setInviteData({
 ...inviteData,
 orgId: e.target.value
 })} placeholder={t("admin_organization_organization_id")} />
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="grid gap-2">
 <Label htmlFor="title">{t("admin_organization_job_title")}</Label>
 <Input id="title" value={inviteData.title} onChange={e => setInviteData({
 ...inviteData,
 title: e.target.value
 })} />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="department">{t("admin_organization_department")}</Label>
 <Input id="department" value={inviteData.department} onChange={e => setInviteData({
 ...inviteData,
 department: e.target.value
 })} />
 </div>
 </div>
 </div>
 <DialogFooter>
 <Button onClick={inviteUser}>{t("admin_organization_send_invitation")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </div>

 {/* Edit User Dialog */}
 <Dialog open={isEditDialogOpen} onOpenChange={setIsEditDialogOpen}>
 <DialogContent className="max-w-lg">
 <DialogHeader>
 <DialogTitle>{t("admin_organization_edit_user")}</DialogTitle>
 <DialogDescription>{t("admin_organization_update_user_information_and")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-2 gap-4">
 <div className="grid gap-2">
 <Label htmlFor="editFirstName">{t("admin_organization_first_name")}</Label>
 <Input id="editFirstName" value={editData.firstName} onChange={e => setEditData({
 ...editData,
 firstName: e.target.value
 })} />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="editLastName">{t("admin_organization_last_name")}</Label>
 <Input id="editLastName" value={editData.lastName} onChange={e => setEditData({
 ...editData,
 lastName: e.target.value
 })} />
 </div>
 </div>
 <div className="grid gap-2">
 <Label htmlFor="editPhone">{t("admin_organization_phone")}</Label>
 <Input id="editPhone" value={editData.phone} onChange={e => setEditData({
 ...editData,
 phone: e.target.value
 })} />
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="grid gap-2">
 <Label htmlFor="editRole">{t("admin_organization_role")}</Label>
 <Select value={editData.role} onValueChange={value => setEditData({
 ...editData,
 role: value
 })}>
 <SelectTrigger>
 <SelectValue />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="CLIENT">{t("admin_organization_client")}</SelectItem>
 <SelectItem value="STAFF">{t("admin_organization_staff")}</SelectItem>
 <SelectItem value="AGENT">{t("admin_organization_agent")}</SelectItem>
 <SelectItem value="ORG_ADMIN">{t("admin_organization_org_admin")}</SelectItem>
 <SelectItem value="SUPER_ADMIN">{t("admin_organization_super_admin")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="grid gap-2">
 <Label htmlFor="editTitle">{t("admin_organization_job_title")}</Label>
 <Input id="editTitle" value={editData.title} onChange={e => setEditData({
 ...editData,
 title: e.target.value
 })} />
 </div>
 </div>
 <div className="grid gap-2">
 <Label htmlFor="editDepartment">{t("admin_organization_department")}</Label>
 <Input id="editDepartment" value={editData.department} onChange={e => setEditData({
 ...editData,
 department: e.target.value
 })} />
 </div>
 </div>
 <DialogFooter>
 <Button onClick={updateUser}>{t("admin_organization_update_user")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>

 {/* Users Table */}
 <Card>
 <CardHeader>
 <CardTitle>{t("admin_organization_users")}</CardTitle>
 <p className="text-sm text-muted-foreground">{t("admin_organization_manage_user_accounts_roles")}</p>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_organization_user")}</TableHead>
 <TableHead>{t("admin_organization_role")}</TableHead>
 <TableHead>{t("admin_organization_status")}</TableHead>
 <TableHead>{t("admin_organization_organization")}</TableHead>
 <TableHead>{t("admin_organization_department")}</TableHead>
 <TableHead>{t("admin_organization_last_login")}</TableHead>
 <TableHead>{t("admin_organization_verification")}</TableHead>
 <TableHead>{t("admin_organization_created")}</TableHead>
 <TableHead className="text-right">{t("admin_organization_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {filteredUsers.map(user => <TableRow key={user.id}>
 <TableCell className="font-medium">
 <div className="flex items-center gap-3">
 <div className="relative w-8 h-8 bg-card rounded-full flex items-center justify-center">
 {user.avatar ? <Image src={user.avatar} alt={t("admin_organization_avatar")} width={32} height={32} className="rounded-full" /> : <span className="text-sm font-medium">
 {user.firstName[0]}{user.lastName[0]}
 </span>}
 </div>
 <div>
 <div className="font-medium">{user.firstName} {user.lastName}</div>
 <div className="text-xs text-muted-foreground flex items-center gap-1">
 <Mail className="h-3 w-3" />
 {user.email}
 </div>
 {user.phone && <div className="text-xs text-muted-foreground flex items-center gap-1">
 <Phone className="h-3 w-3" />
 {user.phone}
 </div>}
 </div>
 </div>
 </TableCell>
 <TableCell>
 <Badge variant="outline" className="text-xs">
 <div className={`w-2 h-2 rounded-full ${getRoleColor(user.role)} mr-1`} />
 {user.role.replace('_', ' ').toLowerCase()}
 </Badge>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 <div className={`w-2 h-2 rounded-full ${getStatusColor(user.status)}`} />
 <span className="capitalize text-sm">{user.status.toLowerCase()}</span>
 </div>
 </TableCell>
 <TableCell>
 {user.organization?.name || 'No Organization'}
 </TableCell>
 <TableCell>
 {user.department || user.title || '-'}
 </TableCell>
 <TableCell>
 {user.lastLoginAt ? <div className="text-sm">
 {new Date(user.lastLoginAt).toLocaleDateString()}
 </div> : <span className="text-muted-foreground">{t("admin_organization_never")}</span>}
 </TableCell>
 <TableCell>
 <div className="flex gap-1">
 {user.emailVerified && <CheckCircle className="h-4 w-4 text-green-500" />}
 {user.twoFactorEnabled && <Shield className="h-4 w-4 text-slate-500" />}
 </div>
 </TableCell>
 <TableCell>
 {new Date(user.createdAt).toLocaleDateString()}
 </TableCell>
 <TableCell className="text-right">
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="ghost" className="h-8 w-8 p-0">
 <MoreHorizontal className="h-4 w-4" />
 </Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent align="end">
 <DropdownMenuLabel>{t("admin_organization_actions")}</DropdownMenuLabel>
 <DropdownMenuItem onClick={() => openEditDialog(user)}>
 <Edit className="h-4 w-4 mr-2" />{t("admin_organization_edit_user")}</DropdownMenuItem>
 <DropdownMenuItem>
 <Eye className="h-4 w-4 mr-2" />{t("admin_organization_view_details")}</DropdownMenuItem>
 <DropdownMenuItem>
 <Shield className="h-4 w-4 mr-2" />{t("admin_organization_manage_permissions")}</DropdownMenuItem>
 {user.status === 'ACTIVE' && <DropdownMenuItem onClick={() => updateUserStatus(user.id, 'SUSPENDED')} className="text-red-600">
 <XCircle className="h-4 w-4 mr-2" />{t("admin_organization_suspend")}</DropdownMenuItem>}
 {user.status === 'SUSPENDED' && <DropdownMenuItem onClick={() => updateUserStatus(user.id, 'ACTIVE')}>
 <CheckCircle className="h-4 w-4 mr-2" />{t("admin_organization_activate")}</DropdownMenuItem>}
 <DropdownMenuSeparator />
 <DropdownMenuItem className="text-red-600">
 <Trash2 className="h-4 w-4 mr-2" />{t("admin_organization_delete_user")}</DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </CardContent>
 </Card>

 {/* User Statistics */}
 <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
 <Card>
 <CardHeader>
 <CardTitle>{t("admin_organization_role_distribution")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-3">
 {['SUPER_ADMIN', 'ORG_ADMIN', 'AGENT', 'STAFF', 'CLIENT'].map(role => {
 const count = users.filter(user => user.role === role).length;
 return <div key={role} className="animate-in fade-in slide-in-from-bottom-4 duration-700 flex justify-between items-center">
 <span className="text-sm">{role.replace('_', ' ').toLowerCase()}</span>
 <span className="font-medium">{count}</span>
 </div>;
 })}
 </div>
 </CardContent>
 </Card>

 <Card>
 <CardHeader>
 <CardTitle>{t("admin_organization_status_overview")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-3">
 <div className="flex justify-between items-center">
 <span className="text-sm flex items-center gap-2">
 <div className="w-2 h-2 rounded-full bg-green-500" />{t("admin_organization_active")}</span>
 <span className="font-medium">{activeUsers}</span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm flex items-center gap-2">
 <div className="w-2 h-2 rounded-full bg-white/10" />{t("admin_organization_inactive")}</span>
 <span className="font-medium">
 {users.filter(user => user.status === 'INACTIVE').length}
 </span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm flex items-center gap-2">
 <div className="w-2 h-2 rounded-full bg-yellow-500" />{t("admin_organization_pending")}</span>
 <span className="font-medium">
 {users.filter(user => user.status === 'PENDING').length}
 </span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm flex items-center gap-2">
 <div className="w-2 h-2 rounded-full bg-red-500" />{t("admin_organization_suspended")}</span>
 <span className="font-medium">
 {users.filter(user => user.status === 'SUSPENDED').length}
 </span>
 </div>
 </div>
 </CardContent>
 </Card>

 <Card>
 <CardHeader>
 <CardTitle>{t("admin_organization_verification_status")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-4">
 <div className="text-center">
 <div className="text-2xl font-bold text-green-600">
 {verifiedUsers}
 </div>
 <p className="text-sm text-muted-foreground">{t("admin_organization_email_verified")}</p>
 <div className="text-xs text-muted-foreground mt-1">
 {totalUsers > 0 ? (verifiedUsers / totalUsers * 100).toFixed(1) : 0}{t("admin_organization_of_users")}</div>
 </div>
 <div className="text-center">
 <div className="text-2xl font-bold text-slate-600">
 {twoFactorUsers}
 </div>
 <p className="text-sm text-muted-foreground">{t("admin_organization_2fa_enabled")}</p>
 <div className="text-xs text-muted-foreground mt-1">
 {totalUsers > 0 ? (twoFactorUsers / totalUsers * 100).toFixed(1) : 0}{t("admin_organization_of_users")}</div>
 </div>
 </div>
 </CardContent>
 </Card>
 </div>
 </div>
 </PageShell>;
}