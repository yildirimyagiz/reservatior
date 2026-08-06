"use client";

import { useTranslation } from "react-i18next";
import { Globe, Languages, DollarSign, Calendar, CheckCircle, Clock, AlertCircle, Settings, TrendingUp } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { m } from "framer-motion";

const COUNTRIES = [
  { id: 1, code: "US", name: "United States", currency: "USD", languages: ["en"], status: "active" },
  { id: 2, code: "GB", name: "United Kingdom", currency: "GBP", languages: ["en"], status: "active" },
  { id: 3, code: "TR", name: "Turkey", currency: "TRY", languages: ["tr", "en"], status: "active" },
  { id: 4, code: "DE", name: "Germany", currency: "EUR", languages: ["de", "en"], status: "active" },
];

const LANGUAGES = [
  { id: 1, code: "en", name: "English", completion: 100, status: "complete" },
  { id: 2, code: "tr", name: "Turkish", completion: 85, status: "in_progress" },
  { id: 3, code: "de", name: "German", completion: 45, status: "in_progress" },
  { id: 4, code: "es", name: "Spanish", completion: 20, status: "in_progress" },
];

const CURRENCIES = [
  { id: 1, code: "USD", name: "US Dollar", rate: 1.0, status: "active" },
  { id: 2, code: "GBP", name: "British Pound", rate: 0.79, status: "active" },
  { id: 3, code: "EUR", name: "Euro", rate: 0.92, status: "active" },
  { id: 4, code: "TRY", name: "Turkish Lira", rate: 32.5, status: "active" },
];

const TRANSLATIONS = [
  { id: 1, key: "common.welcome", en: "Welcome", tr: "Hoş geldiniz", de: "Willkommen", status: "complete" },
  { id: 2, key: "booking.confirm", en: "Confirm Booking", tr: "Rezervasyonu Onayla", de: "Buchung bestätigen", status: "complete" },
  { id: 3, key: "property.details", en: "Property Details", tr: "Mülk Detayları", de: "Immobilien Details", status: "complete" },
];

