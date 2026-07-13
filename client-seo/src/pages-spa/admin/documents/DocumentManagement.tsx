"use client";

import { useTranslation } from"react-i18next";
import { useState } from"react";
import { PageShell } from"../../client/layout/PageShell";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from"@/components/ui/card";
import { Button } from"@/components/ui/button";
import { Badge } from"@/components/ui/badge";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from"@/components/ui/dialog";
import { Tabs, TabsContent, TabsList, TabsTrigger } from"@/components/ui/tabs";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { useToast } from"@/hooks/use-toast";
import { useQuery, useMutation, useQueryClient } from"@tanstack/react-query";
import { documentsApi } from"@/lib/api/documents";
import { FileText, Upload, Download, Eye, Edit, Trash2, MoreHorizontal, Search, Folder, FolderOpen, File, Image, Video, Archive, HardDrive, Share2, Lock, Unlock, Loader2, Brain, CheckCircle, AlertTriangle } from"lucide-react";
import { Switch } from"@/components/ui/switch";
import { apiClient } from"@/lib/api";
interface Document {
 id: string;
 name: string;
 type: string;
 category: string;
 size: number;
 mimeType: string;
 url: string;
 folderId?: string;
 tags: string[];
 isPublic: boolean;
 isEncrypted: boolean;
 uploadedBy: string;
 uploadedAt: string;
 lastModified: string;
 downloadCount: number;
 version: number;
}
interface DocumentFolder {
 id: string;
 name: string;
 parentId?: string;
 path: string;
 documentCount: number;
 size: number;
 createdAt: string;
 isPublic: boolean;
}
const MOCK_DOCUMENTS: Document[] = [{
 id:"1",
 name:"Property Agreement Template.pdf",
 type:"PDF",
 category:"Legal",
 size: 245760,
 mimeType:"application/pdf",
 url:"/docs/property-agreement.pdf",
 folderId:"folder-1",
 tags: ["template","legal","property"],
 isPublic: false,
 isEncrypted: true,
 uploadedBy:"admin",
 uploadedAt:"2024-03-20",
 lastModified:"2024-03-28",
 downloadCount: 45,
 version: 3
}, {
 id:"2",
 name:"Property Photos - 123 Main St.zip",
 type:"ZIP",
 category:"Media",
 size: 5242880,
 mimeType:"application/zip",
 url:"/docs/property-photos.zip",
 folderId:"folder-2",
 tags: ["photos","media","property"],
 isPublic: true,
 isEncrypted: false,
 uploadedBy:"agent-1",
 uploadedAt:"2024-03-25",
 lastModified:"2024-03-27",
 downloadCount: 12,
 version: 1
}, {
 id:"3",
 name:"Lease Agreement.docx",
 type:"DOCX",
 category:"Legal",
 size: 53248,
 mimeType:"application/vnd.openxmlformats-officedocument.wordprocessingml.document",
 url:"/docs/lease-agreement.docx",
 folderId:"folder-1",
 tags: ["lease","legal","template"],
 isPublic: false,
 isEncrypted: true,
 uploadedBy:"admin",
 uploadedAt:"2024-03-15",
 lastModified:"2024-03-26",
 downloadCount: 67,
 version: 2
}, {
 id:"4",
 name:"Marketing Video.mp4",
 type:"MP4",
 category:"Media",
 size: 15728640,
 mimeType:"video/mp4",
 url:"/docs/marketing-video.mp4",
 folderId:"folder-2",
 tags: ["video","marketing","media"],
 isPublic: true,
 isEncrypted: false,
 uploadedBy:"marketing-team",
 uploadedAt:"2024-03-22",
 lastModified:"2024-03-22",
 downloadCount: 23,
 version: 1
}, {
 id:"5",
 name:"Financial Report Q1.xlsx",
 type:"XLSX",
 category:"Financial",
 size: 102400,
 mimeType:"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
 url:"/docs/financial-report.xlsx",
 tags: ["financial","report","q1"],
 isPublic: false,
 name:"Templates",
 path:"/Templates",
 documentCount: 8,
 size: 512000,
 createdAt:"2024-03-15",
 isPublic: true
}];
export default function DocumentManagement() {
 const { toast } = useToast();
 const queryClient = useQueryClient();
 
 const deleteMutation = useMutation({
 mutationFn: (id: string) => documentsApi.deleteDocument(id),
 onSuccess: () => {
 toast({ title:"Deleted", description:"Record deleted successfully" });
 queryClient.invalidateQueries({ queryKey: ['documents'] });
 },
 onError: (err: unknown) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });
 

 
 
 
 const {
 t
 } = useTranslation();
 const folders: DocumentFolder[] = []; // Future API integration
 const [activeTab, setActiveTab] = useState("documents");
 const [uploadDialogOpen, setUploadDialogOpen] = useState(false);
 const [folderDialogOpen, setFolderDialogOpen] = useState(false);
 const [contractDialogOpen, setContractDialogOpen] = useState(false);
 const [contractWizardStep, setContractWizardStep] = useState(1);
 const [contractResult, setContractResult] = useState("");
 const [search, setSearch] = useState("");
 const [filterCategory, setFilterCategory] = useState("all");
 const [filterType, setFilterType] = useState("all");
 const [uploadData, setUploadData] = useState({ country:"", city:"", district:"", neighborhood:"", project:"" });

 const { data: documentsData, isLoading } = useQuery({
 queryKey: ['documents'],
 queryFn: async () => {
 const res = await documentsApi.getDocuments({ orgId:"current" });
 const apiDocs = Array.isArray(res) ? res : ((res as any).data || []);
 
 return apiDocs.map((d: unknown) => ({
 id: d.id,
 name: d.fileName || d.title ||"Unnamed Document",
 type: d.mimeType?.includes("pdf") ?"PDF" : (d.mimeType?.includes("word") ?"DOCX" : (d.mimeType?.includes("sheet") ?"XLSX" :"File")),
 category: d.documentType ||"Other",
 size: d.fileSize || 0,
 mimeType: d.mimeType ||"application/octet-stream",
 url: d.fileUrl ||"#",
 tags: d.tags || [],
 isPublic: d.isPublic || false,
 isEncrypted: d.isEncrypted || false,
 uploadedBy: d.createdBy ||"system",
 uploadedAt: d.createdAt || new Date().toISOString(),
 lastModified: d.updatedAt || new Date().toISOString(),
 downloadCount: d.downloadCount || 0,
 version: d.version || 1
 })) as Document[];
 }
 });

 const documents = documentsData || [];

 const deleteDocumentMutation = useMutation({
 mutationFn: async (id: string) => {
 await documentsApi.deleteDocument(id);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['documents'] });
 toast({
 title: t("admin_documents_document_deleted"),
 description: t("admin_documents_document_has_been_removed")
 });
 },
 onError: (error: unknown) => {
 toast({
 title: t("admin_documents_error","Hata"),
 description: error.message,
 variant:"destructive"
 });
 }
 });

 const toggleVisibilityMutation = useMutation({
 mutationFn: async ({ id, isPublic }: { id: string; isPublic: boolean }) => {
 // Assuming updateDocument takes partial Document, we might not have a direct isPublic field in DocumentType
 // but if the backend accepts it as part of update, we pass it.
 return await documentsApi.updateDocument(id, { tags: [isPublic ? 'public' : 'private'] } as any);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['documents'] });
 toast({
 title: t("admin_documents_visibility_updated"),
 description: t("admin_documents_document_visibility_has_been")
 });
 }
 });
 const getFileIcon = (type: string) => {
 switch (type) {
 case"PDF":
 return <FileText className="w-4 h-4 text-red-600" />;
 case"DOCX":
 return <FileText className="w-4 h-4 text-slate-600" />;
 case"XLSX":
 return <FileText className="w-4 h-4 text-green-600" />;
 case"ZIP":
 return <Archive className="w-4 h-4 text-slate-600" />;
 case"MP4":
 return <Video className="w-4 h-4 text-orange-600" />;
 case"JPG":
 case"PNG":
 return <Image className="w-4 h-4 text-pink-600" />;
 default:
 return <File className="w-4 h-4 text-muted-foreground" />;
 }
 };
 const formatFileSize = (bytes: number) => {
 if (bytes === 0) return"0 Bytes";
 const k = 1024;
 const sizes = ["Bytes","KB","MB","GB"];
 const i = Math.floor(Math.log(bytes) / Math.log(k));
 return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) +"" + sizes[i];
 };
 const getCategoryColor = (category: string) => {
 switch (category) {
 case"Legal":
 return"bg-red-100 text-red-700";
 case"Media":
 return"bg-slate-100 text-slate-700";
 case"Financial":
 return"bg-green-100 text-green-700";
 case"Template":
 return"bg-slate-100 text-slate-700";
 default:
 return"bg-card text-slate-300";
 }
 };
 const downloadDocument = async (document: Document) => {
 try {
 await documentsApi.downloadDocument(document.id);
 queryClient.invalidateQueries({ queryKey: ['documents'] });
 toast({
 title: t("admin_documents_download_started"),
 description: `Downloading ${document.name}`
 });
 } catch (e: unknown) {
 toast({
 title: t("admin_documents_error","Hata"),
 description: e.message,
 variant:"destructive"
 });
 }
 };
 const deleteDocument = (documentId: string) => {
 deleteDocumentMutation.mutate(documentId);
 };
 const toggleDocumentVisibility = (document: Document) => {
 toggleVisibilityMutation.mutate({ id: document.id, isPublic: !document.isPublic });
 };
 const filteredDocuments = documents.filter(document => {
 const matchesSearch = document.name.toLowerCase().includes(search.toLowerCase()) || document.tags.some(tag => tag.toLowerCase().includes(search.toLowerCase()));
 const matchesCategory = filterCategory ==="all" || document.category === filterCategory;
 const matchesType = filterType ==="all" || document.type === filterType;
 return matchesSearch && matchesCategory && matchesType;
 });
 const stats = {
 totalDocuments: documents.length,
 totalSize: documents.reduce((sum, doc) => sum + doc.size, 0),
 totalFolders: folders.length,
 publicDocuments: documents.filter(d => d.isPublic).length,
 encryptedDocuments: documents.filter(d => d.isEncrypted).length,
 totalDownloads: documents.reduce((sum, doc) => sum + doc.downloadCount, 0)
 };
 return <PageShell title={t("admin_documents_document_management")} description={t("admin_documents_manage_documents_templates_and")}>
 <div className="space-y-6">
 {/* Stats Cards */}
 <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
 <Card>
 <CardContent className="p-4">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-sm font-medium text-muted-foreground">{t("admin_documents_total_documents")}</p>
 <p className="text-2xl font-bold">{stats.totalDocuments}</p>
 <p className="text-xs text-muted-foreground">{t("admin_documents_all_files")}</p>
 </div>
 <FileText className="w-8 h-8 text-slate-600" />
 </div>
 </CardContent>
 </Card>
 <Card>
 <CardContent className="p-4">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-sm font-medium text-muted-foreground">{t("admin_documents_total_storage")}</p>
 <p className="text-2xl font-bold">{formatFileSize(stats.totalSize)}</p>
 <p className="text-xs text-muted-foreground">{t("admin_documents_used_space")}</p>
 </div>
 <HardDrive className="w-8 h-8 text-green-600" />
 </div>
 </CardContent>
 </Card>
 <Card>
 <CardContent className="p-4">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-sm font-medium text-muted-foreground">{t("admin_documents_public_documents")}</p>
 <p className="text-2xl font-bold text-slate-600">{stats.publicDocuments}</p>
 <p className="text-xs text-muted-foreground">{t("admin_documents_accessible_to_all")}</p>
 </div>
 <Unlock className="w-8 h-8 text-slate-600" />
 </div>
 </CardContent>
 </Card>
 <Card>
 <CardContent className="p-4">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-sm font-medium text-muted-foreground">{t("admin_documents_total_downloads")}</p>
 <p className="text-2xl font-bold">{stats.totalDownloads}</p>
 <p className="text-xs text-muted-foreground">{t("admin_documents_all_time")}</p>
 </div>
 <Download className="w-8 h-8 text-slate-600" />
 </div>
 </CardContent>
 </Card>
 </div>

 {/* Filters and Actions */}
 <div className="flex flex-col sm:flex-row gap-4 items-start sm:items-center justify-between">
 <div className="flex flex-col sm:flex-row gap-4 flex-1">
 <div className="relative flex-1 max-w-sm">
 <Search className="absolute left-3 top-3 h-4 w-4 text-muted-foreground" />
 <Input placeholder={t("admin_documents_search_documents")} value={search} onChange={e => setSearch(e.target.value)} className="pl-10" />
 </div>
 <Select value={filterCategory} onValueChange={setFilterCategory}>
 <SelectTrigger className="w-[150px]">
 <SelectValue placeholder={t("admin_documents_category")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="all">{t("admin_documents_all_categories")}</SelectItem>
 <SelectItem value="Legal">{t("admin_documents_legal")}</SelectItem>
 <SelectItem value="Media">{t("admin_documents_media")}</SelectItem>
 <SelectItem value="Financial">{t("admin_documents_financial")}</SelectItem>
 <SelectItem value="Template">{t("admin_documents_template")}</SelectItem>
 </SelectContent>
 </Select>
 <Select value={filterType} onValueChange={setFilterType}>
 <SelectTrigger className="w-[120px]">
 <SelectValue placeholder={t("admin_documents_type")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="all">{t("admin_documents_all_types")}</SelectItem>
 <SelectItem value="PDF">{t("admin_documents_pdf")}</SelectItem>
 <SelectItem value="DOCX">{t("admin_documents_docx")}</SelectItem>
 <SelectItem value="XLSX">{t("admin_documents_xlsx")}</SelectItem>
 <SelectItem value="ZIP">{t("admin_documents_zip")}</SelectItem>
 <SelectItem value="MP4">{t("admin_documents_mp4")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="flex gap-2">
 <Button onClick={() => setContractDialogOpen(true)} variant="secondary" className="bg-emerald-500/10 text-emerald-500 hover:bg-emerald-500/20 border-emerald-500/20">
 <FileText className="w-4 h-4 mr-2" />AI Contract
 </Button>
 <Button onClick={() => setFolderDialogOpen(true)} variant="outline">
 <Folder className="w-4 h-4 mr-2" />{t("admin_documents_new_folder")}</Button>
 <Button onClick={() => setUploadDialogOpen(true)}>
 <Upload className="w-4 h-4 mr-2" />{t("admin_documents_upload")}</Button>
 </div>
 </div>

 {/* Tabs */}
 <Tabs value={activeTab} onValueChange={setActiveTab}>
 <TabsList className="grid w-full grid-cols-2">
 <TabsTrigger value="documents">{t("admin_documents_documents")}</TabsTrigger>
 <TabsTrigger value="folders">{t("admin_documents_folders")}</TabsTrigger>
 </TabsList>

 <TabsContent value="documents" className="space-y-6">
 <Card>
 <CardHeader>
 <CardTitle>{t("admin_documents_documents")}{filteredDocuments.length})</CardTitle>
 <CardDescription>{t("admin_documents_manage_and_organize_your")}</CardDescription>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_documents_name")}</TableHead>
 <TableHead>{t("admin_documents_type")}</TableHead>
 <TableHead>{t("admin_documents_category")}</TableHead>
 <TableHead>{t("admin_documents_size")}</TableHead>
 <TableHead>{t("admin_documents_uploaded_by")}</TableHead>
 <TableHead>{t("admin_documents_downloads")}</TableHead>
 <TableHead>{t("admin_documents_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {isLoading ? (
 <TableRow>
 <TableCell colSpan={7} className="text-center py-12">
 <Loader2 className="w-8 h-8 animate-spin mx-auto text-muted-foreground" />
 </TableCell>
 </TableRow>
 ) : (
 filteredDocuments.map(document => <TableRow key={document.id}>
 <TableCell>
 <div className="flex items-center gap-3">
 {getFileIcon(document.type)}
 <div>
 <div className="font-medium">{document.name}</div>
 <div className="flex items-center gap-2 text-xs text-muted-foreground">
 <span>v{document.version}</span>
 {document.isEncrypted && <Lock className="w-3 h-3" />}
 {document.isPublic && <Unlock className="w-3 h-3" />}
 </div>
 </div>
 </div>
 </TableCell>
 <TableCell>
 <Badge variant="outline">{document.type}</Badge>
 </TableCell>
 <TableCell>
 <Badge className={getCategoryColor(document.category)}>
 {document.category}
 </Badge>
 </TableCell>
 <TableCell>
 <span className="text-sm">{formatFileSize(document.size)}</span>
 </TableCell>
 <TableCell>
 <span className="text-sm">{document.uploadedBy}</span>
 </TableCell>
 <TableCell>
 <span className="text-sm">{document.downloadCount}</span>
 </TableCell>
 <TableCell>
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="ghost" size="sm">
 <MoreHorizontal className="w-4 h-4" />
 </Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent>
 <DropdownMenuItem onClick={() => {
 toast({ title: t("admin_documents_ai_analysis_started","AI Analysis Started"), description: t("admin_documents_ai_analysis_desc","Document is being processed by ML OCR Engine.") });
 documentsApi.analyzeDocumentWithAI(document.id).then(() => {
 toast({ title: t("admin_documents_ai_analysis_complete","AI Analysis Complete"), description: t("admin_documents_ai_analysis_success","Data successfully extracted.") });
 }).catch((err: unknown) => {
 toast({ title:"Error", description: err.message, variant:"destructive" });
 });
 }}>
 <Brain className="w-4 h-4 mr-2 text-indigo-400" />
 <span className="text-indigo-400 font-medium">AI Analiz (OCR)</span>
 </DropdownMenuItem>
 <DropdownMenuItem onClick={() => downloadDocument(document)}>
 <Download className="w-4 h-4 mr-2" />{t("admin_documents_download")}</DropdownMenuItem>
 <DropdownMenuItem>
 <Eye className="w-4 h-4 mr-2" />{t("admin_documents_preview")}</DropdownMenuItem>
 <DropdownMenuItem>
 <Share2 className="w-4 h-4 mr-2" />{t("admin_documents_share")}</DropdownMenuItem>
 <DropdownMenuItem>
 <Edit className="w-4 h-4 mr-2" />{t("admin_documents_edit")}</DropdownMenuItem>
 <DropdownMenuItem onClick={() => toggleDocumentVisibility(document)}>
 {document.isPublic ? <>
 <Lock className="w-4 h-4 mr-2" />{t("admin_documents_make_private")}</> : <>
 <Unlock className="w-4 h-4 mr-2" />{t("admin_documents_make_public")}</>}
 </DropdownMenuItem>
 <DropdownMenuItem onClick={() => deleteDocument(document.id)} className="text-red-600">
 <Trash2 className="w-4 h-4 mr-2" />{t("admin_documents_delete")}</DropdownMenuItem>
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

 <TabsContent value="folders" className="space-y-6">
 <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
 {folders.map(folder => <Card key={folder.id} className="cursor-pointer hover:shadow-md transition-shadow">
 <CardContent className="p-6">
 <div className="flex items-center justify-between mb-4">
 <div className="flex items-center gap-2">
 {folder.isPublic ? <FolderOpen className="w-5 h-5 text-slate-600" /> : <Folder className="w-5 h-5 text-muted-foreground" />}
 <span className="font-medium">{folder.name}</span>
 </div>
 {folder.isPublic && <Badge variant="outline">{t("admin_documents_public")}</Badge>}
 </div>
 <div className="space-y-2 text-sm text-muted-foreground">
 <div className="flex justify-between">
 <span>{t("admin_documents_documents")}</span>
 <span className="font-medium">{folder.documentCount}</span>
 </div>
 <div className="flex justify-between">
 <span>{t("admin_documents_size")}</span>
 <span className="font-medium">{formatFileSize(folder.size)}</span>
 </div>
 <div className="flex justify-between">
 <span>{t("admin_documents_created")}</span>
 <span className="font-medium">{new Date(folder.createdAt).toLocaleDateString()}</span>
 </div>
 </div>
 <div className="flex justify-end gap-2 mt-4">
 <Button variant="outline" size="sm">
 <Eye className="w-4 h-4 mr-2" />{t("admin_documents_open")}</Button>
 <Button variant="outline" size="sm">
 <Edit className="w-4 h-4 mr-2" />{t("admin_documents_edit")}</Button>
 </div>
 </CardContent>
 </Card>)}
 </div>
 </TabsContent>
 </Tabs>
 </div>

 {/* Upload Dialog */}
 <Dialog open={uploadDialogOpen} onOpenChange={setUploadDialogOpen}>
 <DialogContent className="max-w-md">
 <DialogHeader>
 <DialogTitle>{t("admin_documents_upload_document")}</DialogTitle>
 <DialogDescription>{t("admin_documents_upload_a_new_document")}</DialogDescription>
 </DialogHeader>
 <div className="py-4 space-y-4">
 <div className="space-y-2">
 <Label>{t("admin_documents_select_file")}</Label>
 <div className="border-2 border-dashed border-border rounded-lg p-6 text-center">
 <Upload className="w-8 h-8 mx-auto text-muted-foreground mb-2" />
 <p className="text-sm text-muted-foreground">{t("admin_documents_click_to_upload_or")}</p>
 <p className="text-xs text-muted-foreground">{t("admin_documents_pdf_docx_xlsx_zip")}</p>
 </div>
 </div>
 <div className="space-y-2">
 <Label>Lokasyon & Proje (Hiyerarşi)</Label>
 <div className="grid grid-cols-2 gap-2">
 <Input placeholder="Ülke (örn: TURKİYE)" value={uploadData.country} onChange={e => setUploadData({...uploadData, country: e.target.value})} />
 <Input placeholder="Şehir (örn: ISTANBUL)" value={uploadData.city} onChange={e => setUploadData({...uploadData, city: e.target.value})} />
 <Input placeholder="İlçe (örn: SİSLİ)" value={uploadData.district} onChange={e => setUploadData({...uploadData, district: e.target.value})} />
 <Input placeholder="Mahalle" value={uploadData.neighborhood} onChange={e => setUploadData({...uploadData, neighborhood: e.target.value})} />
 <Input placeholder="Proje (örn: Queen)" className="col-span-2" value={uploadData.project} onChange={e => setUploadData({...uploadData, project: e.target.value})} />
 </div>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_documents_category")}</Label>
 <Select>
 <SelectTrigger>
 <SelectValue placeholder={t("admin_documents_select_category")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="Legal">{t("admin_documents_legal")}</SelectItem>
 <SelectItem value="Media">{t("admin_documents_media")}</SelectItem>
 <SelectItem value="Financial">{t("admin_documents_financial")}</SelectItem>
 <SelectItem value="Template">{t("admin_documents_template")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_documents_tags")}</Label>
 <Input placeholder={t("admin_documents_enter_tags_separated_by")} />
 </div>
 <div className="flex items-center space-x-2">
 <Switch />
 <Label>{t("admin_documents_make_this_document_public")}</Label>
 </div>
 <div className="flex items-center space-x-2">
 <Switch />
 <Label>{t("admin_documents_encrypt_this_document")}</Label>
 </div>
 </div>
 <DialogFooter>
 <Button variant="outline" onClick={() => setUploadDialogOpen(false)}>{t("admin_documents_cancel")}</Button>
 <Button>{t("admin_documents_upload_document")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>

 {/* Create Folder Dialog */}
 <Dialog open={folderDialogOpen} onOpenChange={setFolderDialogOpen}>
 <DialogContent className="max-w-md">
 <DialogHeader>
 <DialogTitle>{t("admin_documents_create_new_folder")}</DialogTitle>
 <DialogDescription>{t("admin_documents_create_a_new_folder")}</DialogDescription>
 </DialogHeader>
 <div className="py-4 space-y-4">
 <div className="space-y-2">
 <Label>{t("admin_documents_folder_name")}</Label>
 <Input placeholder={t("admin_documents_enter_folder_name")} />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_documents_parent_folder_optional")}</Label>
 <Select>
 <SelectTrigger>
 <SelectValue placeholder={t("admin_documents_select_parent_folder")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="">{t("admin_documents_root_level")}</SelectItem>
 {folders.map(folder => <SelectItem key={folder.id} value={folder.id}>
 {folder.name}
 </SelectItem>)}
 </SelectContent>
 </Select>
 </div>
 <div className="flex items-center space-x-2">
 <Switch />
 <Label>{t("admin_documents_make_this_folder_public")}</Label>
 </div>
 </div>
 <DialogFooter>
 <Button variant="outline" onClick={() => setFolderDialogOpen(false)}>{t("admin_documents_cancel")}</Button>
 <Button>{t("admin_documents_create_folder")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>

 {/* Contract Generator Dialog */}
 <Dialog open={contractDialogOpen} onOpenChange={(open) => {
 setContractDialogOpen(open);
 if (!open) {
 setContractWizardStep(1);
 setContractResult("");
 }
 }}>
 <DialogContent className="max-w-2xl bg-card border-border text-card-foreground">
 <DialogHeader>
 <DialogTitle>AI Contract Wizard</DialogTitle>
 <DialogDescription className="text-muted-foreground">
 {contractWizardStep === 1 &&"Generate a localized real estate contract."}
 {contractWizardStep === 2 &&"Review and export your contract."}
 {contractWizardStep === 3 &&"Securely store property media for this contract."}
 </DialogDescription>
 </DialogHeader>

 <div className="py-4 space-y-4">
 {/* Step 1: Generate & Preview */}
 {contractWizardStep === 1 && (
 <>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label className="text-muted-foreground">Country Code (e.g. TR, US, UK)</Label>
 <Input id="contract-country" defaultValue="TR" className="bg-background border-border text-foreground" />
 </div>
 <div className="space-y-2">
 <Label className="text-muted-foreground">Contract Type</Label>
 <Select defaultValue="SALES">
 <SelectTrigger id="contract-type" className="bg-background border-border text-foreground"><SelectValue /></SelectTrigger>
 <SelectContent className="bg-card border-border text-card-foreground">
 <SelectItem value="SALES">Sales Agreement</SelectItem>
 <SelectItem value="RENTAL">Rental Agreement</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 {contractResult && (
 <div className="mt-4 p-4 bg-background border border-border rounded-xl max-h-60 overflow-y-auto">
 <div className="prose prose-sm prose-invert max-w-none" dangerouslySetInnerHTML={{ __html: contractResult.replace(/\n/g, '<br />') }} />
 </div>
 )}
 </>
 )}

 {/* Step 2: Export Options */}
 {contractWizardStep === 2 && (
 <div className="flex flex-col items-center justify-center py-8 space-y-6">
 <div className="p-4 bg-emerald-500/10 text-emerald-500 rounded-full">
 <CheckCircle className="w-12 h-12" />
 </div>
 <h3 className="text-xl font-bold">Contract Ready!</h3>
 <p className="text-muted-foreground text-center max-w-sm">Your AI-generated contract is ready. Choose a format to download.</p>
 <div className="flex gap-4">
 <Button variant="outline" className="border-blue-500/50 text-blue-400 hover:bg-blue-500/10" onClick={() => {
 const blob = new Blob([contractResult], { type: 'application/pdf' });
 const url = URL.createObjectURL(blob);
 const a = document.createElement('a');
 a.href = url;
 a.download = 'Contract.pdf';
 a.click();
 }}>
 <Download className="w-4 h-4 mr-2" /> Download PDF
 </Button>
 <Button variant="outline" className="border-indigo-500/50 text-indigo-400 hover:bg-indigo-500/10" onClick={() => {
 const blob = new Blob([contractResult], { type: 'application/msword' });
 const url = URL.createObjectURL(blob);
 const a = document.createElement('a');
 a.href = url;
 a.download = 'Contract.docx';
 a.click();
 }}>
 <Download className="w-4 h-4 mr-2" /> Download DOCX
 </Button>
 </div>
 </div>
 )}

 {/* Step 3: Media Vault */}
 {contractWizardStep === 3 && (
 <div className="space-y-4">
 <div className="p-4 bg-amber-500/10 border border-amber-500/20 rounded-xl flex items-start gap-3 text-amber-500">
 <AlertTriangle className="w-5 h-5 shrink-0" />
 <p className="text-sm">Contract saved. Now, securely store any walkthrough videos or images of the property before handover.</p>
 </div>
 <div className="border-2 border-dashed border-border rounded-xl flex flex-col items-center justify-center p-12 hover:bg-accent hover:text-accent-foreground transition-colors cursor-pointer">
 <div className="p-4 bg-primary/10 text-primary rounded-full mb-4">
 <Upload className="w-8 h-8" />
 </div>
 <h3 className="text-lg font-bold mb-2">Drag & Drop Media</h3>
 <p className="text-sm text-muted-foreground text-center max-w-xs mb-6">
 Upload MP4 videos or high-res images to the secure media vault.
 </p>
 <Button variant="secondary">Browse Files</Button>
 </div>
 </div>
 )}
 </div>

 <DialogFooter className="flex items-center justify-between">
 <Button variant="ghost" onClick={() => {
 if (contractWizardStep > 1) {
 setContractWizardStep(contractWizardStep - 1);
 } else {
 setContractDialogOpen(false);
 }
 }}>
 {contractWizardStep > 1 ?"Back" :"Cancel"}
 </Button>
 
 {contractWizardStep === 1 && (
 <Button onClick={async () => {
 if (contractResult) {
 setContractWizardStep(2);
 return;
 }
 const { contractsApi } = await import('@/lib/api/contracts');
 const country = (document.getElementById('contract-country') as HTMLInputElement)?.value || 'TR';
 try {
 const res = await contractsApi.generate({
 country_code: country,
 contract_type:"SALES",
 property: { id:"p1", address:"Sample St", city:"Istanbul", country:"TR", price: 100000, currency:"USD", property_type:"Apartment" },
 owner: { full_name:"John Doe", identification_number:"123456", address:"Owner Addr", phone:"555", email:"o@o.com" },
 buyer_or_tenant: { full_name:"Jane Smith", identification_number:"654321", address:"Buyer Addr", phone:"555", email:"b@b.com" }
 });
 setContractResult(res.content_markdown);
 } catch (e) {
 console.error(e);
 setContractResult("Error generating contract");
 }
 }}>
 {contractResult ?"Next Step" :"Generate"}
 </Button>
 )}
 
 {contractWizardStep === 2 && (
 <Button onClick={() => setContractWizardStep(3)}>Continue to Media Vault</Button>
 )}
 
 {contractWizardStep === 3 && (
 <Button onClick={() => setContractDialogOpen(false)}>Done</Button>
 )}
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </PageShell>;
}