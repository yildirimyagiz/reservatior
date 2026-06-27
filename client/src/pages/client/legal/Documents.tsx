import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { format } from "date-fns";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Checkbox } from "@/components/ui/checkbox";
import { Label } from "@/components/ui/label";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuSeparator, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { Lock as LockIcon, Unlock as UnlockIcon, File as FileIcon, Folder, MoreHorizontal, FileImage, FileVideo, FileAudio, FileArchive, FileCode, FileSpreadsheet, FileText, Upload, Download, Search, Eye, Edit, Trash2, Share2, FilePlus, Grid3X3, List, Star, SortAsc, SortDesc } from "lucide-react";
import { useAuth } from "@/lib/auth/hooks";
import { motion } from "framer-motion";
interface DocumentItem {
  id: string;
  title: string;
  description?: string;
  type: "contract" | "invoice" | "report" | "image" | "video" | "audio" | "archive" | "code" | "spreadsheet" | "other";
  category: string;
  size: number;
  mimeType: string;
  url: string;
  thumbnailUrl?: string;
  status: "active" | "archived" | "deleted" | "processing";
  visibility: "public" | "private" | "shared";
  tags: string[];
  metadata: Record<string, any>;
  createdBy: string;
  createdAt: string;
  updatedAt: string;
  expiresAt?: string;
  downloadCount: number;
  isFavorite: boolean;
  permissions: {
    canView: boolean;
    canEdit: boolean;
    canDelete: boolean;
    canShare: boolean;
  };
}
interface DocFolder {
  id: string;
  name: string;
  description?: string;
  parentId: string | null;
  documentCount: number;
  size: number;
  createdBy: string;
  createdAt: string;
  updatedAt: string;
  isShared: boolean;
  permissions: {
    canView: boolean;
    canEdit: boolean;
    canDelete: boolean;
  };
}
export default function Documents() {
  const {
    t
  } = useTranslation();
  const {
    user
  } = useAuth();
  const [documents, setDocuments] = useState<DocumentItem[]>([]);
  const [folders, setFolders] = useState<DocFolder[]>([]);
  const [selectedDocuments, setSelectedDocuments] = useState<string[]>([]);
  const [viewMode, setViewMode] = useState<"grid" | "list">("grid");
  const [sortBy, setSortBy] = useState<"name" | "date" | "size" | "type">("date");
  const [sortOrder, setSortOrder] = useState<"asc" | "desc">("desc");
  const [filterType, setFilterType] = useState<string>("all");
  const [filterStatus, setFilterStatus] = useState<string>("all");
  const [searchTerm, setSearchTerm] = useState("");
  const [showUploadDialog, setShowUploadDialog] = useState(false);
  const [showCreateFolderDialog, setShowCreateFolderDialog] = useState(false);

  // Mock data - replace with actual API calls
  useEffect(() => {
    const mockDocuments: DocumentItem[] = [{
      id: "1",
      title: t("client.src.rental_agreement_property_123"),
      description: t("client.src.standard_residential_rental_agreement"),
      type: "contract",
      category: "Legal",
      size: 2048576,
      mimeType: "application/pdf",
      url: "/documents/rental-agreement-123.pdf",
      thumbnailUrl: "/thumbnails/rental-agreement-123.jpg",
      status: "active",
      visibility: "private",
      tags: ["rental", "agreement", "legal"],
      metadata: {
        propertyId: "prop123",
        clientId: "client456",
        signedDate: "2024-01-15",
        expiryDate: "2025-01-15"
      },
      createdBy: user?.id || "",
      createdAt: "2024-01-15T10:00:00Z",
      updatedAt: "2024-01-15T10:00:00Z",
      downloadCount: 12,
      isFavorite: true,
      permissions: {
        canView: true,
        canEdit: true,
        canDelete: true,
        canShare: true
      }
    }, {
      id: "2",
      title: t("client.src.property_inspection_report"),
      description: t("client.src.detailed_inspection_report_with"),
      type: "report",
      category: "Inspection",
      size: 5242880,
      mimeType: "application/pdf",
      url: "/documents/inspection-report.pdf",
      thumbnailUrl: "/thumbnails/inspection-report.jpg",
      status: "active",
      visibility: "shared",
      tags: ["inspection", "property", "report"],
      metadata: {
        propertyId: "prop123",
        inspectorId: "inspector789",
        inspectionDate: "2024-01-10"
      },
      createdBy: user?.id || "",
      createdAt: "2024-01-10T14:30:00Z",
      updatedAt: "2024-01-10T14:30:00Z",
      downloadCount: 8,
      isFavorite: false,
      permissions: {
        canView: true,
        canEdit: false,
        canDelete: false,
        canShare: true
      }
    }, {
      id: "3",
      title: t("client.src.property_photos_living_room"),
      description: t("client.src.highquality_photos_of_the"),
      type: "image",
      category: "Media",
      size: 8388608,
      mimeType: "image/jpeg",
      url: "/documents/living-room-photos.zip",
      thumbnailUrl: "/thumbnails/living-room.jpg",
      status: "active",
      visibility: "public",
      tags: ["photos", "living-room", "media"],
      metadata: {
        propertyId: "prop123",
        photographer: "John Doe",
        photoCount: 25
      },
      createdBy: user?.id || "",
      createdAt: "2024-01-08T09:15:00Z",
      updatedAt: "2024-01-08T09:15:00Z",
      downloadCount: 45,
      isFavorite: true,
      permissions: {
        canView: true,
        canEdit: true,
        canDelete: true,
        canShare: true
      }
    }, {
      id: "4",
      title: t("client.src.financial_statements_q4_2023"),
      description: t("client.src.quarterly_financial_statements_and"),
      type: "spreadsheet",
      category: "Financial",
      size: 1048576,
      mimeType: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
      url: "/documents/financial-statements-q4.xlsx",
      thumbnailUrl: "/thumbnails/spreadsheet.jpg",
      status: "active",
      visibility: "private",
      tags: ["financial", "q4", "2023"],
      metadata: {
        quarter: "Q4",
        year: 2023,
        revenue: 1250000,
        expenses: 890000
      },
      createdBy: user?.id || "",
      createdAt: "2024-01-05T16:45:00Z",
      updatedAt: "2024-01-05T16:45:00Z",
      downloadCount: 6,
      isFavorite: false,
      permissions: {
        canView: true,
        canEdit: true,
        canDelete: true,
        canShare: false
      }
    }];
    const mockFolders: DocFolder[] = [{
      id: "folder1",
      name: "Legal Documents",
      description: t("client.src.all_legal_contracts_and"),
      parentId: null,
      documentCount: 15,
      size: 52428800,
      createdBy: user?.id || "",
      createdAt: "2024-01-01T00:00:00Z",
      updatedAt: "2024-01-15T10:00:00Z",
      isShared: false,
      permissions: {
        canView: true,
        canEdit: true,
        canDelete: true
      }
    }, {
      id: "folder2",
      name: "Property Photos",
      description: t("client.src.highquality_property_images_and"),
      parentId: null,
      documentCount: 48,
      size: 1073741824,
      createdBy: user?.id || "",
      createdAt: "2024-01-01T00:00:00Z",
      updatedAt: "2024-01-08T09:15:00Z",
      isShared: true,
      permissions: {
        canView: true,
        canEdit: true,
        canDelete: true
      }
    }, {
      id: "folder3",
      name: "Financial Reports",
      description: t("client.src.monthly_and_quarterly_financial"),
      parentId: null,
      documentCount: 12,
      size: 20971520,
      createdBy: user?.id || "",
      createdAt: "2024-01-01T00:00:00Z",
      updatedAt: "2024-01-05T16:45:00Z",
      isShared: false,
      permissions: {
        canView: true,
        canEdit: true,
        canDelete: true
      }
    }];
    setDocuments(mockDocuments);
    setFolders(mockFolders);
  }, [user]);
  const getDocumentIcon = (type: string) => {
    switch (type) {
      case "contract":
      case "invoice":
      case "report":
        return <FileText className="w-8 h-8" />;
      case "image":
        return <FileImage className="w-8 h-8" />;
      case "video":
        return <FileVideo className="w-8 h-8" />;
      case "audio":
        return <FileAudio className="w-8 h-8" />;
      case "archive":
        return <FileArchive className="w-8 h-8" />;
      case "code":
        return <FileCode className="w-8 h-8" />;
      case "spreadsheet":
        return <FileSpreadsheet className="w-8 h-8" />;
      default:
        return <FileIcon className="w-8 h-8" />;
    }
  };
  const getStatusColor = (status: string) => {
    switch (status) {
      case "active":
        return "bg-green-500/10 text-green-500 border-green-200";
      case "archived":
        return "bg-gray-500/10 text-gray-500 border-gray-200";
      case "deleted":
        return "bg-red-500/10 text-red-500 border-red-200";
      case "processing":
        return "bg-blue-500/10 text-blue-500 border-blue-200";
      default:
        return "bg-gray-500/10 text-gray-500 border-gray-200";
    }
  };
  const getVisibilityIcon = (visibility: string) => {
    switch (visibility) {
      case "public":
        return <UnlockIcon className="w-4 h-4" />;
      case "private":
        return <LockIcon className="w-4 h-4" />;
      case "shared":
        return <Share2 className="w-4 h-4" />;
      default:
        return <LockIcon className="w-4 h-4" />;
    }
  };
  const formatFileSize = (bytes: number) => {
    if (bytes === 0) return "0 Bytes";
    const k = 1024;
    const sizes = ["Bytes", "KB", "MB", "GB"];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + " " + sizes[i];
  };
  const filteredDocuments = documents.filter(doc => {
    const matchesType = filterType === "all" || doc.type === filterType;
    const matchesStatus = filterStatus === "all" || doc.status === filterStatus;
    const matchesSearch = doc.title.toLowerCase().includes(searchTerm.toLowerCase()) || doc.description?.toLowerCase().includes(searchTerm.toLowerCase()) || doc.tags.some(tag => tag.toLowerCase().includes(searchTerm.toLowerCase()));
    return matchesType && matchesStatus && matchesSearch;
  });
  const sortedDocuments = [...filteredDocuments].sort((a, b) => {
    let comparison = 0;
    switch (sortBy) {
      case "name":
        comparison = a.title.localeCompare(b.title);
        break;
      case "date":
        comparison = new Date(a.createdAt).getTime() - new Date(b.createdAt).getTime();
        break;
      case "size":
        comparison = a.size - b.size;
        break;
      case "type":
        comparison = a.type.localeCompare(b.type);
        break;
    }
    return sortOrder === "asc" ? comparison : -comparison;
  });
  const handleDocumentSelect = (documentId: string) => {
    setSelectedDocuments(prev => prev.includes(documentId) ? prev.filter(id => id !== documentId) : [...prev, documentId]);
  };
  const handleSelectAll = () => {
    if (selectedDocuments.length === sortedDocuments.length) {
      setSelectedDocuments([]);
    } else {
      setSelectedDocuments(sortedDocuments.map(doc => doc.id));
    }
  };
  return <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold flex items-center gap-2">
            <FileText className="w-8 h-8" />{t("client.src.documents")}</h1>
          <p className="text-muted-foreground">{t("client.src.manage_your_documents_contracts")}</p>
        </div>
        <div className="flex items-center gap-2">
          <Button variant="outline" onClick={() => setShowCreateFolderDialog(true)}>
            <Folder className="w-4 h-4 mr-2" />{t("client.src.new_folder")}</Button>
          <Button onClick={() => setShowUploadDialog(true)}>
            <Upload className="w-4 h-4 mr-2" />{t("client.src.upload_files")}</Button>
        </div>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <Card>
          <CardContent className="p-4">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-muted-foreground">{t("client.src.total_documents")}</p>
                <p className="text-2xl font-bold">{documents.length}</p>
              </div>
              <FileText className="w-8 h-8 text-blue-500" />
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="p-4">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-muted-foreground">{t("client.src.total_size")}</p>
                <p className="text-2xl font-bold">
                  {formatFileSize(documents.reduce((acc, doc) => acc + doc.size, 0))}
                </p>
              </div>
              <FileArchive className="w-8 h-8 text-green-500" />
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="p-4">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-muted-foreground">{t("client.src.shared")}</p>
                <p className="text-2xl font-bold">
                  {documents.filter(doc => doc.visibility === "shared").length}
                </p>
              </div>
              <Share2 className="w-8 h-8 text-purple-500" />
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="p-4">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-muted-foreground">{t("client.src.favorites")}</p>
                <p className="text-2xl font-bold">
                  {documents.filter(doc => doc.isFavorite).length}
                </p>
              </div>
              <Star className="w-8 h-8 text-yellow-500" />
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Filters and Search */}
      <Card>
        <CardContent className="p-4">
          <div className="flex flex-wrap items-center gap-4">
            <div className="flex items-center gap-2">
              <Checkbox checked={selectedDocuments.length === sortedDocuments.length} onCheckedChange={handleSelectAll} />
              <span className="text-sm">{t("client.src.select_all")}</span>
            </div>
            <div className="flex items-center gap-2">
              <Search className="w-4 h-4" />
              <Input placeholder={t("client.src.search_documents")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="w-64" />
            </div>
            <Select value={filterType} onValueChange={setFilterType}>
              <SelectTrigger className="w-40">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("client.src.all_types")}</SelectItem>
                <SelectItem value="contract">{t("client.src.contracts")}</SelectItem>
                <SelectItem value="invoice">{t("client.src.invoices")}</SelectItem>
                <SelectItem value="report">{t("client.src.reports")}</SelectItem>
                <SelectItem value="image">{t("client.src.images")}</SelectItem>
                <SelectItem value="video">{t("client.src.videos")}</SelectItem>
                <SelectItem value="audio">{t("client.src.audio")}</SelectItem>
                <SelectItem value="archive">{t("client.src.archives")}</SelectItem>
                <SelectItem value="code">{t("client.src.code")}</SelectItem>
                <SelectItem value="spreadsheet">{t("client.src.spreadsheets")}</SelectItem>
              </SelectContent>
            </Select>
            <Select value={filterStatus} onValueChange={setFilterStatus}>
              <SelectTrigger className="w-32">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("client.src.all_status")}</SelectItem>
                <SelectItem value="active">{t("client.src.active")}</SelectItem>
                <SelectItem value="archived">{t("client.src.archived")}</SelectItem>
                <SelectItem value="deleted">{t("client.src.deleted")}</SelectItem>
                <SelectItem value="processing">{t("client.src.processing")}</SelectItem>
              </SelectContent>
            </Select>
            <Select value={sortBy} onValueChange={(value: any) => setSortBy(value)}>
              <SelectTrigger className="w-32">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="name">{t("client.src.name")}</SelectItem>
                <SelectItem value="date">{t("client.src.date")}</SelectItem>
                <SelectItem value="size">{t("client.src.size")}</SelectItem>
                <SelectItem value="type">{t("client.src.type")}</SelectItem>
              </SelectContent>
            </Select>
            <Button variant="outline" size="sm" onClick={() => setSortOrder(sortOrder === "asc" ? "desc" : "asc")}>
              {sortOrder === "asc" ? <SortAsc className="w-4 h-4" /> : <SortDesc className="w-4 h-4" />}
            </Button>
            <div className="flex items-center gap-2 ml-auto">
              <Button variant={viewMode === "grid" ? "default" : "outline"} size="sm" onClick={() => setViewMode("grid")}>
                <Grid3X3 className="w-4 h-4" />
              </Button>
              <Button variant={viewMode === "list" ? "default" : "outline"} size="sm" onClick={() => setViewMode("list")}>
                <List className="w-4 h-4" />
              </Button>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Folders */}
      {folders.length > 0 && <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Folder className="w-5 h-5" />{t("client.src.folders")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
              {folders.map(folder => <motion.div key={folder.id} initial={{
            opacity: 0,
            y: 10
          }} animate={{
            opacity: 1,
            y: 0
          }} className="border rounded-lg p-4 hover:shadow-md transition-shadow cursor-pointer">
                  <div className="flex items-center gap-3">
                    <Folder className="w-8 h-8 text-blue-500" />
                    <div className="flex-1">
                      <h3 className="font-medium">{folder.name}</h3>
                      <p className="text-sm text-muted-foreground">
                        {folder.documentCount}{t("client.src.documents")}{formatFileSize(folder.size)}
                      </p>
                    </div>
                    {folder.isShared && <Share2 className="w-4 h-4 text-purple-500" />}
                  </div>
                </motion.div>)}
            </div>
          </CardContent>
        </Card>}

      {/* Documents */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center justify-between">
            <span className="flex items-center gap-2">
              <FileText className="w-5 h-5" />{t("client.src.documents")}{sortedDocuments.length})
            </span>
            {selectedDocuments.length > 0 && <div className="flex items-center gap-2">
                <Badge variant="secondary">
                  {selectedDocuments.length}{t("client.src.selected")}</Badge>
                <Button size="sm" variant="outline">
                  <Download className="w-4 h-4 mr-2" />{t("client.src.download")}</Button>
                <Button size="sm" variant="outline">
                  <Share2 className="w-4 h-4 mr-2" />{t("client.src.share")}</Button>
                <Button size="sm" variant="outline">
                  <Trash2 className="w-4 h-4 mr-2" />{t("client.src.delete")}</Button>
              </div>}
          </CardTitle>
        </CardHeader>
        <CardContent>
          {viewMode === "grid" ? <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
              {sortedDocuments.map(doc => <motion.div key={doc.id} initial={{
            opacity: 0,
            scale: 0.9
          }} animate={{
            opacity: 1,
            scale: 1
          }} className={`border rounded-lg p-4 hover:shadow-md transition-shadow cursor-pointer ${selectedDocuments.includes(doc.id) ? "ring-2 ring-blue-500" : ""}`} onClick={() => handleDocumentSelect(doc.id)}>
                  <div className="flex items-start justify-between mb-3">
                    <div className={`p-2 rounded-lg ${getStatusColor(doc.status)}`}>
                      {getDocumentIcon(doc.type)}
                    </div>
                    <div className="flex items-center gap-1">
                      {doc.isFavorite && <Star className="w-4 h-4 text-yellow-500 fill-current" />}
                      {getVisibilityIcon(doc.visibility)}
                    </div>
                  </div>
                  <h3 className="font-medium text-sm mb-1 line-clamp-2">{doc.title}</h3>
                  <p className="text-xs text-muted-foreground mb-2 line-clamp-2">
                    {doc.description}
                  </p>
                  <div className="flex items-center justify-between text-xs text-muted-foreground">
                    <span>{formatFileSize(doc.size)}</span>
                    <span>{format(new Date(doc.createdAt), "MMM d, yyyy")}</span>
                  </div>
                  <div className="flex flex-wrap gap-1 mt-2">
                    {doc.tags.slice(0, 2).map(tag => <Badge key={tag} variant="secondary" className="text-xs">
                        {tag}
                      </Badge>)}
                    {doc.tags.length > 2 && <Badge variant="secondary" className="text-xs">
                        +{doc.tags.length - 2}
                      </Badge>}
                  </div>
                </motion.div>)}
            </div> : <div className="space-y-2">
              {sortedDocuments.map(doc => <motion.div key={doc.id} initial={{
            opacity: 0,
            x: -10
          }} animate={{
            opacity: 1,
            x: 0
          }} className={`border rounded-lg p-4 hover:shadow-md transition-shadow cursor-pointer ${selectedDocuments.includes(doc.id) ? "ring-2 ring-blue-500" : ""}`} onClick={() => handleDocumentSelect(doc.id)}>
                  <div className="flex items-center gap-4">
                    <Checkbox checked={selectedDocuments.includes(doc.id)} onChange={() => handleDocumentSelect(doc.id)} />
                    <div className={`p-2 rounded-lg ${getStatusColor(doc.status)}`}>
                      {getDocumentIcon(doc.type)}
                    </div>
                    <div className="flex-1">
                      <div className="flex items-center gap-2 mb-1">
                        <h3 className="font-medium">{doc.title}</h3>
                        {doc.isFavorite && <Star className="w-4 h-4 text-yellow-500 fill-current" />}
                        <Badge className={getStatusColor(doc.status)}>
                          {doc.status}
                        </Badge>
                      </div>
                      {doc.description && <p className="text-sm text-muted-foreground mb-1">{doc.description}</p>}
                      <div className="flex items-center gap-4 text-xs text-muted-foreground">
                        <span>{formatFileSize(doc.size)}</span>
                        <span>{format(new Date(doc.createdAt), "MMM d, yyyy")}</span>
                        <span>{doc.downloadCount}{t("client.src.downloads")}</span>
                        <div className="flex items-center gap-1">
                          {getVisibilityIcon(doc.visibility)}
                          <span>{doc.visibility}</span>
                        </div>
                      </div>
                      <div className="flex flex-wrap gap-1 mt-2">
                        {doc.tags.map(tag => <Badge key={tag} variant="secondary" className="text-xs">
                            {tag}
                          </Badge>)}
                      </div>
                    </div>
                    <DropdownMenu>
                      <DropdownMenuTrigger asChild>
                        <Button variant="ghost" size="sm">
                          <MoreHorizontal className="w-4 h-4" />
                        </Button>
                      </DropdownMenuTrigger>
                      <DropdownMenuContent>
                        <DropdownMenuItem>
                          <Eye className="w-4 h-4 mr-2" />{t("client.src.view")}</DropdownMenuItem>
                        <DropdownMenuItem>
                          <Download className="w-4 h-4 mr-2" />{t("client.src.download")}</DropdownMenuItem>
                        <DropdownMenuItem>
                          <Share2 className="w-4 h-4 mr-2" />{t("client.src.share")}</DropdownMenuItem>
                        <DropdownMenuItem>
                          <Edit className="w-4 h-4 mr-2" />{t("client.src.edit")}</DropdownMenuItem>
                        <DropdownMenuSeparator />
                        <DropdownMenuItem>
                          <Trash2 className="w-4 h-4 mr-2" />{t("client.src.delete")}</DropdownMenuItem>
                      </DropdownMenuContent>
                    </DropdownMenu>
                  </div>
                </motion.div>)}
            </div>}
        </CardContent>
      </Card>

      {/* Upload Dialog */}
      <Dialog open={showUploadDialog} onOpenChange={setShowUploadDialog}>
        <DialogContent className="max-w-2xl">
          <DialogHeader>
            <DialogTitle>{t("client.src.upload_documents")}</DialogTitle>
            <DialogDescription>{t("client.src.upload_one_or_more")}</DialogDescription>
          </DialogHeader>
          <div className="grid gap-4 py-4">
            <div className="border-2 border-dashed border-gray-300 rounded-lg p-8 text-center">
              <Upload className="w-12 h-12 mx-auto mb-4 text-gray-400" />
              <p className="text-lg font-medium mb-2">{t("client.src.drop_files_here_or")}</p>
              <p className="text-sm text-gray-500 mb-4">{t("client.src.supported_formats_pdf_doc")}</p>
              <Button>
                <FilePlus className="w-4 h-4 mr-2" />{t("client.src.select_files")}</Button>
            </div>
            <div>
              <Label className="text-sm font-medium mb-2 block">{t("client.src.folder")}</Label>
              <Select>
                <SelectTrigger>
                  <SelectValue placeholder={t("client.src.select_folder")} />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="root">{t("client.src.root")}</SelectItem>
                  {folders.map(folder => <SelectItem key={folder.id} value={folder.id}>
                      {folder.name}
                    </SelectItem>)}
                </SelectContent>
              </Select>
            </div>
            <div>
              <Label className="text-sm font-medium mb-2 block">{t("client.src.tags")}</Label>
              <Input placeholder={t("client.src.enter_tags_separated_by")} />
            </div>
            <div>
              <Label className="text-sm font-medium mb-2 block">{t("client.src.visibility")}</Label>
              <Select>
                <SelectTrigger>
                  <SelectValue placeholder={t("client.src.select_visibility")} />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="private">{t("client.src.private")}</SelectItem>
                  <SelectItem value="shared">{t("client.src.shared")}</SelectItem>
                  <SelectItem value="public">{t("client.src.public")}</SelectItem>
                </SelectContent>
              </Select>
            </div>
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setShowUploadDialog(false)}>{t("client.src.cancel")}</Button>
            <Button onClick={() => setShowUploadDialog(false)}>{t("client.src.upload_files")}</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Create Folder Dialog */}
      <Dialog open={showCreateFolderDialog} onOpenChange={setShowCreateFolderDialog}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>{t("client.src.create_new_folder")}</DialogTitle>
            <DialogDescription>{t("client.src.create_a_new_folder")}</DialogDescription>
          </DialogHeader>
          <div className="grid gap-4 py-4">
            <div>
              <Label className="text-sm font-medium mb-2 block">{t("client.src.folder_name")}</Label>
              <Input placeholder={t("client.src.enter_folder_name")} />
            </div>
            <div>
              <Label className="text-sm font-medium mb-2 block">{t("client.src.description")}</Label>
              <Textarea placeholder={t("client.src.enter_folder_description")} rows={3} />
            </div>
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setShowCreateFolderDialog(false)}>{t("client.src.cancel")}</Button>
            <Button onClick={() => setShowCreateFolderDialog(false)}>{t("client.src.create_folder")}</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>;
}