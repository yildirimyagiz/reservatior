"use client";

import { useEffect, useState, useCallback } from "react";
import { useTranslation } from "react-i18next";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import Link from "next/link";
import {
  Facebook,
  User,
  DollarSign,
  Clock,
  ShieldCheck,
  TrendingUp,
  Zap,
  ChevronRight,
  AlertCircle,
  CheckCircle2,
  BarChart3,
  Flame,
  Wallet
} from "lucide-react";
import { formatDistanceToNow } from "date-fns";
import { useToast } from "@/hooks/use-toast";

const API_URL = process.env.NEXT_PUBLIC_API_URL || "http://localhost:3000/api/v1";
const WEBHOOKS_URL = "http://localhost:3000/api/webhooks/ads";

type LeadStatus = "NEW" | "CONTACTED" | "QUALIFIED" | "LOST";

interface Lead {
  id: string;
  firstName?: string;
  lastName?: string;
  email?: string;
  phone?: string;
  status: LeadStatus;
  campaignId?: string;
  sourceDetail?: string;
  createdAt: string;
}

const STATUS_COLUMNS = [
  { key: "NEW" as LeadStatus,       label: "New Leads",  colorBg: "bg-brand/100/10",    colorBorder: "border-l-blue-500",    colorBadge: "bg-brand/100/15 text-brand",    Icon: Flame },
  { key: "CONTACTED" as LeadStatus, label: "Contacted",  colorBg: "bg-amber-500/10",   colorBorder: "border-l-amber-400",   colorBadge: "bg-amber-500/15 text-amber-400",  Icon: Zap },
  { key: "QUALIFIED" as LeadStatus, label: "Closed/Won", colorBg: "bg-success/10", colorBorder: "border-l-blue-500", colorBadge: "bg-success/15 text-success", Icon: CheckCircle2 },
  { key: "LOST" as LeadStatus,      label: "Lost",       colorBg: "bg-rose-500/10",    colorBorder: "border-l-rose-500",    colorBadge: "bg-rose-500/15 text-rose-400",    Icon: AlertCircle },
];

function LeadCard({ lead, onAdvance, onCloseDeal }: {
  lead: Lead;
  onAdvance?: (id: string) => void;
  onCloseDeal?: (id: string) => void;
}) {
  const { t } = useTranslation();
  const col = STATUS_COLUMNS.find(c => c.key === lead.status)!;
  const isWon = lead.status === "QUALIFIED";

  return (
    <Card className={`border-l-4 ${col.colorBorder} bg-card border-border hover:shadow-lg hover:-translate-y-0.5 transition-all duration-200`}>
      <CardContent className="p-4 space-y-3">
        <div className="flex justify-between items-start">
          <div>
            <h4 className={`font-bold flex items-center gap-2 text-sm ${isWon ? "line-through text-muted-foreground" : "text-white"}`}>
              <User className="w-3.5 h-3.5 text-muted-foreground shrink-0" />
              {lead.firstName} {lead.lastName}
            </h4>
            <p className="text-[11px] text-muted-foreground truncate mt-0.5">{lead.email}</p>
          </div>
          {lead.campaignId && (
            <Badge className={`text-[9px] px-1.5 py-0 border-0 ${col.colorBadge} shrink-0`}>
              <Facebook className="w-2.5 h-2.5 mr-1" />AI Ads
            </Badge>
          )}
        </div>

        {lead.sourceDetail && (
          <p className="text-[11px] text-muted-foreground italic">{lead.sourceDetail}</p>
        )}

        <div className="flex items-center gap-1.5 text-[11px] text-muted-foreground">
          <Clock className="w-3 h-3" />
          {formatDistanceToNow(new Date(lead.createdAt), { addSuffix: true })}
        </div>

        <div className="pt-2 border-t border-border flex gap-2">
          {lead.status === "NEW" && onAdvance && (
            <Button
              id={`lead-contact-${lead.id}`}
              size="sm"
              variant="outline"
              onClick={() => onAdvance(lead.id)}
              className="flex-1 text-xs border-border text-muted-foreground hover:text-white hover:border-amber-400 hover:bg-amber-500/10"
            >
              <ChevronRight className="w-3 h-3 mr-1" />
              {t("leads.advance_contacted", { defaultValue: "Contact" })}
            </Button>
          )}
          {!isWon && lead.status !== "LOST" && onCloseDeal && (
            <Button
              id={`lead-close-${lead.id}`}
              size="sm"
              onClick={() => onCloseDeal(lead.id)}
              className="flex-1 text-xs bg-blue-600 hover:bg-success text-white"
            >
              <DollarSign className="w-3 h-3 mr-1" />
              {t("leads.close_deal", { defaultValue: "Close Deal" })}
            </Button>
          )}
          {isWon && (
            <div className="flex-1 flex items-center gap-1.5 text-xs text-success font-medium">
              <ShieldCheck className="w-3.5 h-3.5" />
              {t("leads.commission_installments_offered", { defaultValue: "Commission Offered" })}
            </div>
          )}
        </div>
      </CardContent>
    </Card>
  );
}

