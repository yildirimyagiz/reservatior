"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { Progress } from "@/components/ui/progress";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { apiClient } from "@/lib/api/client";
import { Upload, FileText, Download, Eye, Edit, Trash2, MoreHorizontal, FileCheck, Clock, CheckCircle, XCircle, BarChart3, Brain, Share, Search } from "lucide-react";
import { Input } from "@/components/ui/input";
import { CardDescription } from "@/components/ui/card";
import { DialogDescription } from "@/components/ui/dialog";
interface LegalDocument {
  id: string;
  orgId: string;
  title: string;
  description?: string;
  documentType: DocumentType;
  status: DocumentStatus;
  filePath: string;
  fileName: string;
  fileSize: number;
  mimeType: string;
  uploadedBy: string;
  uploadedAt: string;
  expiresAt?: string;
  isPublic: boolean;
  tags: string[];
  metadata?: {
    propertyId?: string;
    contractId?: string;
    leaseId?: string;
    tenantId?: string;
    signedAt?: string;
    signatories?: Array<{
      name: string;
      email: string;
      signedAt?: string;
    }>;
    analysisResults?: {
      status: AnalysisStatus;
      confidence?: number;
      extractedFields?: Record<string, any>;
      summary?: string;
      completedAt?: string;
    };
  };
  createdAt: string;
  updatedAt: string;
  property?: {
    id: string;
    name: string;
    addressLine1: string;
  };
  contract?: {
    id: string;
    title: string;
    status: string;
  };
  uploader?: {
    id: string;
    name: string;
    email: string;
  };
}
enum DocumentType {
  TITLE_DEED = "TITLE_DEED",
  LEASE = "LEASE",
  IDENTITY = "IDENTITY",
  INCOME = "INCOME",
  INSURANCE = "INSURANCE",
  COMPLIANCE = "COMPLIANCE",
  CONTRACT = "CONTRACT",
  AGREEMENT = "AGREEMENT",
  CERTIFICATE = "CERTIFICATE",
  OTHER = "OTHER",
}
enum DocumentStatus {
  DRAFT = "DRAFT",
  PENDING_REVIEW = "PENDING_REVIEW",
  APPROVED = "APPROVED",
  REJECTED = "REJECTED",
  EXPIRED = "EXPIRED",
  ARCHIVED = "ARCHIVED",
}
enum AnalysisStatus {
  PENDING = "PENDING",
  RUNNING = "RUNNING",
  COMPLETED = "COMPLETED",
  FAILED = "FAILED",
}
const DOCUMENT_TYPES = {
  TITLE_DEED: {
    label: t("client.src.title_deed"),
    color: "bg-blue-100 text-blue-800"
  },
  LEASE: {
    label: t("client.src.lease_agreement"),
    color: "bg-blue-100 text-blue-800"
  },
  IDENTITY: {
    label: t("client.src.identity_document"),
    color: "bg-brand/15 text-brand"
  },
  INCOME: {
    label: t("client.src.income_proof"),
    color: "bg-yellow-100 text-yellow-800"
  },
  INSURANCE: {
    label: t("client.src.insurance_policy"),
    color: "bg-red-100 text-red-800"
  },
  COMPLIANCE: {
    label: t("client.src.compliance_certificate"),
    color: "bg-brand/15 text-brand"
  },
  CONTRACT: {
    label: t("client.src.contract"),
    color: "bg-orange-100 text-orange-800"
  },
  AGREEMENT: {
    label: t("client.src.agreement"),
    color: "bg-pink-100 text-pink-800"
  },
  CERTIFICATE: {
    label: t("client.src.certificate"),
    color: "bg-brand/15 text-brand"
  },
  OTHER: {
    label: t("client.src.other"),
    color: "bg-gray-100 text-gray-800"
  }
};
const ANALYSIS_STATUS = {
  PENDING: {
    label: t("common.processing"),
    icon: Clock,
    color: "text-yellow-600"
  },
  RUNNING: {
    label: t("client.src.analyzing"),
    icon: Brain,
    color: "text-brand"
  },
  COMPLETED: {
    label: t("common.completed"),
    icon: CheckCircle,
    color: "text-blue-600"
  },
  FAILED: {
    label: t("common.failed"),
    icon: XCircle,
    color: "text-red-600"
  }
};
const DOCUMENT_STATUS = {
  DRAFT: {
    label: t("common.draft"),
    color: "bg-gray-100 text-gray-700"
  },
  PENDING_REVIEW: {
    label: t("client.src.pending_review"),
    color: "bg-yellow-100 text-yellow-700"
  },
  APPROVED: {
    label: t("common.approved"),
    color: "bg-blue-100 text-blue-700"
  },
  REJECTED: {
    label: t("common.rejected"),
    color: "bg-red-100 text-red-700"
  },
  EXPIRED: {
    label: t("common.expired"),
    color: "bg-orange-100 text-orange-700"
  },
  ARCHIVED: {
    label: t("client.src.archived"),
    color: "bg-gray-100 text-gray-500"
  }
};
export default function DocumentsEnhanced() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [activeTab, setActiveTab] = useState<"documents" | "analytics">("documents");
  const [search, setSearch] = useState("");
  const [filterType, setFilterType] = useState("all");
  const [filterStatus, setFilterStatus] = useState("all");
  const [uploadOpen, setUploadOpen] = useState(false);
  const [documents, setDocuments] = useState<LegalDocument[]>([]);
  const [loading, setLoading] = useState(true);
  // const [selectedDocument, setSelectedDocument] = useState<LegalDocument | null>(null);

  // Fetch documents from API
  useEffect(() => {
    const fetchDocuments = async () => {
      try {
        setLoading(true);
        const response = await apiClient.get('/legal/documents', {
          page: "1",
          limit: "50"
        });
        setDocuments((response as any).data || []);
      } catch (error) {
        console.error('Error fetching documents:', error);
        toast({
          title: t("common.error"),
          description: t("client.src.failed_to_load_legal"),
          variant: "destructive"
        });
      } finally {
        setLoading(false);
      }
    };
    fetchDocuments();
  }, []);
  const filteredDocuments = documents.filter(document => {
    const matchesSearch = document.title.toLowerCase().includes(search.toLowerCase()) || document.description?.toLowerCase().includes(search.toLowerCase()) || document.fileName.toLowerCase().includes(search.toLowerCase());
    const matchesType = filterType === "all" || document.documentType === filterType;
    const matchesStatus = filterStatus === "all" || document.status === filterStatus;
    return matchesSearch && matchesType && matchesStatus;
  });
  const totalDocuments = filteredDocuments.length;
  const approvedDocuments = filteredDocuments.filter(d => d.status === "APPROVED").length;
  const pendingDocuments = filteredDocuments.filter(d => d.status === "PENDING_REVIEW").length;
  const analyzedDocuments = filteredDocuments.filter(d => d.metadata?.analysisResults?.status === "COMPLETED").length;
  const handleUploadDocument = async (file: File, metadata: any) => {
    try {
      const formData = new FormData();
      formData.append('file', file);
      formData.append('metadata', JSON.stringify(metadata));
      await apiClient.post('/legal/documents/upload', formData, {
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      });
      setUploadOpen(false);
      toast({
        title: t("client.src.document_uploaded"),
        description: t("client.src.legal_document_has_been")
      });

      // Refresh data
      const response = await apiClient.get('/legal/documents');
      setDocuments((response as any).data || []);
    } catch (error) {
      console.error('Error uploading document:', error);
      toast({
        title: t("common.error"),
        description: t("client.src.failed_to_upload_document"),
        variant: "destructive"
      });
    }
  };
  const handleUpdateStatus = async (id: string, status: DocumentStatus) => {
    try {
      await apiClient.patch(`/legal/documents/${id}`, {
        status
      });
      setDocuments(documents.map(d => d.id === id ? {
        ...d,
        status
      } : d));
      toast({
        title: t("client.src.status_updated"),
        description: t("client.src.document_status_has_been")
      });
    } catch (error) {
      console.error('Error updating status:', error);
    }
  };
  const handleDeleteDocument = async (id: string) => {
    try {
      await apiClient.delete(`/legal/documents/${id}`);
      setDocuments(documents.filter(d => d.id !== id));
      toast({
        title: t("client.src.document_deleted"),
        description: t("client.src.document_has_been_deleted")
      });
    } catch (error) {
      console.error('Error deleting document:', error);
    }
  };
  const handleAnalyzeDocument = async (id: string) => {
    try {
      await apiClient.post(`/legal/documents/${id}/analyze`);
      setDocuments(documents.map(d => d.id === id ? {
        ...d,
        metadata: {
          ...d.metadata,
          analysisResults: {
            ...d.metadata?.analysisResults,
            status: AnalysisStatus.RUNNING
          }
        }
      } : d));
      toast({
        title: t("client.src.analysis_started"),
        description: t("client.src.document_analysis_has_been")
      });
    } catch (error) {
      console.error('Error starting analysis:', error);
    }
  };
  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString();
  };
  const formatFileSize = (bytes: number) => {
    if (bytes === 0) return '0 Bytes';
    const k = 1024;
    const sizes = ['Bytes', 'KB', 'MB', 'GB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
  };
  const getDocumentTypeColor = (type: DocumentType) => {
    const config = DOCUMENT_TYPES[type];
    return config ? config.color : "bg-gray-100 text-gray-800";
  };
  const getStatusColor = (status: DocumentStatus) => {
    const config = DOCUMENT_STATUS[status];
    return config ? config.color : "bg-gray-100 text-gray-700";
  };
  const getAnalysisIcon = (status: AnalysisStatus | undefined) => {
    const config = ANALYSIS_STATUS[status ?? AnalysisStatus.PENDING];
    return config ? <config.icon className="h-4 w-4" /> : null;
  };
  const getAnalysisColor = (status: AnalysisStatus | undefined) => {
    const config = ANALYSIS_STATUS[status ?? AnalysisStatus.PENDING];
    return config ? config.color : "text-gray-600";
  };
  return <PageShell title={t("client.src.legal_documents")} description={t("client.src.manage_legal_documents_contracts")}>
      <div className="space-y-6">
        {/* Tab Navigation */}
        <div className="flex space-x-1 bg-muted p-1 rounded-lg w-fit">
          <Button variant={activeTab === "documents" ? "default" : "ghost"} size="sm" onClick={() => setActiveTab("documents")}>
            <FileText className="h-4 w-4 mr-2" />{t("common.documents")}</Button>
          <Button variant={activeTab === "analytics" ? "default" : "ghost"} size="sm" onClick={() => setActiveTab("analytics")}>
            <BarChart3 className="h-4 w-4 mr-2" />{t("common.analytics")}</Button>
        </div>

        {/* Summary Cards */}
        <div className="grid gap-4 md:grid-cols-4">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("client.src.total_documents")}</CardTitle>
              <FileText className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{totalDocuments}</div>
              <p className="text-xs text-muted-foreground">{t("client.src.all_legal_documents")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("common.approved")}</CardTitle>
              <CheckCircle className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-blue-600">{approvedDocuments}</div>
              <p className="text-xs text-muted-foreground">
                {totalDocuments > 0 ? (approvedDocuments / totalDocuments * 100).toFixed(1) : 0}{t("common.approved")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("client.src.pending_review")}</CardTitle>
              <Clock className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-yellow-600">{pendingDocuments}</div>
              <p className="text-xs text-muted-foreground">{t("client.src.need_attention")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("client.src.analyzed")}</CardTitle>
              <Brain className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-brand">{analyzedDocuments}</div>
              <p className="text-xs text-muted-foreground">{t("client.src.ai_processed")}</p>
            </CardContent>
          </Card>
        </div>

        {/* Filters and Actions */}
        <div className="flex items-center justify-between space-x-4">
          <div className="flex items-center space-x-2">
            <div className="relative">
              <Search className="absolute left-2 top-2.5 h-4 w-4 text-gray-400" />
              <Input placeholder={t("client.src.search_documents")} value={search} onChange={(e: React.ChangeEvent<HTMLInputElement>) => setSearch(e.target.value)} className="pl-8 w-64" />
            </div>
            <Select value={filterType} onValueChange={setFilterType}>
              <SelectTrigger className="w-32">
                <SelectValue placeholder={t("common.type")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("common.all_types")}</SelectItem>
                {Object.values(DocumentType).map(type => <SelectItem key={type} value={type}>
                    {DOCUMENT_TYPES[type]?.label || type}
                  </SelectItem>)}
              </SelectContent>
            </Select>
            <Select value={filterStatus} onValueChange={setFilterStatus}>
              <SelectTrigger className="w-32">
                <SelectValue placeholder={t("common.status")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("common.all_status")}</SelectItem>
                {Object.values(DocumentStatus).map(status => <SelectItem key={status} value={status}>
                    {DOCUMENT_STATUS[status]?.label || status}
                  </SelectItem>)}
              </SelectContent>
            </Select>
          </div>
          <Button onClick={() => setUploadOpen(true)}>
            <Upload className="h-4 w-4 mr-2" />{t("client.src.upload_document")}</Button>
        </div>

        {/* Content based on active tab */}
        {activeTab === "documents" && <Card>
            <CardHeader>
              <CardTitle>{t("client.src.legal_documents")}</CardTitle>
              <CardDescription>{t("client.src.manage_legal_documents_contracts")}</CardDescription>
            </CardHeader>
            <CardContent>
              {loading ? <div className="flex items-center justify-center py-8">
                  <div className="text-sm text-muted-foreground">{t("common.loading")}</div>
                </div> : <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("common.title")}</TableHead>
                      <TableHead>{t("common.type")}</TableHead>
                      <TableHead>{t("common.status")}</TableHead>
                      <TableHead>{t("client.src.uploaded_by")}</TableHead>
                      <TableHead>{t("client.src.file_size")}</TableHead>
                      <TableHead>{t("client.src.uploaded")}</TableHead>
                      <TableHead>{t("client.src.analysis")}</TableHead>
                      <TableHead className="w-[50px]"></TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {filteredDocuments.length === 0 ? <TableRow>
                        <TableCell colSpan={9} className="text-center py-8">{t("client.src.no_documents_found")}</TableCell>
                      </TableRow> : filteredDocuments.map(document => <TableRow key={document.id}>
                          <TableCell className="font-medium">
                            <div>
                              <div className="font-medium">{document.title}</div>
                              {document.description && <div className="text-sm text-muted-foreground truncate max-w-[200px]">
                                  {document.description}
                                </div>}
                            </div>
                          </TableCell>
                          <TableCell>
                            <Badge className={getDocumentTypeColor(document.documentType)}>
                              {DOCUMENT_TYPES[document.documentType]?.label}
                            </Badge>
                          </TableCell>
                          <TableCell>
                            <Badge className={getStatusColor(document.status)}>
                              {DOCUMENT_STATUS[document.status]?.label}
                            </Badge>
                          </TableCell>
                          <TableCell>
                            <div>
                              <div className="font-medium">{document.uploader?.name}</div>
                              <div className="text-sm text-muted-foreground">
                                {document.uploader?.email}
                              </div>
                            </div>
                          </TableCell>
                          <TableCell>
                            <div className="text-sm">{formatFileSize(document.fileSize)}</div>
                          </TableCell>
                          <TableCell>
                            <div className="text-sm">{formatDate(document.uploadedAt)}</div>
                          </TableCell>
                          <TableCell>
                            {document.metadata?.analysisResults ? <div className="flex items-center space-x-2">
                                {getAnalysisIcon(document.metadata.analysisResults.status)}
                                <span className={`text-sm ${getAnalysisColor(document.metadata.analysisResults.status)}`}>
                                  {ANALYSIS_STATUS[document.metadata.analysisResults.status]?.label}
                                </span>
                              </div> : <Button variant="outline" size="sm" onClick={() => handleAnalyzeDocument(document.id)}>
                                <Brain className="h-4 w-4 mr-1" />{t("client.src.analyze")}</Button>}
                          </TableCell>
                          <TableCell>
                            <DropdownMenu>
                              <DropdownMenuTrigger asChild>
                                <Button variant="ghost" size="sm" aria-label={t("common.more")}>
                                  <MoreHorizontal className="h-4 w-4" />
                                </Button>
                              </DropdownMenuTrigger>
                              <DropdownMenuContent>
                                <DropdownMenuItem>
                                  <Eye className="h-4 w-4 mr-2" />{t("common.view")}</DropdownMenuItem>
                                <DropdownMenuItem>
                                  <Download className="h-4 w-4 mr-2" />{t("common.download")}</DropdownMenuItem>
                                <DropdownMenuItem>
                                  <Share className="h-4 w-4 mr-2" />{t("common.share")}</DropdownMenuItem>
                                <DropdownMenuItem>
                                  <Edit className="h-4 w-4 mr-2" />{t("common.edit")}</DropdownMenuItem>
                                <DropdownMenu>
                                  <DropdownMenuTrigger asChild>
                                    <Button variant="ghost" size="sm">
                                      <FileCheck className="h-4 w-4 mr-2" />{t("common.status")}</Button>
                                  </DropdownMenuTrigger>
                                  <DropdownMenuContent>
                                    {Object.values(DocumentStatus).map(status => <DropdownMenuItem key={status} onClick={() => handleUpdateStatus(document.id, status)}>
                                        {DOCUMENT_STATUS[status]?.label}
                                      </DropdownMenuItem>)}
                                  </DropdownMenuContent>
                                </DropdownMenu>
                                <DropdownMenuItem className="text-red-600" onClick={() => handleDeleteDocument(document.id)}>
                                  <Trash2 className="h-4 w-4 mr-2" />{t("common.delete")}</DropdownMenuItem>
                              </DropdownMenuContent>
                            </DropdownMenu>
                          </TableCell>
                        </TableRow>)}
                  </TableBody>
                </Table>}
            </CardContent>
          </Card>}

        {activeTab === "analytics" && <div className="grid gap-6 md:grid-cols-2">
            <Card>
              <CardHeader>
                <CardTitle>{t("client.src.document_analysis")}</CardTitle>
                <CardDescription>{t("client.src.aipowered_document_analysis_results")}</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {documents.filter(d => d.metadata?.analysisResults).length === 0 ? <div className="text-center py-8">
                      <Brain className="h-12 w-12 text-gray-400 mx-auto mb-4" />
                      <p className="text-muted-foreground">{t("client.src.no_analyzed_documents_yet")}</p>
                    </div> : documents.filter(d => d.metadata?.analysisResults).map(document => <div key={document.id} className="border rounded-lg p-4">
                        <div className="flex items-center justify-between">
                          <div>
                            <h4 className="font-medium">{document.title}</h4>
                            <p className="text-sm text-muted-foreground">
                              {DOCUMENT_TYPES[document.documentType]?.label}
                            </p>
                          </div>
                          <div className="flex items-center space-x-2">
                            {getAnalysisIcon(document.metadata?.analysisResults?.status)}
                            <Badge variant="outline">
                              {ANALYSIS_STATUS[document.metadata?.analysisResults?.status ?? AnalysisStatus.PENDING]?.label}
                            </Badge>
                          </div>
                        </div>
                        {document.metadata?.analysisResults?.summary && <div className="mt-2 p-2 bg-gray-50 rounded text-sm">
                            {document.metadata.analysisResults.summary}
                          </div>}
                        {document.metadata?.analysisResults?.confidence && <div className="mt-2">
                            <div className="flex items-center justify-between text-sm">
                              <span>{t("client.src.confidence")}</span>
                              <span>{Math.round(document.metadata.analysisResults.confidence * 100)}%</span>
                            </div>
                            <Progress value={document.metadata.analysisResults.confidence * 100} className="mt-1" />
                          </div>}
                      </div>)}
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <CardTitle>{t("client.src.document_statistics")}</CardTitle>
                <CardDescription>{t("client.src.overview_of_document_types")}</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  <div>
                    <h4 className="font-medium mb-2">{t("client.src.by_type")}</h4>
                    <div className="space-y-2">
                      {Object.values(DocumentType).map(type => {
                    const count = documents.filter(d => d.documentType === type).length;
                    return <div key={type} className="flex items-center justify-between">
                            <span className="text-sm">{DOCUMENT_TYPES[type]?.label}</span>
                            <span className="text-sm font-medium">{count}</span>
                          </div>;
                  })}
                    </div>
                  </div>
                  <div>
                    <h4 className="font-medium mb-2">{t("client.src.by_status")}</h4>
                    <div className="space-y-2">
                      {Object.values(DocumentStatus).map(status => {
                    const count = documents.filter(d => d.status === status).length;
                    return <div key={status} className="flex items-center justify-between">
                            <span className="text-sm">{DOCUMENT_STATUS[status]?.label}</span>
                            <span className="text-sm font-medium">{count}</span>
                          </div>;
                  })}
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>
          </div>}

        {/* Upload Dialog */}
        <Dialog open={uploadOpen} onOpenChange={setUploadOpen}>
          <DialogContent>
            <DialogHeader>
              <DialogTitle>{t("client.src.upload_legal_document")}</DialogTitle>
              <DialogDescription>{t("client.src.upload_and_categorize_legal")}</DialogDescription>
            </DialogHeader>
            <div className="space-y-4">
              <div>
                <Label htmlFor="file">{t("client.src.document_file")}</Label>
                <Input id="file" type="file" accept=".pdf,.doc,.docx,.txt,.jpg,.png" className="file:mr-2 file:py-2" />
              </div>
              <div>
                <Label htmlFor="title">{t("common.title")}</Label>
                <Input id="title" placeholder={t("client.src.enter_document_title")} />
              </div>
              <div>
                <Label htmlFor="description">{t("common.description")}</Label>
                <textarea id="description" placeholder={t("client.src.enter_document_description")} className="w-full p-2 border rounded" rows={3} />
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <Label htmlFor="documentType">{t("client.src.document_type")}</Label>
                  <Select>
                    <SelectTrigger>
                      <SelectValue placeholder={t("common.select_type")} />
                    </SelectTrigger>
                    <SelectContent>
                      {Object.values(DocumentType).map(type => <SelectItem key={type} value={type}>
                          {DOCUMENT_TYPES[type]?.label}
                        </SelectItem>)}
                    </SelectContent>
                  </Select>
                </div>
                <div>
                  <Label htmlFor="property">{t("client.src.property_optional")}</Label>
                  <Select>
                    <SelectTrigger>
                      <SelectValue placeholder={t("common.select_property")} />
                    </SelectTrigger>
                    <SelectContent>
                      {/* Add property options */}
                    </SelectContent>
                  </Select>
                </div>
              </div>
              <div>
                <Label htmlFor="tags">{t("client.src.tags_comma_separated")}</Label>
                <Input id="tags" placeholder={t("client.src.legal_contract_compliance_etc")} />
              </div>
              <div className="flex items-center space-x-2">
                <input type="checkbox" id="isPublic" />
                <Label htmlFor="isPublic">{t("client.src.make_document_public")}</Label>
              </div>
            </div>
            <DialogFooter>
              <Button variant="outline" onClick={() => setUploadOpen(false)}>{t("common.cancel")}</Button>
              <Button onClick={() => handleUploadDocument(new File([], "placeholder.pdf"), {})}>{t("client.src.upload_document")}</Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>
      </div>
    </PageShell>;
}