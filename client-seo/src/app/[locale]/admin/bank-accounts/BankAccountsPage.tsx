"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  Landmark,
  Search,
  Plus,
  ArrowUpRight,
  Edit,
  Trash2,
  Star,
  CheckCircle,
  ShieldCheck,
  CreditCard,
} from "lucide-react";
import { m } from "framer-motion";
import { useTranslation } from "react-i18next";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
} from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";

interface BankAccount {
  id: string;
  bankName: string;
  accountName: string;
  accountType: "BUSINESS" | "ESCROW" | "OPERATING" | "SAVINGS";
  status: "ACTIVE" | "INACTIVE" | "VERIFICATION_PENDING" | "BLOCKED";
  iban: string;
  accountNumber: string;
  currency: string;
  country: string;
  isDefaultPayout: boolean;
  isDefaultReceipt: boolean;
  createdAt: string;
}

const mockAccounts: BankAccount[] = [
  {
    id: "1", bankName: "Turkiye Is Bankasi", accountName: "Reservatior Operating",
    accountType: "OPERATING", status: "ACTIVE", iban: "TR33 0006 1005 1978 6457 8413 26",
    accountNumber: "19786457841326", currency: "TRY", country: "TR",
    isDefaultPayout: true, isDefaultReceipt: true, createdAt: "2025-01-15",
  },
  {
    id: "2", bankName: "Deutsche Bank", accountName: "Reservatior EU",
    accountType: "BUSINESS", status: "ACTIVE", iban: "DE89 3704 0044 0532 0130 00",
    accountNumber: "0532013000", currency: "EUR", country: "DE",
    isDefaultPayout: false, isDefaultReceipt: true, createdAt: "2025-03-01",
  },
  {
    id: "3", bankName: "Barclays UK", accountName: "Reservatior Escrow",
    accountType: "ESCROW", status: "VERIFICATION_PENDING", iban: "GB29 NWBK 6016 1331 9268 19",
    accountNumber: "60161331926819", currency: "GBP", country: "GB",
    isDefaultPayout: false, isDefaultReceipt: false, createdAt: "2025-06-15",
  },
  {
    id: "4", bankName: "Ziraat Bankasi", accountName: "Savings Account",
    accountType: "SAVINGS", status: "INACTIVE", iban: "TR17 0001 0017 4647 3298 6253 77",
    accountNumber: "001746473298625377", currency: "TRY", country: "TR",
    isDefaultPayout: false, isDefaultReceipt: false, createdAt: "2025-09-01",
  },
];

const TYPE_COLORS: Record<string, string> = {
  BUSINESS: "bg-blue-500/20 text-blue-400",
  ESCROW: "bg-purple-500/20 text-purple-400",
  OPERATING: "bg-green-500/20 text-green-400",
  SAVINGS: "bg-amber-500/20 text-amber-400",
};

const STATUS_COLORS: Record<string, string> = {
  ACTIVE: "bg-green-500/20 text-green-400",
  INACTIVE: "bg-gray-500/20 text-gray-400",
  VERIFICATION_PENDING: "bg-amber-500/20 text-amber-400",
  BLOCKED: "bg-red-500/20 text-red-400",
};

function maskAccountNumber(num: string): string {
  if (num.length <= 4) return num;
  return "*".repeat(num.length - 4) + num.slice(-4);
}

