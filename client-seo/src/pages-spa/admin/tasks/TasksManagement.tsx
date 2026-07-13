"use client";

import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { useTranslation } from"react-i18next";
import { CheckSquare, Plus, Clock, AlertCircle, Activity, Edit, Trash2 } from 'lucide-react';
import { Button } from"@/components/ui/button";
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { apiClient } from '@/lib/api';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from"@/components/ui/dialog";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { useState } from 'react';

const TasksManagement = () => {
 const { t } = useTranslation();
 const queryClient = useQueryClient();
 const [isAddModalOpen, setIsAddModalOpen] = useState(false);
 const [newTask, setNewTask] = useState({ title: '', description: '', priority: 'MEDIUM', type: 'ADMIN' });

 const { data: tasksRes, isLoading } = useQuery({
 queryKey: ['admin-tasks'],
 queryFn: async () => {
 const res: any = await apiClient.get('/task');
 return res.data;
 }
 });

 const createMutation = useMutation({
 mutationFn: async (data: any) => {
 return apiClient.post('/task', { 
 ...data, 
 orgId: 'org_1'
 });
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-tasks'] });
 setIsAddModalOpen(false);
 setNewTask({ title: '', description: '', priority: 'MEDIUM', type: 'ADMIN' });
 }
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => {
 return apiClient.delete(`/task/${id}`);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-tasks'] });
 }
 });

 const handleAddSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 createMutation.mutate(newTask);
 };

 const tasks = tasksRes?.data || [];
 
 return (
 <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
 <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
 <div>
 <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-slate-400 to-slate-400">
 {t("admin_tasks_title","Tasks & Workflow")}
 </h1>
 <p className="text-muted-foreground mt-2">
 {t("admin_tasks_subtitle","Centralized workflow management for internal teams and operations")}
 </p>
 </div>
 <div className="flex gap-2">
 <Button variant="outline" className="bg-card border-border hover:bg-white/10">
 {t("common.export","Export")}
 </Button>
 <Dialog open={isAddModalOpen} onOpenChange={setIsAddModalOpen}>
 <DialogTrigger asChild>
 <Button className="bg-slate-600 hover:bg-slate-700 text-foreground shadow-lg shadow-slate-500/20">
 <Plus className="w-4 h-4 mr-2" />
 {t("admin_tasks_add","New Task")}
 </Button>
 </DialogTrigger>
 <DialogContent className="sm:max-w-[425px] bg-background border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_tasks_add","New Task")}</DialogTitle>
 </DialogHeader>
 <form onSubmit={handleAddSubmit} className="space-y-4 pt-4">
 <div className="space-y-2">
 <Label htmlFor="title">Task Title</Label>
 <Input 
 id="title" 
 className="bg-card border-border" 
 value={newTask.title}
 onChange={e => setNewTask({...newTask, title: e.target.value})}
 required
 />
 </div>
 <div className="space-y-2">
 <Label htmlFor="description">Description</Label>
 <Input 
 id="description" 
 className="bg-card border-border" 
 value={newTask.description}
 onChange={e => setNewTask({...newTask, description: e.target.value})}
 />
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label htmlFor="priority">Priority</Label>
 <Input 
 id="priority" 
 className="bg-card border-border" 
 value={newTask.priority}
 onChange={e => setNewTask({...newTask, priority: e.target.value})}
 placeholder="LOW, MEDIUM, HIGH"
 />
 </div>
 <div className="space-y-2">
 <Label htmlFor="type">Task Type</Label>
 <Input 
 id="type" 
 className="bg-card border-border" 
 value={newTask.type}
 onChange={e => setNewTask({...newTask, type: e.target.value})}
 placeholder="ADMIN, OTHER"
 />
 </div>
 </div>
 <div className="pt-4 flex justify-end gap-2">
 <Button type="button" variant="ghost" onClick={() => setIsAddModalOpen(false)}>Cancel</Button>
 <Button type="submit" className="bg-slate-600 hover:bg-slate-700" disabled={createMutation.isPending}>
 {createMutation.isPending ?"Saving..." :"Create Task"}
 </Button>
 </div>
 </form>
 </DialogContent>
 </Dialog>
 </div>
 </div>

 <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-slate-300">Total Tasks</CardTitle>
 <Activity className="w-4 h-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">4,291</div>
 <p className="text-xs text-green-400 mt-1">+12% from last week</p>
 </CardContent>
 </Card>
 
 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-slate-300">Pending</CardTitle>
 <Clock className="w-4 h-4 text-amber-400" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">842</div>
 <p className="text-xs text-muted-foreground mt-1">Requires action</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-slate-300">Overdue</CardTitle>
 <AlertCircle className="w-4 h-4 text-red-400" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">45</div>
 <p className="text-xs text-red-400 mt-1">Critical priority</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-slate-300">Completed</CardTitle>
 <CheckSquare className="w-4 h-4 text-green-400" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">3,404</div>
 <p className="text-xs text-muted-foreground mt-1">This month</p>
 </CardContent>
 </Card>
 </div>

 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_tasks_list","Global Task Board")}</CardTitle>
 </CardHeader>
 <CardContent>
 {isLoading ? (
 <div className="flex items-center justify-center py-20 text-muted-foreground">
 {t("common.loading","Loading workflow tasks...")}
 </div>
 ) : tasks.length === 0 ? (
 <div className="flex items-center justify-center py-20 text-muted-foreground">
 No tasks found.
 </div>
 ) : (
 <div className="rounded-xl border border-border">
 <Table>
 <TableHeader>
 <TableRow className="border-border hover:bg-transparent">
 <TableHead className="text-slate-300">Title</TableHead>
 <TableHead className="text-slate-300">Type</TableHead>
 <TableHead className="text-slate-300">Priority</TableHead>
 <TableHead className="text-slate-300">Status</TableHead>
 <TableHead className="text-slate-300 text-right">Actions</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {tasks.map((t: any) => (
 <TableRow key={t.id} className="border-border hover:bg-card transition-colors">
 <TableCell className="font-medium text-foreground">{t.title}</TableCell>
 <TableCell className="text-muted-foreground">{t.type}</TableCell>
 <TableCell className={`text-muted-foreground ${t.priority === 'HIGH' ? 'text-red-400' : ''}`}>
 {t.priority}
 </TableCell>
 <TableCell className="text-muted-foreground">
 <span className="px-2 py-1 bg-card rounded-full text-xs">
 {t.status}
 </span>
 </TableCell>
 <TableCell className="text-right">
 <Button variant="ghost" size="icon" className="text-muted-foreground hover:text-white">
 <Edit className="w-4 h-4" />
 </Button>
 <Button 
 variant="ghost" 
 size="icon" 
 className="text-red-400 hover:text-red-300 hover:bg-red-400/10"
 onClick={() => deleteMutation.mutate(t.id)}
 disabled={deleteMutation.isPending}
 >
 <Trash2 className="w-4 h-4" />
 </Button>
 </TableCell>
 </TableRow>
 ))}
 </TableBody>
 </Table>
 </div>
 )}
 </CardContent>
 </Card>
 </div>
 );
};

export default TasksManagement;
