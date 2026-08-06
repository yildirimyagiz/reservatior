"use client";

import { useTranslation } from "react-i18next";
import { Users, Building2, Shield, Key, Smartphone, CheckCircle, Clock, AlertCircle, Settings, Lock } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { m } from "framer-motion";

const ORGANIZATIONS = [
  { id: 1, name: "Reservatior Inc.", type: "property_management", users: 45, status: "active" },
  { id: 2, name: "Smith Realty", type: "agency", users: 12, status: "active" },
  { id: 3, name: "Global Investments", type: "investment_firm", users: 8, status: "active" },
];

const ROLES = [
  { id: 1, name: "Admin", permissions: ["*"], users: 5 },
  { id: 2, name: "Agent", permissions: ["listing.read", "listing.write", "deal.read", "deal.write"], users: 28 },
  { id: 3, name: "Viewer", permissions: ["listing.read", "deal.read"], users: 32 },
];

const API_KEYS = [
  { id: 1, name: "Production API Key", user: "john@example.com", lastUsed: "2024-01-15 10:30", status: "active" },
  { id: 2, name: "Test API Key", user: "jane@example.com", lastUsed: "2024-01-14 15:45", status: "active" },
  { id: 3, name: "Legacy Key", user: "bob@example.com", lastUsed: "2024-01-10 09:00", status: "expired" },
];

const SESSIONS = [
  { id: 1, user: "john@example.com", device: "Chrome / macOS", ip: "192.168.1.100", status: "active" },
  { id: 2, user: "jane@example.com", device: "Safari / iOS", ip: "192.168.1.101", status: "active" },
  { id: 3, user: "bob@example.com", device: "Firefox / Windows", ip: "192.168.1.102", status: "expired" },
];

export default function AdminIdentityOSDashboard() {
  const { t } = useTranslation();

  const kpis = [
    { title: t("identity_os.total_organizations", "Toplam Kuruluş"), value: 156, icon: Building2, color: "text-success", trend: t("identity_os.trend_this_month", "+12 bu ay") },
    { title: t("identity_os.total_users", "identity os.total users"), value: 1247, icon: Users, color: "text-info", trend: t("identity_os.trend_this_week", "+45 bu hafta") },
    { title: t("identity_os.active_sessions", "identity os.active sessions"), value: 342, icon: Smartphone, color: "text-brand", trend: t("identity_os.trend_currently_active", "Şu anda aktif") },
    { title: t("identity_os.api_keys_kpi", "API Anahtarları"), value: 89, icon: Key, color: "text-warning", trend: t("identity_os.trend_new_this_month", "+5 bu ay yeni") },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-foreground">{t("identity_os.title", "Kimlik OS")}</h1>
          <p className="text-muted-foreground mt-1">{t("identity_os.subtitle", "identity os.subtitle")}</p>
        </div>
        <Button className="bg-primary text-primary-foreground hover:bg-primary/90">
          <Users className="h-4 w-4 mr-2" />
          {t("identity_os.add_user", "Kullanıcı Ekle")}
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

      <Tabs defaultValue="organizations" className="space-y-4">
        <TabsList className="bg-card border-border">
          <TabsTrigger value="organizations">{t("identity_os.tabs.organizations", "Kuruluşlar")}</TabsTrigger>
          <TabsTrigger value="roles">{t("identity_os.tabs.roles", "Roller")}</TabsTrigger>
          <TabsTrigger value="api-keys">{t("identity_os.tabs.api_keys", "API Anahtarları")}</TabsTrigger>
          <TabsTrigger value="sessions">{t("identity_os.tabs.sessions", "Oturumlar")}</TabsTrigger>
        </TabsList>

        <TabsContent value="organizations" className="space-y-4">
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("identity_os.organizations", "Kuruluşlar")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("identity_os.organizations_desc", "Kuruluşları ve ayarlarını yönetin")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {ORGANIZATIONS.map((org) => (
                  <div key={org.id} className="flex items-center justify-between p-4 rounded-lg bg-muted/50 border border-border">
                    <div className="flex items-center gap-3">
                      <Building2 className="h-5 w-5 text-muted-foreground" />
                      <div>
                        <p className="text-sm font-medium text-foreground">{org.name}</p>
                        <p className="text-xs text-muted-foreground">{org.type} • {org.users} {t("identity_os.users", "kullanıcı")}</p>
                      </div>
                    </div>
                    <Badge variant={org.status === 'active' ? 'default' : 'secondary'} className="text-xs">
                      {org.status}
                    </Badge>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="roles">
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("identity_os.roles", "Roller ve İzinler")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("identity_os.roles_desc", "Rolleri ve izinlerini yönetin")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {ROLES.map((role) => (
                  <div key={role.id} className="flex items-center justify-between p-4 rounded-lg bg-muted/50 border border-border">
                    <div className="flex items-center gap-3">
                      <Shield className="h-5 w-5 text-muted-foreground" />
                      <div>
                        <p className="text-sm font-medium text-foreground">{role.name}</p>
                        <p className="text-xs text-muted-foreground">{role.permissions.length} {t("identity_os.permissions", "izin")} • {role.users} {t("identity_os.users", "kullanıcı")}</p>
                      </div>
                    </div>
                    <Button variant="outline" size="sm">{t("identity_os.edit", "Düzenle")}</Button>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="api-keys">
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("identity_os.api_keys", "identity os.api keys")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("identity_os.api_keys_desc", "Harici erişim için API anahtarlarını yönetin")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {API_KEYS.map((key) => (
                  <div key={key.id} className="flex items-center justify-between p-4 rounded-lg bg-muted/50 border border-border">
                    <div className="flex items-center gap-3">
                      <Key className="h-5 w-5 text-muted-foreground" />
                      <div>
                        <p className="text-sm font-medium text-foreground">{key.name}</p>
                        <p className="text-xs text-muted-foreground">{key.user} • {t("identity_os.last_used", "Son kullanım:")} {key.lastUsed}</p>
                      </div>
                    </div>
                    <Badge variant={key.status === 'active' ? 'default' : 'secondary'} className="text-xs">
                      {key.status}
                    </Badge>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="sessions">
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("identity_os.sessions", "Aktif Oturumlar")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("identity_os.sessions_desc", "Kullanıcı oturumlarını izleyin ve yönetin")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {SESSIONS.map((session) => (
                  <div key={session.id} className="flex items-center justify-between p-4 rounded-lg bg-muted/50 border border-border">
                    <div className="flex items-center gap-3">
                      <Smartphone className="h-5 w-5 text-muted-foreground" />
                      <div>
                        <p className="text-sm font-medium text-foreground">{session.user}</p>
                        <p className="text-xs text-muted-foreground">{session.device} • {session.ip}</p>
                      </div>
                    </div>
                    <Badge variant={session.status === 'active' ? 'default' : 'secondary'} className="text-xs">
                      {session.status}
                    </Badge>
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
