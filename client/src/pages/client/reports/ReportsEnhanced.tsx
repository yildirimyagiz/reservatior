import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "../layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { Textarea } from "@/components/ui/textarea";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { FileText, Download, Play, Pause, CheckCircle, XCircle, AlertCircle, BarChart3, Calendar, Users, Mail, Eye, Edit, Trash2, MoreHorizontal, RefreshCw, Activity, Zap, Shield, Search, Plus, ArrowUpRight, Cpu, Layers, Fingerprint, Building } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { reportsApi, ReportStatus, ReportExecutionStatus } from "@/lib/api/reports";
const REPORT_TYPES = {
  FINANCIAL: {
    label: t("client.src.fiscal_telemetry"),
    color: "text-emerald-400 bg-emerald-500/10 border-emerald-500/20",
    icon: DollarSign
  },
  PROPERTY: {
    label: t("client.src.node_performance"),
    color: "text-blue-400 bg-blue-500/10 border-blue-500/20",
    icon: Building
  },
  TENANT: {
    label: t("client.src.indentity_matrix"),
    color: "text-purple-400 bg-purple-500/10 border-purple-500/20",
    icon: Users
  },
  COMPLIANCE: {
    label: t("client.src.protocol_audit"),
    color: "text-amber-400 bg-amber-500/10 border-amber-500/20",
    icon: Shield
  },
  MAINTENANCE: {
    label: t("client.src.grid_maintenance"),
    color: "text-orange-400 bg-orange-500/10 border-orange-500/20",
    icon: Cpu
  },
  OCCUPANCY: {
    label: t("client.src.load_balancing"),
    color: "text-indigo-400 bg-indigo-500/10 border-indigo-500/20",
    icon: Activity
  }
};
const EXECUTION_STATUS = {
  RUNNING: {
    label: t("client.src.syncing"),
    icon: RefreshCw,
    color: "text-blue-400"
  },
  COMPLETED: {
    label: t("client.src.optimized"),
    icon: CheckCircle,
    color: "text-emerald-400"
  },
  FAILED: {
    label: t("client.src.aborted"),
    icon: XCircle,
    color: "text-red-400"
  },
  CANCELLED: {
    label: t("client.src.stalled"),
    icon: Pause,
    color: "text-slate-500"
  }
};
const SCHEDULE_FREQUENCY = {
  DAILY: {
    label: t("client.src.solar_cycle")
  },
  WEEKLY: {
    label: t("client.src.grid_cycle")
  },
  MONTHLY: {
    label: t("client.src.lunar_cycle")
  },
  QUARTERLY: {
    label: t("client.src.strategic_quarter")
  },
  YEARLY: {
    label: t("client.src.annual_harvest")
  },
  MANUAL: {
    label: t("client.src.ondemand_sync")
  }
};

