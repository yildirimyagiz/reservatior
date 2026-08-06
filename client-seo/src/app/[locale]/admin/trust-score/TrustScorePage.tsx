"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  Shield,
  Search,
  Plus,
  ArrowUpRight,
  ChevronRight,
  TrendingUp,
  BarChart3,
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

interface TrustScore {
  id: string;
  entityType: "TENANT" | "LANDLORD" | "AGENT" | "PROPERTY" | "ORGANIZATION";
  entityId: string;
  entityName: string;
  score: number;
  tier: "BRONZE" | "SILVER" | "GOLD" | "PLATINUM" | "DIAMOND";
  confidence: number;
  factors: ScoreFactor[];
  lastUpdated: string;
}

interface ScoreFactor {
  name: string;
  value: number;
  max: number;
}

const mockScores: TrustScore[] = [
  {
    id: "1", entityType: "TENANT", entityId: "T-301", entityName: "Ahmet Yilmaz",
    score: 87, tier: "GOLD", confidence: 92,
    factors: [
      { name: "Payment History", value: 90, max: 100 },
      { name: "Lease Compliance", value: 85, max: 100 },
      { name: "Background Check", value: 95, max: 100 },
      { name: "Reference Score", value: 80, max: 100 },
      { name: "Credit Rating", value: 88, max: 100 },
    ],
    lastUpdated: "2026-07-10",
  },
  {
    id: "2", entityType: "LANDLORD", entityId: "L-401", entityName: "Mehmet Kaya",
    score: 93, tier: "PLATINUM", confidence: 96,
    factors: [
      { name: "Property Maintenance", value: 95, max: 100 },
      { name: "Response Time", value: 92, max: 100 },
      { name: "Legal Compliance", value: 90, max: 100 },
      { name: "Tenant Satisfaction", value: 96, max: 100 },
    ],
    lastUpdated: "2026-07-12",
  },
  {
    id: "3", entityType: "TENANT", entityId: "T-302", entityName: "Emily Chen",
    score: 72, tier: "SILVER", confidence: 78,
    factors: [
      { name: "Payment History", value: 70, max: 100 },
      { name: "Lease Compliance", value: 75, max: 100 },
      { name: "Background Check", value: 80, max: 100 },
      { name: "Credit Rating", value: 65, max: 100 },
    ],
    lastUpdated: "2026-06-28",
  },
  {
    id: "4", entityType: "AGENT", entityId: "A-501", entityName: "Elite Realty",
    score: 81, tier: "GOLD", confidence: 85,
    factors: [
      { name: "Transaction Volume", value: 85, max: 100 },
      { name: "Client Rating", value: 80, max: 100 },
      { name: "Compliance", value: 90, max: 100 },
      { name: "Response Time", value: 75, max: 100 },
    ],
    lastUpdated: "2026-07-05",
  },
  {
    id: "5", entityType: "PROPERTY", entityId: "P-201", entityName: "Beyoglu Apartment",
    score: 65, tier: "SILVER", confidence: 70,
    factors: [
      { name: "Condition", value: 70, max: 100 },
      { name: "Location Score", value: 85, max: 100 },
      { name: "Documentation", value: 55, max: 100 },
      { name: "Insurance", value: 50, max: 100 },
    ],
    lastUpdated: "2026-07-01",
  },
  {
    id: "6", entityType: "ORGANIZATION", entityId: "O-601", entityName: "Reservatior GmbH",
    score: 95, tier: "DIAMOND", confidence: 98,
    factors: [
      { name: "Financial Stability", value: 98, max: 100 },
      { name: "Compliance", value: 95, max: 100 },
      { name: "Reputation", value: 92, max: 100 },
      { name: "Track Record", value: 96, max: 100 },
    ],
    lastUpdated: "2026-07-15",
  },
];

const TIER_COLORS: Record<string, string> = {
  BRONZE: "bg-orange-600/20 text-warning",
  SILVER: "bg-gray-400/20 text-gray-300",
  GOLD: "bg-yellow-500/20 text-yellow-400",
  PLATINUM: "bg-cyan-400/20 text-cyan-300",
  DIAMOND: "bg-brand/20 text-brand",
};

