"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  ScrollText,
  Search,
  ShieldCheck,
  AlertTriangle,
  Clock,
  CheckCircle,
  ArrowUpRight,
  ChevronRight,
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
} from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";

interface AuditEntry {
  id: string;
  timestamp: string;
  action: string;
  entityType: string;
  entityId: string;
  amount?: number;
  actor: string;
  status: "SUCCESS" | "FAILED" | "PENDING";
  oldValues?: Record<string, unknown>;
  newValues?: Record<string, unknown>;
  verified: boolean;
}

const mockEntries: AuditEntry[] = [
  {
    id: "1", timestamp: "2026-07-18T14:32:00Z", action: "DEPOSIT_CREATED",
    entityType: "KUMBARA_DEPOSIT", entityId: "K-1001", amount: 12000,
    actor: "admin@reservatior.com", status: "SUCCESS", verified: true,
    newValues: { tenantId: "T-301", totalTarget: 12000, ruleType: "FIXED_MONTHLY" },
  },
  {
    id: "2", timestamp: "2026-07-18T13:15:00Z", action: "PAYMENT_PROCESSED",
    entityType: "ESCROW", entityId: "E-2001", amount: 5000,
    actor: "system@reservatior.com", status: "SUCCESS", verified: true,
    oldValues: { balance: 0 }, newValues: { balance: 5000 },
  },
  {
    id: "3", timestamp: "2026-07-18T12:45:00Z", action: "TRUST_SCORE_UPDATED",
    entityType: "TRUST_SCORE", entityId: "TS-301",
    actor: "admin@reservatior.com", status: "SUCCESS", verified: true,
    oldValues: { score: 82, tier: "SILVER" }, newValues: { score: 87, tier: "GOLD" },
  },
  {
    id: "4", timestamp: "2026-07-18T11:20:00Z", action: "TRANSFER_FAILED",
    entityType: "BANK_ACCOUNT", entityId: "BA-4001", amount: 3200,
    actor: "system@reservatior.com", status: "FAILED", verified: true,
    oldValues: { status: "PENDING" }, newValues: { status: "FAILED", reason: "Insufficient funds" },
  },
  {
    id: "5", timestamp: "2026-07-18T10:00:00Z", action: "PORTFOLIO_CREATED",
    entityType: "REO_PORTFOLIO", entityId: "RP-5001",
    actor: "admin@reservatior.com", status: "SUCCESS", verified: false,
    newValues: { name: "Istanbul Core Portfolio", totalValue: 2500000 },
  },
  {
    id: "6", timestamp: "2026-07-17T18:30:00Z", action: "INTENT_DECLARED",
    entityType: "PURCHASE_INTENT", entityId: "PI-6001",
    actor: "tenant@reservatior.com", status: "SUCCESS", verified: true,
    newValues: { tenantId: "T-303", propertyId: "P-203" },
  },
  {
    id: "7", timestamp: "2026-07-17T16:00:00Z", action: "DEPOSIT_DEFAULTED",
    entityType: "KUMBARA_DEPOSIT", entityId: "K-1003",
    actor: "system@reservatior.com", status: "SUCCESS", verified: true,
    oldValues: { status: "ACTIVE" }, newValues: { status: "DEFAULTED" },
  },
];

const ACTION_COLORS: Record<string, string> = {
  DEPOSIT_CREATED: "bg-blue-500/20 text-blue-400",
  PAYMENT_PROCESSED: "bg-green-500/20 text-green-400",
  TRUST_SCORE_UPDATED: "bg-purple-500/20 text-purple-400",
  TRANSFER_FAILED: "bg-red-500/20 text-red-400",
  PORTFOLIO_CREATED: "bg-cyan-500/20 text-cyan-400",
  INTENT_DECLARED: "bg-amber-500/20 text-amber-400",
  DEPOSIT_DEFAULTED: "bg-orange-500/20 text-orange-400",
};

const STATUS_ICONS: Record<string, React.ReactNode> = {
  SUCCESS: <CheckCircle className="w-4 h-4 text-green-400" />,
  FAILED: <AlertTriangle className="w-4 h-4 text-red-400" />,
  PENDING: <Clock className="w-4 h-4 text-amber-400" />,
};

