import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Label } from "@/components/ui/label";
import { Progress } from "@/components/ui/progress";
import { Users, FileText, Download, Send, CheckCircle, AlertTriangle, Clock, DollarSign, TrendingUp, Calendar, Mail, Phone, Search, Filter, Plus, Eye, Edit, Trash2, CreditCard, BarChart3, Activity } from "lucide-react";
import { motion } from "framer-motion";
import { cn } from "@/lib/utils";
import { useToast } from "@/hooks/use-toast";
import { edenClient } from "@/lib/eden-client";
import { useNavigate } from "react-router-dom";
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
export default function CustomerInvoices() {
  const {
    t
  } = useTranslation();
  const [activeTab, setActiveTab] = useState<'invoices' | 'customers' | 'templates' | 'analytics'>('invoices');
  const [invoices, setInvoices] = useState<CustomerInvoice[]>([]);
  const [customers, setCustomers] = useState<Customer[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState("");
  const [statusFilter, setStatusFilter] = useState("ALL");
  const [customerFilter, setCustomerFilter] = useState("");
  const [dateFilter, setDateFilter] = useState("");
  const {
    toast
  } = useToast();
  const navigate = useNavigate();

  // Mock data
  const [mockCustomers] = useState<Customer[]>([{
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
  }]);
  const [mockInvoices] = useState<CustomerInvoice[]>([{
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
      description: t("admin.invoices.property_management_fee_march"),
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
      description: t("admin.invoices.commission_property_sale"),
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
  }]);
  useEffect(() => {
    // Simulate API calls
    setTimeout(() => {
      setCustomers(mockCustomers);
      setInvoices(mockInvoices);
      setLoading(false);
    }, 1000);
  }, []);
  const getLocalizedStatus = (status: string) => {
    const map: Record<string, string> = {
      'PAID': t('admin.invoices.paid_status', 'Ödendi'),
      'SENT': t('admin.invoices.sent_status', 'Gönderildi'),
      'OVERDUE': t('admin.invoices.overdue_status', 'Gecikmiş'),
      'DRAFT': t('admin.invoices.draft_status', 'Taslak'),
      'CANCELLED': t('admin.invoices.cancelled_status', 'İptal Edildi')
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
  const filteredInvoices = invoices.filter(invoice => {
    const matchesSearch = invoice.customerName.toLowerCase().includes(searchTerm.toLowerCase()) || invoice.customerEmail.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesStatus = statusFilter === "ALL" || invoice.status === statusFilter;
    const matchesCustomer = customerFilter === "" || invoice.customerId === customerFilter;
    const matchesDate = dateFilter === "" || new Date(invoice.dueDate).toISOString().split('T')[0] === dateFilter;
    return matchesSearch && matchesStatus && matchesCustomer && matchesDate;
  });
  const totalRevenue = invoices.filter(inv => inv.status === 'PAID').reduce((sum, inv) => sum + inv.totalAmount, 0);
  const totalOutstanding = invoices.filter(inv => inv.status === 'OVERDUE').reduce((sum, inv) => sum + inv.totalAmount, 0);
  const handleSendInvoice = async (invoiceId: string) => {
    try {
      // Mock API call
      await new Promise(resolve => setTimeout(resolve, 2000));
      setInvoices(prev => prev.map(inv => inv.id === invoiceId ? {
        ...inv,
        status: 'SENT',
        sentDate: new Date().toISOString()
      } : inv));
      toast({
        title: t("admin.invoices.invoice_sent"),
        description: t("admin.invoices.invoice_has_been_sent")
      });
    } catch (error) {
      toast({
        title: t("admin.invoices.send_failed"),
        description: t("admin.invoices.failed_to_send_invoice"),
        variant: "destructive"
      });
    }
  };
  const handleMarkPaid = async (invoiceId: string) => {
    try {
      // Mock API call
      await new Promise(resolve => setTimeout(resolve, 1000));
      setInvoices(prev => prev.map(inv => inv.id === invoiceId ? {
        ...inv,
        status: 'PAID',
        paidDate: new Date().toISOString()
      } : inv));
      toast({
        title: t("admin.invoices.invoice_paid"),
        description: t("admin.invoices.invoice_has_been_marked")
      });
    } catch (error) {
      toast({
        title: t("admin.invoices.update_failed"),
        description: t("admin.invoices.failed_to_update_invoice"),
        variant: "destructive"
      });
    }
  };
  const handleCreateInvoice = () => {
    navigate('/admin/invoices/create');
  };
  if (loading) {
    return <PageShell title={t("admin.invoices.customer_invoices")} description={t("admin.invoices.manage_customer_billing_and")}>
        <div className="flex items-center justify-center h-64">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-500"></div>
        </div>
      </PageShell>;
  }
  return <PageShell title={t("admin.invoices.customer_invoices")} description={t("admin.invoices.manage_customer_billing_and")}>
      <div className="max-w-7xl mx-auto px-4 lg:px-8 py-10 space-y-8">
        
        {/* Header */}
        <div className="flex items-center justify-between">
          <div>
            <h1 className="text-3xl font-bold text-foreground">{t("admin.invoices.customer_billing")}</h1>
            <p className="text-sm text-muted-foreground mt-1">{t("admin.invoices.invoice_management_and_customer")}</p>
          </div>
          
          <div className="flex items-center gap-4">
            <Button onClick={handleCreateInvoice} className="bg-blue-600 hover:bg-blue-500 text-foreground font-bold text-xs">
              <Plus className="w-4 h-4 mr-2" />{t("admin.invoices.create_invoice")}</Button>
          </div>
        </div>

        {/* Stats Cards */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <Card className="bg-card border-border rounded-3xl p-6">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-xl bg-emerald-500/20 flex items-center justify-center">
                <DollarSign className="w-5 h-5 text-emerald-400" />
              </div>
              <div>
                <p className="text-[10px] font-bold text-muted-foreground">{t("admin.invoices.total_revenue")}</p>
                <p className="text-2xl font-bold text-foreground">${totalRevenue.toLocaleString()}</p>
              </div>
            </div>
          </Card>

          <Card className="bg-card border-border rounded-3xl p-6">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-xl bg-red-500/20 flex items-center justify-center">
                <AlertTriangle className="w-5 h-5 text-red-400" />
              </div>
              <div>
                <p className="text-[10px] font-bold text-muted-foreground">{t("admin.invoices.outstanding")}</p>
                <p className="text-2xl font-bold text-foreground">${totalOutstanding.toLocaleString()}</p>
              </div>
            </div>
          </Card>

          <Card className="bg-card border-border rounded-3xl p-6">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-xl bg-blue-500/20 flex items-center justify-center">
                <Users className="w-5 h-5 text-blue-400" />
              </div>
              <div>
                <p className="text-[10px] font-bold text-muted-foreground">{t("admin.invoices.total_customers")}</p>
                <p className="text-2xl font-bold text-foreground">{customers.length}</p>
              </div>
            </div>
          </Card>
        </div>

        {/* Navigation Tabs */}
        <div className="flex space-x-1 border-b border-border">
          {[{
          id: 'invoices',
          label: t("admin.invoices.invoices"),
          icon: <FileText className="w-4 h-4" />
        }, {
          id: 'customers',
          label: t("admin.invoices.customers"),
          icon: <Users className="w-4 h-4" />
        }, {
          id: 'templates',
          label: t("admin.invoices.templates"),
          icon: <FileText className="w-4 h-4" />
        }, {
          id: 'analytics',
          label: t("admin.invoices.analytics"),
          icon: <TrendingUp className="w-4 h-4" />
        }].map(tab => <button key={tab.id} onClick={() => setActiveTab(tab.id as any)} className={cn("px-4 py-3 text-sm font-medium transition-colors border-b-2", activeTab === tab.id ? "text-foreground border-blue-500" : "text-muted-foreground border-transparent hover:text-foreground")}>
              <div className="flex items-center gap-2">
                {tab.icon}
                {tab.label}
              </div>
            </button>)}
        </div>

        {/* Tab Content */}
        <div className="mt-8">
          
          {/* Invoices Tab */}
          {activeTab === 'invoices' && <div className="space-y-6">
              {/* Filters */}
              <Card className="bg-card border-border rounded-3xl p-6">
                <CardHeader>
                  <CardTitle className="text-lg font-bold text-foreground">{t("admin.invoices.filters")}</CardTitle>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
                    <div className="space-y-2">
                      <Label htmlFor="search" className="text-[10px] font-bold text-muted-foreground">{t("admin.invoices.search")}</Label>
                      <Input id="search" value={searchTerm} onChange={e => setSearchTerm(e.target.value)} placeholder={t("admin.invoices.search_by_customer_name")} className="bg-muted/50 border-border text-foreground" />
                    </div>
                    
                    <div className="space-y-2">
                      <Label htmlFor="status" className="text-[10px] font-bold text-muted-foreground">{t("admin.invoices.status")}</Label>
                      <Select value={statusFilter} onValueChange={value => setStatusFilter(value)}>
                        <SelectTrigger className="bg-muted/50 border-border text-foreground">
                          <SelectValue placeholder={t("admin.invoices.all_status")} />
                        </SelectTrigger>
                        <SelectContent className="bg-[#14151a] border-border">
                          <SelectItem value="ALL">{t("admin.invoices.all_status")}</SelectItem>
                          <SelectItem value="DRAFT">{t("admin.invoices.draft")}</SelectItem>
                          <SelectItem value="SENT">{t("admin.invoices.sent")}</SelectItem>
                          <SelectItem value="PAID">{t("admin.invoices.paid")}</SelectItem>
                          <SelectItem value="OVERDUE">{t("admin.invoices.overdue")}</SelectItem>
                          <SelectItem value="CANCELLED">{t("admin.invoices.cancelled")}</SelectItem>
                        </SelectContent>
                      </Select>
                    </div>
                    
                    <div className="space-y-2">
                      <Label htmlFor="customer" className="text-[10px] font-bold text-muted-foreground">{t("admin.invoices.customer")}</Label>
                      <Select value={customerFilter} onValueChange={value => setCustomerFilter(value)}>
                        <SelectTrigger className="bg-muted/50 border-border text-foreground">
                          <SelectValue placeholder={t("admin.invoices.all_customers")} />
                        </SelectTrigger>
                        <SelectContent className="bg-[#14151a] border-border">
                          <SelectItem value="">{t("admin.invoices.all_customers")}</SelectItem>
                          {customers.map(customer => <SelectItem key={customer.id} value={customer.id}>
                              {customer.name} ({customer.email})
                            </SelectItem>)}
                        </SelectContent>
                      </Select>
                    </div>
                    
                    <div className="space-y-2">
                      <Label htmlFor="date" className="text-[10px] font-bold text-muted-foreground">{t("admin.invoices.due_date")}</Label>
                      <Input id="date" type="date" value={dateFilter} onChange={e => setDateFilter(e.target.value)} className="bg-muted/50 border-border text-foreground" />
                    </div>
                  </div>
                </CardContent>
              </Card>

              {/* Invoices List */}
              <Card className="bg-card border-border rounded-3xl p-8">
                <CardHeader>
                  <CardTitle className="text-lg font-bold text-foreground flex items-center gap-2">
                    <FileText className="w-5 h-5 text-blue-500" />{t("admin.invoices.customer_invoices")}{filteredInvoices.length})
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    {filteredInvoices.map(invoice => <motion.div key={invoice.id} initial={{
                  opacity: 0,
                  y: 10
                }} animate={{
                  opacity: 1,
                  y: 0
                }} className="bg-muted/50 rounded-2xl p-4 border border-border">
                        <div className="flex items-center justify-between">
                          <div className="flex-1">
                            <div className="flex items-center gap-3 mb-2">
                              {getStatusIcon(invoice.status)}
                              <div>
                                <h4 className="text-sm font-bold text-foreground">{invoice.customerName}</h4>
                                <p className="text-xs text-muted-foreground">{invoice.customerEmail}</p>
                                <p className="text-xs text-muted-foreground">{invoice.customerAddress}</p>
                              </div>
                              
                              <div className="text-right">
                                <Badge className={cn("text-[9px] font-bold   px-2 border-0 shadow-lg", 
                                  invoice.status === 'PAID' ? 'bg-emerald-500/10 text-emerald-400' :
                                  invoice.status === 'SENT' ? 'bg-blue-500/10 text-blue-400' :
                                  invoice.status === 'OVERDUE' ? 'bg-red-500/10 text-red-400' :
                                  invoice.status === 'CANCELLED' ? 'bg-orange-500/10 text-orange-400' :
                                  'bg-slate-500/10 text-muted-foreground'
                                )}>
                                  {getLocalizedStatus(invoice.status)}
                                </Badge>
                              </div>
                            </div>
                            
                            <div className="space-y-2">
                              <p className="text-xs text-muted-foreground">{t("admin.invoices.invoice")}{invoice.id}
                              </p>
                              <p className="text-xs text-muted-foreground">{t("admin.invoices.due")}{new Date(invoice.dueDate).toLocaleDateString()}
                              </p>
                              <p className="text-xs text-muted-foreground">
                                {invoice.sentDate ? `${t("admin.invoices.sent_on", "Gönderildi:")} ${new Date(invoice.sentDate).toLocaleDateString()}` : t("admin.invoices.not_sent", "Gönderilmedi")}
                              </p>
                            </div>
                            
                            <div className="flex items-center justify-between">
                              <div>
                                <p className="text-lg font-bold text-foreground">
                                  ${invoice.totalAmount.toLocaleString()} {invoice.currency}
                                </p>
                                <p className="text-xs text-muted-foreground">
                                  {invoice.items.length}{t("admin.invoices.items_tax")}{invoice.taxRate * 100}%
                                </p>
                              </div>
                              
                              <div className="flex items-center gap-2">
                                <Button size="sm" variant="outline">
                                  <Eye className="w-3 h-3 mr-1" />{t("admin.invoices.view")}</Button>
                                
                                {invoice.status === 'DRAFT' && <Button size="sm" variant="outline">
                                    <Edit className="w-3 h-3 mr-1" />{t("admin.invoices.edit")}</Button>}
                                
                                {invoice.status === 'DRAFT' && <Button size="sm" variant="outline">
                                    <Send className="w-3 h-3 mr-1" />{t("admin.invoices.send")}</Button>}
                                
                                {invoice.status === 'SENT' && <Button size="sm" variant="outline" onClick={() => handleSendInvoice(invoice.id)}>
                                    <Mail className="w-3 h-3 mr-1" />{t("admin.invoices.resend")}</Button>}
                                
                                {invoice.status !== 'PAID' && <Button size="sm" variant="outline" onClick={() => handleMarkPaid(invoice.id)}>
                                    <CreditCard className="w-3 h-3 mr-1" />{t("admin.invoices.mark_paid")}</Button>}
                                
                                <Button size="sm" variant="outline">
                                  <Download className="w-3 h-3 mr-1" />{t("admin.invoices.pdf")}</Button>
                              </div>
                            </div>
                          </div>
                        </div>
                      </motion.div>)}
                  </div>
                </CardContent>
              </Card>
              </div>}

          {/* Customers Tab */}
          {activeTab === 'customers' && <div className="space-y-6">
              <Card className="bg-card border-border rounded-3xl p-8">
                <CardHeader>
                  <CardTitle className="text-lg font-bold text-foreground flex items-center gap-2">
                    <Users className="w-5 h-5 text-emerald-500" />{t("admin.invoices.customers")}{customers.length})
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    {customers.map(customer => <motion.div key={customer.id} initial={{
                  opacity: 0,
                  y: 10
                }} animate={{
                  opacity: 1,
                  y: 0
                }} className="bg-muted/50 rounded-2xl p-4 border border-border">
                        <div className="flex items-center justify-between">
                          <div className="flex items-center gap-3">
                            <div className="w-10 h-10 rounded-xl bg-emerald-500/20 flex items-center justify-center">
                              <Users className="w-5 h-5 text-emerald-400" />
                            </div>
                            <div>
                              <h4 className="text-sm font-bold text-foreground">{customer.name}</h4>
                              <p className="text-xs text-muted-foreground">{customer.email}</p>
                              <p className="text-xs text-muted-foreground">{customer.phone}</p>
                              <p className="text-xs text-muted-foreground">{customer.address}</p>
                              {customer.company && <p className="text-xs text-muted-foreground">{customer.company}</p>}
                            </div>
                          </div>
                          
                          <div className="text-right">
                            <div className="text-xs text-muted-foreground">
                              <p>{t("admin.invoices.total_invoices")}{customer.totalInvoices || 0}</p>
                              <p>{t("admin.invoices.paid")}{customer.paidInvoices || 0}</p>
                              <p>{t("admin.invoices.outstanding")}{customer.outstandingAmount?.toLocaleString() || '$0'}</p>
                            </div>
                            
                            <div className="flex items-center gap-2">
                              <Button size="sm" variant="ghost" className="text-muted-foreground hover:text-foreground hover:bg-muted/50">
                                <Eye className="w-4 h-4 mr-1.5" />{t("admin.invoices.details")}</Button>
                              <Button size="sm" className="bg-emerald-600/10 text-emerald-400 border border-emerald-500/20 hover:bg-emerald-600/20" onClick={() => navigate('/admin/invoices/create')}>
                                <Plus className="w-4 h-4 mr-1.5" />{t("admin.invoices.new_invoice")}</Button>
                            </div>
                          </div>
                        </div>
                      </motion.div>)}
                  </div>
                </CardContent>
                </Card>
              </div>}

          {/* Templates Tab */}
          {activeTab === 'templates' && <div className="space-y-6">
              <Card className="bg-card border-border rounded-3xl p-8">
                <CardHeader>
                  <CardTitle className="text-lg font-bold text-foreground flex items-center gap-2">
                    <FileText className="w-5 h-5 text-purple-500" />{t("admin.invoices.invoice_templates")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                    {[{
                  name: "Standard Service",
                  type: t("admin.invoices.management_type", "Yönetim"),
                  color: "blue",
                  usage: 124
                }, {
                  name: "Premium Rental",
                  type: t("admin.invoices.booking_type", "Rezervasyon"),
                  color: "emerald",
                  usage: 89
                }, {
                  name: "Late Penalty",
                  type: t("admin.invoices.legal_type", "Hukuki"),
                  color: "red",
                  usage: 12
                }, {
                  name: "Utility Rebate",
                  type: t("admin.invoices.credit_type", "Kredi"),
                  color: "orange",
                  usage: 45
                }, {
                  name: "Bulk Deposit",
                  type: t("admin.invoices.brokerage_type", "Komisyon"),
                  color: "purple",
                  usage: 67
                }].map((template, i) => <motion.div key={i} whileHover={{
                  y: -5
                }} className="bg-muted/50 border border-border rounded-3xl p-6 group cursor-pointer relative overflow-hidden">
                        <div className={cn("absolute top-0 left-0 w-1 h-full opacity-30 group-hover:w-full transition-all duration-500", template.color === 'blue' ? "bg-blue-500" : template.color === 'emerald' ? "bg-emerald-500" : template.color === 'red' ? "bg-red-500" : template.color === 'orange' ? "bg-orange-500" : "bg-purple-500")} />
                        
                        <div className="relative z-10 flex flex-col h-full">
                           <div className="flex justify-between items-start mb-4">
                              <div className={cn("w-10 h-10 rounded-xl flex items-center justify-center", template.color === 'blue' ? "bg-blue-500/20 text-blue-400" : template.color === 'emerald' ? "bg-emerald-500/20 text-emerald-400" : template.color === 'red' ? "bg-red-500/20 text-red-400" : template.color === 'orange' ? "bg-orange-500/20 text-orange-400" : "bg-purple-500/20 text-purple-400")}>
                                 <FileText className="w-5 h-5" />
                              </div>
                              <Badge className="bg-muted/50 text-muted-foreground border-border text-[9px] font-bold">{template.usage}{t("admin.invoices.x_used")}</Badge>
                           </div>
                           
                           <h4 className="text-foreground font-bold mb-1">{template.name}</h4>
                           <p className="text-[10px] font-bold text-muted-foreground mb-6">{template.type}{t("admin.invoices.template")}</p>
                           
                           <div className="mt-auto flex gap-2">
                              <Button size="sm" variant="ghost" className="h-8 text-[10px] font-bold text-muted-foreground hover:text-foreground">
                                <Eye className="w-3 h-3 mr-1.5" />{t("admin.invoices.preview")}</Button>
                              <Button size="sm" className="h-8 bg-blue-600 hover:bg-blue-500 text-[10px] font-bold">{t("admin.invoices.use_now")}</Button>
                           </div>
                        </div>
                      </motion.div>)}
                    <div className="border-2 border-dashed border-border rounded-3xl flex flex-col items-center justify-center p-8 hover:bg-muted/50 transition-colors cursor-pointer group">
                       <Plus className="w-8 h-8 text-slate-600 group-hover:text-blue-500 transition-colors mb-2" />
                       <p className="text-[10px] font-bold text-muted-foreground">{t("admin.invoices.new_template")}</p>
                    </div>
                  </div>
                </CardContent>
              </Card>
            </div>}

          {/* Analytics Tab */}
          {activeTab === 'analytics' && <div className="space-y-6">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                <Card className="bg-card border-border rounded-3xl p-6">
                  <CardHeader>
                    <CardTitle className="text-lg font-bold text-foreground flex items-center gap-2">
                      <TrendingUp className="w-5 h-5 text-emerald-500" />{t("admin.invoices.revenue_overview")}</CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-4">
                    <div className="text-center">
                      <div className="text-xl font-bold text-foreground">${totalRevenue.toLocaleString()}</div>
                      <p className="text-sm text-muted-foreground">{t("admin.invoices.total_revenue")}</p>
                    </div>
                    
                    <div className="grid grid-cols-2 gap-4 text-sm">
                      <div>
                        <p className="text-muted-foreground">{t("admin.invoices.paid_invoices")}</p>
                        <p className="text-lg font-bold text-foreground">{invoices.filter(inv => inv.status === 'PAID').length}</p>
                      </div>
                      <div>
                        <p className="text-muted-foreground">{t("admin.invoices.pending_invoices")}</p>
                        <p className="text-lg font-bold text-foreground">{invoices.filter(inv => inv.status === 'SENT').length}</p>
                      </div>
                    </div>
                  </CardContent>
                </Card>

                <Card className="bg-card border-border rounded-3xl p-6 relative overflow-hidden group">
                  <div className="absolute top-0 right-0 w-32 h-32 bg-red-500/5 blur-3xl rounded-full translate-x-16 -translate-y-16 group-hover:bg-red-500/10 transition-all duration-700" />
                  <CardHeader>
                    <CardTitle className="text-lg font-bold text-foreground flex items-center gap-2">
                      <AlertTriangle className="w-5 h-5 text-red-500" />{t("admin.invoices.outstanding_debt")}</CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-6">
                    <div className="text-center relative">
                      <div className="text-2xl font-bold text-red-400">${totalOutstanding.toLocaleString()}</div>
                      <p className="text-[10px] font-bold text-muted-foreground tracking-[0.3em] mt-2">{t("admin.invoices.recovery_target")}</p>
                    </div>
                    
                    <div className="space-y-4">
                       <div className="flex justify-between items-end">
                          <p className="text-[10px] font-bold text-muted-foreground">{t("admin.invoices.risk_exposure")}</p>
                          <p className="text-sm font-bold text-foreground">{t("admin.invoices.high")}</p>
                       </div>
                       <Progress value={65} className="h-1.5 bg-muted/50 [&>div]:bg-red-500/50" />
                       
                       <div className="grid grid-cols-2 gap-4 pt-2">
                          <div className="p-3 bg-muted/50 rounded-2xl border border-border">
                             <p className="text-[9px] font-bold text-muted-foreground leading-none mb-1">{t("admin.invoices.overdue")}</p>
                             <p className="text-lg font-bold text-foreground">{invoices.filter(inv => inv.status === 'OVERDUE').length}</p>
                          </div>
                          <div className="p-3 bg-muted/50 rounded-2xl border border-border">
                             <p className="text-[9px] font-bold text-muted-foreground leading-none mb-1">{t("admin.invoices.avg_aging")}</p>
                             <p className="text-lg font-bold text-foreground">{t("admin.invoices.24_days")}</p>
                          </div>
                       </div>
                    </div>
                  </CardContent>
                </Card>

                <Card className="md:col-span-2 bg-card border-border rounded-3xl p-6 relative overflow-hidden">
                   <div className="absolute top-0 left-0 w-full h-1 bg-linear-to-r from-blue-500 via-emerald-500 to-purple-500 opacity-30" />
                   <CardHeader className="flex flex-row items-center justify-between">
                     <CardTitle className="text-lg font-bold text-foreground flex items-center gap-2">
                       <BarChart3 className="w-5 h-5 text-blue-500" />{t("admin.invoices.neural_cashflow_pulse")}</CardTitle>
                     <Badge className="bg-emerald-500/10 text-emerald-400 border-emerald-500/20 text-[10px] font-bold">{t("admin.invoices.124_mo")}</Badge>
                   </CardHeader>
                   <CardContent>
                      <div className="h-48 flex items-end justify-between gap-2 px-4 pb-4">
                         {[45, 62, 58, 75, 42, 68, 85, 55, 92, 78, 64, 82].map((val, i) => <motion.div key={i} initial={{
                    height: 0
                  }} animate={{
                    height: `${val}%`
                  }} transition={{
                    delay: i * 0.05,
                    duration: 1,
                    ease: "circOut"
                  }} className="flex-1 bg-linear-to-t from-blue-600/20 to-blue-500/40 rounded-t-lg relative group cursor-pointer">
                              <div className="absolute -top-8 left-1/2 -translate-x-1/2 bg-white text-black text-[9px] font-bold px-1.5 py-0.5 rounded opacity-0 group-hover:opacity-100 transition-opacity whitespace-nowrap">
                                ${val}k
                              </div>
                           </motion.div>)}
                      </div>
                      <div className="flex justify-between text-[9px] font-bold text-slate-600 tracking-[0.2em] px-4 pt-4 border-t border-border">
                         <span>{t("admin.invoices.jan")}</span>
                         <span>{t("admin.invoices.mar")}</span>
                         <span>{t("admin.invoices.may")}</span>
                         <span>{t("admin.invoices.jul")}</span>
                         <span>{t("admin.invoices.sep")}</span>
                         <span>{t("admin.invoices.nov")}</span>
                      </div>
                   </CardContent>
                </Card>

                <Card className="col-span-1 md:col-span-3 bg-card border-border rounded-3xl p-6 overflow-hidden">
                   <div className="flex items-center justify-between mb-6">
                      <CardTitle className="text-lg font-bold text-foreground flex items-center gap-2">
                        <Activity className="w-5 h-5 text-purple-500" />{t("admin.invoices.live_billing_node_activity")}</CardTitle>
                      <Button variant="ghost" size="sm" className="text-muted-foreground text-[10px] font-bold">{t("admin.invoices.clear_logs")}</Button>
                   </div>
                   <div className="space-y-3">
                      {[{
                  event: t("admin.invoices.invoice_sent", "Fatura Gönderildi"),
                  user: "John Doe Properties",
                  sub: "$2,700.00",
                  time: t("admin.invoices.2_min_ago", "2 dk önce"),
                  icon: <Send className="w-3 h-3" />,
                  color: "blue"
                }, {
                  event: t("admin.invoices.payment_received", "Ödeme Alındı"),
                  user: "Jane Smith Realty",
                  sub: "$1,296.00",
                  time: t("admin.invoices.14_min_ago", "14 dk önce"),
                  icon: <CheckCircle className="w-3 h-3" />,
                  color: "emerald"
                }, {
                  event: t("admin.invoices.auto_alert_overdue", "Otomatik Uyarı: Gecikmiş"),
                  user: "Johnson Commercial",
                  sub: "$12,500.00",
                  time: t("admin.invoices.1_hour_ago", "1 saat önce"),
                  icon: <AlertTriangle className="w-3 h-3" />,
                  color: "red"
                }, {
                  event: t("admin.invoices.draft_generated", "Taslak Oluşturuldu"),
                  user: "New Prospect LP",
                  sub: "$4,500.00",
                  time: t("admin.invoices.3_hours_ago", "3 saat önce"),
                  icon: <FileText className="w-3 h-3" />,
                  color: "slate"
                }].map((log, i) => <div key={i} className="flex items-center justify-between p-3 bg-muted/50 rounded-2xl border border-border hover:bg-muted/50 transition-colors">
                           <div className="flex items-center gap-4">
                              <div className={cn("w-8 h-8 rounded-lg flex items-center justify-center", log.color === 'blue' ? "bg-blue-500/20 text-blue-400" : log.color === 'emerald' ? "bg-emerald-500/20 text-emerald-400" : log.color === 'red' ? "bg-red-500/20 text-red-400" : "bg-slate-500/20 text-muted-foreground")}>
                                 {log.icon}
                              </div>
                              <div>
                                 <p className="text-[10px] font-bold text-foreground tracking-tight leading-none mb-1">{log.event}</p>
                                 <p className="text-xs text-muted-foreground font-medium">{log.user}</p>
                              </div>
                           </div>
                           <div className="text-right">
                              <p className="text-xs font-bold text-foreground">{log.sub}</p>
                              <p className="text-[9px] font-bold text-slate-600">{log.time}</p>
                           </div>
                        </div>)}
                   </div>
                </Card>
              </div>
            </div>}
        </div>
      </div>
    </PageShell>;
}