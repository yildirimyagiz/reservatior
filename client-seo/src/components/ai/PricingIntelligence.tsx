"use client";

import { useState, useEffect } from "react";
import {
  Sparkles, TrendingUp, TrendingDown, BarChart3, Clock, Target, Brain, Shield,
  ArrowUp, ArrowDown, Minus,
} from "lucide-react";
import { pricingIntelligenceApi } from "@/lib/api/pricing-intelligence";

interface PricingIntelligenceProps {
  listingId: string;
  currentPrice: number;
  currency: string;
}

type Tab = "overview" | "elasticity" | "timeline" | "opportunity";

interface ConfidenceData { score: number; reasons: string[]; }
interface PriceTrend { direction: "UP" | "DOWN" | "STABLE"; percentage: number; }
interface PriceData { current: number; recommended: number; min: number; max: number; trend: PriceTrend; }
interface KeyMetrics { timeToRent: string; optimalRevenue: number; marketHeat: string; opportunityScore: number; }
interface DemandPoint { price: number; demand: number; isOptimal: boolean; }
interface ElasticityData { demandCurve: DemandPoint[]; coefficient: number; optimalPrice: number; optimalRevenue: number; }
interface TimelineItem { day: number; action: string; impact: string; priority: "high" | "medium" | "low"; }
interface OpportunityData { score: number; recommendation: "BUY" | "SELL" | "HOLD"; rationale: string; marketHeatIndex: number; marketHeatClassification: "COLD" | "COOL" | "WARM" | "HOT" | "BOILING"; }

function formatCurrency(v: number, currency: string) {
  return new Intl.NumberFormat("en-US", { style: "currency", currency, maximumFractionDigits: 0 }).format(v);
}

const defaultPriceData: PriceData = { current: 0, recommended: 0, min: 0, max: 0, trend: { direction: "STABLE", percentage: 0 } };
const defaultConfidence: ConfidenceData = { score: 0, reasons: [] };
const defaultElasticity: ElasticityData = { demandCurve: [], coefficient: 0, optimalPrice: 0, optimalRevenue: 0 };
const defaultTimeline: TimelineItem[] = [
  { day: 1, action: "Run AI valuation", impact: "Accurate pricing baseline", priority: "high" },
  { day: 7, action: "Review market comparables", impact: "Market positioning", priority: "medium" },
  { day: 14, action: "Adjust price based on feedback", impact: "Optimized time-to-rent", priority: "medium" },
];
const defaultOpportunity: OpportunityData = { score: 50, recommendation: "HOLD", rationale: "Insufficient data", marketHeatIndex: 50, marketHeatClassification: "WARM" };
const defaultMetrics: KeyMetrics = { timeToRent: "--", optimalRevenue: 0, marketHeat: "--", opportunityScore: 0 };

const GaugeSvg = ({ value, max, label, color }: { value: number; max: number; label: string; color: string }) => {
  const pct = Math.min(value / max, 1);
  const dashArray = 2 * Math.PI * 40;
  const dashOffset = dashArray * (1 - pct);
  return (
    <div className="flex flex-col items-center">
      <svg width="100" height="60" viewBox="0 0 100 60">
        <path d="M10 50 A40 40 0 0 1 90 50" fill="none" stroke="#1e293b" strokeWidth="6" strokeLinecap="round" />
        <path d="M10 50 A40 40 0 0 1 90 50" fill="none" stroke={color} strokeWidth="6" strokeLinecap="round" strokeDasharray={dashArray} strokeDashoffset={dashOffset} />
        <text x="50" y="50" textAnchor="middle" fill="#fff" fontSize="14" fontWeight="bold">{Math.round(pct * 100)}%</text>
      </svg>
      <span className="text-xs text-slate-400 mt-1">{label}</span>
    </div>
  );
};

