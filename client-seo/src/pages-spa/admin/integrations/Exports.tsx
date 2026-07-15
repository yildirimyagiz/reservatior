"use client";

import { t } from"i18next";
import { useTranslation } from"react-i18next";
import React, { useState, useEffect } from"react";
import { PageShell } from"../../client/layout/PageShell";
import { Button } from"@/components/ui/button";
import { Badge } from"@/components/ui/badge";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from"@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from"@/components/ui/card";
import { useToast } from"@/hooks/use-toast";
import { apiClient } from"@/lib/api/client";
import { Trash2, MoreHorizontal, Search, Download, Eye, RefreshCw, FileText, Database, Users, Building2, Clock, CheckCircle, XCircle, AlertTriangle, FileDown, Settings } from"lucide-react";
interface Export {
 id: string;
 orgId: string;
 name: string;
 type: ExportType;
 format: ExportFormat;
 status: ExportStatus;
 recordCount: number;
 fileSize: number;
 filePath?: string;
 downloadUrl?: string;
 expiresAt?: string;
 parameters: {
 filters?: Record<string, any>;
 dateRange?: {
 start: string;
 end: string;
 };
 fields?: string[];
 includeHeaders?: boolean;
 compression?: boolean;
 };
 createdBy: string;
 createdAt: string;
 updatedAt: string;
 completedAt?: string;
 user?: {
 id: string;
 name: string;
 email: string;
 };
}
enum ExportType {
 PROPERTIES ="PROPERTIES",
 LISTINGS ="LISTINGS",
 TENANTS ="TENANTS",
 CONTRACTS ="CONTRACTS",
 PAYMENTS ="PAYMENTS",
 FINANCIAL ="FINANCIAL",
 REPORTS ="REPORTS",
 USERS ="USERS",
 AUDIT_LOGS ="AUDIT_LOGS",
 CUSTOM ="CUSTOM",
}
enum ExportFormat {
 CSV ="CSV",
 EXCEL ="EXCEL",
 JSON ="JSON",
 PDF ="PDF",
 XML ="XML",
}
enum ExportStatus {
 COMPLETED ="COMPLETED",
 PROCESSING ="PROCESSING",
 FAILED ="FAILED",
 QUEUED ="QUEUED",
 CANCELLED ="CANCELLED",
 EXPIRED ="EXPIRED",
}
const EXPORT_TYPE_CONFIG = {
 PROPERTIES: {
 label: t("admin_integrations_properties"),
 icon: Building2,
 color:"bg-green-100 text-green-700"
 },
 LISTINGS: {
 label: t("admin_integrations_listings"),
 icon: Building2,
 color:"bg-slate-100 text-slate-700"
 },
 TENANTS: {
 label: t("admin_integrations_tenants"),
 icon: Users,
 color:"bg-slate-100 text-slate-700"
 },
 CONTRACTS: {
 label: t("admin_integrations_contracts"),
 icon: FileText,
 color:"bg-orange-100 text-orange-700"
 },
 PAYMENTS: {
 label: t("admin_integrations_payments"),
 icon: Database,
 color:"bg-red-100 text-red-700"
 },
 FINANCIAL: {
 label: t("admin_integrations_financial"),
 icon: Database,
 color:"bg-emerald-100 text-emerald-700"
 },
 REPORTS: {
 label: t("admin_integrations_reports"),
 icon: FileText,
 color:"bg-slate-100 text-slate-700"
 },
 USERS: {
 label: t("admin_integrations_users"),
 icon: Users,
 color:"bg-card text-slate-300"
 },
 AUDIT_LOGS: {
 label: t("admin_integrations_audit_logs"),
 icon: Settings,
 color:"bg-pink-100 text-pink-700"
 },
 CUSTOM: {
 label: t("admin_integrations_custom"),
 icon: Settings,
 color:"bg-yellow-100 text-yellow-700"
 }
};
const STATUS_CONFIG = {
 COMPLETED: {
 label: t("admin_integrations_completed"),
 color:"bg-green-100 text-green-700",
 icon: CheckCircle
 },
 PROCESSING: {
 label: t("admin_integrations_processing"),
 color:"bg-slate-100 text-slate-700",
 icon: RefreshCw
 },
 FAILED: {
 label: t("admin_integrations_failed"),
 color:"bg-red-100 text-red-700",
 icon: XCircle
 },
 QUEUED: {
 label: t("admin_integrations_queued"),
 color:"bg-yellow-100 text-yellow-700",
 icon: Clock
 },
 CANCELLED: {
 label: t("admin_integrations_cancelled"),
 color:"bg-card text-slate-300",
 icon: XCircle
 },
 EXPIRED: {
 label: t("admin_integrations_expired"),
 color:"bg-orange-100 text-orange-700",
 icon: AlertTriangle
 }
};
export default function Exports() {
 const {
 t
 } = useTranslation();
 const {
 toast
 } = useToast();
 const [search, setSearch] = useState("");
 const [filterType, setFilterType] = useState("all");
 const [filterStatus, setFilterStatus] = useState("all");
 const [filterFormat, setFilterFormat] = useState("all");
 const [viewOpen, setViewOpen] = useState(false);
 const [exports, setExports] = useState<Export[]>([]);
 const [loading, setLoading] = useState(true);
 const [selectedExport, setSelectedExport] = useState<Export | null>(null);

 // Fetch exports from API
 useEffect(() => {
 const fetchExports = async () => {
 try {
 setLoading(true);
 const response = await apiClient.get('/exports', {
 page:"1",
 limit:"50",
 include:"user"
 });
 setExports((response as any).data || []);
 } catch (error) {
 console.error('Error fetching exports:', error);
 toast({
 title: t("admin_integrations_error"),
 description: t("admin_integrations_failed_to_load_exports"),
 variant:"destructive"
 });
 } finally {
 setLoading(false);
 }
 };
 fetchExports();
 }, []);
 const filteredExports = exports.filter(export_ => {
 const matchesSearch = export_.name.toLowerCase().includes(search.toLowerCase()) || export_.user?.name?.toLowerCase().includes(search.toLowerCase());
 const matchesType = filterType ==="all" || export_.type === filterType;
 const matchesStatus = filterStatus ==="all" || export_.status === filterStatus;
 const matchesFormat = filterFormat ==="all" || export_.format === filterFormat;
 return matchesSearch && matchesType && matchesStatus && matchesFormat;
 });
 const totalExports = filteredExports.length;
 const completedExports = filteredExports.filter(e => e.status ==="COMPLETED").length;
 const processingExports = filteredExports.filter(e => e.status ==="PROCESSING").length;
 const totalSize = filteredExports.reduce((sum, e) => sum + e.fileSize, 0);
 const handleDownloadExport = async (export_: Export) => {
 try {
 if (export_.downloadUrl) {
 window.open(export_.downloadUrl, '_blank');
 } else if (export_.filePath) {
 const response = await apiClient.get(`/exports/${export_.id}/download`, {
 responseType: 'blob'
 });

 // Create download link
 const blob = new Blob([(response as any).data]);
 const url = window.URL.createObjectURL(blob);
 const a = document.createElement('a');
 a.href = url;
 a.download = `${export_.name}.${export_.format.toLowerCase()}`;
 document.body.appendChild(a);
 a.click();
 document.body.removeChild(a);
 window.URL.revokeObjectURL(url);
 }
 } catch (error) {
 console.error('Error downloading export:', error);
 toast({
 title: t("admin_integrations_download_failed"),
 description: t("admin_integrations_failed_to_download_export"),
 variant:"destructive"
 });
 }
 };
 const handleDeleteExport = async (id: string) => {
 try {
 await apiClient.delete(`/exports/${id}`);
 setExports(exports.filter(e => e.id !== id));
 toast({
 title: t("admin_integrations_export_deleted"),
 description: t("admin_integrations_export_has_been_deleted")
 });
 } catch (error) {
 console.error('Error deleting export:', error);
 toast({
 title: t("admin_integrations_delete_failed"),
 description: t("admin_integrations_failed_to_delete_export"),
 variant:"destructive"
 });
 }
 };
 const handleRefreshExports = async () => {
 try {
 const response = await apiClient.get('/exports', {
 include:"user"
 });
 setExports((response as any).data || []);
 toast({
 title: t("admin_integrations_exports_refreshed"),
 description: t("admin_integrations_export_list_has_been")
 });
 } catch (error) {
 console.error('Error refreshing exports:', error);
 }
 };
 const formatFileSize = (bytes: number) => {
 if (bytes === 0) return '0 Bytes';
 const k = 1024;
 const sizes = ['Bytes', 'KB', 'MB', 'GB'];
 const i = Math.floor(Math.log(bytes) / Math.log(k));
 return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
 };
 const formatDate = (dateString: string) => {
 return new Date(dateString).toLocaleDateString();
 };
 const formatDateTime = (dateString: string) => {
 return new Date(dateString).toLocaleString();
 };
 const getExportTypeConfig = (type: ExportType) => {
 const config = EXPORT_TYPE_CONFIG[type as keyof typeof EXPORT_TYPE_CONFIG];
 return config || {
 label: type,
 icon: Settings,
 color:"bg-card text-slate-300"
 };
 };
 const getStatusConfig = (status: ExportStatus) => {
 const config = STATUS_CONFIG[status as keyof typeof STATUS_CONFIG];
 return config || {
 label: status,
 icon: Clock,
 color:"bg-card text-slate-300"
 };
 };
 const isExpired = (export_: Export) => {
 if (!export_.expiresAt) return false;
 return new Date(export_.expiresAt) < new Date();
 };
 return <PageShell title={t("admin_integrations_exports")} description={t("admin_integrations_manage_completed_data_exports")}>
 <div className="space-y-6">
 {/* Summary Cards */}
 <div className="grid gap-4 md:grid-cols-4">
 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_integrations_total_exports")}</CardTitle>
 <FileDown className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold">{totalExports}</div>
 <p className="text-xs text-muted-foreground">{t("admin_integrations_all_export_files")}</p>
 </CardContent>
 </Card>
 
 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_integrations_completed")}</CardTitle>
 <CheckCircle className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-green-600">{completedExports}</div>
 <p className="text-xs text-muted-foreground">{t("admin_integrations_ready_for_download")}</p>
 </CardContent>
 </Card>
 
 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_integrations_processing")}</CardTitle>
 <RefreshCw className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-slate-600">{processingExports}</div>
 <p className="text-xs text-muted-foreground">{t("admin_integrations_being_generated")}</p>
 </CardContent>
 </Card>
 
 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_integrations_total_size")}</CardTitle>
 <Database className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-slate-600">{formatFileSize(totalSize)}</div>
 <p className="text-xs text-muted-foreground">{t("admin_integrations_storage_used")}</p>
 </CardContent>
 </Card>
 </div>

 {/* Filters and Actions */}
 <div className="flex items-center justify-between space-x-4">
 <div className="flex items-center space-x-2">
 <div className="relative">
 <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
 <Input placeholder={t("admin_integrations_search_exports")} value={search} onChange={(e: React.ChangeEvent<HTMLInputElement>) => setSearch(e.target.value)} className="pl-8 w-64" />
 </div>
 <Select value={filterType} onValueChange={setFilterType}>
 <SelectTrigger className="w-32">
 <SelectValue placeholder={t("admin_integrations_type")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="all">{t("admin_integrations_all_types")}</SelectItem>
 {Object.entries(EXPORT_TYPE_CONFIG).map(([key, config]) => <SelectItem key={key} value={key}>
 {config.label}
 </SelectItem>)}
 </SelectContent>
 </Select>
 <Select value={filterStatus} onValueChange={setFilterStatus}>
 <SelectTrigger className="w-32">
 <SelectValue placeholder={t("admin_integrations_status")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="all">{t("admin_integrations_all_status")}</SelectItem>
 {Object.entries(STATUS_CONFIG).map(([key, config]) => <SelectItem key={key} value={key}>
 {config.label}
 </SelectItem>)}
 </SelectContent>
 </Select>
 <Select value={filterFormat} onValueChange={setFilterFormat}>
 <SelectTrigger className="w-32">
 <SelectValue placeholder={t("admin_integrations_format")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="all">{t("admin_integrations_all_formats")}</SelectItem>
 <SelectItem value="CSV">{t("admin_integrations_csv")}</SelectItem>
 <SelectItem value="EXCEL">{t("admin_integrations_excel")}</SelectItem>
 <SelectItem value="JSON">{t("admin_integrations_json")}</SelectItem>
 <SelectItem value="PDF">{t("admin_integrations_pdf")}</SelectItem>
 <SelectItem value="XML">{t("admin_integrations_xml")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <Button variant="outline" onClick={handleRefreshExports}>
 <RefreshCw className="h-4 w-4 mr-2" />{t("admin_integrations_refresh")}</Button>
 </div>

 {/* Exports Table */}
 <Card>
 <CardHeader>
 <CardTitle>{t("admin_integrations_export_files")}</CardTitle>
 <CardDescription>{t("admin_integrations_download_and_manage_completed")}</CardDescription>
 </CardHeader>
 <CardContent>
 {loading ? <div className="flex items-center justify-center py-8">
 <div className="text-sm text-muted-foreground">{t("admin_integrations_loading_exports")}</div>
 </div> : <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_integrations_name")}</TableHead>
 <TableHead>{t("admin_integrations_type")}</TableHead>
 <TableHead>{t("admin_integrations_format")}</TableHead>
 <TableHead>{t("admin_integrations_status")}</TableHead>
 <TableHead>{t("admin_integrations_records")}</TableHead>
 <TableHead>{t("admin_integrations_file_size")}</TableHead>
 <TableHead>{t("admin_integrations_created")}</TableHead>
 <TableHead>{t("admin_integrations_expires")}</TableHead>
 <TableHead className="w-[50px]"></TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {filteredExports.length === 0 ? <TableRow>
 <TableCell colSpan={10} className="text-center py-8">{t("admin_integrations_no_exports_found")}</TableCell>
 </TableRow> : filteredExports.map(export_ => {
 const typeConfig = getExportTypeConfig(export_.type);
 const statusConfig = getStatusConfig(export_.status);
 const TypeIcon = typeConfig.icon;
 const StatusIcon = statusConfig.icon;
 const expired = isExpired(export_);
 return <TableRow key={export_.id}>
 <TableCell>
 <div>
 <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 font-medium">{export_.name}</div>
 <div className="text-sm text-muted-foreground">{export_.user?.name}</div>
 </div>
 </TableCell>
 <TableCell>
 <div className="flex items-center space-x-2">
 <TypeIcon className="h-4 w-4" />
 <Badge className={typeConfig.color}>
 {typeConfig.label}
 </Badge>
 </div>
 </TableCell>
 <TableCell>
 <Badge variant="outline">
 {export_.format}
 </Badge>
 </TableCell>
 <TableCell>
 <div className="flex items-center space-x-2">
 <StatusIcon className="h-4 w-4" />
 <Badge className={`${statusConfig.color} ${expired ? 'opacity-75' : ''}`}>
 {expired ? 'Expired' : statusConfig.label}
 </Badge>
 </div>
 </TableCell>
 <TableCell>
 <div className="text-sm">{export_.recordCount.toLocaleString()}</div>
 </TableCell>
 <TableCell>
 <div className="text-sm">{formatFileSize(export_.fileSize)}</div>
 </TableCell>
 <TableCell>
 <div className="text-sm">{formatDate(export_.createdAt)}</div>
 </TableCell>
 <TableCell>
 <div className="text-sm">
 {export_.expiresAt ? <span className={expired ? 'text-red-500' : 'text-muted-foreground'}>
 {formatDate(export_.expiresAt)}
 </span> : <span className="text-muted-foreground">{t("admin_integrations_never")}</span>}
 </div>
 </TableCell>
 <TableCell>
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="ghost" size="sm">
 <MoreHorizontal className="h-4 w-4" />
 </Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent>
 <DropdownMenuItem onClick={() => {
 setSelectedExport(export_);
 setViewOpen(true);
 }}>
 <Eye className="h-4 w-4 mr-2" />{t("admin_integrations_view_details")}</DropdownMenuItem>
 {export_.status ==="COMPLETED" && !expired && <DropdownMenuItem onClick={() => handleDownloadExport(export_)}>
 <Download className="h-4 w-4 mr-2" />{t("admin_integrations_download")}</DropdownMenuItem>}
 <DropdownMenuItem className="text-red-600" onClick={() => handleDeleteExport(export_.id)}>
 <Trash2 className="h-4 w-4 mr-2" />{t("admin_integrations_delete")}</DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 </TableCell>
 </TableRow>;
 })}
 </TableBody>
 </Table>}
 </CardContent>
 </Card>

 {/* View Details Dialog */}
 <Dialog open={viewOpen} onOpenChange={setViewOpen}>
 <DialogContent className="sm:max-w-[600px]">
 <DialogHeader>
 <DialogTitle>{t("admin_integrations_export_details")}</DialogTitle>
 </DialogHeader>
 {selectedExport && <div className="space-y-4">
 <div className="grid grid-cols-2 gap-4">
 <div>
 <Label>{t("admin_integrations_export_name")}</Label>
 <div className="font-medium">{selectedExport.name}</div>
 </div>
 <div>
 <Label>{t("admin_integrations_export_type")}</Label>
 <div className="flex items-center space-x-2">
 {React.createElement(getExportTypeConfig(selectedExport.type).icon, {
 className:"h-4 w-4"
 })}
 <Badge className={getExportTypeConfig(selectedExport.type).color}>
 {getExportTypeConfig(selectedExport.type).label}
 </Badge>
 </div>
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div>
 <Label>{t("admin_integrations_format")}</Label>
 <div className="text-sm">{selectedExport.format}</div>
 </div>
 <div>
 <Label>{t("admin_integrations_status")}</Label>
 <div className="flex items-center space-x-2">
 {React.createElement(getStatusConfig(selectedExport.status).icon, {
 className:"h-4 w-4"
 })}
 <Badge className={getStatusConfig(selectedExport.status).color}>
 {getStatusConfig(selectedExport.status).label}
 </Badge>
 </div>
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div>
 <Label>{t("admin_integrations_records")}</Label>
 <div className="text-sm">{selectedExport.recordCount.toLocaleString()}</div>
 </div>
 <div>
 <Label>{t("admin_integrations_file_size")}</Label>
 <div className="text-sm">{formatFileSize(selectedExport.fileSize)}</div>
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div>
 <Label>{t("admin_integrations_created_by")}</Label>
 <div>
 <div className="font-medium">{selectedExport.user?.name}</div>
 <div className="text-sm text-muted-foreground">{selectedExport.user?.email}</div>
 </div>
 </div>
 <div>
 <Label>{t("admin_integrations_created_at")}</Label>
 <div className="text-sm">{formatDateTime(selectedExport.createdAt)}</div>
 </div>
 </div>
 {selectedExport.completedAt && <div className="grid grid-cols-2 gap-4">
 <div>
 <Label>{t("admin_integrations_completed_at")}</Label>
 <div className="text-sm">{formatDateTime(selectedExport.completedAt)}</div>
 </div>
 <div>
 <Label>{t("admin_integrations_expires_at")}</Label>
 <div className={`text-sm ${isExpired(selectedExport) ? 'text-red-500' : 'text-muted-foreground'}`}>
 {selectedExport.expiresAt ? formatDate(selectedExport.expiresAt) :"Never"}
 </div>
 </div>
 </div>}
 {selectedExport.parameters.dateRange && <div>
 <Label>{t("admin_integrations_date_range")}</Label>
 <div className="text-sm">
 {formatDate(selectedExport.parameters.dateRange.start)} {t(" - ", "-")}{formatDate(selectedExport.parameters.dateRange.end)}
 </div>
 </div>}
 {selectedExport.parameters.fields && selectedExport.parameters.fields.length > 0 && <div>
 <Label>{t("admin_integrations_fields")}</Label>
 <div className="text-sm">{selectedExport.parameters.fields.join(",")}</div>
 </div>}
 {selectedExport.filePath && <div>
 <Label>{t("admin_integrations_file_path")}</Label>
 <div className="text-sm font-mono text-muted-foreground break-all">{selectedExport.filePath}</div>
 </div>}
 </div>}
 <DialogFooter>
 <Button variant="outline" onClick={() => setViewOpen(false)}>{t("admin_integrations_close")}</Button>
 {selectedExport?.status ==="COMPLETED" && !isExpired(selectedExport) && <Button onClick={() => handleDownloadExport(selectedExport)}>
 <Download className="h-4 w-4 mr-2" />{t("admin_integrations_download")}</Button>}
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </div>
 </PageShell>;
}