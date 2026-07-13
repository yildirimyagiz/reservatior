"use client";

import { t } from"i18next";
import { useTranslation } from"react-i18next";
import { useState, useEffect } from"react";
import { PageShell } from"../../client/layout/PageShell";
import { cn } from"@/lib/utils";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Badge } from"@/components/ui/badge";
import { Button } from"@/components/ui/button";
import { Input } from"@/components/ui/input";
import { Tabs, TabsContent, TabsList, TabsTrigger } from"@/components/ui/tabs";
import { Progress } from"@/components/ui/progress";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Switch } from"@/components/ui/switch";
import { Link, RefreshCw, CheckCircle, Database, Eye, Settings, Plus, Search, MapPin, Home, Table, Clapperboard, Sparkles, Calendar, Users as UsersIcon, TrendingUp, ChevronRight } from"lucide-react";
import { TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { mlsApi } from"@/lib/api/mls";
import { useAuth } from"@/lib/auth/hooks";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle, DialogTrigger } from"@/components/ui/dialog";
import { Label } from"@/components/ui/label";
import { useNavigate } from"@/lib/react-router-shim";
import { useToast } from"@/hooks/use-toast";
export type MLSProviderKey = 'RIGHTMOVE' | 'ZOOPLA' | 'ONTHEMARKET' | 'SAVILLS' | 'STRATFORD_GRAHAM' | 'GENERIC_RETS' | 'BRIDGE_API' | 'SPARK_API' | 'ZILLOW' | 'REDFIN' | 'TREB' | 'CREA' | 'IDEALISTA' | 'OTHER';
export type SyncStatus = 'IDLE' | 'RUNNING' | 'SUCCESS' | 'FAILED';
interface MLSConnection {
 id: string;
 orgId: string;
 provider: MLSProviderKey;
 name: string;
 baseUrl?: string;
 isEnabled: boolean;
 status: SyncStatus;
 lastSyncAt?: string;
 lastError?: string;
 createdAt: string;
 updatedAt: string;
 // totalListings is often a calculated field or from config
 totalListings?: number;
}
interface MLSSyncJob {
 id: string;
 orgId: string;
 connectionId: string;
 status: SyncStatus;
 startedAt?: string;
 finishedAt?: string;
 error?: string;
 stats?: any;
 createdAt: string;
 updatedAt: string;
 // UI helper fields
 connectionName?: string;
}
interface MLSExternalListing {
 id: string;
 mlsId: string;
 connectionId: string;
 connectionName: string;
 address: string;
 price: number;
 bedrooms: number;
 bathrooms: number;
 areaSqm: number;
 propertyType: string;
 status: 'ACTIVE' | 'SOLD' | 'PENDING' | 'EXPIRED';
 listedDate: string;
 lastUpdated: string;
 syncedAt: string;
}
interface MlsDataMapping {
 id: string;
 connectionId: string;
 sourceField: string;
 targetField: string;
 fieldType: 'STRING' | 'NUMBER' | 'DATE' | 'BOOLEAN' | 'ARRAY';
 isRequired: boolean;
 transformRule?: string;
 isActive: boolean;
}
export default function MLSIntegration() {
 const {
 t
 } = useTranslation();
 const [connections, setConnections] = useState<MLSConnection[]>([]);
 const [syncJobs, setSyncJobs] = useState<MLSSyncJob[]>([]);
 const [listings, setListings] = useState<MLSExternalListing[]>([]);
 const [dataMappings, setDataMappings] = useState<MlsDataMapping[]>([]);
 const [loading, setLoading] = useState(true);
 const [searchTerm, setSearchTerm] = useState("");
 const [statusFilter, setStatusFilter] = useState("ALL");
 const [isTransferring, setIsTransferring] = useState<string | null>(null);
 const navigate = useNavigate();
 const {
 user: currentUser
 } = useAuth();
 const {
 toast
 } = useToast();
 useEffect(() => {
 fetchMLSData();
 }, []);
 const fetchMLSData = async () => {
 try {
 const [connectionsRes, syncJobsRes, listingsRes, mappingsRes] = await Promise.all([mlsApi.getConnections(), mlsApi.getSyncJobs(), mlsApi.getExternalListings(), mlsApi.getDataMappings()]);
 setConnections(connectionsRes.data);
 setSyncJobs(syncJobsRes.data);
 setListings(listingsRes.data);
 setDataMappings(mappingsRes.data);
 } catch (error) {
 toast({
 title: t("admin_integrations_error"),
 description: t("admin_integrations_failed_to_fetch_mls"),
 variant:"destructive"
 });
 } finally {
 setLoading(false);
 }
 };
 const getStatusColor = (status: string) => {
 switch (status) {
 case 'SUCCESS':
 return 'bg-green-500';
 case 'FAILED':
 return 'bg-red-500';
 case 'RUNNING':
 return 'bg-muted0';
 case 'IDLE':
 return 'bg-white/10';
 default:
 return 'bg-white/10';
 }
 };
 const formatCurrency = (amount: number) => {
 return new Intl.NumberFormat('en-US', {
 style: 'currency',
 currency: 'USD'
 }).format(amount);
 };
 const filteredListings = listings.filter(listing => {
 const matchesSearch = listing.address.toLowerCase().includes(searchTerm.toLowerCase()) || listing.mlsId.toLowerCase().includes(searchTerm.toLowerCase());
 const matchesStatus = statusFilter ==="ALL" || listing.status === statusFilter;
 return matchesSearch && matchesStatus;
 });
 const activeConnections = connections.filter(c => c.isEnabled).length;
 const runningSyncs = syncJobs.filter(s => s.status === 'RUNNING').length;
 const totalListingsCount = connections.reduce((sum, conn) => sum + (conn.totalListings || 0), 0);
 const recentSyncsCount = syncJobs.filter(s => s.status === 'SUCCESS' && s.finishedAt && new Date(s.finishedAt).toDateString() === new Date().toDateString()).length;
 if (loading) {
 return <PageShell title={t("admin_integrations_mls_integration")}>
 <div className="flex items-center justify-center h-64">
 <Database className="h-8 w-8 animate-spin" />
 </div>
 </PageShell>;
 }
 return <PageShell title={t("admin_integrations_mls_integration")}>
 <div className="space-y-6">
 {/* Overview Cards */}
 <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_integrations_active_connections")}</CardTitle>
 <Link className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold">{activeConnections}</div>
 <p className="text-xs text-muted-foreground">{t("admin_integrations_of")}{connections.length}{t("admin_integrations_total")}</p>
 </CardContent>
 </Card>

 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_integrations_running_syncs")}</CardTitle>
 <RefreshCw className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-slate-600">{runningSyncs}</div>
 <p className="text-xs text-muted-foreground">{t("admin_integrations_in_progress")}</p>
 </CardContent>
 </Card>

 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_integrations_total_listings")}</CardTitle>
 <Home className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold">{totalListingsCount.toLocaleString()}</div>
 <p className="text-xs text-muted-foreground">{t("admin_integrations_synchronized_listings")}</p>
 </CardContent>
 </Card>

 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_integrations_recent_syncs")}</CardTitle>
 <CheckCircle className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-green-600">{recentSyncsCount}</div>
 <p className="text-xs text-muted-foreground">{t("admin_integrations_completed_today")}</p>
 </CardContent>
 </Card>
 </div>

 <Tabs defaultValue="connections" className="space-y-4">
 <TabsList>
 <TabsTrigger value="connections">{t("admin_integrations_connections")}</TabsTrigger>
 <TabsTrigger value="sync">{t("admin_integrations_sync_jobs")}</TabsTrigger>
 <TabsTrigger value="listings" className="font-bold text-[10px]">{t("admin_integrations_external_listings")}</TabsTrigger>
 <TabsTrigger value="mappings" className="font-bold text-[10px]">{t("admin_integrations_data_mappings")}</TabsTrigger>
 <TabsTrigger value="roi-insights" className="text-emerald-500 font-bold text-[10px]">{t("admin_integrations_roi_insights")}</TabsTrigger>
 </TabsList>

 <TabsContent value="connections" className="space-y-4">
 <div className="flex justify-end">
 <Dialog>
 <DialogTrigger asChild>
 <Button>
 <Plus className="h-4 w-4 mr-2" />{t("admin_integrations_new_connection")}</Button>
 </DialogTrigger>
 <DialogContent>
 <DialogHeader>
 <DialogTitle>{t("admin_integrations_connect_new_mls_provider")}</DialogTitle>
 <DialogDescription>{t("admin_integrations_select_your_mls_provider")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid gap-2">
 <Label>{t("admin_integrations_mls_provider")}</Label>
 <Select onValueChange={v => toast({
 title: t("admin_integrations_provider_selected"),
 description: `${v} selected. Please provide credentials.`
 })}>
 <SelectTrigger className="bg-muted/50 border-border text-foreground">
 <SelectValue placeholder={t("admin_integrations_chose_provider")} />
 </SelectTrigger>
 <SelectContent className="bg-card border-border text-foreground max-h-[300px]">
 <SelectItem value="BRIDGE_API">{t("admin_integrations_bridge_api_global")}</SelectItem>
 <SelectItem value="SPARK_API">{t("admin_integrations_spark_api_north_america")}</SelectItem>
 <SelectItem value="ZILLOW">{t("admin_integrations_zillow_redfin_scraper")}</SelectItem>
 <SelectItem value="TREB">{t("admin_integrations_treb_toronto")}</SelectItem>
 <SelectItem value="CREA">{t("admin_integrations_crea_realtorca")}</SelectItem>
 <SelectItem value="IDEALISTA">{t("admin_integrations_idealista_europe")}</SelectItem>
 <SelectItem value="RIGHTMOVE">{t("admin_integrations_rightmove_zoopla_uk")}</SelectItem>
 <SelectItem value="GENERIC_RETS">{t("admin_integrations_generic_rets_idx")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="grid gap-2">
 <Label>{t("admin_integrations_connection_name")}</Label>
 <Input placeholder={t("admin_integrations_eg_my_zillow_feed")} className="bg-muted/50 border-border" />
 </div>
 <div className="grid gap-2">
 <Label>{t("admin_integrations_base_url_endpoint")}</Label>
 <Input placeholder={t("admin_integrations_https")} className="bg-muted/50 border-border" />
 </div>
 </div>
 <Button onClick={() => toast({
 title: t("admin_integrations_integration_request_sent"),
 description: t("admin_integrations_our_ai_is_verifying")
 })}>{t("admin_integrations_connect_feed")}</Button>
 </DialogContent>
 </Dialog>
 </div>

 <Card>
 <CardHeader>
 <CardTitle>{t("admin_integrations_mls_connections")}</CardTitle>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_integrations_name")}</TableHead>
 <TableHead>{t("admin_integrations_provider")}</TableHead>
 <TableHead>{t("admin_integrations_endpoint")}</TableHead>
 <TableHead>{t("admin_integrations_status")}</TableHead>
 <TableHead>{t("admin_integrations_sync_frequency")}</TableHead>
 <TableHead>{t("admin_integrations_listings")}</TableHead>
 <TableHead>{t("admin_integrations_last_sync")}</TableHead>
 <TableHead>{t("admin_integrations_active")}</TableHead>
 <TableHead>{t("admin_integrations_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {connections.map(connection => <TableRow key={connection.id}>
 <TableCell className="font-medium">{connection.name}</TableCell>
 <TableCell>
 <Badge variant="outline">{connection.provider}</Badge>
 </TableCell>
 <TableCell className="font-mono text-sm">{connection.baseUrl || '-'}</TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 <div className={`w-2 h-2 rounded-full ${getStatusColor(connection.status)}`} />
 <span className="capitalize">{connection.status.toLowerCase()}</span>
 </div>
 </TableCell>
 <TableCell>
 <Badge variant="outline">{t("admin_integrations_daily")}</Badge>
 </TableCell>
 <TableCell>{(connection.totalListings || 0).toLocaleString()}</TableCell>
 <TableCell>{connection.lastSyncAt ? new Date(connection.lastSyncAt).toLocaleDateString() : '-'}</TableCell>
 <TableCell>
 <Switch checked={connection.isEnabled} />
 </TableCell>
 <TableCell>
 <div className="flex gap-1">
 <Button variant="ghost" size="sm">
 <Settings className="h-4 w-4" />
 </Button>
 <Button variant="ghost" size="sm">
 <RefreshCw className="h-4 w-4" />
 </Button>
 </div>
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </CardContent>
 </Card>
 </TabsContent>

 <TabsContent value="sync" className="space-y-4">
 <div className="flex justify-end">
 <Button onClick={() => toast({
 title: t("admin_integrations_coming_soon"),
 description: t("admin_integrations_this_feature_is_being")
 })}>
 <Plus className="h-4 w-4 mr-2" />{t("admin_integrations_start_sync")}</Button>
 </div>

 <Card>
 <CardHeader>
 <CardTitle>{t("admin_integrations_sync_jobs")}</CardTitle>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_integrations_connection")}</TableHead>
 <TableHead>{t("admin_integrations_type")}</TableHead>
 <TableHead>{t("admin_integrations_status")}</TableHead>
 <TableHead>{t("admin_integrations_progress")}</TableHead>
 <TableHead>{t("admin_integrations_started")}</TableHead>
 <TableHead>{t("admin_integrations_completed")}</TableHead>
 <TableHead>{t("admin_integrations_duration")}</TableHead>
 <TableHead>{t("admin_integrations_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {syncJobs.map(job => {
 const duration = job.finishedAt && job.startedAt ? new Date(job.finishedAt).getTime() - new Date(job.startedAt).getTime() : job.startedAt ? Date.now() - new Date(job.startedAt).getTime() : 0;
 return <TableRow key={job.id}>
 <TableCell className="font-medium">{job.connectionName}</TableCell>
 <TableCell>
 <Badge variant="outline">{t("admin_integrations_incremental")}</Badge>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 <div className={`w-2 h-2 rounded-full ${getStatusColor(job.status)}`} />
 <span className="capitalize">{job.status.toLowerCase()}</span>
 </div>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 <div className="w-16 bg-card rounded-full h-2">
 <div className="bg-slate-600 h-2 rounded-full" style={{
 width: `100%`
 }} />
 </div>
 <span className="text-sm">100%</span>
 </div>
 </TableCell>
 <TableCell>{job.startedAt ? new Date(job.startedAt).toLocaleString() : '-'}</TableCell>
 <TableCell>
 {job.finishedAt ? new Date(job.finishedAt).toLocaleString() : '-'}
 </TableCell>
 <TableCell>{Math.round(duration / 1000)}s</TableCell>
 <TableCell>
 <Button variant="ghost" size="sm">
 <Eye className="h-4 w-4" />
 </Button>
 </TableCell>
 </TableRow>;
 })}
 </TableBody>
 </Table>
 </CardContent>
 </Card>
 </TabsContent>

 <TabsContent value="listings" className="space-y-4">
 <div className="flex gap-2">
 <div className="relative">
 <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
 <Input placeholder={t("admin_integrations_search_listings")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-8 w-64" />
 </div>
 <Select value={statusFilter} onValueChange={setStatusFilter}>
 <SelectTrigger className="w-32">
 <SelectValue />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="ALL">{t("admin_integrations_all_status")}</SelectItem>
 <SelectItem value="ACTIVE">{t("admin_integrations_active")}</SelectItem>
 <SelectItem value="SOLD">{t("admin_integrations_sold")}</SelectItem>
 <SelectItem value="PENDING">{t("admin_integrations_pending")}</SelectItem>
 <SelectItem value="EXPIRED">{t("admin_integrations_expired")}</SelectItem>
 </SelectContent>
 </Select>
 </div>

 <Card>
 <CardHeader>
 <CardTitle>{t("admin_integrations_external_mls_listings")}</CardTitle>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_integrations_mls_id")}</TableHead>
 <TableHead>{t("admin_integrations_address")}</TableHead>
 <TableHead>{t("admin_integrations_price")}</TableHead>
 <TableHead>{t("admin_integrations_details")}</TableHead>
 <TableHead>{t("admin_integrations_status")}</TableHead>
 <TableHead>{t("admin_integrations_connection")}</TableHead>
 <TableHead>{t("admin_integrations_listed")}</TableHead>
 <TableHead>{t("admin_integrations_synced")}</TableHead>
 <TableHead>{t("admin_integrations_neural_score")}</TableHead>
 <TableHead>{t("admin_integrations_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {filteredListings.map(listing => <TableRow key={listing.id}>
 <TableCell className="font-medium">{listing.mlsId}</TableCell>
 <TableCell>
 <div className="flex items-center gap-1">
 <MapPin className="h-3 w-3 text-muted-foreground" />
 {listing.address || 'N/A'}
 </div>
 </TableCell>
 <TableCell className="font-semibold">{listing.price ? formatCurrency(listing.price) : 'N/A'}</TableCell>
 <TableCell>
 <div className="text-sm">
 <div>{listing.bedrooms || 'N/A'}{t("admin_integrations_bed")}{listing.bathrooms || 'N/A'}{t("admin_integrations_bath")}</div>
 <div>{listing.areaSqm ? `${listing.areaSqm} m²` : 'N/A'} • {listing.propertyType || 'N/A'}</div>
 </div>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 <div className={`w-2 h-2 rounded-full ${getStatusColor(listing.status || 'UNKNOWN')}`} />
 <span className="capitalize">{(listing.status || 'unknown').toLowerCase()}</span>
 </div>
 </TableCell>
 <TableCell>{listing.connectionName || 'Unknown'}</TableCell>
 <TableCell>{listing.listedDate ? new Date(listing.listedDate).toLocaleDateString() : 'N/A'}</TableCell>
 <TableCell>{new Date(listing.syncedAt).toLocaleDateString()}</TableCell>
 <TableCell>
 {(() => {
 const raw = (listing as any).raw || {};
 const score = Math.min(100, (raw.media?.images?.length || 0) * 10 + ((raw.description?.length || 100) > 100 ? 30 : 10) + (raw.location?.lat ? 20 : 0));
 return <div className="flex items-center gap-2">
 <div className="flex-1 h-1.5 bg-muted/50 rounded-full overflow-hidden w-12">
 <div className={cn("h-full", score > 80 ?"bg-emerald-500" : score > 50 ?"bg-muted0" :"bg-orange-500")} style={{
 width: `${score}%`
 }} />
 </div>
 <span className="text-[10px] font-bold">{score}%</span>
 </div>;
 })()}
 </TableCell>
 <TableCell>
 <div className="flex gap-1">
 {/* Neural Staging Button */}
 <Button variant="ghost" size="sm" className="text-orange-400 hover:text-orange-300 hover:bg-orange-500/10" title={t("admin_integrations_neural_staging_virtual_furniture")} onClick={async () => {
 if (!currentUser) return;
 toast({
 title: t("admin_integrations_neural_staging"),
 description: `Converting ${listing.mlsId} and preparing AI transformation...`
 });
 try {
 // Step 1: Convert to project if not already
 const convertRes = await mlsApi.convert(listing.id, currentUser.orgId ||"", currentUser.id ||"");
 if (convertRes.success) {
 // Step 2: Trigger AI Staging
 await mlsApi.superchargeStaging(convertRes.propertyId, currentUser.orgId ||"", (listing as any).raw?.media?.images?.[0] ||"");
 toast({
 title: t("admin_integrations_neural_suite_active"),
 description: t("admin_integrations_ai_is_now_staging")
 });
 }
 } catch (e) {
 toast({
 title: t("admin_integrations_action_failed"),
 description: t("admin_integrations_could_not_initiate_staging"),
 variant:"destructive"
 });
 }
 }}>
 <Home className="h-4 w-4" />
 </Button>

 {/* Neural Video Button */}
 <Button variant="ghost" size="sm" className="text-muted-foreground hover:text-slate-300 hover:bg-muted0/10" title={t("admin_integrations_generate_neural_reels_video")} onClick={async () => {
 if (!currentUser) return;
 toast({
 title: t("admin_integrations_neural_reels"),
 description: `Generating cinematic content for ${listing.mlsId}...`
 });
 try {
 const convertRes = await mlsApi.convert(listing.id, currentUser.orgId ||"", currentUser.id ||"");
 if (convertRes.success) {
 await mlsApi.superchargeReels(convertRes.propertyId, currentUser.orgId ||"", (listing as any).raw?.media?.images || []);
 toast({
 title: t("admin_integrations_production_started"),
 description: t("admin_integrations_neural_reel_is_being")
 });
 }
 } catch (e) {
 toast({
 title: t("admin_integrations_production_failed"),
 description: t("admin_integrations_could_not_generate_video"),
 variant:"destructive"
 });
 }
 }}>
 <Clapperboard className="h-4 w-4" />
 </Button>

 <Button variant="ghost" size="sm" title={t("admin_integrations_convert_to_project_neural")} disabled={isTransferring === listing.id} className="text-emerald-500 hover:text-emerald-400 hover:bg-emerald-500/10" onClick={async () => {
 if (!currentUser) return;
 setIsTransferring(listing.id);
 toast({
 title: t("admin_integrations_neural_studio"),
 description: `Extracting assets from ${listing.mlsId}...`
 });
 try {
 if (!currentUser?.orgId || !currentUser?.id) throw new Error("Auth required");
 const response = await mlsApi.convert(listing.id, currentUser.orgId, currentUser.id);
 if (response.success) {
 toast({
 title: t("admin_integrations_transfer_complete"),
 description: t("admin_integrations_listing_has_been_converted")
 });
 navigate("/admin/projects");
 }
 } catch (e) {
 toast({
 title: t("admin_integrations_transfer_failed"),
 description: t("admin_integrations_could_not_migrate_listing"),
 variant:"destructive"
 });
 } finally {
 setIsTransferring(null);
 }
 }}>
 {isTransferring === listing.id ? <RefreshCw className="h-4 w-4 animate-spin" /> : <Sparkles className="h-4 w-4" />}
 </Button>
 
 <Dialog>
 <DialogTrigger asChild>
 <Button variant="ghost" size="sm" title={t("admin_integrations_invite_homeowner_for_ai")} className="text-muted-foreground hover:text-slate-300 hover:bg-muted0/10">
 <UsersIcon className="h-4 w-4" />
 </Button>
 </DialogTrigger>
 <DialogContent className="bg-[#0f1014] border-border shadow-2xl shadow-slate-500/10">
 <DialogHeader>
 <DialogTitle className="flex items-center gap-2 text-foreground">
 <UsersIcon className="w-5 h-5 text-muted-foreground" />{t("admin_integrations_invite_homeowner")}{listing.mlsId}
 </DialogTitle>
 <DialogDescription className="text-muted-foreground">{t("admin_integrations_invite_the_owner_to")}<strong>{t("admin_integrations_staging_results")}</strong>{t("admin_integrations_and_approve_the_virtual")}</DialogDescription>
 </DialogHeader>
 <div className="space-y-4 py-4">
 <div className="grid gap-2">
 <Label className="text-[10px] font-bold text-muted-foreground">{t("admin_integrations_owners_email_address")}</Label>
 <Input placeholder={t("admin_integrations_ownerluxuryresidencecom")} className="bg-muted/50 border-border text-foreground h-12 rounded-xl" />
 </div>
 <div className="p-4 bg-muted0/5 border border-slate-500/10 rounded-2xl">
 <p className="text-[10px] text-slate-300/70 font-medium leading-relaxed">{t("admin_integrations_a_personalized_neural_dashboard")}</p>
 </div>
 </div>
 <Button className="w-full bg-slate-600 hover:bg-muted0 text-foreground font-bold h-12 rounded-xl" onClick={() => toast({
 title: t("admin_integrations_invitation_sent"),
 description: t("admin_integrations_host_dashboard_invitation_is")
 })}>{t("admin_integrations_send_neural_invite")}</Button>
 </DialogContent>
 </Dialog>

 <Button variant="ghost" size="sm" title={t("admin_integrations_sales_support_closing_management")} className="text-muted-foreground">
 <Table className="h-4 w-4" />
 </Button>
 </div>
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </CardContent>
 </Card>
 </TabsContent>

 <TabsContent value="mappings" className="space-y-4">
 <Card>
 <CardHeader>
 <CardTitle>{t("admin_integrations_field_mappings")}</CardTitle>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_integrations_source_field")}</TableHead>
 <TableHead>{t("admin_integrations_target_field")}</TableHead>
 <TableHead>{t("admin_integrations_field_type")}</TableHead>
 <TableHead>{t("admin_integrations_required")}</TableHead>
 <TableHead>{t("admin_integrations_transform_rule")}</TableHead>
 <TableHead>{t("admin_integrations_active")}</TableHead>
 <TableHead>{t("admin_integrations_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {dataMappings.map(mapping => <TableRow key={mapping.id}>
 <TableCell className="font-mono text-sm">{mapping.sourceField}</TableCell>
 <TableCell className="font-mono text-sm">{mapping.targetField}</TableCell>
 <TableCell>
 <Badge variant="outline">{mapping.fieldType}</Badge>
 </TableCell>
 <TableCell>
 {mapping.isRequired ? <CheckCircle className="h-4 w-4 text-red-600" /> : <div className="w-4 h-4" />}
 </TableCell>
 <TableCell className="font-mono text-xs max-w-xs truncate">
 {mapping.transformRule || '-'}
 </TableCell>
 <TableCell>
 <Switch checked={mapping.isActive} />
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </CardContent>
 </Card>
 </TabsContent>
 <TabsContent value="roi-insights" className="space-y-6">
 <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
 <Card className="bg-orange-950/10 border-orange-500/20 relative overflow-hidden group">
 <div className="absolute top-0 right-0 p-4 opacity-10 group-hover:opacity-20 transition-opacity">
 <div className="text-8xl font-bold select-none">{t("admin_integrations_trex")}</div>
 </div>
 <CardHeader>
 <CardTitle className="text-orange-400 flex items-center gap-2 text-sm">
 <div className="w-2 h-2 rounded-full bg-orange-500 animate-pulse" />{t("admin_integrations_dinosaur_mls_performance")}</CardTitle>
 </CardHeader>
 <CardContent className="space-y-6">
 <div className="space-y-4">
 {[{
 label: t("admin_integrations_reach_local_only"),
 val: 15,
 max: 100,
 color:"bg-orange-500"
 }, {
 label: t("admin_integrations_conversion_rate"),
 val: 8,
 max: 100,
 color:"bg-orange-500"
 }, {
 label: t("admin_integrations_engagement_velocity"),
 val: 12,
 max: 100,
 color:"bg-orange-500"
 }].map((metric, i) => <div key={i} className="space-y-2">
 <div className="flex justify-between text-[10px] font-bold text-orange-300/60">
 <span>{metric.label}</span>
 <span>{metric.val}%</span>
 </div>
 <Progress value={metric.val} className="h-1 bg-orange-500/10" />
 </div>)}
 </div>
 <div className="p-4 bg-orange-500/5 rounded-2xl border border-orange-500/10">
 <p className="text-[10px] text-orange-200/50 leading-relaxed font-bold">{t("admin_integrations_static_photos_and_manual")}</p>
 </div>
 </CardContent>
 </Card>

 <Card className="bg-emerald-950/10 border-emerald-500/20 relative overflow-hidden group">
 <div className="absolute top-0 right-0 p-4 opacity-10 group-hover:opacity-20 transition-opacity">
 <Sparkles className="w-32 h-32 text-emerald-500" />
 </div>
 <CardHeader>
 <CardTitle className="text-emerald-400 flex items-center gap-2 text-sm">
 <Sparkles className="w-5 h-5" />{t("admin_integrations_neural_reservatior_roi")}</CardTitle>
 </CardHeader>
 <CardContent className="space-y-6">
 <div className="space-y-4">
 {[{
 label: t("admin_integrations_global_reach_14_languages"),
 val: 88,
 max: 100,
 color:"bg-emerald-500"
 }, {
 label: t("admin_integrations_ai_staging_conversion"),
 val: 72,
 max: 100,
 color:"bg-emerald-500"
 }, {
 label: t("admin_integrations_booking_speed_reels_powered"),
 val: 94,
 max: 100,
 color:"bg-emerald-500"
 }].map((metric, i) => <div key={i} className="space-y-2">
 <div className="flex justify-between text-[10px] font-bold text-emerald-300">
 <span>{metric.label}</span>
 <span className="flex items-center gap-1">+{metric.val}% <TrendingUp className="w-3 h-3" /></span>
 </div>
 <Progress value={metric.val} className={`h-1 bg-emerald-500/10`} />
 </div>)}
 </div>
 <div className="p-4 bg-emerald-500/5 rounded-2xl border border-emerald-500/10 shadow-[0_0_20px_rgba(16,185,129,0.05)]">
 <p className="text-[10px] text-emerald-200/70 leading-relaxed font-bold">{t("admin_integrations_bypassing_the_extinction_neural")}</p>
 </div>
 </CardContent>
 </Card>
 </div>

 <Card className="bg-slate-950/10 border-slate-500/20 shadow-2xl relative overflow-hidden">
 <div className="absolute inset-0 bg-muted0/5 pointer-events-none" />
 <CardContent className="p-8 flex flex-col md:flex-row items-center justify-between gap-8 relative z-10">
 <div className="space-y-2 text-center md:text-left">
 <h2 className="text-3xl font-bold text-foreground">{t("admin_integrations_the_extinction_gap")}</h2>
 <p className="text-sm text-slate-300/70 font-medium max-w-sm">{t("admin_integrations_modernizing_with_neural_reels")}</p>
 </div>
 <div className="flex flex-col md:flex-row items-center gap-6">
 <div className="text-center p-6 bg-muted/50 rounded-[32px] border border-border backdrop-blur-md">
 <p className="text-[10px] font-bold text-muted-foreground">{t("admin_integrations_est_revenue_boost")}</p>
 <p className="text-2xl font-bold text-emerald-500">+340%</p>
 </div>
 <Button className="h-20 px-8 bg-slate-600 hover:bg-muted0 font-bold rounded-[24px] shadow-[0_0_40px_rgba(37,99,235,0.3)] group">{t("admin_integrations_upgrade_all_listings")}<ChevronRight className="w-5 h-5 ml-2 group-hover:translate-x-1 transition-transform" />
 </Button>
 </div>
 </CardContent>
 </Card>
 </TabsContent>
 </Tabs>

 {/* Marketing/Upsell Section */}
 <Card className="bg-emerald-600/10 border-emerald-600/20 overflow-hidden relative">
 <div className="absolute top-0 right-0 p-8 opacity-10">
 <Sparkles className="w-32 h-32 text-emerald-500" />
 </div>
 <CardHeader>
 <CardTitle className="text-emerald-500 flex items-center justify-between">
 <div className="flex items-center gap-2">
 <Sparkles className="w-5 h-5" />{t("admin_integrations_extinction_of_the_dinosaur")}</div>
 <Badge variant="outline" className="border-orange-500/50 text-orange-400 bg-orange-500/10">{t("admin_integrations_bypass_the_48hour_wait")}</Badge>
 </CardTitle>
 </CardHeader>
 <CardContent className="space-y-4 relative z-10">
 <p className="text-sm text-muted-foreground max-w-2xl font-medium leading-relaxed">{t("admin_integrations_dont_let_your_listings")}<strong>{t("admin_integrations_reservatior_neural_studio")}</strong>{t("admin_integrations_bypasses_the_legacy_friction")}</p>
 <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mt-6">
 <div className="p-4 bg-muted/50 rounded-2xl border border-border space-y-2">
 <div className="w-8 h-8 rounded-lg bg-muted0/20 flex items-center justify-center">
 <Clapperboard className="w-4 h-4 text-muted-foreground" />
 </div>
 <h4 className="text-xs font-bold text-foreground">{t("admin_integrations_neural_reels")}</h4>
 <p className="text-[10px] text-muted-foreground">{t("admin_integrations_automatic_cinematic_video_generation")}</p>
 </div>
 <div className="p-4 bg-muted/50 rounded-2xl border border-border space-y-2">
 <div className="w-8 h-8 rounded-lg bg-muted0/20 flex items-center justify-center">
 <RefreshCw className="w-4 h-4 text-muted-foreground" />
 </div>
 <h4 className="text-xs font-bold text-foreground">{t("admin_integrations_multilang_seo")}</h4>
 <p className="text-[10px] text-muted-foreground">{t("admin_integrations_autotranslate_listings_to_capture")}</p>
 </div>
 <div className="p-4 bg-muted/50 rounded-2xl border border-border space-y-2">
 <div className="w-8 h-8 rounded-lg bg-orange-500/20 flex items-center justify-center">
 <Calendar className="w-4 h-4 text-orange-400" />
 </div>
 <h4 className="text-xs font-bold text-foreground">{t("admin_integrations_booking_capture")}</h4>
 <p className="text-[10px] text-muted-foreground">{t("admin_integrations_turn_browsing_into_bookings")}</p>
 </div>
 </div>
 </CardContent>
 </Card>
 </div>
 </PageShell>;
}
;