"use client";

import { t } from "i18next";
import { useState, useEffect } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Activity, Clock, CheckCircle, XCircle, AlertTriangle, Filter, Search, Download, Play, Pause, RotateCcw, Zap, ChevronRight, Sparkles, Terminal, Cpu, ShieldCheck } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
import { useTranslation } from "react-i18next";
interface ActivityLog {
  id: string;
  timestamp: Date;
  type: 'user_action' | 'system_event' | 'error' | 'security' | 'performance';
  severity: 'low' | 'medium' | 'high' | 'critical';
  category: string;
  action: string;
  details: string;
  userId?: string;
  userName?: string;
  ipAddress?: string;
  userAgent?: string;
  duration?: number;
  status: 'pending' | 'running' | 'completed' | 'failed' | 'cancelled';
  metadata?: Record<string, any>;
}
interface ActivityFilter {
  type?: string;
  severity?: string;
  status?: string;
  dateRange?: 'today' | 'week' | 'month' | 'all';
  search?: string;
}
export default function ActivityTracking() {
  const {
    t
  } = useTranslation();
  const [logs, setLogs] = useState<ActivityLog[]>([]);
  const [filteredLogs, setFilteredLogs] = useState<ActivityLog[]>([]);
  const [filter, setFilter] = useState<ActivityFilter>({});
  const [isLive, setIsLive] = useState(true);
  const [selectedLog, setSelectedLog] = useState<ActivityLog | null>(null);
  const [mounted, setMounted] = useState(false);
  const [stats, setStats] = useState({
    total: 0,
    critical: 0,
    completed: 0,
    throughput: 412
  });

  // Mock data generation
  const generateMockLogs = (): ActivityLog[] => {
    return [{
      id: "1",
      timestamp: new Date(Date.now() - 1000 * 60 * 5),
      type: "user_action",
      severity: "low",
      category: "Authentication",
      action: "User Login",
      details: "User admin@propos.com logged in successfully",
      userName: "Admin User",
      status: "completed"
    }, {
      id: "2",
      timestamp: new Date(Date.now() - 1000 * 60 * 10),
      type: "system_event",
      severity: "medium",
      category: "Database",
      action: "Database Backup",
      details: "Scheduled database backup completed",
      status: "completed"
    }, {
      id: "3",
      timestamp: new Date(Date.now() - 1000 * 60 * 15),
      type: "error",
      severity: "high",
      category: "API",
      action: "API Rate Limit",
      details: "Rate limit exceeded for user user@example.com",
      userName: "John Doe",
      status: "failed"
    }, {
      id: "4",
      timestamp: new Date(Date.now() - 1000 * 60 * 20),
      type: "security",
      severity: "critical",
      category: "Security",
      action: "Suspicious Login Attempt",
      details: "Multiple failed login attempts from unknown IP region.",
      status: "failed"
    }];
  };
  useEffect(() => {
    setMounted(true);
    const mockLogs = generateMockLogs();
    setLogs(mockLogs);
    setFilteredLogs(mockLogs);
    updateStats(mockLogs);
  }, []);
  const updateStats = (logData: ActivityLog[]) => {
    setStats(prev => ({
      ...prev,
      total: logData.length,
      critical: logData.filter(log => log.severity === 'critical').length,
      completed: logData.filter(log => log.status === 'completed').length
    }));
  };
  useEffect(() => {
    let filtered = [...logs];
    if (filter.search) {
      filtered = filtered.filter(log => log.action.toLowerCase().includes(filter.search!.toLowerCase()) || log.details.toLowerCase().includes(filter.search!.toLowerCase()));
    }
    setFilteredLogs(filtered);
    updateStats(filtered);
  }, [logs, filter]);
  const exportLogs = () => {
    const csv = ['Timestamp,Type,Severity,Category,Action,Details,User,Status', ...filteredLogs.map(log => `${log.timestamp.toISOString()},${log.type},${log.severity},${log.category},"${log.action}","${log.details}",${log.userName || 'N/A'},${log.status}`)].join('\n');
    const blob = new Blob([csv], {
      type: 'text/csv'
    });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `neural-logs-${new Date().toISOString().split('T')[0]}.csv`;
    a.click();
    window.URL.revokeObjectURL(url);
  };
  useEffect(() => {
    if (!isLive) return;
    const interval = setInterval(() => {
      const newLog: ActivityLog = {
        id: Date.now().toString(),
        timestamp: new Date(),
        type: Math.random() > 0.5 ? 'user_action' : 'system_event',
        severity: ['low', 'medium', 'high'][Math.floor(Math.random() * 3)] as any,
        category: ['Auth', 'DB', 'API', 'Perf'][Math.floor(Math.random() * 4)],
        action: 'Neural Pulse Detected',
        details: 'Real-time synchronization cycle completed across 18 nodes.',
        status: 'completed'
      };
      setLogs(prev => [newLog, ...prev].slice(0, 50));
    }, 4000);
    return () => clearInterval(interval);
  }, [isLive]);
  if (!mounted) return null;
  return <div className="min-h-screen bg-[#14151a] p-8 lg:p-12 overflow-x-hidden">
      <div className="max-w-[1600px] mx-auto space-y-12">
        
        {/* Tactical Header HUD */}
        <header className="relative py-12 px-10 rounded-[40px] bg-[#1a1b1e]/40 border border-white/5 border-l border-t overflow-hidden shadow-3xl">
           <div className="absolute top-0 right-0 p-40 opacity-5 pointer-events-none text-emerald-600">
              <Activity className="w-96 h-96" />
           </div>
           <div className="absolute -top-24 -left-24 w-96 h-96 bg-blue-600/10 blur-[120px] rounded-full pointer-events-none"></div>
           
           <div className="relative z-10 flex flex-col md:flex-row items-center justify-between gap-10">
              <div className="flex items-center gap-8">
                 <div className="relative group">
                    <div className="absolute inset-0 bg-emerald-600/20 blur-2xl group-hover:bg-emerald-600/40 transition-all rounded-full animate-pulse-slow"></div>
                    <div className="relative p-6 rounded-3xl bg-gradient-to-br from-emerald-500/20 to-blue-500/20 border border-emerald-500/30 backdrop-blur-xl shadow-2xl">
                       <Terminal className="w-10 h-10 text-emerald-400" />
                    </div>
                 </div>
                 <div className="space-y-2">
                    <div className="flex items-center gap-3">
                       <h1 className="text-5xl font-black text-white italic tracking-tighter leading-none">{t("activityTitle")}</h1>
                       <Badge className={cn("font-black italic tracking-widest text-[10px] px-3 py-1  rounded-full border", isLive ? "bg-emerald-500/10 text-emerald-400 border-emerald-500/20" : "bg-red-500/10 text-red-400 border-red-500/20")}>
                        {isLive ? t("feedActive") : t("feedPaused")}
                       </Badge>
                    </div>
                    <p className="text-lg font-black text-slate-500 italic tracking-widest leading-none mt-2">{t("activitySubtitle")}</p>
                 </div>
              </div>
              
              <div className="flex gap-4">
                 <Button onClick={() => setIsLive(!isLive)} className={cn("h-16 px-10 rounded-2xl font-black  italic text-xs tracking-widest shadow-xl transition-all hover:scale-105 active:scale-95", isLive ? "bg-white text-black hover:bg-slate-200" : "bg-emerald-600 text-white hover:bg-emerald-500")}>
                    {isLive ? <Pause className="w-4 h-4 mr-3" /> : <Play className="w-4 h-4 mr-3" />}
                    {isLive ? t("pause") : t("resume")}
                 </Button>
                 <Button onClick={() => setLogs(generateMockLogs())} variant="outline" className="h-16 w-16 rounded-2xl border-white/5 bg-white/5 text-slate-400 hover:text-white transition-all backdrop-blur-xl">
                    <RotateCcw className="w-6 h-6" />
                 </Button>
              </div>
           </div>
        </header>

        {/* Real-time Metrics Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
           {[{
          label: t("total"),
          value: stats.total,
          icon: Activity,
          color: "text-blue-400",
          bg: "bg-blue-500/10"
        }, {
          label: t("success"),
          value: "99.8%",
          icon: CheckCircle,
          color: "text-emerald-400",
          bg: "bg-emerald-500/10"
        }, {
          label: t("throughput"),
          value: `${stats.throughput} t/s`,
          icon: Zap,
          color: "text-orange-400",
          bg: "bg-orange-500/10"
        }, {
          label: t("activityAlerts"),
          value: stats.critical,
          icon: ShieldCheck,
          color: "text-red-400",
          bg: "bg-red-500/10"
        }].map((stat, idx) => <Card key={idx} className="border-white/5 bg-[#1a1b1e]/60 backdrop-blur-3xl rounded-[32px] overflow-hidden shadow-2xl relative border-l border-t">
                <CardContent className="p-8">
                   <div className="flex justify-between items-start mb-6">
                      <div className={cn("p-4 rounded-2xl bg-black/40 border border-white/5", stat.color)}>
                         <stat.icon className="h-6 w-6" />
                      </div>
                      <Badge className="bg-white/5 text-slate-500 border-none text-[8px] font-black italic tracking-widest">{t("client.src.realtime")}</Badge>
                   </div>
                   <p className="text-[10px] font-black text-slate-500 tracking-widest italic">{stat.label}</p>
                   <h3 className="text-3xl font-black text-white italic tracking-tighter mt-1">{stat.value}</h3>
                </CardContent>
             </Card>)}
        </div>

        <div className="grid lg:grid-cols-12 gap-12 text-white">
           {/* Event Log Node */}
           <div className="lg:col-span-8 space-y-8">
              <div className="flex items-center justify-between px-4">
                 <h2 className="text-xl font-black italic tracking-tighter flex items-center gap-3">
                    <Terminal className="w-5 h-5 text-blue-500" /> {t("feedTitle")}
                 </h2>
                 <div className="relative">
                    <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-600" />
                    <input type="text" placeholder={t("activityFilterplaceholder")} className="bg-[#1a1b1e]/60 border border-white/5 rounded-2xl py-3 pl-12 pr-6 text-[10px] font-black tracking-widest italic text-white placeholder:text-slate-700 focus:outline-none focus:border-blue-500/50 transition-all w-80" onChange={e => setFilter({
                ...filter,
                search: e.target.value
              })} />
                 </div>
              </div>

              <div className="space-y-4">
                <AnimatePresence initial={false}>
                  {filteredLogs.map(log => <motion.div key={log.id} initial={{
                opacity: 0,
                x: -20,
                height: 0
              }} animate={{
                opacity: 1,
                x: 0,
                height: 'auto'
              }} exit={{
                opacity: 0,
                x: 20,
                height: 0
              }} className="p-6 rounded-[32px] bg-[#1a1b1e]/40 border border-white/5 border-l border-t hover:bg-white/5 transition-all cursor-pointer group shadow-xl relative overflow-hidden" onClick={() => setSelectedLog(log)}>
                       <div className="flex items-center gap-8 relative z-10">
                          <div className={cn("h-14 w-14 rounded-2xl flex items-center justify-center border transition-transform group-hover:scale-110", log.severity === 'critical' ? "bg-red-500/10 border-red-500/20 text-red-500" : log.severity === 'high' ? "bg-orange-500/10 border-orange-500/20 text-orange-500" : "bg-blue-500/10 border-blue-500/20 text-blue-400")}>
                             <Zap className="w-6 h-6" />
                          </div>
                          <div className="flex-1 space-y-1">
                             <div className="flex items-center gap-3">
                                <h4 className="text-xl font-black italic tracking-tighter leading-none">{log.action}</h4>
                                <Badge className="bg-black/40 border-white/5 text-slate-500 text-[8px] font-black italic tracking-widest">{log.category}</Badge>
                             </div>
                             <p className="text-[11px] font-bold text-slate-500 tracking-tight italic line-clamp-1">{log.details}</p>
                          </div>
                          <div className="text-right space-y-1">
                             <p className="text-[10px] font-black text-white italic whitespace-nowrap">{log.timestamp.toLocaleTimeString()}</p>
                             <div className="flex justify-end">
                                <ChevronRight className="w-4 h-4 text-slate-800" />
                             </div>
                          </div>
                       </div>
                       {log.severity === 'critical' && <div className="absolute right-0 top-0 bottom-0 w-1 bg-red-600 shadow-[0_0_15px_#ef4444]"></div>}
                    </motion.div>)}
                </AnimatePresence>
              </div>
           </div>

           {/* Tactical Insight Panel */}
           <div className="lg:col-span-4 space-y-12">
              <aside className="sticky top-12 space-y-8">
                 <Card className="bg-[#1a1b1e]/80 backdrop-blur-3xl border-white/5 rounded-[40px] p-10 shadow-3xl border-l border-t">
                    <header className="mb-10 flex items-center justify-between">
                       <h2 className="text-xl font-black text-white italic tracking-tighter leading-none">{t("intelligenceHud")}</h2>
                       <div className="h-8 w-8 rounded-xl bg-white/5 flex items-center justify-center">
                          <Cpu className="w-4 h-4 text-slate-500" />
                       </div>
                    </header>
                    
                    <div className="space-y-10">
                      <div className="p-6 rounded-3xl bg-black/40 border border-white/5 relative overflow-hidden group/alert">
                         <div className="absolute top-0 right-0 p-4 opacity-10">
                            <Sparkles className="w-12 h-12 text-blue-500" />
                         </div>
                         <h4 className="text-[10px] font-black text-blue-400 italic tracking-widest mb-2">{t("patternRecognition")}</h4>
                         <p className="text-xs font-bold text-slate-400 italic leading-relaxed">{t("patternDesc")}</p>
                      </div>

                      <div className="space-y-8">
                         <h3 className="text-xs font-black text-slate-500 tracking-widest italic flex items-center gap-2">
                            <Filter className="w-4 h-4" /> {t("calibration")}
                         </h3>
                         
                         {[{
                    label: t("client.src.memory_sync"),
                    val: "73%",
                    color: "bg-blue-600 shadow-blue-600/50"
                  }, {
                    label: t("client.src.latent_throughput"),
                    val: "88%",
                    color: "bg-emerald-600 shadow-emerald-600/50"
                  }, {
                    label: t("client.src.security_shield"),
                    val: "100%",
                    color: "bg-purple-600 shadow-purple-600/50"
                  }].map((cal, i) => <div key={i} className="space-y-4">
                             <div className="flex justify-between items-center text-[10px] font-black italic tracking-tighter">
                                <span className="text-slate-400">{cal.label}</span>
                                <span className="text-white">{cal.val}</span>
                             </div>
                             <div className="h-1.5 w-full bg-black/40 rounded-full overflow-hidden shadow-inner">
                                <motion.div initial={{
                        width: 0
                      }} animate={{
                        width: cal.val
                      }} className={cn("h-full shadow-[0_0_10px]", cal.color)} />
                             </div>
                           </div>)}
                      </div>
                      
                      <Button onClick={exportLogs} variant="outline" className="w-full h-14 rounded-2xl border-white/5 bg-white/5 text-slate-400 hover:text-white font-black text-[10px] tracking-widest italic transition-all group">
                         {t("exportDossier")} <Download className="w-3 h-3 ml-2" />
                      </Button>
                    </div>
                 </Card>
              </aside>
           </div>
        </div>
      </div>

      {/* Detail Overlay */}
      {selectedLog && <div className="fixed inset-0 bg-black/80 backdrop-blur-md flex items-center justify-center p-8 z-50">
           <motion.div initial={{
        opacity: 0,
        scale: 0.9
      }} animate={{
        opacity: 1,
        scale: 1
      }} className="w-full max-w-2xl bg-[#1a1b1e] border border-white/10 rounded-[40px] overflow-hidden shadow-3xl">
              <div className="p-10 space-y-10">
                 <header className="flex items-center justify-between">
                    <div className="space-y-2">
                       <Badge className="bg-blue-500/10 text-blue-400 border border-blue-500/10 px-4 py-1 text-[9px] font-black italic">{t("analysis")}</Badge>
                       <h2 className="text-4xl font-black text-white italic tracking-tighter">{selectedLog.action}</h2>
                    </div>
                    <Button variant="ghost" onClick={() => setSelectedLog(null)} className="h-12 w-12 rounded-2xl bg-white/5 hover:bg-white/10">
                       <XCircle className="w-6 h-6 text-white" />
                    </Button>
                 </header>

                 <div className="grid grid-cols-2 gap-8 pt-10 border-t border-white/5">
                    <div>
                       <p className="text-[9px] font-black text-slate-500 italic tracking-widest mb-1">{t("timeTrace")}</p>
                       <p className="text-lg font-black text-white italic">{selectedLog.timestamp.toLocaleString()}</p>
                    </div>
                    <div>
                       <p className="text-[9px] font-black text-slate-500 italic tracking-widest mb-1">{t("statusCode")}</p>
                       <p className={cn("text-lg font-black italic", selectedLog.status === 'completed' ? 'text-emerald-400' : 'text-red-400')}>{selectedLog.status}</p>
                    </div>
                 </div>

                 <div className="space-y-4">
                    <p className="text-[9px] font-black text-slate-500 italic tracking-widest">{t("extendedData")}</p>
                    <div className="p-8 rounded-3xl bg-black/40 border border-white/5 font-mono text-[11px] text-emerald-400 leading-relaxed shadow-inner">
                       {selectedLog.details}
                       <br />
                       <span className="text-slate-600 mt-4 block">{t("client.src.processid")}{selectedLog.id}</span>
                       <span className="text-slate-600 block">{t("client.src.encryption_shield256active")}</span>
                    </div>
                 </div>

                 <Button onClick={() => setSelectedLog(null)} className="w-full h-16 rounded-[24px] bg-blue-600 hover:bg-blue-500 text-white font-black italic tracking-widest text-xs shadow-xl">
                    {t("closeAnalysis")}
                 </Button>
              </div>
           </motion.div>
        </div>}
    </div>;
}