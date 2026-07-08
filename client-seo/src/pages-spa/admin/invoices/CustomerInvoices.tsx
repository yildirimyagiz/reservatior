"use client";

import React from 'react';
import { apiClient } from "@/lib/api/client";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Label } from "@/components/ui/label";
import { Progress } from "@/components/ui/progress";
import { Users, FileText, Download, Send, CheckCircle, AlertTriangle, Clock, DollarSign, TrendingUp, Calendar, Mail, Phone, Search, Plus, Eye, CreditCard, BarChart3, Activity } from "lucide-react";
import { motion } from "framer-motion";
import { cn } from "@/lib/utils";
import { useToast } from "@/hooks/use-toast";
import { useNavigate } from "@/lib/react-router-shim";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { MoreHorizontal, Edit, Trash2 } from "lucide-react";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";

interface CustomerInvoice {
  id: string;
  customerId: string;
  customerName: string;
  customerEmail: string;
  customerPhone: string;
  customerAddress: string;
  amount: number;
  currency: string;
  dueDate: string;
  status: 'DRAFT' | 'SENT' | 'PAID' | 'OVERDUE' | 'CANCELLED';
  items: InvoiceItem[];
  taxRate: number;
  discountAmount?: number;
  totalAmount: number;
  notes?: string;
  createdAt: string;
  updatedAt: string;
  sentDate?: string;
  paidDate?: string;
}
interface InvoiceItem {
  id: string;
  description: string;
  quantity: number;
  unitPrice: number;
  totalPrice: number;
  itemType: 'SERVICE' | 'PRODUCT' | 'RENT' | 'COMMISSION' | 'UTILITY';
  taxRate?: number;
}
interface Customer {
  id: string;
  name: string;
  email: string;
  phone: string;
  address: string;
  company?: string;
  taxId?: string;
  createdAt: string;
  totalInvoices?: number;
  paidInvoices?: number;
  outstandingAmount?: number;
}

const MOCK_INVOICES: CustomerInvoice[] = [{
  id: "inv_001",
  customerId: "cust_001",
  customerName: "John Doe Properties",
  customerEmail: "john@doeproperties.com",
  customerPhone: "+1 (555) 123-4567",
  customerAddress: "123 Main St, New York, NY 10001",
  amount: 2500.00,
  currency: "USD",
  dueDate: "2026-04-15T00:00:00Z",
  status: "SENT",
  items: [{
    id: "item_001",
    description: "Property Management Fee - March",
    quantity: 1,
    unitPrice: 2500.00,
    totalPrice: 2500.00,
    itemType: "SERVICE"
  }],
  taxRate: 0.08,
  totalAmount: 2700.00,
  notes: "Monthly property management services",
  createdAt: "2026-03-15T10:00:00Z",
  updatedAt: "2026-03-15T10:00:00Z",
  sentDate: "2026-03-16T09:00:00Z"
}, {
  id: "inv_002",
  customerId: "cust_002",
  customerName: "Jane Smith Realty",
  customerEmail: "jane@smithrealty.com",
  customerPhone: "+1 (555) 987-6543",
  customerAddress: "456 Oak Ave, Los Angeles, CA 90210",
  amount: 1200.00,
  currency: "USD",
  dueDate: "2026-04-01T00:00:00Z",
  status: "PAID",
  items: [{
    id: "item_002",
    description: "Commission on Property Sale",
    quantity: 1,
    unitPrice: 1200.00,
    totalPrice: 1200.00,
    itemType: "COMMISSION"
  }],
  taxRate: 0.08,
  totalAmount: 1296.00,
  notes: "3% commission on property sale",
  createdAt: "2026-03-01T14:30:00Z",
  updatedAt: "2026-03-01T14:30:00Z",
  sentDate: "2026-03-02T11:00:00Z",
  paidDate: "2026-03-25T14:30:00Z"
}];

const MOCK_CUSTOMERS: Customer[] = [{
  id: "cust_001",
  name: "John Doe Properties",
  email: "john@doeproperties.com",
  phone: "+1 (555) 123-4567",
  address: "123 Main St, New York, NY 10001",
  company: "Doe Properties LLC",
  taxId: "12-3456789",
  createdAt: "2026-01-15T00:00:00Z",
  totalInvoices: 15,
  paidInvoices: 12,
  outstandingAmount: 8500.00
}, {
  id: "cust_002",
  name: "Jane Smith Realty",
  email: "jane@smithrealty.com",
  phone: "+1 (555) 987-6543",
  address: "456 Oak Ave, Los Angeles, CA 90210",
  company: "Smith Realty Group",
  taxId: "98-7654321",
  createdAt: "2026-02-01T00:00:00Z",
  totalInvoices: 8,
  paidInvoices: 6,
  outstandingAmount: 3200.00
}, {
  id: "cust_003",
  name: "Mike Johnson Commercial",
  email: "mike@johnsoncommercial.com",
  phone: "+1 (555) 246-8090",
  address: "789 Business Blvd, Chicago, IL 60601",
  company: "Johnson Commercial Properties",
  taxId: "45-678901",
  createdAt: "2026-03-01T00:00:00Z",
  totalInvoices: 25,
  paidInvoices: 20,
  outstandingAmount: 12500.00
}];

