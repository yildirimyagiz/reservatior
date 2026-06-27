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
import { motion } from "framer-motion";
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
  const [documents, setDocuments] = useState<LegalDocument[]>([]);
  const [complianceChecks, setComplianceChecks] = useState<ComplianceCheck[]>([]);
  const [templates, setTemplates] = useState<LegalTemplate[]>([]);
  const [searchTerm, setSearchTerm] = useState("");
  const [filterType, setFilterType] = useState<string>("all");
  const [filterStatus, setFilterStatus] = useState<string>("all");
  const [activeTab, setActiveTab] = useState("documents");
  const [showCreateDialog, setShowCreateDialog] = useState(false);

  // Mock data - replace with actual API calls
  useEffect(() => {
    const mockDocuments: LegalDocument[] = [{
      id: "doc1",
      title: t("client.src.residential_rental_agreement_property"),
      type: "lease",
      category: "Rental",
      description: t("client.src.standard_residential_rental_agreement"),
      status: "signed",
      priority: "medium",
      parties: [{
        id: "client1",
        name: "John Doe",
        type: "tenant",
        role: "Tenant",
        signed: true,
        signedAt: "2024-01-15T10:00:00Z"
      }, {
        id: "landlord1",
        name: "Jane Smith",
        type: "landlord",
        role: "Landlord",
        signed: true,
        signedAt: "2024-01-15T10:30:00Z"
      }, {
        id: "agent1",
        name: user?.name || "Agent",
        type: "agent",
        role: "Real Estate Agent",
        signed: false
      }],
      propertyId: "prop123",
      clientId: "client1",
      effectiveDate: "2024-01-15",
      expiryDate: "2025-01-15",
      renewalDate: "2024-12-15",
      terms: [{
        id: "term1",
        title: t("client.src.rent_amount"),
        content: "Monthly rent of $2,500 due on the 1st of each month",
        required: true
      }, {
        id: "term2",
        title: t("client.src.security_deposit"),
        content: "Security deposit of $2,500 required",
        required: true
      }],
      attachments: [{
        id: "att1",
        name: "rental_agreement_signed.pdf",
        type: "application/pdf",
        size: 1048576,
        url: "/documents/rental_agreement_signed.pdf"
      }],
      compliance: {
        isCompliant: true,
        lastChecked: "2024-01-20T00:00:00Z",
        issues: []
      },
      createdBy: user?.id || "",
      createdAt: "2024-01-10T10:00:00Z",
      updatedAt: "2024-01-15T10:30:00Z",
      version: 2,
      isArchived: false,
      tags: ["rental", "apartment", "downtown"]
    }, {
      id: "doc2",
      title: t("client.src.property_management_agreement"),
      type: "contract",
      category: "Management",
      description: t("client.src.comprehensive_property_management_services"),
      status: "approved",
      priority: "high",
      parties: [{
        id: "owner1",
        name: "Property Owner LLC",
        type: "company",
        role: "Property Owner",
        signed: true,
        signedAt: "2024-01-01T00:00:00Z"
      }, {
        id: "agent1",
        name: user?.name || "Agent",
        type: "agent",
        role: "Property Manager",
        signed: true,
        signedAt: "2024-01-02T09:00:00Z"
      }],
      effectiveDate: "2024-01-01",
      expiryDate: "2026-01-01",
      terms: [{
        id: "term1",
        title: t("client.src.management_fee"),
        content: "8% of monthly rent collected",
        required: true
      }],
      attachments: [],
      compliance: {
        isCompliant: true,
        lastChecked: "2024-01-15T00:00:00Z",
        issues: []
      },
      createdBy: user?.id || "",
      createdAt: "2023-12-15T10:00:00Z",
      updatedAt: "2024-01-02T09:00:00Z",
      version: 1,
      isArchived: false,
      tags: ["management", "commercial", "long-term"]
    }, {
      id: "doc3",
      title: t("client.src.disclosure_statement_property_456"),
      type: "disclosure",
      category: "Disclosure",
      description: t("client.src.property_condition_and_history"),
      status: "draft",
      priority: "urgent",
      parties: [{
        id: "client2",
        name: "Sarah Johnson",
        type: "client",
        role: "Potential Buyer",
        signed: false
      }],
      propertyId: "prop456",
      clientId: "client2",
      effectiveDate: "",
      terms: [{
        id: "term1",
        title: t("client.src.property_condition"),
        content: "Full disclosure of property condition",
        required: true
      }],
      attachments: [],
      compliance: {
        isCompliant: false,
        lastChecked: "2024-01-25T00:00:00Z",
        issues: [{
          type: "error",
          message: t("client.src.missing_leadbased_paint_disclosure"),
          resolved: false
        }, {
          type: "warning",
          message: t("client.src.property_age_disclosure_incomplete"),
          resolved: false
        }]
      },
      createdBy: user?.id || "",
      createdAt: "2024-01-20T14:00:00Z",
      updatedAt: "2024-01-25T10:00:00Z",
      version: 1,
      isArchived: false,
      tags: ["disclosure", "buyer", "urgent"]
    }];
    const mockComplianceChecks: ComplianceCheck[] = [{
      id: "check1",
      documentId: "doc1",
      type: "regulatory",
      status: "passed",
      score: 95,
      maxScore: 100,
      checkedBy: user?.name || "Agent",
      checkedAt: "2024-01-20T00:00:00Z",
      findings: [{
        category: "Documentation",
        severity: "low",
        description: t("client.src.minor_formatting_issues"),
        recommendation: "Update document formatting",
        resolved: true
      }],
      nextDue: "2024-04-20T00:00:00Z"
    }, {
      id: "check2",
      documentId: "doc3",
      type: "legal",
      status: "requires_action",
      score: 70,
      maxScore: 100,
      checkedBy: user?.name || "Agent",
      checkedAt: "2024-01-25T00:00:00Z",
      findings: [{
        category: "Compliance",
        severity: "high",
        description: t("client.src.missing_required_disclosures"),
        recommendation: "Add lead-based paint and property age disclosures",
        resolved: false
      }],
      nextDue: "2024-01-30T00:00:00Z"
    }];
    const mockTemplates: LegalTemplate[] = [{
      id: "template1",
      name: "Standard Residential Lease",
      description: t("client.src.comprehensive_residential_lease_agreement"),
      type: "lease",
      category: "Rental",
      content: "Standard lease agreement content...",
      variables: [{
        key: "tenant_name",
        label: t("client.src.tenant_name"),
        type: "text",
        required: true
      }, {
        key: "rent_amount",
        label: t("client.src.monthly_rent"),
        type: "number",
        required: true
      }, {
        key: "lease_term",
        label: t("client.src.lease_term"),
        type: "select",
        required: true,
        options: ["6 months", "1 year", "2 years"]
      }],
      isPublic: true,
      usageCount: 45,
      createdBy: user?.id || "",
      createdAt: "2023-12-01T00:00:00Z",
      updatedAt: "2024-01-15T00:00:00Z"
    }, {
      id: "template2",
      name: "Property Management Agreement",
      description: t("client.src.property_management_services_contract"),
      type: "contract",
      category: "Management",
      content: "Management agreement content...",
      variables: [{
        key: "property_address",
        label: t("client.src.property_address"),
        type: "text",
        required: true
      }, {
        key: "management_fee",
        label: t("client.src.management_fee"),
        type: "number",
        required: true
      }],
      isPublic: false,
      usageCount: 12,
      createdBy: user?.id || "",
      createdAt: "2023-11-15T00:00:00Z",
      updatedAt: "2024-01-10T00:00:00Z"
    }];
    setDocuments(mockDocuments);
    setComplianceChecks(mockComplianceChecks);
    setTemplates(mockTemplates);
  }, [user]);
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
        return "bg-blue-500/10 text-blue-500 border-blue-200";
      case "approved":
        return "bg-green-500/10 text-green-500 border-green-200";
      case "signed":
        return "bg-emerald-500/10 text-emerald-500 border-emerald-200";
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
        return "bg-green-500";
      default:
        return "bg-gray-500";
    }
  };
  const getComplianceScoreColor = (score: number, maxScore: number) => {
    const percentage = score / maxScore * 100;
    if (percentage >= 90) return "text-green-500";
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
          <Button variant="outline" onClick={() => {}}>
            <FileText className="w-4 h-4 mr-2" />{t("client.src.templates")}</Button>
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
              <FileText className="w-8 h-8 text-blue-500" />
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
                <p className="text-sm text-muted-foreground">{t("client.src.templates")}</p>
                <p className="text-2xl font-bold">{templates.length}</p>
              </div>
              <FileCheck className="w-8 h-8 text-purple-500" />
            </div>
          </CardContent>
        </Card>
      </div>

      <Tabs value={activeTab} onValueChange={setActiveTab}>
        <TabsList className="grid w-full grid-cols-4">
          <TabsTrigger value="documents">{t("client.src.documents")}</TabsTrigger>
          <TabsTrigger value="compliance">{t("client.src.compliance")}</TabsTrigger>
          <TabsTrigger value="templates">{t("client.src.templates")}</TabsTrigger>
          <TabsTrigger value="analytics">{t("client.src.analytics")}</TabsTrigger>
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
                    <SelectItem value="all">{t("client.src.all_types")}</SelectItem>
                    <SelectItem value="contract">{t("client.src.contracts")}</SelectItem>
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
                    <SelectItem value="all">{t("client.src.all_status")}</SelectItem>
                    <SelectItem value="draft">{t("client.src.draft")}</SelectItem>
                    <SelectItem value="review">{t("client.src.review")}</SelectItem>
                    <SelectItem value="approved">{t("client.src.approved")}</SelectItem>
                    <SelectItem value="signed">{t("client.src.signed")}</SelectItem>
                    <SelectItem value="expired">{t("client.src.expired")}</SelectItem>
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
                {filteredDocuments.map(doc => <motion.div key={doc.id} initial={{
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
                            {doc.compliance.isCompliant ? <ShieldCheck className="w-4 h-4 text-green-500" /> : <AlertTriangle className="w-4 h-4 text-red-500" />}
                          </div>
                          <p className="text-sm text-gray-600 mb-3">{doc.description}</p>
                          <div className="flex items-center gap-4 text-sm text-gray-500 mb-3">
                            <span>{t("client.src.type")}{doc.type}</span>
                            <span>{t("client.src.category")}{doc.category}</span>
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
                              {doc.parties.filter(p => p.signed).length}{t("client.src.of")}{doc.parties.length}{t("client.src.signed")}</span>
                          </div>
                          <div className="flex flex-wrap gap-1">
                            {doc.tags.map(tag => <Badge key={tag} variant="secondary" className="text-xs">
                                {tag}
                              </Badge>)}
                          </div>
                        </div>
                      </div>
                      <div className="flex gap-2">
                        <Button size="sm" variant="outline">
                          <Eye className="w-4 h-4" />
                        </Button>
                        <Button size="sm" variant="outline">
                          <Download className="w-4 h-4" />
                        </Button>
                        <Button size="sm" variant="outline">
                          <Edit className="w-4 h-4" />
                        </Button>
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild>
                            <Button size="sm" variant="outline">
                              <MoreHorizontal className="w-4 h-4" />
                            </Button>
                          </DropdownMenuTrigger>
                          <DropdownMenuContent>
                            <DropdownMenuItem>
                              <Share2 className="w-4 h-4 mr-2" />{t("client.src.share")}</DropdownMenuItem>
                            <DropdownMenuItem>
                              <FileCheck className="w-4 h-4 mr-2" />{t("client.src.check_compliance")}</DropdownMenuItem>
                            <DropdownMenuItem>
                              <Archive className="w-4 h-4 mr-2" />{t("client.src.archive")}</DropdownMenuItem>
                            <DropdownMenuSeparator />
                            <DropdownMenuItem>
                              <Trash2 className="w-4 h-4 mr-2" />{t("client.src.delete")}</DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </div>
                    </div>
                  </motion.div>)}
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
                  return <motion.div key={check.id} initial={{
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
                          <Badge className={check.status === "passed" ? "bg-green-500/10 text-green-500" : check.status === "failed" ? "bg-red-500/10 text-red-500" : check.status === "requires_action" ? "bg-orange-500/10 text-orange-500" : "bg-blue-500/10 text-blue-500"}>
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
                            <div className={`h-2 rounded-full ${check.score / check.maxScore >= 0.9 ? "bg-green-500" : check.score / check.maxScore >= 0.7 ? "bg-yellow-500" : "bg-red-500"}`} style={{
                          width: `${check.score / check.maxScore * 100}%`
                        }} />
                          </div>
                        </div>
                        <div className="text-sm text-gray-500">
                          <p>{t("client.src.checked_by")}{check.checkedBy}{t("client.src.on")}{format(new Date(check.checkedAt), "MMM d, yyyy")}</p>
                          <p>{t("client.src.next_due")}{format(new Date(check.nextDue), "MMM d, yyyy")}</p>
                        </div>
                      </motion.div>;
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
                  {complianceIssues.map(doc => <motion.div key={doc.id} initial={{
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
                                  <div className={`w-2 h-2 rounded-full ${issue.severity === "critical" ? "bg-red-500" : issue.severity === "high" ? "bg-orange-500" : issue.severity === "medium" ? "bg-yellow-500" : "bg-blue-500"}`} />
                                  <span className="font-medium">{issue.message}</span>
                                </div>
                                <p className="text-gray-600 ml-4">{issue.recommendation}</p>
                              </div>)}
                          </div>
                        </div>
                      </div>
                    </motion.div>)}
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
                {templates.map(template => <motion.div key={template.id} initial={{
                opacity: 0,
                scale: 0.9
              }} animate={{
                opacity: 1,
                scale: 1
              }} className="border rounded-lg p-4 hover:shadow-md transition-shadow cursor-pointer">
                    <div className="flex items-start justify-between mb-3">
                      <div className="p-2 rounded-lg bg-blue-500/10">
                        <FileText className="w-6 h-6 text-blue-500" />
                      </div>
                      <div className="flex items-center gap-1">
                        {template.isPublic ? <Unlock className="w-4 h-4 text-green-500" /> : <Lock className="w-4 h-4 text-gray-400" />}
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
                  </motion.div>)}
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
                          <div className="bg-blue-500 h-2 rounded-full" style={{
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
                <Select>
                  <SelectTrigger>
                    <SelectValue placeholder={t("client.src.select_type")} />
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
                <Label className="text-sm font-medium mb-2 block">{t("client.src.category")}</Label>
                <Select>
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
              <Input placeholder={t("client.src.enter_document_title")} />
            </div>
            <div>
              <Label className="text-sm font-medium mb-2 block">{t("client.src.description")}</Label>
              <Textarea placeholder={t("client.src.enter_document_description")} rows={3} />
            </div>
            <div>
              <Label className="text-sm font-medium mb-2 block">{t("client.src.use_template")}</Label>
              <Select>
                <SelectTrigger>
                  <SelectValue placeholder={t("client.src.select_template_optional")} />
                </SelectTrigger>
                <SelectContent>
                  {templates.map(template => <SelectItem key={template.id} value={template.id}>
                      {template.name}
                    </SelectItem>)}
                </SelectContent>
              </Select>
            </div>
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setShowCreateDialog(false)}>{t("client.src.cancel")}</Button>
            <Button onClick={() => setShowCreateDialog(false)}>{t("client.src.create_document")}</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>;
}