"use client";

import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { useTranslation } from "react-i18next";
import { Plus, FileText, Edit, Trash2, Calendar, DollarSign, User, AlertCircle, CheckCircle } from 'lucide-react';
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
import { useCountryGuard } from '@/lib/hooks/useCountryGuard';

interface Lease {
  id: string;
  orgId: string;
  listingId: string;
  tenantId: string;
  startDate: string;
  endDate: string;
  monthlyRent: number;
  currency: string;
  depositAmount?: number;
  status: 'ACTIVE' | 'PENDING' | 'EXPIRED' | 'TERMINATED';
  paymentFrequency: 'MONTHLY' | 'QUARTERLY' | 'ANNUALLY';
  autoRenew: boolean;
  noticePeriod?: number;
  terms?: string;
  createdAt: string;
  updatedAt: string;
  listing?: {
    id: string;
    title: string;
    property?: {
      id: string;
      name: string;
      addressLine1: string;
    };
  };
  tenant?: {
    id: string;
    name: string;
    email: string;
  };
}

const LeaseManagement = () => {
  const { t } = useTranslation();
  const { isFieldAllowed } = useCountryGuard(undefined);
  const queryClient = useQueryClient();
  const [isAddModalOpen, setIsAddModalOpen] = useState(false);
  const [isEditModalOpen, setIsEditModalOpen] = useState(false);
  const [editingItem, setEditingItem] = useState<Lease | null>(null);
  const [newItem, setNewItem] = useState({ 
    listingId: '', 
    tenantId: '', 
    startDate: '', 
    endDate: '', 
    monthlyRent: '', 
    currency: 'USD',
    depositAmount: '',
    status: 'PENDING',
    paymentFrequency: 'MONTHLY',
    autoRenew: false,
    noticePeriod: '',
    terms: ''
  });

  const { data: leasesRes, isLoading } = useQuery({
    queryKey: ['admin-leases'],
    queryFn: async () => {
      const res: any = await apiClient.get('/lease');
      return res.data;
    }
  });

  const { data: listingsRes } = useQuery({
    queryKey: ['admin-listings'],
    queryFn: async () => {
      const res: any = await apiClient.get('/listing');
      return res.data;
    }
  });

  const { data: tenantsRes } = useQuery({
    queryKey: ['admin-tenants'],
    queryFn: async () => {
      const res: any = await apiClient.get('/tenant');
      return res.data;
    }
  });

  const createMutation = useMutation({
    mutationFn: async (data: any) => {
      return apiClient.post('/lease', data);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['admin-leases'] });
      setIsAddModalOpen(false);
      setNewItem({ 
        listingId: '', 
        tenantId: '', 
        startDate: '', 
        endDate: '', 
        monthlyRent: '', 
        currency: 'USD',
        depositAmount: '',
        status: 'PENDING',
        paymentFrequency: 'MONTHLY',
        autoRenew: false,
        noticePeriod: '',
        terms: ''
      });
    }
  });

  const deleteMutation = useMutation({
    mutationFn: async (id: string) => {
      return apiClient.delete(`/lease/${id}`);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['admin-leases'] });
    }
  });

  const updateMutation = useMutation({
    mutationFn: async (data: any) => {
      return apiClient.put(`/lease/${data.id}`, data);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['admin-leases'] });
      setIsEditModalOpen(false);
      setEditingItem(null);
    }
  });

  const handleAddSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    createMutation.mutate({
      ...newItem,
      monthlyRent: parseFloat(newItem.monthlyRent) || 0,
      depositAmount: newItem.depositAmount ? parseFloat(newItem.depositAmount) : null,
      noticePeriod: newItem.noticePeriod ? parseInt(newItem.noticePeriod) : null
    });
  };

  const handleEditSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (editingItem) {
      updateMutation.mutate(editingItem);
    }
  };

  const openEditModal = (item: Lease) => {
    setEditingItem(item);
    setIsEditModalOpen(true);
  };

  const getStatusBadge = (status: string) => {
    const statusConfig: Record<string, { icon: any; color: string; label: string }> = {
      'ACTIVE': { icon: CheckCircle, color: 'bg-emerald-500/10 text-emerald-400 border-emerald-500/20', label: t('admin_lease_active', 'Active') },
      'PENDING': { icon: AlertCircle, color: 'bg-yellow-500/10 text-yellow-400 border-yellow-500/20', label: t('admin_lease_pending', 'Pending') },
      'EXPIRED': { icon: AlertCircle, color: 'bg-slate-500/10 text-slate-500 dark:text-slate-400 border-slate-500/20', label: t('admin_lease_expired', 'Expired') },
      'TERMINATED': { icon: AlertCircle, color: 'bg-red-500/10 text-red-400 border-red-500/20', label: t('admin_lease_terminated', 'Terminated') }
    };
    const config = statusConfig[status] || statusConfig['PENDING'];
    const Icon = config.icon;
    return (
      <Badge className={config.color}>
        <Icon className="w-3 h-3 mr-1" />
        {config.label}
      </Badge>
    );
  };

  const leases = leasesRes?.data || [];
  const listings = listingsRes?.data || [];
  const tenants = tenantsRes?.data || [];

  return (
    <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
        <div>
          <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-slate-400 to-slate-400">
            {t("admin_lease_title", "Lease Management")}
          </h1>
          <p className="text-slate-500 dark:text-slate-400 mt-2">
            {t("admin_lease_subtitle", "Manage rental leases and tenant agreements")}
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
                {t("common.add", "Add Lease")}
              </Button>
            </DialogTrigger>
            <DialogContent className="bg-[#14151a] border-slate-200 dark:border-white/10 text-slate-900 dark:text-white max-w-2xl">
              <DialogHeader>
                <DialogTitle>{t("admin_lease_add_title", "Add New Lease")}</DialogTitle>
                <DialogDescription>{t("admin_lease_add_desc", "Create a new lease agreement")}</DialogDescription>
              </DialogHeader>
              <form onSubmit={handleAddSubmit} className="space-y-4 py-4">
                <div className="grid grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label>{t("admin_lease_listing", "Listing")}</Label>
                    <Select value={newItem.listingId} onValueChange={(v) => setNewItem({...newItem, listingId: v})}>
                      <SelectTrigger className="bg-white/5 border-slate-200 dark:border-white/10">
                        <SelectValue placeholder={t("admin_lease_select_listing", "Select listing")} />
                      </SelectTrigger>
                      <SelectContent className="bg-[#14151a] border-slate-200 dark:border-white/10">
                        {listings.map((l: any) => (
                          <SelectItem key={l.id} value={l.id}>{l.title || l.property?.name}</SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                  </div>
                  <div className="space-y-2">
                    <Label>{t("admin_lease_tenant", "Tenant")}</Label>
                    <Select value={newItem.tenantId} onValueChange={(v) => setNewItem({...newItem, tenantId: v})}>
                      <SelectTrigger className="bg-white/5 border-slate-200 dark:border-white/10">
                        <SelectValue placeholder={t("admin_lease_select_tenant", "Select tenant")} />
                      </SelectTrigger>
                      <SelectContent className="bg-[#14151a] border-slate-200 dark:border-white/10">
                        {tenants.map((t: any) => (
                          <SelectItem key={t.id} value={t.id}>{t.name}</SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                  </div>
                </div>
                <div className="grid grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label>{t("admin_lease_start_date", "Start Date")}</Label>
                    <Input 
                      type="date" 
                      value={newItem.startDate} 
                      onChange={(e) => setNewItem({...newItem, startDate: e.target.value})}
                      className="bg-white/5 border-slate-200 dark:border-white/10"
                    />
                  </div>
                  <div className="space-y-2">
                    <Label>{t("admin_lease_end_date", "End Date")}</Label>
                    <Input 
                      type="date" 
                      value={newItem.endDate} 
                      onChange={(e) => setNewItem({...newItem, endDate: e.target.value})}
                      className="bg-white/5 border-slate-200 dark:border-white/10"
                    />
                  </div>
                </div>
                <div className="grid grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label>{t("admin_lease_monthly_rent", "Monthly Rent")}</Label>
                    <Input 
                      type="number" 
                      value={newItem.monthlyRent} 
                      onChange={(e) => setNewItem({...newItem, monthlyRent: e.target.value})}
                      className="bg-white/5 border-slate-200 dark:border-white/10"
                    />
                  </div>
                  <div className="space-y-2">
                    <Label>{t("admin_lease_currency", "Currency")}</Label>
                    <Select value={newItem.currency} onValueChange={(v) => setNewItem({...newItem, currency: v})}>
                      <SelectTrigger className="bg-white/5 border-slate-200 dark:border-white/10">
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent className="bg-[#14151a] border-slate-200 dark:border-white/10">
                        <SelectItem value="USD">USD</SelectItem>
                        <SelectItem value="EUR">EUR</SelectItem>
                        <SelectItem value="GBP">GBP</SelectItem>
                        <SelectItem value="TRY">TRY</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                </div>
                <div className="grid grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label>{t("admin_lease_deposit", "Deposit Amount")}</Label>
                    <Input 
                      type="number" 
                      value={newItem.depositAmount} 
                      onChange={(e) => setNewItem({...newItem, depositAmount: e.target.value})}
                      className="bg-white/5 border-slate-200 dark:border-white/10"
                    />
                  </div>
                  <div className="space-y-2">
                    <Label>{t("admin_lease_payment_frequency", "Payment Frequency")}</Label>
                    <Select value={newItem.paymentFrequency} onValueChange={(v) => setNewItem({...newItem, paymentFrequency: v as any})}>
                      <SelectTrigger className="bg-white/5 border-slate-200 dark:border-white/10">
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent className="bg-[#14151a] border-slate-200 dark:border-white/10">
                        <SelectItem value="MONTHLY">{t("admin_lease_monthly", "Monthly")}</SelectItem>
                        <SelectItem value="QUARTERLY">{t("admin_lease_quarterly", "Quarterly")}</SelectItem>
                        <SelectItem value="ANNUALLY">{t("admin_lease_annually", "Annually")}</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                </div>
                <div className="grid grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label>{t("admin_lease_notice_period", "Notice Period (days)")}</Label>
                    <Input 
                      type="number" 
                      value={newItem.noticePeriod} 
                      onChange={(e) => setNewItem({...newItem, noticePeriod: e.target.value})}
                      className="bg-white/5 border-slate-200 dark:border-white/10"
                    />
                  </div>
                  <div className="flex items-center gap-2 pt-6">
                    <input 
                      type="checkbox" 
                      id="autoRenew"
                      checked={newItem.autoRenew}
                      onChange={(e) => setNewItem({...newItem, autoRenew: e.target.checked})}
                      className="rounded"
                    />
                    <Label htmlFor="autoRenew">{t("admin_lease_auto_renew", "Auto Renew")}</Label>
                  </div>
                </div>
                <div className="space-y-2">
                  <Label>{t("admin_lease_terms", "Terms and Conditions")}</Label>
                  <Textarea 
                    value={newItem.terms} 
                    onChange={(e) => setNewItem({...newItem, terms: e.target.value})}
                    className="bg-white/5 border-slate-200 dark:border-white/10"
                    placeholder={t("admin_lease_terms_placeholder", "Lease terms and conditions")}
                    rows={3}
                  />
                </div>
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

      <Card className="bg-white/5 border-slate-200 dark:border-white/10">
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <FileText className="w-5 h-5" />
            {t("admin_lease_list_title", "Lease Agreements")}
          </CardTitle>
        </CardHeader>
        <CardContent>
          {isLoading ? (
            <div className="text-center py-8 text-slate-500">{t("common.loading", "Loading...")}</div>
          ) : leases.length === 0 ? (
            <div className="text-center py-8 text-slate-500">{t("admin_lease_empty", "No leases found")}</div>
          ) : (
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>{t("admin_lease_property", "Property")}</TableHead>
                  <TableHead>{t("admin_lease_tenant", "Tenant")}</TableHead>
                  <TableHead>{t("admin_lease_period", "Period")}</TableHead>
                  <TableHead>{t("admin_lease_rent", "Monthly Rent")}</TableHead>
                  <TableHead>{t("admin_lease_status", "Status")}</TableHead>
                  <TableHead>{t("admin_lease_payment", "Payment")}</TableHead>
                  <TableHead className="text-right">{t("common.actions", "Actions")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {leases.map((item: Lease) => (
                  <TableRow key={item.id}>
                    <TableCell className="font-medium">
                      {item.listing?.property?.name || item.listing?.title || '-'}
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-2">
                        <User className="w-4 h-4 text-slate-500" />
                        {item.tenant?.name || '-'}
                      </div>
                    </TableCell>
                    <TableCell className="text-slate-500">
                      <div className="flex items-center gap-1">
                        <Calendar className="w-3 h-3" />
                        {new Date(item.startDate).toLocaleDateString()} - {new Date(item.endDate).toLocaleDateString()}
                      </div>
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-1">
                        <DollarSign className="w-4 h-4" />
                        {item.monthlyRent.toLocaleString()} {item.currency}
                      </div>
                    </TableCell>
                    <TableCell>{getStatusBadge(item.status)}</TableCell>
                    <TableCell className="text-slate-500">
                      {item.paymentFrequency}
                      {item.autoRenew && <Badge variant="outline" className="ml-2">{t("admin_lease_auto", "Auto")}</Badge>}
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

      {/* Edit Modal */}
      <Dialog open={isEditModalOpen} onOpenChange={setIsEditModalOpen}>
        <DialogContent className="bg-[#14151a] border-slate-200 dark:border-white/10 text-slate-900 dark:text-white max-w-2xl">
          <DialogHeader>
            <DialogTitle>{t("admin_lease_edit_title", "Edit Lease")}</DialogTitle>
            <DialogDescription>{t("admin_lease_edit_desc", "Update lease agreement details")}</DialogDescription>
          </DialogHeader>
          {editingItem && (
            <form onSubmit={handleEditSubmit} className="space-y-4 py-4">
              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-2">
                  <Label>{t("admin_lease_status", "Status")}</Label>
                  <Select value={editingItem.status} onValueChange={(v) => setEditingItem({...editingItem, status: v as any})}>
                    <SelectTrigger className="bg-white/5 border-slate-200 dark:border-white/10">
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent className="bg-[#14151a] border-slate-200 dark:border-white/10">
                      <SelectItem value="ACTIVE">{t("admin_lease_active", "Active")}</SelectItem>
                      <SelectItem value="PENDING">{t("admin_lease_pending", "Pending")}</SelectItem>
                      <SelectItem value="EXPIRED">{t("admin_lease_expired", "Expired")}</SelectItem>
                      <SelectItem value="TERMINATED">{t("admin_lease_terminated", "Terminated")}</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div className="space-y-2">
                  <Label>{t("admin_lease_monthly_rent", "Monthly Rent")}</Label>
                  <Input 
                    type="number" 
                    value={editingItem.monthlyRent}
                    onChange={(e) => setEditingItem({...editingItem, monthlyRent: parseFloat(e.target.value)})}
                    className="bg-white/5 border-slate-200 dark:border-white/10"
                  />
                </div>
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-2">
                  <Label>{t("admin_lease_end_date", "End Date")}</Label>
                  <Input 
                    type="date" 
                    value={editingItem.endDate}
                    onChange={(e) => setEditingItem({...editingItem, endDate: e.target.value})}
                    className="bg-white/5 border-slate-200 dark:border-white/10"
                  />
                </div>
                <div className="flex items-center gap-2 pt-6">
                  <input 
                    type="checkbox" 
                    id="editAutoRenew"
                    checked={editingItem.autoRenew}
                    onChange={(e) => setEditingItem({...editingItem, autoRenew: e.target.checked})}
                    className="rounded"
                  />
                  <Label htmlFor="editAutoRenew">{t("admin_lease_auto_renew", "Auto Renew")}</Label>
                </div>
              </div>
              <div className="space-y-2">
                <Label>{t("admin_lease_terms", "Terms and Conditions")}</Label>
                <Textarea 
                  value={editingItem.terms || ''}
                  onChange={(e) => setEditingItem({...editingItem, terms: e.target.value})}
                  className="bg-white/5 border-slate-200 dark:border-white/10"
                  rows={3}
                />
              </div>
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

export default LeaseManagement;
