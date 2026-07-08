"use client";

import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { useTranslation } from "react-i18next";
import { Contact, Plus, PhoneCall, Mail, MessageSquare, Edit, Trash2 } from 'lucide-react';
import { Button } from "@/components/ui/button";
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { apiClient } from '@/lib/api';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useState } from 'react';

import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { FileSignature, Send, FileText } from 'lucide-react';

const ContactsManagement = () => {
  const { toast } = useToast();
  const { t } = useTranslation();
  const queryClient = useQueryClient();
  const [isAddModalOpen, setIsAddModalOpen] = useState(false);
  const [newContact, setNewContact] = useState({ fullName: '', email: '', phone: '', type: 'OTHER' });

  const { data: contactsRes, isLoading } = useQuery({
    queryKey: ['admin-contacts'],
    queryFn: async () => {
      const res: any = await apiClient.get('/contact');
      return res.data;
    }
  });

  const createMutation = useMutation({
    mutationFn: async (data: any) => {
      return apiClient.post('/contact', { 
        ...data, 
        orgId: 'org_1'
      });
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['admin-contacts'] });
      setIsAddModalOpen(false);
      setNewContact({ fullName: '', email: '', phone: '', type: 'OTHER' });
    }
  });

  const deleteMutation = useMutation({
    mutationFn: async (id: string) => {
      return apiClient.delete(`/contact/${id}`);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['admin-contacts'] });
    }
  });

  const handleAddSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    createMutation.mutate(newContact);
  };

  const handleSendContract = async (contact: any, contractType: string) => {
    try {
      toast({ title: t('admin_contracts_sending', "Sending..."), description: t('admin_contracts_sendingDesc', "{{type}} is being sent.", { type: contractType }) });
      await apiClient.post('/crm/request-contract-signature', {
        email: contact.email,
        name: contact.fullName,
        contractType: contractType,
        propertyId: "default_property_id" // Placeholder
      });
      toast({ title: t('success'), description: t('admin_contracts_success', "Legal document successfully sent to client via email.") });
    } catch (error) {
      toast({ title: t('error'), description: t('admin_contracts_error', "Failed to send contract."), variant: "destructive" });
    }
  };

  const contacts = contactsRes?.data || [];
  
  return (
    <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
        <div>
          <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-emerald-400 to-slate-400">
            {t("admin_contacts_title", "Contacts & Leads")}
          </h1>
          <p className="text-slate-500 dark:text-slate-400 mt-2">
            {t("admin_contacts_subtitle", "Centralized CRM for all property inquiries, leads, and client relations")}
          </p>
        </div>
        <div className="flex gap-2">
          <Button variant="outline" className="bg-white/5 border-slate-200 dark:border-white/10 hover:bg-white/10">
            {t("common.export", "Export CSV")}
          </Button>
          <Dialog open={isAddModalOpen} onOpenChange={setIsAddModalOpen}>
            <DialogTrigger asChild>
              <Button className="bg-emerald-600 hover:bg-emerald-700 text-slate-900 dark:text-white shadow-lg shadow-emerald-500/20">
                <Plus className="w-4 h-4 mr-2" />
                {t("admin_contacts_add", "New Contact")}
              </Button>
            </DialogTrigger>
            <DialogContent className="sm:max-w-[425px] bg-white dark:bg-slate-900 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white">
              <DialogHeader>
                <DialogTitle>{t("admin_contacts_add", "New Contact")}</DialogTitle>
              </DialogHeader>
              <form onSubmit={handleAddSubmit} className="space-y-4 pt-4">
                <div className="space-y-2">
                  <Label htmlFor="fullName">Full Name</Label>
                  <Input 
                    id="fullName" 
                    className="bg-white/5 border-slate-200 dark:border-white/10" 
                    value={newContact.fullName}
                    onChange={e => setNewContact({...newContact, fullName: e.target.value})}
                    required
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="email">Email</Label>
                  <Input 
                    id="email" 
                    type="email"
                    className="bg-white/5 border-slate-200 dark:border-white/10" 
                    value={newContact.email}
                    onChange={e => setNewContact({...newContact, email: e.target.value})}
                  />
                </div>
                <div className="grid grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label htmlFor="phone">Phone</Label>
                    <Input 
                      id="phone" 
                      className="bg-white/5 border-slate-200 dark:border-white/10" 
                      value={newContact.phone}
                      onChange={e => setNewContact({...newContact, phone: e.target.value})}
                    />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="type">Contact Type</Label>
                    <Input 
                      id="type" 
                      className="bg-white/5 border-slate-200 dark:border-white/10" 
                      value={newContact.type}
                      onChange={e => setNewContact({...newContact, type: e.target.value})}
                      placeholder="TENANT, OWNER_CONTACT..."
                    />
                  </div>
                </div>
                <div className="pt-4 flex justify-end gap-2">
                  <Button type="button" variant="ghost" onClick={() => setIsAddModalOpen(false)}>Cancel</Button>
                  <Button type="submit" className="bg-emerald-600 hover:bg-emerald-700" disabled={createMutation.isPending}>
                    {createMutation.isPending ? "Saving..." : "Create Contact"}
                  </Button>
                </div>
              </form>
            </DialogContent>
          </Dialog>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        <Card className="bg-white/5 border-slate-200 dark:border-white/10 backdrop-blur-sm">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-300">Total Leads</CardTitle>
            <Contact className="w-4 h-4 text-emerald-400" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900 dark:text-white">45,210</div>
            <p className="text-xs text-green-400 mt-1">+1,200 this week</p>
          </CardContent>
        </Card>
        
        <Card className="bg-white/5 border-slate-200 dark:border-white/10 backdrop-blur-sm">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-300">Emails Sent</CardTitle>
            <Mail className="w-4 h-4 text-slate-500 dark:text-slate-400" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900 dark:text-white">128k</div>
            <p className="text-xs text-slate-500 dark:text-slate-400 mt-1">98% delivery rate</p>
          </CardContent>
        </Card>

        <Card className="bg-white/5 border-slate-200 dark:border-white/10 backdrop-blur-sm">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-300">Active Calls</CardTitle>
            <PhoneCall className="w-4 h-4 text-amber-400" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900 dark:text-white">342</div>
            <p className="text-xs text-slate-500 dark:text-slate-400 mt-1">Today</p>
          </CardContent>
        </Card>

        <Card className="bg-white/5 border-slate-200 dark:border-white/10 backdrop-blur-sm">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-300">Messages</CardTitle>
            <MessageSquare className="w-4 h-4 text-slate-500 dark:text-slate-400" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900 dark:text-white">8,901</div>
            <p className="text-xs text-slate-500 dark:text-slate-400 mt-1">Unread: 12</p>
          </CardContent>
        </Card>
      </div>

      <Card className="bg-white/5 border-slate-200 dark:border-white/10 backdrop-blur-sm">
        <CardHeader>
          <CardTitle className="text-slate-900 dark:text-white">{t("admin_contacts_list", "Global Directory")}</CardTitle>
        </CardHeader>
        <CardContent>
          {isLoading ? (
            <div className="flex items-center justify-center py-20 text-slate-500 dark:text-slate-400">
              {t("common.loading", "Loading global CRM data...")}
            </div>
          ) : contacts.length === 0 ? (
            <div className="flex items-center justify-center py-20 text-slate-500 dark:text-slate-400">
              No contacts found.
            </div>
          ) : (
            <div className="rounded-xl border border-slate-200 dark:border-white/10">
              <Table>
                <TableHeader>
                  <TableRow className="border-slate-200 dark:border-white/10 hover:bg-transparent">
                    <TableHead className="text-slate-300">Name</TableHead>
                    <TableHead className="text-slate-300">Email</TableHead>
                    <TableHead className="text-slate-300">Phone</TableHead>
                    <TableHead className="text-slate-300">Type</TableHead>
                    <TableHead className="text-slate-300 text-right">Actions</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {contacts.map((c: any) => (
                    <TableRow key={c.id} className="border-slate-200 dark:border-white/10 hover:bg-white/5 transition-colors">
                      <TableCell className="font-medium text-slate-900 dark:text-white">{c.fullName}</TableCell>
                      <TableCell className="text-slate-500 dark:text-slate-400">{c.email || 'N/A'}</TableCell>
                      <TableCell className="text-slate-500 dark:text-slate-400">{c.phone || 'N/A'}</TableCell>
                      <TableCell className="text-slate-500 dark:text-slate-400">
                        <span className="px-2 py-1 bg-white/5 rounded-full text-xs">
                          {c.type}
                        </span>
                      </TableCell>
                      <TableCell className="text-right">
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild>
                            <Button variant="ghost" size="sm" className="text-slate-500 dark:text-slate-400 hover:text-white bg-emerald-600/10 hover:bg-emerald-600/20 text-emerald-400 mr-2">
                              <FileSignature className="w-4 h-4 mr-2" /> {t('admin_contracts_actions', 'Process')}
                            </Button>
                          </DropdownMenuTrigger>
                          <DropdownMenuContent align="end" className="bg-white dark:bg-slate-900 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white">
                            <DropdownMenuItem className="cursor-pointer hover:bg-white/10" onClick={() => handleSendContract(c, t('admin_contracts_salesType', "Sales Contract"))}>
                              <FileText className="w-4 h-4 mr-2 text-slate-500 dark:text-slate-400" /> {t('admin_contracts_sendSales', 'Send Sales Contract')}
                            </DropdownMenuItem>
                            <DropdownMenuItem className="cursor-pointer hover:bg-white/10" onClick={() => handleSendContract(c, t('admin_contracts_evictionType', "Eviction Agreement"))}>
                              <FileText className="w-4 h-4 mr-2 text-orange-400" /> {t('admin_contracts_sendEviction', 'Send Eviction Agreement')}
                            </DropdownMenuItem>
                            <DropdownMenuItem className="cursor-pointer hover:bg-white/10" onClick={() => handleSendContract(c, t('admin_contracts_rentalType', "Rental Contract"))}>
                              <FileText className="w-4 h-4 mr-2 text-emerald-400" /> {t('admin_contracts_sendRental', 'Send Rental Contract')}
                            </DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>

                        <Button variant="ghost" size="icon" className="text-slate-500 dark:text-slate-400 hover:text-white">
                          <Edit className="w-4 h-4" />
                        </Button>
                        <Button 
                          variant="ghost" 
                          size="icon" 
                          className="text-red-400 hover:text-red-300 hover:bg-red-400/10"
                          onClick={() => deleteMutation.mutate(c.id)}
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

export default ContactsManagement;
