"use client";

import { useState } from "react";
import { useTranslation } from "react-i18next";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { apiClient } from "@/lib/api/client";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Progress } from "@/components/ui/progress";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import {
  Scan, ShieldCheck, Camera, AlertTriangle, CheckCircle2, Upload,
  Search, Eye, Building2, Zap, Brain, Lock, DollarSign, ArrowUpRight,
  FileText, Layers, Paintbrush, Globe, ChevronRight, RefreshCw, Trash2, Plus
} from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { cn } from "@/lib/utils";

interface RoomAnalysis {
  id: string;
  roomId: string;
  roomType: string;
  name: string;
  areaSqm: number;
  conditionScore: number;
  defects: { type: string; severity: string; description: string }[];
  lightScore: number;
  stagedStyles: string[];
}

interface HealthReport {
  id: string;
  propertyId: string;
  overallScore: number;
  structuralIntegrity: number;
  cosmeticCondition: number;
  systemsHealth: number;
  safetyScore: number;
  totalDefects: number;
  criticalDefects: number;
  estimatedRepairCost: number;
  generatedAt: string;
  comparisonMode?: string;
  conditionDelta?: number;
  rooms?: RoomAnalysis[];
}

interface InsuranceProduct {
  id: string;
  type: string;
  name: string;
  provider: string;
  coverageAmount: number;
  annualPremium: number;
  monthlyPremium: number;
  suitableFor: string[];
}

interface InsuranceAttachment {
  id: string;
  propertyId: string;
  productId: string;
  productName: string;
  holderType: string;
  status: string;
  attachedAt: string;
}

interface SpatialAsset {
  id: string;
  propertyId: string;
  url: string;
  type: string;
  analysisStatus: string;
  uploadedAt: string;
}

interface BrochureAsset {
  id: string;
  propertyId: string;
  language: string;
  title: string;
  pdfUrl: string;
  status: string;
  generatedAt: string;
}

const ROOM_TYPE_ICONS: Record<string, any> = {
  LIVING_ROOM: "🛋️", BEDROOM: "🛏️", KITCHEN: "🍳", BATHROOM: "🚿",
  HOME_OFFICE: "💻", DINING_ROOM: "🍽️", GARAGE: "🚗", BALCONY: "🌅",
  HALLWAY: "🚪", EXTERIOR: "🏠",
};

const SEVERITY_CONFIG: Record<string, { label: string; class: string; icon: any }> = {
  NONE: { label: "None", class: "bg-blue-500/20 text-success", icon: CheckCircle2 },
  LOW: { label: "Low", class: "bg-blue-500/20 text-info", icon: Eye },
  MEDIUM: { label: "Medium", class: "bg-amber-500/20 text-warning", icon: AlertTriangle },
  HIGH: { label: "High", class: "bg-orange-500/20 text-warning", icon: AlertTriangle },
  CRITICAL: { label: "Critical", class: "bg-red-500/20 text-red-400", icon: AlertTriangle },
};

