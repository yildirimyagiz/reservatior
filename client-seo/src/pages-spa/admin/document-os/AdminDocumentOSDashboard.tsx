"use client";

import { useTranslation } from "react-i18next";
import { FileText, Upload, CheckCircle, Clock, AlertCircle, Search, Shield, Users, FolderOpen } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { m } from "framer-motion";

const DOCUMENTS = [
  { id: 1, name: "Lease Agreement - 123 Main St", type: "contract", status: "approved", createdAt: "2024-01-15" },
  { id: 2, name: "Invoice #4521", type: "invoice", status: "pending_review", createdAt: "2024-01-14" },
  { id: 3, name: "Property Inspection Report", type: "property", status: "approved", createdAt: "2024-01-13" },
  { id: 4, name: "Insurance Policy", type: "insurance", status: "draft", createdAt: "2024-01-12" },
];

const TEMPLATES = [
  { id: 1, name: "Standard Lease Agreement", type: "contract", usage: 45 },
  { id: 2, name: "Rental Invoice", type: "invoice", usage: 128 },
  { id: 3, name: "Property Disclosure", type: "property", usage: 67 },
];

const SIGNATURE_REQUESTS = [
  { id: 1, document: "Lease Agreement - 123 Main St", signers: ["john@example.com", "jane@example.com"], status: "pending" },
  { id: 2, document: "Sales Contract - 456 Oak Ave", signers: ["bob@example.com"], status: "completed" },
];

export default function AdminDocumentOSDashboard() {
  const { t } = useTranslation();

  const kpis = [
    { title: t("document_os.total_documents", "document os.total documents"), value: 1247, icon: FileText, color: "text-success", trend: "+23 this week" },
    { title: t("document_os.pending_review", "İnceleme Bekliyor"), value: 18, icon: Clock, color: "text-yellow-400", trend: "Requires attention" },
    { title: t("document_os.approved", "Onaylandı"), value: 1189, icon: CheckCircle, color: "text-info", trend: "95.4% approval rate" },
    { title: t("document_os.templates", "Şablonlar"), value: 12, icon: FolderOpen, color: "text-brand", trend: "+2 new this month" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-foreground">{t("document_os.title", "Doküman OS")}</h1>
          <p className="text-muted-foreground mt-1">{t("document_os.subtitle", "document os.subtitle")}</p>
        </div>
        <Button className="bg-primary text-primary-foreground hover:bg-primary/90">
          <Upload className="h-4 w-4 mr-2" />
          {t("document_os.upload_document", "Belge Yükle")}
        </Button>
      </div>

      {/* KPIs */}
      <div className="grid gap-4 md:grid-cols-4">
        {kpis.map((kpi, i) => (
          <m.div key={kpi.title} initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: i * 0.07 }}>
            <Card className="bg-card border-border">
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-muted-foreground">{kpi.title}</CardTitle>
                <kpi.icon className={`h-4 w-4 ${kpi.color}`} />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-foreground">{kpi.value}</div>
                <p className="text-xs text-muted-foreground mt-1">{kpi.trend}</p>
              </CardContent>
            </Card>
          </m.div>
        ))}
      </div>

      <Tabs defaultValue="documents" className="space-y-4">
        <TabsList className="bg-card border-border">
          <TabsTrigger value="documents">{t("document_os.tabs.documents", "Belgeler")}</TabsTrigger>
          <TabsTrigger value="templates">{t("document_os.tabs.templates", "Şablonlar")}</TabsTrigger>
          <TabsTrigger value="signatures">{t("document_os.tabs.signatures", "İmzalar")}</TabsTrigger>
          <TabsTrigger value="approvals">{t("document_os.tabs.approvals", "Onaylar")}</TabsTrigger>
        </TabsList>

        <TabsContent value="documents" className="space-y-4">
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("document_os.library", "Belge Kütüphanesi")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("document_os.library_desc", "Sistemdeki tüm belgeler")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {DOCUMENTS.map((doc) => (
                  <div key={doc.id} className="flex items-center justify-between p-4 rounded-lg bg-muted/50 border border-border">
                    <div className="flex items-center gap-3">
                      <FileText className="h-5 w-5 text-muted-foreground" />
                      <div>
                        <p className="text-sm font-medium text-foreground">{doc.name}</p>
                        <p className="text-xs text-muted-foreground">{doc.type} • {doc.createdAt}</p>
                      </div>
                    </div>
                    <Badge variant={doc.status === 'approved' ? 'default' : doc.status === 'pending_review' ? 'secondary' : 'outline'} className="text-xs">
                      {doc.status}
                    </Badge>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="templates">
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("document_os.templates", "Şablonlar")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("document_os.templates_desc", "Yeniden kullanılabilir belge şablonları")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {TEMPLATES.map((template) => (
                  <div key={template.id} className="flex items-center justify-between p-4 rounded-lg bg-muted/50 border border-border">
                    <div className="flex items-center gap-3">
                      <FolderOpen className="h-5 w-5 text-muted-foreground" />
                      <div>
                        <p className="text-sm font-medium text-foreground">{template.name}</p>
                        <p className="text-xs text-muted-foreground">{template.type} • {t("document_os.used", "Kullanıldı")} {template.usage} {t("document_os.times", "kez")}</p>
                      </div>
                    </div>
                    <Button variant="outline" size="sm">{t("document_os.use_template", "Şablonu Kullan")}</Button>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="signatures">
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("document_os.signatures", "İmza Talepleri")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("document_os.signatures_desc", "Dijital imza talepleri ve durumu")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {SIGNATURE_REQUESTS.map((req) => (
                  <div key={req.id} className="p-4 rounded-lg bg-muted/50 border border-border">
                    <div className="flex items-start justify-between mb-2">
                      <div className="flex items-center gap-2">
                        <Shield className="h-4 w-4 text-muted-foreground" />
                        <p className="text-sm font-medium text-foreground">{req.document}</p>
                      </div>
                      <Badge variant={req.status === 'completed' ? 'default' : 'secondary'} className="text-xs">
                        {req.status}
                      </Badge>
                    </div>
                    <div className="flex items-center gap-2">
                      <Users className="h-3 w-3 text-muted-foreground" />
                      <p className="text-xs text-muted-foreground">{req.signers.join(", ")}</p>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="approvals">
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("document_os.approvals", "Belge Onayları")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("document_os.approvals_desc", "Bekleyen belge onayları")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-muted-foreground">
                <AlertCircle className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>{t("document_os.approval_queue_placeholder", "Onay kuyruğu arayüzü")}</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
