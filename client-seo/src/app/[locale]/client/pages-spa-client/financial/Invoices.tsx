"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../layout/PageShell";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { FileText, Download, Send, Clock, CheckCircle, AlertCircle, MoreHorizontal, Loader2, RefreshCw } from "lucide-react";
import { financialsApi, type FinancialRecord } from "@/lib/api/financials";
import { propertiesApi, type Property } from "@/lib/api/properties";
import { useQuery } from "@tanstack/react-query";
const STATUS_CONFIG: Record<string, {
  label: string;
  cls: string;
  icon: any;
}> = {
  paid: {
    label: t("client.src.paid"),
    cls: "bg-green-100 text-green-700",
    icon: CheckCircle
  },
  pending: {
    label: t("client.src.pending"),
    cls: "bg-blue-100 text-blue-700",
    icon: Clock
  },
  overdue: {
    label: t("client.src.overdue"),
    cls: "bg-red-100 text-red-700",
    icon: AlertCircle
  },
  draft: {
    label: t("client.src.draft"),
    cls: "bg-gray-100 text-gray-700",
    icon: FileText
  }
};
export default function FinancialInvoices() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [search, setSearch] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");

  const { data, isLoading: loading, refetch } = useQuery({
    queryKey: ['invoices'],
    queryFn: async () => {
      const [recRes, propRes] = await Promise.all([
        financialsApi.getRecords({ type: "INCOME" }),
        propertiesApi.getAll()
      ]);
      return {
        records: recRes.data || [],
        properties: propRes || []
      };
    }
  });

  const { records = [], properties = [] } = data || {};
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
  return <PageShell title={t("client.src.invoices")} description={t("client.src.manage_and_track_all")} createLabel="Create Invoice" onCreateClick={() => toast({
    title: t("client.src.coming_soon"),
    description: t("client.src.manual_invoice_creation_is")
  })} searchValue={search} onSearchChange={setSearch} searchPlaceholder="Search by ID, client or property..." actions={<Button variant="outline" size="icon" onClick={() => refetch()} disabled={loading}>
          <RefreshCw className={`w-4 h-4 ${loading ? 'animate-spin' : ''}`} />
        </Button>} stats={[{
    label: t("client.src.total_invoices"),
    value: stats.total
  }, {
    label: t("client.src.outstanding"),
    value: `$${stats.outstanding.toLocaleString()}`
  }, {
    label: t("client.src.paid_all_time"),
    value: `$${stats.paidThisMonth.toLocaleString()}`
  }, {
    label: t("client.src.overdue"),
    value: `$${stats.overdue.toLocaleString()}`
  }]}>
      <div className="space-y-6">
        <div className="flex items-center space-x-2">
          <Button variant={filterStatus === "all" ? "default" : "outline"} size="sm" onClick={() => setFilterStatus("all")}>{t("client.src.all")}</Button>
          {Object.entries(STATUS_CONFIG).map(([key, config]) => <Button key={key} variant={filterStatus === key ? "default" : "outline"} size="sm" onClick={() => setFilterStatus(key)} className="h-8">
              <config.icon className="w-3.5 h-3.5 mr-2" />
              {config.label}
            </Button>)}
        </div>

        <div className="bg-card border border-border rounded-xl overflow-hidden shadow-sm">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>{t("client.src.invoice_id_client")}</TableHead>
                <TableHead>{t("client.src.property")}</TableHead>
                <TableHead>{t("client.src.amount")}</TableHead>
                <TableHead>{t("client.src.due_date")}</TableHead>
                <TableHead>{t("client.src.status")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {loading ? <TableRow><TableCell colSpan={6} className="text-center py-12"><Loader2 className="w-6 h-6 animate-spin mx-auto text-muted-foreground" /></TableCell></TableRow> : filtered.length === 0 ? <TableRow><TableCell colSpan={6} className="text-center py-12 text-muted-foreground">{t("client.src.no_invoices_found")}</TableCell></TableRow> : filtered.map(r => {
              const meta = getMeta(r);
              const status = (r.paymentStatus || 'pending').toLowerCase();
              const config = STATUS_CONFIG[status] || STATUS_CONFIG.pending;
              return <TableRow key={r.id} className="hover:bg-muted/40 transition-colors">
                      <TableCell>
                        <div className="font-semibold text-sm">{r.id.split('-').pop()?.toUpperCase()}</div>
                        <div className="text-xs text-muted-foreground">{meta.clientName}</div>
                      </TableCell>
                      <TableCell className="text-sm font-medium">{meta.propertyName}</TableCell>
                      <TableCell className="font-bold text-primary">${r.amount.toLocaleString()}</TableCell>
                      <TableCell className="text-sm text-muted-foreground">{r.dueDate ? new Date(r.dueDate).toLocaleDateString() : '—'}</TableCell>
                      <TableCell>
                        <Badge className={`${config.cls} border-0 text-[10px]`}>{config.label}</Badge>
                      </TableCell>
                      <TableCell>
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
                          <DropdownMenuContent align="end">
                            <DropdownMenuItem><Download className="w-4 h-4 mr-2" />{t("client.src.download_pdf")}</DropdownMenuItem>
                            <DropdownMenuItem><Send className="w-4 h-4 mr-2" />{t("client.src.resend_email")}</DropdownMenuItem>
                            <DropdownMenuItem className="text-destructive font-bold"><Download className="w-4 h-4 mr-2" />{t("client.src.delete")}</DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </TableCell>
                    </TableRow>;
            })}
            </TableBody>
          </Table>
        </div>
      </div>
    </PageShell>;
}