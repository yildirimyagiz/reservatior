"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { 
  Activity, 
  Clock, 
  CheckCircle, 
  XCircle, 
  AlertTriangle, 
  Filter, 
  Search, 
  Download,
  Play,
  Pause,
  ArrowUpRight,
  Zap,
  Terminal
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";

interface ActivityLog {
  id: string;
  timestamp: Date;
  type: 'user_action' | 'system_event' | 'error' | 'security' | 'performance';
  severity: 'low' | 'medium' | 'high' | 'critical';
  category: string;
  action: string;
  details: string;
  userName?: string;
  status: 'pending' | 'running' | 'completed' | 'failed' | 'cancelled';
}

const mockLogs: ActivityLog[] = [
  {
    id: "1",
    timestamp: new Date(Date.now() - 1000 * 60 * 5),
    type: "user_action",
    severity: "low",
    category: "Authentication",
    action: "User Login",
    details: "User admin@reservatior.com logged in successfully",
    userName: "Admin User",
    status: "completed"
  },
  {
    id: "2",
    timestamp: new Date(Date.now() - 1000 * 60 * 10),
    type: "system_event",
    severity: "medium",
    category: "Property",
    action: "Property Updated",
    details: "Property ID: 12345 updated with new pricing",
    userName: "System",
    status: "completed"
  },
  {
    id: "3",
    timestamp: new Date(Date.now() - 1000 * 60 * 15),
    type: "security",
    severity: "high",
    category: "Security",
    action: "Failed Login Attempt",
    details: "Multiple failed login attempts detected from IP 192.168.1.1",
    userName: "Unknown",
    status: "failed"
  },
  {
    id: "4",
    timestamp: new Date(Date.now() - 1000 * 60 * 20),
    type: "performance",
    severity: "low",
    category: "Performance",
    action: "API Response Time",
    details: "API response time exceeded threshold (500ms)",
    userName: "System",
    status: "completed"
  },
  {
    id: "5",
    timestamp: new Date(Date.now() - 1000 * 60 * 25),
    type: "error",
    severity: "critical",
    category: "Database",
    action: "Connection Error",
    details: "Database connection timeout",
    userName: "System",
    status: "failed"
  }
];

const TYPE_COLORS: Record<string, string> = {
  user_action: "bg-blue-500/20 text-blue-400",
  system_event: "bg-purple-500/20 text-purple-400",
  error: "bg-red-500/20 text-red-400",
  security: "bg-orange-500/20 text-orange-400",
  performance: "bg-green-500/20 text-green-400"
};

const STATUS_ICONS: Record<string, React.ComponentType<{ className?: string }>> = {
  completed: CheckCircle,
  failed: XCircle,
  running: Play,
  pending: Clock,
  cancelled: XCircle
};

