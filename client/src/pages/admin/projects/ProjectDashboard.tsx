import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { BarChart3, AlertTriangle, FileText, Calendar, Clock, DollarSign, TrendingUp, Plus, ArrowRight, MoreVertical, Filter } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { projectsApi, type Project, type ProjectAlert } from "@/lib/api/projects";
import { useToast } from "@/hooks/use-toast";
export default function ProjectDashboard() {
  const {
    t
  } = useTranslation();
  const { toast } = useToast();
  const [projects, setProjects] = useState<Project[]>([]);
  const [alerts, setAlerts] = useState<ProjectAlert[]>([]);
  useEffect(() => {
    fetchData();
  }, []);
  const fetchData = async () => {
    try {
      const projectsRes = await projectsApi.getProjects();
      setProjects(projectsRes);
      // For now, getting alerts from first project or mock if none
      if (projectsRes.length > 0) {
        const alertsRes = await projectsApi.getProjectAlerts(projectsRes[0].id);
        setAlerts(alertsRes);
      }
    } catch (error) {
      console.error("Error fetching projects:", error);
    }
  };
  return <div className="container mx-auto py-8 px-4">
      <div className="flex flex-col md:flex-row md:items-center justify-between mb-8 gap-4">
        <div>
          <h1 className="text-3xl font-bold tracking-tight">{t("admin.projects.project_management")}</h1>
          <p className="text-muted-foreground mt-1">{t("admin.projects.track_renovations_construction_and")}</p>
        </div>
        <div className="flex items-center gap-2">
          <Button variant="outline" onClick={() => toast({ title: t("admin.projects.filters"), description: "Opening filters..." })}>
            <Filter className="w-4 h-4 mr-2" />{t("admin.projects.filters")}</Button>
          <Button className="bg-primary" onClick={() => toast({ title: t("admin.projects.new_project"), description: "Opening creation modal..." })}>
            <Plus className="w-4 h-4 mr-2" />{t("admin.projects.new_project")}</Button>
        </div>
      </div>

      {/* Summary Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <Card className="shadow-premium border-none bg-primary text-primary-foreground">
          <CardContent className="pt-6">
            <div className="flex justify-between items-start">
              <div>
                <p className="text-primary-foreground/80 text-sm font-medium">{t("admin.projects.active_projects")}</p>
                <h3 className="text-3xl font-bold mt-1">{projects.length}</h3>
              </div>
              <div className="p-2 bg-muted/50 rounded-lg">
                <BarChart3 className="w-5 h-5 text-foreground" />
              </div>
            </div>
            <div className="mt-4 flex items-center gap-2 text-sm text-primary-foreground/90">
              <TrendingUp className="w-4 h-4" />
              <span>{t("admin.projects.2_from_last_month")}</span>
            </div>
          </CardContent>
        </Card>

        <Card className="shadow-premium border-none">
          <CardContent className="pt-6">
            <div className="flex justify-between items-start">
              <div>
                <p className="text-muted-foreground text-sm font-medium">{t("admin.projects.critical_alerts")}</p>
                <h3 className="text-3xl font-bold mt-1 text-red-500">{alerts.filter(a => a.severity === "CRITICAL").length}</h3>
              </div>
              <div className="p-2 bg-red-100 rounded-lg">
                <AlertTriangle className="w-5 h-5 text-red-500" />
              </div>
            </div>
            <div className="mt-4 flex items-center gap-2 text-sm text-muted-foreground">
              <Clock className="w-4 h-4" />
              <span>{t("admin.projects.needs_immediate_attention")}</span>
            </div>
          </CardContent>
        </Card>

        <Card className="shadow-premium border-none">
          <CardContent className="pt-6">
            <div className="flex justify-between items-start">
              <div>
                <p className="text-muted-foreground text-sm font-medium">{t("admin.projects.total_budget")}</p>
                <h3 className="text-3xl font-bold mt-1">{t("admin.projects.4285k")}</h3>
              </div>
              <div className="p-2 bg-blue-100 rounded-lg">
                <DollarSign className="w-5 h-5 text-blue-500" />
              </div>
            </div>
            <div className="mt-4 flex items-center gap-2 text-sm text-muted-foreground">
              <Progress value={65} className="h-1.5" />
              <span className="mt-1 block">{t("admin.projects.65_utilized")}</span>
            </div>
          </CardContent>
        </Card>

        <Card className="shadow-premium border-none">
          <CardContent className="pt-6">
            <div className="flex justify-between items-start">
              <div>
                <p className="text-muted-foreground text-sm font-medium">{t("admin.projects.reports_generated")}</p>
                <h3 className="text-3xl font-bold mt-1">24</h3>
              </div>
              <div className="p-2 bg-green-100 rounded-lg">
                <FileText className="w-5 h-5 text-green-500" />
              </div>
            </div>
            <div className="mt-4 flex items-center gap-2 text-sm text-green-600 font-medium">
              <span>{t("admin.projects.weekly_report_ready")}</span>
              <ArrowRight className="w-4 h-4" />
            </div>
          </CardContent>
        </Card>
      </div>

      <Tabs defaultValue="projects" className="space-y-6">
        <TabsList className="bg-secondary/20 p-1">
          <TabsTrigger value="projects">{t("admin.projects.all_projects")}</TabsTrigger>
          <TabsTrigger value="alerts">{t("admin.projects.alerts_notifications")}</TabsTrigger>
          <TabsTrigger value="analytics">{t("admin.projects.analytics")}</TabsTrigger>
          <TabsTrigger value="reports">{t("admin.projects.reports")}</TabsTrigger>
        </TabsList>

        <TabsContent value="projects" className="space-y-6">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            {projects.length > 0 ? projects.map(project => <Card key={project.id} className="shadow-sm border-none bg-secondary/5 hover:bg-secondary/10 transition-colors">
                <CardHeader className="flex flex-row items-start justify-between">
                  <div>
                    <CardTitle>{project.name}</CardTitle>
                    <CardDescription>{project.projectType}</CardDescription>
                  </div>
                  <Badge variant={project.status === "ACTIVE" ? "default" : "outline"}>
                    {project.status}
                  </Badge>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    <div className="flex justify-between text-sm">
                      <span className="text-muted-foreground">{t("admin.projects.progress")}</span>
                      <span className="font-medium">75%</span>
                    </div>
                    <Progress value={75} className="h-2" />
                    
                    <div className="grid grid-cols-2 gap-4 pt-2">
                      <div className="flex items-center gap-2 text-sm">
                        <Calendar className="w-4 h-4 text-muted-foreground" />
                        <span>{t("admin.projects.ends")}{project.estimatedEndDate || "TBD"}</span>
                      </div>
                      <div className="flex items-center gap-2 text-sm">
                        <DollarSign className="w-4 h-4 text-muted-foreground" />
                        <span>{t("admin.projects.budget")}{project.budget?.toLocaleString()}</span>
                      </div>
                    </div>

                    <div className="pt-4 flex justify-end gap-2">
                        <Button variant="ghost" size="sm" onClick={() => toast({ title: "Project Details", description: `Viewing details for ${project.name}` })}>{t("admin.projects.details")}</Button>
                        <Button size="sm" onClick={() => toast({ title: "Manage Project", description: `Managing ${project.name}` })}>{t("admin.projects.manage")}</Button>
                    </div>
                  </div>
                </CardContent>
              </Card>) : <div className="col-span-full py-12 text-center border-2 border-dashed rounded-xl">
                <p className="text-muted-foreground">{t("admin.projects.no_active_projects_found")}</p>
              </div>}
          </div>
        </TabsContent>

        <TabsContent value="alerts">
          <Card>
            <CardHeader>
              <CardTitle>{t("admin.projects.system_alerts")}</CardTitle>
              <CardDescription>{t("admin.projects.critical_updates_from_ai")}</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {alerts.length > 0 ? alerts.map(alert => <div key={alert.id} className="flex items-start gap-4 p-4 rounded-lg bg-secondary/10">
                    <AlertTriangle className={`w-5 h-5 mt-0.5 ${alert.severity === "CRITICAL" ? "text-red-500" : "text-yellow-500"}`} />
                    <div className="flex-1">
                      <div className="flex justify-between items-start">
                        <h4 className="font-semibold">{alert.type}</h4>
                        <span className="text-xs text-muted-foreground text-nowrap">{alert.createdAt}</span>
                      </div>
                      <p className="text-sm text-muted-foreground mt-1">{alert.message}</p>
                    </div>
                    <Button variant="ghost" size="icon">
                        <MoreVertical className="w-4 h-4" />
                    </Button>
                  </div>) : <p className="text-center py-8 text-muted-foreground">{t("admin.projects.no_active_alerts")}</p>}
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>;
}