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
  Bell
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";

export default function AdminPage() {
    const { t } = useTranslation();
  const router = useRouter();
  const [activeTab, setActiveTab] = useState("overview");

  const stats = [
    { label: "Total Users", value: "2,847", change: "+12%", icon: Users, color: "text-slate-400" },
    { label: "Active Properties", value: "1,234", change: "+8%", icon: Building2, color: "text-slate-400" },
    { label: "Revenue", value: "$1.2M", change: "+23%", icon: DollarSign, color: "text-green-400" },
    { label: "System Health", value: "98.5%", change: "+2%", icon: Activity, color: "text-emerald-400" },
  ];

  const recentAlerts = [
    { id: "1", type: "warning", message: "High server load detected", time: "2 min ago" },
    { id: "2", type: "error", message: "Payment gateway timeout", time: "15 min ago" },
    { id: "3", type: "success", message: "Database backup completed", time: "1 hour ago" },
  ];

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-slate-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">{t("admin.main.title")}</h1>
              <p className="text-gray-400">{t("admin.main.description")}</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-slate-600 hover:bg-slate-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin.main.view_site")}
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
              <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
                <CardContent className="p-6">
                  <div className="flex items-center justify-between">
                    <div>
                      <div className="text-sm text-gray-400 mb-1">{stat.label}</div>
                      <div className="text-2xl font-bold text-white">{stat.value}</div>
                      <div className="text-green-400 text-sm mt-1">{stat.change}</div>
                    </div>
                    <div className="p-3 rounded-lg bg-slate-500/10">
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
          <TabsList className="bg-white/5 border-slate-500/20">
            <TabsTrigger value="overview" className="data-[state=active]:bg-slate-600">{t("admin.main.tab_overview")}</TabsTrigger>
            <TabsTrigger value="users" className="data-[state=active]:bg-slate-600">{t("admin.main.tab_users")}</TabsTrigger>
            <TabsTrigger value="triggers" className="data-[state=active]:bg-slate-600">{t("admin.main.tab_triggers")}</TabsTrigger>
            <TabsTrigger value="system" className="data-[state=active]:bg-slate-600">{t("admin.main.tab_system")}</TabsTrigger>
          </TabsList>

          <TabsContent value="overview">
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              {/* Recent Alerts */}
              <motion.div
                initial={{ opacity: 0, x: -20 }}
                animate={{ opacity: 1, x: 0 }}
              >
                <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
                  <CardHeader>
                    <CardTitle className="text-white flex items-center gap-2">
                      <Bell className="w-5 h-5" />
                      {t("admin.main.recent_alerts")}
                                                              </CardTitle>
                  </CardHeader>
                  <CardContent>
                    <div className="space-y-3">
                      {recentAlerts.map((alert) => (
                        <div
                          key={alert.id}
                          className="flex items-start gap-3 p-3 bg-white/5 rounded-lg"
                        >
                          {alert.type === "warning" && <AlertTriangle className="w-5 h-5 text-yellow-400" />}
                          {alert.type === "error" && <AlertTriangle className="w-5 h-5 text-red-400" />}
                          {alert.type === "success" && <CheckCircle className="w-5 h-5 text-green-400" />}
                          <div className="flex-1">
                            <div className="text-white text-sm">{alert.message}</div>
                            <div className="text-gray-400 text-xs mt-1">{alert.time}</div>
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
                <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
                  <CardHeader>
                    <CardTitle className="text-white">{t("admin.main.quick_actions")}</CardTitle>
                  </CardHeader>
                  <CardContent>
                    <div className="grid grid-cols-2 gap-4">
                      <Button
                        variant="outline"
                        className="bg-white/10 border-slate-500/30 text-white hover:bg-white/20"
                        onClick={() => router.push('/automation')}
                      >
                        <Zap className="w-4 h-4 mr-2" />
                        {t("admin.main.manage_automations")}
                                                                    </Button>
                      <Button
                        variant="outline"
                        className="bg-white/10 border-slate-500/30 text-white hover:bg-white/20"
                      >
                        <Users className="w-4 h-4 mr-2" />
                        {t("admin.main.manage_users")}
                                                                    </Button>
                      <Button
                        variant="outline"
                        className="bg-white/10 border-slate-500/30 text-white hover:bg-white/20"
                      >
                        <Database className="w-4 h-4 mr-2" />
                        {t("admin.main.backup_data")}
                                                                    </Button>
                      <Button
                        variant="outline"
                        className="bg-white/10 border-slate-500/30 text-white hover:bg-white/20"
                      >
                        <Settings className="w-4 h-4 mr-2" />
                        {t("admin.main.system_config")}
                                                                    </Button>
                    </div>
                  </CardContent>
                </Card>
              </motion.div>
            </div>
          </TabsContent>

          <TabsContent value="users">
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
            >
              <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
                <CardHeader>
                  <CardTitle className="text-white">{t("admin.main.users_section_title")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="text-center py-12 text-gray-400">
                    <Users className="w-12 h-12 mx-auto mb-4 text-slate-400" />
                    <p>{t("admin.main.users_placeholder")}</p>
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
              <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
                <CardHeader>
                  <CardTitle className="text-white">{t("admin.main.triggers_section_title")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="flex items-center justify-between mb-4">
                    <p className="text-gray-400">{t("admin.main.triggers_description")}</p>
                    <Button
                      onClick={() => router.push('/automation')}
                      className="bg-slate-600 hover:bg-slate-700"
                    >
                      <Zap className="w-4 h-4 mr-2" />
                      {t("admin.main.create_trigger")}
                                                              </Button>
                  </div>
                  <div className="text-center py-8 text-gray-400">
                    <Zap className="w-12 h-12 mx-auto mb-4 text-slate-400" />
                    <p>{t("admin.main.triggers_placeholder")}</p>
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
              <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
                <CardHeader>
                  <CardTitle className="text-white">{t("admin.main.system_section_title")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    <div className="flex items-center justify-between p-4 bg-white/5 rounded-lg">
                      <div className="flex items-center gap-3">
                        <Globe className="w-5 h-5 text-slate-400" />
                        <div>
                          <div className="text-white">{t("admin.main.system_domain")}</div>
                          <div className="text-gray-400 text-sm">{t("admin.main.system_domain_desc")}</div>
                        </div>
                      </div>
                      <Button variant="outline" size="sm">{t("admin.main.manage")}</Button>
                    </div>
                    <div className="flex items-center justify-between p-4 bg-white/5 rounded-lg">
                      <div className="flex items-center gap-3">
                        <Lock className="w-5 h-5 text-green-400" />
                        <div>
                          <div className="text-white">{t("admin.main.system_security")}</div>
                          <div className="text-gray-400 text-sm">{t("admin.main.system_security_desc")}</div>
                        </div>
                      </div>
                      <Button variant="outline" size="sm">{t("admin.main.manage")}</Button>
                    </div>
                    <div className="flex items-center justify-between p-4 bg-white/5 rounded-lg">
                      <div className="flex items-center gap-3">
                        <Database className="w-5 h-5 text-slate-400" />
                        <div>
                          <div className="text-white">{t("admin.main.system_database")}</div>
                          <div className="text-gray-400 text-sm">{t("admin.main.system_database_desc")}</div>
                        </div>
                      </div>
                      <Button variant="outline" size="sm">{t("admin.main.manage")}</Button>
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
