"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  DollarSign,
  Search,
  CheckCircle,
  Clock,
  TrendingUp,
  CreditCard,
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
} from "@/components/ui/dialog";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";

const STATUSES = ["PENDING", "APPROVED", "PAID", "CANCELLED"];

const STATUS_COLORS: Record<string, string> = {
  PENDING: "bg-amber-500/20 text-amber-400",
  APPROVED: "bg-blue-500/20 text-blue-400",
  PAID: "bg-green-500/20 text-green-400",
  CANCELLED: "bg-red-500/20 text-red-400",
};

const mockCommissions = [
  { id: "1", orgId: "org1", sourceType: "ORDER", sourceId: "ORD-001", agentId: "a1", agentName: "Alex Morgan", type: "SALE", basis: "PERCENTAGE", basisAmount: 5999, rate: 12, amount: 719.88, currency: "USD", platformShare: 359.94, agentShare: 359.94, supplierShare: 0, partnerShare: 0, status: "PAID", calculatedAt: "2026-01-15", approvedAt: "2026-01-16", paidAt: "2026-01-20", paymentRef: "PAY-001", createdAt: "2026-01-15", updatedAt: "2026-01-20" },
  { id: "2", orgId: "org1", sourceType: "ORDER", sourceId: "ORD-002", agentId: "a2", agentName: "Jordan Lee", type: "SALE", basis: "PERCENTAGE", basisAmount: 3499, rate: 10, amount: 349.9, currency: "USD", platformShare: 174.95, agentShare: 174.95, supplierShare: 0, partnerShare: 0, status: "APPROVED", calculatedAt: "2026-01-20", approvedAt: "2026-01-21", createdAt: "2026-01-20", updatedAt: "2026-01-21" },
  { id: "3", orgId: "org1", sourceType: "BUNDLE", sourceId: "BUN-003", agentId: "a3", agentName: "Sam Williams", type: "REFERRAL", basis: "FIXED", basisAmount: 0, rate: 0, amount: 250, currency: "USD", platformShare: 125, agentShare: 125, supplierShare: 0, partnerShare: 0, status: "PENDING", calculatedAt: "2026-02-01", createdAt: "2026-02-01", updatedAt: "2026-02-01" },
  { id: "4", orgId: "org1", sourceType: "ORDER", sourceId: "ORD-004", agentId: "a1", agentName: "Alex Morgan", type: "SALE", basis: "PERCENTAGE", basisAmount: 15999, rate: 12, amount: 1919.88, currency: "USD", platformShare: 959.94, agentShare: 959.94, supplierShare: 0, partnerShare: 0, status: "PAID", calculatedAt: "2026-02-05", approvedAt: "2026-02-06", paidAt: "2026-02-10", paymentRef: "PAY-004", createdAt: "2026-02-05", updatedAt: "2026-02-10" },
  { id: "5", orgId: "org1", sourceType: "ORDER", sourceId: "ORD-005", agentId: "a4", agentName: "Taylor Swift", type: "BONUS", basis: "FIXED", basisAmount: 0, rate: 0, amount: 500, currency: "USD", platformShare: 250, agentShare: 250, supplierShare: 0, partnerShare: 0, status: "PENDING", calculatedAt: "2026-02-10", createdAt: "2026-02-10", updatedAt: "2026-02-10" },
];

