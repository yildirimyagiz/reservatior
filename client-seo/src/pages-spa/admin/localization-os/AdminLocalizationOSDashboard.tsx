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
    { title: "Active Countries", value: 24, icon: Globe, color: "text-emerald-500", trend: "+2 this month" },
    { title: "Supported Languages", value: 8, icon: Languages, color: "text-blue-400", trend: "+1 new this quarter" },
    { title: "Currencies", value: 12, icon: DollarSign, color: "text-purple-400", trend: "All active" },
    { title: "Translation Rate", value: "78%", icon: CheckCircle, color: "text-orange-400", trend: "+5% improvement" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-slate-100">Localization OS Management</h1>
          <p className="text-slate-400 mt-1">Multi-country support and localization</p>
        </div>
        <Button className="bg-indigo-600 hover:bg-indigo-700">
          <Globe className="h-4 w-4 mr-2" />
          Add Country
        </Button>
      </div>

      {/* KPIs */}
      <div className="grid gap-4 md:grid-cols-4">
        {kpis.map((kpi, i) => (
          <m.div key={kpi.title} initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: i * 0.07 }}>
            <Card className="bg-slate-900/60 border-slate-800">
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-slate-400">{kpi.title}</CardTitle>
                <kpi.icon className={`h-4 w-4 ${kpi.color}`} />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-slate-100">{kpi.value}</div>
                <p className="text-xs text-slate-500 mt-1">{kpi.trend}</p>
              </CardContent>
            </Card>
          </m.div>
        ))}
      </div>

      <Tabs defaultValue="countries" className="space-y-4">
        <TabsList className="bg-slate-900/60 border-slate-800">
          <TabsTrigger value="countries">Countries</TabsTrigger>
          <TabsTrigger value="languages">Languages</TabsTrigger>
          <TabsTrigger value="currencies">Currencies</TabsTrigger>
          <TabsTrigger value="translations">Translations</TabsTrigger>
        </TabsList>

        <TabsContent value="countries" className="space-y-4">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Country Configurations</CardTitle>
              <CardDescription className="text-slate-400">
                Manage country-specific settings
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {COUNTRIES.map((country) => (
                  <div key={country.id} className="flex items-center justify-between p-4 rounded-lg bg-slate-800/50 border border-slate-700">
                    <div className="flex items-center gap-3">
                      <Globe className="h-5 w-5 text-slate-400" />
                      <div>
                        <p className="text-sm font-medium text-slate-200">{country.name}</p>
                        <p className="text-xs text-slate-500">{country.code} • {country.currency} • {country.languages.join(", ")}</p>
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
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Language Support</CardTitle>
              <CardDescription className="text-slate-400">
                Translation completion status
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {LANGUAGES.map((lang) => (
                  <div key={lang.id} className="flex items-center justify-between p-4 rounded-lg bg-slate-800/50 border border-slate-700">
                    <div className="flex items-center gap-3">
                      <Languages className="h-5 w-5 text-slate-400" />
                      <div>
                        <p className="text-sm font-medium text-slate-200">{lang.name}</p>
                        <p className="text-xs text-slate-500">{lang.code} • {lang.completion}% complete</p>
                      </div>
                    </div>
                    <div className="flex items-center gap-2">
                      <div className="w-24 h-2 bg-slate-700 rounded-full overflow-hidden">
                        <div className="h-full bg-emerald-500" style={{ width: `${lang.completion}%` }} />
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
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Currency Exchange Rates</CardTitle>
              <CardDescription className="text-slate-400">
                Manage currency configurations and rates
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {CURRENCIES.map((currency) => (
                  <div key={currency.id} className="flex items-center justify-between p-4 rounded-lg bg-slate-800/50 border border-slate-700">
                    <div className="flex items-center gap-3">
                      <DollarSign className="h-5 w-5 text-slate-400" />
                      <div>
                        <p className="text-sm font-medium text-slate-200">{currency.name}</p>
                        <p className="text-xs text-slate-500">{currency.code} • Rate: {currency.rate}</p>
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
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Translation Keys</CardTitle>
              <CardDescription className="text-slate-400">
                Manage translation content
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {TRANSLATIONS.map((trans) => (
                  <div key={trans.id} className="p-4 rounded-lg bg-slate-800/50 border border-slate-700">
                    <div className="flex items-start justify-between mb-2">
                      <p className="text-sm font-medium text-slate-200">{trans.key}</p>
                      <Badge variant={trans.status === 'complete' ? 'default' : 'secondary'} className="text-xs">
                        {trans.status}
                      </Badge>
                    </div>
                    <div className="grid grid-cols-3 gap-2 text-xs">
                      <div>
                        <span className="text-slate-500">EN:</span>
                        <p className="text-slate-300">{trans.en}</p>
                      </div>
                      <div>
                        <span className="text-slate-500">TR:</span>
                        <p className="text-slate-300">{trans.tr}</p>
                      </div>
                      <div>
                        <span className="text-slate-500">DE:</span>
                        <p className="text-slate-300">{trans.de}</p>
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