export default function SpatialAnalysisDashboard() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const [searchTerm, setSearchTerm] = useState("");
  const [isUploadOpen, setIsUploadOpen] = useState(false);
  const [selectedPropertyId, setSelectedPropertyId] = useState("");
  const [activeTab, setActiveTab] = useState("overview");

  const { data: reportsData, isLoading: reportsLoading } = useQuery({
    queryKey: ["spatial-health-reports"],
    queryFn: async () => {
      const res: any = await apiClient.get("/property-health-report");
      return (res?.data || []) as HealthReport[];
    },
  });

  const { data: productsData } = useQuery({
    queryKey: ["insurance-products"],
    queryFn: async () => {
      const res: any = await apiClient.get("/insurance-products");
      return (res?.data || []) as InsuranceProduct[];
    },
  });

  const { data: attachmentsData } = useQuery({
    queryKey: ["insurance-attachments"],
    queryFn: async () => {
      const res: any = await apiClient.get("/insurance-attachments");
      return (res?.data || []) as InsuranceAttachment[];
    },
  });

  const { data: brochuresData } = useQuery({
    queryKey: ["brochures"],
    queryFn: async () => {
      const res: any = await apiClient.get("/brochures");
      return (res?.data || []) as BrochureAsset[];
    },
  });

  const reports = (reportsData || []) as HealthReport[];
  const products = (productsData || []) as InsuranceProduct[];
  const attachments = (attachmentsData || []) as InsuranceAttachment[];
  const brochures = (brochuresData || []) as BrochureAsset[];

  const analyzeMutation = useMutation({
    mutationFn: async (data: { propertyId: string; assets: string[] }) => {
      return apiClient.post("/spatial-analysis", data);
    },
    onSuccess: () => {
      toast({ title: "⚡ Analysis Started", description: "Gemini ML pipeline processing your property assets..." });
      queryClient.invalidateQueries({ queryKey: ["spatial-health-reports"] });
    },
    onError: (err: any) => {
      toast({ title: "Error", description: err.message, variant: "destructive" });
    },
  });

  const attachInsuranceMutation = useMutation({
    mutationFn: async (data: { propertyId: string; productId: string; holderType: string }) => {
      return apiClient.post("/insurance-attachments", data);
    },
    onSuccess: () => {
      toast({ title: "🛡️ Insurance Attached", description: "Deposit protection policy linked to property" });
      queryClient.invalidateQueries({ queryKey: ["insurance-attachments"] });
    },
    onError: (err: any) => {
      toast({ title: "Error", description: err.message, variant: "destructive" });
    },
  });

  const generateBrochureMutation = useMutation({
    mutationFn: async (data: { propertyId: string; languages: string[]; demographicTarget: string }) => {
      return apiClient.post("/brochures/generate", data);
    },
    onSuccess: () => {
      toast({ title: t("admin_spatial_brochure_queued", "Broşür Sıraya Alındı"), description: t("admin_spatial_brochure_queued_desc", "Çok dilli PDF broşür oluşturma başlatıldı") });
      queryClient.invalidateQueries({ queryKey: ["brochures"] });
    },
    onError: (err: any) => {
      toast({ title: "Error", description: err.message, variant: "destructive" });
    },
  });

  const stats = {
    totalReports: reports.length,
    avgHealthScore: reports.length > 0 ? Math.round(reports.reduce((s, r) => s + r.overallScore, 0) / reports.length) : 0,
    totalDefects: reports.reduce((s, r) => s + r.totalDefects, 0),
    criticalDefects: reports.reduce((s, r) => s + r.criticalDefects, 0),
    insuranceAttached: attachments.length,
    brochuresGenerated: brochures.length,
    totalRepairCost: reports.reduce((s, r) => s + (r.estimatedRepairCost || 0), 0),
    propertiesAnalyzed: reports.length,
  };

  const filtered = reports.filter((r) =>
    r.propertyId.toLowerCase().includes(searchTerm.toLowerCase()) ||
    r.id.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-6 min-h-screen">
      <div className="flex justify-between items-center bg-card p-6 rounded-2xl border border-border">
        <div className="flex items-center gap-4">
          <div className="p-3 bg-violet-600 rounded-xl shadow-lg shadow-violet-600/20">
            <Scan className="w-8 h-8 text-white" />
          </div>
          <div>
            <h1 className="text-3xl font-bold tracking-tight text-foreground bg-clip-text text-transparent bg-gradient-to-r from-violet-200 to-violet-500">
              {t("admin_spatial_title", "Mekansal Analiz ve Sigorta Teknolojisi")}
            </h1>
            <p className="text-muted-foreground">
              {t("admin_spatial_subtitle", "Gemini ML hattı: mülk sağlığı, sigorta çapraz satışı ve sanal sahneleme")}
            </p>
          </div>
        </div>
        <div className="flex gap-3">
          <Button variant="outline" className="gap-2 bg-card border-border hover:bg-muted dark:hover:bg-card/10 text-foreground">
            <FileText className="w-4 h-4" />
            {t("admin_spatial_reports", "Raporlar")}
          </Button>
          <Dialog open={isUploadOpen} onOpenChange={setIsUploadOpen}>
            <DialogTrigger asChild>
              <Button className="gap-2 bg-violet-600 hover:bg-violet-700 shadow-lg shadow-violet-600/20 text-white">
                <Upload className="w-4 h-4" />
                {t("admin_spatial_analyze_new", "Mülkü Analiz Et")}
              </Button>
            </DialogTrigger>
            <DialogContent className="sm:max-w-[480px] bg-background border-border text-foreground">
              <DialogHeader>
                <DialogTitle>{t("admin_spatial_analyze_dialog", "Mülk Varlıklarını Yükle")}</DialogTitle>
                <DialogDescription className="text-muted-foreground">
                  {t("admin_spatial_analyze_desc", "Gemini ML mekansal analizi için fotoğraflar veya video turları yükleyin")}
                </DialogDescription>
              </DialogHeader>
              <div className="space-y-4 pt-4">
                <div className="space-y-2">
                  <Label htmlFor="propertyId">{t("admin_spatial_property_id", "Mülk Kimliği")}</Label>
                  <Input id="propertyId" className="bg-card border-border text-foreground" placeholder="prop_xxx" value={selectedPropertyId} onChange={(e) => setSelectedPropertyId(e.target.value)} />
                </div>
                <div className="border-2 border-dashed border-border rounded-xl p-8 text-center hover:border-violet-500/50 transition-colors cursor-pointer">
                  <Camera className="w-10 h-10 mx-auto text-muted-foreground mb-3" />
                  <p className="text-sm text-muted-foreground">{t("admin_spatial_drag_drop", "Fotoğraf/video sürükleyin veya gözatın")}</p>
                  <p className="text-xs text-muted-foreground mt-1">{t("admin_spatial_upload_hint", "PNG, JPG, MP4, MOV — Maks 500MB")}</p>
                </div>
              </div>
              <DialogFooter>
                <Button variant="ghost" onClick={() => setIsUploadOpen(false)} className="text-muted-foreground">
                  {t("common.cancel", "İptal")}
                </Button>
                <Button
                  className="bg-violet-600 hover:bg-violet-700 text-white"
                  disabled={!selectedPropertyId || analyzeMutation.isPending}
                  onClick={() => {
                    analyzeMutation.mutate({ propertyId: selectedPropertyId, assets: [] });
                    setIsUploadOpen(false);
                  }}
                >
                  {analyzeMutation.isPending ? t("common.processing", "İşleniyor") : t("admin_spatial_start_analysis", "Analizi Başlat")}
                </Button>
              </DialogFooter>
            </DialogContent>
          </Dialog>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        {[
          { label: t("admin_spatial_properties_analyzed", "Analiz Edilen Mülkler"), value: stats.propertiesAnalyzed, icon: Building2, color: "bg-violet-500/20", iconColor: "text-violet-400" },
          { label: t("admin_spatial_avg_health", "Ort. Sağlık Skoru"), value: `${stats.avgHealthScore}/100`, icon: ShieldCheck, color: "bg-blue-500/20", iconColor: "text-success" },
          { label: t("admin_spatial_defects_found", "Bulunan Kusurlar"), value: stats.totalDefects, icon: AlertTriangle, color: "bg-amber-500/20", iconColor: "text-warning", sub: `${stats.criticalDefects} critical` },
          { label: t("admin_spatial_repair_cost", "Tahmini Onarım Maliyeti"), value: `$${stats.totalRepairCost.toLocaleString()}`, icon: DollarSign, color: "bg-blue-500/20", iconColor: "text-info" },
        ].map((kpi, i) => (
          <Card key={i} className="bg-card border-border">
            <CardContent className="p-6">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-xs font-medium text-muted-foreground">{kpi.label}</p>
                  <h3 className="text-2xl font-bold text-foreground mt-1">{kpi.value}</h3>
                  {'sub' in kpi && kpi.sub && <p className="text-xs text-red-400 mt-1">{kpi.sub}</p>}
                </div>
                <div className={cn("p-3 rounded-lg", kpi.color)}>
                  <kpi.icon className={cn("w-5 h-5", kpi.iconColor)} />
                </div>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      <Tabs value={activeTab} onValueChange={setActiveTab}>
        <TabsList className="bg-card border border-border">
          <TabsTrigger value="overview" className="data-[state=active]:bg-violet-600 data-[state=active]:text-white">
            <Eye className="w-4 h-4 mr-2" /> {t("admin_spatial_tab_overview", "Sağlık Raporları")}
          </TabsTrigger>
          <TabsTrigger value="insurance" className="data-[state=active]:bg-violet-600 data-[state=active]:text-white">
            <ShieldCheck className="w-4 h-4 mr-2" /> {t("admin_spatial_tab_insurance", "SigortaTek")}
          </TabsTrigger>
          <TabsTrigger value="staging" className="data-[state=active]:bg-violet-600 data-[state=active]:text-white">
            <Paintbrush className="w-4 h-4 mr-2" /> {t("admin_spatial_tab_staging", "Sanal Sahneleme")}
          </TabsTrigger>
          <TabsTrigger value="brochures" className="data-[state=active]:bg-violet-600 data-[state=active]:text-white">
            <Globe className="w-4 h-4 mr-2" /> {t("admin_spatial_tab_brochures", "Broşürler")}
          </TabsTrigger>
        </TabsList>

        <TabsContent value="overview" className="space-y-6">
          <div className="flex items-center gap-4">
            <div className="relative flex-1 max-w-md">
              <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
              <Input placeholder={t("admin_spatial_search", "Mülk kimliğine göre ara...")} className="bg-card border-border pl-10 text-foreground" value={searchTerm} onChange={(e) => setSearchTerm(e.target.value)} />
            </div>
          </div>
          <Card className="bg-card border-border overflow-hidden">
            <CardContent className="p-0">
              <div className="overflow-x-auto">
                <Table>
                  <TableHeader className="bg-card border-b border-border">
                    <TableRow className="hover:bg-transparent border-none">
                      <TableHead className="text-xs font-medium text-muted-foreground py-4 px-6">{t("admin_spatial_prop_id", "Mülk")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_spatial_health_score", "Sağlık Skoru")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_spatial_structural", "Yapısal")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_spatial_cosmetic", "Kozmetik")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_spatial_defects", "Kusurlar")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_spatial_repair", "Onarım Maliyeti")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_spatial_delta", "Delta")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_spatial_date", "Tarih")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {reportsLoading ? (
                      <TableRow><TableCell colSpan={8} className="text-center py-8 text-muted-foreground">{t("common.loading", "Yükleniyor")}</TableCell></TableRow>
                    ) : filtered.length === 0 ? (
                      <TableRow><TableCell colSpan={8} className="text-center py-8 text-muted-foreground">{t("admin_spatial_no_reports", "Sağlık raporu bulunamadı")}</TableCell></TableRow>
                    ) : filtered.map((report) => (
                      <TableRow key={report.id} className="border-b border-border hover:bg-card transition-colors">
                        <TableCell className="py-4 px-6">
                          <span className="text-sm font-mono text-foreground">{report.propertyId.slice(0, 12)}...</span>
                        </TableCell>
                        <TableCell className="px-6">
                          <div className="flex items-center gap-3">
                            <Progress value={report.overallScore} className="w-20 h-2" />
                            <span className={cn("text-sm font-bold", report.overallScore >= 80 ? "text-success" : report.overallScore >= 50 ? "text-warning" : "text-red-400")}>
                              {report.overallScore}
                            </span>
                          </div>
                        </TableCell>
                        <TableCell className="px-6 text-sm text-foreground">{report.structuralIntegrity}/100</TableCell>
                        <TableCell className="px-6 text-sm text-foreground">{report.cosmeticCondition}/100</TableCell>
                        <TableCell className="px-6">
                          <Badge className={cn("border-0", report.criticalDefects > 0 ? "bg-red-500/20 text-red-400" : report.totalDefects > 0 ? "bg-amber-500/20 text-warning" : "bg-blue-500/20 text-success")}>
                            {report.totalDefects} {report.criticalDefects > 0 ? `(${report.criticalDefects}!)` : ""}
                          </Badge>
                        </TableCell>
                        <TableCell className="px-6 text-sm font-bold text-foreground">${report.estimatedRepairCost.toLocaleString()}</TableCell>
                        <TableCell className="px-6">
                          {report.conditionDelta !== undefined ? (
                            <Badge className={cn("border-0", report.conditionDelta >= 0 ? "bg-blue-500/20 text-success" : "bg-red-500/20 text-red-400")}>
                              {report.conditionDelta >= 0 ? "+" : ""}{report.conditionDelta}
                            </Badge>
                          ) : <span className="text-muted-foreground">—</span>}
                        </TableCell>
                        <TableCell className="px-6 text-sm text-muted-foreground">{new Date(report.generatedAt).toLocaleDateString()}</TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </div>
            </CardContent>
          </Card>

          {reports.length > 0 && reports[0].rooms && (
            <Card className="bg-card border-border">
              <CardHeader>
                <CardTitle className="text-foreground flex items-center gap-2">
                  <Layers className="w-5 h-5 text-violet-400" />
                  {t("admin_spatial_room_breakdown", "Oda Düzeyi Analiz")}
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                  {reports[0].rooms.map((room) => (
                    <div key={room.id} className="p-4 bg-card rounded-xl border border-border hover:border-violet-500/30 transition-colors">
                      <div className="flex items-center gap-3 mb-3">
                        <span className="text-2xl">{ROOM_TYPE_ICONS[room.roomType] || "🏠"}</span>
                        <div>
                          <h4 className="text-sm font-semibold text-foreground">{room.name}</h4>
                          <p className="text-xs text-muted-foreground">{room.roomType.replace("_", " ")} — {room.areaSqm}m²</p>
                        </div>
                      </div>
                      <div className="space-y-2">
                        <div className="flex justify-between text-xs">
                          <span className="text-muted-foreground">{t("admin_spatial_condition", "Durum")}</span>
                          <span className="font-bold text-foreground">{room.conditionScore}/100</span>
                        </div>
                        <Progress value={room.conditionScore} className="h-1.5" />
                        <div className="flex justify-between text-xs">
                          <span className="text-muted-foreground">{t("admin_spatial_light", "Aydınlatma")}</span>
                          <span className="font-bold text-foreground">{room.lightScore}/100</span>
                        </div>
                        {room.defects.length > 0 && (
                          <div className="flex flex-wrap gap-1 mt-2">
                            {room.defects.map((d, di) => {
                              const cfg = SEVERITY_CONFIG[d.severity] || SEVERITY_CONFIG.LOW;
                              return (
                                <Badge key={di} className={cn("border-0 text-[10px]", cfg.class)}>{d.type.replace("_", " ")}</Badge>
                              );
                            })}
                          </div>
                        )}
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          )}
        </TabsContent>

        <TabsContent value="insurance" className="space-y-6">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            <Card className="bg-card border-border md:col-span-2">
              <CardHeader>
                <CardTitle className="text-foreground flex items-center gap-2">
                  <ShieldCheck className="w-5 h-5 text-success" />
                  {t("admin_spatial_insurance_products", "Mevcut Sigorta Ürünleri")}
                </CardTitle>
              </CardHeader>
              <CardContent className="p-0">
                <Table>
                  <TableHeader className="bg-card border-b border-border">
                    <TableRow className="hover:bg-transparent border-none">
                      <TableHead className="text-xs font-medium text-muted-foreground py-4 px-6">{t("admin_spatial_product", "Ürün")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_spatial_provider", "Sağlayıcı")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_spatial_coverage", "Teminat")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_spatial_premium", "Yıllık Prim")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_spatial_for", "İçin")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_spatial_action", "İşlem")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {products.length === 0 ? (
                      <TableRow><TableCell colSpan={6} className="text-center py-8 text-muted-foreground">{t("admin_spatial_no_products", "Sigorta ürünü yapılandırılmamış")}</TableCell></TableRow>
                    ) : products.map((product) => (
                      <TableRow key={product.id} className="border-b border-border hover:bg-card transition-colors">
                        <TableCell className="py-4 px-6">
                          <div className="flex items-center gap-2">
                            <ShieldCheck className="w-4 h-4 text-success" />
                            <div>
                              <span className="text-sm font-medium text-foreground">{product.name}</span>
                              <p className="text-xs text-muted-foreground">{product.type.replace("_", " ")}</p>
                            </div>
                          </div>
                        </TableCell>
                        <TableCell className="px-6 text-sm text-foreground">{product.provider}</TableCell>
                        <TableCell className="px-6 text-sm font-bold text-foreground">${product.coverageAmount.toLocaleString()}</TableCell>
                        <TableCell className="px-6 text-sm text-foreground">${product.annualPremium.toLocaleString()}</TableCell>
                        <TableCell className="px-6">
                          <div className="flex gap-1">
                            {(product.suitableFor || []).map((f) => (
                              <Badge key={f} className="border-0 bg-violet-500/20 text-violet-400 text-[10px]">{f}</Badge>
                            ))}
                          </div>
                        </TableCell>
                        <TableCell className="px-6">
                          <Button
                            size="sm"
                            variant="outline"
                            className="bg-card border-border text-foreground hover:bg-violet-600 hover:text-white"
                            onClick={() => {
                              if (selectedPropertyId) {
                                attachInsuranceMutation.mutate({
                                  propertyId: selectedPropertyId,
                                  productId: product.id,
                                  holderType: "OWNER",
                                });
                              } else {
                                toast({ title: "Select a property first", variant: "destructive" });
                              }
                            }}
                          >
                            <Lock className="w-3 h-3 mr-1" />
                            {t("admin_spatial_attach", "Ekle")}
                          </Button>
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </CardContent>
            </Card>

            <Card className="bg-card border-border">
              <CardHeader>
                <CardTitle className="text-foreground flex items-center gap-2">
                  <Lock className="w-5 h-5 text-warning" />
                  {t("admin_spatial_active_policies", "Aktif Poliçeler")}
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                {attachments.length === 0 ? (
                  <p className="text-sm text-muted-foreground text-center py-8">{t("admin_spatial_no_policies", "Henüz sigorta poliçesi eklenmemiş")}</p>
                ) : attachments.map((att) => (
                  <div key={att.id} className="p-3 bg-card rounded-lg border border-border">
                    <div className="flex items-center justify-between mb-1">
                      <span className="text-sm font-medium text-foreground">{att.productName}</span>
                      <Badge className="border-0 bg-blue-500/20 text-success text-[10px]">{att.status}</Badge>
                    </div>
                    <p className="text-xs text-muted-foreground">{att.holderType} — {new Date(att.attachedAt).toLocaleDateString()}</p>
                  </div>
                ))}
              </CardContent>
            </Card>
          </div>
        </TabsContent>

        <TabsContent value="staging" className="space-y-6">
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground flex items-center gap-2">
                <Paintbrush className="w-5 h-5 text-pink-400" />
                {t("admin_spatial_virtual_staging", "Yapay Zeka Sanal Sahneleme Motoru")}
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                {[
                  { style: "MODERN_MINIMALIST", label: "Modern Minimalist", market: "Western / CIS", color: "from-slate-500 to-slate-700" },
                  { style: "EAST_ASIAN_LUXURY", label: "East Asian Luxury", market: "Baidu / Naver", color: "from-red-500 to-rose-700" },
                  { style: "MENA_FUSION", label: "MENA High-End Fusion", market: "Gulf Market", color: "from-amber-500 to-amber-700" },
                ].map((s) => (
                  <div key={s.style} className={cn("rounded-xl p-6 bg-gradient-to-br text-white", s.color)}>
                    <h3 className="text-lg font-bold mb-1">{s.label}</h3>
                    <p className="text-sm opacity-80 mb-4">{t("admin_spatial_target_market", "Hedef Pazar")}: {s.market}</p>
                    <div className="space-y-2 text-sm">
                      <div className="flex justify-between"><span className="opacity-70">{t("admin_spatial_style", "Stil")}</span><span>{s.style.replace("_", " ")}</span></div>
                      <div className="flex justify-between"><span className="opacity-70">{t("admin_spatial_impact", "Tahmini Fiyat Etkisi")}</span><span>+8-15%</span></div>
                      <div className="flex justify-between"><span className="opacity-70">{t("admin_spatial_tom", "Piyasada Geçen Süre")}</span><span>-12 {t("admin_common_days", "gün")}</span></div>
                    </div>
                    <Button className="w-full mt-4 bg-card/20 hover:bg-card/30 text-white border-0" size="sm">
                      <Paintbrush className="w-3 h-3 mr-1" /> {t("admin_spatial_apply_staging", "Sahnelemeyi Uygula")}
                    </Button>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="brochures" className="space-y-6">
          <div className="flex justify-between items-center">
            <h3 className="text-lg font-semibold text-foreground">{t("admin_spatial_brochure_engine", "Otomatik Broşür ve Landing Page Motoru")}</h3>
            <Button
              className="gap-2 bg-violet-600 hover:bg-violet-700 text-white"
              onClick={() => generateBrochureMutation.mutate({
                propertyId: selectedPropertyId || "prop_demo",
                languages: ["EN", "ZH", "KO", "AR", "RU"],
                demographicTarget: "EAST_ASIAN",
              })}
              disabled={generateBrochureMutation.isPending}
            >
              <Globe className="w-4 h-4" />
              {t("admin_spatial_generate_brochure", "Çok Dilli Broşür Oluştur")}
            </Button>
          </div>
          <Card className="bg-card border-border overflow-hidden">
            <CardContent className="p-0">
              <Table>
                <TableHeader className="bg-card border-b border-border">
                  <TableRow className="hover:bg-transparent border-none">
                    <TableHead className="text-xs font-medium text-muted-foreground py-4 px-6">{t("admin_spatial_property", "Mülk")}</TableHead>
                    <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_spatial_language", "Dil")}</TableHead>
                    <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_spatial_title_col", "Başlık")}</TableHead>
                    <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_spatial_status", "Durum")}</TableHead>
                    <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_spatial_generated", "Oluşturuldu")}</TableHead>
                    <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_spatial_action", "İşlem")}</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {brochures.length === 0 ? (
                    <TableRow><TableCell colSpan={6} className="text-center py-8 text-muted-foreground">{t("admin_spatial_no_brochures", "Henüz broşür oluşturulmamış")}</TableCell></TableRow>
                  ) : brochures.map((b) => (
                    <TableRow key={b.id} className="border-b border-border hover:bg-card transition-colors">
                      <TableCell className="py-4 px-6 text-sm font-mono text-foreground">{b.propertyId.slice(0, 12)}...</TableCell>
                      <TableCell className="px-6"><Badge className="border-0 bg-violet-500/20 text-violet-400">{b.language}</Badge></TableCell>
                      <TableCell className="px-6 text-sm text-foreground">{b.title}</TableCell>
                      <TableCell className="px-6">
                        <Badge className={cn("border-0", b.status === "READY" ? "bg-blue-500/20 text-success" : "bg-amber-500/20 text-warning")}>
                          {b.status}
                        </Badge>
                      </TableCell>
                      <TableCell className="px-6 text-sm text-muted-foreground">{new Date(b.generatedAt).toLocaleDateString()}</TableCell>
                      <TableCell className="px-6">
                        <Button size="sm" variant="outline" className="bg-card border-border text-foreground">
                          <FileText className="w-3 h-3 mr-1" /> PDF
                        </Button>
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
