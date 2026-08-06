"use client";

import { useTranslation } from "react-i18next";
import { Home, Activity, CheckCircle, Eye, TrendingUp, Globe, Radio, AlertTriangle, Settings, Upload } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { m } from "framer-motion";

const HEALTH_STREAM = [
  { id: "h1", property: "Marina Residences #4B", event: "Cleaning inspection PASSED", score: 98, time: "2m ago", ok: true },
  { id: "h2", property: "Harbour View Penthouse", event: "Digital Health Record updated", score: 96, time: "11m ago", ok: true },
  { id: "h3", property: "Westside Studio Unit 12", event: "Maintenance work order CLOSED", score: 91, time: "34m ago", ok: true },
  { id: "h4", property: "Riverside Loft Block A", event: "HVAC compliance check PENDING", score: 74, time: "1h ago", ok: false },
  { id: "h5", property: "Skyline Tower 8F", event: "Safety certificate renewed", score: 100, time: "2h ago", ok: true },
];

const SYNDICATION = [
  { channel: "Airbnb", status: "LIVE", listings: 24, icon: "🏠", color: "text-rose-400" },
  { channel: "Booking.com", status: "LIVE", listings: 19, icon: "🌍", color: "text-info" },
  { channel: "MLS Network", status: "LIVE", listings: 31, icon: "🔗", color: "text-brand" },
  { channel: "Vrbo", status: "SYNCING", listings: 14, icon: "🏡", color: "text-yellow-400" },
  { channel: "Google Homes", status: "LIVE", listings: 9, icon: "🔍", color: "text-blue-400" },
];