export default function BankAccountsPage() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");
  const [statusFilter, setStatusFilter] = useState<string>("ALL");
  const [items, setItems] = useState<BankAccount[]>(mockAccounts);
  const [editingItem, setEditingItem] = useState<BankAccount | null>(null);
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [isDeleteOpen, setIsDeleteOpen] = useState(false);
  const [deletingItem, setDeletingItem] = useState<BankAccount | null>(null);

  const filtered = items.filter((s) => {
    const matchesSearch = s.bankName.toLowerCase().includes(searchTerm.toLowerCase()) || s.accountName.toLowerCase().includes(searchTerm.toLowerCase()) || s.iban.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesStatus = statusFilter === "ALL" || s.status === statusFilter;
    return matchesSearch && matchesStatus;
  });

  const handleCreate = (data: Omit<BankAccount, "id" | "createdAt">) => {
    const newItem: BankAccount = { ...data, id: String(Date.now()), createdAt: new Date().toISOString().split("T")[0] };
    setItems((prev) => [...prev, newItem]);
    setIsCreateOpen(false);
  };

  const handleEdit = (updatedItem: BankAccount) => {
    setItems((prev) => prev.map((item) => (item.id === updatedItem.id ? updatedItem : item)));
    setIsEditOpen(false);
    setEditingItem(null);
  };

  const handleDelete = (id: string) => {
    setItems((prev) => prev.filter((item) => item.id !== id));
    setIsDeleteOpen(false);
    setDeletingItem(null);
  };

  const toggleDefault = (id: string, field: "isDefaultPayout" | "isDefaultReceipt") => {
    setItems((prev) =>
      prev.map((item) =>
        item.id === id ? { ...item, [field]: !item[field] } : item
      )
    );
  };

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8">
        <m.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} className="mb-8">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-foreground mb-2">{t("admin_bank_title", "Bank Accounts")}</h1>
              <p className="text-muted-foreground">{t("admin_bank_description", "Manage platform bank accounts, IBAN details, and payout configuration")}</p>
            </div>
            <Button className="bg-primary hover:bg-primary/90">
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin_bank_back_to_dashboard", "Back to Dashboard")}
            </Button>
          </div>
        </m.div>

        {/* Search and Filter */}
        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1 }} className="mb-6">
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex gap-4 flex-wrap">
                <div className="flex-1 min-w-[200px]">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                    <Input
                      placeholder={t("admin_bank_search_placeholder", "Search by bank name, account name, or IBAN...")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors placeholder:text-muted-foreground"
                    />
                  </div>
                </div>
                <Select value={statusFilter} onValueChange={setStatusFilter}>
                  <SelectTrigger className="w-[180px] bg-white/5 border-white/10 text-foreground">
                    <SelectValue placeholder={t("admin_bank_filter_status", "Filter Status")} />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="ALL">All Status</SelectItem>
                    <SelectItem value="ACTIVE">Active</SelectItem>
                    <SelectItem value="INACTIVE">Inactive</SelectItem>
                    <SelectItem value="VERIFICATION_PENDING">Verification Pending</SelectItem>
                    <SelectItem value="BLOCKED">Blocked</SelectItem>
                  </SelectContent>
                </Select>
                <Button onClick={() => setIsCreateOpen(true)} className="bg-primary hover:bg-primary/90">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin_bank_add_account", "Add Account")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </m.div>

        {/* Account Cards */}
        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.15 }}>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            {filtered.map((account) => (
              <Card key={account.id} className="bg-card border-border hover:bg-muted/30 transition-colors">
                <CardContent className="p-5">
                  <div className="flex items-start justify-between mb-4">
                    <div className="flex items-center gap-3">
                      <div className="p-2 rounded-lg bg-muted/50"><Landmark className="w-5 h-5 text-muted-foreground" /></div>
                      <div>
                        <h2 className="text-foreground font-semibold">{account.bankName}</h2>
                        <p className="text-sm text-muted-foreground">{account.accountName}</p>
                      </div>
                    </div>
                    <div className="flex gap-1">
                      {account.isDefaultPayout && <Star className="w-4 h-4 text-yellow-400 fill-yellow-400" />}
                      {account.isDefaultReceipt && <Star className="w-4 h-4 text-green-400 fill-green-400" />}
                    </div>
                  </div>
                  <div className="space-y-3">
                    <div className="flex items-center justify-between">
                      <Badge className={TYPE_COLORS[account.accountType]}>{account.accountType}</Badge>
                      <Badge className={STATUS_COLORS[account.status]}>{account.status.replace(/_/g, " ")}</Badge>
                    </div>
                    <div className="p-3 bg-muted/30 rounded-lg">
                      <p className="text-xs text-muted-foreground mb-1">{t("admin_bank_iban", "IBAN")}</p>
                      <p className="text-sm text-foreground font-mono">{account.iban}</p>
                    </div>
                    <div className="flex items-center justify-between text-xs text-muted-foreground">
                      <span className="flex items-center gap-1"><CreditCard className="w-3 h-3" />{maskAccountNumber(account.accountNumber)}</span>
                      <span>{account.currency} / {account.country}</span>
                    </div>
                    <div className="flex items-center gap-2 pt-2 border-t border-border/50">
                      <Button onClick={() => toggleDefault(account.id, "isDefaultPayout")} variant="ghost" size="sm" className={`text-xs ${account.isDefaultPayout ? "text-yellow-400" : "text-muted-foreground"}`}>
                        <Star className={`w-3 h-3 mr-1 ${account.isDefaultPayout ? "fill-yellow-400" : ""}`} />
                        {t("admin_bank_payout", "Payout")}
                      </Button>
                      <Button onClick={() => toggleDefault(account.id, "isDefaultReceipt")} variant="ghost" size="sm" className={`text-xs ${account.isDefaultReceipt ? "text-green-400" : "text-muted-foreground"}`}>
                        <Star className={`w-3 h-3 mr-1 ${account.isDefaultReceipt ? "fill-green-400" : ""}`} />
                        {t("admin_bank_receipt", "Receipt")}
                      </Button>
                    </div>
                  </div>
                  <div className="flex justify-end gap-2 mt-3 pt-3 border-t border-border/50">
                    {account.status === "VERIFICATION_PENDING" && (
                      <Button variant="ghost" size="icon" className="min-h-10 min-w-10 h-10 w-10 text-green-400"><ShieldCheck className="w-4 h-4" /></Button>
                    )}
                    <Button onClick={() => { setEditingItem(account); setIsEditOpen(true); }} variant="ghost" size="icon" className="min-h-10 min-w-10 h-10 w-10"><Edit className="w-4 h-4" /></Button>
                    <Button onClick={() => { setDeletingItem(account); setIsDeleteOpen(true); }} variant="ghost" size="icon" className="min-h-10 min-w-10 h-10 w-10 text-red-400"><Trash2 className="w-4 h-4" /></Button>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        </m.div>

        {/* Create Dialog */}
        <CreateAccountDialog open={isCreateOpen} onOpenChange={setIsCreateOpen} onSubmit={handleCreate} />
        {editingItem && <EditAccountDialog open={isEditOpen} onOpenChange={setIsEditOpen} item={editingItem} onSubmit={handleEdit} />}
        {deletingItem && <DeleteAccountDialog open={isDeleteOpen} onOpenChange={setIsDeleteOpen} item={deletingItem} onConfirm={() => handleDelete(deletingItem.id)} />}
      </div>
    </div>
  );
}

function CreateAccountDialog({ open, onOpenChange, onSubmit }: { open: boolean; onOpenChange: (open: boolean) => void; onSubmit: (data: Omit<BankAccount, "id" | "createdAt">) => void }) {
  const { t } = useTranslation();
  const [bankName, setBankName] = useState("");
  const [accountName, setAccountName] = useState("");
  const [accountType, setAccountType] = useState<BankAccount["accountType"]>("BUSINESS");
  const [status, setStatus] = useState<BankAccount["status"]>("ACTIVE");
  const [iban, setIban] = useState("");
  const [accountNumber, setAccountNumber] = useState("");
  const [currency, setCurrency] = useState("TRY");
  const [country, setCountry] = useState("TR");

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[600px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_bank_create_account", "Add Bank Account")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_bank_create_account_desc", "Add a new bank account to the platform.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_bank_bank_name", "Bank Name")}</Label>
            <Input value={bankName} onChange={(e) => setBankName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_bank_account_name", "Account Name")}</Label>
            <Input value={accountName} onChange={(e) => setAccountName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_bank_account_type", "Account Type")}</Label>
            <Select value={accountType} onValueChange={(v) => setAccountType(v as BankAccount["accountType"])}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="BUSINESS">Business</SelectItem>
                <SelectItem value="ESCROW">Escrow</SelectItem>
                <SelectItem value="OPERATING">Operating</SelectItem>
                <SelectItem value="SAVINGS">Savings</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">IBAN</Label>
            <Input value={iban} onChange={(e) => setIban(e.target.value)} placeholder="TR..." className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_bank_account_number", "Account Number")}</Label>
            <Input value={accountNumber} onChange={(e) => setAccountNumber(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_bank_currency", "Currency")}</Label>
            <Select value={currency} onValueChange={setCurrency}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="TRY">TRY</SelectItem>
                <SelectItem value="EUR">EUR</SelectItem>
                <SelectItem value="GBP">GBP</SelectItem>
                <SelectItem value="USD">USD</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_bank_country", "Country")}</Label>
            <Select value={country} onValueChange={setCountry}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="TR">Turkey</SelectItem>
                <SelectItem value="DE">Germany</SelectItem>
                <SelectItem value="GB">United Kingdom</SelectItem>
                <SelectItem value="US">United States</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_status", "Status")}</Label>
            <Select value={status} onValueChange={(v) => setStatus(v as BankAccount["status"])}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="ACTIVE">Active</SelectItem>
                <SelectItem value="INACTIVE">Inactive</SelectItem>
                <SelectItem value="VERIFICATION_PENDING">Verification Pending</SelectItem>
                <SelectItem value="BLOCKED">Blocked</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onSubmit({ bankName, accountName, accountType, status, iban, accountNumber, currency, country, isDefaultPayout: false, isDefaultReceipt: false })} className="bg-primary hover:bg-primary/90">{t("admin_action_create", "Create")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function EditAccountDialog({ open, onOpenChange, item, onSubmit }: { open: boolean; onOpenChange: (open: boolean) => void; item: BankAccount; onSubmit: (data: BankAccount) => void }) {
  const { t } = useTranslation();
  const [bankName, setBankName] = useState(item.bankName);
  const [accountName, setAccountName] = useState(item.accountName);
  const [accountType, setAccountType] = useState(item.accountType);
  const [status, setStatus] = useState(item.status);
  const [iban, setIban] = useState(item.iban);
  const [accountNumber, setAccountNumber] = useState(item.accountNumber);
  const [currency, setCurrency] = useState(item.currency);
  const [country, setCountry] = useState(item.country);

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[600px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_bank_edit_account", "Edit Bank Account")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_bank_edit_account_desc", "Update bank account details.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_bank_bank_name", "Bank Name")}</Label>
            <Input value={bankName} onChange={(e) => setBankName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_bank_account_name", "Account Name")}</Label>
            <Input value={accountName} onChange={(e) => setAccountName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_bank_account_type", "Account Type")}</Label>
            <Select value={accountType} onValueChange={(v) => setAccountType(v as BankAccount["accountType"])}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="BUSINESS">Business</SelectItem>
                <SelectItem value="ESCROW">Escrow</SelectItem>
                <SelectItem value="OPERATING">Operating</SelectItem>
                <SelectItem value="SAVINGS">Savings</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">IBAN</Label>
            <Input value={iban} onChange={(e) => setIban(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_bank_account_number", "Account Number")}</Label>
            <Input value={accountNumber} onChange={(e) => setAccountNumber(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_bank_currency", "Currency")}</Label>
            <Select value={currency} onValueChange={setCurrency}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="TRY">TRY</SelectItem>
                <SelectItem value="EUR">EUR</SelectItem>
                <SelectItem value="GBP">GBP</SelectItem>
                <SelectItem value="USD">USD</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_bank_country", "Country")}</Label>
            <Select value={country} onValueChange={setCountry}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="TR">Turkey</SelectItem>
                <SelectItem value="DE">Germany</SelectItem>
                <SelectItem value="GB">United Kingdom</SelectItem>
                <SelectItem value="US">United States</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_status", "Status")}</Label>
            <Select value={status} onValueChange={(v) => setStatus(v as BankAccount["status"])}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="ACTIVE">Active</SelectItem>
                <SelectItem value="INACTIVE">Inactive</SelectItem>
                <SelectItem value="VERIFICATION_PENDING">Verification Pending</SelectItem>
                <SelectItem value="BLOCKED">Blocked</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onSubmit({ ...item, bankName, accountName, accountType, status, iban, accountNumber, currency, country })} className="bg-primary hover:bg-primary/90">{t("admin_action_save", "Save")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function DeleteAccountDialog({ open, onOpenChange, item, onConfirm }: { open: boolean; onOpenChange: (open: boolean) => void; item: BankAccount; onConfirm: () => void }) {
  const { t } = useTranslation();
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_bank_delete_account", "Delete Bank Account")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_bank_delete_account_desc", "Are you sure you want to delete")}{item.accountName}{t("admin_auto_this_action_cannot_be_undone", "? This action cannot be undone.")}</DialogDescription>
        </DialogHeader>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={onConfirm} className="bg-red-500 hover:bg-red-600 text-white shadow-lg shadow-red-500/20">{t("admin_action_delete", "Delete")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
