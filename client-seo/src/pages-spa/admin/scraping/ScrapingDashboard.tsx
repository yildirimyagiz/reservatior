"use client";

import { useTranslation } from"react-i18next";
import { useState } from"react";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Badge } from"@/components/ui/badge";
import { Button } from"@/components/ui/button";
import { Progress } from"@/components/ui/progress";
import { useQuery } from"@tanstack/react-query";
import { scrapingApi, type ScrapingJob } from"@/lib/api/scraping";
import { Play, RotateCcw, AlertCircle, CheckCircle2, Clock, Database, RefreshCw, ChevronRight, ShieldCheck, History, Terminal, Cpu } from"lucide-react";

export default function ScrapingDashboard() {
 const { t } = useTranslation();
 const [isAddOpen, setIsAddOpen] = useState(false);
 const { data: jobs = [], isLoading, refetch } = useQuery({
 queryKey: ['scraping-jobs'],
 queryFn: async () => {
 const res = await scrapingApi.getJobs();
 const data = (res as any)?.data?.data || (res as any)?.data || [];
 if (data.length > 0) return data as ScrapingJob[];
 return [{
 id:"sj-1", jobType:"sahibinden", status:"running",
 startTime: new Date(Date.now() - 3600000).toISOString(),
 projectsScraped: 42, errors: [],
 configuration: { region:"Istanbul", limit: 100 },
 createdAt: new Date().toISOString(), updatedAt: new Date().toISOString()
 }, {
 id:"sj-2", jobType:"emlakjet", status:"completed",
 startTime: new Date(Date.now() - 7200000).toISOString(),
 endTime: new Date(Date.now() - 3600000).toISOString(),
 projectsScraped: 128, errors: [],
 configuration: { region:"Ankara" },
 createdAt: new Date().toISOString(), updatedAt: new Date().toISOString()
 }, {
 id:"sj-3", jobType:"hurriyetemlak", status:"failed",
 startTime: new Date(Date.now() - 86400000).toISOString(),
 endTime: new Date(Date.now() - 82800000).toISOString(),
 projectsScraped: 5, errors: ["Connection timeout after 30s","Rate limit exceeded"],
 configuration: { region:"Izmir" },
 createdAt: new Date().toISOString(), updatedAt: new Date().toISOString()
 }] as ScrapingJob[];
 }
 });
 const getStatusBadge = (status: string) => {
 switch (status) {
 case"running": return <Badge className="bg-slate-100 text-slate-700 hover:bg-slate-200 border-0 gap-1"><RefreshCw className="w-3 h-3 animate-spin" />{t("admin_scraping_running")}</Badge>;
 case"completed": return <Badge className="bg-green-100 text-green-700 hover:bg-green-200 border-0 gap-1"><CheckCircle2 className="w-3 h-3" />{t("admin_scraping_completed")}</Badge>;
 case"failed": return <Badge className="bg-red-100 text-red-700 hover:bg-red-200 border-0 gap-1"><AlertCircle className="w-3 h-3" />{t("admin_scraping_failed")}</Badge>;
 default: return <Badge variant="secondary" className="gap-1"><Clock className="w-3 h-3" />{t("admin_scraping_pending")}</Badge>;
 }
 };
 const calculateDuration = (start?: string, end?: string) => {
 if (!start) return"N/A";
 const startTime = new Date(start).getTime();
 const endTime = end ? new Date(end).getTime() : Date.now();
 const diff = Math.floor((endTime - startTime) / 1000 / 60);
 return `${diff}m`;
 };
 return <div className="min-h-screen bg-background">
 <div className="p-6 space-y-6">
 <div className="bg-card p-6 rounded-2xl border border-border flex items-center justify-between">
 <div>
 <h1 className="text-xl font-bold text-foreground">{t("admin_scraping_scraping_management")}</h1>
 <p className="text-sm text-muted-foreground">{t("admin_scraping_monitor_and_control_automated")}</p>
 </div>
 <div className="flex gap-2">
 <Button variant="outline" size="sm" onClick={() => refetch()} disabled={isLoading}>
 <RotateCcw className={`w-4 h-4 mr-2 ${isLoading ? 'animate-spin' : ''}`} />{t("admin_scraping_refresh")}</Button>
 <Button size="sm" className="bg-primary hover:bg-primary/90 text-primary-foreground">
 <Play className="w-4 h-4 mr-2" />{t("admin_scraping_run_new_job")}</Button>
 </div>
 </div>

 <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
 <Card className="bg-card border-border shadow-sm">
 <CardHeader className="pb-2">
 <CardTitle className="text-[10px] font-bold text-muted-foreground flex items-center gap-1">
 <History className="w-3 h-3" />{t("admin_scraping_recent_24h")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">2,482</div>
 <p className="text-[10px] text-muted-foreground">{t("admin_scraping_properties_scraped_today")}</p>
 </CardContent>
 </Card>
 <Card className="bg-card border-border shadow-sm">
 <CardHeader className="pb-2">
 <CardTitle className="text-[10px] font-bold text-muted-foreground flex items-center gap-1">
 <Cpu className="w-3 h-3" />{t("admin_scraping_success_rate")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-green-600">96.8%</div>
 <p className="text-[10px] text-muted-foreground flex items-center gap-1">
 <ShieldCheck className="w-3 h-3 text-green-500" />{t("admin_scraping_all_systems_healthy")}</p>
 </CardContent>
 </Card>
 <Card className="bg-card border-border shadow-sm">
 <CardHeader className="pb-2">
 <CardTitle className="text-[10px] font-bold text-muted-foreground flex items-center gap-1">
 <Database className="w-3 h-3" />{t("admin_scraping_active_threads")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">12</div>
 <p className="text-[10px] text-muted-foreground">{t("admin_scraping_across_3_sources")}</p>
 </CardContent>
 </Card>
 <Card className="bg-card border-border shadow-sm">
 <CardHeader className="pb-2">
 <CardTitle className="text-[10px] font-bold text-muted-foreground flex items-center gap-1">
 <Terminal className="w-3 h-3" />{t("admin_scraping_last_job")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground truncate">{t("admin_scraping_sahibinden")}</div>
 <p className="text-[10px] text-muted-foreground">{t("admin_scraping_finished_15m_ago")}</p>
 </CardContent>
 </Card>
 </div>

 <div className="bg-card border border-border rounded-xl shadow-sm overflow-hidden">
 <Table>
 <TableHeader className="bg-card">
 <TableRow>
 <TableHead className="font-bold text-xs text-muted-foreground">{t("admin_scraping_source")}</TableHead>
 <TableHead className="font-bold text-xs text-muted-foreground">{t("admin_scraping_status")}</TableHead>
 <TableHead className="font-bold text-xs text-muted-foreground">{t("admin_scraping_progress")}</TableHead>
 <TableHead className="font-bold text-xs text-muted-foreground">{t("admin_scraping_duration")}</TableHead>
 <TableHead className="font-bold text-xs text-muted-foreground">{t("admin_scraping_operations")}</TableHead>
 <TableHead className="w-10" />
 </TableRow>
 </TableHeader>
 <TableBody>
 {jobs.map(job => <TableRow key={job.id} className="hover:bg-card transition-colors">
 <TableCell>
 <div className="flex items-center gap-2">
 <div className="w-8 h-8 rounded-lg bg-primary/10 flex items-center justify-center font-bold text-[10px] text-primary">
 {job.jobType.slice(0, 2)}
 </div>
 <div>
 <div className="font-semibold text-sm text-foreground capitalize">{job.jobType}</div>
 <div className="text-[10px] text-muted-foreground font-mono">{job.id}</div>
 </div>
 </div>
 </TableCell>
 <TableCell>{getStatusBadge(job.status)}</TableCell>
 <TableCell>
 <div className="space-y-1">
 <div className="flex justify-between text-[10px] font-medium">
 <span className="text-muted-foreground">{job.projectsScraped}{t("admin_scraping_targets_found")}</span>
 {job.status ==="running" && <span className="text-muted-foreground">{t("admin_scraping_processing")}</span>}
 </div>
 <Progress value={job.status ==="completed" ? 100 : job.status ==="failed" ? 15 : 45} className="h-1" />
 </div>
 </TableCell>
 <TableCell className="text-xs text-muted-foreground">
 <div className="flex items-center gap-1">
 <Clock className="w-3 h-3" />
 {calculateDuration(job.startTime, job.endTime)}
 </div>
 </TableCell>
 <TableCell>
 <div className="flex gap-2">
 <Button variant="ghost" size="sm" className="h-8 px-2 text-[10px] font-bold tracking-tight text-muted-foreground hover:text-white">{t("admin_scraping_logs")}</Button>
 {job.status ==="failed" && <Button variant="ghost" size="sm" className="h-8 px-2 text-[10px] font-bold tracking-tight text-red-600 hover:text-red-700 hover:bg-red-50">{t("admin_scraping_retry")}</Button>}
 </div>
 </TableCell>
 <TableCell>
 <Button variant="ghost" size="icon" className="h-8 w-8 text-muted-foreground">
 <ChevronRight className="w-4 h-4" />
 </Button>
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </div>
 </div>
 </div>;
}
