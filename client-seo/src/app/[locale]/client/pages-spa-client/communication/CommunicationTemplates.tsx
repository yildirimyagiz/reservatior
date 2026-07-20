"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { format } from "date-fns";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuSeparator, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useAuth } from "@/lib/auth/hooks";
import { motion } from "framer-motion";
import { Clock, Copy, Download, Edit, Eye, FileCheck, FilePlus, FileSignature, FileSpreadsheet, FileText, Folder, Grid3X3, List, Mail, MoreHorizontal, Plus, Search, Share2, Star, Trash2, TrendingUp, Unlock, LockKeyhole } from "lucide-react";
interface Template {
  id: string;
  name: string;
  description: string;
  type: "document" | "email" | "contract" | "report" | "form" | "proposal" | "invoice" | "letter" | "presentation" | "spreadsheet";
  category: string;
  content: string;
  variables: Array<{
    key: string;
    label: string;
    type: "text" | "date" | "number" | "select" | "textarea" | "checkbox" | "email" | "phone";
    required: boolean;
    defaultValue?: string;
    options?: string[];
    validation?: {
      pattern?: string;
      minLength?: number;
      maxLength?: number;
      min?: number;
      max?: number;
    };
  }>;
  styling: {
    fontFamily?: string;
    fontSize?: string;
    color?: string;
    backgroundColor?: string;
    headerStyle?: string;
    bodyStyle?: string;
    footerStyle?: string;
  };
  metadata: {
    version: number;
    language: string;
    pageSize?: string;
    orientation?: "portrait" | "landscape";
    margins?: {
      top: number;
      right: number;
      bottom: number;
      left: number;
    };
  };
  permissions: {
    isPublic: boolean;
    isEditable: boolean;
    canShare: boolean;
    canDownload: boolean;
    allowedRoles: string[];
  };
  usage: {
    totalUses: number;
    lastUsed?: string;
    averageRating: number;
    ratingCount: number;
    downloads: number;
    shares: number;
  };
  folder: {
    id: string;
    name: string;
    path: string;
  };
  tags: string[];
  status: "active" | "draft" | "archived" | "deprecated";
  createdBy: string;
  createdAt: string;
  updatedAt: string;
  isFavorite: boolean;
  preview: {
    thumbnail?: string;
    url?: string;
  };
}
interface TemplateFolder {
  id: string;
  name: string;
  description: string;
  parentId: string | null;
  path: string;
  templateCount: number;
  isPublic: boolean;
  createdBy: string;
  createdAt: string;
  updatedAt: string;
  permissions: {
    canView: boolean;
    canEdit: boolean;
    canDelete: boolean;
  };
}
interface TemplateUsage {
  id: string;
  templateId: string;
  templateName: string;
  usedBy: string;
  usedByName: string;
  usedAt: string;
  variables: Record<string, any>;
  generatedDocument: {
    id: string;
    name: string;
    url: string;
    size: number;
  };
  context?: {
    propertyId?: string;
    clientId?: string;
    projectId?: string;
  };
}
export default function Templates() {
  const {
    t
  } = useTranslation();
  const {
    user
  } = useAuth();
  const [templates, setTemplates] = useState<Template[]>([]);
  const [folders, setFolders] = useState<TemplateFolder[]>([]);
  const [usage, setUsage] = useState<TemplateUsage[]>([]);
  const [selectedTemplate, setSelectedTemplate] = useState<Template | null>(null);
  const [selectedFolder, setSelectedFolder] = useState<string | null>(null);
  const [searchTerm, setSearchTerm] = useState("");
  const [filterType, setFilterType] = useState<string>("all");
  const [filterCategory, setFilterCategory] = useState<string>("all");
  const [filterStatus, _setFilterStatus] = useState<string>("all");
  const [viewMode, setViewMode] = useState<"grid" | "list">("grid");
  const [sortBy, setSortBy] = useState<"name" | "date" | "usage" | "rating">("date");
  const [sortOrder, _setSortOrder] = useState<"asc" | "desc">("desc");
  const [_showCreateDialog, setShowCreateDialog] = useState(false);
  const [_showFolderDialog, setShowFolderDialog] = useState(false);
  const [showUseDialog, setShowUseDialog] = useState(false);
  const [activeTab, setActiveTab] = useState("templates");

  // Mock data - replace with actual API calls
  useEffect(() => {
    const mockTemplates: Template[] = [{
      id: "template1",
      name: "Rental Agreement Template",
      description: t("client.src.comprehensive_residential_rental_agreement"),
      type: "contract",
      category: "Legal",
      content: `<div class="rental-agreement">
          <h1>Residential Rental Agreement</h1>
          <div class="parties">
            <h2>Parties</h2>
            <p>Landlord: {{landlord_name}}</p>
            <p>Tenant: {{tenant_name}}</p>
          </div>
          <div class="property">
            <h2>Property Details</h2>
            <p>Address: {{property_address}}</p>
            <p>Rent: {{rent_amount}}</p>
          </div>
        </div>`,
      variables: [{
        key: "landlord_name",
        label: t("client.src.landlord_name"),
        type: "text",
        required: true
      }, {
        key: "tenant_name",
        label: t("client.src.tenant_name"),
        type: "text",
        required: true
      }, {
        key: "property_address",
        label: t("client.src.property_address"),
        type: "textarea",
        required: true
      }, {
        key: "rent_amount",
        label: t("client.src.monthly_rent"),
        type: "number",
        required: true,
        validation: {
          min: 0
        }
      }, {
        key: "lease_term",
        label: t("client.src.lease_term"),
        type: "select",
        required: true,
        options: ["6 months", "1 year", "2 years"]
      }],
      styling: {
        fontFamily: "Arial, sans-serif",
        fontSize: "12pt",
        color: "#000000",
        backgroundColor: "#ffffff"
      },
      metadata: {
        version: 2,
        language: "en",
        pageSize: "A4",
        orientation: "portrait",
        margins: {
          top: 20,
          right: 20,
          bottom: 20,
          left: 20
        }
      },
      permissions: {
        isPublic: true,
        isEditable: true,
        canShare: true,
        canDownload: true,
        allowedRoles: ["agent", "admin"]
      },
      usage: {
        totalUses: 156,
        lastUsed: format(new Date(Date.now() - 1000 * 60 * 60 * 24), "yyyy-MM-dd'T'HH:mm:ss"),
        averageRating: 4.5,
        ratingCount: 23,
        downloads: 89,
        shares: 12
      },
      folder: {
        id: "folder1",
        name: "Legal Templates",
        path: "/Legal Templates"
      },
      tags: ["rental", "agreement", "legal", "residential"],
      status: "active",
      createdBy: user?.id || "",
      createdAt: format(new Date(Date.now() - 1000 * 60 * 60 * 24 * 30), "yyyy-MM-dd'T'HH:mm:ss"),
      updatedAt: format(new Date(Date.now() - 1000 * 60 * 60 * 24 * 7), "yyyy-MM-dd'T'HH:mm:ss"),
      isFavorite: true,
      preview: {
        thumbnail: "/thumbnails/rental-agreement.jpg"
      }
    }, {
      id: "template2",
      name: "Property Viewing Confirmation",
      description: t("client.src.email_template_for_confirming"),
      type: "email",
      category: "Communication",
      content: `<div class="email-confirmation">
          <h2>Property Viewing Confirmation</h2>
          <p>Dear {{client_name}},</p>
          <p>This email confirms your property viewing appointment:</p>
          <div class="appointment-details">
            <p>Property: {{property_address}}</p>
            <p>Date: {{viewing_date}}</p>
            <p>Time: {{viewing_time}}</p>
          </div>
          <p>Please let us know if you need to reschedule.</p>
          <p>Best regards,<br>{{agent_name}}</p>
        </div>`,
      variables: [{
        key: "client_name",
        label: t("client.src.client_name"),
        type: "text",
        required: true
      }, {
        key: "property_address",
        label: t("client.src.property_address"),
        type: "textarea",
        required: true
      }, {
        key: "viewing_date",
        label: t("client.src.viewing_date"),
        type: "date",
        required: true
      }, {
        key: "viewing_time",
        label: t("client.src.viewing_time"),
        type: "text",
        required: true
      }, {
        key: "agent_name",
        label: t("client.src.agent_name"),
        type: "text",
        required: true
      }],
      styling: {
        fontFamily: "Helvetica, Arial, sans-serif",
        fontSize: "14px",
        color: "#333333"
      },
      metadata: {
        version: 1,
        language: "en"
      },
      permissions: {
        isPublic: false,
        isEditable: true,
        canShare: true,
        canDownload: true,
        allowedRoles: ["agent", "admin"]
      },
      usage: {
        totalUses: 89,
        lastUsed: format(new Date(Date.now() - 1000 * 60 * 60 * 48), "yyyy-MM-dd'T'HH:mm:ss"),
        averageRating: 4.2,
        ratingCount: 15,
        downloads: 45,
        shares: 8
      },
      folder: {
        id: "folder2",
        name: "Email Templates",
        path: "/Email Templates"
      },
      tags: ["email", "viewing", "confirmation", "appointment"],
      status: "active",
      createdBy: user?.id || "",
      createdAt: format(new Date(Date.now() - 1000 * 60 * 60 * 24 * 14), "yyyy-MM-dd'T'HH:mm:ss"),
      updatedAt: format(new Date(Date.now() - 1000 * 60 * 60 * 24 * 3), "yyyy-MM-dd'T'HH:mm:ss"),
      isFavorite: false,
      preview: {
        thumbnail: "/thumbnails/email-confirmation.jpg"
      }
    }, {
      id: "template3",
      name: "Property Inspection Report",
      description: t("client.src.comprehensive_property_inspection_report"),
      type: "report",
      category: "Inspection",
      content: `<div class="inspection-report">
          <h1>Property Inspection Report</h1>
          <div class="property-info">
            <h2>Property Information</h2>
            <p>Address: {{property_address}}</p>
            <p>Inspection Date: {{inspection_date}}</p>
            <p>Inspector: {{inspector_name}}</p>
          </div>
          <div class="findings">
            <h2>Inspection Findings</h2>
            <div class="section">
              <h3>Structural</h3>
              <p>{{structural_findings}}</p>
            </div>
            <div class="section">
              <h3>Electrical</h3>
              <p>{{electrical_findings}}</p>
            </div>
          </div>
        </div>`,
      variables: [{
        key: "property_address",
        label: t("client.src.property_address"),
        type: "textarea",
        required: true
      }, {
        key: "inspection_date",
        label: t("client.src.inspection_date"),
        type: "date",
        required: true
      }, {
        key: "inspector_name",
        label: t("client.src.inspector_name"),
        type: "text",
        required: true
      }, {
        key: "structural_findings",
        label: t("client.src.structural_findings"),
        type: "textarea",
        required: true
      }, {
        key: "electrical_findings",
        label: t("client.src.electrical_findings"),
        type: "textarea",
        required: true
      }],
      styling: {
        fontFamily: "Times New Roman, serif",
        fontSize: "12pt",
        color: "#000000"
      },
      metadata: {
        version: 1,
        language: "en",
        pageSize: "A4",
        orientation: "portrait"
      },
      permissions: {
        isPublic: true,
        isEditable: false,
        canShare: true,
        canDownload: true,
        allowedRoles: ["agent", "inspector", "admin"]
      },
      usage: {
        totalUses: 67,
        lastUsed: format(new Date(Date.now() - 1000 * 60 * 60 * 24 * 10), "yyyy-MM-dd'T'HH:mm:ss"),
        averageRating: 4.8,
        ratingCount: 12,
        downloads: 34,
        shares: 5
      },
      folder: {
        id: "folder3",
        name: "Inspection Templates",
        path: "/Inspection Templates"
      },
      tags: ["inspection", "report", "property", "structural"],
      status: "active",
      createdBy: user?.id || "",
      createdAt: format(new Date(Date.now() - 1000 * 60 * 60 * 24 * 21), "yyyy-MM-dd'T'HH:mm:ss"),
      updatedAt: format(new Date(Date.now() - 1000 * 60 * 60 * 24 * 5), "yyyy-MM-dd'T'HH:mm:ss"),
      isFavorite: true,
      preview: {
        thumbnail: "/thumbnails/inspection-report.jpg"
      }
    }];
    const mockFolders: TemplateFolder[] = [{
      id: "folder1",
      name: "Legal Templates",
      description: t("client.src.all_legal_document_templates"),
      parentId: null,
      path: "/Legal Templates",
      templateCount: 12,
      isPublic: true,
      createdBy: user?.id || "",
      createdAt: format(new Date(Date.now() - 1000 * 60 * 60 * 24 * 60), "yyyy-MM-dd'T'HH:mm:ss"),
      updatedAt: format(new Date(Date.now() - 1000 * 60 * 60 * 24 * 7), "yyyy-MM-dd'T'HH:mm:ss"),
      permissions: {
        canView: true,
        canEdit: true,
        canDelete: true
      }
    }, {
      id: "folder2",
      name: "Email Templates",
      description: t("client.src.email_communication_templates"),
      parentId: null,
      path: "/Email Templates",
      templateCount: 8,
      isPublic: false,
      createdBy: user?.id || "",
      createdAt: format(new Date(Date.now() - 1000 * 60 * 60 * 24 * 45), "yyyy-MM-dd'T'HH:mm:ss"),
      updatedAt: format(new Date(Date.now() - 1000 * 60 * 60 * 24 * 3), "yyyy-MM-dd'T'HH:mm:ss"),
      permissions: {
        canView: true,
        canEdit: true,
        canDelete: true
      }
    }, {
      id: "folder3",
      name: "Inspection Templates",
      description: t("client.src.property_inspection_report_templates"),
      parentId: null,
      path: "/Inspection Templates",
      templateCount: 5,
      isPublic: true,
      createdBy: user?.id || "",
      createdAt: format(new Date(Date.now() - 1000 * 60 * 60 * 24 * 30), "yyyy-MM-dd'T'HH:mm:ss"),
      updatedAt: format(new Date(Date.now() - 1000 * 60 * 60 * 24 * 14), "yyyy-MM-dd'T'HH:mm:ss"),
      permissions: {
        canView: true,
        canEdit: true,
        canDelete: true
      }
    }];
    const mockUsage: TemplateUsage[] = [{
      id: "usage1",
      templateId: "template1",
      templateName: "Rental Agreement Template",
      usedBy: user?.id || "",
      usedByName: user?.name || "You",
      usedAt: format(new Date(Date.now() - 1000 * 60 * 60 * 24), "yyyy-MM-dd'T'HH:mm:ss"),
      variables: {
        landlord_name: "Jane Smith",
        tenant_name: "John Doe",
        property_address: "123 Main St, Istanbul",
        rent_amount: 2500,
        lease_term: "1 year"
      },
      generatedDocument: {
        id: "doc1",
        name: "rental-agreement-john-doe.pdf",
        url: "/documents/rental-agreement-john-doe.pdf",
        size: 1048576
      },
      context: {
        propertyId: "prop123",
        clientId: "client1"
      }
    }, {
      id: "usage2",
      templateId: "template2",
      templateName: "Property Viewing Confirmation",
      usedBy: user?.id || "",
      usedByName: user?.name || "You",
      usedAt: format(new Date(Date.now() - 1000 * 60 * 60 * 48), "yyyy-MM-dd'T'HH:mm:ss"),
      variables: {
        client_name: "Sarah Johnson",
        property_address: "456 Business Ave, Istanbul",
        viewing_date: format(new Date(Date.now() + 1000 * 60 * 60 * 24), "yyyy-MM-dd"),
        viewing_time: "2:00 PM",
        agent_name: user?.name || "Agent"
      },
      generatedDocument: {
        id: "doc2",
        name: "viewing-confirmation-sarah.pdf",
        url: "/documents/viewing-confirmation-sarah.pdf",
        size: 524288
      },
      context: {
        propertyId: "prop456",
        clientId: "client2"
      }
    }];
    setTemplates(mockTemplates);
    setFolders(mockFolders);
    setUsage(mockUsage);
  }, [user]);
  const getTemplateIcon = (type: string) => {
    switch (type) {
      case "document":
        return <FileText className="w-8 h-8" />;
      case "email":
        return <Mail className="w-8 h-8" />;
      case "contract":
        return <FileSignature className="w-8 h-8" />;
      case "report":
        return <FileCheck className="w-8 h-8" />;
      case "form":
        return <FileText className="w-8 h-8" />;
      case "proposal":
        return <FileText className="w-8 h-8" />;
      case "invoice":
        return <FileText className="w-8 h-8" />;
      case "letter":
        return <FileText className="w-8 h-8" />;
      case "presentation":
        return <FileText className="w-8 h-8" />;
      case "spreadsheet":
        return <FileSpreadsheet className="w-8 h-8" />;
      default:
        return <FileText className="w-8 h-8" />;
    }
  };
  const getStatusColor = (status: string) => {
    switch (status) {
      case "active":
        return "bg-green-500/10 text-green-500 border-green-200";
      case "draft":
        return "bg-gray-500/10 text-gray-500 border-gray-200";
      case "archived":
        return "bg-orange-500/10 text-orange-500 border-orange-200";
      case "deprecated":
        return "bg-red-500/10 text-red-500 border-red-200";
      default:
        return "bg-gray-500/10 text-gray-500 border-gray-200";
    }
  };
  const getCategoryColor = (category: string) => {
    switch (category) {
      case "Legal":
        return "bg-purple-500/10 text-purple-500";
      case "Communication":
        return "bg-blue-500/10 text-blue-500";
      case "Inspection":
        return "bg-green-500/10 text-green-500";
      case "Financial":
        return "bg-yellow-500/10 text-yellow-500";
      case "Marketing":
        return "bg-pink-500/10 text-pink-500";
      default:
        return "bg-gray-500/10 text-gray-500";
    }
  };
  const getRatingStars = (rating: number) => {
    const stars = [];
    const fullStars = Math.floor(rating);
    const hasHalfStar = rating % 1 !== 0;
    for (let i = 0; i < fullStars; i++) {
      stars.push(<Star key={i} className="w-4 h-4 fill-current text-yellow-500" />);
    }
    if (hasHalfStar) {
      stars.push(<Star key="half" className="w-4 h-4 fill-current text-yellow-500 opacity-50" />);
    }
    const emptyStars = 5 - Math.ceil(rating);
    for (let i = 0; i < emptyStars; i++) {
      stars.push(<Star key={`empty-${i}`} className="w-4 h-4 text-gray-300" />);
    }
    return stars;
  };
  const filteredTemplates = templates.filter(template => {
    const matchesType = filterType === "all" || template.type === filterType;
    const matchesCategory = filterCategory === "all" || template.category === filterCategory;
    const matchesStatus = filterStatus === "all" || template.status === filterStatus;
    const matchesSearch = template.name.toLowerCase().includes(searchTerm.toLowerCase()) || template.description.toLowerCase().includes(searchTerm.toLowerCase()) || template.tags.some(tag => tag.toLowerCase().includes(searchTerm.toLowerCase()));
    const matchesFolder = !selectedFolder || template.folder.id === selectedFolder;
    return matchesType && matchesCategory && matchesStatus && matchesSearch && matchesFolder;
  });
  const sortedTemplates = [...filteredTemplates].sort((a, b) => {
    let comparison = 0;
    switch (sortBy) {
      case "name":
        comparison = a.name.localeCompare(b.name);
        break;
      case "date":
        comparison = new Date(a.updatedAt).getTime() - new Date(b.updatedAt).getTime();
        break;
      case "usage":
        comparison = a.usage.totalUses - b.usage.totalUses;
        break;
      case "rating":
        comparison = a.usage.averageRating - b.usage.averageRating;
        break;
    }
    return sortOrder === "asc" ? comparison : -comparison;
  });
  const favoriteTemplates = templates.filter(t => t.isFavorite);
  const recentlyUsed = usage.sort((a, b) => new Date(b.usedAt).getTime() - new Date(a.usedAt).getTime()).slice(0, 5);
  return <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold flex items-center gap-2">
            <FileText className="w-8 h-8" />{t("client.src.templates")}</h1>
          <p className="text-muted-foreground">{t("client.src.create_and_manage_document")}</p>
        </div>
        <div className="flex items-center gap-2">
          <Button variant="outline" onClick={() => setShowFolderDialog(true)}>
            <Folder className="w-4 h-4 mr-2" />{t("client.src.new_folder")}</Button>
          <Button onClick={() => setShowCreateDialog(true)}>
            <Plus className="w-4 h-4 mr-2" />{t("client.src.new_template")}</Button>
        </div>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <Card>
          <CardContent className="p-4">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-muted-foreground">{t("client.src.total_templates")}</p>
                <p className="text-2xl font-bold">{templates.length}</p>
              </div>
              <FileText className="w-8 h-8 text-blue-500" />
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="p-4">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-muted-foreground">{t("client.src.total_uses")}</p>
                <p className="text-2xl font-bold">
                  {templates.reduce((acc, t) => acc + t.usage.totalUses, 0)}
                </p>
              </div>
              <TrendingUp className="w-8 h-8 text-green-500" />
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="p-4">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-muted-foreground">{t("client.src.favorites")}</p>
                <p className="text-2xl font-bold">{favoriteTemplates.length}</p>
              </div>
              <Star className="w-8 h-8 text-yellow-500" />
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="p-4">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-muted-foreground">{t("client.src.folders")}</p>
                <p className="text-2xl font-bold">{folders.length}</p>
              </div>
              <Folder className="w-8 h-8 text-purple-500" />
            </div>
          </CardContent>
        </Card>
      </div>

      <Tabs value={activeTab} onValueChange={setActiveTab}>
        <TabsList className="grid w-full grid-cols-4">
          <TabsTrigger value="templates">{t("client.src.templates")}</TabsTrigger>
          <TabsTrigger value="folders">{t("client.src.folders")}</TabsTrigger>
          <TabsTrigger value="usage">{t("client.src.usage_analytics")}</TabsTrigger>
          <TabsTrigger value="create">{t("client.src.create_new")}</TabsTrigger>
        </TabsList>

        {/* Templates Tab */}
        <TabsContent value="templates" className="space-y-6">
          {/* Quick Access */}
          {(favoriteTemplates.length > 0 || recentlyUsed.length > 0) && <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              {favoriteTemplates.length > 0 && <Card>
                  <CardHeader>
                    <CardTitle className="flex items-center gap-2">
                      <Star className="w-5 h-5 text-yellow-500" />{t("client.src.favorite_templates")}</CardTitle>
                  </CardHeader>
                  <CardContent>
                    <div className="space-y-3">
                      {favoriteTemplates.slice(0, 3).map(template => <motion.div key={template.id} initial={{
                  opacity: 0,
                  y: 10
                }} animate={{
                  opacity: 1,
                  y: 0
                }} className="flex items-center gap-3 p-3 border rounded-lg hover:shadow-md transition-shadow cursor-pointer" onClick={() => setSelectedTemplate(template)}>
                          <div className="p-2 rounded-lg bg-blue-500/10">
                            {getTemplateIcon(template.type)}
                          </div>
                          <div className="flex-1">
                            <h4 className="font-medium">{template.name}</h4>
                            <p className="text-sm text-gray-500">{template.category}</p>
                          </div>
                          <div className="text-right">
                            <p className="text-sm font-medium">{template.usage.totalUses}{t("client.src.uses")}</p>
                            <div className="flex items-center gap-1">
                              {getRatingStars(template.usage.averageRating)}
                            </div>
                          </div>
                        </motion.div>)}
                    </div>
                  </CardContent>
                </Card>}

              {recentlyUsed.length > 0 && <Card>
                  <CardHeader>
                    <CardTitle className="flex items-center gap-2">
                      <Clock className="w-5 h-5 text-blue-500" />{t("client.src.recently_used")}</CardTitle>
                  </CardHeader>
                  <CardContent>
                    <div className="space-y-3">
                      {recentlyUsed.map(usage => <motion.div key={usage.id} initial={{
                  opacity: 0,
                  y: 10
                }} animate={{
                  opacity: 1,
                  y: 0
                }} className="flex items-center gap-3 p-3 border rounded-lg hover:shadow-md transition-shadow cursor-pointer">
                          <div className="p-2 rounded-lg bg-green-500/10">
                            <FileText className="w-6 h-6 text-green-500" />
                          </div>
                          <div className="flex-1">
                            <h4 className="font-medium">{usage.templateName}</h4>
                            <p className="text-sm text-gray-500">{t("client.src.used")}{format(new Date(usage.usedAt), "MMM d, yyyy")}
                            </p>
                          </div>
                          <Button size="sm" variant="outline">
                            <Eye className="w-4 h-4" />
                          </Button>
                        </motion.div>)}
                    </div>
                  </CardContent>
                </Card>}
            </div>}

          {/* Filters */}
          <Card>
            <CardContent className="p-4">
              <div className="flex flex-wrap items-center gap-4">
                <div className="flex items-center gap-2">
                  <Search className="w-4 h-4" />
                  <Input placeholder={t("client.src.search_templates")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="w-64" />
                </div>
                <Select value={filterType} onValueChange={setFilterType}>
                  <SelectTrigger className="w-40">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">{t("client.src.all_types")}</SelectItem>
                    <SelectItem value="document">{t("client.src.documents")}</SelectItem>
                    <SelectItem value="email">{t("client.src.emails")}</SelectItem>
                    <SelectItem value="contract">{t("client.src.contracts")}</SelectItem>
                    <SelectItem value="report">{t("client.src.reports")}</SelectItem>
                    <SelectItem value="form">{t("client.src.forms")}</SelectItem>
                  </SelectContent>
                </Select>
                <Select value={filterCategory} onValueChange={setFilterCategory}>
                  <SelectTrigger className="w-32">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">{t("client.src.all_categories")}</SelectItem>
                    <SelectItem value="Legal">{t("client.src.legal")}</SelectItem>
                    <SelectItem value="Communication">{t("client.src.communication")}</SelectItem>
                    <SelectItem value="Inspection">{t("client.src.inspection")}</SelectItem>
                    <SelectItem value="Financial">{t("client.src.financial")}</SelectItem>
                  </SelectContent>
                </Select>
                <Select value={selectedFolder || ""} onValueChange={v => setSelectedFolder(v || null)}>
                  <SelectTrigger className="w-32">
                    <SelectValue placeholder={t("client.src.all_folders")} />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="">{t("client.src.all_folders")}</SelectItem>
                    {folders.map(folder => <SelectItem key={folder.id} value={folder.id}>
                        {folder.name}
                      </SelectItem>)}
                  </SelectContent>
                </Select>
                <Select value={sortBy} onValueChange={(value: any) => setSortBy(value)}>
                  <SelectTrigger className="w-32">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="name">{t("client.src.name")}</SelectItem>
                    <SelectItem value="date">{t("client.src.date")}</SelectItem>
                    <SelectItem value="usage">{t("client.src.usage")}</SelectItem>
                    <SelectItem value="rating">{t("client.src.rating")}</SelectItem>
                  </SelectContent>
                </Select>
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

          {/* Templates Grid/List */}
          <Card>
            <CardHeader>
              <CardTitle>{t("client.src.templates")}{sortedTemplates.length})</CardTitle>
            </CardHeader>
            <CardContent>
              {viewMode === "grid" ? <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
                  {sortedTemplates.map(template => <motion.div key={template.id} initial={{
                opacity: 0,
                scale: 0.9
              }} animate={{
                opacity: 1,
                scale: 1
              }} className="border rounded-lg p-4 hover:shadow-md transition-shadow cursor-pointer" onClick={() => setSelectedTemplate(template)}>
                      <div className="flex items-start justify-between mb-3">
                        <div className="p-2 rounded-lg bg-blue-500/10">
                          {getTemplateIcon(template.type)}
                        </div>
                        <div className="flex items-center gap-1">
                          {template.isFavorite && <Star className="w-4 h-4 text-yellow-500 fill-current" />}
                          {template.permissions.isPublic ? <Unlock className="w-4 h-4 text-green-500" /> : <LockKeyhole className="w-4 h-4 text-gray-400" />}
                        </div>
                      </div>
                      <h3 className="font-medium mb-1 line-clamp-2">{template.name}</h3>
                      <p className="text-sm text-gray-600 mb-3 line-clamp-2">{template.description}</p>
                      <div className="flex items-center gap-2 mb-3">
                        <Badge className={getCategoryColor(template.category)}>
                          {template.category}
                        </Badge>
                        <Badge className={getStatusColor(template.status)}>
                          {template.status}
                        </Badge>
                      </div>
                      <div className="flex items-center justify-between text-sm text-gray-500 mb-3">
                        <span>{template.usage.totalUses}{t("client.src.uses")}</span>
                        <div className="flex items-center gap-1">
                          {getRatingStars(template.usage.averageRating)}
                        </div>
                      </div>
                      <div className="flex flex-wrap gap-1">
                        {template.tags.slice(0, 2).map(tag => <Badge key={tag} variant="secondary" className="text-xs">
                            {tag}
                          </Badge>)}
                        {template.tags.length > 2 && <Badge variant="secondary" className="text-xs">
                            +{template.tags.length - 2}
                          </Badge>}
                      </div>
                    </motion.div>)}
                </div> : <div className="space-y-3">
                  {sortedTemplates.map(template => <motion.div key={template.id} initial={{
                opacity: 0,
                x: -10
              }} animate={{
                opacity: 1,
                x: 0
              }} className="border rounded-lg p-4 hover:shadow-md transition-shadow cursor-pointer" onClick={() => setSelectedTemplate(template)}>
                      <div className="flex items-center gap-4">
                        <div className="p-3 rounded-lg bg-blue-500/10">
                          {getTemplateIcon(template.type)}
                        </div>
                        <div className="flex-1">
                          <div className="flex items-center gap-2 mb-1">
                            <h3 className="font-medium">{template.name}</h3>
                            <Badge className={getCategoryColor(template.category)}>
                              {template.category}
                            </Badge>
                            <Badge className={getStatusColor(template.status)}>
                              {template.status}
                            </Badge>
                            {template.isFavorite && <Star className="w-4 h-4 text-yellow-500 fill-current" />}
                          </div>
                          <p className="text-sm text-gray-600 mb-2">{template.description}</p>
                          <div className="flex items-center gap-4 text-sm text-gray-500">
                            <span>{template.usage.totalUses}{t("client.src.uses")}</span>
                            <span>{template.variables.length}{t("client.src.variables")}</span>
                            <div className="flex items-center gap-1">
                              {getRatingStars(template.usage.averageRating)}
                            </div>
                            {template.permissions.isPublic ? <Unlock className="w-4 h-4 text-green-500" /> : <LockKeyhole className="w-4 h-4 text-gray-400" />}
                          </div>
                          <div className="flex flex-wrap gap-1 mt-2">
                            {template.tags.map(tag => <Badge key={tag} variant="secondary" className="text-xs">
                                {tag}
                              </Badge>)}
                          </div>
                        </div>
                        <div className="flex gap-2">
                          <Button size="sm" variant="outline" onClick={e => {
                      e.stopPropagation();
                      setShowUseDialog(true);
                    }}>
                            <FilePlus className="w-4 h-4 mr-2" />{t("client.src.use")}</Button>
                          <DropdownMenu>
                            <DropdownMenuTrigger asChild>
                              <Button size="sm" variant="outline" onClick={e => e.stopPropagation()}>
                                <MoreHorizontal className="w-4 h-4" />
                              </Button>
                            </DropdownMenuTrigger>
                            <DropdownMenuContent>
                              <DropdownMenuItem>
                                <Eye className="w-4 h-4 mr-2" />{t("client.src.preview")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <Edit className="w-4 h-4 mr-2" />{t("client.src.edit")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <Copy className="w-4 h-4 mr-2" />{t("client.src.duplicate")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <Download className="w-4 h-4 mr-2" />{t("client.src.download")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <Share2 className="w-4 h-4 mr-2" />{t("client.src.share")}</DropdownMenuItem>
                              <DropdownMenuSeparator />
                              <DropdownMenuItem>
                                <Trash2 className="w-4 h-4 mr-2" />{t("client.src.delete")}</DropdownMenuItem>
                            </DropdownMenuContent>
                          </DropdownMenu>
                        </div>
                      </div>
                    </motion.div>)}
                </div>}
            </CardContent>
          </Card>
        </TabsContent>

        {/* Folders Tab */}
        <TabsContent value="folders" className="space-y-6">
          <Card>
            <CardHeader>
              <CardTitle>{t("client.src.template_folders")}{folders.length})</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                {folders.map(folder => <motion.div key={folder.id} initial={{
                opacity: 0,
                y: 10
              }} animate={{
                opacity: 1,
                y: 0
              }} className="border rounded-lg p-4 hover:shadow-md transition-shadow cursor-pointer" onClick={() => setSelectedFolder(folder.id)}>
                    <div className="flex items-center gap-3 mb-3">
                      <div className="p-2 rounded-lg bg-purple-500/10">
                        <Folder className="w-6 h-6 text-purple-500" />
                      </div>
                      <div className="flex-1">
                        <h3 className="font-medium">{folder.name}</h3>
                        <p className="text-sm text-gray-500">{folder.templateCount}{t("client.src.templates")}</p>
                      </div>
                      {folder.isPublic && <Unlock className="w-4 h-4 text-green-500" />}
                    </div>
                    <p className="text-sm text-gray-600 mb-3">{folder.description}</p>
                    <div className="flex items-center justify-between text-sm text-gray-500">
                      <span>{t("client.src.created")}{format(new Date(folder.createdAt), "MMM d, yyyy")}</span>
                      <span>{folder.path}</span>
                    </div>
                  </motion.div>)}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        {/* Usage Analytics Tab */}
        <TabsContent value="usage" className="space-y-6">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <Card>
              <CardHeader>
                <CardTitle>{t("client.src.template_usage_statistics")}</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {templates.sort((a, b) => b.usage.totalUses - a.usage.totalUses).slice(0, 5).map(template => <div key={template.id} className="flex items-center justify-between p-3 border rounded-lg">
                        <div>
                          <h4 className="font-medium">{template.name}</h4>
                          <p className="text-sm text-gray-500">{template.category}</p>
                        </div>
                        <div className="text-right">
                          <p className="font-medium">{template.usage.totalUses}{t("client.src.uses")}</p>
                          <div className="flex items-center gap-1">
                            {getRatingStars(template.usage.averageRating)}
                          </div>
                        </div>
                      </div>)}
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <CardTitle>{t("client.src.recent_usage")}</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-3">
                  {usage.sort((a, b) => new Date(b.usedAt).getTime() - new Date(a.usedAt).getTime()).slice(0, 10).map(usage => <div key={usage.id} className="flex items-center justify-between p-3 border rounded-lg">
                        <div>
                          <h4 className="font-medium">{usage.templateName}</h4>
                          <p className="text-sm text-gray-500">{t("client.src.used_by")}{usage.usedByName}{t("client.src.on")}{format(new Date(usage.usedAt), "MMM d, yyyy")}
                          </p>
                        </div>
                        <Button size="sm" variant="outline">
                          <Eye className="w-4 h-4" />
                        </Button>
                      </div>)}
                </div>
              </CardContent>
            </Card>
          </div>
        </TabsContent>

        {/* Create New Tab */}
        <TabsContent value="create" className="space-y-6">
          <Card>
            <CardHeader>
              <CardTitle>{t("client.src.create_new_template")}</CardTitle>
              <CardDescription>{t("client.src.start_from_scratch_or")}</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                {[{
                type: "document",
                name: "Document",
                icon: FileText,
                description: t("client.src.general_document_template")
              }, {
                type: "email",
                name: "Email",
                icon: Mail,
                description: t("client.src.email_message_template")
              }, {
                type: "contract",
                name: "Contract",
                icon: FileSignature,
                description: t("client.src.legal_contract_template")
              }, {
                type: "report",
                name: "Report",
                icon: FileCheck,
                description: t("client.src.report_template")
              }, {
                type: "form",
                name: "Form",
                icon: FileText,
                description: t("client.src.form_template")
              }, {
                type: "proposal",
                name: "Proposal",
                icon: FileText,
                description: t("client.src.business_proposal_template")
              }].map(templateType => <motion.div key={templateType.type} initial={{
                opacity: 0,
                scale: 0.9
              }} animate={{
                opacity: 1,
                scale: 1
              }} className="border rounded-lg p-4 hover:shadow-md transition-shadow cursor-pointer" onClick={() => setShowCreateDialog(true)}>
                    <div className="flex flex-col items-center text-center">
                      <div className="p-3 rounded-lg bg-blue-500/10 mb-3">
                        <templateType.icon className="w-8 h-8 text-blue-500" />
                      </div>
                      <h3 className="font-medium mb-1">{templateType.name}</h3>
                      <p className="text-sm text-gray-600">{templateType.description}</p>
                    </div>
                  </motion.div>)}
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>

      {/* Template Details Dialog */}
      {selectedTemplate && <Dialog open={!!selectedTemplate} onOpenChange={() => setSelectedTemplate(null)}>
          <DialogContent className="max-w-4xl">
            <DialogHeader>
              <DialogTitle>{selectedTemplate.name}</DialogTitle>
              <DialogDescription>{t("client.src.template_details_and_management")}</DialogDescription>
            </DialogHeader>
            <div className="grid gap-6 py-4">
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <Label className="text-sm font-medium">{t("client.src.type")}</Label>
                  <p className="text-sm capitalize">{selectedTemplate.type}</p>
                </div>
                <div>
                  <Label className="text-sm font-medium">{t("client.src.category")}</Label>
                  <Badge className={getCategoryColor(selectedTemplate.category)}>
                    {selectedTemplate.category}
                  </Badge>
                </div>
                <div>
                  <Label className="text-sm font-medium">{t("client.src.status")}</Label>
                  <Badge className={getStatusColor(selectedTemplate.status)}>
                    {selectedTemplate.status}
                  </Badge>
                </div>
                <div>
                  <Label className="text-sm font-medium">{t("client.src.version")}</Label>
                  <p className="text-sm">{selectedTemplate.metadata.version}</p>
                </div>
              </div>
              <div>
                <Label className="text-sm font-medium">{t("client.src.description")}</Label>
                <p className="text-sm">{selectedTemplate.description}</p>
              </div>
              <div>
                <Label className="text-sm font-medium">{t("client.src.variables")}{selectedTemplate.variables.length})</Label>
                <div className="grid grid-cols-2 gap-2 mt-2">
                  {selectedTemplate.variables.map(variable => <div key={variable.key} className="flex items-center gap-2 p-2 border rounded">
                      <span className="text-sm font-medium">{variable.label}</span>
                      <Badge variant="outline" className="text-xs">
                        {variable.type}
                      </Badge>
                      {variable.required && <span className="text-red-500">*</span>}
                    </div>)}
                </div>
              </div>
              <div>
                <Label className="text-sm font-medium">{t("client.src.usage_statistics")}</Label>
                <div className="grid grid-cols-4 gap-4 mt-2">
                  <div className="text-center">
                    <p className="text-2xl font-bold">{selectedTemplate.usage.totalUses}</p>
                    <p className="text-sm text-gray-500">{t("client.src.total_uses")}</p>
                  </div>
                  <div className="text-center">
                    <p className="text-2xl font-bold">{selectedTemplate.usage.downloads}</p>
                    <p className="text-sm text-gray-500">{t("client.src.downloads")}</p>
                  </div>
                  <div className="text-center">
                    <p className="text-2xl font-bold">{selectedTemplate.usage.shares}</p>
                    <p className="text-sm text-gray-500">{t("client.src.shares")}</p>
                  </div>
                  <div className="text-center">
                    <div className="flex items-center justify-center gap-1">
                      {getRatingStars(selectedTemplate.usage.averageRating)}
                    </div>
                    <p className="text-sm text-gray-500">{t("client.src.rating")}</p>
                  </div>
                </div>
              </div>
              <div>
                <Label className="text-sm font-medium">{t("client.src.tags")}</Label>
                <div className="flex flex-wrap gap-1 mt-2">
                  {selectedTemplate.tags.map(tag => <Badge key={tag} variant="secondary" className="text-xs">
                      {tag}
                    </Badge>)}
                </div>
              </div>
            </div>
            <DialogFooter>
              <Button variant="outline" onClick={() => setSelectedTemplate(null)}>{t("client.src.close")}</Button>
              <Button variant="outline">
                <Edit className="w-4 h-4 mr-2" />{t("client.src.edit_template")}</Button>
              <Button onClick={() => {
            setShowUseDialog(true);
            setSelectedTemplate(null);
          }}>
                <FilePlus className="w-4 h-4 mr-2" />{t("client.src.use_template")}</Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>}

      {/* Use Template Dialog */}
      <Dialog open={showUseDialog} onOpenChange={setShowUseDialog}>
        <DialogContent className="max-w-2xl">
          <DialogHeader>
            <DialogTitle>{t("client.src.use_template")}</DialogTitle>
            <DialogDescription>{t("client.src.fill_in_the_template")}</DialogDescription>
          </DialogHeader>
          <div className="grid gap-4 py-4">
            {selectedTemplate?.variables.map(variable => <div key={variable.key}>
                <Label className="text-sm font-medium">
                  {variable.label}
                  {variable.required && <span className="text-red-500 ml-1">*</span>}
                </Label>
                {variable.type === "textarea" ? <Textarea placeholder={`Enter ${variable.label.toLowerCase()}`} /> : variable.type === "select" ? <Select>
                    <SelectTrigger>
                      <SelectValue placeholder={`Select ${variable.label.toLowerCase()}`} />
                    </SelectTrigger>
                    <SelectContent>
                      {variable.options?.map(option => <SelectItem key={option} value={option}>
                          {option}
                        </SelectItem>)}
                    </SelectContent>
                  </Select> : <Input type={variable.type === "email" ? "email" : variable.type === "number" ? "number" : "text"} placeholder={`Enter ${variable.label.toLowerCase()}`} />}
              </div>)}
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setShowUseDialog(false)}>{t("client.src.cancel")}</Button>
            <Button onClick={() => setShowUseDialog(false)}>
              <FilePlus className="w-4 h-4 mr-2" />{t("client.src.generate_document")}</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>;
}