export default function ActivityTrackingPage() {
    const { t } = useTranslation();
  const router = useRouter();
  const [isLive, setIsLive] = useState(true);
  const [searchTerm, setSearchTerm] = useState("");

  const filteredLogs = mockLogs.filter(log => 
    log.action.toLowerCase().includes(searchTerm.toLowerCase()) ||
    log.details.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const stats = {
    total: mockLogs.length,
    critical: mockLogs.filter(l => l.severity === 'critical').length,
    completed: mockLogs.filter(l => l.status === 'completed').length,
    throughput: 412
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">{t("activity_tracking.activitytrackingpage.auto_ext_1")}</h1>
              <p className="text-gray-400">{t("activity_tracking.activitytrackingpage.auto_ext_2")}</p>
            </div>
            <div className="flex gap-3">
              <Button
                onClick={() => router.push('/dashboard')}
                className="bg-purple-600 hover:bg-purple-700"
              >
                <ArrowUpRight className="w-4 h-4 mr-2" />
                {t("activity_tracking.activitytrackingpage.auto_ext_3")}
                                            </Button>
              <Button
                variant={isLive ? "default" : "outline"}
                className={isLive ? "bg-green-600 hover:bg-green-700" : "bg-white/10 border-purple-500/30 text-white"}
                onClick={() => setIsLive(!isLive)}
              >
                {isLive ? <Pause className="w-4 h-4 mr-2" /> : <Play className="w-4 h-4 mr-2" />}
                {isLive ? "Live" : "Paused"}
              </Button>
            </div>
          </div>
        </motion.div>

        {/* Stats */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.1 }}
          >
            <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <CardContent className="p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <div className="text-sm text-gray-400 mb-1">{t("activity_tracking.activitytrackingpage.auto_ext_4")}</div>
                    <div className="text-2xl font-bold text-white">{stats.total}</div>
                  </div>
                  <div className="p-3 rounded-lg bg-blue-500/10">
                    <Activity className="w-6 h-6 text-blue-400" />
                  </div>
                </div>
              </CardContent>
            </Card>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.2 }}
          >
            <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <CardContent className="p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <div className="text-sm text-gray-400 mb-1">{t("activity_tracking.activitytrackingpage.auto_ext_5")}</div>
                    <div className="text-2xl font-bold text-red-400">{stats.critical}</div>
                  </div>
                  <div className="p-3 rounded-lg bg-red-500/10">
                    <AlertTriangle className="w-6 h-6 text-red-400" />
                  </div>
                </div>
              </CardContent>
            </Card>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.3 }}
          >
            <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <CardContent className="p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <div className="text-sm text-gray-400 mb-1">{t("activity_tracking.activitytrackingpage.auto_ext_6")}</div>
                    <div className="text-2xl font-bold text-green-400">{stats.completed}</div>
                  </div>
                  <div className="p-3 rounded-lg bg-green-500/10">
                    <CheckCircle className="w-6 h-6 text-green-400" />
                  </div>
                </div>
              </CardContent>
            </Card>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.4 }}
          >
            <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <CardContent className="p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <div className="text-sm text-gray-400 mb-1">{t("activity_tracking.activitytrackingpage.auto_ext_7")}</div>
                    <div className="text-2xl font-bold text-purple-400">{stats.throughput}{t("activity_tracking.activitytrackingpage.auto_ext_8")}</div>
                  </div>
                  <div className="p-3 rounded-lg bg-purple-500/10">
                    <Zap className="w-6 h-6 text-purple-400" />
                  </div>
                </div>
              </CardContent>
            </Card>
          </motion.div>
        </div>

        {/* Toolbar */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.5 }}
          className="mb-6"
        >
          <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
            <CardContent className="p-4">
              <div className="flex gap-4">
                <div className="flex-1">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
                    <Input
                      placeholder="Search logs..."
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/10 border-purple-500/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Button variant="outline" className="bg-white/10 border-purple-500/30 text-white">
                  <Filter className="w-4 h-4 mr-2" />
                  {t("activity_tracking.activitytrackingpage.auto_ext_9")}
                                                  </Button>
                <Button variant="outline" className="bg-white/10 border-purple-500/30 text-white">
                  <Download className="w-4 h-4 mr-2" />
                  {t("activity_tracking.activitytrackingpage.auto_ext_10")}
                                                  </Button>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        {/* Logs */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.6 }}
        >
          <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
            <CardHeader>
              <CardTitle className="text-white flex items-center gap-2">
                <Terminal className="w-5 h-5" />
                {t("activity_tracking.activitytrackingpage.auto_ext_11")}
                                            </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                {filteredLogs.map((log) => {
                    const { t } = useTranslation();
                  const StatusIcon = STATUS_ICONS[log.status];
                  return (
                    <div
                      key={log.id}
                      className="flex items-start gap-4 p-4 bg-white/5 rounded-lg hover:bg-white/10 transition-colors"
                    >
                      <div className="p-2 rounded-lg bg-purple-500/20">
                        <StatusIcon className="w-4 h-4 text-purple-400" />
                      </div>
                      <div className="flex-1">
                        <div className="flex items-center gap-3 mb-1">
                          <span className="text-white font-medium">{log.action}</span>
                          <Badge className={TYPE_COLORS[log.type]}>{log.type}</Badge>
                          <Badge variant="outline" className="border-purple-500/30 text-purple-300">{log.severity}</Badge>
                        </div>
                        <p className="text-gray-400 text-sm">{log.details}</p>
                        <div className="flex items-center gap-4 mt-2 text-xs text-gray-500">
                          <span>{log.category}</span>
                          <span>•</span>
                          <span>{log.userName}</span>
                          <span>•</span>
                          <span>{log.timestamp.toLocaleString()}</span>
                        </div>
                      </div>
                    </div>
                  );
                })}
              </div>
            </CardContent>
          </Card>
        </motion.div>
      </div>
    </div>
  );
}