function PricingIntelligenceComponent({ listingId, currentPrice, currency }: PricingIntelligenceProps) {
  const [tab, setTab] = useState<Tab>("overview");
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [priceData, setPriceData] = useState<PriceData>(defaultPriceData);
  const [confidence, setConfidence] = useState<ConfidenceData>(defaultConfidence);
  const [metrics, setMetrics] = useState<KeyMetrics>(defaultMetrics);
  const [elasticity, setElasticity] = useState<ElasticityData>(defaultElasticity);
  const [timeline, setTimeline] = useState<TimelineItem[]>(defaultTimeline);
  const [opportunity, setOpportunity] = useState<OpportunityData>(defaultOpportunity);

  useEffect(() => {
    let cancelled = false;
    setLoading(true);
    setError(null);

    pricingIntelligenceApi.generatePrediction({ propertyId: listingId, countryCode: "US", currency })
      .then((res: any) => {
        if (cancelled) return;
        const d = res.data || res;
        const p = d.predictedPrice || {};
        const c = d.confidence || {};
        const e = d.elasticity || {};
        const o = d.opportunity || {};
        const mh = d.marketHeat || {};
        const liq = d.liquidity || {};
        const r = d.revenueOptimization || {};

        setPriceData({
          current: p.current ?? currentPrice,
          recommended: p.recommended ?? currentPrice,
          min: p.min ?? currentPrice * 0.85,
          max: p.max ?? currentPrice * 1.15,
          trend: { direction: p.trend || "STABLE", percentage: 0 },
        });

        setConfidence({ score: c.score ?? 0.5, reasons: c.reasons ?? ["AI analysis pending"] });
        setMetrics({
          timeToRent: liq.timeToRent ? `${liq.timeToRent} days` : "--",
          optimalRevenue: r.optimalRevenue ?? r.netOperatingIncome ?? 0,
          marketHeat: mh.classification || "BALANCED",
          opportunityScore: o.score ?? 50,
        });
        setElasticity({
          demandCurve: (e.demandCurve || []).map((dp: any) => ({ ...dp, isOptimal: dp.price === e.optimalPrice })),
          coefficient: e.elasticityCoefficient ?? -0.8,
          optimalPrice: e.optimalPrice ?? p.recommended ?? currentPrice,
          optimalRevenue: e.optimalRevenue ?? 0,
        });
        setTimeline((d.advisoryTimeline || []).map((item: any) => ({
          day: item.day, action: item.action, impact: item.impact, priority: item.priority?.toLowerCase() || "medium",
        })));
        setOpportunity({
          score: o.score ?? 50,
          recommendation: o.type || "HOLD",
          rationale: o.rationale || "Analysis pending",
          marketHeatIndex: mh.index ?? 50,
          marketHeatClassification: (mh.classification || "WARM") as any,
        });
      })
      .catch((err: any) => {
        if (cancelled) return;
        setError(err.message || "Failed to load pricing data");
      })
      .finally(() => { if (!cancelled) setLoading(false); });

    return () => { cancelled = true; };
  }, [listingId, currentPrice, currency]);

  const renderTrend = () => {
    const { direction, percentage } = priceData.trend;
    if (direction === "UP") return <span className="flex items-center gap-1 text-blue-400"><ArrowUp className="w-4 h-4" />{percentage > 0 ? `${percentage}%` : "Rising"}</span>;
    if (direction === "DOWN") return <span className="flex items-center gap-1 text-red-400"><ArrowDown className="w-4 h-4" />{percentage > 0 ? `${percentage}%` : "Declining"}</span>;
    return <span className="flex items-center gap-1 text-slate-400"><Minus className="w-4 h-4" />Stable</span>;
  };

  if (loading) {
    return <div className="bg-slate-900/60 rounded-2xl border border-slate-800 p-6 text-center text-slate-400">Loading pricing intelligence...</div>;
  }

  if (error) {
    return <div className="bg-slate-900/60 rounded-2xl border border-slate-800 p-6">
      <div className="text-center text-red-400 mb-4">{error}</div>
      <div className="text-sm text-slate-500 text-center">Showing fallback estimates</div>
    </div>;
  }

  const tabs: { key: Tab; label: string; icon: any }[] = [
    { key: "overview", label: "Overview", icon: Sparkles },
    { key: "elasticity", label: "Price Elasticity", icon: BarChart3 },
    { key: "timeline", label: "Advisory Timeline", icon: Clock },
    { key: "opportunity", label: "Opportunity Score", icon: Target },
  ];

  return (
    <div className="bg-slate-900/60 rounded-2xl border border-slate-800 overflow-hidden">
      <div className="flex border-b border-slate-800">
        {tabs.map(({ key, label, icon: Icon }) => (
          <button key={key} onClick={() => setTab(key)}
            className={`flex-1 flex items-center justify-center gap-2 py-3 text-sm font-medium transition-colors ${tab === key ? "text-blue-400 border-b-2 border-blue-400 bg-blue-500/5" : "text-slate-500 hover:text-slate-300"}`}>
            <Icon className="w-4 h-4" />{label}
          </button>
        ))}
      </div>

      <div className="p-6">
        {tab === "overview" && (
          <div className="space-y-6">
            <div className="bg-gradient-to-br from-blue-500/10 to-blue-500/5 rounded-xl p-5 border border-blue-500/20">
              <div className="flex items-center gap-2 mb-4">
                <Brain className="w-5 h-5 text-blue-400" />
                <span className="font-bold text-white">AI Price Prediction</span>
                {renderTrend()}
              </div>
              <div className="grid grid-cols-3 gap-4">
                <div>
                  <p className="text-xs text-slate-400">Current</p>
                  <p className="text-lg font-bold text-white">{formatCurrency(priceData.current, currency)}</p>
                </div>
                <div>
                  <p className="text-xs text-slate-400">Recommended</p>
                  <p className="text-lg font-bold text-blue-400">{formatCurrency(priceData.recommended, currency)}</p>
                </div>
                <div>
                  <p className="text-xs text-slate-400">Range</p>
                  <p className="text-sm font-bold text-white">{formatCurrency(priceData.min, currency)} – {formatCurrency(priceData.max, currency)}</p>
                </div>
              </div>
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="bg-slate-800/50 rounded-xl p-4">
                <div className="flex items-center gap-2 mb-3">
                  <Shield className="w-4 h-4 text-blue-400" />
                  <span className="text-sm font-semibold text-white">Confidence</span>
                </div>
                <GaugeSvg value={confidence.score * 100} max={100} label="AI Confidence" color="#60a5fa" />
                <ul className="mt-3 space-y-1">
                  {confidence.reasons.slice(0, 2).map((r, i) => (
                    <li key={i} className="text-xs text-slate-400 flex items-start gap-1">
                      <span className="text-blue-400 mt-0.5">•</span>{r}
                    </li>
                  ))}
                </ul>
              </div>
              <div className="space-y-3">
                <div className="bg-slate-800/50 rounded-xl p-4 flex items-center justify-between">
                  <div className="flex items-center gap-2"><Clock className="w-4 h-4 text-purple-400" /><span className="text-sm text-slate-300">Time to Rent</span></div>
                  <span className="font-bold text-white">{metrics.timeToRent}</span>
                </div>
                <div className="bg-slate-800/50 rounded-xl p-4 flex items-center justify-between">
                  <div className="flex items-center gap-2"><TrendingUp className="w-4 h-4 text-blue-400" /><span className="text-sm text-slate-300">Optimal Revenue</span></div>
                  <span className="font-bold text-white">{formatCurrency(metrics.optimalRevenue, currency)}</span>
                </div>
                <div className="bg-slate-800/50 rounded-xl p-4 flex items-center justify-between">
                  <div className="flex items-center gap-2"><BarChart3 className="w-4 h-4 text-amber-400" /><span className="text-sm text-slate-300">Market Heat</span></div>
                  <span className="font-bold text-white">{metrics.marketHeat}</span>
                </div>
              </div>
            </div>
          </div>
        )}

        {tab === "elasticity" && (
          <div className="space-y-6">
            <div className="bg-slate-800/50 rounded-xl p-4">
              <h3 className="font-bold text-white mb-3 flex items-center gap-2"><BarChart3 className="w-4 h-4 text-blue-400" />Demand Curve</h3>
              <div className="space-y-2">
                {elasticity.demandCurve.map((dp, i) => (
                  <div key={i} className={`flex items-center justify-between p-2 rounded-lg ${dp.isOptimal ? "bg-blue-500/10 border border-blue-500/20" : ""}`}>
                    <span className="text-sm text-slate-300">{formatCurrency(dp.price, currency)}</span>
                    <div className="flex items-center gap-2">
                      <div className="h-2 bg-blue-500/30 rounded" style={{ width: `${dp.demand}px`, maxWidth: "120px" }} />
                      <span className="text-xs text-slate-400 w-8 text-right">{dp.demand}</span>
                    </div>
                    {dp.isOptimal && <span className="text-xs text-blue-400 ml-2">Optimal</span>}
                  </div>
                ))}
              </div>
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div className="bg-slate-800/50 rounded-xl p-4">
                <p className="text-xs text-slate-400">Elasticity Coefficient</p>
                <p className="text-lg font-bold text-white">{elasticity.coefficient.toFixed(2)}</p>
              </div>
              <div className="bg-slate-800/50 rounded-xl p-4">
                <p className="text-xs text-slate-400">Optimal Revenue</p>
                <p className="text-lg font-bold text-blue-400">{formatCurrency(elasticity.optimalRevenue, currency)}</p>
              </div>
            </div>
          </div>
        )}

        {tab === "timeline" && (
          <div className="space-y-3">
            {timeline.map((item, i) => (
              <div key={i} className="bg-slate-800/50 rounded-xl p-4 border-l-4 border-blue-500/50">
                <div className="flex items-center justify-between mb-1">
                  <span className="text-xs text-slate-500">Day {item.day}</span>
                  <span className={`text-xs px-2 py-0.5 rounded-full ${item.priority === "high" ? "bg-red-500/20 text-red-400" : item.priority === "medium" ? "bg-amber-500/20 text-amber-400" : "bg-slate-500/20 text-slate-400"}`}>
                    {item.priority.toUpperCase()}
                  </span>
                </div>
                <p className="text-sm font-semibold text-white">{item.action}</p>
                <p className="text-xs text-slate-400">{item.impact}</p>
              </div>
            ))}
          </div>
        )}

        {tab === "opportunity" && (
          <div className="space-y-6">
            <div className="flex flex-col items-center py-4">
              <GaugeSvg value={opportunity.score} max={100} label="Opportunity Score" color={opportunity.score >= 70 ? "#3b82f6" : opportunity.score >= 40 ? "#f59e0b" : "#ef4444"} />
              <div className={`mt-3 px-4 py-1.5 rounded-full text-sm font-bold ${opportunity.recommendation === "BUY" ? "bg-blue-500/20 text-blue-400" : opportunity.recommendation === "SELL" ? "bg-red-500/20 text-red-400" : "bg-amber-500/20 text-amber-400"}`}>
                {opportunity.recommendation === "BUY" ? "🟢 BUY" : opportunity.recommendation === "SELL" ? "🔴 SELL" : "🟡 HOLD"}
              </div>
            </div>
            <div className="bg-slate-800/50 rounded-xl p-4">
              <p className="text-sm text-slate-300">{opportunity.rationale}</p>
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div className="bg-slate-800/50 rounded-xl p-4">
                <p className="text-xs text-slate-400">Market Heat Index</p>
                <p className="text-lg font-bold text-white">{opportunity.marketHeatIndex}/100</p>
              </div>
              <div className="bg-slate-800/50 rounded-xl p-4">
                <p className="text-xs text-slate-400">Classification</p>
                <p className="text-lg font-bold text-blue-400">{opportunity.marketHeatClassification}</p>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

export { PricingIntelligenceComponent as PricingIntelligence };
export default PricingIntelligenceComponent;
