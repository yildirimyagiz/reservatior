import { t } from "i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { FileText, Download, Send, Clock, CheckCircle, AlertCircle, MoreHorizontal, Loader2, RefreshCw, Search, Plus, Activity, Zap, Maximize2, Trash2 } from "lucide-react";
import { financialsApi, type FinancialRecord } from "@/lib/api/financials";
import { propertiesApi, type Property } from "@/lib/api/properties";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { useTranslation } from "react-i18next";
import { cn } from "@/lib/utils";
import { motion } from "framer-motion";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";

const STATUS_CONFIG: Record<string, {
  label: string;
  cls: string;
  icon: any;
}> = {
  paid: {
    label: t("admin.financial.paid"),
    cls: "bg-emerald-500/10 text-emerald-400 border-emerald-500/20",
    icon: CheckCircle
  },
  pending: {
    label: t("admin.financial.pending"),
    cls: "bg-blue-500/10 text-blue-400 border-blue-500/20",
    icon: Clock
  },
  overdue: {
    label: t("admin.financial.overdue"),
    cls: "bg-red-500/10 text-red-400 border-red-500/20",
    icon: AlertCircle
  },
  draft: {
    label: t("admin.financial.draft"),
    cls: "bg-slate-500/10 text-muted-foreground border-slate-500/20",
    icon: FileText
  }
};
export default function FinancialInvoices() {
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const deleteMutation = useMutation({
    mutationFn: async (id: string) => apiClient.delete(`/api/v1/unknown/${id}`),
    onSuccess: () => {
      toast({ title: "Deleted", description: "Record deleted successfully" });
      queryClient.invalidateQueries();
    },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
  });
  

  const { t } = useTranslation();
  const [isAddOpen, setIsAddOpen] = useState(false);

          const [newInvoice, setNewInvoice] = useState({
            customerId: '',
            customerName: '',
            customerEmail: '',
            amount: '',
            currency: 'USD',
            dueDate: '',
            status: 'DRAFT'
          });

          const createMutation = useMutation({
            mutationFn: async (data: any) => {
              return financialsApi.createInvoice({
                ...data,
                amount: parseFloat(data.amount),
                items: [{ description: "General Services", quantity: 1, unitPrice: parseFloat(data.amount), totalPrice: parseFloat(data.amount), itemType: "SERVICE" }]
              });
            },
            onSuccess: () => {
              setIsAddOpen(false);
              refetchRecords();
              toast({ title: "Success", description: "Invoice created successfully" });
            },
            onError: (err: any) => {
              toast({ title: "Error", description: err.message || "Failed to create invoice", variant: "destructive" });
            }
          });
        

  const [search, setSearch] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const { data: recordsData, isLoading: loadingRecords, refetch: refetchRecords } = useQuery({
    queryKey: ['financialRecords', 'INCOME'],
    queryFn: async () => {
      const res = await financialsApi.getRecords({ type: "INCOME" });
      return res.data || [];
    }
  });

  const { data: propertiesData, isLoading: loadingProperties, refetch: refetchProperties } = useQuery({
    queryKey: ['properties'],
    queryFn: async () => {
      const res = await propertiesApi.getAll();
      return res || [];
    }
  });

  const records = recordsData || [];
  const properties = propertiesData || [];
  const loading = loadingRecords || loadingProperties;

  const fetchData = () => {
    refetchRecords();
    refetchProperties();
  };
  const getMeta = (record: FinancialRecord) => {
    const prop = properties.find(p => p.id === record.propertyId);
    return {
      propertyName: prop?.name || "Unknown Property",
      clientName: record.description?.split(" - ")[0] || "Unknown Client"
    };
  };
  const filtered = records.filter(r => {
    const meta = getMeta(r);
    const matchesSearch = r.id.toLowerCase().includes(search.toLowerCase()) || meta.clientName.toLowerCase().includes(search.toLowerCase()) || meta.propertyName.toLowerCase().includes(search.toLowerCase());
    const matchesStatus = filterStatus === "all" || (r.paymentStatus || 'pending').toLowerCase() === filterStatus;
    return matchesSearch && matchesStatus;
  });
  const stats = {
    total: records.length,
    outstanding: records.filter(r => r.paymentStatus !== 'paid').reduce((s, r) => s + r.amount, 0),
    paidThisMonth: records.filter(r => r.paymentStatus === 'paid').reduce((s, r) => s + r.amount, 0),
    overdue: records.filter(r => r.paymentStatus === 'overdue').reduce((s, r) => s + r.amount, 0)
  };
  return <PageShell title={t("admin.financial.invoices")} description={t("admin.financial.manage_and_track_all")}>
      <div className="space-y-10 pb-20 selection:bg-primary/30">
        {/* KPI Neural Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 px-4">
          <motion.div initial={{
          opacity: 0,
          y: 20
        }} animate={{
          opacity: 1,
          y: 0
        }} transition={{
          delay: 0.1
        }}>
            <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-muted/50">
              <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-muted-foreground">
                <FileText className="w-10 h-10" />
              </div>
              <CardContent className="p-8">
                <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin.financial.totalinvoices")}</p>
                <h3 className="text-xl font-bold text-foreground leading-none">{stats.total}</h3>
              </CardContent>
            </Card>
          </motion.div>

          <motion.div initial={{
          opacity: 0,
          y: 20
        }} animate={{
          opacity: 1,
          y: 0
        }} transition={{
          delay: 0.2
        }}>
            <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t border-l-orange-500/30 transition-all hover:bg-muted/50">
              <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-orange-500">
                <Clock className="w-10 h-10" />
              </div>
              <CardContent className="p-8">
                <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin.financial.outstanding")}</p>
                <h3 className="text-xl font-bold text-orange-400 leading-none">${stats.outstanding.toLocaleString()}</h3>
              </CardContent>
            </Card>
          </motion.div>

          <motion.div initial={{
          opacity: 0,
          y: 20
        }} animate={{
          opacity: 1,
          y: 0
        }} transition={{
          delay: 0.3
        }}>
            <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t border-l-emerald-500/30 transition-all hover:bg-muted/50">
              <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-emerald-500">
                <CheckCircle className="w-10 h-10" />
              </div>
              <CardContent className="p-8">
                <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin.financial.paidtotal")}</p>
                <h3 className="text-xl font-bold text-emerald-400 leading-none">${stats.paidThisMonth.toLocaleString()}</h3>
              </CardContent>
            </Card>
          </motion.div>

          <motion.div initial={{
          opacity: 0,
          y: 20
        }} animate={{
          opacity: 1,
          y: 0
        }} transition={{
          delay: 0.4
        }}>
            <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t border-l-red-500/30 transition-all hover:bg-muted/50">
              <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-red-500">
                <AlertCircle className="w-10 h-10" />
              </div>
              <CardContent className="p-8">
                <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin.financial.overduedebt")}</p>
                <h3 className="text-xl font-bold text-red-400 leading-none">${stats.overdue.toLocaleString()}</h3>
              </CardContent>
            </Card>
          </motion.div>
        </div>

        {/* Tactical Search & Actions Interface */}
        <div className="bg-card backdrop-blur-xl border border-border rounded-3xl p-6 flex flex-wrap items-center justify-between gap-6 shadow-2xl mx-4">
          <div className="flex flex-wrap items-center gap-4 flex-1">
             <div className="relative group min-w-[320px]">
              <Search className="absolute left-4 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground group-focus-within:text-primary transition-colors" />
              <Input placeholder={t("admin.financial.search_invoices")} value={search} onChange={e => setSearch(e.target.value)} className="pl-12 w-full h-12 bg-muted/50 border-border rounded-xl text-foreground placeholder:text-slate-600 font-bold text-[10px] focus:ring-primary/20 transition-all" />
            </div>
            <div className="flex items-center gap-2">
              <Button variant="ghost" onClick={() => setFilterStatus("all")} className={cn("h-12 px-6 rounded-xl text-[10px] font-bold    transition-all", filterStatus === "all" ? "bg-primary text-foreground" : "text-muted-foreground hover:text-foreground hover:bg-muted/50")}>{t("admin.financial.all")}</Button>
              {Object.entries(STATUS_CONFIG).map(([key, config]) => <Button key={key} variant="ghost" onClick={() => setFilterStatus(key)} className={cn("h-12 px-6 rounded-xl text-[10px] font-bold    transition-all", filterStatus === key ? "bg-muted/50 text-foreground" : "text-muted-foreground hover:text-foreground hover:bg-muted/50")}>
                  <config.icon className="w-4 h-4 mr-2" />
                  {config.label}
                </Button>)}
            </div>
          </div>
          <div className="flex items-center gap-3">
             <Button variant="ghost" onClick={fetchData} className="h-12 w-12 rounded-xl text-muted-foreground hover:text-foreground hover:bg-muted/50 transition-all flex items-center justify-center p-0">
               <RefreshCw className={cn("h-4 w-4", loading && "animate-spin")} />
             </Button>
             
                            <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
                              <DialogTrigger asChild>
                                <Button className="bg-primary hover:bg-primary/90 text-foreground h-12 px-8 rounded-xl font-bold text-[10px] gap-3 shadow-xl shadow-primary/20">
                                  <Plus className="w-4 h-4" />{t("admin.financial.createinvoice")}</Button>
                              </DialogTrigger>
                              
                      <DialogContent className="sm:max-w-[500px] bg-card text-card-foreground">
                        <DialogHeader>
                          <DialogTitle>Create New Invoice</DialogTitle>
                          <DialogDescription>
                            Fill in the invoice details mapped to the backend.
                          </DialogDescription>
                        </DialogHeader>
                        <div className="grid gap-4 py-4">
                          <div className="grid grid-cols-4 items-center gap-4">
                            <Label htmlFor="customerName" className="text-right text-xs">Customer Name</Label>
                            <Input id="customerName" className="col-span-3 h-10" value={newInvoice.customerName} onChange={e => setNewInvoice({...newInvoice, customerName: e.target.value})} placeholder="John Doe" />
                          </div>
                          <div className="grid grid-cols-4 items-center gap-4">
                            <Label htmlFor="customerEmail" className="text-right text-xs">Email</Label>
                            <Input id="customerEmail" type="email" className="col-span-3 h-10" value={newInvoice.customerEmail} onChange={e => setNewInvoice({...newInvoice, customerEmail: e.target.value})} placeholder="john@example.com" />
                          </div>
                          <div className="grid grid-cols-4 items-center gap-4">
                            <Label htmlFor="customerId" className="text-right text-xs">Customer ID</Label>
                            <Input id="customerId" className="col-span-3 h-10" value={newInvoice.customerId} onChange={e => setNewInvoice({...newInvoice, customerId: e.target.value})} placeholder="CUST-123" />
                          </div>
                          <div className="grid grid-cols-4 items-center gap-4">
                            <Label htmlFor="amount" className="text-right text-xs">Amount</Label>
                            <Input id="amount" type="number" className="col-span-3 h-10" value={newInvoice.amount} onChange={e => setNewInvoice({...newInvoice, amount: e.target.value})} placeholder="1000" />
                          </div>
                          <div className="grid grid-cols-4 items-center gap-4">
                            <Label htmlFor="currency" className="text-right text-xs">Currency</Label>
                            <Select value={newInvoice.currency} onValueChange={(v) => setNewInvoice({...newInvoice, currency: v})}>
                              <SelectTrigger className="col-span-3 h-10"><SelectValue placeholder="Select Currency" /></SelectTrigger>
                              <SelectContent>
                                <SelectItem value="USD">USD ($)</SelectItem>
                                <SelectItem value="EUR">EUR (€)</SelectItem>
                                <SelectItem value="TRY">TRY (₺)</SelectItem>
                                <SelectItem value="GBP">GBP (£)</SelectItem>
                              </SelectContent>
                            </Select>
                          </div>
                          <div className="grid grid-cols-4 items-center gap-4">
                            <Label htmlFor="dueDate" className="text-right text-xs">Due Date</Label>
                            <Input id="dueDate" type="date" className="col-span-3 h-10" value={newInvoice.dueDate} onChange={e => setNewInvoice({...newInvoice, dueDate: e.target.value})} />
                          </div>
                          <div className="grid grid-cols-4 items-center gap-4">
                            <Label htmlFor="status" className="text-right text-xs">Status</Label>
                            <Select value={newInvoice.status} onValueChange={(v) => setNewInvoice({...newInvoice, status: v})}>
                              <SelectTrigger className="col-span-3 h-10"><SelectValue placeholder="Select Status" /></SelectTrigger>
                              <SelectContent>
                                <SelectItem value="DRAFT">Draft</SelectItem>
                                <SelectItem value="SENT">Sent</SelectItem>
                                <SelectItem value="PAID">Paid</SelectItem>
                                <SelectItem value="OVERDUE">Overdue</SelectItem>
                              </SelectContent>
                            </Select>
                          </div>
                        </div>
                        <DialogFooter>
                          <Button variant="outline" onClick={() => setIsAddOpen(false)}>Cancel</Button>
                          <Button onClick={() => createMutation.mutate(newInvoice)} disabled={createMutation.isPending}>
                            {createMutation.isPending ? "Saving..." : "Create Invoice"}
                          </Button>
                        </DialogFooter>
                      </DialogContent>
                            
                            </Dialog>
                          
          </div>
        </div>

        <Card className="bg-card border-border rounded-4xl overflow-hidden border-l border-t relative shadow-2xl mx-4">
          <CardHeader className="px-8 py-8 border-b border-border bg-muted/50">
            <div className="flex items-center justify-between">
              <div>
                <CardTitle className="text-xl font-bold text-foreground leading-none">{t("admin.financial.invoiceledger")}</CardTitle>
                <CardDescription className="text-[10px] font-bold text-muted-foreground mt-2">{t("admin.financial.global_billing_and_payment")}</CardDescription>
              </div>
              <Activity className="w-8 h-8 text-primary opacity-20" />
            </div>
          </CardHeader>
          <CardContent className="p-0">
            <Table>
              <TableHeader className="bg-muted/50 border-b border-border">
                <TableRow className="hover:bg-transparent border-none">
                  <TableHead className="text-[10px] font-bold px-8 h-16 text-muted-foreground">{t("admin.financial.invoiceid_client")}</TableHead>
                  <TableHead className="text-[10px] font-bold px-8 h-16 text-muted-foreground">{t("admin.financial.propertynode")}</TableHead>
                  <TableHead className="text-[10px] font-bold px-8 h-16 text-muted-foreground">{t("admin.financial.grossamount")}</TableHead>
                  <TableHead className="text-[10px] font-bold px-8 h-16 text-muted-foreground">{t("admin.financial.expirypulse")}</TableHead>
                  <TableHead className="text-[10px] font-bold px-8 h-16 text-muted-foreground">{t("admin.financial.matrixstatus")}</TableHead>
                  <TableHead className="w-[80px]"></TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {loading ? <TableRow><TableCell colSpan={6} className="text-center py-20"><Loader2 className="w-6 h-6 animate-spin mx-auto text-primary opacity-50" /></TableCell></TableRow> : filtered.length === 0 ? <TableRow>
                     <TableCell colSpan={6} className="text-center py-20 text-muted-foreground text-[10px] font-bold opacity-30">{t("admin.financial.no_invoice_signatures_found")}</TableCell>
                  </TableRow> : filtered.map(r => {
                const meta = getMeta(r);
                const status = (r.paymentStatus || 'pending').toLowerCase();
                const config = STATUS_CONFIG[status] || STATUS_CONFIG.pending;
                return <TableRow key={r.id} className="border-b border-border hover:bg-muted/50 transition-all group">
                        <TableCell className="px-8 py-6">
                           <div>
                              <div className="text-sm font-bold text-foreground truncate tracking-tight leading-none mb-2">{r.id.split('-').pop()?.toUpperCase()}</div>
                              <div className="text-[9px] font-bold text-muted-foreground opacity-50">{meta.clientName}</div>
                           </div>
                        </TableCell>
                        <TableCell className="px-8">
                           <div className="text-[10px] font-bold text-muted-foreground leading-none">{meta.propertyName}</div>
                        </TableCell>
                        <TableCell className="px-8">
                           <div className="text-lg font-bold text-foreground">${r.amount.toLocaleString()}</div>
                        </TableCell>
                        <TableCell className="px-8">
                           <div className="text-[10px] font-bold text-muted-foreground leading-none">{r.dueDate ? new Date(r.dueDate).toLocaleDateString() : '—'}</div>
                        </TableCell>
                        <TableCell className="px-8">
                           <Badge className={cn("text-[9px] font-bold   px-3 py-1 rounded-full  border transition-all", config.cls)}>
                              <div className="flex items-center gap-1.5">
                                 <config.icon className="w-3 h-3" />
                                 <span>{config.label}</span>
                              </div>
                           </Badge>
                        </TableCell>
                        <TableCell className="px-8 text-right">
                          <DropdownMenu>
                            <DropdownMenuTrigger asChild>
                              <Button variant="ghost" size="icon" className="h-10 w-10 text-muted-foreground hover:text-foreground hover:bg-muted/50 rounded-xl transition-all">
                                <MoreHorizontal className="h-4 w-4" />
                              </Button>
                            </DropdownMenuTrigger>
                            <DropdownMenuContent align="end" className="bg-[#14151a] border-border rounded-2xl p-2 w-48 shadow-2xl">
                              <DropdownMenuItem className="text-[10px] font-bold focus:bg-muted/50 focus:text-foreground rounded-xl py-3 cursor-pointer">
                                <Download className="w-4 h-4 mr-3 text-blue-400" />{t("admin.financial.downloadpdf")}</DropdownMenuItem>
                              <DropdownMenuItem className="text-[10px] font-bold focus:bg-muted/50 focus:text-foreground rounded-xl py-3 cursor-pointer">
                                <Send className="w-4 h-4 mr-3 text-emerald-400" />{t("admin.financial.resendpulse")}</DropdownMenuItem>
                              <DropdownMenuItem className="text-[10px] font-bold focus:bg-red-500/10 focus:text-red-500 rounded-xl py-3 cursor-pointer">
                                <Trash2 className="w-4 h-4 mr-3" />{t("admin.financial.terminate")}</DropdownMenuItem>
                            </DropdownMenuContent>
                          </DropdownMenu>
                        </TableCell>
                      </TableRow>;
              })}
              </TableBody>
            </Table>
          </CardContent>
        </Card>
      </div>
    </PageShell>;
}