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
  Network,
  Copy,
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
  Handshake,
  Key
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";

export default function AdminPage() {
    const { t } = useTranslation();
  const router = useRouter();
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

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <motion.div
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
        </motion.div>

        {/* Stats */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
          {stats.map((stat, index) => (
            <motion.div
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
            </motion.div>
          ))}
        </div>

        {/* Tabs */}
        <Tabs value={activeTab} onValueChange={setActiveTab} className="space-y-6">
          <TabsList className="bg-muted/30 border-border">
            <TabsTrigger value="overview" className="data-[state=active]:bg-primary">{t("admin_main_tab_overview")}</TabsTrigger>
            <TabsTrigger value="os-modules" className="data-[state=active]:bg-primary">OS Modules</TabsTrigger>
            <TabsTrigger value="users" className="data-[state=active]:bg-primary">{t("admin_main_tab_users")}</TabsTrigger>
            <TabsTrigger value="triggers" className="data-[state=active]:bg-primary">{t("admin_main_tab_triggers")}</TabsTrigger>
            <TabsTrigger value="system" className="data-[state=active]:bg-primary">{t("admin_main_tab_system")}</TabsTrigger>
          </TabsList>

          <TabsContent value="overview">
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              {/* Recent Alerts */}
              <motion.div
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
              </motion.div>

              {/* Quick Actions */}
              <motion.div
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
              </motion.div>
            </div>
          </TabsContent>

          <TabsContent value="os-modules">
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
            >
              <Card className="bg-card border-border">
                <CardHeader>
                  <CardTitle className="text-foreground">OS Modules</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                    <Button
                      variant="outline"
                      className="bg-muted/30 border-border text-foreground hover:bg-muted/50 h-auto p-4 flex flex-col items-start"
                      onClick={() => router.push('/admin/booking-os')}
                    >
                      <Calendar className="w-6 h-6 mb-2 text-blue-400" />
                      <div className="text-left">
                        <div className="font-semibold">Booking OS</div>
                        <div className="text-xs text-muted-foreground">Manage bookings and reservations</div>
                      </div>
                    </Button>
                    <Button
                      variant="outline"
                      className="bg-muted/30 border-border text-foreground hover:bg-muted/50 h-auto p-4 flex flex-col items-start"
                      onClick={() => router.push('/admin/finance-os')}
                    >
                      <DollarSign className="w-6 h-6 mb-2 text-green-400" />
                      <div className="text-left">
                        <div className="font-semibold">Finance OS</div>
                        <div className="text-xs text-muted-foreground">Financial operations and commissions</div>
                      </div>
                    </Button>
                    <Button
                      variant="outline"
                      className="bg-muted/30 border-border text-foreground hover:bg-muted/50 h-auto p-4 flex flex-col items-start"
                      onClick={() => router.push('/admin/listing-os')}
                    >
                      <Building2 className="w-6 h-6 mb-2 text-purple-400" />
                      <div className="text-left">
                        <div className="font-semibold">Listing OS</div>
                        <div className="text-xs text-muted-foreground">Property listings management</div>
                      </div>
                    </Button>
                    <Button
                      variant="outline"
                      className="bg-muted/30 border-border text-foreground hover:bg-muted/50 h-auto p-4 flex flex-col items-start"
                      onClick={() => router.push('/admin/identity-os')}
                    >
                      <Users className="w-6 h-6 mb-2 text-indigo-400" />
                      <div className="text-left">
                        <div className="font-semibold">Identity OS</div>
                        <div className="text-xs text-muted-foreground">User and organization management</div>
                      </div>
                    </Button>
                    <Button
                      variant="outline"
                      className="bg-muted/30 border-border text-foreground hover:bg-muted/50 h-auto p-4 flex flex-col items-start"
                      onClick={() => router.push('/admin/agent-os')}
                    >
                      <Activity className="w-6 h-6 mb-2 text-orange-400" />
                      <div className="text-left">
                        <div className="font-semibold">Agent OS</div>
                        <div className="text-xs text-muted-foreground">Agent performance and management</div>
                      </div>
                    </Button>
                    <Button
                      variant="outline"
                      className="bg-muted/30 border-border text-foreground hover:bg-muted/50 h-auto p-4 flex flex-col items-start"
                      onClick={() => router.push('/admin/document-os')}
                    >
                      <FileText className="w-6 h-6 mb-2 text-pink-400" />
                      <div className="text-left">
                        <div className="font-semibold">Document OS</div>
                        <div className="text-xs text-muted-foreground">Document and signature management</div>
                      </div>
                    </Button>
                    <Button
                      variant="outline"
                      className="bg-muted/30 border-border text-foreground hover:bg-muted/50 h-auto p-4 flex flex-col items-start"
                      onClick={() => router.push('/admin/analytics-os')}
                    >
                      <BarChart3 className="w-6 h-6 mb-2 text-cyan-400" />
                      <div className="text-left">
                        <div className="font-semibold">Analytics OS</div>
                        <div className="text-xs text-muted-foreground">Data analytics and insights</div>
                      </div>
                    </Button>
                    <Button
                      variant="outline"
                      className="bg-muted/30 border-border text-foreground hover:bg-muted/50 h-auto p-4 flex flex-col items-start"
                      onClick={() => router.push('/admin/notification-os')}
                    >
                      <Bell className="w-6 h-6 mb-2 text-yellow-400" />
                      <div className="text-left">
                        <div className="font-semibold">Notification OS</div>
                        <div className="text-xs text-muted-foreground">Notification and communication</div>
                      </div>
                    </Button>
                    <Button
                      variant="outline"
                      className="bg-muted/30 border-border text-foreground hover:bg-muted/50 h-auto p-4 flex flex-col items-start"
                      onClick={() => router.push('/admin/localization-os')}
                    >
                      <Globe className="w-6 h-6 mb-2 text-emerald-400" />
                      <div className="text-left">
                        <div className="font-semibold">Localization OS</div>
                        <div className="text-xs text-muted-foreground">Multi-country and language support</div>
                      </div>
                    </Button>
                    <Button
                      variant="outline"
                      className="bg-muted/30 border-border text-foreground hover:bg-muted/50 h-auto p-4 flex flex-col items-start"
                      onClick={() => router.push('/admin/intelligence-graph')}
                    >
                      <Network className="w-6 h-6 mb-2 text-violet-400" />
                      <div className="text-left">
                        <div className="font-semibold">Intelligence Graph</div>
                        <div className="text-xs text-muted-foreground">Graph analytics and ML predictions</div>
                      </div>
                    </Button>
                    <Button
                      variant="outline"
                      className="bg-muted/30 border-border text-foreground hover:bg-muted/50 h-auto p-4 flex flex-col items-start"
                      onClick={() => router.push('/admin/digital-twin')}
                    >
                      <Copy className="w-6 h-6 mb-2 text-rose-400" />
                      <div className="text-left">
                        <div className="font-semibold">Digital Twin</div>
                        <div className="text-xs text-muted-foreground">Simulation and optimization</div>
                      </div>
                    </Button>
                    <Button
                      variant="outline"
                      className="bg-muted/30 border-border text-foreground hover:bg-muted/50 h-auto p-4 flex flex-col items-start"
                      onClick={() => router.push('/admin/ai-os')}
                    >
                      <Brain className="w-6 h-6 mb-2 text-violet-400" />
                      <div className="text-left">
                        <div className="font-semibold">AI OS</div>
                        <div className="text-xs text-muted-foreground">AI models and predictions</div>
                      </div>
                    </Button>
                    <Button
                      variant="outline"
                      className="bg-muted/30 border-border text-foreground hover:bg-muted/50 h-auto p-4 flex flex-col items-start"
                      onClick={() => router.push('/admin/user-os')}
                    >
                      <Users className="w-6 h-6 mb-2 text-blue-400" />
                      <div className="text-left">
                        <div className="font-semibold">User OS</div>
                        <div className="text-xs text-muted-foreground">User lifecycle management</div>
                      </div>
                    </Button>
                    <Button
                      variant="outline"
                      className="bg-muted/30 border-border text-foreground hover:bg-muted/50 h-auto p-4 flex flex-col items-start"
                      onClick={() => router.push('/admin/trust-os')}
                    >
                      <Shield className="w-6 h-6 mb-2 text-emerald-400" />
                      <div className="text-left">
                        <div className="font-semibold">Trust OS</div>
                        <div className="text-xs text-muted-foreground">Trust scores and verification</div>
                      </div>
                    </Button>
                    <Button
                      variant="outline"
                      className="bg-muted/30 border-border text-foreground hover:bg-muted/50 h-auto p-4 flex flex-col items-start"
                      onClick={() => router.push('/admin/ads-os')}
                    >
                      <Megaphone className="w-6 h-6 mb-2 text-orange-400" />
                      <div className="text-left">
                        <div className="font-semibold">Ads OS</div>
                        <div className="text-xs text-muted-foreground">Advertising campaigns</div>
                      </div>
                    </Button>
                    <Button
                      variant="outline"
                      className="bg-muted/30 border-border text-foreground hover:bg-muted/50 h-auto p-4 flex flex-col items-start"
                      onClick={() => router.push('/admin/commerce-os')}
                    >
                      <ShoppingCart className="w-6 h-6 mb-2 text-pink-400" />
                      <div className="text-left">
                        <div className="font-semibold">Commerce OS</div>
                        <div className="text-xs text-muted-foreground">Products and orders</div>
                      </div>
                    </Button>
                    <Button
                      variant="outline"
                      className="bg-muted/30 border-border text-foreground hover:bg-muted/50 h-auto p-4 flex flex-col items-start"
                      onClick={() => router.push('/admin/operations-os')}
                    >
                      <CheckSquare className="w-6 h-6 mb-2 text-cyan-400" />
                      <div className="text-left">
                        <div className="font-semibold">Operations OS</div>
                        <div className="text-xs text-muted-foreground">Tasks and workflows</div>
                      </div>
                    </Button>
                    <Button
                      variant="outline"
                      className="bg-muted/30 border-border text-foreground hover:bg-muted/50 h-auto p-4 flex flex-col items-start"
                      onClick={() => router.push('/admin/crm-os')}
                    >
                      <Target className="w-6 h-6 mb-2 text-indigo-400" />
                      <div className="text-left">
                        <div className="font-semibold">CRM OS</div>
                        <div className="text-xs text-muted-foreground">Leads and opportunities</div>
                      </div>
                    </Button>
                    <Button
                      variant="outline"
                      className="bg-muted/30 border-border text-foreground hover:bg-muted/50 h-auto p-4 flex flex-col items-start"
                      onClick={() => router.push('/admin/investment-os')}
                    >
                      <TrendingUp className="w-6 h-6 mb-2 text-green-400" />
                      <div className="text-left">
                        <div className="font-semibold">Investment OS</div>
                        <div className="text-xs text-muted-foreground">Investments and returns</div>
                      </div>
                    </Button>
                    <Button
                      variant="outline"
                      className="bg-muted/30 border-border text-foreground hover:bg-muted/50 h-auto p-4 flex flex-col items-start"
                      onClick={() => router.push('/admin/governance-os')}
                    >
                      <FileText className="w-6 h-6 mb-2 text-amber-400" />
                      <div className="text-left">
                        <div className="font-semibold">Governance OS</div>
                        <div className="text-xs text-muted-foreground">Policies and compliance</div>
                      </div>
                    </Button>
                    <Button
                      variant="outline"
                      className="bg-muted/30 border-border text-foreground hover:bg-muted/50 h-auto p-4 flex flex-col items-start"
                      onClick={() => router.push('/admin/partner-os')}
                    >
                      <Handshake className="w-6 h-6 mb-2 text-teal-400" />
                      <div className="text-left">
                        <div className="font-semibold">Partner OS</div>
                        <div className="text-xs text-muted-foreground">Partner relationships</div>
                      </div>
                    </Button>
                    <Button
                      variant="outline"
                      className="bg-muted/30 border-border text-foreground hover:bg-muted/50 h-auto p-4 flex flex-col items-start"
                      onClick={() => router.push('/admin/devapi-os')}
                    >
                      <Key className="w-6 h-6 mb-2 text-slate-400" />
                      <div className="text-left">
                        <div className="font-semibold">Developer API OS</div>
                        <div className="text-xs text-muted-foreground">API keys and usage</div>
                      </div>
                    </Button>
                    <Button
                      variant="outline"
                      className="bg-muted/30 border-border text-foreground hover:bg-muted/50 h-auto p-4 flex flex-col items-start"
                      onClick={() => router.push('/admin/security-os')}
                    >
                      <AlertTriangle className="w-6 h-6 mb-2 text-red-400" />
                      <div className="text-left">
                        <div className="font-semibold">Security OS</div>
                        <div className="text-xs text-muted-foreground">Security and incidents</div>
                      </div>
                    </Button>
                  </div>
                </CardContent>
              </Card>
            </motion.div>
          </TabsContent>

          <TabsContent value="users">
            <motion.div
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
            </motion.div>
          </TabsContent>

          <TabsContent value="triggers">
            <motion.div
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
            </motion.div>
          </TabsContent>

          <TabsContent value="system">
            <motion.div
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
            </motion.div>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}
