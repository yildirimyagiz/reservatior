"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  TrendingUp,
  Search,
  Plus,
  DollarSign,
  PieChart,
  ArrowUpRight,
  ArrowDownRight,
  Edit,
  Trash2,
  Briefcase,
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";

interface Investor {
  id: string;
  name: string;
  email: string;
  totalInvested: number;
  portfolioValue: number;
  returnRate: number;
  status: "ACTIVE" | "INACTIVE" | "PENDING";
  joinDate: string;
}

const mockInvestors: Investor[] = [
  { id: "1", name: "Thomas Reed", email: "thomas@example.com", totalInvested: 500000, portfolioValue: 625000, returnRate: 25, status: "ACTIVE", joinDate: "2023-01-15" },
  { id: "2", name: "Patricia Lane", email: "patricia@example.com", totalInvested: 250000, portfolioValue: 287500, returnRate: 15, status: "ACTIVE", joinDate: "2023-03-20" },
  { id: "3", name: "George Knight", email: "george@example.com", totalInvested: 100000, portfolioValue: 115000, returnRate: 15, status: "INACTIVE", joinDate: "2023-06-10" },
  { id: "4", name: "Rachel Green", email: "rachel@example.com", totalInvested: 750000, portfolioValue: 975000, returnRate: 30, status: "ACTIVE", joinDate: "2022-11-01" },
  { id: "5", name: "Samuel Wright", email: "samuel@example.com", totalInvested: 300000, portfolioValue: 330000, returnRate: 10, status: "PENDING", joinDate: "2024-04-05" },
];

const STATUS_COLORS: Record<string, string> = {
  ACTIVE: "bg-green-500/20 text-green-400",
  INACTIVE: "bg-gray-500/20 text-gray-400",
  PENDING: "bg-yellow-500/20 text-yellow-400",
};