export default function AuditLogPage() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");
  const [actionFilter, setActionFilter] = useState<string>("ALL");
  const [entityFilter, setEntityFilter] = useState<string>("ALL");
  const [entries] = useState<AuditEntry[]>(mockEntries);
  const [expandedEntry, setExpandedEntry] = useState<AuditEntry | null>(null);
  const [verifyingId, setVerifyingId] = useState<string | null>(null);

  const filtered = entries.filter((e) => {
    const matchesSearch = e.actor.toLowerCase().includes(searchTerm.toLowerCase()) || e.entityId.toLowerCase().includes(searchTerm.toLowerCase()) || e.action.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesAction = actionFilter === "ALL" || e.action === actionFilter;
    const matchesEntity = entityFilter === "ALL" || e.entityType === entityFilter;
    return matchesSearch && matchesAction && matchesEntity;
  });

  const totalEvents = entries.length;
  const todayEvents = entries.filter((e) => e.timestamp.startsWith("2026-07-18")).length;
  const failedEvents = entries.filter((e) => e.status === "FAILED").length;

  const handleVerify = (id: string) => {
    setVerifyingId(id);
    setTimeout(() => setVerifyingId(null), 1500);
  };

  const formatDate = (ts: string) => {
    const d = new Date(ts);
    return d.toLocaleDateString("en-US", { month: "short", day: "numeric", year: "numeric" }) + " " + d.toLocaleTimeString("en-US", { hour: "2-digit", minute: "2-digit" });
  };

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8">
        <motion.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} className="mb-8">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-foreground mb-2">{t("admin_audit_title", "Financial Audit Log")}</h1>
              <p className="text-muted-foreground">{t("admin_audit_description", "Review financial audit trail, transaction history, and integrity checks")}</p>
            </div>
            <Button className="bg-primary hover:bg-primary/90">
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin_audit_back_to_dashboard", "Back to Dashboard")}
            </Button>
          </div>
        </motion.div>

        {/* Summary Cards */}
        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1 }} className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-blue-500/10"><ScrollText className="w-5 h-5 text-blue-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_audit_total_events", "Total Events")}</p>
                  <p className="text-2xl font-bold text-foreground">{totalEvents}</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-green-500/10"><Clock className="w-5 h-5 text-green-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_audit_today_events", "Today's Events")}</p>
                  <p className="text-2xl font-bold text-foreground">{todayEvents}</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-red-500/10"><AlertTriangle className="w-5 h-5 text-red-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_audit_failed_events", "Failed Events")}</p>
                  <p className="text-2xl font-bold text-foreground">{failedEvents}</p>
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
                      placeholder={t("admin_audit_search_placeholder", "Search by actor, action, or entity ID...")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors placeholder:text-muted-foreground"
                    />
                  </div>
                </div>
                <Select value={actionFilter} onValueChange={setActionFilter}>
                  <SelectTrigger className="w-[200px] bg-white/5 border-white/10 text-foreground">
                    <SelectValue placeholder={t("admin_audit_action_type", "Action Type")} />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="ALL">All Actions</SelectItem>
                    <SelectItem value="DEPOSIT_CREATED">Deposit Created</SelectItem>
                    <SelectItem value="PAYMENT_PROCESSED">Payment Processed</SelectItem>
                    <SelectItem value="TRUST_SCORE_UPDATED">Trust Score Updated</SelectItem>
                    <SelectItem value="TRANSFER_FAILED">Transfer Failed</SelectItem>
                    <SelectItem value="PORTFOLIO_CREATED">Portfolio Created</SelectItem>
                    <SelectItem value="INTENT_DECLARED">Intent Declared</SelectItem>
                    <SelectItem value="DEPOSIT_DEFAULTED">Deposit Defaulted</SelectItem>
                  </SelectContent>
                </Select>
                <Select value={entityFilter} onValueChange={setEntityFilter}>
                  <SelectTrigger className="w-[200px] bg-white/5 border-white/10 text-foreground">
                    <SelectValue placeholder={t("admin_audit_entity_type", "Entity Type")} />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="ALL">All Entities</SelectItem>
                    <SelectItem value="KUMBARA_DEPOSIT">Kumbara Deposit</SelectItem>
                    <SelectItem value="ESCROW">Escrow</SelectItem>
                    <SelectItem value="TRUST_SCORE">Trust Score</SelectItem>
                    <SelectItem value="BANK_ACCOUNT">Bank Account</SelectItem>
                    <SelectItem value="REO_PORTFOLIO">REO Portfolio</SelectItem>
                    <SelectItem value="PURCHASE_INTENT">Purchase Intent</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        {/* Audit Table */}
        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}>
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground flex items-center gap-2">
                <ScrollText className="w-5 h-5" />
                {t("admin_audit_log_entries", "Audit Log Entries")} ({filtered.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="overflow-x-auto">
                <table className="w-full text-sm">
                  <thead>
                    <tr className="border-b border-border">
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_audit_timestamp", "Timestamp")}</th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_audit_action", "Action")}</th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_audit_entity", "Entity")}</th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_audit_amount", "Amount")}</th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_audit_actor", "Actor")}</th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_audit_status", "Status")}</th>
                      <th className="text-right py-3 px-4 text-muted-foreground font-medium">{t("admin_audit_actions", "Actions")}</th>
                    </tr>
                  </thead>
                  <tbody>
                    {filtered.map((entry) => (
                      <tr key={entry.id} className="border-b border-border/50 hover:bg-muted/30 transition-colors cursor-pointer" onClick={() => setExpandedEntry(expandedEntry?.id === entry.id ? null : entry)}>
                        <td className="py-3 px-4 text-muted-foreground text-xs whitespace-nowrap">{formatDate(entry.timestamp)}</td>
                        <td className="py-3 px-4"><Badge className={ACTION_COLORS[entry.action]}>{entry.action.replace(/_/g, " ")}</Badge></td>
                        <td className="py-3 px-4">
                          <div className="text-foreground">{entry.entityType.replace(/_/g, " ")}</div>
                          <div className="text-xs text-muted-foreground">{entry.entityId}</div>
                        </td>
                        <td className="py-3 px-4 text-foreground">{entry.amount ? `$${entry.amount.toLocaleString()}` : "-"}</td>
                        <td className="py-3 px-4 text-muted-foreground text-xs">{entry.actor}</td>
                        <td className="py-3 px-4">{STATUS_ICONS[entry.status]}</td>
                        <td className="py-3 px-4">
                          <div className="flex justify-end gap-2" onClick={(e) => e.stopPropagation()}>
                            <Button onClick={() => handleVerify(entry.id)} variant="ghost" size="icon" className="h-8 w-8">
                              {verifyingId === entry.id ? <span className="animate-spin w-4 h-4 border-2 border-primary border-t-transparent rounded-full" /> : <ShieldCheck className={`w-4 h-4 ${entry.verified ? "text-green-400" : "text-muted-foreground"}`} />}
                            </Button>
                            <Button onClick={() => setExpandedEntry(expandedEntry?.id === entry.id ? null : entry)} variant="ghost" size="icon" className="h-8 w-8">
                              <ChevronRight className={`w-4 h-4 text-muted-foreground transition-transform ${expandedEntry?.id === entry.id ? "rotate-90" : ""}`} />
                            </Button>
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

        {/* Expanded Diff View */}
        {expandedEntry && (expandedEntry.oldValues || expandedEntry.newValues) && (
          <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} className="mt-6">
            <Card className="bg-card border-border">
              <CardHeader>
                <CardTitle className="text-foreground flex items-center gap-2">
                  <ScrollText className="w-5 h-5" />
                  {t("admin_audit_event_diff", "Event Diff")} - {expandedEntry.action.replace(/_/g, " ")}
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div className="p-4 bg-red-500/5 rounded-lg border border-red-500/20">
                    <h4 className="text-sm font-medium text-red-400 mb-3">{t("admin_audit_old_values", "Old Values")}</h4>
                    <pre className="text-xs text-foreground font-mono whitespace-pre-wrap">{expandedEntry.oldValues ? JSON.stringify(expandedEntry.oldValues, null, 2) : t("admin_audit_no_previous", "No previous values")}</pre>
                  </div>
                  <div className="p-4 bg-green-500/5 rounded-lg border border-green-500/20">
                    <h4 className="text-sm font-medium text-green-400 mb-3">{t("admin_audit_new_values", "New Values")}</h4>
                    <pre className="text-xs text-foreground font-mono whitespace-pre-wrap">{expandedEntry.newValues ? JSON.stringify(expandedEntry.newValues, null, 2) : t("admin_audit_no_new", "No new values")}</pre>
                  </div>
                </div>
              </CardContent>
            </Card>
          </motion.div>
        )}
      </div>
    </div>
  );
}
