const fs = require('fs');
const path = require('path');
const file = path.join(__dirname, 'client/src/pages/admin/agents/AgentsManagement.tsx');
let code = fs.readFileSync(file, 'utf8');

// The file doesn't have useQuery or api. Let's replace the whole file content
const fullRewrite = `
import React, { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { useTranslation } from "react-i18next";
import { BadgeCheck, Plus, UserCircle, Star, Target, MoreHorizontal, Edit, Trash2 } from 'lucide-react';
import { Button } from "@/components/ui/button";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import api from '@/lib/api';
import { useToast } from "@/hooks/use-toast";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";

const AgentsManagement = () => {
  const { t } = useTranslation();
  const queryClient = useQueryClient();
  const { toast } = useToast();
  
  const [isInviteOpen, setIsInviteOpen] = useState(false);
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [editingId, setEditingId] = useState<string | null>(null);
  const [formData, setFormData] = useState({ name: '', email: '', role: 'Agent', licenseNumber: '', specialization: '' });

  const { data: agentsRes, isLoading } = useQuery({
    queryKey: ['admin-agents'],
    queryFn: async () => {
      const res: any = await api.get('/agent');
      return res.data;
    }
  });

  const createMutation = useMutation({
    mutationFn: async (data: any) => api.post('/agent', data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['admin-agents'] });
      setIsInviteOpen(false);
      setFormData({ name: '', email: '', role: 'Agent', licenseNumber: '', specialization: '' });
      toast({ title: "Success", description: "Agent created successfully" });
    }
  });

  const updateMutation = useMutation({
    mutationFn: async (data: any) => api.put(\`/agent/\${editingId}\`, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['admin-agents'] });
      setIsEditOpen(false);
      setEditingId(null);
      setFormData({ name: '', email: '', role: 'Agent', licenseNumber: '', specialization: '' });
      toast({ title: "Updated", description: "Agent updated successfully" });
    }
  });

  const deleteMutation = useMutation({
    mutationFn: async (id: string) => api.delete(\`/agent/\${id}\`),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['admin-agents'] });
      toast({ title: "Deleted", description: "Agent deleted successfully" });
    }
  });

  const agents = agentsRes?.data || [];

  const openEdit = (a: any) => {
    setEditingId(a.id);
    setFormData({
      name: a.name || '',
      email: a.email || '',
      role: a.role || 'Agent',
      licenseNumber: a.licenseNumber || '',
      specialization: a.specialization || ''
    });
    setIsEditOpen(true);
  };

  return (
    <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
        <div>
          <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-linear-to-r from-purple-400 to-pink-400">
            {t("admin.agents.title", "Agent Management")}
          </h1>
          <p className="text-slate-400 mt-2">
            {t("admin.agents.subtitle", "Monitor agent performance, licenses, and operational status")}
          </p>
        </div>
        <div className="flex gap-2">
          <Button variant="outline" className="bg-white/5 border-white/10 hover:bg-white/10">
            {t("common.export", "Export")}
          </Button>
          
          <Dialog open={isInviteOpen} onOpenChange={setIsInviteOpen}>
            <DialogTrigger asChild>
              <Button className="bg-purple-600 hover:bg-purple-700 text-white shadow-lg shadow-purple-500/20">
                <Plus className="w-4 h-4 mr-2" />
                {t("admin.agents.add", "Invite Agent")}
              </Button>
            </DialogTrigger>
            <DialogContent className="sm:max-w-[425px] bg-slate-900 text-white border-white/10">
              <DialogHeader>
                <DialogTitle>{t("admin.agents.add", "Invite Agent")}</DialogTitle>
                <DialogDescription className="text-slate-400">
                  Enter the details of the agent you want to invite to the platform.
                </DialogDescription>
              </DialogHeader>
              <form onSubmit={e => { e.preventDefault(); createMutation.mutate(formData); }} className="grid gap-4 py-4">
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="name" className="text-right text-slate-300">Name</Label>
                  <Input id="name" required value={formData.name} onChange={(e) => setFormData({...formData, name: e.target.value})} className="col-span-3 bg-white/5 border-white/10 text-white" />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="email" className="text-right text-slate-300">Email</Label>
                  <Input id="email" type="email" required value={formData.email} onChange={(e) => setFormData({...formData, email: e.target.value})} className="col-span-3 bg-white/5 border-white/10 text-white" />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="license" className="text-right text-slate-300">License</Label>
                  <Input id="license" value={formData.licenseNumber} onChange={(e) => setFormData({...formData, licenseNumber: e.target.value})} className="col-span-3 bg-white/5 border-white/10 text-white" />
                </div>
                <DialogFooter className="mt-4">
                  <Button type="button" variant="outline" className="bg-transparent border-white/10 text-white hover:bg-white/5" onClick={() => setIsInviteOpen(false)}>Cancel</Button>
                  <Button type="submit" disabled={createMutation.isPending} className="bg-purple-600 hover:bg-purple-700 text-white">{createMutation.isPending ? 'Saving...' : 'Send Invitation'}</Button>
                </DialogFooter>
              </form>
            </DialogContent>
          </Dialog>

          <Dialog open={isEditOpen} onOpenChange={setIsEditOpen}>
            <DialogContent className="sm:max-w-[425px] bg-slate-900 text-white border-white/10">
              <DialogHeader>
                <DialogTitle>Edit Agent</DialogTitle>
              </DialogHeader>
              <form onSubmit={e => { e.preventDefault(); updateMutation.mutate(formData); }} className="grid gap-4 py-4">
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="edit-name" className="text-right text-slate-300">Name</Label>
                  <Input id="edit-name" required value={formData.name} onChange={(e) => setFormData({...formData, name: e.target.value})} className="col-span-3 bg-white/5 border-white/10 text-white" />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="edit-email" className="text-right text-slate-300">Email</Label>
                  <Input id="edit-email" type="email" required value={formData.email} onChange={(e) => setFormData({...formData, email: e.target.value})} className="col-span-3 bg-white/5 border-white/10 text-white" />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="edit-license" className="text-right text-slate-300">License</Label>
                  <Input id="edit-license" value={formData.licenseNumber} onChange={(e) => setFormData({...formData, licenseNumber: e.target.value})} className="col-span-3 bg-white/5 border-white/10 text-white" />
                </div>
                <DialogFooter className="mt-4">
                  <Button type="button" variant="outline" className="bg-transparent border-white/10 text-white hover:bg-white/5" onClick={() => setIsEditOpen(false)}>Cancel</Button>
                  <Button type="submit" disabled={updateMutation.isPending} className="bg-purple-600 hover:bg-purple-700 text-white">{updateMutation.isPending ? 'Saving...' : 'Update Agent'}</Button>
                </DialogFooter>
              </form>
            </DialogContent>
          </Dialog>
        </div>
      </div>

      <Card className="bg-white/5 border-white/10 backdrop-blur-sm">
        <CardHeader>
          <CardTitle className="text-white">Agent Directory</CardTitle>
        </CardHeader>
        <CardContent>
          {isLoading ? (
            <div className="flex items-center justify-center py-20 text-slate-400">Loading...</div>
          ) : agents.length === 0 ? (
            <div className="flex items-center justify-center py-20 text-slate-400">No agents found.</div>
          ) : (
            <div className="rounded-md border border-white/10">
              <Table>
                <TableHeader>
                  <TableRow className="border-white/10 hover:bg-transparent">
                    <TableHead className="text-slate-300">Name</TableHead>
                    <TableHead className="text-slate-300">Email</TableHead>
                    <TableHead className="text-slate-300">License</TableHead>
                    <TableHead className="text-slate-300 text-right">Actions</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {agents.map((a: any) => (
                    <TableRow key={a.id} className="border-white/10 hover:bg-white/5 transition-colors">
                      <TableCell className="font-medium text-white">{a.name}</TableCell>
                      <TableCell className="text-slate-400">{a.email}</TableCell>
                      <TableCell className="text-slate-400">{a.licenseNumber || 'N/A'}</TableCell>
                      <TableCell className="text-right">
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild>
                            <Button variant="ghost" className="h-8 w-8 p-0"><MoreHorizontal className="h-4 w-4 text-slate-400" /></Button>
                          </DropdownMenuTrigger>
                          <DropdownMenuContent align="end" className="bg-slate-900 border-white/10 text-white">
                            <DropdownMenuItem onClick={() => openEdit(a)} className="cursor-pointer hover:bg-white/10"><Edit className="mr-2 h-4 w-4" /> Edit</DropdownMenuItem>
                            <DropdownMenuItem onClick={() => deleteMutation.mutate(a.id)} className="cursor-pointer text-red-400 hover:bg-red-400/10"><Trash2 className="mr-2 h-4 w-4" /> Delete</DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
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

export default AgentsManagement;
`;

fs.writeFileSync(file, fullRewrite);
console.log("Rewrote AgentsManagement.tsx");
