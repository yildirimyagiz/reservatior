"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import React, { useState, useEffect } from "react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuSeparator, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { BarChart, Bar, AreaChart, Area, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Cell, Pie, PieChart } from "recharts";
import { MoreHorizontal, Download, Play, Clock, CheckCircle2, AlertCircle, XCircle, FileBarChart, TrendingUp, Users, DollarSign, Calendar, Plus, RefreshCw, Building, Wrench, Search, Zap, Activity, ArrowUpRight, Shield, Layers, PieChart as PieChartIcon } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import { apiClient } from "@/lib/api/client";
import { reportsApi, ReportStatus, ReportExecutionStatus, type Report } from "@/lib/api/reports";
import { cn } from "@/lib/utils";
import { motion, AnimatePresence } from "framer-motion";
enum ReportType {
  FINANCIAL = "FINANCIAL",
  OCCUPANCY = "OCCUPANCY",
  PERFORMANCE = "PERFORMANCE",
  MAINTENANCE = "MAINTENANCE",
  COMPLIANCE = "COMPLIANCE",
  TAX = "TAX",
  GUEST = "GUEST",
  MARKETING = "MARKETING",
  OPERATIONS = "OPERATIONS",
}
const REPORT_TYPE_CONFIG = {
  FINANCIAL: {
    label: t("admin_reports_financial"),
    color: "bg-emerald-500/10 text-emerald-400 border-emerald-500/20",
    icon: DollarSign
  },
  OCCUPANCY: {
    label: t("admin_reports_occupancy"),
    color: "bg-slate-500/10 text-slate-500 dark:text-slate-400 border-slate-500/20",
    icon: Building
  },
  PERFORMANCE: {
    label: t("admin_reports_performance"),
    color: "bg-slate-500/10 text-slate-500 dark:text-slate-400 border-slate-500/20",
    icon: TrendingUp
  },
  MAINTENANCE: {
    label: t("admin_reports_maintenance"),
    color: "bg-orange-500/10 text-orange-400 border-orange-500/20",
    icon: Wrench
  },
  COMPLIANCE: {
    label: t("admin_reports_compliance"),
    color: "bg-red-500/10 text-red-500 border-red-500/20",
    icon: AlertCircle
  },
  TAX: {
    label: t("admin_reports_tax"),
    color: "bg-yellow-500/10 text-yellow-400 border-yellow-500/20",
    icon: FileBarChart
  },
  GUEST: {
    label: t("admin_reports_guest"),
    color: "bg-pink-500/10 text-pink-400 border-pink-500/20",
    icon: Users
  },
  MARKETING: {
    label: t("admin_reports_marketing"),
    color: "bg-slate-500/10 text-slate-500 dark:text-slate-400 border-slate-500/20",
    icon: TrendingUp
  },
  OPERATIONS: {
    label: t("admin_reports_operations"),
    color: "bg-slate-500/10 text-slate-500 dark:text-slate-400 border-slate-500/20",
    icon: Calendar
  }
};
const STATUS_CONFIG = {
  ACTIVE: {
    label: t("admin_reports_active_signal"),
    color: "bg-emerald-500/10 text-emerald-400"
  },
  PAUSED: {
    label: t("admin_reports_paused_sync"),
    color: "bg-orange-500/10 text-orange-400"
  },
  DRAFT: {
    label: t("admin_reports_beta_draft"),
    color: "bg-slate-500/10 text-slate-500 dark:text-slate-400"
  }
};
const EXECUTION_STATUS_CONFIG = {
  SUCCESS: {
    label: t("admin_reports_syncsuccess"),
    color: "bg-emerald-500/10 text-emerald-400",
    icon: CheckCircle2
  },
  FAILED: {
    label: t("admin_reports_syncfailure"),
    color: "bg-red-500/10 text-red-500",
    icon: XCircle
  },
  RUNNING: {
    label: t("admin_reports_processing"),
    color: "bg-slate-500/10 text-slate-500 dark:text-slate-400",
    icon: Clock
  },
  PENDING: {
    label: t("admin_reports_inqueue"),
    color: "bg-orange-500/10 text-orange-400",
    icon: Clock
  }
};
export default function Reports() {
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const [editingId, setEditingId] = React.useState<string | null>(null);

  const updateMutation = useMutation({
    mutationFn: async (data: any) => apiClient.put(`/admin/reports/${data.id}`, data),
    onSuccess: () => { toast({ title: "Updated", description: "Record updated successfully" }); queryClient.invalidateQueries(); setEditingId(null); },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
  });

  const deleteMutation = useMutation({
    mutationFn: async (id: string) => apiClient.delete(`/admin/reports/${id}`),
    onSuccess: () => { toast({ title: "Deleted", description: "Record deleted successfully" }); queryClient.invalidateQueries(); },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
  });
  
  const {
    t
  } = useTranslation();
  const [search, setSearch] = useState("");
  const [filterType, setFilterType] = useState("all");
  const [filterStatus, setFilterStatus] = useState("all");
  const [createOpen, setCreateOpen] = useState(false);
  const [reports, setReports] = useState<Report[]>([]);
  const [loading, setLoading] = useState(true);
  useEffect(() => {
    const fetchReports = async () => {
      try {
        setLoading(true);
        const response = await reportsApi.getReports({
          page: "1",
          limit: "50",
          include: "executions,user"
        });
        setReports(response || []);
      } catch (error) {
        toast({
          title: t("admin_reports_sync_error"),
          description: t("admin_reports_global_report_matrix_unreachable"),
          variant: "destructive"
        });
      } finally {
        setLoading(false);
      }
    };
    fetchReports();
  }, []);
  const filteredReports = reports.filter(report => {
    const matchesSearch = report.name.toLowerCase().includes(search.toLowerCase()) || report.description.toLowerCase().includes(search.toLowerCase());
    const matchesType = filterType === "all" || report.reportType === filterType;
    const matchesStatus = filterStatus === "all" || report.status === filterStatus;
    return matchesSearch && matchesType && matchesStatus;
  });
  const stats = {
    total: filteredReports.length,
    active: filteredReports.filter(r => r.status === "ACTIVE").length,
    successfulRuns: filteredReports.reduce((sum, r) => sum + (r.executions?.filter(e => e.status === "SUCCESS").length || 0), 0),
    failedRuns: filteredReports.reduce((sum, r) => sum + (r.executions?.filter(e => e.status === "FAILED").length || 0), 0)
  };
  const handleRunReport = async (id: string) => {
    try {
      await reportsApi.runReport(id);
      toast({
        title: t("admin_reports_neural_sequence_initiated"),
        description: t("admin_reports_report_generation_protocol_active")
      });
      const response = await reportsApi.getReports({
        include: "executions,user"
      });
      setReports(response || []);
    } catch (error) {
      toast({
        title: t("admin_reports_protocol_failed"),
        description: t("admin_reports_report_execution_aborted"),
        variant: "destructive"
      });
    }
  };
  return <div className="p-6 space-y-6 min-h-screen">
      <div className="space-y-10 pb-20">
        
        {/* KPI Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          <Card className="bg-white/5 border-slate-200 dark:border-white/10 rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-white/5">
            <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-slate-500">
               <FileBarChart className="w-10 h-10" />
            </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400 mb-1">{t("admin_reports_matrix_capacity")}</p>
              <h3 className="text-xl font-bold text-slate-900 dark:text-white leading-none">{stats.total}</h3>
              <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400 mt-4">{t("admin_reports_total_report_nodes")}</p>
            </CardContent>
          </Card>

          <Card className="bg-white/5 border-slate-200 dark:border-white/10 rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-white/5 font-medium">
             <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-emerald-500">
               <CheckCircle2 className="w-10 h-10" />
            </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400 mb-1">{t("admin_reports_active_signals")}</p>
              <h3 className="text-xl font-bold text-emerald-400 leading-none">{stats.active}</h3>
              <p className="text-[10px] font-bold text-emerald-500/60 mt-4">{t("admin_reports_synchronized_modules")}</p>
            </CardContent>
          </Card>

          <Card className="bg-white/5 border-slate-200 dark:border-white/10 rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-white/5">
             <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-orange-500">
               <Zap className="w-10 h-10" />
            </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400 mb-1">{t("admin_reports_total_success_runs")}</p>
              <h3 className="text-xl font-bold text-orange-400 leading-none">{stats.successfulRuns}</h3>
              <p className="text-[10px] font-bold text-orange-400/60 mt-4">{t("admin_reports_verified_cycles")}</p>
            </CardContent>
          </Card>

          <Card className="bg-white/5 border-slate-200 dark:border-white/10 rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-white/5">
            <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-red-500">
               <AlertCircle className="w-10 h-10" />
            </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400 mb-1">{t("admin_reports_sync_failures")}</p>
              <h3 className="text-xl font-bold text-red-500 leading-none">{stats.failedRuns}</h3>
              <p className="text-[10px] font-bold text-red-500/60 mt-4">{t("admin_reports_action_required")}</p>
            </CardContent>
          </Card>
        </div>

        {/* Tactical Charts Grid */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          <Card className="lg:col-span-2 bg-white/5 border-slate-200 dark:border-white/10 rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
             <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-slate-600 via-transparent to-transparent opacity-50"></div>
             <CardHeader className="bg-white/5 p-6 rounded-2xl border border-slate-200 dark:border-white/10">
                <CardTitle className="text-xl font-bold text-slate-900 dark:text-white flex items-center gap-3">
                  <Activity className="w-5 h-5 text-slate-500" />{t("admin_reports_temporal_run_distribution")}</CardTitle>
                <CardDescription className="text-[10px] font-bold text-slate-500 dark:text-slate-400">{t("admin_reports_monitoring_data_sequence_integrity")}</CardDescription>
             </CardHeader>
             <CardContent className="p-10">
                <div className="h-[300px] w-full">
                  <ResponsiveContainer width="100%" height={300} minWidth={0}>
                    <AreaChart data={filteredReports.flatMap(r => (r.executions || []).map(e => ({
                  date: new Date(e.createdAt).toLocaleDateString(),
                  success: e.status === "SUCCESS" ? 1 : 0,
                  failed: e.status === "FAILED" ? 1 : 0
                }))).slice(-30)}>
                      <defs>
                        <linearGradient id="colorSuccess" x1="0" y1="0" x2="0" y2="1">
                          <stop offset="5%" stopColor="#10b981" stopOpacity={0.3} />
                          <stop offset="95%" stopColor="#10b981" stopOpacity={0} />
                        </linearGradient>
                      </defs>
                      <CartesianGrid strokeDasharray="3 3" stroke="#ffffff05" vertical={false} />
                      <XAxis dataKey="date" stroke="#475569" fontSize={10} tickLine={false} axisLine={false} />
                      <YAxis stroke="#475569" fontSize={10} tickLine={false} axisLine={false} />
                      <Tooltip contentStyle={{
                    backgroundColor: '#14151a',
                    border: '1px solid rgba(255,255,255,0.1)',
                    borderRadius: '12px'
                  }} />
                      <Area type="monotone" dataKey="success" stroke="#10b981" fillOpacity={1} fill="url(#colorSuccess)" strokeWidth={3} />
                    </AreaChart>
                  </ResponsiveContainer>
                </div>
             </CardContent>
          </Card>

          <Card className="bg-white/5 border-slate-200 dark:border-white/10 rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
             <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-slate-600 via-transparent to-transparent opacity-50"></div>
             <CardHeader className="bg-white/5 p-6 rounded-2xl border border-slate-200 dark:border-white/10">
                <CardTitle className="text-xl font-bold text-slate-900 dark:text-white flex items-center gap-3">
                  <PieChartIcon className="w-5 h-5 text-slate-500" />{t("admin_reports_sector_allocation")}</CardTitle>
                <CardDescription className="text-[10px] font-bold text-slate-500 dark:text-slate-400">{t("admin_reports_global_report_type_distribution")}</CardDescription>
             </CardHeader>
             <CardContent className="p-10 flex items-center justify-center">
                <div className="h-[300px] w-full">
                  <ResponsiveContainer width="100%" height={300} minWidth={0}>
                    <PieChart>
                      <Pie data={Object.entries(filteredReports.reduce((acc, r) => {
                    acc[r.reportType] = (acc[r.reportType] || 0) + 1;
                    return acc;
                  }, {} as Record<string, number>)).map(([name, value]) => ({
                    name,
                    value
                  }))} innerRadius={80} outerRadius={100} paddingAngle={5} dataKey="value">
                        {[0, 1, 2, 3, 4, 5, 6].map((entry, index) => <Cell key={`cell-${index}`} fill={['#3b82f6', '#8b5cf6', '#10b981', '#f59e0b', '#ef4444'][index % 5]} />)}
                      </Pie>
                      <Tooltip contentStyle={{
                    backgroundColor: '#14151a',
                    border: '1px solid rgba(255,255,255,0.1)',
                    borderRadius: '12px'
                  }} />
                    </PieChart>
                  </ResponsiveContainer>
                </div>
             </CardContent>
          </Card>
        </div>

        {/* Global Toolbar */}
        <div className="flex flex-col lg:flex-row items-center justify-between gap-6 px-4">
           <div className="flex flex-wrap items-center gap-3 flex-1">
              <div className="relative group min-w-[320px]">
                <Search className="absolute left-4 top-1/2 -translate-y-1/2 h-4 w-4 text-slate-500 dark:text-slate-400 group-focus-within:text-slate-500 transition-colors" />
                <Input placeholder={t("admin_reports_filter_reporting_nodes")} value={search} onChange={e => setSearch(e.target.value)} className="bg-white/5 border-slate-200 dark:border-white/10 rounded-2xl pl-12 h-14 text-slate-900 dark:text-white focus:ring-slate-500/20 focus:border-slate-500/40 transition-all font-medium border-l border-t" />
              </div>
              <Select value={filterType} onValueChange={setFilterType}>
                <SelectTrigger className="w-44 bg-white/5 border-slate-200 dark:border-white/10 rounded-2xl h-14 text-slate-900 dark:text-white font-bold text-[10px] border-l border-t">
                  <SelectValue placeholder={t("admin_reports_report_type")} />
                </SelectTrigger>
                <SelectContent className="bg-[#14151a] border-slate-200 dark:border-white/10 rounded-2xl text-slate-500 dark:text-slate-400">
                  <SelectItem value="all">{t("admin_reports_all_types")}</SelectItem>
                  {Object.values(ReportType).map(type => <SelectItem key={type} value={type}>{REPORT_TYPE_CONFIG[type]?.label}</SelectItem>)}
                </SelectContent>
              </Select>
           </div>
           <Button onClick={() => setCreateOpen(true)} className="h-14 px-8 rounded-2xl bg-slate-600 hover:bg-slate-500 text-slate-900 dark:text-white font-bold text-xs shadow-xl shadow-slate-600/30 gap-3">
              <Plus className="w-5 h-5" />{t("admin_reports_initialize_report_node")}</Button>
        </div>

        {/* Data Matrix Table */}
        <Card className="bg-white/5 border-slate-200 dark:border-white/10 rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
            <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-emerald-600 via-transparent to-transparent opacity-50"></div>
            <CardContent className="p-0">
               <Table>
                 <TableHeader className="bg-white/5 border-b border-slate-200 dark:border-white/10">
                    <TableRow className="border-none hover:bg-transparent">
                      <TableHead className="text-[10px] font-bold text-slate-500 dark:text-slate-400 py-6 px-8">{t("admin_reports_node_identity")}</TableHead>
                      <TableHead className="text-[10px] font-bold text-slate-500 dark:text-slate-400 px-8">{t("admin_reports_classification")}</TableHead>
                      <TableHead className="text-[10px] font-bold text-slate-500 dark:text-slate-400 px-8">{t("admin_reports_sync_arc")}</TableHead>
                      <TableHead className="text-[10px] font-bold text-slate-500 dark:text-slate-400 px-8 text-right">{t("admin_reports_temporal_sequence")}</TableHead>
                      <TableHead className="text-[10px] font-bold text-slate-500 dark:text-slate-400 px-8 text-right">{t("admin_reports_action")}</TableHead>
                    </TableRow>
                 </TableHeader>
                 <TableBody>
                    {loading ? <TableRow>
                        <TableCell colSpan={5} className="py-24 text-center">
                          <Activity className="w-10 h-10 text-slate-500 animate-spin mx-auto mb-4 opacity-50" />
                          <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400 animate-pulse">{t("admin_reports_synchronizing_global_matrix")}</p>
                        </TableCell>
                      </TableRow> : filteredReports.map(report => <TableRow key={report.id} className="border-b border-slate-200 dark:border-white/10 hover:bg-white/5 transition-all group">
                           <TableCell className="py-8 px-8">
                             <div className="flex items-center gap-5">
                               <div className="w-12 h-12 rounded-xl bg-white/5 border border-slate-200 dark:border-white/10 flex items-center justify-center group-hover:scale-110 transition-all">
                                  <FileBarChart className="w-6 h-6 text-slate-500 dark:text-slate-400" />
                               </div>
                               <div>
                                 <div className="text-lg font-bold text-slate-900 dark:text-white leading-tight">{report.name}</div>
                                 <div className="text-[10px] font-bold text-slate-500 dark:text-slate-400 max-w-xs truncate">{report.description}</div>
                               </div>
                             </div>
                           </TableCell>
                           <TableCell className="px-8">
                              <Badge className={cn("text-[8px] font-bold   px-3 py-1 rounded-full  border shadow-lg", REPORT_TYPE_CONFIG[report.reportType as ReportType].color)}>
                                {REPORT_TYPE_CONFIG[report.reportType as ReportType].label}
                              </Badge>
                           </TableCell>
                           <TableCell className="px-8 font-medium">
                              <div className="flex items-center gap-2">
                                <div className={cn("w-2 h-2 rounded-full", report.status === 'ACTIVE' ? "bg-emerald-500 shadow-[0_0_10px_#10b981]" : "bg-slate-700")}></div>
                                <span className={cn("text-[10px] font-bold   ", report.status === 'ACTIVE' ? "text-emerald-400" : "text-slate-500 dark:text-slate-400")}>
                                  {STATUS_CONFIG[report.status].label}
                                </span>
                              </div>
                           </TableCell>
                           <TableCell className="px-8 text-right">
                              <div className="flex flex-col items-end">
                                <div className="text-sm font-bold text-slate-900 dark:text-white font-mono">{report.lastRunAt ? new Date(report.lastRunAt).toLocaleDateString() : t("admin.reports.never_synced", "HİÇ SENKRONİZE EDİLMEDİ")}</div>
                                <div className="text-[9px] font-bold text-slate-500 dark:text-slate-400 leading-none mt-1">{t("admin_reports_nextsync")}{report.nextRunAt ? new Date(report.nextRunAt).toLocaleDateString() : t("admin.reports.manual_only", "SADECE MANUEL")}</div>
                              </div>
                           </TableCell>
                           <TableCell className="px-8 text-right">
                              <div className="flex items-center justify-end gap-2">
                                 <Button variant="ghost" size="icon" className="h-10 w-10 rounded-xl hover:bg-white/5 text-emerald-500 shadow-xl" onClick={() => handleRunReport(report.id)}>
                                    <Play className="w-4 h-4" />
                                 </Button>
                                 <Button variant="ghost" size="icon" className="h-10 w-10 rounded-xl hover:bg-white/5 text-slate-500 dark:text-slate-400">
                                    <MoreHorizontal className="w-4 h-4" />
                                 </Button>
                              </div>
                            </TableCell>
                         </TableRow>)}
                 </TableBody>
               </Table>
            </CardContent>
        </Card>
      </div>

      {/* Modernized Create Report Dialog */}
      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="max-w-2xl bg-[#14151a] border-slate-200 dark:border-white/10 text-slate-900 dark:text-white rounded-4xl p-0 overflow-hidden shadow-[0_0_50px_rgba(0,0,0,0.5)]">
           <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-slate-600 via-transparent to-transparent"></div>
           <DialogHeader className="p-8 border-b border-slate-200 dark:border-white/10 bg-white/5">
              <DialogTitle className="text-2xl font-bold flex items-center gap-3 text-slate-900 dark:text-white">
                <Layers className="w-6 h-6 text-slate-500" />{t("admin_reports_initialize_neural_node")}</DialogTitle>
              <DialogDescription className="text-[10px] font-bold text-slate-500 dark:text-slate-400 mt-1">{t("admin_reports_configure_automated_reporting_parameters")}</DialogDescription>
           </DialogHeader>
           
           <div className="p-10 space-y-8">
              <div className="grid grid-cols-2 gap-8">
                <div className="col-span-2 space-y-3">
                   <Label className="text-[10px] font-bold text-slate-500 dark:text-slate-400 ml-3">{t("admin_reports_node_designation")}</Label>
                   <Input placeholder={t("admin_reports_designationid")} className="bg-white/5 border-slate-200 dark:border-white/10 rounded-2xl h-16 font-bold tracking-tight px-6 text-lg focus:ring-slate-500/20 shadow-inner" />
                </div>
                <div className="space-y-3">
                   <Label className="text-[10px] font-bold text-slate-500 dark:text-slate-400 ml-3">{t("admin_reports_report_category")}</Label>
                   <Select>
                      <SelectTrigger className="bg-white/5 border-slate-200 dark:border-white/10 rounded-2xl h-14 font-bold text-[10px] px-6 border-l border-t">
                        <SelectValue placeholder={t("admin_reports_category")} />
                      </SelectTrigger>
                      <SelectContent className="bg-[#14151a] border-slate-200 dark:border-white/10 text-slate-900 dark:text-white rounded-2xl font-bold">
                        {Object.values(ReportType).map(type => <SelectItem key={type} value={type} className="text-[11px] py-3">{REPORT_TYPE_CONFIG[type]?.label}</SelectItem>)}
                      </SelectContent>
                   </Select>
                </div>
                <div className="space-y-3">
                   <Label className="text-[10px] font-bold text-slate-500 dark:text-slate-400 ml-3">{t("admin_reports_temporal_frequency")}</Label>
                   <Select>
                      <SelectTrigger className="bg-white/5 border-slate-200 dark:border-white/10 rounded-2xl h-14 font-bold text-[10px] px-6 border-l border-t">
                        <SelectValue placeholder={t("admin_reports_frequency")} />
                      </SelectTrigger>
                      <SelectContent className="bg-[#14151a] border-slate-200 dark:border-white/10 text-slate-900 dark:text-white rounded-2xl">
                         <SelectItem value="DAILY" className="font-bold">{t("admin_reports_dailysync")}</SelectItem>
                         <SelectItem value="WEEKLY" className="font-bold">{t("admin_reports_weeklypulse")}</SelectItem>
                         <SelectItem value="MONTHLY" className="font-bold">{t("admin_reports_monthlyarc")}</SelectItem>
                      </SelectContent>
                   </Select>
                </div>
              </div>
           </div>

           <DialogFooter className="p-8 bg-white/5 border-t border-slate-200 dark:border-white/10 flex gap-4">
              <Button variant="ghost" className="flex-1 h-16 rounded-2xl font-bold text-[10px] text-slate-500 dark:text-slate-400 hover:text-white transition-all" onClick={() => setCreateOpen(false)}>{t("admin_reports_abortmod")}</Button>
              <Button className="flex-2 h-16 rounded-2xl bg-slate-600 hover:bg-slate-500 text-slate-900 dark:text-white font-bold text-[10px] shadow-xl shadow-slate-600/30">{t("admin_reports_initializesequence")}</Button>
           </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>;
}