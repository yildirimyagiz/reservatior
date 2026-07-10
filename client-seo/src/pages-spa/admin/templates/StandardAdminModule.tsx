"use client";

import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { useTranslation } from "react-i18next";
import { Plus, Edit, Trash2, Search } from 'lucide-react';
import { Button } from "@/components/ui/button";
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { apiClient } from '@/lib/api';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Badge } from "@/components/ui/badge";
import { Textarea } from "@/components/ui/textarea";
import { useState } from 'react';

// ============================================================================
// INTERFACE DEFINITIONS
// ============================================================================

interface StandardModuleItem {
  id: string;
  orgId: string;
  // Add specific fields for your module here
  name: string;
  status: 'ACTIVE' | 'INACTIVE' | 'PENDING';
  createdAt: string;
  updatedAt: string;
  // Add relations as needed
  // relatedEntity?: {
  //   id: string;
  //   name: string;
  // };
}

// ============================================================================
// MAIN COMPONENT
// ============================================================================

const StandardAdminModule = () => {
  const { t } = useTranslation();
  const queryClient = useQueryClient();
  
  // ============================================================================
  // STATE MANAGEMENT
  // ============================================================================
  const [isAddModalOpen, setIsAddModalOpen] = useState(false);
  const [isEditModalOpen, setIsEditModalOpen] = useState(false);
  const [editingItem, setEditingItem] = useState<StandardModuleItem | null>(null);
  const [newItem, setNewItem] = useState({ 
    name: '', 
    status: 'ACTIVE'
    // Add other fields as needed
  });
  const [searchQuery, setSearchQuery] = useState('');
  const [statusFilter, setStatusFilter] = useState<string>('ALL');

  // ============================================================================
  // DATA FETCHING
  // ============================================================================
  const { data: itemsRes, isLoading } = useQuery({
    queryKey: ['admin-standard-module'],
    queryFn: async () => {
      const res: any = await apiClient.get('/your-endpoint');
      return res.data;
    }
  });

  // ============================================================================
  // MUTATIONS
  // ============================================================================
  const createMutation = useMutation({
    mutationFn: async (data: any) => {
      return apiClient.post('/your-endpoint', data);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['admin-standard-module'] });
      setIsAddModalOpen(false);
      setNewItem({ name: '', status: 'ACTIVE' });
    }
  });

  const deleteMutation = useMutation({
    mutationFn: async (id: string) => {
      return apiClient.delete(`/your-endpoint/${id}`);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['admin-standard-module'] });
    }
  });

  const updateMutation = useMutation({
    mutationFn: async (data: any) => {
      return apiClient.put(`/your-endpoint/${data.id}`, data);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['admin-standard-module'] });
      setIsEditModalOpen(false);
      setEditingItem(null);
    }
  });

  // ============================================================================
  // HANDLERS
  // ============================================================================
  const handleAddSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    createMutation.mutate(newItem);
  };

  const handleEditSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (editingItem) {
      updateMutation.mutate(editingItem);
    }
  };

  const openEditModal = (item: StandardModuleItem) => {
    setEditingItem(item);
    setIsEditModalOpen(true);
  };

  const getStatusBadge = (status: string) => {
    const statusConfig: Record<string, { color: string; label: string }> = {
      'ACTIVE': { color: 'bg-emerald-500/10 text-emerald-400 border-emerald-500/20', label: t('admin_status_active', 'Active') },
      'INACTIVE': { color: 'bg-slate-500/10 text-slate-400 border-slate-500/20', label: t('admin_status_inactive', 'Inactive') },
      'PENDING': { color: 'bg-yellow-500/10 text-yellow-400 border-yellow-500/20', label: t('admin_status_pending', 'Pending') }
    };
    const config = statusConfig[status] || statusConfig['ACTIVE'];
    return <Badge className={config.color}>{config.label}</Badge>;
  };

  // ============================================================================
  // FILTERING
  // ============================================================================
  const items = itemsRes?.data || [];
  const filteredItems = items.filter((item: StandardModuleItem) => {
    const matchesSearch = item.name.toLowerCase().includes(searchQuery.toLowerCase());
    const matchesFilter = statusFilter === 'ALL' || item.status === statusFilter;
    return matchesSearch && matchesFilter;
  });

  // ============================================================================
  // RENDER
  // ============================================================================
  return (
    <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
      {/* ============================================================================
          HEADER SECTION
          ============================================================================ */}
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
        <div>
          <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-slate-400 to-slate-400">
            {t("admin_module_title", "Module Management")}
          </h1>
          <p className="text-slate-500 dark:text-slate-400 mt-2">
            {t("admin_module_subtitle", "Manage your module items")}
          </p>
        </div>
        <div className="flex gap-2">
          <Button variant="outline" className="bg-white/5 border-slate-200 dark:border-white/10 hover:bg-white/10">
            {t("common.export", "Export")}
          </Button>
          <Dialog open={isAddModalOpen} onOpenChange={setIsAddModalOpen}>
            <DialogTrigger asChild>
              <Button className="bg-slate-600 hover:bg-slate-500 text-white">
                <Plus className="w-4 h-4 mr-2" />
                {t("common.add", "Add Item")}
              </Button>
            </DialogTrigger>
            <DialogContent className="bg-[#14151a] border-slate-200 dark:border-white/10 text-slate-900 dark:text-white max-w-2xl">
              <DialogHeader>
                <DialogTitle>{t("admin_module_add_title", "Add New Item")}</DialogTitle>
                <DialogDescription>{t("admin_module_add_desc", "Create a new item")}</DialogDescription>
              </DialogHeader>
              <form onSubmit={handleAddSubmit} className="space-y-4 py-4">
                <div className="space-y-2">
                  <Label>{t("admin_module_name", "Name")}</Label>
                  <Input 
                    value={newItem.name} 
                    onChange={(e) => setNewItem({...newItem, name: e.target.value})}
                    className="bg-white/5 border-slate-200 dark:border-white/10"
                  />
                </div>
                <div className="space-y-2">
                  <Label>{t("admin_module_status", "Status")}</Label>
                  <Select value={newItem.status} onValueChange={(v) => setNewItem({...newItem, status: v as any})}>
                    <SelectTrigger className="bg-white/5 border-slate-200 dark:border-white/10">
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent className="bg-[#14151a] border-slate-200 dark:border-white/10">
                      <SelectItem value="ACTIVE">{t("admin_status_active", "Active")}</SelectItem>
                      <SelectItem value="INACTIVE">{t("admin_status_inactive", "Inactive")}</SelectItem>
                      <SelectItem value="PENDING">{t("admin_status_pending", "Pending")}</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                {/* Add additional form fields as needed */}
              </form>
              <DialogFooter>
                <Button variant="outline" onClick={() => setIsAddModalOpen(false)} className="bg-white/5 border-slate-200 dark:border-white/10">
                  {t("common.cancel", "Cancel")}
                </Button>
                <Button onClick={handleAddSubmit} className="bg-slate-600 hover:bg-slate-500 text-white">
                  {t("common.save", "Save")}
                </Button>
              </DialogFooter>
            </DialogContent>
          </Dialog>
        </div>
      </div>

      {/* ============================================================================
          FILTERS SECTION
          ============================================================================ */}
      <div className="flex gap-4">
        <div className="relative flex-1 max-w-md">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-500" />
          <Input
            placeholder={t("common.search", "Search...")}
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="pl-10 bg-white/5 border-slate-200 dark:border-white/10"
          />
        </div>
        <Select value={statusFilter} onValueChange={setStatusFilter}>
          <SelectTrigger className="w-40 bg-white/5 border-slate-200 dark:border-white/10">
            <SelectValue />
          </SelectTrigger>
          <SelectContent className="bg-[#14151a] border-slate-200 dark:border-white/10">
            <SelectItem value="ALL">{t("common.all", "All")}</SelectItem>
            <SelectItem value="ACTIVE">{t("admin_status_active", "Active")}</SelectItem>
            <SelectItem value="INACTIVE">{t("admin_status_inactive", "Inactive")}</SelectItem>
            <SelectItem value="PENDING">{t("admin_status_pending", "Pending")}</SelectItem>
          </SelectContent>
        </Select>
      </div>

      {/* ============================================================================
          DATA TABLE SECTION
          ============================================================================ */}
      <Card className="bg-white/5 border-slate-200 dark:border-white/10">
        <CardHeader>
          <CardTitle className="text-slate-900 dark:text-white">
            {t("admin_module_list_title", "Items")}
          </CardTitle>
        </CardHeader>
        <CardContent>
          {isLoading ? (
            <div className="text-center py-8 text-slate-500">{t("common.loading", "Loading...")}</div>
          ) : filteredItems.length === 0 ? (
            <div className="text-center py-8 text-slate-500">{t("admin_module_empty", "No items found")}</div>
          ) : (
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead className="text-slate-900 dark:text-white">{t("admin_module_name", "Name")}</TableHead>
                  <TableHead className="text-slate-900 dark:text-white">{t("admin_module_status", "Status")}</TableHead>
                  <TableHead className="text-slate-900 dark:text-white">{t("admin_module_created", "Created")}</TableHead>
                  <TableHead className="text-slate-900 dark:text-white text-right">{t("common.actions", "Actions")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {filteredItems.map((item: StandardModuleItem) => (
                  <TableRow key={item.id}>
                    <TableCell className="font-medium text-slate-900 dark:text-white">{item.name}</TableCell>
                    <TableCell>{getStatusBadge(item.status)}</TableCell>
                    <TableCell className="text-slate-500">
                      {new Date(item.createdAt).toLocaleDateString()}
                    </TableCell>
                    <TableCell className="text-right">
                      <div className="flex justify-end gap-2">
                        <Button variant="ghost" size="icon" onClick={() => openEditModal(item)}>
                          <Edit className="w-4 h-4" />
                        </Button>
                        <Button variant="ghost" size="icon" onClick={() => deleteMutation.mutate(item.id)}>
                          <Trash2 className="w-4 h-4 text-red-500" />
                        </Button>
                      </div>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          )}
        </CardContent>
      </Card>

      {/* ============================================================================
          EDIT MODAL
          ============================================================================ */}
      <Dialog open={isEditModalOpen} onOpenChange={setIsEditModalOpen}>
        <DialogContent className="bg-[#14151a] border-slate-200 dark:border-white/10 text-slate-900 dark:text-white max-w-2xl">
          <DialogHeader>
            <DialogTitle>{t("admin_module_edit_title", "Edit Item")}</DialogTitle>
            <DialogDescription>{t("admin_module_edit_desc", "Update item details")}</DialogDescription>
          </DialogHeader>
          {editingItem && (
            <form onSubmit={handleEditSubmit} className="space-y-4 py-4">
              <div className="space-y-2">
                <Label>{t("admin_module_name", "Name")}</Label>
                <Input 
                  value={editingItem.name}
                  onChange={(e) => setEditingItem({...editingItem, name: e.target.value})}
                  className="bg-white/5 border-slate-200 dark:border-white/10"
                />
              </div>
              <div className="space-y-2">
                <Label>{t("admin_module_status", "Status")}</Label>
                <Select value={editingItem.status} onValueChange={(v) => setEditingItem({...editingItem, status: v as any})}>
                  <SelectTrigger className="bg-white/5 border-slate-200 dark:border-white/10">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent className="bg-[#14151a] border-slate-200 dark:border-white/10">
                    <SelectItem value="ACTIVE">{t("admin_status_active", "Active")}</SelectItem>
                    <SelectItem value="INACTIVE">{t("admin_status_inactive", "Inactive")}</SelectItem>
                    <SelectItem value="PENDING">{t("admin_status_pending", "Pending")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              {/* Add additional edit fields as needed */}
            </form>
          )}
          <DialogFooter>
            <Button variant="outline" onClick={() => setIsEditModalOpen(false)} className="bg-white/5 border-slate-200 dark:border-white/10">
              {t("common.cancel", "Cancel")}
            </Button>
            <Button onClick={handleEditSubmit} className="bg-slate-600 hover:bg-slate-500 text-white">
              {t("common.save", "Save")}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
};

export default StandardAdminModule;
