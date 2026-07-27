"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { 
  Users, 
  Building2, 
  DollarSign, 
  Settings, 
  Activity,
  Zap,
  AlertTriangle,
  CheckCircle,
  ArrowUpRight,
  Database,
  Globe,
  Lock,
  Bell,
  Calendar,
  FileText,
  BarChart3,
  Brain,
  Shield,
  Megaphone,
  ShoppingCart,
  CheckSquare,
  Target,
  TrendingUp,
  HeartHandshake,
  Key
} from "lucide-react";
import { m } from "framer-motion";
import { useTranslation } from "react-i18next";
import { useAuth } from "@/contexts/AuthContext";
import { hasPermission, canAccessOSModule } from "@/lib/auth/role-based-routing";

export default function AdminPage() {
    const { t } = useTranslation();
  const router = useRouter();
  const { user } = useAuth();
  const [activeTab, setActiveTab] = useState("overview");

  const stats = [
    { label: "Total Users", value: "2,847", change: "+12%", icon: Users, color: "text-muted-foreground" },
    { label: "Active Properties", value: "1,234", change: "+8%", icon: Building2, color: "text-muted-foreground" },
    { label: "Revenue", value: "$1.2M", change: "+23%", icon: DollarSign, color: "text-green-400" },
    { label: "System Health", value: "98.5%", change: "+2%", icon: Activity, color: "text-emerald-400" },
  ];

  const recentAlerts = [
    { id: "1", type: "warning", message: "High server load detected", time: "2 min ago" },
    { id: "2", type: "error", message: "Payment gateway timeout", time: "15 min ago" },
    { id: "3", type: "success", message: "Database backup completed", time: "1 hour ago" },
  ];

  const osModules = [
    { name: "Booking OS", path: "/admin/booking-os", icon: Calendar, color: "text-blue-400", desc: "Manage bookings and reservations", module: "booking-os" },
    { name: "Finance OS", path: "/admin/finance-os", icon: DollarSign, color: "text-green-400", desc: "Financial operations and commissions", module: "finance-os" },
    { name: "Listing OS", path: "/admin/listing-os", icon: Building2, color: "text-purple-400", desc: "Property listings management", module: "listing-os" },
    { name: "Identity OS", path: "/admin/identity-os", icon: Users, color: "text-indigo-400", desc: "User and organization management", module: "identity-os" },
    { name: "Agent OS", path: "/admin/agent-os", icon: Activity, color: "text-orange-400", desc: "Agent performance and management", module: "agent-os" },
    { name: "Document OS", path: "/admin/document-os", icon: FileText, color: "text-pink-400", desc: "Document and signature management", module: "document-os" },
    { name: "Analytics OS", path: "/admin/analytics-os", icon: BarChart3, color: "text-cyan-400", desc: "Data analytics and insights", module: "analytics-os" },
    { name: "Notification OS", path: "/admin/notification-os", icon: Bell, color: "text-yellow-400", desc: "Notification and communication", module: "notification-os" },
    { name: "Localization OS", path: "/admin/localization-os", icon: Globe, color: "text-emerald-400", desc: "Multi-country and language support", module: "localization-os" },
    { name: "AI OS", path: "/admin/ai-os", icon: Brain, color: "text-violet-400", desc: "AI models and predictions", module: "ai-os" },
    { name: "User OS", path: "/admin/user-os", icon: Users, color: "text-blue-400", desc: "User lifecycle management", module: "user-os" },
    { name: "Trust OS", path: "/admin/trust-os", icon: Shield, color: "text-emerald-400", desc: "Trust scores and verification", module: "trust-os" },
    { name: "Ads OS", path: "/admin/ads-os", icon: Megaphone, color: "text-orange-400", desc: "Advertising campaigns", module: "ads-os" },
    { name: "Commerce OS", path: "/admin/commerce-os", icon: ShoppingCart, color: "text-pink-400", desc: "Products and orders", module: "commerce-os" },
    { name: "Operations OS", path: "/admin/operations-os", icon: CheckSquare, color: "text-cyan-400", desc: "Tasks and workflows", module: "operations-os" },
    { name: "CRM OS", path: "/admin/crm-os", icon: Target, color: "text-indigo-400", desc: "Leads and opportunities", module: "crm-os" },
    { name: "Investment OS", path: "/admin/investment-os", icon: TrendingUp, color: "text-green-400", desc: "Investments and returns", module: "investment-os" },
    { name: "Governance OS", path: "/admin/governance-os", icon: FileText, color: "text-amber-400", desc: "Policies and compliance", module: "governance-os" },
    { name: "Partner OS", path: "/admin/partner-os", icon: HeartHandshake, color: "text-teal-400", desc: "Partner relationships", module: "partner-os" },
    { name: "Developer API OS", path: "/admin/devapi-os", icon: Key, color: "text-slate-400", desc: "API keys and usage", module: "devapi-os" },
    { name: "Security OS", path: "/admin/security-os", icon: AlertTriangle, color: "text-red-400", desc: "Security and incidents", module: "security-os" },
  ];

  const accessibleOSModules = osModules.filter(os => canAccessOSModule(user, os.module));

  const canViewUsers = hasPermission(user, "view:users") || user?.roles?.includes("OWNER") || user?.roles?.includes("ORG_ADMIN") || user?.roles?.includes("AGENCY_ADMIN");
  const canViewTriggers = hasPermission(user, "view:triggers") || user?.roles?.includes("OWNER") || user?.roles?.includes("ORG_ADMIN");
  const canViewSystem = hasPermission(user, "view:system") || user?.roles?.includes("OWNER") || user?.roles?.includes("ORG_ADMIN") || user?.roles?.includes("MAINTENANCE");

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <m.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-foreground mb-2">{t("admin_main_title")}</h1>
              <p className="text-muted-foreground">{t("admin_main_description")}</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-primary hover:bg-primary/90"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin_main_view_site")}
                                      </Button>
          </div>
        </m.div>

        {/* Stats */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
          {stats.map((stat, index) => (
            <m.div
              key={stat.label}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.1 }}
            >
              <Card className="bg-card border-border">
                <CardContent className="p-6">
                  <div className="flex items-center justify-between">
                    <div>
                      <div className="text-sm text-muted-foreground mb-1">{stat.label}</div>
                      <div className="text-2xl font-bold text-foreground">{stat.value}</div>
                      <div className="text-green-400 text-sm mt-1">{stat.change}</div>
                    </div>
                    <div className="p-3 rounded-lg bg-muted/30">
                      <stat.icon className={`w-6 h-6 ${stat.color}`} />
                    </div>
                  </div>
                </CardContent>
              </Card>
            </m.div>
          ))}
        </div>

        {/* Tabs */}
        <Tabs value={activeTab} onValueChange={setActiveTab} className="space-y-6">
          <TabsList className="bg-muted/30 border-border">
            <TabsTrigger value="overview" className="data-[state=active]:bg-primary">{t("admin_main_tab_overview")}</TabsTrigger>
            <TabsTrigger value="os-modules" className="data-[state=active]:bg-primary">OS Modules</TabsTrigger>
            {canViewUsers && <TabsTrigger value="users" className="data-[state=active]:bg-primary">{t("admin_main_tab_users")}</TabsTrigger>}
            {canViewTriggers && <TabsTrigger value="triggers" className="data-[state=active]:bg-primary">{t("admin_main_tab_triggers")}</TabsTrigger>}
            {canViewSystem && <TabsTrigger value="system" className="data-[state=active]:bg-primary">{t("admin_main_tab_system")}</TabsTrigger>}
          </TabsList>

          <TabsContent value="overview">
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              {/* Recent Alerts */}
              <m.div
                initial={{ opacity: 0, x: -20 }}
                animate={{ opacity: 1, x: 0 }}
              >
                <Card className="bg-card border-border">
                  <CardHeader>
                    <CardTitle className="text-foreground flex items-center gap-2">
                      <Bell className="w-5 h-5" />
                      {t("admin_main_recent_alerts")}
                                                              </CardTitle>
                  </CardHeader>
                  <CardContent>
                    <div className="space-y-3">
                      {recentAlerts.map((alert) => (
                        <div
                          key={alert.id}
                          className="flex items-start gap-3 p-3 bg-muted/30 rounded-lg"
                        >
                          {alert.type === "warning" && <AlertTriangle className="w-5 h-5 text-yellow-400" />}
                          {alert.type === "error" && <AlertTriangle className="w-5 h-5 text-red-400" />}
                          {alert.type === "success" && <CheckCircle className="w-5 h-5 text-green-400" />}
                          <div className="flex-1">
                            <div className="text-foreground text-sm">{alert.message}</div>
                            <div className="text-muted-foreground text-xs mt-1">{alert.time}</div>
                          </div>
                        </div>
                      ))}
                    </div>
                  </CardContent>
                </Card>
              </m.div>

              {/* Quick Actions */}
              <m.div
                initial={{ opacity: 0, x: 20 }}
                animate={{ opacity: 1, x: 0 }}
              >
                <Card className="bg-card border-border">
                  <CardHeader>
                    <CardTitle className="text-foreground">{t("admin_main_quick_actions")}</CardTitle>
                  </CardHeader>
                  <CardContent>
                    <div className="grid grid-cols-2 gap-4">
                      <Button
                        variant="outline"
                        className="bg-muted/30 border-border text-foreground hover:bg-muted/50"
                        onClick={() => router.push('/automation')}
                      >
                        <Zap className="w-4 h-4 mr-2" />
                        {t("admin_main_manage_automations")}
                                                                    </Button>
                      <Button
                        variant="outline"
                        className="bg-muted/30 border-border text-foreground hover:bg-muted/50"
                      >
                        <Users className="w-4 h-4 mr-2" />
                        {t("admin_main_manage_users")}
                                                                    </Button>
                      <Button
                        variant="outline"
                        className="bg-muted/30 border-border text-foreground hover:bg-muted/50"
                      >
                        <Database className="w-4 h-4 mr-2" />
                        {t("admin_main_backup_data")}
                                                                    </Button>
                      <Button
                        variant="outline"
                        className="bg-muted/30 border-border text-foreground hover:bg-muted/50"
                      >
                        <Settings className="w-4 h-4 mr-2" />
                        {t("admin_main_system_config")}
                                                                    </Button>
                    </div>
                  </CardContent>
                </Card>
              </m.div>
            </div>
          </TabsContent>

          <TabsContent value="os-modules">
            <m.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
            >
              <Card className="bg-card border-border">
                <CardHeader>
                  <CardTitle className="text-foreground">OS Modules</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                    {accessibleOSModules.map((os) => (
                      <Button
                        key={os.name}
                        variant="outline"
                        className="bg-muted/30 border-border text-foreground hover:bg-muted/50 h-auto p-4 flex flex-col items-start"
                        onClick={() => router.push(os.path)}
                      >
                        <os.icon className={`w-6 h-6 mb-2 ${os.color}`} />
                        <div className="text-left">
                          <div className="font-semibold">{os.name}</div>
                          <div className="text-xs text-muted-foreground">{os.desc}</div>
                        </div>
                      </Button>
                    ))}
                  </div>
                </CardContent>
              </Card>
            </m.div>
          </TabsContent>

          <TabsContent value="users">
            <m.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
            >
              <Card className="bg-card border-border">
                <CardHeader>
                  <CardTitle className="text-foreground">{t("admin_main_users_section_title")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="text-center py-12 text-muted-foreground">
                    <Users className="w-12 h-12 mx-auto mb-4 text-muted-foreground" />
                    <p>{t("admin_main_users_placeholder")}</p>
                  </div>
                </CardContent>
              </Card>
            </m.div>
          </TabsContent>

          <TabsContent value="triggers">
            <m.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
            >
              <Card className="bg-card border-border">
                <CardHeader>
                  <CardTitle className="text-foreground">{t("admin_main_triggers_section_title")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="flex items-center justify-between mb-4">
                    <p className="text-muted-foreground">{t("admin_main_triggers_description")}</p>
                    <Button
                      onClick={() => router.push('/automation')}
                      className="bg-primary hover:bg-primary/90"
                    >
                      <Zap className="w-4 h-4 mr-2" />
                      {t("admin_main_create_trigger")}
                                                              </Button>
                  </div>
                  <div className="text-center py-8 text-muted-foreground">
                    <Zap className="w-12 h-12 mx-auto mb-4 text-muted-foreground" />
                    <p>{t("admin_main_triggers_placeholder")}</p>
                  </div>
                </CardContent>
              </Card>
            </m.div>
          </TabsContent>

          <TabsContent value="system">
            <m.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
            >
              <Card className="bg-card border-border">
                <CardHeader>
                  <CardTitle className="text-foreground">{t("admin_main_system_section_title")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    <div className="flex items-center justify-between p-4 bg-muted/30 rounded-lg">
                      <div className="flex items-center gap-3">
                        <Globe className="w-5 h-5 text-muted-foreground" />
                        <div>
                          <div className="text-foreground">{t("admin_main_system_domain")}</div>
                          <div className="text-muted-foreground text-sm">{t("admin_main_system_domain_desc")}</div>
                        </div>
                      </div>
                      <Button variant="outline" size="sm">{t("admin_main_manage")}</Button>
                    </div>
                    <div className="flex items-center justify-between p-4 bg-muted/30 rounded-lg">
                      <div className="flex items-center gap-3">
                        <Lock className="w-5 h-5 text-green-400" />
                        <div>
                          <div className="text-foreground">{t("admin_main_system_security")}</div>
                          <div className="text-muted-foreground text-sm">{t("admin_main_system_security_desc")}</div>
                        </div>
                      </div>
                      <Button variant="outline" size="sm">{t("admin_main_manage")}</Button>
                    </div>
                    <div className="flex items-center justify-between p-4 bg-muted/30 rounded-lg">
                      <div className="flex items-center gap-3">
                        <Database className="w-5 h-5 text-muted-foreground" />
                        <div>
                          <div className="text-foreground">{t("admin_main_system_database")}</div>
                          <div className="text-muted-foreground text-sm">{t("admin_main_system_database_desc")}</div>
                        </div>
                      </div>
                      <Button variant="outline" size="sm">{t("admin_main_manage")}</Button>
                    </div>
                  </div>
                </CardContent>
              </Card>
            </m.div>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}
