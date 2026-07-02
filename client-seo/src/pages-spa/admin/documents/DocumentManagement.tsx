import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { documentsApi } from "@/lib/api/documents";
import { FileText, Upload, Download, Eye, Edit, Trash2, MoreHorizontal, Search, Folder, FolderOpen, File, Image, Video, Archive, HardDrive, Share2, Lock, Unlock, Loader2 } from "lucide-react";
import { Switch } from "@/components/ui/switch";
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
  id: "1",
  name: "Property Agreement Template.pdf",
  type: "PDF",
  category: "Legal",
  size: 245760,
  mimeType: "application/pdf",
  url: "/docs/property-agreement.pdf",
  folderId: "folder-1",
  tags: ["template", "legal", "property"],
  isPublic: false,
  isEncrypted: true,
  uploadedBy: "admin",
  uploadedAt: "2024-03-20",
  lastModified: "2024-03-28",
  downloadCount: 45,
  version: 3
}, {
  id: "2",
  name: "Property Photos - 123 Main St.zip",
  type: "ZIP",
  category: "Media",
  size: 5242880,
  mimeType: "application/zip",
  url: "/docs/property-photos.zip",
  folderId: "folder-2",
  tags: ["photos", "media", "property"],
  isPublic: true,
  isEncrypted: false,
  uploadedBy: "agent-1",
  uploadedAt: "2024-03-25",
  lastModified: "2024-03-27",
  downloadCount: 12,
  version: 1
}, {
  id: "3",
  name: "Lease Agreement.docx",
  type: "DOCX",
  category: "Legal",
  size: 53248,
  mimeType: "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
  url: "/docs/lease-agreement.docx",
  folderId: "folder-1",
  tags: ["lease", "legal", "template"],
  isPublic: false,
  isEncrypted: true,
  uploadedBy: "admin",
  uploadedAt: "2024-03-15",
  lastModified: "2024-03-26",
  downloadCount: 67,
  version: 2
}, {
  id: "4",
  name: "Marketing Video.mp4",
  type: "MP4",
  category: "Media",
  size: 15728640,
  mimeType: "video/mp4",
  url: "/docs/marketing-video.mp4",
  folderId: "folder-2",
  tags: ["video", "marketing", "media"],
  isPublic: true,
  isEncrypted: false,
  uploadedBy: "marketing-team",
  uploadedAt: "2024-03-22",
  lastModified: "2024-03-22",
  downloadCount: 23,
  version: 1
}, {
  id: "5",
  name: "Financial Report Q1.xlsx",
  type: "XLSX",
  category: "Financial",
  size: 102400,
  mimeType: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
  url: "/docs/financial-report.xlsx",
  tags: ["financial", "report", "q1"],
  isPublic: false,
  isEncrypted: true,
  uploadedBy: "finance-team",
  uploadedAt: "2024-03-28",
  lastModified: "2024-03-28",
  downloadCount: 8,
  version: 1
}];
const MOCK_FOLDERS: DocumentFolder[] = [{
  id: "folder-1",
  name: "Legal Documents",
  path: "/Legal Documents",
  documentCount: 12,
  size: 2048000,
  createdAt: "2024-03-10",
  isPublic: false
}, {
  id: "folder-2",
  name: "Media Files",
  path: "/Media Files",
  documentCount: 34,
  size: 52428800,
  createdAt: "2024-03-12",
  isPublic: true
}, {
  id: "folder-3",
  name: "Templates",
  path: "/Templates",
  documentCount: 8,
  size: 512000,
  createdAt: "2024-03-15",
  isPublic: true
}];
export default function DocumentManagement() {
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const deleteMutation = useMutation({
    mutationFn: async (id: string) => apiClient.delete(`/api/v1/unknown/${id}`),
    onSuccess: () => {
      toast({ title: "Deleted", description: "Record deleted successfully" });
      queryClient.invalidateQueries();
    },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
  });
  

  
  
    
  const {
    t
  } = useTranslation();
  const [folders] = useState<DocumentFolder[]>(MOCK_FOLDERS);
  const [activeTab, setActiveTab] = useState("documents");
  const [uploadDialogOpen, setUploadDialogOpen] = useState(false);
  const [folderDialogOpen, setFolderDialogOpen] = useState(false);
  const [search, setSearch] = useState("");
  const [filterCategory, setFilterCategory] = useState("all");
  const [filterType, setFilterType] = useState("all");

  const { data: documentsData, isLoading } = useQuery({
    queryKey: ['documents'],
    queryFn: async () => {
      const res = await documentsApi.getDocuments({ orgId: "current" });
      const apiDocs = Array.isArray(res) ? res : ((res as any).data || []);
      
      return apiDocs.map((d: any) => ({
        id: d.id,
        name: d.fileName || d.title || "Unnamed Document",
        type: d.mimeType?.includes("pdf") ? "PDF" : (d.mimeType?.includes("word") ? "DOCX" : (d.mimeType?.includes("sheet") ? "XLSX" : "File")),
        category: d.documentType || "Other",
        size: d.fileSize || 0,
        mimeType: d.mimeType || "application/octet-stream",
        url: d.fileUrl || "#",
        tags: d.tags || [],
        isPublic: d.isPublic || false,
        isEncrypted: d.isEncrypted || false,
        uploadedBy: d.createdBy || "system",
        uploadedAt: d.createdAt || new Date().toISOString(),
        lastModified: d.updatedAt || new Date().toISOString(),
        downloadCount: d.downloadCount || 0,
        version: d.version || 1
      })) as Document[];
    }
  });

  const documents = documentsData && documentsData.length > 0 ? documentsData : MOCK_DOCUMENTS;

  const deleteDocumentMutation = useMutation({
    mutationFn: async (id: string) => {
      await documentsApi.deleteDocument(id);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['documents'] });
      toast({
        title: t("admin.documents.document_deleted"),
        description: t("admin.documents.document_has_been_removed")
      });
    },
    onError: (error: any) => {
      toast({
        title: t("admin.documents.error", "Hata"),
        description: error.message,
        variant: "destructive"
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
        title: t("admin.documents.visibility_updated"),
        description: t("admin.documents.document_visibility_has_been")
      });
    }
  });
  const getFileIcon = (type: string) => {
    switch (type) {
      case "PDF":
        return <FileText className="w-4 h-4 text-red-600" />;
      case "DOCX":
        return <FileText className="w-4 h-4 text-blue-600" />;
      case "XLSX":
        return <FileText className="w-4 h-4 text-green-600" />;
      case "ZIP":
        return <Archive className="w-4 h-4 text-purple-600" />;
      case "MP4":
        return <Video className="w-4 h-4 text-orange-600" />;
      case "JPG":
      case "PNG":
        return <Image className="w-4 h-4 text-pink-600" />;
      default:
        return <File className="w-4 h-4 text-gray-600" />;
    }
  };
  const formatFileSize = (bytes: number) => {
    if (bytes === 0) return "0 Bytes";
    const k = 1024;
    const sizes = ["Bytes", "KB", "MB", "GB"];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + " " + sizes[i];
  };
  const getCategoryColor = (category: string) => {
    switch (category) {
      case "Legal":
        return "bg-red-100 text-red-700";
      case "Media":
        return "bg-blue-100 text-blue-700";
      case "Financial":
        return "bg-green-100 text-green-700";
      case "Template":
        return "bg-purple-100 text-purple-700";
      default:
        return "bg-gray-100 text-gray-700";
    }
  };
  const downloadDocument = async (document: Document) => {
    try {
      await documentsApi.downloadDocument(document.id);
      queryClient.invalidateQueries({ queryKey: ['documents'] });
      toast({
        title: t("admin.documents.download_started"),
        description: `Downloading ${document.name}`
      });
    } catch (e: any) {
      toast({
        title: t("admin.documents.error", "Hata"),
        description: e.message,
        variant: "destructive"
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
    const matchesCategory = filterCategory === "all" || document.category === filterCategory;
    const matchesType = filterType === "all" || document.type === filterType;
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
  return <PageShell title={t("admin.documents.document_management")} description={t("admin.documents.manage_documents_templates_and")}>
      <div className="space-y-6">
        {/* Stats Cards */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          <Card>
            <CardContent className="p-4">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-gray-600">{t("admin.documents.total_documents")}</p>
                  <p className="text-2xl font-bold">{stats.totalDocuments}</p>
                  <p className="text-xs text-gray-500">{t("admin.documents.all_files")}</p>
                </div>
                <FileText className="w-8 h-8 text-blue-600" />
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="p-4">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-gray-600">{t("admin.documents.total_storage")}</p>
                  <p className="text-2xl font-bold">{formatFileSize(stats.totalSize)}</p>
                  <p className="text-xs text-gray-500">{t("admin.documents.used_space")}</p>
                </div>
                <HardDrive className="w-8 h-8 text-green-600" />
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="p-4">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-gray-600">{t("admin.documents.public_documents")}</p>
                  <p className="text-2xl font-bold text-blue-600">{stats.publicDocuments}</p>
                  <p className="text-xs text-gray-500">{t("admin.documents.accessible_to_all")}</p>
                </div>
                <Unlock className="w-8 h-8 text-blue-600" />
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="p-4">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-gray-600">{t("admin.documents.total_downloads")}</p>
                  <p className="text-2xl font-bold">{stats.totalDownloads}</p>
                  <p className="text-xs text-gray-500">{t("admin.documents.all_time")}</p>
                </div>
                <Download className="w-8 h-8 text-purple-600" />
              </div>
            </CardContent>
          </Card>
        </div>

        {/* Filters and Actions */}
        <div className="flex flex-col sm:flex-row gap-4 items-start sm:items-center justify-between">
          <div className="flex flex-col sm:flex-row gap-4 flex-1">
            <div className="relative flex-1 max-w-sm">
              <Search className="absolute left-3 top-3 h-4 w-4 text-gray-400" />
              <Input placeholder={t("admin.documents.search_documents")} value={search} onChange={e => setSearch(e.target.value)} className="pl-10" />
            </div>
            <Select value={filterCategory} onValueChange={setFilterCategory}>
              <SelectTrigger className="w-[150px]">
                <SelectValue placeholder={t("admin.documents.category")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("admin.documents.all_categories")}</SelectItem>
                <SelectItem value="Legal">{t("admin.documents.legal")}</SelectItem>
                <SelectItem value="Media">{t("admin.documents.media")}</SelectItem>
                <SelectItem value="Financial">{t("admin.documents.financial")}</SelectItem>
                <SelectItem value="Template">{t("admin.documents.template")}</SelectItem>
              </SelectContent>
            </Select>
            <Select value={filterType} onValueChange={setFilterType}>
              <SelectTrigger className="w-[120px]">
                <SelectValue placeholder={t("admin.documents.type")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("admin.documents.all_types")}</SelectItem>
                <SelectItem value="PDF">{t("admin.documents.pdf")}</SelectItem>
                <SelectItem value="DOCX">{t("admin.documents.docx")}</SelectItem>
                <SelectItem value="XLSX">{t("admin.documents.xlsx")}</SelectItem>
                <SelectItem value="ZIP">{t("admin.documents.zip")}</SelectItem>
                <SelectItem value="MP4">{t("admin.documents.mp4")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="flex gap-2">
            <Button onClick={() => setFolderDialogOpen(true)} variant="outline">
              <Folder className="w-4 h-4 mr-2" />{t("admin.documents.new_folder")}</Button>
            <Button onClick={() => setUploadDialogOpen(true)}>
              <Upload className="w-4 h-4 mr-2" />{t("admin.documents.upload")}</Button>
          </div>
        </div>

        {/* Tabs */}
        <Tabs value={activeTab} onValueChange={setActiveTab}>
          <TabsList className="grid w-full grid-cols-2">
            <TabsTrigger value="documents">{t("admin.documents.documents")}</TabsTrigger>
            <TabsTrigger value="folders">{t("admin.documents.folders")}</TabsTrigger>
          </TabsList>

          <TabsContent value="documents" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>{t("admin.documents.documents")}{filteredDocuments.length})</CardTitle>
                <CardDescription>{t("admin.documents.manage_and_organize_your")}</CardDescription>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("admin.documents.name")}</TableHead>
                      <TableHead>{t("admin.documents.type")}</TableHead>
                      <TableHead>{t("admin.documents.category")}</TableHead>
                      <TableHead>{t("admin.documents.size")}</TableHead>
                      <TableHead>{t("admin.documents.uploaded_by")}</TableHead>
                      <TableHead>{t("admin.documents.downloads")}</TableHead>
                      <TableHead>{t("admin.documents.actions")}</TableHead>
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
                              <div className="flex items-center gap-2 text-xs text-gray-500">
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
                              <DropdownMenuItem onClick={() => downloadDocument(document)}>
                                <Download className="w-4 h-4 mr-2" />{t("admin.documents.download")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <Eye className="w-4 h-4 mr-2" />{t("admin.documents.preview")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <Share2 className="w-4 h-4 mr-2" />{t("admin.documents.share")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <Edit className="w-4 h-4 mr-2" />{t("admin.documents.edit")}</DropdownMenuItem>
                              <DropdownMenuItem onClick={() => toggleDocumentVisibility(document)}>
                                {document.isPublic ? <>
                                    <Lock className="w-4 h-4 mr-2" />{t("admin.documents.make_private")}</> : <>
                                    <Unlock className="w-4 h-4 mr-2" />{t("admin.documents.make_public")}</>}
                              </DropdownMenuItem>
                              <DropdownMenuItem onClick={() => deleteDocument(document.id)} className="text-red-600">
                                <Trash2 className="w-4 h-4 mr-2" />{t("admin.documents.delete")}</DropdownMenuItem>
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
                        {folder.isPublic ? <FolderOpen className="w-5 h-5 text-blue-600" /> : <Folder className="w-5 h-5 text-gray-600" />}
                        <span className="font-medium">{folder.name}</span>
                      </div>
                      {folder.isPublic && <Badge variant="outline">{t("admin.documents.public")}</Badge>}
                    </div>
                    <div className="space-y-2 text-sm text-gray-600">
                      <div className="flex justify-between">
                        <span>{t("admin.documents.documents")}</span>
                        <span className="font-medium">{folder.documentCount}</span>
                      </div>
                      <div className="flex justify-between">
                        <span>{t("admin.documents.size")}</span>
                        <span className="font-medium">{formatFileSize(folder.size)}</span>
                      </div>
                      <div className="flex justify-between">
                        <span>{t("admin.documents.created")}</span>
                        <span className="font-medium">{new Date(folder.createdAt).toLocaleDateString()}</span>
                      </div>
                    </div>
                    <div className="flex justify-end gap-2 mt-4">
                      <Button variant="outline" size="sm">
                        <Eye className="w-4 h-4 mr-2" />{t("admin.documents.open")}</Button>
                      <Button variant="outline" size="sm">
                        <Edit className="w-4 h-4 mr-2" />{t("admin.documents.edit")}</Button>
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
            <DialogTitle>{t("admin.documents.upload_document")}</DialogTitle>
            <DialogDescription>{t("admin.documents.upload_a_new_document")}</DialogDescription>
          </DialogHeader>
          <div className="py-4 space-y-4">
            <div className="space-y-2">
              <Label>{t("admin.documents.select_file")}</Label>
              <div className="border-2 border-dashed border-gray-300 rounded-lg p-6 text-center">
                <Upload className="w-8 h-8 mx-auto text-gray-400 mb-2" />
                <p className="text-sm text-gray-600">{t("admin.documents.click_to_upload_or")}</p>
                <p className="text-xs text-gray-500">{t("admin.documents.pdf_docx_xlsx_zip")}</p>
              </div>
            </div>
            <div className="space-y-2">
              <Label>{t("admin.documents.category")}</Label>
              <Select>
                <SelectTrigger>
                  <SelectValue placeholder={t("admin.documents.select_category")} />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="Legal">{t("admin.documents.legal")}</SelectItem>
                  <SelectItem value="Media">{t("admin.documents.media")}</SelectItem>
                  <SelectItem value="Financial">{t("admin.documents.financial")}</SelectItem>
                  <SelectItem value="Template">{t("admin.documents.template")}</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div className="space-y-2">
              <Label>{t("admin.documents.tags")}</Label>
              <Input placeholder={t("admin.documents.enter_tags_separated_by")} />
            </div>
            <div className="flex items-center space-x-2">
              <Switch />
              <Label>{t("admin.documents.make_this_document_public")}</Label>
            </div>
            <div className="flex items-center space-x-2">
              <Switch />
              <Label>{t("admin.documents.encrypt_this_document")}</Label>
            </div>
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setUploadDialogOpen(false)}>{t("admin.documents.cancel")}</Button>
            <Button>{t("admin.documents.upload_document")}</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Create Folder Dialog */}
      <Dialog open={folderDialogOpen} onOpenChange={setFolderDialogOpen}>
        <DialogContent className="max-w-md">
          <DialogHeader>
            <DialogTitle>{t("admin.documents.create_new_folder")}</DialogTitle>
            <DialogDescription>{t("admin.documents.create_a_new_folder")}</DialogDescription>
          </DialogHeader>
          <div className="py-4 space-y-4">
            <div className="space-y-2">
              <Label>{t("admin.documents.folder_name")}</Label>
              <Input placeholder={t("admin.documents.enter_folder_name")} />
            </div>
            <div className="space-y-2">
              <Label>{t("admin.documents.parent_folder_optional")}</Label>
              <Select>
                <SelectTrigger>
                  <SelectValue placeholder={t("admin.documents.select_parent_folder")} />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="">{t("admin.documents.root_level")}</SelectItem>
                  {folders.map(folder => <SelectItem key={folder.id} value={folder.id}>
                      {folder.name}
                    </SelectItem>)}
                </SelectContent>
              </Select>
            </div>
            <div className="flex items-center space-x-2">
              <Switch />
              <Label>{t("admin.documents.make_this_folder_public")}</Label>
            </div>
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setFolderDialogOpen(false)}>{t("admin.documents.cancel")}</Button>
            <Button>{t("admin.documents.create_folder")}</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </PageShell>;
}