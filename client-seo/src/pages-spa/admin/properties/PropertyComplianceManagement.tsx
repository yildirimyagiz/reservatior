"use client";

import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { useTranslation } from "react-i18next";
import { Plus, ShieldCheck, AlertTriangle, CheckCircle, Clock, Edit, Trash2, FileText } from 'lucide-react';
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

interface PropertyCompliance {
  id: string;
  propertyId: string;
  complianceType: string;
  status: 'PENDING' | 'VERIFIED' | 'FAILED' | 'EXPIRED';
  expiryDate?: string;
  documentId?: string;
  notes?: string;
  verifiedBy?: string;
  verifiedAt?: string;
  property?: {
    id: string;
    name: string;
  };
}

const PropertyComplianceManagement = () => {
  const { t } = useTranslation();
  const { isFieldAllowed } = useCountryGuard(undefined);
  const queryClient = useQueryClient();
  const [isAddModalOpen, setIsAddModalOpen] = useState(false);
  const [isEditModalOpen, setIsEditModalOpen] = useState(false);
  const [editingItem, setEditingItem] = useState<PropertyCompliance | null>(null);
  const [newItem, setNewItem] = useState({ propertyId: '', complianceType: '', status: 'PENDING', expiryDate: '', notes: '' });

  const { data: complianceRes, isLoading } = useQuery({
    queryKey: ['admin-property-compliance'],
    queryFn: async () => {
      const res: any = await apiClient.get('/property-compliance');
      return res.data;
    }
  });

  const { data: propertiesRes } = useQuery({
    queryKey: ['admin-properties'],
    queryFn: async () => {
      const res: any = await apiClient.get('/property');
      return res.data;
    }
  });

  const createMutation = useMutation({
    mutationFn: async (data: any) => {
      return apiClient.post('/property-compliance', data);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['admin-property-compliance'] });
      setIsAddModalOpen(false);
      setNewItem({ propertyId: '', complianceType: '', status: 'PENDING', expiryDate: '', notes: '' });
    }
  });

  const deleteMutation = useMutation({
    mutationFn: async (id: string) => {
      return apiClient.delete(`/property-compliance/${id}`);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['admin-property-compliance'] });
    }
  });

  const updateMutation = useMutation({
    mutationFn: async (data: any) => {
      return apiClient.put(`/property-compliance/${data.id}`, data);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['admin-property-compliance'] });
      setIsEditModalOpen(false);
      setEditingItem(null);
    }
  });

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

  const openEditModal = (item: PropertyCompliance) => {
    setEditingItem(item);
    setIsEditModalOpen(true);
  };

  const getStatusBadge = (status: string) => {
    const statusConfig: Record<string, { icon: any; color: string; label: string }> = {
      'PENDING': { icon: Clock, color: 'bg-yellow-500/10 text-yellow-400 border-yellow-500/20', label: t('admin_compliance_pending', 'Pending') },
      'VERIFIED': { icon: CheckCircle, color: 'bg-emerald-500/10 text-emerald-400 border-emerald-500/20', label: t('admin_compliance_verified', 'Verified') },
      'FAILED': { icon: AlertTriangle, color: 'bg-red-500/10 text-red-400 border-red-500/20', label: t('admin_compliance_failed', 'Failed') },
      'EXPIRED': { icon: AlertTriangle, color: 'bg-slate-500/10 text-slate-500 dark:text-slate-400 border-slate-500/20', label: t('admin_compliance_expired', 'Expired') }
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

  const complianceTypes = [
    'FIRE_SAFETY',
    'BUILDING_CODE',
    'HEALTH_SAFETY',
    'ENVIRONMENTAL',
    'ACCESSIBILITY',
    'INSURANCE',
    'LICENSE',
    'TAX_COMPLIANCE',
    'ZONING'
  ];

  const complianceItems = complianceRes?.data || [];
  const properties = propertiesRes?.data || [];

  return (
    <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
        <div>
          <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-slate-400 to-slate-400">
            {t("admin_property_compliance_title", "Property Compliance Management")}
          </h1>
          <p className="text-slate-500 dark:text-slate-400 mt-2">
            {t("admin_property_compliance_subtitle", "Monitor and manage property compliance records and certifications")}
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
                {t("common.add", "Add Compliance")}
              </Button>
            </DialogTrigger>
            <DialogContent className="bg-[#14151a] border-slate-200 dark:border-white/10 text-slate-900 dark:text-white">
              <DialogHeader>
                <DialogTitle>{t("admin_property_compliance_add_title", "Add Property Compliance")}</DialogTitle>
                <DialogDescription>{t("admin_property_compliance_add_desc", "Add a new compliance record for a property")}</DialogDescription>
              </DialogHeader>
              <form onSubmit={handleAddSubmit} className="space-y-4 py-4">
                <div className="space-y-2">
                  <Label>{t("admin_property_compliance_property", "Property")}</Label>
                  <Select value={newItem.propertyId} onValueChange={(v) => setNewItem({...newItem, propertyId: v})}>
                    <SelectTrigger className="bg-white/5 border-slate-200 dark:border-white/10">
                      <SelectValue placeholder={t("admin_property_compliance_select_property", "Select property")} />
                    </SelectTrigger>
                    <SelectContent className="bg-[#14151a] border-slate-200 dark:border-white/10">
                      {properties.map((p: any) => (
                        <SelectItem key={p.id} value={p.id}>{p.name}</SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>
                <div className="space-y-2">
                  <Label>{t("admin_property_compliance_type", "Compliance Type")}</Label>
                  <Select value={newItem.complianceType} onValueChange={(v) => setNewItem({...newItem, complianceType: v})}>
                    <SelectTrigger className="bg-white/5 border-slate-200 dark:border-white/10">
                      <SelectValue placeholder={t("admin_property_compliance_select_type", "Select compliance type")} />
                    </SelectTrigger>
                    <SelectContent className="bg-[#14151a] border-slate-200 dark:border-white/10">
                      {complianceTypes.map(type => (
                        <SelectItem key={type} value={type}>{type.replace(/_/g, ' ')}</SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>
                <div className="space-y-2">
                  <Label>{t("admin_property_compliance_status", "Status")}</Label>
                  <Select value={newItem.status} onValueChange={(v) => setNewItem({...newItem, status: v as any})}>
                    <SelectTrigger className="bg-white/5 border-slate-200 dark:border-white/10">
                      <SelectValue placeholder={t("admin_property_compliance_select_status", "Select status")} />
                    </SelectTrigger>
                    <SelectContent className="bg-[#14151a] border-slate-200 dark:border-white/10">
                      <SelectItem value="PENDING">{t("admin_compliance_pending", "Pending")}</SelectItem>
                      <SelectItem value="VERIFIED">{t("admin_compliance_verified", "Verified")}</SelectItem>
                      <SelectItem value="FAILED">{t("admin_compliance_failed", "Failed")}</SelectItem>
                      <SelectItem value="EXPIRED">{t("admin_compliance_expired", "Expired")}</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div className="space-y-2">
                  <Label>{t("admin_property_compliance_expiry", "Expiry Date")}</Label>
                  <Input 
                    type="date" 
                    value={newItem.expiryDate} 
                    onChange={(e) => setNewItem({...newItem, expiryDate: e.target.value})}
                    className="bg-white/5 border-slate-200 dark:border-white/10"
                  />
                </div>
                <div className="space-y-2">
                  <Label>{t("admin_property_compliance_notes", "Notes")}</Label>
                  <Textarea 
                    value={newItem.notes} 
                    onChange={(e) => setNewItem({...newItem, notes: e.target.value})}
                    className="bg-white/5 border-slate-200 dark:border-white/10"
                    placeholder={t("admin_property_compliance_notes_placeholder", "Optional notes")}
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
            <ShieldCheck className="w-5 h-5" />
            {t("admin_property_compliance_list_title", "Property Compliance Records")}
          </CardTitle>
        </CardHeader>
        <CardContent>
          {isLoading ? (
            <div className="text-center py-8 text-slate-500">{t("common.loading", "Loading...")}</div>
          ) : complianceItems.length === 0 ? (
            <div className="text-center py-8 text-slate-500">{t("admin_property_compliance_empty", "No compliance records found")}</div>
          ) : (
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>{t("admin_property_compliance_property", "Property")}</TableHead>
                  <TableHead>{t("admin_property_compliance_type", "Compliance Type")}</TableHead>
                  <TableHead>{t("admin_property_compliance_status", "Status")}</TableHead>
                  <TableHead>{t("admin_property_compliance_expiry", "Expiry Date")}</TableHead>
                  <TableHead>{t("admin_property_compliance_verified", "Verified By")}</TableHead>
                  <TableHead>{t("admin_property_compliance_notes", "Notes")}</TableHead>
                  <TableHead className="text-right">{t("common.actions", "Actions")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {complianceItems.map((item: PropertyCompliance) => (
                  <TableRow key={item.id}>
                    <TableCell className="font-medium">{item.property?.name || '-'}</TableCell>
                    <TableCell>{item.complianceType.replace(/_/g, ' ')}</TableCell>
                    <TableCell>{getStatusBadge(item.status)}</TableCell>
                    <TableCell>{item.expiryDate ? new Date(item.expiryDate).toLocaleDateString() : '-'}</TableCell>
                    <TableCell className="text-slate-500">{item.verifiedBy || '-'}</TableCell>
                    <TableCell className="text-slate-500 max-w-xs truncate">{item.notes || '-'}</TableCell>
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
        <DialogContent className="bg-[#14151a] border-slate-200 dark:border-white/10 text-slate-900 dark:text-white">
          <DialogHeader>
            <DialogTitle>{t("admin_property_compliance_edit_title", "Edit Property Compliance")}</DialogTitle>
            <DialogDescription>{t("admin_property_compliance_edit_desc", "Update compliance record details")}</DialogDescription>
          </DialogHeader>
          {editingItem && (
            <form onSubmit={handleEditSubmit} className="space-y-4 py-4">
              <div className="space-y-2">
                <Label>{t("admin_property_compliance_status", "Status")}</Label>
                <Select value={editingItem.status} onValueChange={(v) => setEditingItem({...editingItem, status: v as any})}>
                  <SelectTrigger className="bg-white/5 border-slate-200 dark:border-white/10">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent className="bg-[#14151a] border-slate-200 dark:border-white/10">
                    <SelectItem value="PENDING">{t("admin_compliance_pending", "Pending")}</SelectItem>
                    <SelectItem value="VERIFIED">{t("admin_compliance_verified", "Verified")}</SelectItem>
                    <SelectItem value="FAILED">{t("admin_compliance_failed", "Failed")}</SelectItem>
                    <SelectItem value="EXPIRED">{t("admin_compliance_expired", "Expired")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label>{t("admin_property_compliance_expiry", "Expiry Date")}</Label>
                <Input 
                  type="date" 
                  value={editingItem.expiryDate || ''}
                  onChange={(e) => setEditingItem({...editingItem, expiryDate: e.target.value})}
                  className="bg-white/5 border-slate-200 dark:border-white/10"
                />
              </div>
              <div className="space-y-2">
                <Label>{t("admin_property_compliance_notes", "Notes")}</Label>
                <Textarea 
                  value={editingItem.notes || ''}
                  onChange={(e) => setEditingItem({...editingItem, notes: e.target.value})}
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

export default PropertyComplianceManagement;
