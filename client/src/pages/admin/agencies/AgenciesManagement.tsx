import { useToast } from "@/hooks/use-toast";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { useTranslation } from "react-i18next";
import { Building2, Plus, Users, Globe, Settings, Edit, Trash2 } from 'lucide-react';
import { Button } from "@/components/ui/button";
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import api from '@/lib/api';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useState } from 'react';

const AgenciesManagement = () => {
  const { t } = useTranslation();
  const queryClient = useQueryClient();
  const [isAddModalOpen, setIsAddModalOpen] = useState(false);
  const [newAgency, setNewAgency] = useState<any>({ name: '', email: '', phoneNumber: '', status: 'ACTIVE', website: '' });
  const { toast } = useToast();
  const [isEditModalOpen, setIsEditModalOpen] = useState(false);
  const [editingId, setEditingId] = useState<string | null>(null);

  const updateMutation = useMutation({
    mutationFn: async (data: any) => {
      return api.put(`/agency/${editingId}`, data);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['admin-agencies'] });
      setIsEditModalOpen(false);
      setEditingId(null);
      setNewAgency({ name: '', email: '', phoneNumber: '', status: 'ACTIVE', website: '' });
      toast({ title: "Success", description: "Agency updated successfully" });
    }
  });

  const handleEditClick = (agency: any) => {
    setEditingId(agency.id);
    setNewAgency({
      name: agency.name || '',
      email: agency.email || '',
      phoneNumber: agency.phoneNumber || '',
      status: agency.status || 'ACTIVE',
      website: agency.website || ''
    });
    setIsEditModalOpen(true);
  };


  const { data: agenciesRes, isLoading } = useQuery({
    queryKey: ['admin-agencies'],
    queryFn: async () => {
      const res: any = await api.get('/agency');
      return res.data;
    }
  });

  const createMutation = useMutation({
    mutationFn: async (data: any) => {
      return api.post('/agency', { 
        ...data, 
        organizationId: 'org_1'
      });
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['admin-agencies'] });
      setIsAddModalOpen(false);
      setNewAgency({ name: '', email: '', phoneNumber: '' });
    }
  });

  const deleteMutation = useMutation({
    mutationFn: async (id: string) => {
      return api.delete(`/agency/${id}`);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['admin-agencies'] });
    }
  });

  const handleAddSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    createMutation.mutate(newAgency);
  };

  const agencies = agenciesRes?.data || [];
  
  return (
    <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
        <div>
          <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-linear-to-r from-blue-400 to-indigo-400">
            {t("admin.agencies.title", "Agencies Management")}
          </h1>
          <p className="text-slate-400 mt-2">
            {t("admin.agencies.subtitle", "Manage real estate agencies, brokerage firms, and corporate accounts")}
          </p>
        </div>
        <div className="flex gap-2">
          <Button variant="outline" className="bg-white/5 border-white/10 hover:bg-white/10">
            <Globe className="w-4 h-4 mr-2" />
            {t("common.export", "Export")}
          </Button>
          <Dialog open={isAddModalOpen} onOpenChange={setIsAddModalOpen}>
            <DialogTrigger asChild>
              <Button className="bg-blue-600 hover:bg-blue-700 text-white shadow-lg shadow-blue-500/20">
                <Plus className="w-4 h-4 mr-2" />
                {t("admin.agencies.add", "Add Agency")}
              </Button>
            </DialogTrigger>
            <DialogContent className="sm:max-w-[425px] bg-slate-900 border-white/10 text-white">
              <DialogHeader>
                <DialogTitle>{t("admin.agencies.add", "Add Agency")}</DialogTitle>
              </DialogHeader>
              <form onSubmit={handleAddSubmit} className="space-y-4 pt-4">
                <div className="space-y-2">
                  <Label htmlFor="name">Agency Name</Label>
                  <Input 
                    id="name" 
                    className="bg-white/5 border-white/10" 
                    value={newAgency.name}
                    onChange={e => setNewAgency({...newAgency, name: e.target.value})}
                    required
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="email">Email</Label>
                  <Input 
                    id="email" 
                    type="email"
                    className="bg-white/5 border-white/10" 
                    value={newAgency.email}
                    onChange={e => setNewAgency({...newAgency, email: e.target.value})}
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="phoneNumber">Phone Number</Label>
                  <Input 
                    id="phoneNumber" 
                    className="bg-white/5 border-white/10" 
                    value={newAgency.phoneNumber}
                    onChange={e => setNewAgency({...newAgency, phoneNumber: e.target.value})}
                  />
                </div>
                
                <div className="space-y-2">
                  <Label htmlFor="website">Website</Label>
                  <Input 
                    id="website" 
                    className="bg-white/5 border-white/10" 
                    value={newAgency.website || ''}
                    onChange={e => setNewAgency({...newAgency, website: e.target.value})}
                  />
                </div>
                <div className="space-y-2">
                  <Label>Status</Label>
                  <Select value={newAgency.status} onValueChange={v => setNewAgency({...newAgency, status: v})}>
                    <SelectTrigger className="bg-white/5 border-white/10">
                      <SelectValue placeholder="Select status" />
                    </SelectTrigger>
                    <SelectContent className="bg-slate-900 border-white/10 text-white">
                      <SelectItem value="PENDING">Pending</SelectItem>
                      <SelectItem value="ACTIVE">Active</SelectItem>
                      <SelectItem value="INACTIVE">Inactive</SelectItem>
                      <SelectItem value="SUSPENDED">Suspended</SelectItem>
                    </SelectContent>
                  </Select>
                </div>

                <div className="pt-4 flex justify-end gap-2">
                  <Button type="button" variant="ghost" onClick={() => setIsAddModalOpen(false)}>Cancel</Button>
                  <Button type="submit" className="bg-blue-600 hover:bg-blue-700" disabled={createMutation.isPending}>
                    {createMutation.isPending ? "Saving..." : "Create Agency"}
                  </Button>
                </div>
              </form>
            </DialogContent>
          </Dialog>

          <Dialog open={isEditModalOpen} onOpenChange={setIsEditModalOpen}>
            <DialogContent className="sm:max-w-[425px] bg-slate-900 border-white/10 text-white">
              <DialogHeader>
                <DialogTitle>{t("admin.agencies.edit", "Edit Agency")}</DialogTitle>
              </DialogHeader>
              <form onSubmit={(e) => { e.preventDefault(); updateMutation.mutate(newAgency); }} className="space-y-4 pt-4">
                <div className="space-y-2">
                  <Label htmlFor="edit-name">Agency Name</Label>
                  <Input id="edit-name" className="bg-white/5 border-white/10" value={newAgency.name} onChange={e => setNewAgency({...newAgency, name: e.target.value})} required />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="edit-email">Email</Label>
                  <Input id="edit-email" type="email" className="bg-white/5 border-white/10" value={newAgency.email} onChange={e => setNewAgency({...newAgency, email: e.target.value})} />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="edit-phoneNumber">Phone Number</Label>
                  <Input id="edit-phoneNumber" className="bg-white/5 border-white/10" value={newAgency.phoneNumber} onChange={e => setNewAgency({...newAgency, phoneNumber: e.target.value})} />
                </div>
                <div className="space-y-2">
                  <Label>Status</Label>
                  <Select value={newAgency.status} onValueChange={v => setNewAgency({...newAgency, status: v})}>
                    <SelectTrigger className="bg-white/5 border-white/10"><SelectValue placeholder="Select status" /></SelectTrigger>
                    <SelectContent className="bg-slate-900 border-white/10 text-white">
                      <SelectItem value="PENDING">Pending</SelectItem>
                      <SelectItem value="ACTIVE">Active</SelectItem>
                      <SelectItem value="INACTIVE">Inactive</SelectItem>
                      <SelectItem value="SUSPENDED">Suspended</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div className="pt-4 flex justify-end gap-2">
                  <Button type="button" variant="ghost" onClick={() => setIsEditModalOpen(false)}>Cancel</Button>
                  <Button type="submit" className="bg-blue-600 hover:bg-blue-700" disabled={updateMutation.isPending}>
                    {updateMutation.isPending ? "Saving..." : "Update Agency"}
                  </Button>
                </div>
              </form>
            </DialogContent>
          </Dialog>

        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <Card className="bg-white/5 border-white/10 backdrop-blur-sm">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-300">Total Agencies</CardTitle>
            <Building2 className="w-4 h-4 text-blue-400" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-white">124</div>
            <p className="text-xs text-green-400 mt-1">+12 this month</p>
          </CardContent>
        </Card>
        
        <Card className="bg-white/5 border-white/10 backdrop-blur-sm">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-300">Active Agents</CardTitle>
            <Users className="w-4 h-4 text-purple-400" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-white">8,432</div>
            <p className="text-xs text-green-400 mt-1">+142 this month</p>
          </CardContent>
        </Card>

        <Card className="bg-white/5 border-white/10 backdrop-blur-sm">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-300">System Integration</CardTitle>
            <Settings className="w-4 h-4 text-amber-400" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-white">98%</div>
            <p className="text-xs text-slate-400 mt-1">API Health</p>
          </CardContent>
        </Card>
      </div>

      <Card className="bg-white/5 border-white/10 backdrop-blur-sm">
        <CardHeader>
          <CardTitle className="text-white">{t("admin.agencies.list", "Agency Directory")}</CardTitle>
        </CardHeader>
        <CardContent>
          {isLoading ? (
            <div className="flex items-center justify-center py-20 text-slate-400">
              {t("common.loading", "Loading data...")}
            </div>
          ) : agencies.length === 0 ? (
            <div className="flex items-center justify-center py-20 text-slate-400">
              No agencies found.
            </div>
          ) : (
            <div className="rounded-md border border-white/10">
              <Table>
                <TableHeader>
                  <TableRow className="border-white/10 hover:bg-transparent">
                    <TableHead className="text-slate-300">Agency Name</TableHead>
                    <TableHead className="text-slate-300">Email</TableHead>
                    <TableHead className="text-slate-300">Phone</TableHead>
                    <TableHead className="text-slate-300">Status</TableHead>
                    <TableHead className="text-slate-300 text-right">Actions</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {agencies.map((a: any) => (
                    <TableRow key={a.id} className="border-white/10 hover:bg-white/5 transition-colors">
                      <TableCell className="font-medium text-white">{a.name}</TableCell>
                      <TableCell className="text-slate-400">{a.email || 'N/A'}</TableCell>
                      <TableCell className="text-slate-400">{a.phoneNumber || 'N/A'}</TableCell>
                      <TableCell className="text-slate-400">
                        <span className="px-2 py-1 bg-white/5 rounded-full text-xs">
                          {a.status}
                        </span>
                      </TableCell>
                      <TableCell className="text-right">
                        <Button variant="ghost" size="icon" className="text-slate-400 hover:text-white" onClick={() => handleEditClick(a)}><Edit className="w-4 h-4" /></Button>
                        <Button 
                          variant="ghost" 
                          size="icon" 
                          className="text-red-400 hover:text-red-300 hover:bg-red-400/10"
                          onClick={() => deleteMutation.mutate(a.id)}
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

export default AgenciesManagement;
