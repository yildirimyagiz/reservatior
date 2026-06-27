import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { useToast } from "@/hooks/use-toast";
import { RefreshCw, Eye, TrendingUp, TrendingDown, Minus } from "lucide-react";
interface LeadScore {
  id: string;
  leadName: string;
  email: string;
  score: number;
  scoreLabel: "HOT" | "WARM" | "COLD";
  confidence: number;
  factors: {
    label: string;
    impact: "positive" | "negative" | "neutral";
    weight: number;
  }[];
  lastUpdated: string;
  predictedConversion: number;
}
const SCORE_STYLES = {
  HOT: {
    cls: "bg-red-100 text-red-700",
    icon: TrendingUp
  },
  WARM: {
    cls: "bg-orange-100 text-orange-700",
    icon: Minus
  },
  COLD: {
    cls: "bg-blue-100 text-blue-700",
    icon: TrendingDown
  }
};
const MOCK: LeadScore[] = [{
  id: "1",
  leadName: "James Peterson",
  email: "james@company.com",
  score: 92,
  scoreLabel: "HOT",
  confidence: 0.94,
  predictedConversion: 0.78,
  lastUpdated: "2025-01-10 08:30",
  factors: [{
    label: t("admin.ai.multiple_property_views"),
    impact: "positive",
    weight: 0.3
  }, {
    label: t("admin.ai.budget_match"),
    impact: "positive",
    weight: 0.4
  }, {
    label: t("admin.ai.responded_within_1h"),
    impact: "positive",
    weight: 0.2
  }]
}, {
  id: "2",
  leadName: "Linda Zhang",
  email: "linda@corp.com",
  score: 71,
  scoreLabel: "WARM",
  confidence: 0.82,
  predictedConversion: 0.45,
  lastUpdated: "2025-01-10 07:15",
  factors: [{
    label: t("admin.ai.viewed_3_listings"),
    impact: "positive",
    weight: 0.25
  }, {
    label: t("admin.ai.opened_5_emails"),
    impact: "positive",
    weight: 0.2
  }, {
    label: t("admin.ai.no_call_response"),
    impact: "negative",
    weight: -0.15
  }]
}, {
  id: "3",
  leadName: "Mark Williams",
  email: "mark@email.com",
  score: 34,
  scoreLabel: "COLD",
  confidence: 0.76,
  predictedConversion: 0.12,
  lastUpdated: "2025-01-09 15:00",
  factors: [{
    label: t("admin.ai.inactive_30_days"),
    impact: "negative",
    weight: -0.4
  }, {
    label: t("admin.ai.low_budget_fit"),
    impact: "negative",
    weight: -0.3
  }]
}, {
  id: "4",
  leadName: "Sara O'Brien",
  email: "sara@business.com",
  score: 85,
  scoreLabel: "HOT",
  confidence: 0.89,
  predictedConversion: 0.67,
  lastUpdated: "2025-01-10 09:00",
  factors: [{
    label: t("admin.ai.mortgage_preapproved"),
    impact: "positive",
    weight: 0.5
  }, {
    label: t("admin.ai.requested_3_viewings"),
    impact: "positive",
    weight: 0.3
  }]
}];
export default function AILeadScoring() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [search, setSearch] = useState("");
  const [filterLabel, setFilterLabel] = useState("all");
  const [detailOpen, setDetailOpen] = useState(false);
  const [selected, setSelected] = useState<LeadScore | null>(null);
  const [rerunning, setRerunning] = useState(false);
  const filtered = MOCK.filter(l => {
    const m = `${l.leadName} ${l.email}`.toLowerCase().includes(search.toLowerCase());
    return m && (filterLabel === "all" || l.scoreLabel === filterLabel);
  });
  const handleRerun = async () => {
    setRerunning(true);
    await new Promise(r => setTimeout(r, 1500));
    setRerunning(false);
    toast({
      title: t("admin.ai.scoring_updated"),
      description: t("admin.ai.ai_rescored_all_leads")
    });
  };
  const ScoreBar = ({
    score
  }: {
    score: number;
  }) => <div className="flex items-center gap-2">
      <div className="h-1.5 w-20 bg-muted rounded-full overflow-hidden">
        <div className={`h-full rounded-full transition-all ${score >= 75 ? "bg-red-500" : score >= 50 ? "bg-orange-500" : "bg-blue-400"}`} style={{
        width: `${score}%`
      }} />
      </div>
      <span className="text-sm font-semibold w-6 text-right">{score}</span>
    </div>;
  return <>
      <PageShell title={t("admin.ai.ai_lead_scoring")} description={t("admin.ai.machine_learningpowered_lead_prioritization")} searchValue={search} onSearchChange={setSearch} searchPlaceholder={t("admin.ai.search_leads", "Müşteri adaylarında ara...")} actions={<Button variant="outline" size="sm" onClick={handleRerun} disabled={rerunning}>
            <RefreshCw className={`w-4 h-4 mr-1.5 ${rerunning ? "animate-spin" : ""}`} />
            {rerunning ? "Scoring..." : "Re-score All"}
          </Button>} stats={[{
      label: t("admin.ai.scored_leads"),
      value: MOCK.length
    }, {
      label: t("admin.ai.hot_leads"),
      value: MOCK.filter(l => l.scoreLabel === "HOT").length
    }, {
      label: t("admin.ai.avg_score"),
      value: Math.round(MOCK.reduce((s, l) => s + l.score, 0) / MOCK.length)
    }, {
      label: t("admin.ai.avg_conversion"),
      value: `${Math.round(MOCK.reduce((s, l) => s + l.predictedConversion, 0) / MOCK.length * 100)}%`
    }]} filters={<Select value={filterLabel} onValueChange={setFilterLabel}>
            <SelectTrigger className="w-32"><SelectValue placeholder={t("admin.ai.score")} /></SelectTrigger>
            <SelectContent>
              <SelectItem value="all">{t("admin.ai.all")}</SelectItem>
              <SelectItem value="HOT">{t("admin.ai.hot")}</SelectItem>
              <SelectItem value="WARM">{t("admin.ai.warm")}</SelectItem>
              <SelectItem value="COLD">{t("admin.ai.cold")}</SelectItem>
            </SelectContent>
          </Select>}>
        <div className="bg-card border border-border rounded-xl overflow-hidden">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>{t("admin.ai.lead")}</TableHead>
                <TableHead>{t("admin.ai.score")}</TableHead>
                <TableHead>{t("admin.ai.label")}</TableHead>
                <TableHead>{t("admin.ai.confidence")}</TableHead>
                <TableHead>{t("admin.ai.conversion_prob")}</TableHead>
                <TableHead>{t("admin.ai.last_updated")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {filtered.length === 0 && <TableRow><TableCell colSpan={7} className="text-center py-12 text-muted-foreground">{t("admin.ai.no_scored_leads")}</TableCell></TableRow>}
              {filtered.map(l => {
              const s = SCORE_STYLES[l.scoreLabel];
              const SIcon = s.icon;
              return <TableRow key={l.id} className="hover:bg-muted/40">
                    <TableCell>
                      <p className="text-sm font-medium">{l.leadName}</p>
                      <p className="text-xs text-muted-foreground">{l.email}</p>
                    </TableCell>
                    <TableCell><ScoreBar score={l.score} /></TableCell>
                    <TableCell><Badge className={`${s.cls} border-0 text-xs`}><SIcon className="w-3 h-3 mr-1" />{l.scoreLabel}</Badge></TableCell>
                    <TableCell>
                      <div className="flex items-center gap-1.5">
                        <div className="h-1.5 w-16 bg-muted rounded-full overflow-hidden">
                          <div className="h-full bg-violet-500 rounded-full" style={{
                        width: `${l.confidence * 100}%`
                      }} />
                        </div>
                        <span className="text-xs text-muted-foreground">{Math.round(l.confidence * 100)}%</span>
                      </div>
                    </TableCell>
                    <TableCell>
                      <span className={`text-sm font-semibold ${l.predictedConversion >= 0.6 ? "text-green-600" : l.predictedConversion >= 0.3 ? "text-orange-600" : "text-muted-foreground"}`}>
                        {Math.round(l.predictedConversion * 100)}%
                      </span>
                    </TableCell>
                    <TableCell className="text-xs text-muted-foreground">{l.lastUpdated}</TableCell>
                    <TableCell>
                      <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => {
                    setSelected(l);
                    setDetailOpen(true);
                  }}>
                        <Eye className="w-4 h-4" />
                      </Button>
                    </TableCell>
                  </TableRow>;
            })}
            </TableBody>
          </Table>
        </div>
      </PageShell>

      <Dialog open={detailOpen} onOpenChange={setDetailOpen}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader>
            <DialogTitle>{t("admin.ai.score_breakdown")}</DialogTitle>
            <DialogDescription>{selected?.leadName} — {selected?.email}</DialogDescription>
          </DialogHeader>
          {selected && <div className="space-y-5 py-2">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-xl font-bold">{selected.score}</p>
                  <p className="text-sm text-muted-foreground">/ 100 score</p>
                </div>
                <div className="text-right">
                  <p className="text-2xl font-bold text-green-600">{Math.round(selected.predictedConversion * 100)}%</p>
                  <p className="text-sm text-muted-foreground">{t("admin.ai.conversion_prob")}</p>
                </div>
              </div>
              <div>
                <p className="text-xs font-semibold text-muted-foreground tracking-wider mb-2">{t("admin.ai.scoring_factors")}</p>
                <div className="space-y-2">
                  {selected.factors.map((f, i) => <div key={i} className="flex items-center justify-between gap-3 p-2.5 rounded-lg bg-muted/40">
                      <div className="flex items-center gap-2">
                        {f.impact === "positive" ? <TrendingUp className="w-3.5 h-3.5 text-green-500" /> : f.impact === "negative" ? <TrendingDown className="w-3.5 h-3.5 text-red-500" /> : <Minus className="w-3.5 h-3.5 text-muted-foreground" />}
                        <span className="text-sm">{f.label}</span>
                      </div>
                      <span className={`text-sm font-semibold ${f.weight > 0 ? "text-green-600" : f.weight < 0 ? "text-red-600" : "text-muted-foreground"}`}>
                        {f.weight > 0 ? "+" : ""}{Math.round(f.weight * 100)}{t("admin.ai.pts")}</span>
                    </div>)}
                </div>
              </div>
            </div>}
        </DialogContent>
      </Dialog>
    </>;
}