export default function CommissionsPage() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");
  const [statusFilter, setStatusFilter] = useState("all");
  const [agentFilter, setAgentFilter] = useState("all");
  const [payDialogOpen, setPayDialogOpen] = useState(false);
  const [payingItem, setPayingItem] = useState<any>(null);

  const filtered = mockCommissions.filter((c) => {
    const matchesSearch = c.sourceId.toLowerCase().includes(searchTerm.toLowerCase()) || c.agentName.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesStatus = statusFilter === "all" || c.status === statusFilter;
    const matchesAgent = agentFilter === "all" || c.agentId === agentFilter;
    return matchesSearch && matchesStatus && matchesAgent;
  });

  const totalCommissions = mockCommissions.reduce((sum, c) => sum + c.amount, 0);
  const paidCommissions = mockCommissions.filter((c) => c.status === "PAID").reduce((sum, c) => sum + c.amount, 0);
  const pendingCommissions = mockCommissions.filter((c) => c.status === "PENDING" || c.status === "APPROVED").reduce((sum, c) => sum + c.amount, 0);
  const platformRevenue = mockCommissions.filter((c) => c.status === "PAID").reduce((sum, c) => sum + c.platformShare, 0);

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8">
        <motion.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} className="mb-8">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-foreground mb-2">{t("admin_commissions_title", "Commerce Commissions")}</h1>
              <p className="text-muted-foreground">{t("admin_commissions_description", "Track and manage commission calculations, approvals, and payouts")}</p>
            </div>
          </div>
        </motion.div>

        {/* Summary Cards */}
        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1 }} className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-blue-500/10"><DollarSign className="w-5 h-5 text-blue-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_commissions_total", "Total")}</p>
                  <p className="text-2xl font-bold text-foreground">${totalCommissions.toLocaleString()}</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-green-500/10"><CheckCircle className="w-5 h-5 text-green-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_commissions_paid", "Paid")}</p>
                  <p className="text-2xl font-bold text-foreground">${paidCommissions.toLocaleString()}</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-amber-500/10"><Clock className="w-5 h-5 text-amber-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_commissions_pending", "Pending")}</p>
                  <p className="text-2xl font-bold text-foreground">${pendingCommissions.toLocaleString()}</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-purple-500/10"><TrendingUp className="w-5 h-5 text-purple-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_commissions_platform", "Platform Share")}</p>
                  <p className="text-2xl font-bold text-foreground">${platformRevenue.toLocaleString()}</p>
                </div>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        {/* Search and Filter */}
        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.15 }} className="mb-6">
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex gap-4 flex-wrap">
                <div className="flex-1 min-w-[200px]">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                    <Input
                      placeholder={t("admin_commissions_search_placeholder", "Search by order or agent...")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors placeholder:text-muted-foreground"
                    />
                  </div>
                </div>
                <Select value={agentFilter} onValueChange={setAgentFilter}>
                  <SelectTrigger className="w-[180px] bg-white/5 border-white/10 text-foreground">
                    <SelectValue placeholder={t("admin_commissions_agent", "Agent")} />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">{t("admin_commissions_all_agents", "All Agents")}</SelectItem>
                    <SelectItem value="a1">Alex Morgan</SelectItem>
                    <SelectItem value="a2">Jordan Lee</SelectItem>
                    <SelectItem value="a3">Sam Williams</SelectItem>
                    <SelectItem value="a4">Taylor Swift</SelectItem>
                  </SelectContent>
                </Select>
                <Select value={statusFilter} onValueChange={setStatusFilter}>
                  <SelectTrigger className="w-[180px] bg-white/5 border-white/10 text-foreground">
                    <SelectValue placeholder={t("admin_commissions_status", "Status")} />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">{t("admin_commissions_all_status", "All Status")}</SelectItem>
                    {STATUSES.map((s) => <SelectItem key={s} value={s}>{s}</SelectItem>)}
                  </SelectContent>
                </Select>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        {/* Commissions Table */}
        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}>
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground flex items-center gap-2">
                <DollarSign className="w-5 h-5" />
                {t("admin_commissions_list_title", "Commissions")} ({filtered.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="overflow-x-auto">
                <table className="w-full text-sm">
                  <thead>
                    <tr className="border-b border-border">
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_commissions_source", "Source")}</th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_commissions_agent", "Agent")}</th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_commissions_type", "Type")}</th>
                      <th className="text-right py-3 px-4 text-muted-foreground font-medium">{t("admin_commissions_amount", "Amount")}</th>
                      <th className="text-right py-3 px-4 text-muted-foreground font-medium">{t("admin_commissions_platform", "Platform")}</th>
                      <th className="text-right py-3 px-4 text-muted-foreground font-medium">{t("admin_commissions_agent_share", "Agent")}</th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_commissions_status_col", "Status")}</th>
                      <th className="text-right py-3 px-4 text-muted-foreground font-medium">{t("admin_commissions_actions", "Actions")}</th>
                    </tr>
                  </thead>
                  <tbody>
                    {filtered.map((commission) => (
                      <tr key={commission.id} className="border-b border-border/50 hover:bg-muted/30 transition-colors">
                        <td className="py-3 px-4">
                          <div className="text-foreground font-medium font-mono text-xs">{commission.sourceId}</div>
                          <div className="text-xs text-muted-foreground">{commission.sourceType}</div>
                        </td>
                        <td className="py-3 px-4 text-foreground">{commission.agentName}</td>
                        <td className="py-3 px-4">
                          <Badge className="bg-slate-500/20 text-slate-400">{commission.type}</Badge>
                        </td>
                        <td className="py-3 px-4 text-right font-medium text-foreground">${commission.amount.toLocaleString()}</td>
                        <td className="py-3 px-4 text-right text-muted-foreground">${commission.platformShare.toLocaleString()}</td>
                        <td className="py-3 px-4 text-right text-muted-foreground">${commission.agentShare.toLocaleString()}</td>
                        <td className="py-3 px-4">
                          <Badge className={STATUS_COLORS[commission.status]}>{commission.status}</Badge>
                        </td>
                        <td className="py-3 px-4">
                          <div className="flex justify-end gap-2">
                            {commission.status === "PENDING" && (
                              <Button variant="ghost" size="sm" className="text-green-400"><CheckCircle className="w-3.5 h-3.5 mr-1" />Approve</Button>
                            )}
                            {commission.status === "APPROVED" && (
                              <Button variant="ghost" size="sm" className="text-blue-400" onClick={() => { setPayingItem(commission); setPayDialogOpen(true); }}><CreditCard className="w-3.5 h-3.5 mr-1" />Pay</Button>
                            )}
                          </div>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        {/* Pay Dialog */}
        {payingItem && (
          <Dialog open={payDialogOpen} onOpenChange={setPayDialogOpen}>
            <DialogContent className="sm:max-w-[425px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground">
              <DialogHeader>
                <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_commissions_pay_title", "Confirm Payment")}</DialogTitle>
                <DialogDescription className="text-muted-foreground">{t("admin_commissions_pay_desc", "Mark commission as paid for")}{payingItem.agentName}</DialogDescription>
              </DialogHeader>
              <div className="py-4">
                <div className="text-center">
                  <p className="text-3xl font-bold text-foreground">${payingItem.amount.toLocaleString()}</p>
                  <p className="text-sm text-muted-foreground mt-1">{payingItem.sourceId} • {payingItem.type}</p>
                </div>
              </div>
              <DialogFooter className="pt-4 border-t border-white/10">
                <Button variant="outline" onClick={() => setPayDialogOpen(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
                <Button onClick={() => setPayDialogOpen(false)} className="bg-green-500 hover:bg-green-600 text-white shadow-lg shadow-green-500/20">{t("admin_commissions_confirm_pay", "Confirm Payment")}</Button>
              </DialogFooter>
            </DialogContent>
          </Dialog>
        )}
      </div>
    </div>
  );
}
