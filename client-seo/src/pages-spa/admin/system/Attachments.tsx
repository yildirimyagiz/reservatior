"use client";

import { t } from"i18next";
import { useTranslation } from"react-i18next";
import React, { useState, useEffect } from"react";
import { PageShell } from"../../client/layout/PageShell";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from"@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Badge } from"@/components/ui/badge";
import { Button } from"@/components/ui/button";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { MoreHorizontal, Search, Upload, FileText, Download, Eye, Trash2, Paperclip, Image, Video, File, User, Home, FileSignature, CheckSquare, AlertTriangle } from"lucide-react";
import { Input } from"@/components/ui/input";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle, DialogFooter } from"@/components/ui/dialog";
import { Label } from"@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Progress } from"@/components/ui/progress";
import { useToast } from"@/hooks/use-toast";
import { apiClient } from"@/lib/api/client";
interface Attachment {
 id: string;
 orgId: string;
 propertyId?: string;
 listingId?: string;
 contractId?: string;
 taskId?: string;
 dealId?: string;
 userId?: string;
 fileName: string;
 originalName: string;
 mimeType: string;
 fileSize: number;
 filePath: string;
 checksum: string;
 isPublic: boolean;
 downloadCount: number;
 uploadedBy: string;
 createdAt: string;
 updatedAt: string;
 deletedAt?: string;
 property?: {
 id: string;
 name: string;
 };
 listing?: {
 id: string;
 title: string;
 };
 contract?: {
 id: string;
 title: string;
 };
 task?: {
 id: string;
 title: string;
 };
 deal?: {
 id: string;
 title: string;
 };
 user?: {
 id: string;
 name: string;
 email: string;
 };
}
const FILE_TYPE_CONFIG = {
 'image/jpeg': {
 label: t("admin_system_jpeg"),
 icon: Image,
 color: 'bg-green-100 text-green-700'
 },
 'image/png': {
 label: t("admin_system_png"),
 icon: Image,
 color: 'bg-green-100 text-green-700'
 },
 'image/gif': {
 label: t("admin_system_gif"),
 icon: Image,
 color: 'bg-green-100 text-green-700'
 },
 'video/mp4': {
 label: t("admin_system_mp4"),
 icon: Video,
 color: 'bg-slate-100 text-slate-700'
 },
 'video/avi': {
 label: t("admin_system_avi"),
 icon: Video,
 color: 'bg-slate-100 text-slate-700'
 },
 'video/mov': {
 label: t("admin_system_mov"),
 icon: Video,
 color: 'bg-slate-100 text-slate-700'
 },
 'application/pdf': {
 label: t("admin_system_pdf"),
 icon: FileText,
 color: 'bg-red-100 text-red-700'
 },
 'application/msword': {
 label: t("admin_system_doc"),
 icon: FileText,
 color: 'bg-slate-100 text-slate-700'
 },
 'application/vnd.openxmlformats-officedocument.wordprocessingml.document': {
 label: t("admin_system_docx"),
 icon: FileText,
 color: 'bg-slate-100 text-slate-700'
 },
 'application/vnd.ms-excel': {
 label: t("admin_system_xls"),
 icon: FileText,
 color: 'bg-green-100 text-green-700'
 },
 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet': {
 label: t("admin_system_xlsx"),
 icon: FileText,
 color: 'bg-green-100 text-green-700'
 },
 'text/plain': {
 label: t("admin_system_txt"),
 icon: FileText,
 color: 'bg-card text-slate-300'
 },
 'application/zip': {
 label: t("admin_system_zip"),
 icon: File,
 color: 'bg-orange-100 text-orange-700'
 },
 'application/x-rar-compressed': {
 label: t("admin_system_rar"),
 icon: File,
 color: 'bg-orange-100 text-orange-700'
 }
};
const ENTITY_CONFIG = {
 property: {
 label: t("admin_system_property"),
 icon: Home,
 color: 'bg-slate-100 text-slate-700'
 },
 listing: {
 label: t("admin_system_listing"),
 icon: Home,
 color: 'bg-green-100 text-green-700'
 },
 contract: {
 label: t("admin_system_contract"),
 icon: FileSignature,
 color: 'bg-slate-100 text-slate-700'
 },
 task: {
 label: t("admin_system_task"),
 icon: CheckSquare,
 color: 'bg-orange-100 text-orange-700'
 },
 deal: {
 label: t("admin_system_deal"),
 icon: FileText,
 color: 'bg-red-100 text-red-700'
 },
 user: {
 label: t("admin_system_user"),
 icon: User,
 color: 'bg-card text-slate-300'
 }
};
export default function Attachments() {
 const {
 t
 } = useTranslation();
 const {
 toast
 } = useToast();
 const [search, setSearch] = useState("");
 const [filterType, setFilterType] = useState("all");
 const [filterEntity, setFilterEntity] = useState("all");
 const [filterPublic, setFilterPublic] = useState("all");
 const [uploadOpen, setUploadOpen] = useState(false);
 const [viewOpen, setViewOpen] = useState(false);
 const [attachments, setAttachments] = useState<Attachment[]>([]);
 const [loading, setLoading] = useState(true);
 const [selectedAttachment, setSelectedAttachment] = useState<Attachment | null>(null);
 const [uploadProgress, setUploadProgress] = useState(0);
 const [uploading, setUploading] = useState(false);

 // Fetch attachments from API
 useEffect(() => {
 const fetchAttachments = async () => {
 try {
 setLoading(true);
 const response = await apiClient.get('/attachment', {
 page:"1",
 limit:"50",
 include:"property,listing,contract,task,deal,user"
 });
 setAttachments((response as any).data || []);
 } catch (error) {
 console.error('Error fetching attachments:', error);
 toast({
 title: t("admin_system_error"),
 description: t("admin_system_failed_to_load_attachments"),
 variant:"destructive"
 });
 } finally {
 setLoading(false);
 }
 };
 fetchAttachments();
 }, []);
 const filteredAttachments = attachments.filter(attachment => {
 const matchesSearch = attachment.fileName.toLowerCase().includes(search.toLowerCase()) || attachment.originalName.toLowerCase().includes(search.toLowerCase());
 const matchesType = filterType ==="all" || attachment.mimeType.startsWith(filterType);
 const matchesEntity = filterEntity ==="all" || filterEntity ==="property" && attachment.propertyId || filterEntity ==="listing" && attachment.listingId || filterEntity ==="contract" && attachment.contractId || filterEntity ==="task" && attachment.taskId || filterEntity ==="deal" && attachment.dealId || filterEntity ==="user" && attachment.userId;
 const matchesPublic = filterPublic ==="all" || filterPublic ==="public" && attachment.isPublic || filterPublic ==="private" && !attachment.isPublic;
 return matchesSearch && matchesType && matchesEntity && matchesPublic;
 });
 const totalAttachments = filteredAttachments.length;
 const publicAttachments = filteredAttachments.filter(a => a.isPublic).length;
 const privateAttachments = filteredAttachments.filter(a => !a.isPublic).length;
 const totalSize = filteredAttachments.reduce((sum, a) => sum + a.fileSize, 0);
 const handleUploadFile = async (file: File, isPublic: boolean) => {
 try {
 setUploading(true);
 setUploadProgress(0);
 const formData = new FormData();
 formData.append('file', file);
 formData.append('isPublic', isPublic.toString());
 const response = (await apiClient.post('/attachment/upload', formData)) as {
 data: any;
 };
 setAttachments([...attachments, (response as any).data]);
 setUploadOpen(false);
 setUploadProgress(0);
 toast({
 title: t("admin_system_file_uploaded"),
 description: t("admin_system_file_has_been_uploaded")
 });
 } catch (error) {
 console.error('Error uploading file:', error);
 toast({
 title: t("admin_system_upload_failed"),
 description: t("admin_system_failed_to_upload_file"),
 variant:"destructive"
 });
 } finally {
 setUploading(false);
 }
 };
 const handleDownloadFile = async (id: string, fileName: string) => {
 try {
 const response = await apiClient.get(`/attachment/${id}/download`, {
 responseType: 'blob'
 });

 // Create download link
 const blob = new Blob([(response as any).data]);
 const url = window.URL.createObjectURL(blob);
 const a = document.createElement('a');
 a.href = url;
 a.download = fileName;
 document.body.appendChild(a);
 a.click();
 document.body.removeChild(a);
 window.URL.revokeObjectURL(url);

 // Update download count
 setAttachments(attachments.map(a => a.id === id ? {
 ...a,
 downloadCount: a.downloadCount + 1
 } : a));
 toast({
 title: t("admin_system_download_started"),
 description: t("admin_system_file_download_has_been")
 });
 } catch (error) {
 console.error('Error downloading file:', error);
 toast({
 title: t("admin_system_download_failed"),
 description: t("admin_system_failed_to_download_file"),
 variant:"destructive"
 });
 }
 };
 const handleDeleteFile = async (id: string) => {
 try {
 await apiClient.delete(`/attachment/${id}`);
 setAttachments(attachments.filter(a => a.id !== id));
 toast({
 title: t("admin_system_file_deleted"),
 description: t("admin_system_file_has_been_deleted")
 });
 } catch (error) {
 console.error('Error deleting file:', error);
 toast({
 title: t("admin_system_delete_failed"),
 description: t("admin_system_failed_to_delete_file"),
 variant:"destructive"
 });
 }
 };
 const handleToggleVisibility = async (id: string, isPublic: boolean) => {
 try {
 await apiClient.patch(`/attachment/${id}`, {
 isPublic
 });
 setAttachments(attachments.map(a => a.id === id ? {
 ...a,
 isPublic
 } : a));
 toast({
 title: t("admin_system_visibility_updated"),
 description: `File is now ${isPublic ? 'public' : 'private'}.`
 });
 } catch (error) {
 console.error('Error updating visibility:', error);
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
 const getFileTypeConfig = (mimeType: string) => {
 const config = FILE_TYPE_CONFIG[mimeType as keyof typeof FILE_TYPE_CONFIG];
 return config || {
 label: t("admin_system_unknown"),
 icon: File,
 color: 'bg-card text-slate-300'
 };
 };
 const getEntityInfo = (attachment: Attachment) => {
 if (attachment.property) return {
 type: 'property',
 item: attachment.property
 };
 if (attachment.listing) return {
 type: 'listing',
 item: attachment.listing
 };
 if (attachment.contract) return {
 type: 'contract',
 item: attachment.contract
 };
 if (attachment.task) return {
 type: 'task',
 item: attachment.task
 };
 if (attachment.deal) return {
 type: 'deal',
 item: attachment.deal
 };
 return null;
 };
 return <PageShell title={t("admin_system_attachments")} description={t("admin_system_manage_files_and_documents")}>
 <div className="space-y-6">
 {/* Summary Cards */}
 <div className="grid gap-4 md:grid-cols-4">
 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_system_total_files")}</CardTitle>
 <Paperclip className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold">{totalAttachments}</div>
 <p className="text-xs text-muted-foreground">{t("admin_system_all_attachments")}</p>
 </CardContent>
 </Card>
 
 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_system_public")}</CardTitle>
 <Eye className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-green-600">{publicAttachments}</div>
 <p className="text-xs text-muted-foreground">{t("admin_system_accessible_to_all")}</p>
 </CardContent>
 </Card>
 
 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_system_private")}</CardTitle>
 <AlertTriangle className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-orange-600">{privateAttachments}</div>
 <p className="text-xs text-muted-foreground">{t("admin_system_restricted_access")}</p>
 </CardContent>
 </Card>
 
 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_system_total_size")}</CardTitle>
 <File className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-slate-600">{formatFileSize(totalSize)}</div>
 <p className="text-xs text-muted-foreground">{t("admin_system_storage_used")}</p>
 </CardContent>
 </Card>
 </div>

 {/* Filters and Actions */}
 <div className="flex items-center justify-between space-x-4">
 <div className="flex items-center space-x-2">
 <div className="relative">
 <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
 <Input placeholder={t("admin_system_search_files")} value={search} onChange={(e: React.ChangeEvent<HTMLInputElement>) => setSearch(e.target.value)} className="pl-8 w-64" />
 </div>
 <Select value={filterType} onValueChange={setFilterType}>
 <SelectTrigger className="w-32">
 <SelectValue placeholder={t("admin_system_type")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="all">{t("admin_system_all_types")}</SelectItem>
 <SelectItem value="image">{t("admin_system_images")}</SelectItem>
 <SelectItem value="video">{t("admin_system_videos")}</SelectItem>
 <SelectItem value="application">{t("admin_system_documents")}</SelectItem>
 <SelectItem value="text">{t("admin_system_text")}</SelectItem>
 </SelectContent>
 </Select>
 <Select value={filterEntity} onValueChange={setFilterEntity}>
 <SelectTrigger className="w-32">
 <SelectValue placeholder={t("admin_system_entity")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="all">{t("admin_system_all_entities")}</SelectItem>
 {Object.entries(ENTITY_CONFIG).map(([key, config]) => <SelectItem key={key} value={key}>
 {config.label}
 </SelectItem>)}
 </SelectContent>
 </Select>
 <Select value={filterPublic} onValueChange={setFilterPublic}>
 <SelectTrigger className="w-32">
 <SelectValue placeholder={t("admin_system_visibility")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="all">{t("admin_system_all")}</SelectItem>
 <SelectItem value="public">{t("admin_system_public")}</SelectItem>
 <SelectItem value="private">{t("admin_system_private")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <Button onClick={() => setUploadOpen(true)}>
 <Upload className="h-4 w-4 mr-2" />{t("admin_system_upload_file")}</Button>
 </div>

 {/* Attachments Table */}
 <Card>
 <CardHeader>
 <CardTitle>{t("admin_system_files_documents")}</CardTitle>
 <CardDescription>{t("admin_system_manage_all_attachments_across")}</CardDescription>
 </CardHeader>
 <CardContent>
 {loading ? <div className="flex items-center justify-center py-8">
 <div className="text-sm text-muted-foreground">{t("admin_system_loading_attachments")}</div>
 </div> : <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_system_file")}</TableHead>
 <TableHead>{t("admin_system_type")}</TableHead>
 <TableHead>{t("admin_system_size")}</TableHead>
 <TableHead>{t("admin_system_entity")}</TableHead>
 <TableHead>{t("admin_system_visibility")}</TableHead>
 <TableHead>{t("admin_system_downloads")}</TableHead>
 <TableHead>{t("admin_system_uploaded")}</TableHead>
 <TableHead className="w-[50px]"></TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {filteredAttachments.length === 0 ? <TableRow>
 <TableCell colSpan={9} className="text-center py-8">{t("admin_system_no_attachments_found")}</TableCell>
 </TableRow> : filteredAttachments.map(attachment => {
 const fileTypeConfig = getFileTypeConfig(attachment.mimeType);
 const FileTypeIcon = fileTypeConfig.icon;
 const entityInfo = getEntityInfo(attachment);
 return <TableRow key={attachment.id}>
 <TableCell>
 <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 flex items-center space-x-3">
 <FileTypeIcon className="h-8 w-8 text-muted-foreground" />
 <div>
 <div className="font-medium">{attachment.originalName}</div>
 <div className="text-sm text-muted-foreground">{attachment.fileName}</div>
 </div>
 </div>
 </TableCell>
 <TableCell>
 <Badge className={fileTypeConfig.color}>
 {fileTypeConfig.label}
 </Badge>
 </TableCell>
 <TableCell>
 <div className="text-sm">{formatFileSize(attachment.fileSize)}</div>
 </TableCell>
 <TableCell>
 {entityInfo ? <div className="flex items-center space-x-2">
 {React.createElement(ENTITY_CONFIG[entityInfo.type as keyof typeof ENTITY_CONFIG].icon, {
 className:"h-4 w-4"
 })}
 <div>
 <div className="font-medium">{(entityInfo.item as any).name || (entityInfo.item as any).title}</div>
 <div className="text-sm text-muted-foreground">{ENTITY_CONFIG[entityInfo.type as keyof typeof ENTITY_CONFIG].label}</div>
 </div>
 </div> : <div className="text-sm text-muted-foreground">{t("admin_system_no_entity")}</div>}
 </TableCell>
 <TableCell>
 <Badge className={attachment.isPublic ?"bg-green-100 text-green-700" :"bg-orange-100 text-orange-700"}>
 {attachment.isPublic ?"Public" :"Private"}
 </Badge>
 </TableCell>
 <TableCell>
 <div className="text-sm">{attachment.downloadCount}</div>
 </TableCell>
 <TableCell>
 <div>
 <div className="text-sm">{formatDate(attachment.createdAt)}</div>
 <div className="text-xs text-muted-foreground">{attachment.user?.name}</div>
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
 <DropdownMenuItem onClick={() => handleDownloadFile(attachment.id, attachment.originalName)}>
 <Download className="h-4 w-4 mr-2" />{t("admin_system_download")}</DropdownMenuItem>
 <DropdownMenuItem onClick={() => {
 setSelectedAttachment(attachment);
 setViewOpen(true);
 }}>
 <Eye className="h-4 w-4 mr-2" />{t("admin_system_view_details")}</DropdownMenuItem>
 <DropdownMenuItem onClick={() => handleToggleVisibility(attachment.id, !attachment.isPublic)}>
 {attachment.isPublic ? <>
 <AlertTriangle className="h-4 w-4 mr-2" />{t("admin_system_make_private")}</> : <>
 <Eye className="h-4 w-4 mr-2" />{t("admin_system_make_public")}</>}
 </DropdownMenuItem>
 <DropdownMenuItem className="text-red-600" onClick={() => handleDeleteFile(attachment.id)}>
 <Trash2 className="h-4 w-4 mr-2" />{t("admin_system_delete")}</DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 </TableCell>
 </TableRow>;
 })}
 </TableBody>
 </Table>}
 </CardContent>
 </Card>

 {/* Upload Dialog */}
 <Dialog open={uploadOpen} onOpenChange={setUploadOpen}>
 <DialogContent className="sm:max-w-[500px]">
 <DialogHeader>
 <DialogTitle>{t("admin_system_upload_file")}</DialogTitle>
 <DialogDescription>{t("admin_system_upload_a_new_file")}</DialogDescription>
 </DialogHeader>
 <div className="space-y-4">
 <div>
 <Label htmlFor="file">{t("admin_system_choose_file")}</Label>
 <Input id="file" type="file" onChange={(e: React.ChangeEvent<HTMLInputElement>) => {
 const file = e.target.files?.[0];
 if (file) {
 handleUploadFile(file, false);
 }
 }} />
 </div>
 {uploading && <div>
 <Label>{t("admin_system_upload_progress")}</Label>
 <Progress value={uploadProgress} className="w-full" />
 <div className="text-sm text-muted-foreground mt-1">{uploadProgress}%</div>
 </div>}
 </div>
 <DialogFooter>
 <Button variant="outline" onClick={() => setUploadOpen(false)}>{t("admin_system_cancel")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>

 {/* View Details Dialog */}
 <Dialog open={viewOpen} onOpenChange={setViewOpen}>
 <DialogContent className="sm:max-w-[600px]">
 <DialogHeader>
 <DialogTitle>{t("admin_system_file_details")}</DialogTitle>
 </DialogHeader>
 {selectedAttachment && <div className="space-y-4">
 <div className="grid grid-cols-2 gap-4">
 <div>
 <Label>{t("admin_system_file_name")}</Label>
 <div className="font-medium">{selectedAttachment.originalName}</div>
 <div className="text-sm text-muted-foreground">{selectedAttachment.fileName}</div>
 </div>
 <div>
 <Label>{t("admin_system_file_type")}</Label>
 <Badge className={getFileTypeConfig(selectedAttachment.mimeType).color}>
 {getFileTypeConfig(selectedAttachment.mimeType).label}
 </Badge>
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div>
 <Label>{t("admin_system_file_size")}</Label>
 <div className="text-sm">{formatFileSize(selectedAttachment.fileSize)}</div>
 </div>
 <div>
 <Label>{t("admin_system_visibility")}</Label>
 <Badge className={selectedAttachment.isPublic ?"bg-green-100 text-green-700" :"bg-orange-100 text-orange-700"}>
 {selectedAttachment.isPublic ?"Public" :"Private"}
 </Badge>
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div>
 <Label>{t("admin_system_uploaded_by")}</Label>
 <div>
 <div className="font-medium">{selectedAttachment.user?.name}</div>
 <div className="text-sm text-muted-foreground">{selectedAttachment.user?.email}</div>
 </div>
 </div>
 <div>
 <Label>{t("admin_system_downloads")}</Label>
 <div className="text-sm">{selectedAttachment.downloadCount}</div>
 </div>
 </div>
 {getEntityInfo(selectedAttachment) && <div>
 <Label>{t("admin_system_linked_entity")}</Label>
 <div className="flex items-center space-x-2">
 {React.createElement(ENTITY_CONFIG[getEntityInfo(selectedAttachment)!.type as keyof typeof ENTITY_CONFIG].icon, {
 className:"h-4 w-4"
 })}
 <div>
 <div className="font-medium">{(getEntityInfo(selectedAttachment)!.item as any).name || (getEntityInfo(selectedAttachment)!.item as any).title}</div>
 <div className="text-sm text-muted-foreground">{ENTITY_CONFIG[getEntityInfo(selectedAttachment)!.type as keyof typeof ENTITY_CONFIG].label}</div>
 </div>
 </div>
 </div>}
 <div className="grid grid-cols-2 gap-4">
 <div>
 <Label>{t("admin_system_created")}</Label>
 <div className="text-sm">{formatDateTime(selectedAttachment.createdAt)}</div>
 </div>
 <div>
 <Label>{t("admin_system_last_updated")}</Label>
 <div className="text-sm">{formatDateTime(selectedAttachment.updatedAt)}</div>
 </div>
 </div>
 <div>
 <Label>{t("admin_system_file_path")}</Label>
 <div className="text-sm font-mono text-muted-foreground break-all">{selectedAttachment.filePath}</div>
 </div>
 <div>
 <Label>{t("admin_system_checksum")}</Label>
 <div className="text-sm font-mono text-muted-foreground">{selectedAttachment.checksum}</div>
 </div>
 </div>}
 <DialogFooter>
 <Button variant="outline" onClick={() => setViewOpen(false)}>{t("admin_system_close")}</Button>
 {selectedAttachment && <Button onClick={() => handleDownloadFile(selectedAttachment.id, selectedAttachment.originalName)}>
 <Download className="h-4 w-4 mr-2" />{t("admin_system_download")}</Button>}
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </div>
 </PageShell>;
}