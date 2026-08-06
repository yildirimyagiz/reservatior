"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { format, addDays } from "date-fns";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuSeparator, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { FileText, Scale, ShieldCheck, AlertTriangle, Clock, Search, Plus, Eye, Edit, Download, Share2, Trash2, MoreHorizontal, FileSignature, FileCheck, FileWarning, Archive, Lock, Unlock } from "lucide-react";
import { useAuth } from "@/lib/auth/hooks";
import { apiClient } from "@/lib/api/client";
import { useToast } from "@/hooks/use-toast";
import { m } from "framer-motion";
interface LegalDocument {
  id: string;
  title: string;
  type: "contract" | "agreement" | "lease" | "compliance" | "policy" | "disclosure" | "permit" | "license";
  category: string;
  description: string;
  status: "draft" | "review" | "approved" | "signed" | "expired" | "terminated";
  priority: "low" | "medium" | "high" | "urgent";
  parties: Array<{
    id: string;
    name: string;
    type: "client" | "landlord" | "agent" | "tenant" | "lawyer" | "company";
    role: string;
    signed: boolean;
    signedAt?: string;
  }>;
  propertyId?: string;
  clientId?: string;
  lawyerId?: string;
  effectiveDate: string;
  expiryDate?: string;
  renewalDate?: string;
  terms: Array<{
    id: string;
    title: string;
    content: string;
    required: boolean;
  }>;
  attachments: Array<{
    id: string;
    name: string;
    type: string;
    size: number;
    url: string;
  }>;
  compliance: {
    isCompliant: boolean;
    lastChecked: string;
    issues: Array<{
      type: "warning" | "error" | "info";
      severity?: "low" | "medium" | "high" | "critical";
      message: string;
      recommendation?: string;
      resolved: boolean;
    }>;
  };
  createdBy: string;
  createdAt: string;
  updatedAt: string;
  version: number;
  isArchived: boolean;
  tags: string[];
}
interface ComplianceCheck {
  id: string;
  documentId: string;
  type: "regulatory" | "internal" | "legal" | "safety" | "environmental";
  status: "pending" | "in_progress" | "passed" | "failed" | "requires_action";
  score: number;
  maxScore: number;
  checkedBy: string;
  checkedAt: string;
  findings: Array<{
    category: string;
    severity: "low" | "medium" | "high" | "critical";
    description: string;
    recommendation: string;
    resolved: boolean;
  }>;
  nextDue: string;
}
interface LegalTemplate {
  id: string;
  name: string;
  description: string;
  type: LegalDocument["type"];
  category: string;
  content: string;
  variables: Array<{
    key: string;
    label: string;
    type: "text" | "date" | "number" | "select" | "textarea";
    required: boolean;
    options?: string[];
  }>;
  isPublic: boolean;
  usageCount: number;
  createdBy: string;
  createdAt: string;
  updatedAt: string;
}
export default function Legal() {
  const {
    t
  } = useTranslation();
  const {
    user
  } = useAuth();
  const { toast } = useToast();
  const [documents, setDocuments] = useState<LegalDocument[]>([]);
  const [complianceChecks, setComplianceChecks] = useState<ComplianceCheck[]>([]);
  const [templates, setTemplates] = useState<LegalTemplate[]>([]);
  const [searchTerm, setSearchTerm] = useState("");
  const [filterType, setFilterType] = useState<string>("all");
  const [filterStatus, setFilterStatus] = useState<string>("all");
  const [activeTab, setActiveTab] = useState("documents");
  const [showCreateDialog, setShowCreateDialog] = useState(false);
  const [newDocType, setNewDocType] = useState<string>("contract");
  const [newDocCategory, setNewDocCategory] = useState<string>("rental");
  const [newDocTitle, setNewDocTitle] = useState("");
  const [newDocDescription, setNewDocDescription] = useState("");
  const [newDocTemplate, setNewDocTemplate] = useState<string>("");
  const [isCreatingDoc, setIsCreatingDoc] = useState(false);

  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    const fetchLegalData = async () => {
      try {
        setIsLoading(true);
        const [docsRes, checksRes, templatesRes] = await Promise.allSettled([
          apiClient.get('/legal/documents'),
          apiClient.get('/legal/compliance'),
          apiClient.get('/legal/templates')
        ]);
        
        if (docsRes.status === 'fulfilled' && (docsRes.value as any)?.data) {
          setDocuments((docsRes.value as any).data);
        } else {
          setDocuments([]);
        }
        
        if (checksRes.status === 'fulfilled' && (checksRes.value as any)?.data) {
          setComplianceChecks((checksRes.value as any).data);
        } else {
          setComplianceChecks([]);
        }
        
        if (templatesRes.status === 'fulfilled' && (templatesRes.value as any)?.data) {
          setTemplates((templatesRes.value as any).data);
        } else {
          setTemplates([]);
        }
      } catch (error) {
        console.error('Failed to fetch legal data:', error);
      } finally {
        setIsLoading(false);
      }
    };
    
    fetchLegalData();
  }, []);

  const handleCreateDocument = async () => {
    if (!newDocTitle.trim()) {
      toast({
        title: t("common.error"),
        description: t("client.src.enter_document_title"),
        variant: "destructive"
      });
      return;
    }
    setIsCreatingDoc(true);
    try {
      await apiClient.post('/legal/documents', {
        title: newDocTitle,
        type: newDocType,
        category: newDocCategory,
        description: newDocDescription,
        status: "draft",
        priority: "medium",
        templateId: newDocTemplate || undefined
      });
      setShowCreateDialog(false);
      setNewDocTitle("");
      setNewDocDescription("");
      toast({
        title: t("common.success"),
        description: t("client.src.legal_document_has_been")
      });
      const response = await apiClient.get('/legal/documents');
      setDocuments((response as any).data || []);
    } catch (error) {
      console.error('Create document failed:', error);
      toast({
        title: t("common.error"),
        description: t("common.error_generic"),
        variant: "destructive"
      });
    } finally {
      setIsCreatingDoc(false);
    }
  };
  const getDocumentIcon = (type: string) => {
    switch (type) {
      case "contract":
        return <FileText className="w-8 h-8" />;
      case "agreement":
        return <FileCheck className="w-8 h-8" />;
      case "lease":
        return <FileSignature className="w-8 h-8" />;
      case "compliance":
        return <ShieldCheck className="w-8 h-8" />;
      case "policy":
        return <FileText className="w-8 h-8" />;
      case "disclosure":
        return <FileWarning className="w-8 h-8" />;
      case "permit":
        return <FileText className="w-8 h-8" />;
      case "license":
        return <FileText className="w-8 h-8" />;
      default:
        return <FileText className="w-8 h-8" />;
    }
  };
  const getStatusColor = (status: string) => {
    switch (status) {
      case "draft":
        return "bg-gray-500/10 text-gray-500 border-gray-200";
      case "review":
        return "bg-brand/100/10 text-brand border-border";
      case "approved":
        return "bg-blue-500/10 text-blue-500 border-blue-200";
      case "signed":
        return "bg-success/10 text-success border-blue-200";
      case "expired":
        return "bg-red-500/10 text-red-500 border-red-200";
      case "terminated":
        return "bg-red-500/10 text-red-500 border-red-200";
      default:
        return "bg-gray-500/10 text-gray-500 border-gray-200";
    }
  };
  const getPriorityColor = (priority: string) => {
    switch (priority) {
      case "urgent":
        return "bg-red-500";
      case "high":
        return "bg-orange-500";
      case "medium":
        return "bg-yellow-500";
      case "low":
        return "bg-blue-500";
      default:
        return "bg-gray-500";
    }
  };
  const getComplianceScoreColor = (score: number, maxScore: number) => {
    const percentage = score / maxScore * 100;
    if (percentage >= 90) return "text-blue-500";
    if (percentage >= 70) return "text-yellow-500";
    return "text-red-500";
  };
  const filteredDocuments = documents.filter(doc => {
    const matchesType = filterType === "all" || doc.type === filterType;
    const matchesStatus = filterStatus === "all" || doc.status === filterStatus;
    const matchesSearch = doc.title.toLowerCase().includes(searchTerm.toLowerCase()) || doc.description.toLowerCase().includes(searchTerm.toLowerCase()) || doc.tags.some(tag => tag.toLowerCase().includes(searchTerm.toLowerCase()));
    return matchesType && matchesStatus && matchesSearch;
  });
  const upcomingExpirations = documents.filter(doc => doc.expiryDate && new Date(doc.expiryDate) <= addDays(new Date(), 30)).sort((a, b) => new Date(a.expiryDate!).getTime() - new Date(b.expiryDate!).getTime());
  const complianceIssues = documents.filter(doc => !doc.compliance.isCompliant);
  return <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold flex items-center gap-2">
            <Scale className="w-8 h-8" />{t("client.src.legal_compliance")}</h1>
          <p className="text-muted-foreground">{t("client.src.manage_legal_documents_contracts")}</p>
        </div>
        <div className="flex items-center gap-2">
          <Button variant="outline" onClick={() => toast({ title: t("client.src.templates_coming_soon") })}>
            <FileText className="w-4 h-4 mr-2" />{t("common.templates")}</Button>
          <Button onClick={() => setShowCreateDialog(true)}>
            <Plus className="w-4 h-4 mr-2" />{t("client.src.new_document")}</Button>
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
              <FileText className="w-8 h-8 text-brand" />
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="p-4">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-muted-foreground">{t("client.src.compliance_issues")}</p>
                <p className="text-2xl font-bold text-red-500">{complianceIssues.length}</p>
              </div>
              <AlertTriangle className="w-8 h-8 text-red-500" />
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="p-4">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-muted-foreground">{t("client.src.upcoming_expirations")}</p>
                <p className="text-2xl font-bold text-orange-500">{upcomingExpirations.length}</p>
              </div>
              <Clock className="w-8 h-8 text-orange-500" />
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="p-4">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-muted-foreground">{t("common.templates")}</p>
                <p className="text-2xl font-bold">{templates.length}</p>
              </div>
              <FileCheck className="w-8 h-8 text-brand" />
            </div>
          </CardContent>
        </Card>
      </div>

      <Tabs value={activeTab} onValueChange={setActiveTab}>
        <TabsList className="grid w-full grid-cols-4">
          <TabsTrigger value="documents">{t("common.documents")}</TabsTrigger>
          <TabsTrigger value="compliance">{t("client.src.compliance")}</TabsTrigger>
          <TabsTrigger value="templates">{t("common.templates")}</TabsTrigger>
          <TabsTrigger value="analytics">{t("common.analytics")}</TabsTrigger>
        </TabsList>

        {/* Documents Tab */}
        <TabsContent value="documents" className="space-y-6">
          {/* Filters */}
          <Card>
            <CardContent className="p-4">
              <div className="flex flex-wrap items-center gap-4">
                <div className="flex items-center gap-2">
                  <Search className="w-4 h-4" />
                  <Input placeholder={t("client.src.search_documents")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="w-64" />
                </div>
                <Select value={filterType} onValueChange={setFilterType}>
                  <SelectTrigger className="w-40">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">{t("common.all_types")}</SelectItem>
                    <SelectItem value="contract">{t("common.contracts")}</SelectItem>
                    <SelectItem value="agreement">{t("client.src.agreements")}</SelectItem>
                    <SelectItem value="lease">{t("client.src.leases")}</SelectItem>
                    <SelectItem value="compliance">{t("client.src.compliance")}</SelectItem>
                    <SelectItem value="policy">{t("client.src.policies")}</SelectItem>
                    <SelectItem value="disclosure">{t("client.src.disclosures")}</SelectItem>
                  </SelectContent>
                </Select>
                <Select value={filterStatus} onValueChange={setFilterStatus}>
                  <SelectTrigger className="w-32">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">{t("common.all_status")}</SelectItem>
                    <SelectItem value="draft">{t("common.draft")}</SelectItem>
                    <SelectItem value="review">{t("client.src.review")}</SelectItem>
                    <SelectItem value="approved">{t("common.approved")}</SelectItem>
                    <SelectItem value="signed">{t("common.signed")}</SelectItem>
                    <SelectItem value="expired">{t("common.expired")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </CardContent>
          </Card>

          {/* Documents List */}
          <Card>
            <CardHeader>
              <CardTitle>{t("client.src.legal_documents")}{filteredDocuments.length})</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filteredDocuments.map(doc => <m.div key={doc.id} initial={{
                opacity: 0,
                y: 10
              }} animate={{
                opacity: 1,
                y: 0
              }} className="border rounded-lg p-4 hover:shadow-md transition-shadow">
                    <div className="flex items-start justify-between">
                      <div className="flex items-start gap-4">
                        <div className={`p-3 rounded-lg ${getStatusColor(doc.status)}`}>
                          {getDocumentIcon(doc.type)}
                        </div>
                        <div className="flex-1">
                          <div className="flex items-center gap-2 mb-2">
                            <h3 className="font-medium">{doc.title}</h3>
                            <Badge className={getStatusColor(doc.status)}>
                              {doc.status}
                            </Badge>
                            <div className={`w-2 h-2 rounded-full ${getPriorityColor(doc.priority)}`} />
                            {doc.compliance.isCompliant ? <ShieldCheck className="w-4 h-4 text-blue-500" /> : <AlertTriangle className="w-4 h-4 text-red-500" />}
                          </div>
                          <p className="text-sm text-gray-600 mb-3">{doc.description}</p>
                          <div className="flex items-center gap-4 text-sm text-gray-500 mb-3">
                            <span>{t("common.type")}{doc.type}</span>
                            <span>{t("common.category")}{doc.category}</span>
                            {doc.effectiveDate && <span>{t("client.src.effective")}{format(new Date(doc.effectiveDate), "MMM d, yyyy")}</span>}
                            {doc.expiryDate && <span className="text-orange-500">{t("client.src.expires")}{format(new Date(doc.expiryDate), "MMM d, yyyy")}
                              </span>}
                          </div>
                          <div className="flex items-center gap-2 mb-3">
                            <span className="text-sm font-medium">{t("client.src.parties")}</span>
                            <div className="flex -space-x-2">
                              {doc.parties.slice(0, 3).map(party => <Avatar key={party.id} className="w-6 h-6 border-2 border-white">
                                  <AvatarFallback className="text-xs">
                                    {party.name.charAt(0)}
                                  </AvatarFallback>
                                </Avatar>)}
                              {doc.parties.length > 3 && <div className="w-6 h-6 rounded-full bg-gray-200 border-2 border-white flex items-center justify-center">
                                  <span className="text-xs">+{doc.parties.length - 3}</span>
                                </div>}
                            </div>
                            <span className="text-xs text-gray-500">
                              {doc.parties.filter(p => p.signed).length}{t("client.src.of")}{doc.parties.length}{t("common.signed")}</span>
                          </div>
                          <div className="flex flex-wrap gap-1">
                            {doc.tags.map(tag => <Badge key={tag} variant="secondary" className="text-xs">
                                {tag}
                              </Badge>)}
                          </div>
                        </div>
                      </div>
                      <div className="flex gap-2">
                        <Button size="sm" variant="outline" aria-label={t("common.view")}>
                          <Eye className="w-4 h-4" />
                        </Button>
                        <Button size="sm" variant="outline" aria-label={t("common.download")}>
                          <Download className="w-4 h-4" />
                        </Button>
                        <Button size="sm" variant="outline" aria-label={t("common.edit")}>
                          <Edit className="w-4 h-4" />
                        </Button>
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild>
                            <Button size="sm" variant="outline" aria-label={t("common.more")}>
                              <MoreHorizontal className="w-4 h-4" />
                            </Button>
                          </DropdownMenuTrigger>
                          <DropdownMenuContent>
                            <DropdownMenuItem>
                              <Share2 className="w-4 h-4 mr-2" />{t("common.share")}</DropdownMenuItem>
                            <DropdownMenuItem>
                              <FileCheck className="w-4 h-4 mr-2" />{t("client.src.check_compliance")}</DropdownMenuItem>
                            <DropdownMenuItem>
                              <Archive className="w-4 h-4 mr-2" />{t("client.src.archive")}</DropdownMenuItem>
                            <DropdownMenuSeparator />
                            <DropdownMenuItem>
                              <Trash2 className="w-4 h-4 mr-2" />{t("common.delete")}</DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </div>
                    </div>
                  </m.div>)}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        {/* Compliance Tab */}
        <TabsContent value="compliance" className="space-y-6">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            {/* Compliance Overview */}
            <Card>
              <CardHeader>
                <CardTitle>{t("client.src.compliance_overview")}</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {complianceChecks.map(check => {
                  const document = documents.find(doc => doc.id === check.documentId);
                  return <m.div key={check.id} initial={{
                    opacity: 0,
                    x: -10
                  }} animate={{
                    opacity: 1,
                    x: 0
                  }} className="border rounded-lg p-4">
                        <div className="flex items-start justify-between mb-3">
                          <div>
                            <h3 className="font-medium">{document?.title}</h3>
                            <p className="text-sm text-gray-500">{check.type}{t("client.src.check")}</p>
                          </div>
                          <Badge className={check.status === "passed" ? "bg-blue-500/10 text-blue-500" : check.status === "failed" ? "bg-red-500/10 text-red-500" : check.status === "requires_action" ? "bg-warning/10 text-orange-500" : "bg-brand/100/10 text-brand"}>
                            {check.status.replace("_", " ")}
                          </Badge>
                        </div>
                        <div className="mb-3">
                          <div className="flex items-center justify-between text-sm mb-1">
                            <span>{t("client.src.compliance_score")}</span>
                            <span className={`font-medium ${getComplianceScoreColor(check.score, check.maxScore)}`}>
                              {check.score}/{check.maxScore}
                            </span>
                          </div>
                          <div className="w-full bg-gray-200 rounded-full h-2">
                            <div className={`h-2 rounded-full ${check.score / check.maxScore >= 0.9 ? "bg-blue-500" : check.score / check.maxScore >= 0.7 ? "bg-yellow-500" : "bg-red-500"}`} style={{
                          width: `${check.score / check.maxScore * 100}%`
                        }} />
                          </div>
                        </div>
                        <div className="text-sm text-gray-500">
                          <p>{t("client.src.checked_by")}{check.checkedBy}{t("client.src.on")}{format(new Date(check.checkedAt), "MMM d, yyyy")}</p>
                          <p>{t("client.src.next_due")}{format(new Date(check.nextDue), "MMM d, yyyy")}</p>
                        </div>
                      </m.div>;
                })}
                </div>
              </CardContent>
            </Card>

            {/* Issues & Findings */}
            <Card>
              <CardHeader>
                <CardTitle>{t("client.src.issues_findings")}</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-3">
                  {complianceIssues.map(doc => <m.div key={doc.id} initial={{
                  opacity: 0,
                  x: -10
                }} animate={{
                  opacity: 1,
                  x: 0
                }} className="border rounded-lg p-4 border-red-200">
                      <div className="flex items-start gap-3">
                        <AlertTriangle className="w-5 h-5 text-red-500 mt-1" />
                        <div className="flex-1">
                          <h3 className="font-medium text-red-700">{doc.title}</h3>
                          <div className="mt-2 space-y-2">
                            {doc.compliance.issues.map((issue, idx) => <div key={idx} className="text-sm">
                                <div className="flex items-center gap-2 mb-1">
                                  <div className={`w-2 h-2 rounded-full ${issue.severity === "critical" ? "bg-red-500" : issue.severity === "high" ? "bg-orange-500" : issue.severity === "medium" ? "bg-yellow-500" : "bg-brand/100"}`} />
                                  <span className="font-medium">{issue.message}</span>
                                </div>
                                <p className="text-gray-600 ml-4">{issue.recommendation}</p>
                              </div>)}
                          </div>
                        </div>
                      </div>
                    </m.div>)}
                </div>
              </CardContent>
            </Card>
          </div>
        </TabsContent>

        {/* Templates Tab */}
        <TabsContent value="templates" className="space-y-6">
          <Card>
            <CardHeader>
              <CardTitle>{t("client.src.legal_templates")}{templates.length})</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                {templates.map(template => <m.div key={template.id} initial={{
                opacity: 0,
                scale: 0.9
              }} animate={{
                opacity: 1,
                scale: 1
              }} className="border rounded-lg p-4 hover:shadow-md transition-shadow cursor-pointer">
                    <div className="flex items-start justify-between mb-3">
                      <div className="p-2 rounded-lg bg-brand/100/10">
                        <FileText className="w-6 h-6 text-brand" />
                      </div>
                      <div className="flex items-center gap-1">
                        {template.isPublic ? <Unlock className="w-4 h-4 text-blue-500" /> : <Lock className="w-4 h-4 text-gray-400" />}
                        <Badge variant="secondary" className="text-xs">
                          {template.type}
                        </Badge>
                      </div>
                    </div>
                    <h3 className="font-medium mb-1">{template.name}</h3>
                    <p className="text-sm text-gray-600 mb-3">{template.description}</p>
                    <div className="flex items-center justify-between text-sm text-gray-500">
                      <span>{t("client.src.used")}{template.usageCount}{t("client.src.times")}</span>
                      <span>{template.variables.length}{t("client.src.variables")}</span>
                    </div>
                  </m.div>)}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        {/* Analytics Tab */}
        <TabsContent value="analytics" className="space-y-6">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <Card>
              <CardHeader>
                <CardTitle>{t("client.src.document_types_distribution")}</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-3">
                  {["contract", "lease", "agreement", "disclosure"].map(type => {
                  const count = documents.filter(doc => doc.type === type).length;
                  const percentage = count / documents.length * 100;
                  return <div key={type} className="flex items-center gap-3">
                        <span className="text-sm font-medium w-20">{type}</span>
                        <div className="flex-1 bg-gray-200 rounded-full h-2">
                          <div className="bg-brand/100 h-2 rounded-full" style={{
                        width: `${percentage}%`
                      }} />
                        </div>
                        <span className="text-sm text-gray-500 w-12">{count}</span>
                      </div>;
                })}
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <CardTitle>{t("client.src.upcoming_expirations")}</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-3">
                  {upcomingExpirations.slice(0, 5).map(doc => <div key={doc.id} className="flex items-center justify-between p-3 border rounded-lg">
                      <div>
                        <h4 className="font-medium text-sm">{doc.title}</h4>
                        <p className="text-xs text-gray-500">{t("client.src.expires")}{format(new Date(doc.expiryDate!), "MMM d, yyyy")}
                        </p>
                      </div>
                      <Badge variant="outline" className="text-orange-500">
                        {Math.ceil((new Date(doc.expiryDate!).getTime() - new Date().getTime()) / (1000 * 60 * 60 * 24))}{t("client.src.days")}</Badge>
                    </div>)}
                </div>
              </CardContent>
            </Card>
          </div>
        </TabsContent>
      </Tabs>

      {/* Create Document Dialog */}
      <Dialog open={showCreateDialog} onOpenChange={setShowCreateDialog}>
        <DialogContent className="max-w-2xl">
          <DialogHeader>
            <DialogTitle>{t("client.src.create_new_legal_document")}</DialogTitle>
            <DialogDescription>{t("client.src.create_a_new_legal")}</DialogDescription>
          </DialogHeader>
          <div className="grid gap-4 py-4">
            <div className="grid grid-cols-2 gap-4">
              <div>
                <Label className="text-sm font-medium mb-2 block">{t("client.src.document_type")}</Label>
                <Select value={newDocType} onValueChange={setNewDocType}>
                  <SelectTrigger>
                    <SelectValue placeholder={t("common.select_type")} />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="contract">{t("client.src.contract")}</SelectItem>
                    <SelectItem value="agreement">{t("client.src.agreement")}</SelectItem>
                    <SelectItem value="lease">{t("client.src.lease")}</SelectItem>
                    <SelectItem value="compliance">{t("client.src.compliance")}</SelectItem>
                    <SelectItem value="policy">{t("client.src.policy")}</SelectItem>
                    <SelectItem value="disclosure">{t("client.src.disclosure")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div>
                <Label className="text-sm font-medium mb-2 block">{t("common.category")}</Label>
                <Select value={newDocCategory} onValueChange={setNewDocCategory}>
                  <SelectTrigger>
                    <SelectValue placeholder={t("client.src.select_category")} />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="rental">{t("client.src.rental")}</SelectItem>
                    <SelectItem value="management">{t("client.src.management")}</SelectItem>
                    <SelectItem value="purchase">{t("client.src.purchase")}</SelectItem>
                    <SelectItem value="disclosure">{t("client.src.disclosure")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
            <div>
              <Label className="text-sm font-medium mb-2 block">{t("client.src.document_title")}</Label>
              <Input placeholder={t("client.src.enter_document_title")} value={newDocTitle} onChange={e => setNewDocTitle(e.target.value)} />
            </div>
            <div>
              <Label className="text-sm font-medium mb-2 block">{t("common.description")}</Label>
              <Textarea placeholder={t("client.src.enter_document_description")} rows={3} value={newDocDescription} onChange={e => setNewDocDescription(e.target.value)} />
            </div>
            <div>
              <Label className="text-sm font-medium mb-2 block">{t("client.src.use_template")}</Label>
              <Select value={newDocTemplate} onValueChange={setNewDocTemplate}>
                <SelectTrigger>
                  <SelectValue placeholder={t("client.src.select_template_optional")} />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="">{t("client.src.select_template_optional")}</SelectItem>
                  {templates.map(template => <SelectItem key={template.id} value={template.id}>
                      {template.name}
                    </SelectItem>)}
                </SelectContent>
              </Select>
            </div>
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setShowCreateDialog(false)}>{t("common.cancel")}</Button>
            <Button onClick={handleCreateDocument} disabled={isCreatingDoc || !newDocTitle.trim()}>{t("client.src.create_document")}</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>;
}