export default function CustomerInvoices() {
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const deleteMutation = useMutation({
    mutationFn: async (id: string) => apiClient.delete(`/invoices/${id}`),
    onSuccess: () => {
      toast({ title: "Deleted", description: "Record deleted successfully" });
      queryClient.invalidateQueries();
    },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
  });
  

  const { t } = useTranslation();
  const navigate = useNavigate();
  const [isAddOpen, setIsAddOpen] = useState(false);
  const [formData, setFormData] = React.useState({ customerId: "", amount: "", status: "" });
  const [activeTab, setActiveTab] = useState<'invoices' | 'customers' | 'templates' | 'analytics'>('invoices');
  const [searchTerm, setSearchTerm] = useState("");
  const [statusFilter, setStatusFilter] = useState("ALL");
  const [customerFilter, setCustomerFilter] = useState("");
  const [dateFilter, setDateFilter] = useState("");

  const { data: { invoices = MOCK_INVOICES, customers = MOCK_CUSTOMERS } = {}, isLoading } = useQuery({
    queryKey: ['customer-invoices'],
    queryFn: async () => {
      const res = await apiClient.get('/invoices');
      const data = (res as any).data || [];
      return { invoices: data as any, customers: [] as any };
    },
    placeholderData: { invoices: MOCK_INVOICES, customers: MOCK_CUSTOMERS },
  });

  const createMutation = useMutation({
    mutationFn: async (data: any) => {
      const res = await apiClient.post('/invoices', data);
      return res;
    },
    onSuccess: () => {
      setIsAddOpen(false);
      queryClient.invalidateQueries({ queryKey: ['customer-invoices'] });
      toast({ title: "Success", description: "Customer Invoice created successfully" });
    },
    onError: (err: any) => {
      toast({ title: "Error", description: err.message, variant: "destructive" });
    }
  });

  const getLocalizedStatus = (status: string) => {
    const map: Record<string, string> = {
      'PAID': t('admin_invoices_paid_status', 'Odendi'),
      'SENT': t('admin_invoices_sent_status', 'Gonderildi'),
      'OVERDUE': t('admin_invoices_overdue_status', 'Gecikmis'),
      'DRAFT': t('admin_invoices_draft_status', 'Taslak'),
      'CANCELLED': t('admin_invoices_cancelled_status', 'Iptal Edildi')
    };
    return map[status] || status;
  };

  const getStatusIcon = (status: string) => {
    switch (status) {
      case 'PAID':
        return <CheckCircle className="w-4 h-4" />;
      case 'SENT':
        return <Send className="w-4 h-4" />;
      case 'OVERDUE':
        return <AlertTriangle className="w-4 h-4" />;
      case 'DRAFT':
        return <FileText className="w-4 h-4" />;
      case 'CANCELLED':
        return <AlertTriangle className="w-4 h-4" />;
      default:
        return <Clock className="w-4 h-4" />;
    }
  };

  const sendInvoiceMutation = useMutation({
    mutationFn: async (invoiceId: string) => {
      await new Promise(resolve => setTimeout(resolve, 2000));
      return invoiceId;
    },
    onSuccess: (invoiceId) => {
      queryClient.setQueryData(['customer-invoices'], (old: any) => ({
        ...old,
        invoices: old.invoices.map((inv: CustomerInvoice) =>
          inv.id === invoiceId ? { ...inv, status: 'SENT' as const, sentDate: new Date().toISOString() } : inv
        ),
      }));
      toast({ title: t("admin_invoices_invoice_sent"), description: t("admin_invoices_invoice_has_been_sent") });
    },
    onError: () => {
      toast({ title: t("admin_invoices_send_failed"), description: t("admin_invoices_failed_to_send_invoice"), variant: "destructive" });
    }
  });

  const markPaidMutation = useMutation({
    mutationFn: async (invoiceId: string) => {
      await new Promise(resolve => setTimeout(resolve, 1000));
      return invoiceId;
    },
    onSuccess: (invoiceId) => {
      queryClient.setQueryData(['customer-invoices'], (old: any) => ({
        ...old,
        invoices: old.invoices.map((inv: CustomerInvoice) =>
          inv.id === invoiceId ? { ...inv, status: 'PAID' as const, paidDate: new Date().toISOString() } : inv
        ),
      }));
      toast({ title: t("admin_invoices_invoice_paid"), description: t("admin_invoices_invoice_has_been_marked") });
    },
    onError: () => {
      toast({ title: t("admin_invoices_update_failed"), description: t("admin_invoices_failed_to_update_invoice"), variant: "destructive" });
    }
  });

  const filteredInvoices = invoices.filter((invoice: any) => {
    const matchesSearch = invoice.customerName.toLowerCase().includes(searchTerm.toLowerCase()) || invoice.customerEmail.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesStatus = statusFilter === "ALL" || invoice.status === statusFilter;
    const matchesCustomer = customerFilter === "" || invoice.customerId === customerFilter;
    const matchesDate = dateFilter === "" || new Date(invoice.dueDate).toISOString().split('T')[0] === dateFilter;
    return matchesSearch && matchesStatus && matchesCustomer && matchesDate;
  });

  const totalRevenue = invoices.filter((inv: any) => inv.status === 'PAID').reduce((sum: any, inv: any) => sum + inv.totalAmount, 0);
  const totalOutstanding = invoices.filter((inv: any) => inv.status === 'OVERDUE').reduce((sum: any, inv: any) => sum + inv.totalAmount, 0);
  const handleCreateInvoice = () => navigate('/admin/invoices/create');

  if (isLoading) {
    return (
      <div className="space-y-6">
        <div className="flex items-center justify-center h-64">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-slate-500"></div>
        </div>
      </div>
    );
  }

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div className="bg-card p-6 rounded-xl border border-border flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-card-foreground">{t("admin_invoices_customer_billing")}</h1>
          <p className="text-sm text-slate-500 dark:text-slate-400 mt-1">{t("admin_invoices_invoice_management_and_customer")}</p>
        </div>
        <div className="flex items-center gap-4">
          <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
            <DialogTrigger asChild>
              <Button onClick={handleCreateInvoice} className="bg-slate-600 hover:bg-slate-500 text-card-foreground font-bold text-xs">
                <Plus className="w-4 h-4 mr-2" />{t("admin_invoices_create_invoice")}
              </Button>
            </DialogTrigger>
            <DialogContent className="sm:max-w-[425px] bg-card border-border text-card-foreground">
              <DialogHeader>
                <DialogTitle>Create New Customer Invoice</DialogTitle>
                <DialogDescription className="text-slate-500 dark:text-slate-400">
                  Enter the details for the new customer invoice.
                </DialogDescription>
              </DialogHeader>
              <div className="grid gap-4 py-4">
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="customerId" className="text-right text-xs text-slate-500 dark:text-slate-400">Customer ID</Label>
                  <Input id="customerId" className="col-span-3 h-10 bg-card border-border text-card-foreground" value={formData.customerId} onChange={e => setFormData({ ...formData, customerId: e.target.value })} placeholder="Enter customer id" />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="amount" className="text-right text-xs text-slate-500 dark:text-slate-400">Amount</Label>
                  <Input id="amount" className="col-span-3 h-10 bg-card border-border text-card-foreground" value={formData.amount} onChange={e => setFormData({ ...formData, amount: e.target.value })} placeholder="Enter amount" />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="status" className="text-right text-xs text-slate-500 dark:text-slate-400">Status</Label>
                  <Input id="status" className="col-span-3 h-10 bg-card border-border text-card-foreground" value={formData.status} onChange={e => setFormData({ ...formData, status: e.target.value })} placeholder="Enter status" />
                </div>
              </div>
              <DialogFooter>
                <Button variant="outline" onClick={() => setIsAddOpen(false)}>Cancel</Button>
                <Button onClick={() => createMutation.mutate(formData)} disabled={createMutation.isPending}>
                  {createMutation.isPending ? "Saving..." : "Save Changes"}
                </Button>
              </DialogFooter>
            </DialogContent>
          </Dialog>
        </div>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <Card className="bg-card border-border rounded-xl p-6">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-emerald-500/20 flex items-center justify-center">
              <DollarSign className="w-5 h-5 text-emerald-400" />
            </div>
            <div>
              <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400">{t("admin_invoices_total_revenue")}</p>
              <p className="text-2xl font-bold text-card-foreground">${totalRevenue.toLocaleString()}</p>
            </div>
          </div>
        </Card>
        <Card className="bg-card border-border rounded-xl p-6">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-red-500/20 flex items-center justify-center">
              <AlertTriangle className="w-5 h-5 text-red-400" />
            </div>
            <div>
              <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400">{t("admin_invoices_outstanding")}</p>
              <p className="text-2xl font-bold text-card-foreground">${totalOutstanding.toLocaleString()}</p>
            </div>
          </div>
        </Card>
        <Card className="bg-card border-border rounded-xl p-6">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-slate-500/20 flex items-center justify-center">
              <Users className="w-5 h-5 text-slate-500 dark:text-slate-400" />
            </div>
            <div>
              <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400">{t("admin_invoices_total_customers")}</p>
              <p className="text-2xl font-bold text-card-foreground">{customers.length}</p>
            </div>
          </div>
        </Card>
      </div>

      {/* Navigation Tabs */}
      <div className="flex space-x-1 border-b border-border">
        {[{
          id: 'invoices', label: t("admin_invoices_invoices"), icon: <FileText className="w-4 h-4" />
        }, {
          id: 'customers', label: t("admin_invoices_customers"), icon: <Users className="w-4 h-4" />
        }, {
          id: 'templates', label: t("admin_invoices_templates"), icon: <FileText className="w-4 h-4" />
        }, {
          id: 'analytics', label: t("admin_invoices_analytics"), icon: <TrendingUp className="w-4 h-4" />
        }].map(tab => (
          <button key={tab.id} onClick={() => setActiveTab(tab.id as any)} className={cn("px-4 py-3 text-sm font-medium transition-colors border-b-2", activeTab === tab.id ? "text-card-foreground border-slate-500" : "text-slate-500 dark:text-slate-400 border-transparent hover:text-card-foreground")}>
            <div className="flex items-center gap-2">
              {tab.icon}
              {tab.label}
            </div>
          </button>
        ))}
      </div>

      {/* Tab Content */}
      <div className="mt-8">
        {/* Invoices Tab */}
        {activeTab === 'invoices' && (
          <div className="space-y-6">
            <Card className="bg-card border-border rounded-xl p-6">
              <CardHeader>
                <CardTitle className="text-lg font-bold text-card-foreground">{t("admin_invoices_filters")}</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
                  <div className="space-y-2">
                    <Label htmlFor="search" className="text-[10px] font-bold text-slate-500 dark:text-slate-400">{t("admin_invoices_search")}</Label>
                    <Input id="search" value={searchTerm} onChange={e => setSearchTerm(e.target.value)} placeholder={t("admin_invoices_search_by_customer_name")} className="bg-card border-border text-card-foreground" />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="status" className="text-[10px] font-bold text-slate-500 dark:text-slate-400">{t("admin_invoices_status")}</Label>
                    <Select value={statusFilter} onValueChange={value => setStatusFilter(value)}>
                      <SelectTrigger className="bg-card border-border text-card-foreground">
                        <SelectValue placeholder={t("admin_invoices_all_status")} />
                      </SelectTrigger>
                      <SelectContent className="bg-card border-border text-card-foreground">
                        <SelectItem value="ALL">{t("admin_invoices_all_status")}</SelectItem>
                        <SelectItem value="DRAFT">{t("admin_invoices_draft")}</SelectItem>
                        <SelectItem value="SENT">{t("admin_invoices_sent")}</SelectItem>
                        <SelectItem value="PAID">{t("admin_invoices_paid")}</SelectItem>
                        <SelectItem value="OVERDUE">{t("admin_invoices_overdue")}</SelectItem>
                        <SelectItem value="CANCELLED">{t("admin_invoices_cancelled")}</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="customer" className="text-[10px] font-bold text-slate-500 dark:text-slate-400">{t("admin_invoices_customer")}</Label>
                    <Select value={customerFilter} onValueChange={value => setCustomerFilter(value)}>
                      <SelectTrigger className="bg-card border-border text-card-foreground">
                        <SelectValue placeholder={t("admin_invoices_all_customers")} />
                      </SelectTrigger>
                      <SelectContent className="bg-card border-border text-card-foreground">
                        <SelectItem value="">{t("admin_invoices_all_customers")}</SelectItem>
                        {customers.map((customer: any) => (
                          <SelectItem key={customer.id} value={customer.id}>
                            {customer.name} ({customer.email})
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="date" className="text-[10px] font-bold text-slate-500 dark:text-slate-400">{t("admin_invoices_due_date")}</Label>
                    <Input id="date" type="date" value={dateFilter} onChange={e => setDateFilter(e.target.value)} className="bg-card border-border text-card-foreground" />
                  </div>
                </div>
              </CardContent>
            </Card>

            <Card className="bg-card border-border rounded-xl p-8">
              <CardHeader>
                <CardTitle className="text-lg font-bold text-card-foreground flex items-center gap-2">
                  <FileText className="w-5 h-5 text-slate-500" />{t("admin_invoices_customer_invoices")} ({filteredInvoices.length})
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {filteredInvoices.map((invoice: any) => (
                    <motion.div key={invoice.id} initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} className="bg-card rounded-xl p-4 border border-border">
                      <div className="flex items-center justify-between">
                        <div className="flex-1">
                          <div className="flex items-center gap-3 mb-2">
                            {getStatusIcon(invoice.status)}
                            <div>
                              <h4 className="text-sm font-bold text-card-foreground">{invoice.customerName}</h4>
                              <p className="text-xs text-slate-500 dark:text-slate-400">{invoice.customerEmail}</p>
                              <p className="text-xs text-slate-500 dark:text-slate-400">{invoice.customerAddress}</p>
                            </div>
                            <div className="text-right">
                              <Badge className={cn("text-[9px] font-bold px-2 border-0 shadow-lg",
                                invoice.status === 'PAID' ? 'bg-emerald-500/10 text-emerald-400' :
                                invoice.status === 'SENT' ? 'bg-slate-500/10 text-slate-500 dark:text-slate-400' :
                                invoice.status === 'OVERDUE' ? 'bg-red-500/10 text-red-400' :
                                invoice.status === 'CANCELLED' ? 'bg-orange-500/10 text-orange-400' :
                                'bg-slate-500/10 text-slate-500 dark:text-slate-400'
                              )}>
                                {getLocalizedStatus(invoice.status)}
                              </Badge>
                            </div>
                          </div>
                          <div className="space-y-2">
                            <p className="text-xs text-slate-500 dark:text-slate-400">{t("admin_invoices_invoice")}{invoice.id}</p>
                            <p className="text-xs text-slate-500 dark:text-slate-400">{t("admin_invoices_due")}{new Date(invoice.dueDate).toLocaleDateString()}</p>
                            <p className="text-xs text-slate-500 dark:text-slate-400">
                              {invoice.sentDate ? `${t("admin_invoices_sent_on", "Gonderildi:")} ${new Date(invoice.sentDate).toLocaleDateString()}` : t("admin_invoices_not_sent", "Gonderilmedi")}
                            </p>
                          </div>
                          <div className="flex items-center justify-between">
                            <div>
                              <p className="text-lg font-bold text-card-foreground">${invoice.totalAmount.toLocaleString()} {invoice.currency}</p>
                              <p className="text-xs text-slate-500 dark:text-slate-400">{invoice.items.length}{t("admin_invoices_items_tax")}{invoice.taxRate * 100}%</p>
                            </div>
                            <div className="flex items-center gap-2">
                              <Button size="sm" variant="outline"><Eye className="w-3 h-3 mr-1" />{t("admin_invoices_view")}</Button>
                              {invoice.status === 'DRAFT' && <Button size="sm" variant="outline"><Edit className="w-3 h-3 mr-1" />{t("admin_invoices_edit")}</Button>}
                              {invoice.status === 'DRAFT' && <Button size="sm" variant="outline"><Send className="w-3 h-3 mr-1" />{t("admin_invoices_send")}</Button>}
                              {invoice.status === 'SENT' && <Button size="sm" variant="outline" onClick={() => sendInvoiceMutation.mutate(invoice.id)} disabled={sendInvoiceMutation.isPending}><Mail className="w-3 h-3 mr-1" />{t("admin_invoices_resend")}</Button>}
                              {invoice.status !== 'PAID' && <Button size="sm" variant="outline" onClick={() => markPaidMutation.mutate(invoice.id)} disabled={markPaidMutation.isPending}><CreditCard className="w-3 h-3 mr-1" />{t("admin_invoices_mark_paid")}</Button>}
                              <Button size="sm" variant="outline"><Download className="w-3 h-3 mr-1" />{t("admin_invoices_pdf")}</Button>
                            </div>
                          </div>
                        </div>
                      </div>
                    </motion.div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </div>
        )}

        {/* Customers Tab */}
        {activeTab === 'customers' && (
          <div className="space-y-6">
            <Card className="bg-card border-border rounded-xl p-8">
              <CardHeader>
                <CardTitle className="text-lg font-bold text-card-foreground flex items-center gap-2">
                  <Users className="w-5 h-5 text-emerald-500" />{t("admin_invoices_customers")} ({customers.length})
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {customers.map((customer: any) => (
                    <motion.div key={customer.id} initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} className="bg-card rounded-xl p-4 border border-border">
                      <div className="flex items-center justify-between">
                        <div className="flex items-center gap-3">
                          <div className="w-10 h-10 rounded-xl bg-emerald-500/20 flex items-center justify-center">
                            <Users className="w-5 h-5 text-emerald-400" />
                          </div>
                          <div>
                            <h4 className="text-sm font-bold text-card-foreground">{customer.name}</h4>
                            <p className="text-xs text-slate-500 dark:text-slate-400">{customer.email}</p>
                            <p className="text-xs text-slate-500 dark:text-slate-400">{customer.phone}</p>
                            <p className="text-xs text-slate-500 dark:text-slate-400">{customer.address}</p>
                            {customer.company && <p className="text-xs text-slate-500 dark:text-slate-400">{customer.company}</p>}
                          </div>
                        </div>
                        <div className="text-right">
                          <div className="text-xs text-slate-500 dark:text-slate-400">
                            <p>{t("admin_invoices_total_invoices")}{customer.totalInvoices || 0}</p>
                            <p>{t("admin_invoices_paid")}{customer.paidInvoices || 0}</p>
                            <p>{t("admin_invoices_outstanding")}${customer.outstandingAmount?.toLocaleString() || '0'}</p>
                          </div>
                          <div className="flex items-center gap-2">
                            <Button size="sm" variant="ghost" className="text-slate-500 dark:text-slate-400 hover:text-card-foreground hover:bg-card"><Eye className="w-4 h-4 mr-1.5" />{t("admin_invoices_details")}</Button>
                            <Button size="sm" className="bg-emerald-600/10 text-emerald-400 border border-emerald-500/20 hover:bg-emerald-600/20" onClick={() => navigate('/admin/invoices/create')}><Plus className="w-4 h-4 mr-1.5" />{t("admin_invoices_new_invoice")}</Button>
                          </div>
                        </div>
                      </div>
                    </motion.div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </div>
        )}

        {/* Templates Tab */}
        {activeTab === 'templates' && (
          <div className="space-y-6">
            <Card className="bg-card border-border rounded-xl p-8">
              <CardHeader>
                <CardTitle className="text-lg font-bold text-card-foreground flex items-center gap-2">
                  <FileText className="w-5 h-5 text-slate-500" />{t("admin_invoices_invoice_templates")}
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                  {[{
                    name: "Standard Service", type: t("admin_invoices_management_type", "Yonetim"), color: "slate", usage: 124
                  }, {
                    name: "Premium Rental", type: t("admin_invoices_booking_type", "Rezervasyon"), color: "emerald", usage: 89
                  }, {
                    name: "Late Penalty", type: t("admin_invoices_legal_type", "Hukuki"), color: "red", usage: 12
                  }, {
                    name: "Utility Rebate", type: t("admin_invoices_credit_type", "Kredi"), color: "orange", usage: 45
                  }, {
                    name: "Bulk Deposit", type: t("admin_invoices_brokerage_type", "Komisyon"), color: "slate", usage: 67
                  }].map((template, i) => (
                    <motion.div key={i} whileHover={{ y: -5 }} className="bg-card border border-border rounded-xl p-6 group cursor-pointer relative overflow-hidden">
                      <div className={cn("absolute top-0 left-0 w-1 h-full opacity-30 group-hover:w-full transition-all duration-500", template.color === 'slate' ? "bg-slate-500" : template.color === 'emerald' ? "bg-emerald-500" : template.color === 'red' ? "bg-red-500" : template.color === 'orange' ? "bg-orange-500" : "bg-slate-500")} />
                      <div className="relative z-10 flex flex-col h-full">
                        <div className="flex justify-between items-start mb-4">
                          <div className={cn("w-10 h-10 rounded-xl flex items-center justify-center", template.color === 'slate' ? "bg-slate-500/20 text-slate-500 dark:text-slate-400" : template.color === 'emerald' ? "bg-emerald-500/20 text-emerald-400" : template.color === 'red' ? "bg-red-500/20 text-red-400" : template.color === 'orange' ? "bg-orange-500/20 text-orange-400" : "bg-slate-500/20 text-slate-500 dark:text-slate-400")}>
                            <FileText className="w-5 h-5" />
                          </div>
                          <Badge className="bg-card text-slate-500 dark:text-slate-400 border-border text-[9px] font-bold">{template.usage}{t("admin_invoices_x_used")}</Badge>
                        </div>
                        <h4 className="text-card-foreground font-bold mb-1">{template.name}</h4>
                        <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400 mb-6">{template.type}{t("admin_invoices_template")}</p>
                        <div className="mt-auto flex gap-2">
                          <Button size="sm" variant="ghost" className="h-8 text-[10px] font-bold text-slate-500 dark:text-slate-400 hover:text-card-foreground"><Eye className="w-3 h-3 mr-1.5" />{t("admin_invoices_preview")}</Button>
                          <Button size="sm" className="h-8 bg-slate-600 hover:bg-slate-500 text-[10px] font-bold">{t("admin_invoices_use_now")}</Button>
                        </div>
                      </div>
                    </motion.div>
                  ))}
                  <div className="border-2 border-dashed border-border rounded-xl flex flex-col items-center justify-center p-8 hover:bg-card transition-colors cursor-pointer group">
                    <Plus className="w-8 h-8 text-slate-600 group-hover:text-slate-500 transition-colors mb-2" />
                    <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400">{t("admin_invoices_new_template")}</p>
                  </div>
                </div>
              </CardContent>
            </Card>
          </div>
        )}

        {/* Analytics Tab */}
        {activeTab === 'analytics' && (
          <div className="space-y-6">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <Card className="bg-card border-border rounded-xl p-6">
                <CardHeader>
                  <CardTitle className="text-lg font-bold text-card-foreground flex items-center gap-2">
                    <TrendingUp className="w-5 h-5 text-emerald-500" />{t("admin_invoices_revenue_overview")}
                  </CardTitle>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div className="text-center">
                    <div className="text-xl font-bold text-card-foreground">${totalRevenue.toLocaleString()}</div>
                    <p className="text-sm text-slate-500 dark:text-slate-400">{t("admin_invoices_total_revenue")}</p>
                  </div>
                  <div className="grid grid-cols-2 gap-4 text-sm">
                    <div>
                      <p className="text-slate-500 dark:text-slate-400">{t("admin_invoices_paid_invoices")}</p>
                      <p className="text-lg font-bold text-card-foreground">{invoices.filter((inv: any) => inv.status === 'PAID').length}</p>
                    </div>
                    <div>
                      <p className="text-slate-500 dark:text-slate-400">{t("admin_invoices_pending_invoices")}</p>
                      <p className="text-lg font-bold text-card-foreground">{invoices.filter((inv: any) => inv.status === 'SENT').length}</p>
                    </div>
                  </div>
                </CardContent>
              </Card>

              <Card className="bg-card border-border rounded-xl p-6 relative overflow-hidden group">
                <div className="absolute top-0 right-0 w-32 h-32 bg-red-500/5 blur-3xl rounded-full translate-x-16 -translate-y-16 group-hover:bg-red-500/10 transition-all duration-700" />
                <CardHeader>
                  <CardTitle className="text-lg font-bold text-card-foreground flex items-center gap-2">
                    <AlertTriangle className="w-5 h-5 text-red-500" />{t("admin_invoices_outstanding_debt")}
                  </CardTitle>
                </CardHeader>
                <CardContent className="space-y-6">
                  <div className="text-center relative">
                    <div className="text-2xl font-bold text-red-400">${totalOutstanding.toLocaleString()}</div>
                    <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400 tracking-[0.3em] mt-2">{t("admin_invoices_recovery_target")}</p>
                  </div>
                  <div className="space-y-4">
                    <div className="flex justify-between items-end">
                      <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400">{t("admin_invoices_risk_exposure")}</p>
                      <p className="text-sm font-bold text-card-foreground">{t("admin_invoices_high")}</p>
                    </div>
                    <Progress value={65} className="h-1.5 bg-card [&>div]:bg-red-500/50" />
                    <div className="grid grid-cols-2 gap-4 pt-2">
                      <div className="p-3 bg-card rounded-xl border border-border">
                        <p className="text-[9px] font-bold text-slate-500 dark:text-slate-400 leading-none mb-1">{t("admin_invoices_overdue")}</p>
                        <p className="text-lg font-bold text-card-foreground">{invoices.filter((inv: any) => inv.status === 'OVERDUE').length}</p>
                      </div>
                      <div className="p-3 bg-card rounded-xl border border-border">
                        <p className="text-[9px] font-bold text-slate-500 dark:text-slate-400 leading-none mb-1">{t("admin_invoices_avg_aging")}</p>
                        <p className="text-lg font-bold text-card-foreground">{t("admin_invoices_24_days")}</p>
                      </div>
                    </div>
                  </div>
                </CardContent>
              </Card>

              <Card className="md:col-span-2 bg-card border-border rounded-xl p-6 relative overflow-hidden">
                <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-slate-500 via-emerald-500 to-slate-500 opacity-30" />
                <CardHeader className="flex flex-row items-center justify-between">
                  <CardTitle className="text-lg font-bold text-card-foreground flex items-center gap-2">
                    <BarChart3 className="w-5 h-5 text-slate-500" />{t("admin_invoices_neural_cashflow_pulse")}
                  </CardTitle>
                  <Badge className="bg-emerald-500/10 text-emerald-400 border-emerald-500/20 text-[10px] font-bold">{t("admin_invoices_124_mo")}</Badge>
                </CardHeader>
                <CardContent>
                  <div className="h-48 flex items-end justify-between gap-2 px-4 pb-4">
                    {[45, 62, 58, 75, 42, 68, 85, 55, 92, 78, 64, 82].map((val, i) => (
                      <motion.div key={i} initial={{ height: 0 }} animate={{ height: `${val}%` }} transition={{ delay: i * 0.05, duration: 1, ease: "circOut" }} className="flex-1 bg-gradient-to-t from-slate-600/20 to-slate-500/40 rounded-t-lg relative group cursor-pointer">
                        <div className="absolute -top-8 left-1/2 -translate-x-1/2 bg-card text-card-foreground border-border text-card-foreground text-[9px] font-bold px-1.5 py-0.5 rounded-lg opacity-0 group-hover:opacity-100 transition-opacity whitespace-nowrap">${val}k</div>
                      </motion.div>
                    ))}
                  </div>
                  <div className="flex justify-between text-[9px] font-bold text-slate-600 tracking-[0.2em] px-4 pt-4 border-t border-border">
                    <span>{t("admin_invoices_jan")}</span><span>{t("admin_invoices_mar")}</span><span>{t("admin_invoices_may")}</span><span>{t("admin_invoices_jul")}</span><span>{t("admin_invoices_sep")}</span><span>{t("admin_invoices_nov")}</span>
                  </div>
                </CardContent>
              </Card>

              <Card className="col-span-1 md:col-span-3 bg-card border-border rounded-xl p-6 overflow-hidden">
                <div className="flex items-center justify-between mb-6">
                  <CardTitle className="text-lg font-bold text-card-foreground flex items-center gap-2">
                    <Activity className="w-5 h-5 text-slate-500" />{t("admin_invoices_live_billing_node_activity")}
                  </CardTitle>
                  <Button variant="ghost" size="sm" className="text-slate-500 dark:text-slate-400 text-[10px] font-bold">{t("admin_invoices_clear_logs")}</Button>
                </div>
                <div className="space-y-3">
                  {[{
                    event: t("admin_invoices_invoice_sent", "Fatura Gonderildi"),
                    user: "John Doe Properties", sub: "$2,700.00", time: t("admin_invoices_2_min_ago", "2 dk once"),
                    icon: <Send className="w-3 h-3" />, color: "slate"
                  }, {
                    event: t("admin_invoices_payment_received", "Odeme Alindi"),
                    user: "Jane Smith Realty", sub: "$1,296.00", time: t("admin_invoices_14_min_ago", "14 dk once"),
                    icon: <CheckCircle className="w-3 h-3" />, color: "emerald"
                  }, {
                    event: t("admin_invoices_auto_alert_overdue", "Otomatik Uyari: Gecikmis"),
                    user: "Johnson Commercial", sub: "$12,500.00", time: t("admin_invoices_1_hour_ago", "1 saat once"),
                    icon: <AlertTriangle className="w-3 h-3" />, color: "red"
                  }, {
                    event: t("admin_invoices_draft_generated", "Taslak Olusturuldu"),
                    user: "New Prospect LP", sub: "$4,500.00", time: t("admin_invoices_3_hours_ago", "3 saat once"),
                    icon: <FileText className="w-3 h-3" />, color: "slate"
                  }].map((log, i) => (
                    <div key={i} className="flex items-center justify-between p-3 bg-card rounded-xl border border-border hover:bg-card transition-colors">
                      <div className="flex items-center gap-4">
                        <div className={cn("w-8 h-8 rounded-lg flex items-center justify-center", log.color === 'slate' ? "bg-slate-500/20 text-slate-500 dark:text-slate-400" : log.color === 'emerald' ? "bg-emerald-500/20 text-emerald-400" : log.color === 'red' ? "bg-red-500/20 text-red-400" : "bg-slate-500/20 text-slate-500 dark:text-slate-400")}>
                          {log.icon}
                        </div>
                        <div>
                          <p className="text-[10px] font-bold text-card-foreground tracking-tight leading-none mb-1">{log.event}</p>
                          <p className="text-xs text-slate-500 dark:text-slate-400 font-medium">{log.user}</p>
                        </div>
                      </div>
                      <div className="text-right">
                        <p className="text-xs font-bold text-card-foreground">{log.sub}</p>
                        <p className="text-[9px] font-bold text-slate-600">{log.time}</p>
                      </div>
                    </div>
                  ))}
                </div>
              </Card>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