function StatCard({ label, value, sub, ring }: { label: string; value: string | number; sub?: string; ring: string }) {
  return (
    <div className={`rounded-xl p-4 bg-card border border-border ring-1 ${ring}`}>
      <p className="text-xs text-muted-foreground uppercase tracking-wider font-medium">{label}</p>
      <p className="text-2xl font-bold text-white mt-1">{value}</p>
      {sub && <p className="text-xs text-muted-foreground mt-0.5">{sub}</p>}
    </div>
  );
}

export function DealsContent() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const [leads, setLeads] = useState<Lead[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [isSimulating, setIsSimulating] = useState(false);

  const fetchLeads = useCallback(async () => {
    try {
      const token = localStorage.getItem("auth_token");
      const res = await fetch(`${API_URL}/lead`, {
        headers: { Authorization: `Bearer ${token}` },
      });
      if (res.ok) {
        const data = await res.json();
        setLeads(data.data || []);
      }
    } catch { /* silent */ }
    finally { setIsLoading(false); }
  }, []);

  useEffect(() => {
    fetchLeads();
    const id = setInterval(fetchLeads, 5000);
    return () => clearInterval(id);
  }, [fetchLeads]);

  const simulateLead = async () => {
    setIsSimulating(true);
    try {
      const pool = [["Sarah","Mitchell"],["James","Torres"],["Aisha","Malik"],["Wei","Zhang"],["Omar","Khalid"],["Elena","Petrov"]];
      const [fn, ln] = pool[Math.floor(Math.random() * pool.length)];
      const res = await fetch(`${WEBHOOKS_URL}/lead`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ firstName: fn, lastName: ln, email: `${fn.toLowerCase()}.${ln.toLowerCase()}@example.com`, phone: `+1-555-${Math.floor(1000 + Math.random() * 9000)}`, campaignId: "cmp_ai_reels_auto" }),
      });
      if (res.ok) {
        toast({ title: t("leads.ad_lead_created", { defaultValue: "Lead Captured! 🎯" }), description: t("leads.ad_lead_created_desc", { defaultValue: "A new lead arrived from the Meta Ads campaign." }) });
        await fetchLeads();
      }
    } finally { setIsSimulating(false); }
  };

  const advanceToContacted = async (id: string) => {
    try {
      const token = localStorage.getItem("auth_token");
      await fetch(`${API_URL}/lead/${id}`, {
        method: "PATCH",
        headers: { "Content-Type": "application/json", Authorization: `Bearer ${token}` },
        body: JSON.stringify({ status: "CONTACTED" }),
      });
      toast({ title: t("leads.lead_contacted", { defaultValue: "Moved to Contacted" }) });
      await fetchLeads();
    } catch { /* silent */ }
  };

  const closeDeal = async (id: string) => {
    const price = Math.floor(Math.random() * 700_000) + 300_000;
    try {
      const res = await fetch(`${WEBHOOKS_URL}/${id}/close-deal`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ price, commissionRate: 3.0 }),
      });
      if (res.ok) {
        toast({
          title: t("leads.deal_closed", { defaultValue: "🎉 Deal Closed!" }),
          description: t("leads.deal_closed_desc", { defaultValue: `$${price.toLocaleString()} — Commission saga triggered.`, price: price.toLocaleString() }),
        });
        await fetchLeads();
      }
    } catch { /* silent */ }
  };

  const total   = leads.length;
  const newCnt  = leads.filter(l => l.status === "NEW").length;
  const wonCnt  = leads.filter(l => l.status === "QUALIFIED").length;
  const convRate = total > 0 ? Math.round((wonCnt / total) * 100) : 0;
  const pipelineValue = (wonCnt * 450_000) / 1_000_000;

  return (
    <div className="min-h-screen bg-muted text-white p-6 space-y-8">
      {/* Header */}
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
        <div>
          <h1 className="text-3xl font-bold tracking-tight bg-gradient-to-r from-white via-slate-300 to-slate-500 bg-clip-text text-transparent">
            {t("deals.pipeline_title", { defaultValue: "Deal Pipeline" })}
          </h1>
          <p className="text-muted-foreground text-sm mt-1 flex items-center gap-1.5">
            <Facebook className="w-3.5 h-3.5 text-brand" /> Meta Ads
            <ChevronRight className="w-3 h-3 text-muted-foreground" />
            <span className="text-muted-foreground">AI Reel</span>
            <ChevronRight className="w-3 h-3 text-muted-foreground" />
            Lead
            <ChevronRight className="w-3 h-3 text-muted-foreground" />
            <span className="text-success font-medium">Commission</span>
          </p>
        </div>
        <div className="flex gap-3">
          <Link href="/client/commission_payouts" passHref>
            <Button
              variant="outline"
              className="gap-2 border-blue-500/30 text-success hover:bg-success/10 hover:text-blue-300 shadow-lg shadow-blue-900/10"
            >
              <Wallet className="w-4 h-4" />
              Commission Advances
            </Button>
          </Link>
          <Button
            id="simulate-meta-lead-btn"
            onClick={simulateLead}
            disabled={isSimulating}
            className="gap-2 bg-blue-600 hover:bg-brand/100 text-white shadow-lg shadow-blue-900/40"
          >
            <Facebook className="w-4 h-4" />
            {isSimulating ? t("leads.simulating", { defaultValue: "Simulating..." }) : t("leads.simulate_meta_ad", { defaultValue: "Simulate Meta Ad Lead" })}
          </Button>
        </div>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-2 xl:grid-cols-4 gap-4">
        <StatCard label={t("deals.total_leads", { defaultValue: "Total Leads" })} value={total} ring="ring-slate-700/50" />
        <StatCard label={t("deals.new_today", { defaultValue: "New" })} value={newCnt} ring="ring-blue-700/40" />
        <StatCard label={t("deals.conversion_rate", { defaultValue: "Conversion" })} value={`${convRate}%`} sub={`${wonCnt} closed`} ring="ring-blue-700/40" />
        <StatCard label={t("deals.pipeline_value", { defaultValue: "Pipeline Value" })} value={`$${pipelineValue.toFixed(1)}M`} sub={t("deals.estimated", { defaultValue: "est." })} ring="ring-violet-700/40" />
      </div>

      {/* Kanban */}
      {isLoading ? (
        <div className="flex items-center justify-center h-64">
          <div className="w-8 h-8 border-2 border-blue-500 border-t-transparent rounded-full animate-spin" />
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-6">
          {STATUS_COLUMNS.map(col => {
            const colLeads = leads.filter(l => l.status === col.key);
            return (
              <div key={col.key} className="space-y-3">
                <div className={`flex items-center justify-between rounded-lg px-3 py-2 ${col.colorBg} border border-border/60`}>
                  <span className="flex items-center gap-2 font-semibold text-sm text-foreground">
                    <col.Icon className="w-4 h-4" />
                    {t(`deals.col_${col.key.toLowerCase()}`, { defaultValue: col.label })}
                  </span>
                  <Badge className={`text-[10px] px-1.5 py-0 border-0 ${col.colorBadge}`}>{colLeads.length}</Badge>
                </div>

                <div className="space-y-3 min-h-[180px]">
                  {colLeads.map(lead => (
                    <LeadCard
                      key={lead.id}
                      lead={lead}
                      onAdvance={lead.status === "NEW" ? advanceToContacted : undefined}
                      onCloseDeal={lead.status !== "QUALIFIED" && lead.status !== "LOST" ? closeDeal : undefined}
                    />
                  ))}
                  {colLeads.length === 0 && (
                    <div className="flex flex-col items-center justify-center h-28 border border-dashed border-border rounded-xl text-muted-foreground text-xs gap-2">
                      <BarChart3 className="w-5 h-5" />
                      {t("deals.empty_col", { defaultValue: "No leads" })}
                    </div>
                  )}
                </div>
              </div>
            );
          })}
        </div>
      )}

      {/* Flow legend */}
      <div className="flex items-center gap-2 text-xs text-muted-foreground justify-center flex-wrap pt-4 border-t border-slate-900">
        <TrendingUp className="w-3.5 h-3.5 text-muted-foreground" />
        {["Meta Ads", "AI Reel Creative", "Lead Capture", "Deal Close", "Commission Engine"].map((step, i, arr) => (
          <span key={step} className="flex items-center gap-2">
            <span className={i === arr.length - 1 ? "text-success font-semibold" : "text-muted-foreground"}>{step}</span>
            {i < arr.length - 1 && <ChevronRight className="w-3 h-3 text-foreground" />}
          </span>
        ))}
      </div>
    </div>
  );
}