// Re-using icon mapping for the new aesthetic
function DollarSign(props: any) {
  return <Activity {...props} />;
}
export default function ReportsEnhanced() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [search, setSearch] = useState("");
  const [filterType, setFilterType] = useState("all");
  const [filterStatus, setFilterStatus] = useState("all");
  const [createOpen, setCreateOpen] = useState(false);
  const queryClient = useQueryClient();
  const [activeTab, setActiveTab] = useState("reports");
  const [generatingReport, setGeneratingReport] = useState<string | null>(null);

  const { data: rawReports = [] } = useQuery({
    queryKey: ['reports'],
    queryFn: async () => {
      const response = await reportsApi.getReports();
      return (response as any).data || response || [];
    }
  });

  const reports = Array.isArray(rawReports) ? rawReports : [];
  
  // Flatten executions from reports
  const executions = reports.flatMap((r: any) => 
    (r.executions || []).map((e: any) => ({
      ...e,
      report: { name: r.name }
    }))
  ).sort((a, b) => new Date(b.startedAt).getTime() - new Date(a.startedAt).getTime());

  const runReportMutation = useMutation({
    mutationFn: (id: string) => reportsApi.runReport(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['reports'] });
      setGeneratingReport(null);
      toast({
        title: t("client.src.protocol_complete"),
        description: t("client.src.report_generated_and_encrypted")
      });
    },
    onError: () => {
      setGeneratingReport(null);
      toast({
        title: "Error",
        description: "Failed to generate report",
        variant: "destructive"
      });
    }
  });

  const handleGenerateReport = (reportId: string) => {
    setGeneratingReport(reportId);
    runReportMutation.mutate(reportId);
  };
  const filteredReports = reports.filter(r => {
    const mSearch = r.name.toLowerCase().includes(search.toLowerCase());
    const mType = filterType === "all" || r.reportType === filterType;
    return mSearch && mType;
  });
  const stats = [{
    label: t("client.src.telemetry_nodes"),
    value: reports.length
  }, {
    label: t("client.src.sync_active"),
    value: reports.filter((r: any) => r.status === ReportStatus.ACTIVE).length
  }, {
    label: t("client.src.cycles_run"),
    value: executions.length
  }, {
    label: t("client.src.optimization"),
    value: "98.2%",
    color: "text-emerald-400"
  }];
  return <PageShell title={t("client.src.tactical_intelligence")} description={t("client.src.neural_reporting_hub_predictive")} stats={stats} onSearchChange={setSearch} searchValue={search}>
      <div className="space-y-12">
        <Tabs value={activeTab} onValueChange={setActiveTab} className="space-y-12 outline-none">
          <div className="flex flex-col lg:flex-row items-center justify-between gap-6 px-4">
             <TabsList className="bg-[#1a1b1e]/60 border border-white/5 p-1.5 rounded-[20px] h-14 shadow-xl">
               {["REPORTS", "EXECUTIONS", "TELEMETRY"].map(tab => <TabsTrigger key={tab} value={tab.toLowerCase()} className="data-[state=active]:bg-blue-600 data-[state=active]:text-white rounded-[14px] px-8 text-[10px] font-black tracking-widest italic h-full transition-all">
                   {tab}
                 </TabsTrigger>)}
             </TabsList>

             <div className="flex items-center gap-4 w-full lg:w-auto">
                <Button onClick={() => setCreateOpen(true)} className="h-14 px-8 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black text-[10px] italic tracking-widest shadow-xl shadow-blue-600/20 border-t border-white/10 shrink-0">
                   <Plus className="w-4 h-4 mr-2" />{t("client.src.initialize_report")}</Button>
             </div>
          </div>

          <AnimatePresence mode="wait">
            <TabsContent value="reports" className="mt-0 outline-none">
              <div className="grid grid-cols-1 xl:grid-cols-2 gap-8 px-4">
                {filteredReports.map((report: any, idx: number) => {
                const rType = REPORT_TYPES[report.reportType as keyof typeof REPORT_TYPES] || REPORT_TYPES.FINANCIAL;
                const Icon = rType.icon;
                return <motion.div key={report.id} initial={{
                  opacity: 0,
                  y: 20
                }} animate={{
                  opacity: 1,
                  y: 0
                }} transition={{
                  delay: idx * 0.05
                }} className="p-8 rounded-[40px] bg-[#1a1b1e]/40 border border-white/5 backdrop-blur-3xl shadow-3xl group relative overflow-hidden flex flex-col justify-between border-l border-t">
                      <div className="absolute top-0 right-0 p-10 opacity-5 group-hover:opacity-10 transition-all pointer-events-none text-blue-500">
                         <Icon className="w-32 h-32" />
                      </div>

                      <div className="space-y-6 relative z-10">
                        <div className="flex items-center justify-between">
                           <Badge className={cn("text-[9px] font-black  tracking-[0.2em] italic border-none py-1 px-4 rounded-full", rType.color)}>
                              {rType.label}
                           </Badge>
                           <div className="flex items-center gap-4">
                              <Badge className={cn("text-[9px] font-black  italic border-none py-1 px-4 rounded-full", report.status === ReportStatus.ACTIVE ? "bg-emerald-400/10 text-emerald-400" : "bg-slate-500/10 text-slate-400")}>
                                 {report.status === ReportStatus.ACTIVE ? "ONLINE" : "OFFLINE"}
                              </Badge>
                              <DropdownMenu>
                                <DropdownMenuTrigger asChild>
                                  <div className="h-10 w-10 rounded-xl bg-black/40 border border-white/5 flex items-center justify-center text-slate-400 group-hover:text-white transition-colors cursor-pointer">
                                    <MoreHorizontal className="w-4 h-4" />
                                  </div>
                                </DropdownMenuTrigger>
                                <DropdownMenuContent className="bg-black border-white/10 font-display">
                                   <DropdownMenuItem className="text-slate-400 font-bold italic text-[10px]">{t("client.src.edit_config")}</DropdownMenuItem>
                                   <DropdownMenuItem className="text-red-400 font-bold italic text-[10px]">{t("client.src.wipe_record")}</DropdownMenuItem>
                                </DropdownMenuContent>
                              </DropdownMenu>
                           </div>
                        </div>

                        <div className="space-y-2">
                           <h3 className="text-2xl font-black text-white italic tracking-tighter leading-tight group-hover:text-blue-400 transition-colors">{report.name}</h3>
                           <p className="text-[11px] font-bold text-slate-500 tracking-widest leading-relaxed italic max-w-lg">{report.description}</p>
                        </div>

                        <div className="grid grid-cols-2 md:grid-cols-3 gap-6 pt-6 border-t border-white/5">
                           <div className="space-y-1">
                              <p className="text-[8px] font-black text-slate-600 tracking-widest italic flex items-center gap-1.5"><Calendar className="w-2.5 h-2.5" />{t("client.src.cycle_frequency")}</p>
                              <p className="text-[10px] font-black text-white italic tracking-tight">{report.schedule ? SCHEDULE_FREQUENCY[report.schedule as keyof typeof SCHEDULE_FREQUENCY]?.label || "CUSTOM" : "ON-DEMAND"}</p>
                           </div>
                           <div className="space-y-1">
                              <p className="text-[8px] font-black text-slate-600 tracking-widest italic flex items-center gap-1.5"><RefreshCw className="w-2.5 h-2.5" />{t("client.src.last_sync")}</p>
                              <p className="text-[10px] font-black text-white italic tracking-tight">{report.lastRunAt ? new Date(report.lastRunAt).toLocaleDateString() : "NEVER"}</p>
                           </div>
                           <div className="space-y-1">
                              <p className="text-[8px] font-black text-slate-600 tracking-widest italic flex items-center gap-1.5"><Layers className="w-2.5 h-2.5" />{t("client.src.recipients")}</p>
                              <p className="text-[10px] font-black text-white italic tracking-tight">{report.executions?.length || 0} {t("client.src.executions")}</p>
                           </div>
                        </div>
                      </div>

                      <div className="mt-8 flex items-center justify-between">
                         <div className="flex items-center gap-4">
                            <div className="h-10 w-10 bg-black/40 border border-white/5 rounded-xl flex items-center justify-center text-blue-400">
                               <Fingerprint className="w-5 h-5" />
                            </div>
                            <div>
                               <p className="text-[8px] font-black text-slate-600 italic">{t("client.src.sha256_secured")}</p>
                               <p className="text-[9px] font-black text-white italic tracking-tighter">{t("client.src.node_id")}{report.id}</p>
                            </div>
                         </div>
                         <Button disabled={generatingReport === report.id} onClick={() => handleGenerateReport(report.id)} className="h-12 px-8 rounded-xl bg-blue-600 hover:bg-blue-500 text-white font-black text-[10px] italic tracking-widest gap-2 shadow-xl shadow-blue-600/20">
                           {generatingReport === report.id ? <RefreshCw className="w-3 h-3 animate-spin" /> : <Play className="w-3 h-3" />}
                           {generatingReport === report.id ? "SYNCING..." : "EXECUTE"}
                         </Button>
                      </div>
                    </motion.div>;
              })}
              </div>
            </TabsContent>

            <TabsContent value="executions" className="mt-0 outline-none px-4">
               <Card className="border-white/5 bg-[#1a1b1e]/40 backdrop-blur-3xl rounded-[40px] shadow-3xl border-l border-t relative overflow-hidden">
                  <CardHeader className="p-10">
                     <CardTitle className="text-xl font-black text-white italic tracking-tighter flex items-center gap-4">
                        <Activity className="w-5 h-5 text-blue-500" />{t("client.src.historical_execution_log")}</CardTitle>
                  </CardHeader>
                  <CardContent className="p-10 pt-0 space-y-4">
                     {executions.map((exec: any) => {
                  const status = EXECUTION_STATUS[exec.status as keyof typeof EXECUTION_STATUS] || EXECUTION_STATUS.FAILED;
                  return <div key={exec.id} className="flex items-center justify-between p-6 rounded-2xl bg-black/20 border border-white/5 group hover:bg-white/5 transition-all">
                             <div className="flex items-center gap-6">
                                <div className="h-12 w-12 rounded-xl bg-blue-500/10 border border-blue-500/20 flex items-center justify-center text-blue-400">
                                   <FileText className="w-5 h-5" />
                                </div>
                                <div className="space-y-1">
                                   <p className="text-[11px] font-black text-white italic tracking-tight">{exec.report.name}</p>
                                   <p className="text-[9px] font-black text-slate-500 tracking-widest italic">{exec.userId || 'SYSTEM'} · {new Date(exec.startedAt).toLocaleString()}</p>
                                </div>
                             </div>
                             <div className="flex items-center gap-8">
                                <Badge className={cn("text-[9px] font-black  italic border-none py-1 px-4 rounded-full", status.color, "bg-white/5")}>
                                   {status.label}
                                </Badge>
                                <Button variant="ghost" size="icon" className="h-10 w-10 text-slate-500 hover:text-white transition-colors">
                                   <Download className="w-4 h-4" />
                                </Button>
                             </div>
                          </div>;
                })}
                  </CardContent>
               </Card>
            </TabsContent>
          </AnimatePresence>
        </Tabs>
      </div>

      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="max-w-2xl bg-[#14151a] border border-white/10 rounded-[32px] shadow-3xl text-white font-display overflow-hidden">
          <div className="absolute top-0 left-0 w-full h-1 bg-linear-to-r from-blue-600 via-transparent to-transparent opacity-50"></div>
          <DialogHeader className="p-8">
            <DialogTitle className="text-3xl font-black italic tracking-tighter flex items-center gap-4">
               <div className="p-3 bg-blue-600 rounded-2xl shadow-xl shadow-blue-600/20">
                  <FileText className="w-6 h-6 text-white" />
               </div>{t("client.src.initialize_protocol")}</DialogTitle>
            <DialogDescription className="text-[10px] font-black text-slate-500 tracking-widest italic mt-4">{t("client.src.deploy_new_telemetry_extraction")}</DialogDescription>
          </DialogHeader>
          
          <div className="p-8 pt-0 space-y-6">
             <div className="space-y-2">
                <Label className="text-[9px] font-black text-slate-500 italic tracking-widest">{t("client.src.report_identifier")}</Label>
                <Input className="h-12 bg-black/40 border-white/5 rounded-xl text-white focus:ring-blue-500/20" placeholder={t("client.src.eg_q4_revenue_matrix")} />
             </div>
             <div className="grid grid-cols-2 gap-6">
                <div className="space-y-2">
                   <Label className="text-[9px] font-black text-slate-500 italic tracking-widest">{t("client.src.tactical_sector")}</Label>
                   <Select>
                      <SelectTrigger className="h-12 bg-black/40 border-white/5 rounded-xl text-white">
                         <SelectValue placeholder={t("client.src.select_type")} />
                      </SelectTrigger>
                      <SelectContent className="bg-black border-white/10">
                         {Object.entries(REPORT_TYPES).map(([key, c]) => <SelectItem key={key} value={key}>{c.label}</SelectItem>)}
                      </SelectContent>
                   </Select>
                </div>
                <div className="space-y-2">
                   <Label className="text-[9px] font-black text-slate-500 italic tracking-widest">{t("client.src.sync_frequency")}</Label>
                   <Select>
                      <SelectTrigger className="h-12 bg-black/40 border-white/5 rounded-xl text-white">
                         <SelectValue placeholder={t("client.src.select_cycle")} />
                      </SelectTrigger>
                      <SelectContent className="bg-black border-white/10">
                         {Object.entries(SCHEDULE_FREQUENCY).map(([key, c]) => <SelectItem key={key} value={key}>{c.label}</SelectItem>)}
                      </SelectContent>
                   </Select>
                </div>
             </div>
          </div>

          <DialogFooter className="p-8 pt-0 flex gap-4">
            <Button variant="ghost" onClick={() => setCreateOpen(false)} className="h-12 rounded-xl text-[10px] font-black text-slate-500 hover:text-white transition-all italic">{t("client.src.abort_mission")}</Button>
            <Button className="h-12 px-8 rounded-xl bg-blue-600 hover:bg-blue-500 text-white font-black text-[10px] italic tracking-widest shadow-xl shadow-blue-600/20">{t("client.src.confirm_deployment")}</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </PageShell>;
}