export default function AdminListingOSDashboard() {
  const { t } = useTranslation();

  const kpis = [
    { title: t("listing_os.total_properties", "Toplam Mülk"), value: 47, icon: Home, color: "text-success", trend: t("listing_os.trend_this_month", "+4 bu ay") },
    { title: t("listing_os.active_listings", "Aktif İlanlar"), value: 38, icon: Activity, color: "text-info", trend: t("listing_os.trend_live_portals", "Portallarda canlı") },
    { title: t("listing_os.avg_health_score", "Ortalama Sağlık Puanı"), value: "94%", icon: CheckCircle, color: "text-brand", trend: t("listing_os.trend_quality_compliance", "Kalite uyumu") },
    { title: t("listing_os.network_views", "Ağ Görüntülemeleri"), value: "12,480", icon: Eye, color: "text-warning", trend: t("listing_os.trend_vs_prev", "+18,3% geçen döneme göre") },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-foreground">{t("listing_os.title", "İlan OS")}</h1>
          <p className="text-muted-foreground mt-1">{t("listing_os.subtitle", "Dijital Sağlık Kaydı · Varlık Zekası · Sendikasyon Motoru")}</p>
        </div>
        <Button className="bg-primary text-primary-foreground hover:bg-primary/90">
          <Upload className="h-4 w-4 mr-2" />
          {t("listing_os.import_listing", "İlan İçe Aktar")}
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

      <Tabs defaultValue="overview" className="space-y-4">
        <TabsList className="bg-card border-border">
          <TabsTrigger value="overview">{t("listing_os.tabs.overview", "Genel Bakış")}</TabsTrigger>
          <TabsTrigger value="listings">{t("listing_os.tabs.listings", "İlanlar")}</TabsTrigger>
          <TabsTrigger value="syndication">{t("listing_os.tabs.syndication", "Dağıtım")}</TabsTrigger>
          <TabsTrigger value="health">{t("listing_os.tabs.health", "Sağlık")}</TabsTrigger>
        </TabsList>

        <TabsContent value="overview" className="space-y-4">
          <div className="grid gap-4 md:grid-cols-2">
            {/* Digital Health Record Stream */}
            <Card className="bg-card border-border">
              <CardHeader>
                <CardTitle className="text-foreground flex items-center gap-2">
                  <Radio className="h-4 w-4 text-success animate-pulse" />
                  {t("listing_os.health_stream", "Sağlık Akışı")}
                </CardTitle>
                <CardDescription className="text-muted-foreground">
                  {t("listing_os.health_stream_desc", "Gerçek zamanlı ilan sağlık metrikleri")}
                </CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-3">
                  {HEALTH_STREAM.map((item, i) => (
                    <m.div
                      key={item.id}
                      initial={{ opacity: 0, x: -8 }}
                      animate={{ opacity: 1, x: 0 }}
                      transition={{ delay: i * 0.05 }}
                      className={`flex items-start gap-3 p-3 rounded-lg border-l-2 bg-muted/50 ${item.ok ? "border-blue-500" : "border-yellow-500"}`}
                    >
                      <div className={`mt-0.5 text-xs font-bold px-2 py-1 rounded-full ${item.ok ? "bg-blue-500/15 text-success" : "bg-yellow-500/15 text-yellow-400"}`}>
                        {item.score}
                      </div>
                      <div className="flex-1 min-w-0">
                        <p className="text-sm font-medium text-foreground truncate">{item.property}</p>
                        <p className="text-xs text-muted-foreground">{item.event}</p>
                      </div>
                      <span className="text-xs text-muted-foreground whitespace-nowrap">{item.time}</span>
                    </m.div>
                  ))}
                </div>
              </CardContent>
            </Card>

            {/* Platform Syndication Stats */}
            <Card className="bg-card border-border">
              <CardHeader>
                <CardTitle className="text-foreground flex items-center gap-2">
                  <Globe className="h-4 w-4 text-info" />
                  {t("listing_os.syndication", "İlan Dağıtımı")}
                </CardTitle>
                <CardDescription className="text-muted-foreground">
                  {t("listing_os.syndication_desc", "Çoklu platform ilan yönetimi")}
                </CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {SYNDICATION.map((ch, i) => (
                    <m.div 
                      key={ch.channel}
                      initial={{ opacity: 0, x: 20 }}
                      animate={{ opacity: 1, x: 0 }}
                      transition={{ delay: i * 0.1 }}
                      className="flex items-center justify-between p-3 rounded-lg border border-border bg-muted/20"
                    >
                      <div className="flex items-center gap-3">
                        <span className="text-xl">{ch.icon}</span>
                        <div>
                          <p className="text-sm font-medium text-foreground">{ch.channel}</p>
                          <p className="text-xs text-muted-foreground">{ch.listings} {t("admin_listing_os_active_listings_lower", "aktif ilan")}</p>
                        </div>
                      </div>
                      <div className={`text-xs font-bold px-2 py-1 rounded-full ${
                        ch.status === "LIVE" ? "bg-blue-500/10 text-success" : "bg-yellow-500/10 text-yellow-400"
                      }`}>
                        {ch.status}
                      </div>
                    </m.div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </div>
        </TabsContent>

        <TabsContent value="listings">
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("listing_os.listings", "İlan Yönetimi")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("listing_os.listings_desc", "Tüm mülk ilanlarını yönetin ve güncelleyin")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-muted-foreground">
                <Home className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>{t("listing_os.listings_placeholder", "İlan yönetim arayüzü")}</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="syndication">
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("listing_os.syndication_config", "Dağıtım Yapılandırması")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("listing_os.syndication_config_desc", "Platform dağıtım ayarlarını yapılandırın")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-muted-foreground">
                <Globe className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>{t("listing_os.syndication_placeholder", "Dağıtım yönetim arayüzü")}</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="health">
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("listing_os.health_monitoring", "Sağlık Takibi")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("listing_os.health_monitoring_desc", "İlan sağlık durumu izleme ve uyarılar")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-muted-foreground">
                <CheckCircle className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>{t("listing_os.health_monitoring_placeholder", "Sağlık takip arayüzü")}</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