export default function AdminLocalizationOSDashboard() {
  const { t } = useTranslation();

  const kpis = [
    { title: t("localization_os.active_countries", "Aktif Ülkeler"), value: 24, icon: Globe, color: "text-success", trend: "+2 this month" },
    { title: t("localization_os.supported_languages", "Desteklenen Diller"), value: 8, icon: Languages, color: "text-info", trend: "+1 new this quarter" },
    { title: t("localization_os.currencies", "Para Birimleri"), value: 12, icon: DollarSign, color: "text-brand", trend: "All active" },
    { title: t("localization_os.translation_rate", "Çeviri Oranı"), value: "78%", icon: CheckCircle, color: "text-warning", trend: "+5% improvement" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-foreground">{t("localization_os.title", "Yerelleştirme OS")}</h1>
          <p className="text-muted-foreground mt-1">{t("localization_os.subtitle", "localization os.subtitle")}</p>
        </div>
        <Button className="bg-primary text-primary-foreground hover:bg-primary/90">
          <Globe className="h-4 w-4 mr-2" />
          {t("localization_os.add_country", "Ülke Ekle")}
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

      <Tabs defaultValue="countries" className="space-y-4">
        <TabsList className="bg-card border-border">
          <TabsTrigger value="countries">{t("localization_os.tabs.countries", "Ülkeler")}</TabsTrigger>
          <TabsTrigger value="languages">{t("localization_os.tabs.languages", "Diller")}</TabsTrigger>
          <TabsTrigger value="currencies">{t("localization_os.tabs.currencies", "Para Birimleri")}</TabsTrigger>
          <TabsTrigger value="translations">{t("localization_os.tabs.translations", "Çeviriler")}</TabsTrigger>
        </TabsList>

        <TabsContent value="countries" className="space-y-4">
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("localization_os.countries", "Ülke Yapılandırmaları")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("localization_os.countries_desc", "Ülkeye özel ayarları yönetin")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {COUNTRIES.map((country) => (
                  <div key={country.id} className="flex items-center justify-between p-4 rounded-lg bg-muted/50 border border-border">
                    <div className="flex items-center gap-3">
                      <Globe className="h-5 w-5 text-muted-foreground" />
                      <div>
                        <p className="text-sm font-medium text-foreground">{country.name}</p>
                        <p className="text-xs text-muted-foreground">{country.code} • {country.currency} • {country.languages.join(", ")}</p>
                      </div>
                    </div>
                    <Badge variant={country.status === 'active' ? 'default' : 'secondary'} className="text-xs">
                      {country.status}
                    </Badge>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="languages">
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("localization_os.languages", "Dil Desteği")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("localization_os.languages_desc", "Çeviri tamamlanma durumu")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {LANGUAGES.map((lang) => (
                  <div key={lang.id} className="flex items-center justify-between p-4 rounded-lg bg-muted/50 border border-border">
                    <div className="flex items-center gap-3">
                      <Languages className="h-5 w-5 text-muted-foreground" />
                      <div>
                        <p className="text-sm font-medium text-foreground">{lang.name}</p>
                        <p className="text-xs text-muted-foreground">{lang.code} • {lang.completion}% {t("localization_os.percent_complete", "tamamlandı")}</p>
                      </div>
                    </div>
                    <div className="flex items-center gap-2">
                      <div className="w-24 h-2 bg-muted rounded-full overflow-hidden">
                        <div className="h-full bg-blue-500" style={{ width: `${lang.completion}%` }} />
                      </div>
                      <Badge variant={lang.status === 'complete' ? 'default' : 'secondary'} className="text-xs">
                        {lang.status}
                      </Badge>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="currencies">
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("localization_os.currencies_rates", "Döviz Kurları")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("localization_os.currencies_rates_desc", "Para birimi yapılandırmalarını ve kurları yönetin")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {CURRENCIES.map((currency) => (
                  <div key={currency.id} className="flex items-center justify-between p-4 rounded-lg bg-muted/50 border border-border">
                    <div className="flex items-center gap-3">
                      <DollarSign className="h-5 w-5 text-muted-foreground" />
                      <div>
                        <p className="text-sm font-medium text-foreground">{currency.name}</p>
                        <p className="text-xs text-muted-foreground">{currency.code} • {t("localization_os.rate_label", "Kur:")} {currency.rate}</p>
                      </div>
                    </div>
                    <Badge variant={currency.status === 'active' ? 'default' : 'secondary'} className="text-xs">
                      {currency.status}
                    </Badge>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="translations">
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("localization_os.translation_keys", "Çeviri Anahtarları")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("localization_os.translation_keys_desc", "Çeviri içeriğini yönetin")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {TRANSLATIONS.map((trans) => (
                  <div key={trans.id} className="p-4 rounded-lg bg-muted/50 border border-border">
                    <div className="flex items-start justify-between mb-2">
                      <p className="text-sm font-medium text-foreground">{trans.key}</p>
                      <Badge variant={trans.status === 'complete' ? 'default' : 'secondary'} className="text-xs">
                        {trans.status}
                      </Badge>
                    </div>
                    <div className="grid grid-cols-3 gap-2 text-xs">
                      <div>
                        <span className="text-muted-foreground">{t("localization_os.en_label", "EN:")}</span>
                        <p className="text-muted-foreground">{trans.en}</p>
                      </div>
                      <div>
                        <span className="text-muted-foreground">{t("localization_os.tr_label", "TR:")}</span>
                        <p className="text-muted-foreground">{trans.tr}</p>
                      </div>
                      <div>
                        <span className="text-muted-foreground">{t("localization_os.de_label", "DE:")}</span>
                        <p className="text-muted-foreground">{trans.de}</p>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