const ENTITY_COLORS: Record<string, string> = {
  TENANT: "bg-blue-500/20 text-info",
  LANDLORD: "bg-blue-500/20 text-blue-400",
  AGENT: "bg-orange-500/20 text-warning",
  PROPERTY: "bg-brand/20 text-brand",
  ORGANIZATION: "bg-cyan-500/20 text-cyan-400",
};

function getScoreColor(score: number): string {
  if (score >= 90) return "text-blue-400";
  if (score >= 75) return "text-info";
  if (score >= 60) return "text-yellow-400";
  if (score >= 40) return "text-warning";
  return "text-red-400";
}

export default function TrustScorePage() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");
  const [entityFilter, setEntityFilter] = useState<string>("ALL");
  const [tierFilter, setTierFilter] = useState<string>("ALL");
  const [items] = useState<TrustScore[]>(mockScores);
  const [expandedItem, setExpandedItem] = useState<TrustScore | null>(null);
  const [isEventOpen, setIsEventOpen] = useState(false);

  const filtered = items.filter((s) => {
    const matchesSearch = s.entityName.toLowerCase().includes(searchTerm.toLowerCase()) || s.entityId.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesEntity = entityFilter === "ALL" || s.entityType === entityFilter;
    const matchesTier = tierFilter === "ALL" || s.tier === tierFilter;
    return matchesSearch && matchesEntity && matchesTier;
  });

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8">
        <m.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} className="mb-8">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-foreground mb-2">{t("admin_trust_title", "Güven Puanları")}</h1>
              <p className="text-muted-foreground">{t("admin_trust_description", "Varlık güven puanlarını, itibar sinyallerini ve puan dağılımlarını izleyin")}</p>
            </div>
            <Button className="bg-primary hover:bg-primary/90">
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin_trust_back_to_dashboard", "Panele Dön")}
            </Button>
          </div>
        </m.div>

        {/* Summary Cards */}
        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1 }} className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-blue-500/10"><Shield className="w-5 h-5 text-blue-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_trust_total_entities", "Toplam Varlık")}</p>
                  <p className="text-2xl font-bold text-foreground">{items.length}</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-blue-500/10"><TrendingUp className="w-5 h-5 text-blue-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_trust_avg_score", "Ort. Puan")}</p>
                  <p className="text-2xl font-bold text-foreground">{Math.round(items.reduce((sum, s) => sum + s.score, 0) / items.length)}</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-brand/10"><BarChart3 className="w-5 h-5 text-brand" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_trust_avg_confidence", "Ort. Güven")}</p>
                  <p className="text-2xl font-bold text-foreground">{Math.round(items.reduce((sum, s) => sum + s.confidence, 0) / items.length)}%</p>
                </div>
              </div>
            </CardContent>
          </Card>
        </m.div>

        {/* Search and Filter */}
        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.15 }} className="mb-6">
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex gap-4 flex-wrap">
                <div className="flex-1 min-w-[200px]">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                    <Input
                      placeholder={t("admin_trust_search_placeholder", "Varlık ara...")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors placeholder:text-muted-foreground"
                    />
                  </div>
                </div>
                <Select value={entityFilter} onValueChange={setEntityFilter}>
                  <SelectTrigger className="w-[180px] bg-white/5 border-white/10 text-foreground">
                    <SelectValue placeholder={t("admin_trust_entity_type", "Varlık Türü")} />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="ALL">{t("admin_trust_all_entities", "Tüm Varlıklar")}</SelectItem>
                    <SelectItem value="TENANT">{t("admin_trust_entity_tenant", "Kiracı")}</SelectItem>
                    <SelectItem value="LANDLORD">{t("admin_trust_entity_landlord", "Ev Sahibi")}</SelectItem>
                    <SelectItem value="AGENT">{t("admin_trust_entity_agent", "Emlakçı")}</SelectItem>
                    <SelectItem value="PROPERTY">{t("admin_trust_entity_property", "Mülk")}</SelectItem>
                    <SelectItem value="ORGANIZATION">{t("admin_trust_entity_organization", "Kuruluş")}</SelectItem>
                  </SelectContent>
                </Select>
                <Select value={tierFilter} onValueChange={setTierFilter}>
                  <SelectTrigger className="w-[180px] bg-white/5 border-white/10 text-foreground">
                    <SelectValue placeholder={t("admin_trust_tier", "Seviye")} />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="ALL">{t("admin_trust_all_tiers", "Tüm Seviyeler")}</SelectItem>
                    <SelectItem value="BRONZE">{t("admin_trust_tier_bronze", "Bronz")}</SelectItem>
                    <SelectItem value="SILVER">{t("admin_trust_tier_silver", "Gümüş")}</SelectItem>
                    <SelectItem value="GOLD">{t("admin_trust_tier_gold", "Altın")}</SelectItem>
                    <SelectItem value="PLATINUM">{t("admin_trust_tier_platinum", "Platin")}</SelectItem>
                    <SelectItem value="DIAMOND">{t("admin_trust_tier_diamond", "Elmas")}</SelectItem>
                  </SelectContent>
                </Select>
                <Button onClick={() => setIsEventOpen(true)} className="bg-primary hover:bg-primary/90">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin_trust_record_event", "Olay Kaydet")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </m.div>

        {/* Score Cards */}
        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            {filtered.map((score) => (
              <Card key={score.id} className="bg-card border-border hover:bg-muted/30 transition-colors cursor-pointer" onClick={() => setExpandedItem(expandedItem?.id === score.id ? null : score)}>
                <CardContent className="p-5">
                  <div className="flex items-start justify-between mb-4">
                    <div>
                      <Badge className={ENTITY_COLORS[score.entityType]}>{score.entityType}</Badge>
                      <h2 className="text-foreground font-semibold mt-2">{score.entityName}</h2>
                      <p className="text-xs text-muted-foreground">{score.entityId}</p>
                    </div>
                    <div className="text-right">
                      <div className={`text-3xl font-bold ${getScoreColor(score.score)}`}>{score.score}</div>
                      <Badge className={TIER_COLORS[score.tier]}>{score.tier}</Badge>
                    </div>
                  </div>
                  <div className="space-y-2">
                    <div className="flex justify-between text-xs">
                      <span className="text-muted-foreground">{t("admin_trust_confidence", "Güven")}</span>
                      <span className="text-foreground">{score.confidence}%</span>
                    </div>
                    <div className="h-1.5 bg-muted/50 rounded-full overflow-hidden">
                      <div className="h-full bg-primary rounded-full transition-all" style={{ width: `${score.confidence}%` }} />
                    </div>
                  </div>
                  <div className="flex items-center justify-between mt-3 pt-3 border-t border-border/50">
                    <span className="text-xs text-muted-foreground">{t("admin_trust_updated", "Güncellendi")}: {score.lastUpdated}</span>
                    <ChevronRight className={`w-4 h-4 text-muted-foreground transition-transform ${expandedItem?.id === score.id ? "rotate-90" : ""}`} />
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        </m.div>

        {/* Expanded Breakdown */}
        {expandedItem && (
          <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} className="mt-6">
            <Card className="bg-card border-border">
              <CardHeader>
                <CardTitle className="text-foreground flex items-center gap-2">
                  <BarChart3 className="w-5 h-5" />
                  {t("admin_trust_score_breakdown", "Puan Dağılımı")} - {expandedItem.entityName}
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                  {expandedItem.factors.map((factor, idx) => {
                    const pct = Math.round((factor.value / factor.max) * 100);
                    return (
                      <div key={idx} className="p-4 bg-muted/30 rounded-lg">
                        <div className="flex justify-between mb-2">
                          <span className="text-sm text-foreground font-medium">{factor.name}</span>
                          <span className={`text-sm font-bold ${getScoreColor(pct)}`}>{factor.value}/{factor.max}</span>
                        </div>
                        <div className="h-2 bg-muted/50 rounded-full overflow-hidden">
                          <div className={`h-full rounded-full transition-all ${pct >= 80 ? "bg-blue-500" : pct >= 60 ? "bg-blue-500" : pct >= 40 ? "bg-yellow-500" : "bg-red-500"}`} style={{ width: `${pct}%` }} />
                        </div>
                      </div>
                    );
                  })}
                </div>
              </CardContent>
            </Card>
          </m.div>
        )}

        {/* Record Event Dialog */}
        <Dialog open={isEventOpen} onOpenChange={setIsEventOpen}>
          <DialogContent className="sm:max-w-[500px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground max-h-[90vh] overflow-y-auto">
            <DialogHeader>
              <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_trust_record_event_title", "Güven Olayı Kaydet")}</DialogTitle>
              <DialogDescription className="text-muted-foreground">{t("admin_trust_record_event_desc", "Bu varlık için yeni bir güven sinyali olayı kaydedin")}</DialogDescription>
            </DialogHeader>
            <div className="grid gap-4 py-4">
              <div className="grid grid-cols-4 items-center gap-4">
                <Label className="text-right text-foreground">{t("admin_trust_entity_type", "Varlık Türü")}</Label>
                <Select defaultValue="TENANT">
                  <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="TENANT">{t("admin_trust_entity_tenant", "Kiracı")}</SelectItem>
                    <SelectItem value="LANDLORD">{t("admin_trust_entity_landlord", "Ev Sahibi")}</SelectItem>
                    <SelectItem value="AGENT">{t("admin_trust_entity_agent", "Emlakçı")}</SelectItem>
                    <SelectItem value="PROPERTY">{t("admin_trust_entity_property", "Mülk")}</SelectItem>
                    <SelectItem value="ORGANIZATION">{t("admin_trust_entity_organization", "Kuruluş")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="grid grid-cols-4 items-center gap-4">
                <Label className="text-right text-foreground">{t("admin_trust_event_type", "Olay Türü")}</Label>
                <Select defaultValue="PAYMENT_RECEIVED">
                  <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="PAYMENT_RECEIVED">{t("admin_trust_event_payment_received", "Ödeme Alındı")}</SelectItem>
                    <SelectItem value="PAYMENT_MISSED">{t("admin_trust_event_payment_missed", "Ödeme Kaçırıldı")}</SelectItem>
                    <SelectItem value="COMPLAINT_FILED">{t("admin_trust_event_complaint_filed", "Şikayet Yapıldı")}</SelectItem>
                    <SelectItem value="COMPLAINT_RESOLVED">{t("admin_trust_event_complaint_resolved", "Şikayet Çözüldü")}</SelectItem>
                    <SelectItem value="VERIFICATION_PASSED">{t("admin_trust_event_verification_passed", "Doğrulama Başarılı")}</SelectItem>
                    <SelectItem value="SCORE_BOOST">{t("admin_trust_event_score_boost", "Puan Artışı")}</SelectItem>
                    <SelectItem value="SCORE_PENALTY">{t("admin_trust_event_score_penalty", "Puan Cezası")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="grid grid-cols-4 items-center gap-4">
                <Label className="text-right text-foreground">{t("admin_trust_impact", "Etki")}</Label>
                <Input type="number" placeholder={t("admin_trust_impact_placeholder", "± puan etkisi")} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
              </div>
              <div className="grid grid-cols-4 items-center gap-4">
                <Label className="text-right text-foreground">{t("admin_trust_notes", "Notlar")}</Label>
                <Input placeholder={t("admin_trust_notes_placeholder", "İsteğe bağlı notlar...")} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
              </div>
            </div>
            <DialogFooter className="pt-4 border-t border-white/10">
              <Button variant="outline" onClick={() => setIsEventOpen(false)} className="border-border text-foreground">{t("admin_action_cancel", "İptal")}</Button>
              <Button onClick={() => setIsEventOpen(false)} className="bg-primary hover:bg-primary/90">{t("admin_trust_record", "Kaydet")}</Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>
      </div>
    </div>
  );
}
