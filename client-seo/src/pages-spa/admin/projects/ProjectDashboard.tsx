"use client";

import React from 'react';
import { apiClient } from"@/lib/api/client";
import { useQuery, useMutation, useQueryClient } from"@tanstack/react-query";
import { useTranslation } from"react-i18next";
import { useState } from"react";
import { BarChart3, AlertTriangle, FileText, Calendar, Clock, DollarSign, TrendingUp, Plus, ArrowRight, MoreVertical, Filter } from"lucide-react";
import { Button } from"@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from"@/components/ui/card";
import { Badge } from"@/components/ui/badge";
import { Progress } from"@/components/ui/progress";
import { Tabs, TabsContent, TabsList, TabsTrigger } from"@/components/ui/tabs";
import { projectsApi, type Project, type ProjectAlert } from"@/lib/api/projects";
import { useToast } from"@/hooks/use-toast";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from"@/components/ui/dialog";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { MoreHorizontal, Edit, Trash2 } from"lucide-react";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";

export default function ProjectDashboard() {
 const { toast } = useToast();
 const queryClient = useQueryClient();
 const { t } = useTranslation();
 const [isAddOpen, setIsAddOpen] = useState(false);
 const [formData, setFormData] = React.useState({ name:"", status:"", budget:"" });

 const { data: projects = [], isLoading: projectsLoading } = useQuery({
 queryKey: ['projects'],
 queryFn: async () => {
 const res = await projectsApi.getProjects();
 return res || [];
 },
 });

 const { data: alerts = [] } = useQuery({
 queryKey: ['project-alerts'],
 queryFn: async () => {
 if (projects.length > 0) {
 const alertsRes = await projectsApi.getProjectAlerts(projects[0].id);
 return alertsRes || [];
 }
 return [];
 },
 enabled: projects.length > 0,
 });

 const createMutation = useMutation({
 mutationFn: async (data: any) => {
 const res = await apiClient.post('/projects', data);
 return res;
 },
 onSuccess: () => {
 setIsAddOpen(false);
 queryClient.invalidateQueries({ queryKey: ['projects'] });
 toast({ title:"Success", description:"Project created successfully" });
 },
 onError: (err: any) => {
 toast({ title:"Error", description: err.message, variant:"destructive" });
 }
 });

 const updateMutation = useMutation({
 mutationFn: async (data: any) => apiClient.put(`/projects/${data.id}`, data),
 onSuccess: () => {
 toast({ title:"Updated", description:"Record updated successfully" });
 queryClient.invalidateQueries({ queryKey: ['projects'] });
 },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/projects/${id}`),
 onSuccess: () => {
 toast({ title:"Deleted", description:"Record deleted successfully" });
 queryClient.invalidateQueries({ queryKey: ['projects'] });
 },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });

 return (<div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-6">
 <div className="bg-card p-6 rounded-2xl border border-border flex flex-col md:flex-row md:items-center justify-between gap-4">
 <div>
 <h1 className="text-3xl font-bold tracking-tight text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_projects_project_management")}</h1>
 <p className="text-muted-foreground mt-1">{t("admin_projects_track_renovations_construction_and")}</p>
 </div>
 <div className="flex items-center gap-2">
 <Button variant="outline" className="border-border text-muted-foreground hover:text-foreground" onClick={() => toast({ title: t("admin_projects_filters"), description:"Opening filters..." })}>
 <Filter className="w-4 h-4 mr-2" />{t("admin_projects_filters")}
 </Button>
 <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
 <DialogTrigger asChild>
 <Button className="bg-slate-600 hover:bg-muted0 text-foreground">
 <Plus className="w-4 h-4 mr-2" />{t("admin_projects_new_project")}
 </Button>
 </DialogTrigger>
 <DialogContent className="sm:max-w-[425px] bg-card border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_auto_create_new_project", "Create New Project")}</DialogTitle>
 <DialogDescription className="text-muted-foreground">{t("admin_auto_enter_the_details_for_the_new_project", "Enter the details for the new project.")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="name" className="text-right text-xs text-muted-foreground">{t("admin_auto_project_name", "Project Name")}</Label>
 <Input id="name" className="col-span-3 h-10 bg-card border-border text-foreground" value={formData.name} onChange={e => setFormData({ ...formData, name: e.target.value })} placeholder={t("admin_auto_enter_project_name", "Enter project name")} />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="status" className="text-right text-xs text-muted-foreground">{t("admin_auto_status", "Status")}</Label>
 <Input id="status" className="col-span-3 h-10 bg-card border-border text-foreground" value={formData.status} onChange={e => setFormData({ ...formData, status: e.target.value })} placeholder={t("admin_auto_enter_status", "Enter status")} />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="budget" className="text-right text-xs text-muted-foreground">{t("admin_auto_budget", "Budget")}</Label>
 <Input id="budget" className="col-span-3 h-10 bg-card border-border text-foreground" value={formData.budget} onChange={e => setFormData({ ...formData, budget: e.target.value })} placeholder={t("admin_auto_enter_budget", "Enter budget")} />
 </div>
 </div>
 <DialogFooter>
 <Button variant="outline" onClick={() => setIsAddOpen(false)}>{t("admin_action_cancel", "Cancel")}</Button>
 <Button onClick={() => createMutation.mutate(formData)} disabled={createMutation.isPending}>
 {createMutation.isPending ?"Saving..." :"Save Changes"}
 </Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </div>
 </div>

 {/* Summary Cards */}
 <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
 <Card className="bg-card border-border">
 <CardContent className="pt-6">
 <div className="flex justify-between items-start">
 <div>
 <p className="text-muted-foreground text-sm font-medium">{t("admin_projects_active_projects")}</p>
 <h3 className="text-3xl font-bold mt-1 text-foreground">{projects.length}</h3>
 </div>
 <div className="p-2 bg-card rounded-lg">
 <BarChart3 className="w-5 h-5 text-muted-foreground" />
 </div>
 </div>
 <div className="mt-4 flex items-center gap-2 text-sm text-muted-foreground">
 <TrendingUp className="w-4 h-4" />
 <span>{t("admin_projects_2_from_last_month")}</span>
 </div>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardContent className="pt-6">
 <div className="flex justify-between items-start">
 <div>
 <p className="text-muted-foreground text-sm font-medium">{t("admin_projects_critical_alerts")}</p>
 <h3 className="text-3xl font-bold mt-1 text-red-500">{alerts.filter((a: ProjectAlert) => a.severity ==="CRITICAL").length}</h3>
 </div>
 <div className="p-2 bg-red-500/10 rounded-lg">
 <AlertTriangle className="w-5 h-5 text-red-400" />
 </div>
 </div>
 <div className="mt-4 flex items-center gap-2 text-sm text-muted-foreground">
 <Clock className="w-4 h-4" />
 <span>{t("admin_projects_needs_immediate_attention")}</span>
 </div>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardContent className="pt-6">
 <div className="flex justify-between items-start">
 <div>
 <p className="text-muted-foreground text-sm font-medium">{t("admin_projects_total_budget")}</p>
 <h3 className="text-3xl font-bold mt-1 text-foreground">{t("admin_projects_4285k")}</h3>
 </div>
 <div className="p-2 bg-muted0/10 rounded-lg">
 <DollarSign className="w-5 h-5 text-muted-foreground" />
 </div>
 </div>
 <div className="mt-4 flex items-center gap-2 text-sm text-muted-foreground">
 <Progress value={65} className="h-1.5 bg-card" />
 <span className="mt-1 block">{t("admin_projects_65_utilized")}</span>
 </div>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardContent className="pt-6">
 <div className="flex justify-between items-start">
 <div>
 <p className="text-muted-foreground text-sm font-medium">{t("admin_projects_reports_generated")}</p>
 <h3 className="text-3xl font-bold mt-1 text-foreground">24</h3>
 </div>
 <div className="p-2 bg-emerald-500/10 rounded-lg">
 <FileText className="w-5 h-5 text-emerald-400" />
 </div>
 </div>
 <div className="mt-4 flex items-center gap-2 text-sm text-emerald-400 font-medium">
 <span>{t("admin_projects_weekly_report_ready")}</span>
 <ArrowRight className="w-4 h-4" />
 </div>
 </CardContent>
 </Card>
 </div>

 <Tabs defaultValue="projects" className="space-y-6">
 <TabsList className="bg-card border border-border p-1">
 <TabsTrigger value="projects" className="text-muted-foreground data-[state=active]:bg-slate-600 data-[state=active]:text-white">{t("admin_projects_all_projects")}</TabsTrigger>
 <TabsTrigger value="alerts" className="text-muted-foreground data-[state=active]:bg-slate-600 data-[state=active]:text-white">{t("admin_projects_alerts_notifications")}</TabsTrigger>
 <TabsTrigger value="analytics" className="text-muted-foreground data-[state=active]:bg-slate-600 data-[state=active]:text-white">{t("admin_projects_analytics")}</TabsTrigger>
 <TabsTrigger value="reports" className="text-muted-foreground data-[state=active]:bg-slate-600 data-[state=active]:text-white">{t("admin_projects_reports")}</TabsTrigger>
 </TabsList>

 <TabsContent value="projects" className="space-y-6">
 <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
 {projects.length > 0 ? projects.map((project: Project) => (
 <Card key={project.id} className="bg-card border-border hover:bg-card transition-colors">
 <CardHeader className="flex flex-row items-start justify-between">
 <div>
 <CardTitle className="text-foreground">{project.name}</CardTitle>
 <CardDescription className="text-muted-foreground">{project.projectType}</CardDescription>
 </div>
 <Badge variant={project.status ==="ACTIVE" ?"default" :"outline"} className={project.status ==="ACTIVE" ?"bg-slate-600" :"border-border text-muted-foreground"}>
 {project.status}
 </Badge>
 </CardHeader>
 <CardContent>
 <div className="space-y-4">
 <div className="flex justify-between text-sm">
 <span className="text-muted-foreground">{t("admin_projects_progress")}</span>
 <span className="font-medium text-foreground">75%</span>
 </div>
 <Progress value={75} className="h-2 bg-card" />
 <div className="grid grid-cols-2 gap-4 pt-2">
 <div className="flex items-center gap-2 text-sm">
 <Calendar className="w-4 h-4 text-muted-foreground" />
 <span className="text-muted-foreground">{t("admin_projects_ends")}{project.estimatedEndDate ||"TBD"}</span>
 </div>
 <div className="flex items-center gap-2 text-sm">
 <DollarSign className="w-4 h-4 text-muted-foreground" />
 <span className="text-muted-foreground">{t("admin_projects_budget")}{project.budget?.toLocaleString()}</span>
 </div>
 </div>
 <div className="pt-4 flex justify-end gap-2">
 <Button variant="ghost" size="sm" className="text-muted-foreground hover:text-foreground" onClick={() => toast({ title:"Project Details", description: `Viewing details for ${project.name}` })}>{t("admin_projects_details")}</Button>
 <Button size="sm" className="bg-slate-600 hover:bg-muted0 text-foreground" onClick={() => toast({ title:"Manage Project", description: `Managing ${project.name}` })}>{t("admin_projects_manage")}</Button>
 </div>
 </div>
 </CardContent>
 </Card>
 )) : (
 <div className="col-span-full py-12 text-center border-2 border-dashed border-border rounded-xl">
 <p className="text-muted-foreground">{t("admin_projects_no_active_projects_found")}</p>
 </div>
 )}
 </div>
 </TabsContent>

 <TabsContent value="alerts">
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_projects_system_alerts")}</CardTitle>
 <CardDescription className="text-muted-foreground">{t("admin_projects_critical_updates_from_ai")}</CardDescription>
 </CardHeader>
 <CardContent>
 <div className="space-y-4">
 {alerts.length > 0 ? alerts.map((alert: ProjectAlert) => (
 <div key={alert.id} className="flex items-start gap-4 p-4 rounded-lg bg-card">
 <AlertTriangle className={`w-5 h-5 mt-0.5 ${alert.severity ==="CRITICAL" ?"text-red-500" :"text-yellow-500"}`} />
 <div className="flex-1">
 <div className="flex justify-between items-start">
 <h4 className="font-semibold text-foreground">{alert.type}</h4>
 <span className="text-xs text-muted-foreground text-nowrap">{alert.createdAt}</span>
 </div>
 <p className="text-sm text-muted-foreground mt-1">{alert.message}</p>
 </div>
 <Button variant="ghost" size="icon" className="text-muted-foreground hover:text-foreground">
 <MoreVertical className="w-4 h-4" />
 </Button>
 </div>
 )) : (
 <p className="text-center py-8 text-muted-foreground">{t("admin_projects_no_active_alerts")}</p>
 )}
 </div>
 </CardContent>
 </Card>
 </TabsContent>
 </Tabs>
 </div>
 );
}
