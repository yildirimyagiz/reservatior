import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, FormEvent } from "react";
import { useQuery } from "@tanstack/react-query";
import { PageShell } from "../layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { financialsApi, type Expense, type ExpenseCategory } from "@/lib/api/financials";
import { propertiesApi, type Property } from "@/lib/api/properties";
import { Edit, Trash2, MoreHorizontal, Loader2, RefreshCw } from "lucide-react";
const CATEGORIES: ExpenseCategory[] = ["MAINTENANCE", "INSURANCE", "UTILITIES", "TAX", "RENOVATION", "OTHER", "COMMISSION", "MANAGEMENT_FEE", "CLEANING", "REPAIR", "MARKETING"];
const EMPTY_FORM = {
  orgId: "default",
  propertyId: "",
  category: "MAINTENANCE" as ExpenseCategory,
  amount: "",
  currency: "USD",
  date: new Date().toISOString().split('T')[0],
  description: ""
};
export default function Expenses() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [search, setSearch] = useState("");
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [currentId, setCurrentId] = useState<string | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [form, setForm] = useState<any>(EMPTY_FORM);
  const { data = { expenses: [], properties: [] }, isLoading: loading, refetch: fetchData } = useQuery({
    queryKey: ['expensesAndProperties'],
    queryFn: async () => {
      try {
        const [expRes, propRes] = await Promise.all([financialsApi.getExpenses(), propertiesApi.getAll()]);
        return {
          expenses: expRes.data || [],
          properties: propRes || []
        };
      } catch (error) {
        toast({
          title: t("client.src.error"),
          description: t("client.src.failed_to_load_expenses"),
          variant: "destructive"
        });
        return { expenses: [], properties: [] };
      }
    }
  });

  const { expenses, properties } = data;
  const filtered = expenses.filter(row => {
    const propName = properties.find(p => p.id === row.propertyId)?.name || "";
    return row.category.toLowerCase().includes(search.toLowerCase()) || (row.description || "").toLowerCase().includes(search.toLowerCase()) || propName.toLowerCase().includes(search.toLowerCase());
  });
  const handleCreate = async (e: FormEvent) => {
    e.preventDefault();
    try {
      setIsSubmitting(true);
      await financialsApi.createExpense({
        ...form,
        amount: parseFloat(form.amount)
      });
      setCreateOpen(false);
      toast({
        title: t("client.src.expense_recorded")
      });
      fetchData();
    } catch (error) {
      toast({
        title: t("client.src.error"),
        description: t("client.src.failed_to_save_expense"),
        variant: "destructive"
      });
    } finally {
      setIsSubmitting(false);
    }
  };
  const handleEdit = async (e: FormEvent) => {
    e.preventDefault();
    if (!currentId) return;
    try {
      setIsSubmitting(true);
      await financialsApi.updateExpense(currentId, {
        ...form,
        amount: parseFloat(form.amount)
      });
      setEditOpen(false);
      toast({
        title: t("client.src.expense_updated")
      });
      fetchData();
    } catch (error) {
      toast({
        title: t("client.src.error"),
        description: t("client.src.failed_to_update_expense"),
        variant: "destructive"
      });
    } finally {
      setIsSubmitting(false);
    }
  };
  const handleDelete = async (id: string) => {
    if (!confirm("Are you sure?")) return;
    try {
      setIsSubmitting(true);
      await financialsApi.deleteExpense(id);
      toast({
        title: t("client.src.expense_deleted")
      });
      fetchData();
    } catch (error) {
      toast({
        title: t("client.src.error"),
        description: t("client.src.failed_to_delete_expense"),
        variant: "destructive"
      });
    } finally {
      setIsSubmitting(false);
    }
  };
  const openEdit = (row: Expense) => {
    setCurrentId(row.id);
    setForm({
      orgId: row.orgId,
      propertyId: row.propertyId || "",
      category: row.category,
      amount: row.amount.toString(),
      currency: row.currency,
      date: new Date(row.date).toISOString().split('T')[0],
      description: row.description || ""
    });
    setEditOpen(true);
  };
  const EntityForm = ({
    onSubmit,
    label,
    isEdit = false
  }: {
    onSubmit: (e: FormEvent) => void;
    label: string;
    isEdit?: boolean;
  }) => {
    const {
      t
    } = useTranslation();
    return <form onSubmit={onSubmit} className="space-y-4 py-2">
      {!isEdit && <div className="space-y-1.5"><Label>{t("client.src.org_id")}</Label><Input value={form.orgId} onChange={e => setForm({
          ...form,
          orgId: e.target.value
        })} required /></div>}
      <div className="space-y-1.5">
        <Label>{t("client.src.property")}</Label>
        <Select value={form.propertyId} onValueChange={v => setForm({
          ...form,
          propertyId: v
        })}>
          <SelectTrigger><SelectValue placeholder={t("client.src.select_property")} /></SelectTrigger>
          <SelectContent>
            {properties.map(p => <SelectItem key={p.id} value={p.id}>{p.name}</SelectItem>)}
          </SelectContent>
        </Select>
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.category")}</Label>
        <Select value={form.category} onValueChange={v => setForm({
          ...form,
          category: v as ExpenseCategory
        })}>
          <SelectTrigger><SelectValue /></SelectTrigger>
          <SelectContent>
            {CATEGORIES.map(c => <SelectItem key={c} value={c}>{c}</SelectItem>)}
          </SelectContent>
        </Select>
      </div>
      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-1.5"><Label>{t("client.src.amount")}</Label><Input type="number" step="0.01" value={form.amount} onChange={e => setForm({
            ...form,
            amount: e.target.value
          })} required /></div>
        <div className="space-y-1.5">
          <Label>{t("client.src.currency")}</Label>
          <Select value={form.currency} onValueChange={v => setForm({
            ...form,
            currency: v
          })}>
            <SelectTrigger><SelectValue /></SelectTrigger>
            <SelectContent><SelectItem value="USD">{t("client.src.usd")}</SelectItem><SelectItem value="EUR">{t("client.src.eur")}</SelectItem></SelectContent>
          </Select>
        </div>
      </div>
      <div className="space-y-1.5"><Label>{t("client.src.date")}</Label><Input type="date" value={form.date} onChange={e => setForm({
          ...form,
          date: e.target.value
        })} required /></div>
      <div className="space-y-1.5"><Label>{t("client.src.description")}</Label><Textarea value={form.description} onChange={e => setForm({
          ...form,
          description: e.target.value
        })} rows={3} /></div>
      <DialogFooter><Button type="submit" disabled={isSubmitting}>{label}</Button></DialogFooter>
    </form>;
  };
  return <>
      <PageShell title={t("client.src.expenses")} description={t("client.src.track_property_and_operational")} createLabel="Add Expense" onCreateClick={() => {
      setForm(EMPTY_FORM);
      setCreateOpen(true);
    }} searchValue={search} onSearchChange={setSearch} searchPlaceholder="Search expenses..." stats={[{
      label: t("client.src.total"),
      value: expenses.length
    }, {
      label: t("client.src.total_spent"),
      value: `$${expenses.reduce((s, r) => s + r.amount, 0).toLocaleString()}`
    }]} actions={<Button variant="outline" size="sm" onClick={() => fetchData()} disabled={loading}>
            <RefreshCw className={`w-4 h-4 mr-2 ${loading ? 'animate-spin' : ''}`} />{t("client.src.refresh")}</Button>}>
        <div className="bg-card border border-border rounded-xl overflow-hidden shadow-sm">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>{t("client.src.category")}</TableHead>
                <TableHead>{t("client.src.property")}</TableHead>
                <TableHead>{t("client.src.amount")}</TableHead>
                <TableHead>{t("client.src.date")}</TableHead>
                <TableHead>{t("client.src.description")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {loading && expenses.length === 0 ? <TableRow><TableCell colSpan={6} className="text-center py-12"><Loader2 className="w-6 h-6 animate-spin mx-auto" /></TableCell></TableRow> : filtered.length === 0 ? <TableRow><TableCell colSpan={6} className="text-center py-12 text-muted-foreground">{t("client.src.no_expenses_found")}</TableCell></TableRow> : filtered.map(row => <TableRow key={row.id} className="hover:bg-muted/40">
                    <TableCell><Badge className="bg-secondary border-0 text-xs text-secondary-foreground">{row.category}</Badge></TableCell>
                    <TableCell className="text-sm">{properties.find(p => p.id === row.propertyId)?.name || '—'}</TableCell>
                    <TableCell className="text-sm font-semibold">${row.amount.toLocaleString()}</TableCell>
                    <TableCell className="text-sm text-muted-foreground">{new Date(row.date).toLocaleDateString()}</TableCell>
                    <TableCell className="text-xs text-muted-foreground max-w-xs truncate">{row.description || "—"}</TableCell>
                    <TableCell>
                      <DropdownMenu>
                        <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
                        <DropdownMenuContent align="end">
                          <DropdownMenuItem onClick={() => openEdit(row)}><Edit className="w-4 h-4 mr-2" />{t("client.src.edit")}</DropdownMenuItem>
                          <DropdownMenuItem onClick={() => handleDelete(row.id)} className="text-destructive"><Trash2 className="w-4 h-4 mr-2" />{t("client.src.delete")}</DropdownMenuItem>
                        </DropdownMenuContent>
                      </DropdownMenu>
                    </TableCell>
                  </TableRow>)}
            </TableBody>
          </Table>
        </div>
      </PageShell>

      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("client.src.add_expense")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleCreate} label={t("client.src.create")} />
        </DialogContent>
      </Dialog>
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("client.src.edit_expense")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleEdit} label={t("client.src.save_changes")} isEdit={true} />
        </DialogContent>
      </Dialog>
    </>;
}