export default function AdminInvestorsPage() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");
  const [items, setItems] = useState<Investor[]>(mockInvestors);
  const [editingItem, setEditingItem] = useState<Investor | null>(null);
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [isDeleteOpen, setIsDeleteOpen] = useState(false);
  const [deletingItem, setDeletingItem] = useState<Investor | null>(null);

  const filtered = items.filter(i =>
    i.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    i.email.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const totalPortfolio = items.reduce((sum, i) => sum + i.portfolioValue, 0);
  const totalInvested = items.reduce((sum, i) => sum + i.totalInvested, 0);
  const avgReturn = items.reduce((sum, i) => sum + i.returnRate, 0) / items.length;

  const handleCreate = (data: Omit<Investor, "id">) => {
    const newItem: Investor = { ...data, id: String(Date.now()) };
    setItems(prev => [...prev, newItem]);
    setIsCreateOpen(false);
  };

  const handleEdit = (updatedItem: Investor) => {
    setItems(prev => prev.map(item => item.id === updatedItem.id ? updatedItem : item));
    setIsEditOpen(false);
    setEditingItem(null);
  };

  const handleDelete = (id: string) => {
    setItems(prev => prev.filter(item => item.id !== id));
    setIsDeleteOpen(false);
    setDeletingItem(null);
  };

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8">
        <motion.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} className="mb-8">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-foreground mb-2">{t("admin_investors_title")}</h1>
              <p className="text-muted-foreground">{t("admin_investors_description")}</p>
            </div>
            <Button className="bg-primary hover:bg-primary/90">
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin_investors_back_to_dashboard")}
            </Button>
          </div>
        </motion.div>

        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1 }} className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
          <Card className="bg-card border-border">
            <CardContent className="p-6">
              <div className="flex items-center justify-between mb-2">
                <span className="text-muted-foreground text-sm">{t("admin_investors_total_portfolio_value")}</span>
                <Briefcase className="w-5 h-5 text-muted-foreground" />
              </div>
              <div className="text-2xl font-bold text-foreground">${(totalPortfolio / 1000000).toFixed(1)}{t("client.src.m", "M")}</div>
              <div className="text-green-400 text-sm flex items-center gap-1 mt-1">
                <ArrowUpRight className="w-4 h-4" />+{(totalPortfolio / totalInvested - 1) * 100}%
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-6">
              <div className="flex items-center justify-between mb-2">
                <span className="text-muted-foreground text-sm">{t("admin_investors_total_invested")}</span>
                <DollarSign className="w-5 h-5 text-green-400" />
              </div>
              <div className="text-2xl font-bold text-foreground">${(totalInvested / 1000000).toFixed(1)}{t("client.src.m", "M")}</div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-6">
              <div className="flex items-center justify-between mb-2">
                <span className="text-muted-foreground text-sm">{t("admin_investors_average_return_rate")}</span>
                <PieChart className="w-5 h-5 text-muted-foreground" />
              </div>
              <div className="text-2xl font-bold text-foreground">{avgReturn.toFixed(0)}%</div>
              <div className="text-green-400 text-sm flex items-center gap-1 mt-1">
                <ArrowUpRight className="w-4 h-4" />+5.2% {t("admin_investors_vs_last_quarter")}
              </div>
            </CardContent>
          </Card>
        </motion.div>

        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }} className="mb-6">
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex gap-4">
                <div className="flex-1">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                    <Input
                      placeholder={t("admin_investors_search_placeholder")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors placeholder:text-muted-foreground"
                    />
                  </div>
                </div>
                <Button onClick={() => setIsCreateOpen(true)} className="bg-primary hover:bg-primary/90">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin_investors_add_investor")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.3 }}>
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground flex items-center gap-2">
                <TrendingUp className="w-5 h-5" />
                {t("admin_investors_list_title")} ({filtered.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filtered.map((investor) => (
                  <div key={investor.id} className="flex items-center justify-between p-4 bg-muted/30 rounded-lg hover:bg-muted/50 transition-colors">
                    <div className="flex items-center gap-4">
                      <div className="w-10 h-10 rounded-full bg-muted/50 flex items-center justify-center text-muted-foreground font-bold">
                        {investor.name.split(" ").map(n => n[0]).join("")}
                      </div>
                      <div>
                        <div className="text-foreground font-medium">{investor.name}</div>
                        <div className="text-sm text-muted-foreground">{investor.email}</div>
                        <div className="text-xs text-muted-foreground/70">{t("admin_investors_joined")} {investor.joinDate}</div>
                      </div>
                    </div>
                    <div className="flex items-center gap-6">
                      <div className="text-right">
                        <div className="text-foreground font-medium">${(investor.portfolioValue / 1000).toFixed(0)}{t("client.src.k", "K")}</div>
                        <div className="text-xs text-muted-foreground">{t("admin_investors_portfolio")}</div>
                      </div>
                      <div className="text-right">
                        <div className={`font-medium flex items-center gap-1 ${investor.returnRate >= 0 ? "text-green-400" : "text-red-400"}`}>
                          {investor.returnRate >= 0 ? <ArrowUpRight className="w-3 h-3" /> : <ArrowDownRight className="w-3 h-3" />}
                          {investor.returnRate}%
                        </div>
                        <div className="text-xs text-muted-foreground">{t("admin_investors_return")}</div>
                      </div>
                      <Badge className={STATUS_COLORS[investor.status]}>{t("admin_status_" + String(investor.status).toLowerCase())}</Badge>
                      <div className="flex gap-2">
                        <Button onClick={() => { setEditingItem(investor); setIsEditOpen(true); }} variant="ghost" size="icon" className="h-8 w-8"><Edit className="w-4 h-4" /></Button>
                        <Button onClick={() => { setDeletingItem(investor); setIsDeleteOpen(true); }} variant="ghost" size="icon" className="h-8 w-8 text-red-400"><Trash2 className="w-4 h-4" /></Button>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </motion.div>
        {/* Create Dialog */}
        <CreateInvestorDialog open={isCreateOpen} onOpenChange={setIsCreateOpen} onSubmit={handleCreate} />
        {/* Edit Dialog */}
        {editingItem && (
          <EditInvestorDialog open={isEditOpen} onOpenChange={setIsEditOpen} item={editingItem} onSubmit={handleEdit} />
        )}
        {/* Delete Dialog */}
        {deletingItem && (
          <DeleteInvestorDialog open={isDeleteOpen} onOpenChange={setIsDeleteOpen} item={deletingItem} onConfirm={() => handleDelete(deletingItem.id)} />
        )}
      </div>
    </div>
  );
}

function CreateInvestorDialog({ open, onOpenChange, onSubmit }: { open: boolean; onOpenChange: (open: boolean) => void; onSubmit: (data: Omit<Investor, "id">) => void }) {
    const { t } = useTranslation();
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [totalInvested, setTotalInvested] = useState(0);
  const [portfolioValue, setPortfolioValue] = useState(0);
  const [returnRate, setReturnRate] = useState(0);
  const [status, setStatus] = useState<Investor["status"]>("PENDING");
  const [joinDate, setJoinDate] = useState(new Date().toISOString().split("T")[0]);
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_investors_add_investor", "Add Investor")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_auto_add_a_new_investor_to_the_system", "Add a new investor to the system.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_name", "Name")}</Label>
            <Input value={name} onChange={e => setName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_email", "Email")}</Label>
            <Input value={email} onChange={e => setEmail(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_total_invested", "Total Invested ($)")}</Label>
            <Input type="number" value={totalInvested} onChange={e => setTotalInvested(Number(e.target.value))} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_portfolio_value", "Portfolio Value ($)")}</Label>
            <Input type="number" value={portfolioValue} onChange={e => setPortfolioValue(Number(e.target.value))} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_return_rate", "Return Rate (%)")}</Label>
            <Input type="number" value={returnRate} onChange={e => setReturnRate(Number(e.target.value))} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_status", "Status")}</Label>
            <Select value={status} onValueChange={v => setStatus(v as Investor["status"])}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="ACTIVE">{t("admin_ai_active", "Active")}</SelectItem>
                <SelectItem value="INACTIVE">{t("admin_ai_inactive", "Inactive")}</SelectItem>
                <SelectItem value="PENDING">{t("admin_ai_pending", "Pending")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("client.src.join_date", "Join Date")}</Label>
            <Input type="date" value={joinDate} onChange={e => setJoinDate(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
        </div>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onSubmit({ name, email, totalInvested, portfolioValue, returnRate, status, joinDate })} className="bg-primary hover:bg-primary/90">{t("admin_action_create", "Create")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function EditInvestorDialog({ open, onOpenChange, item, onSubmit }: { open: boolean; onOpenChange: (open: boolean) => void; item: Investor; onSubmit: (data: Investor) => void }) {
    const { t } = useTranslation();
  const [name, setName] = useState(item.name);
  const [email, setEmail] = useState(item.email);
  const [totalInvested, setTotalInvested] = useState(item.totalInvested);
  const [portfolioValue, setPortfolioValue] = useState(item.portfolioValue);
  const [returnRate, setReturnRate] = useState(item.returnRate);
  const [status, setStatus] = useState<Investor["status"]>(item.status);
  const [joinDate, setJoinDate] = useState(item.joinDate);
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_auto_edit_investor", "Edit Investor")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_auto_update_investor_details", "Update investor details.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_name", "Name")}</Label>
            <Input value={name} onChange={e => setName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_email", "Email")}</Label>
            <Input value={email} onChange={e => setEmail(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_total_invested", "Total Invested ($)")}</Label>
            <Input type="number" value={totalInvested} onChange={e => setTotalInvested(Number(e.target.value))} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_portfolio_value", "Portfolio Value ($)")}</Label>
            <Input type="number" value={portfolioValue} onChange={e => setPortfolioValue(Number(e.target.value))} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_return_rate", "Return Rate (%)")}</Label>
            <Input type="number" value={returnRate} onChange={e => setReturnRate(Number(e.target.value))} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_status", "Status")}</Label>
            <Select value={status} onValueChange={v => setStatus(v as Investor["status"])}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="ACTIVE">{t("admin_ai_active", "Active")}</SelectItem>
                <SelectItem value="INACTIVE">{t("admin_ai_inactive", "Inactive")}</SelectItem>
                <SelectItem value="PENDING">{t("admin_ai_pending", "Pending")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("client.src.join_date", "Join Date")}</Label>
            <Input type="date" value={joinDate} onChange={e => setJoinDate(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
        </div>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onSubmit({ id: item.id, name, email, totalInvested, portfolioValue, returnRate, status, joinDate })} className="bg-primary hover:bg-primary/90">{t("admin_action_save", "Save")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function DeleteInvestorDialog({ open, onOpenChange, item, onConfirm }: { open: boolean; onOpenChange: (open: boolean) => void; item: Investor; onConfirm: () => void }) {
    const { t } = useTranslation();
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_auto_delete_investor", "Delete Investor")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_auto_are_you_sure_you_want_to_delete", "Are you sure you want to delete")}{item.name}{t("admin_auto_this_action_cannot_be_undone", "? This action cannot be undone.")}</DialogDescription>
        </DialogHeader>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={onConfirm} className="bg-red-500 hover:bg-red-600 text-white shadow-lg shadow-red-500/20">{t("admin_action_delete", "Delete")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
