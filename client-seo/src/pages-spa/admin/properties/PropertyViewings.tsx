"use client";

import { useTranslation } from"react-i18next";
import { useState } from"react";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Button } from"@/components/ui/button";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { Eye, Calendar, Users, CheckCircle, XCircle, MoreHorizontal, Activity, Star, TrendingUp } from"lucide-react";
import { useToast } from"@/hooks/use-toast";
import { apiClient } from"@/lib/api/client";
import { useQuery, useMutation, useQueryClient } from"@tanstack/react-query";

interface PropertyViewing {
 id: string;
 orgId?: string;
 propertyId: string;
 leadId?: string;
 agentId?: string;
 viewingType: 'IN_PERSON' | 'VIRTUAL' | 'SELF_GUIDED';
 status: 'SCHEDULED' | 'CONFIRMED' | 'COMPLETED' | 'CANCELLED' | 'NO_SHOW';
 scheduledAt: Date;
 duration: number;
 notes?: string;
 feedback?: {
 rating?: number;
 comments?: string;
 interested: boolean;
 };
 createdAt: Date;
 property?: {
 id: string;
 address: string;
 city: string;
 state: string;
 };
 lead?: {
 id: string;
 name: string;
 email: string;
 };
}
export default function PropertyViewings() {
 const { t } = useTranslation();
 const { toast } = useToast();
 const queryClient = useQueryClient();
 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/unknown/${id}`),
 onSuccess: () => {
 toast({ title:"Deleted", description:"Record deleted successfully" });
 queryClient.invalidateQueries();
 },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });
 

 const [statusFilter, setStatusFilter] = useState<string>('all');
 const [typeFilter, setTypeFilter] = useState<string>('all');
 const { data: viewings = [], isLoading } = useQuery({
 queryKey: ['property-viewing', statusFilter, typeFilter],
 queryFn: async () => {
 const params = new URLSearchParams();
 if (statusFilter !== 'all') params.append('status', statusFilter);
 if (typeFilter !== 'all') params.append('type', typeFilter);
 const response = await apiClient.get(`/property-viewing?${params}`) as { data: PropertyViewing[] };
 return response.data;
 }
 });
 const updateStatusMutation = useMutation({
 mutationFn: async ({ viewingId, status }: { viewingId: string; status: string }) => {
 await apiClient.put(`/property-viewing/${viewingId}`, { status });
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['property-viewing'] });
 toast({ title: t("admin_property_success"), description: t("admin_property_viewing_status_updated_successfully") });
 },
 onError: () => {
 toast({ title: t("admin_property_error"), description: t("admin_property_failed_to_update_viewing"), variant:"destructive" });
 }
 });
 const getStatusColor = (status: string) => {
 switch (status) {
 case 'SCHEDULED': return 'bg-muted0';
 case 'CONFIRMED': return 'bg-blue-500';
 case 'COMPLETED': return 'bg-muted0';
 case 'CANCELLED': return 'bg-red-500';
 case 'NO_SHOW': return 'bg-card/10';
 default: return 'bg-card/10';
 }
 };
 const getTypeIcon = (type: string) => {
 switch (type) {
 case 'IN_PERSON': return <Users className="h-4 w-4 text-muted-foreground" />;
 case 'VIRTUAL': return <Eye className="h-4 w-4 text-muted-foreground" />;
 case 'SELF_GUIDED': return <Activity className="h-4 w-4 text-muted-foreground" />;
 default: return <Calendar className="h-4 w-4 text-muted-foreground" />;
 }
 };
 const scheduledViewings = viewings.filter(v => v.status === 'SCHEDULED').length;
 const completedViewings = viewings.filter(v => v.status === 'COMPLETED').length;
 const avgRating = viewings.filter(v => v.feedback?.rating).reduce((acc, v, _, arr) => arr.length > 0 ? acc + (v.feedback?.rating || 0) / arr.length : 0, 0);
 const conversionRate = viewings.length > 0 ? viewings.filter(v => v.feedback?.interested).length / viewings.length * 100 : 0;
 if (isLoading) {
 return <div className="min-h-screen bg-background p-6">
 <div className="bg-card p-6 rounded-2xl border border-border">
 <h1 className="text-xl font-bold text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_property_property_viewings")}</h1>
 </div>
 <div className="flex items-center justify-center h-64 mt-6">
 <Activity className="h-8 w-8 animate-spin text-foreground" />
 </div>
 </div>;
 }
 return <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 min-h-screen bg-background">
 <div className="p-6 space-y-6">
 <div className="bg-card p-6 rounded-2xl border border-border">
 <h1 className="text-xl font-bold text-foreground">{t("admin_property_property_viewings")}</h1>
 </div>

 <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_property_scheduled_viewings")}</CardTitle>
 <Calendar className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">{scheduledViewings}</div>
 <p className="text-xs text-muted-foreground">{t("admin_property_upcoming_appointments")}</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_property_completed_viewings")}</CardTitle>
 <CheckCircle className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-blue-400">{completedViewings}</div>
 <p className="text-xs text-muted-foreground">{t("admin_property_total_completed_this_month")}</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_property_avg_rating")}</CardTitle>
 <Star className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">{avgRating.toFixed(1)}/5</div>
 <p className="text-xs text-muted-foreground">{t("admin_property_customer_satisfaction")}</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_property_conversion_rate")}</CardTitle>
 <TrendingUp className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">{conversionRate.toFixed(1)}%</div>
 <p className="text-xs text-muted-foreground">{t("admin_property_interested_leads")}</p>
 </CardContent>
 </Card>
 </div>

 <Card className="bg-card border-border">
 <CardContent className="pt-6">
 <div className="flex gap-4">
 <div className="flex items-center gap-2">
 <span className="text-sm font-medium text-muted-foreground">{t("admin_property_status")}</span>
 <Select value={statusFilter} onValueChange={setStatusFilter}>
 <SelectTrigger className="w-[150px] bg-card border-border text-foreground">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border text-foreground">
 <SelectItem value="all">{t("admin_property_all_statuses")}</SelectItem>
 <SelectItem value="SCHEDULED">{t("admin_property_scheduled")}</SelectItem>
 <SelectItem value="CONFIRMED">{t("admin_property_confirmed")}</SelectItem>
 <SelectItem value="COMPLETED">{t("admin_property_completed")}</SelectItem>
 <SelectItem value="CANCELLED">{t("admin_property_cancelled")}</SelectItem>
 <SelectItem value="NO_SHOW">{t("admin_property_no_show")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="flex items-center gap-2">
 <span className="text-sm font-medium text-muted-foreground">{t("admin_property_type")}</span>
 <Select value={typeFilter} onValueChange={setTypeFilter}>
 <SelectTrigger className="w-[150px] bg-card border-border text-foreground">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border text-foreground">
 <SelectItem value="all">{t("admin_property_all_types")}</SelectItem>
 <SelectItem value="IN_PERSON">{t("admin_property_in_person")}</SelectItem>
 <SelectItem value="VIRTUAL">{t("admin_property_virtual")}</SelectItem>
 <SelectItem value="SELF_GUIDED">{t("admin_property_self_guided")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_property_property_viewings")}</CardTitle>
 <p className="text-sm text-muted-foreground">{t("admin_property_manage_and_track_property")}</p>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow className="border-border">
 <TableHead className="text-muted-foreground">{t("admin_property_property")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_property_lead")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_property_type")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_property_status")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_property_scheduled")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_property_duration")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_property_rating")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_property_interested")}</TableHead>
 <TableHead className="text-right text-muted-foreground">{t("admin_property_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {viewings.map(viewing => <TableRow key={viewing.id} className="border-border">
 <TableCell className="font-medium text-foreground">
 <div>
 <div className="text-foreground">{viewing.property?.address || `Property ${viewing.propertyId}`}</div>
 <div className="text-xs text-muted-foreground">
 {viewing.property?.city}{t(",", ",")}{viewing.property?.state}
 </div>
 </div>
 </TableCell>
 <TableCell className="text-muted-foreground">
 <div>
 <div className="font-medium text-foreground">{viewing.lead?.name || 'Unknown'}</div>
 <div className="text-xs text-muted-foreground">{viewing.lead?.email}</div>
 </div>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2 text-foreground">
 {getTypeIcon(viewing.viewingType)}
 <span className="capitalize">{viewing.viewingType.replace('_', ' ').toLowerCase()}</span>
 </div>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2 text-foreground">
 <div className={`w-2 h-2 rounded-full ${getStatusColor(viewing.status)}`} />
 <span className="capitalize">{viewing.status.toLowerCase()}</span>
 </div>
 </TableCell>
 <TableCell className="text-muted-foreground">{new Date(viewing.scheduledAt).toLocaleString()}</TableCell>
 <TableCell className="text-muted-foreground">{viewing.duration}{t("admin_property_min")}</TableCell>
 <TableCell>
 {viewing.feedback?.rating ? <div className="flex items-center gap-1">
 <Star className="h-3 w-3 fill-yellow-400 text-yellow-400" />
 <span className="text-sm text-foreground">{viewing.feedback.rating}/5</span>
 </div> : <span className="text-muted-foreground">{t(" - ", "-")}</span>}
 </TableCell>
 <TableCell>
 {viewing.feedback ? viewing.feedback.interested ? <CheckCircle className="h-4 w-4 text-blue-500" /> : <XCircle className="h-4 w-4 text-red-500" /> : <span className="text-muted-foreground">{t(" - ", "-")}</span>}
 </TableCell>
 <TableCell className="text-right">
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="ghost" className="h-8 w-8 p-0 text-muted-foreground" aria-label={t("common.more")}>
 <MoreHorizontal className="h-4 w-4" />
 </Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent align="end" className="bg-card border-border text-foreground">
 <DropdownMenuLabel className="text-muted-foreground">{t("admin_property_actions")}</DropdownMenuLabel>
 <DropdownMenuItem className="hover:bg-card">
 <Eye className="h-4 w-4 mr-2" />{t("admin_property_view_details")}
 </DropdownMenuItem>
 {viewing.status === 'SCHEDULED' && <>
 <DropdownMenuItem className="hover:bg-card" onClick={() => updateStatusMutation.mutate({ viewingId: viewing.id, status: 'CONFIRMED' })}>
 <CheckCircle className="h-4 w-4 mr-2" />{t("admin_property_confirm")}
 </DropdownMenuItem>
 <DropdownMenuItem className="hover:bg-card text-red-600" onClick={() => updateStatusMutation.mutate({ viewingId: viewing.id, status: 'CANCELLED' })}>
 <XCircle className="h-4 w-4 mr-2" />{t("admin_property_cancel")}
 </DropdownMenuItem>
 </>}
 {viewing.status === 'CONFIRMED' && <DropdownMenuItem className="hover:bg-card" onClick={() => updateStatusMutation.mutate({ viewingId: viewing.id, status: 'COMPLETED' })}>
 <CheckCircle className="h-4 w-4 mr-2" />{t("admin_property_mark_complete")}
 </DropdownMenuItem>}
 </DropdownMenuContent>
 </DropdownMenu>
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </CardContent>
 </Card>

 <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_property_viewing_types_distribution")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-4">
 <div className="flex justify-between items-center">
 <span className="text-sm text-foreground flex items-center gap-2">
 <Users className="h-4 w-4 text-muted-foreground" />{t("admin_property_in_person")}</span>
 <span className="font-medium text-foreground">{viewings.filter(v => v.viewingType === 'IN_PERSON').length}</span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm text-foreground flex items-center gap-2">
 <Eye className="h-4 w-4 text-muted-foreground" />{t("admin_property_virtual")}</span>
 <span className="font-medium text-foreground">{viewings.filter(v => v.viewingType === 'VIRTUAL').length}</span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm text-foreground flex items-center gap-2">
 <Activity className="h-4 w-4 text-muted-foreground" />{t("admin_property_self_guided")}</span>
 <span className="font-medium text-foreground">{viewings.filter(v => v.viewingType === 'SELF_GUIDED').length}</span>
 </div>
 </div>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_property_status_overview")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-4">
 <div className="flex justify-between items-center">
 <span className="text-sm text-foreground">{t("admin_property_scheduled")}</span>
 <span className="font-medium text-foreground">{scheduledViewings}</span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm text-foreground">{t("admin_property_confirmed")}</span>
 <span className="font-medium text-foreground">{viewings.filter(v => v.status === 'CONFIRMED').length}</span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm text-foreground">{t("admin_property_completed")}</span>
 <span className="font-medium text-blue-400">{completedViewings}</span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm text-foreground">{t("admin_property_no_show")}</span>
 <span className="font-medium text-red-400">{viewings.filter(v => v.status === 'NO_SHOW').length}</span>
 </div>
 </div>
 </CardContent>
 </Card>
 </div>
 </div>
 </div>;
}
