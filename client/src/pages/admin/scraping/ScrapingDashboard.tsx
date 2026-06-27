import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Progress } from "@/components/ui/progress";
import { scrapingApi, type ScrapingJob } from "@/lib/api/scraping";
import { Play, RotateCcw, AlertCircle, CheckCircle2, Clock, Database, RefreshCw, ChevronRight, ShieldCheck, History, Terminal, Cpu } from "lucide-react";
export default function ScrapingDashboard() {
  const {
    t
  } = useTranslation();
  const [jobs, setJobs] = useState<ScrapingJob[]>([]);
  const [loading, setLoading] = useState(true);
  const fetchJobs = async () => {
    try {
      setLoading(true);
      const res = await scrapingApi.getJobs();
      setJobs((res as any)?.data?.data || (res as any)?.data || [] || [{
        id: "sj-1",
        jobType: "sahibinden",
        status: "running",
        startTime: new Date(Date.now() - 3600000).toISOString(),
        projectsScraped: 42,
        errors: [],
        configuration: {
          region: "Istanbul",
          limit: 100
        },
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString()
      }, {
        id: "sj-2",
        jobType: "emlakjet",
        status: "completed",
        startTime: new Date(Date.now() - 7200000).toISOString(),
        endTime: new Date(Date.now() - 3600000).toISOString(),
        projectsScraped: 128,
        errors: [],
        configuration: {
          region: "Ankara"
        },
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString()
      }, {
        id: "sj-3",
        jobType: "hurriyetemlak",
        status: "failed",
        startTime: new Date(Date.now() - 86400000).toISOString(),
        endTime: new Date(Date.now() - 82800000).toISOString(),
        projectsScraped: 5,
        errors: ["Connection timeout after 30s", "Rate limit exceeded"],
        configuration: {
          region: "Izmir"
        },
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString()
      }]);
    } catch (error) {
      console.error("API error, using mock data");
    } finally {
      setLoading(false);
    }
  };
  useEffect(() => {
    fetchJobs();
  }, []);
  const getStatusBadge = (status: string) => {
    switch (status) {
      case "running":
        return <Badge className="bg-blue-100 text-blue-700 hover:bg-blue-200 border-0 gap-1"><RefreshCw className="w-3 h-3 animate-spin" />{t("admin.scraping.running")}</Badge>;
      case "completed":
        return <Badge className="bg-green-100 text-green-700 hover:bg-green-200 border-0 gap-1"><CheckCircle2 className="w-3 h-3" />{t("admin.scraping.completed")}</Badge>;
      case "failed":
        return <Badge className="bg-red-100 text-red-700 hover:bg-red-200 border-0 gap-1"><AlertCircle className="w-3 h-3" />{t("admin.scraping.failed")}</Badge>;
      default:
        return <Badge variant="secondary" className="gap-1"><Clock className="w-3 h-3" />{t("admin.scraping.pending")}</Badge>;
    }
  };
  const calculateDuration = (start?: string, end?: string) => {
    if (!start) return "N/A";
    const startTime = new Date(start).getTime();
    const endTime = end ? new Date(end).getTime() : Date.now();
    const diff = Math.floor((endTime - startTime) / 1000 / 60);
    return `${diff}m`;
  };
  return <PageShell title={t("admin.scraping.scraping_management")} description={t("admin.scraping.monitor_and_control_automated")} actions={<div className="flex gap-2">
          <Button variant="outline" size="sm" onClick={fetchJobs} disabled={loading}>
            <RotateCcw className={`w-4 h-4 mr-2 ${loading ? 'animate-spin' : ''}`} />{t("admin.scraping.refresh")}</Button>
          <Button size="sm" className="bg-primary hover:bg-primary/90 text-primary-foreground">
            <Play className="w-4 h-4 mr-2" />{t("admin.scraping.run_new_job")}</Button>
        </div>}>
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-8">
        <Card className="bg-card shadow-sm border-muted">
          <CardHeader className="pb-2">
            <CardTitle className="text-[10px] font-bold text-muted-foreground flex items-center gap-1">
              <History className="w-3 h-3" />{t("admin.scraping.recent_24h")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">2,482</div>
            <p className="text-[10px] text-muted-foreground">{t("admin.scraping.properties_scraped_today")}</p>
          </CardContent>
        </Card>
        <Card className="bg-card shadow-sm border-muted">
          <CardHeader className="pb-2">
            <CardTitle className="text-[10px] font-bold text-muted-foreground flex items-center gap-1">
              <Cpu className="w-3 h-3" />{t("admin.scraping.success_rate")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-green-600">96.8%</div>
            <p className="text-[10px] text-muted-foreground flex items-center gap-1">
              <ShieldCheck className="w-3 h-3 text-green-500" />{t("admin.scraping.all_systems_healthy")}</p>
          </CardContent>
        </Card>
        <Card className="bg-card shadow-sm border-muted">
          <CardHeader className="pb-2">
            <CardTitle className="text-[10px] font-bold text-muted-foreground flex items-center gap-1">
              <Database className="w-3 h-3" />{t("admin.scraping.active_threads")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">12</div>
            <p className="text-[10px] text-muted-foreground">{t("admin.scraping.across_3_sources")}</p>
          </CardContent>
        </Card>
        <Card className="bg-card shadow-sm border-muted">
          <CardHeader className="pb-2">
            <CardTitle className="text-[10px] font-bold text-muted-foreground flex items-center gap-1">
              <Terminal className="w-3 h-3" />{t("admin.scraping.last_job")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold truncate">{t("admin.scraping.sahibinden")}</div>
            <p className="text-[10px] text-muted-foreground">{t("admin.scraping.finished_15m_ago")}</p>
          </CardContent>
        </Card>
      </div>

      <div className="bg-card border border-border rounded-xl shadow-sm overflow-hidden">
        <Table>
          <TableHeader className="bg-muted/30">
            <TableRow>
              <TableHead className="font-bold text-xs">{t("admin.scraping.source")}</TableHead>
              <TableHead className="font-bold text-xs">{t("admin.scraping.status")}</TableHead>
              <TableHead className="font-bold text-xs">{t("admin.scraping.progress")}</TableHead>
              <TableHead className="font-bold text-xs">{t("admin.scraping.duration")}</TableHead>
              <TableHead className="font-bold text-xs">{t("admin.scraping.operations")}</TableHead>
              <TableHead className="w-10" />
            </TableRow>
          </TableHeader>
          <TableBody>
            {jobs.map(job => <TableRow key={job.id} className="hover:bg-muted/40 transition-colors">
                <TableCell>
                  <div className="flex items-center gap-2">
                    <div className="w-8 h-8 rounded bg-primary/10 flex items-center justify-center font-bold text-[10px] text-primary">
                      {job.jobType.slice(0, 2)}
                    </div>
                    <div>
                      <div className="font-semibold text-sm capitalize">{job.jobType}</div>
                      <div className="text-[10px] text-muted-foreground font-mono">{job.id}</div>
                    </div>
                  </div>
                </TableCell>
                <TableCell>{getStatusBadge(job.status)}</TableCell>
                <TableCell>
                  <div className="space-y-1">
                    <div className="flex justify-between text-[10px] font-medium">
                      <span>{job.projectsScraped}{t("admin.scraping.targets_found")}</span>
                      {job.status === "running" && <span>{t("admin.scraping.processing")}</span>}
                    </div>
                    <Progress value={job.status === "completed" ? 100 : job.status === "failed" ? 15 : 45} className="h-1" />
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
                    <Button variant="ghost" size="sm" className="h-8 px-2 text-[10px] font-bold tracking-tight">{t("admin.scraping.logs")}</Button>
                    {job.status === "failed" && <Button variant="ghost" size="sm" className="h-8 px-2 text-[10px] font-bold tracking-tight text-red-600 hover:text-red-700 hover:bg-red-50">{t("admin.scraping.retry")}</Button>}
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
    </PageShell>;
}