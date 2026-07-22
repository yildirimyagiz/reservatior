"use client";

import React, { useState, useCallback, useEffect } from "react";
import { commissionRuleEngineApi } from "@/lib/api/pricing-intelligence";

import {
  ChevronDown,
  ChevronUp,
  Shield,
  TrendingUp,
  DollarSign,
  Users,
  Target,
  AlertTriangle,
  CheckCircle,
  XCircle,
  Settings,
  BarChart3,
  FileText,
  Save,
  Layers,
  ArrowRight,
  Gauge,
} from "lucide-react";

/* ------------------------------------------------------------------ */
/*  Types                                                              */
/* ------------------------------------------------------------------ */

interface RuleLayer {
  name: string;
  value: number;
  color: string;
  description: string;
}

interface CommissionRule {
  id: string;
  country: string;
  countryFlag: string;
  agentType: string;
  baseRate: number;
  ceiling: number;
  marketAdjustment: number;
  status: "active" | "inactive" | "pending";
  layers: RuleLayer[];
  appliedRules: string[];
  regulatoryWarning: boolean;
}

interface CountryBreakdown {
  country: string;
  flag: string;
  totalCommissions: number;
  avgRate: number;
  ruleAccuracy: number;
}

interface DefaultRate {
  country: string;
  flag: string;
  rate: number;
}

/* ------------------------------------------------------------------ */
/*  Mock Data                                                          */
/* ------------------------------------------------------------------ */

const mockRules: CommissionRule[] = [
  {
    id: "rule-001",
    country: "Turkey",
    countryFlag: "TR",
    agentType: "OTA Partner",
    baseRate: 12.5,
    ceiling: 18.0,
    marketAdjustment: 1.5,
    status: "active",
    layers: [
      { name: "Country Base", value: 12.5, color: "bg-blue-500", description: "Standard Turkey OTA rate" },
      { name: "Market Adjustment", value: 1.5, color: "bg-emerald-500", description: "High-demand season adjustment" },
      { name: "Agent Type Modifier", value: 0.5, color: "bg-purple-500", description: "OTA Partner bonus tier" },
      { name: "Campaign Incentive", value: -0.5, color: "bg-amber-500", description: "Summer promo deduction" },
      { name: "Volume Incentive", value: 1.0, color: "bg-rose-500", description: "High-volume rebate" },
    ],
    appliedRules: ["Country Base Rule", "Seasonal Market Modifier", "OTA Tier Classification", "Campaign: Summer2026", "Volume Threshold Tier-2"],
    regulatoryWarning: false,
  },
  {
    id: "rule-002",
    country: "United States",
    countryFlag: "US",
    agentType: "Direct Agent",
    baseRate: 10.0,
    ceiling: 15.0,
    marketAdjustment: 0.0,
    status: "active",
    layers: [
      { name: "Country Base", value: 10.0, color: "bg-blue-500", description: "Standard US Direct rate" },
      { name: "Market Adjustment", value: 0.0, color: "bg-emerald-500", description: "No adjustment applied" },
      { name: "Agent Type Modifier", value: 0.0, color: "bg-purple-500", description: "Standard classification" },
      { name: "Campaign Incentive", value: 0.0, color: "bg-amber-500", description: "None" },
      { name: "Volume Incentive", value: 0.0, color: "bg-rose-500", description: "Below threshold" },
    ],
    appliedRules: ["Country Base Rule"],
    regulatoryWarning: false,
  },
  {
    id: "rule-003",
    country: "Germany",
    countryFlag: "DE",
    agentType: "Corporate Agent",
    baseRate: 8.0,
    ceiling: 12.0,
    marketAdjustment: -1.0,
    status: "active",
    layers: [
      { name: "Country Base", value: 8.0, color: "bg-blue-500", description: "Standard DE rate" },
      { name: "Market Adjustment", value: -1.0, color: "bg-emerald-500", description: "Low season adjustment" },
      { name: "Agent Type Modifier", value: 2.0, color: "bg-purple-500", description: "Corporate premium tier" },
      { name: "Campaign Incentive", value: 0.5, color: "bg-amber-500", description: "Q3 bonus" },
      { name: "Volume Incentive", value: 0.5, color: "bg-rose-500", description: "Moderate volume" },
    ],
    appliedRules: ["Country Base Rule", "Seasonal Market Modifier", "Corporate Tier Classification", "Campaign: Q3-2026", "Volume Threshold Tier-1"],
    regulatoryWarning: true,
  },
  {
    id: "rule-004",
    country: "UAE",
    countryFlag: "AE",
    agentType: "Luxury Agent",
    baseRate: 15.0,
    ceiling: 22.0,
    marketAdjustment: 3.0,
    status: "active",
    layers: [
      { name: "Country Base", value: 15.0, color: "bg-blue-500", description: "Premium AE base rate" },
      { name: "Market Adjustment", value: 3.0, color: "bg-emerald-500", description: "Peak travel season" },
      { name: "Agent Type Modifier", value: 1.5, color: "bg-purple-500", description: "Luxury classification bonus" },
      { name: "Campaign Incentive", value: 0.0, color: "bg-amber-500", description: "None" },
      { name: "Volume Incentive", value: 1.5, color: "bg-rose-500", description: "High-volume rebate" },
    ],
    appliedRules: ["Country Base Rule", "Seasonal Market Modifier", "Luxury Tier Classification", "Volume Threshold Tier-3"],
    regulatoryWarning: false,
  },
  {
    id: "rule-005",
    country: "United Kingdom",
    countryFlag: "GB",
    agentType: "B2B Agent",
    baseRate: 9.5,
    ceiling: 14.0,
    marketAdjustment: 0.5,
    status: "active",
    layers: [
      { name: "Country Base", value: 9.5, color: "bg-blue-500", description: "Standard GB rate" },
      { name: "Market Adjustment", value: 0.5, color: "bg-emerald-500", description: "Minor market correction" },
      { name: "Agent Type Modifier", value: 1.0, color: "bg-purple-500", description: "B2B partnership bonus" },
      { name: "Campaign Incentive", value: -0.5, color: "bg-amber-500", description: "Compliance penalty" },
      { name: "Volume Incentive", value: 0.0, color: "bg-rose-500", description: "Below threshold" },
    ],
    appliedRules: ["Country Base Rule", "Market Correction", "B2B Tier Classification", "Campaign: Compliance-Q3"],
    regulatoryWarning: false,
  },
  {
    id: "rule-006",
    country: "Greece",
    countryFlag: "GR",
    agentType: "Wholesale Agent",
    baseRate: 11.0,
    ceiling: 16.0,
    marketAdjustment: 2.0,
    status: "pending",
    layers: [
      { name: "Country Base", value: 11.0, color: "bg-blue-500", description: "Standard GR rate" },
      { name: "Market Adjustment", value: 2.0, color: "bg-emerald-500", description: "Island season premium" },
      { name: "Agent Type Modifier", value: -1.0, color: "bg-purple-500", description: "Wholesale deduction" },
      { name: "Campaign Incentive", value: 1.0, color: "bg-amber-500", description: "Island promo bonus" },
      { name: "Volume Incentive", value: 1.0, color: "bg-rose-500", description: "High-volume rebate" },
    ],
    appliedRules: ["Country Base Rule", "Island Season Modifier", "Wholesale Classification", "Campaign: Island-Promo", "Volume Threshold Tier-2"],
    regulatoryWarning: true,
  },
];

const mockBreakdown: CountryBreakdown[] = [
  { country: "Turkey", flag: "TR", totalCommissions: 845230, avgRate: 15.0, ruleAccuracy: 98.7 },
  { country: "United States", flag: "US", totalCommissions: 1203450, avgRate: 10.0, ruleAccuracy: 99.2 },
  { country: "Germany", flag: "DE", totalCommissions: 567890, avgRate: 10.0, ruleAccuracy: 97.5 },
  { country: "UAE", flag: "AE", totalCommissions: 934120, avgRate: 21.0, ruleAccuracy: 96.8 },
  { country: "United Kingdom", flag: "GB", totalCommissions: 678340, avgRate: 10.5, ruleAccuracy: 99.0 },
  { country: "Greece", flag: "GR", totalCommissions: 412560, avgRate: 16.0, ruleAccuracy: 95.3 },
];

const defaultRates: DefaultRate[] = [
  { country: "Turkey", flag: "TR", rate: 12.5 },
  { country: "United States", flag: "US", rate: 10.0 },
  { country: "Germany", flag: "DE", rate: 8.0 },
  { country: "UAE", flag: "AE", rate: 15.0 },
  { country: "United Kingdom", flag: "GB", rate: 9.5 },
];

const calcTypes = [
  { label: "Standard", value: 42, color: "bg-blue-500" },
  { label: "Volume-Tiered", value: 28, color: "bg-emerald-500" },
  { label: "Campaign", value: 18, color: "bg-purple-500" },
  { label: "Manual Override", value: 12, color: "bg-amber-500" },
];

/* ------------------------------------------------------------------ */
/*  Helpers                                                            */
/* ------------------------------------------------------------------ */

const flagEmoji = (code: string): string => {
  const map: Record<string, string> = {
    TR: "\u{1F1F9}\u{1F1F7}",
    US: "\u{1F1FA}\u{1F1F8}",
    DE: "\u{1F1E9}\u{1F1EA}",
    AE: "\u{1F1E6}\u{1F1EA}",
    GB: "\u{1F1EC}\u{1F1E7}",
    GR: "\u{1F1EC}\u{1F1F7}",
  };
  return map[code] ?? "";
};

const totalLayerValue = (layers: RuleLayer[]): number =>
  layers.reduce((s, l) => s + l.value, 0);

/* ------------------------------------------------------------------ */
/*  Sub-components                                                     */
/* ------------------------------------------------------------------ */

function KpiCard({
  icon: Icon,
  label,
  value,
  sub,
  color,
}: {
  icon: React.ElementType;
  label: string;
  value: string;
  sub: string;
  color: string;
}) {
  return (
    <div className="rounded-xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-700 dark:bg-gray-900">
      <div className="flex items-center gap-3">
        <div className={`flex h-11 w-11 items-center justify-center rounded-lg ${color}`}>
          <Icon className="h-5 w-5 text-white" />
        </div>
        <div>
          <p className="text-xs font-medium uppercase tracking-wide text-gray-500 dark:text-gray-400">{label}</p>
          <p className="text-2xl font-bold text-gray-900 dark:text-white">{value}</p>
        </div>
      </div>
      <p className="mt-2 text-xs text-gray-400 dark:text-gray-500">{sub}</p>
    </div>
  );
}

function StatusBadge({ status }: { status: CommissionRule["status"] }) {
  const styles: Record<string, string> = {
    active: "bg-emerald-100 text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-400",
    inactive: "bg-gray-100 text-gray-600 dark:bg-gray-800 dark:text-gray-400",
    pending: "bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400",
  };
  return (
    <span className={`inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-semibold capitalize ${styles[status]}`}>
      {status}
    </span>
  );
}

/* ------------------------------------------------------------------ */
/*  Rule Detail Expansion                                              */
/* ------------------------------------------------------------------ */

function RuleDetail({ rule }: { rule: CommissionRule }) {
  const maxVal = Math.max(...rule.layers.map((l) => Math.abs(l.value)), 1);
  const effective = totalLayerValue(rule.layers);

  return (
    <div className="border-t border-gray-100 bg-gray-50 px-6 py-5 dark:border-gray-700 dark:bg-gray-800/50">
      <div className="mb-5 flex items-center gap-2">
        <Layers className="h-4 w-4 text-gray-500" />
        <h4 className="text-sm font-semibold text-gray-700 dark:text-gray-300">Rule Breakdown</h4>
        <span className="ml-auto rounded-full bg-blue-100 px-3 py-1 text-xs font-bold text-blue-700 dark:bg-blue-900/30 dark:text-blue-400">
          Effective: {effective.toFixed(1)}%
        </span>
      </div>

      {/* Layer bars */}
      <div className="space-y-3">
        {rule.layers.map((layer, i) => (
          <div key={i} className="flex items-center gap-3">
            <span className="w-36 shrink-0 text-xs font-medium text-gray-600 dark:text-gray-400">{layer.name}</span>
            <div className="relative h-6 flex-1 overflow-hidden rounded-md bg-gray-200 dark:bg-gray-700">
              <div
                className={`absolute inset-y-0 left-0 ${layer.color} rounded-md opacity-80 transition-all`}
                style={{ width: `${Math.max((Math.abs(layer.value) / maxVal) * 100, 2)}%` }}
              />
              <span className="relative z-10 flex h-full items-center pl-2 text-xs font-semibold text-white">
                {layer.value > 0 ? "+" : ""}{layer.value.toFixed(1)}%
              </span>
            </div>
            <span className="w-48 shrink-0 text-xs text-gray-400 dark:text-gray-500">{layer.description}</span>
          </div>
        ))}
      </div>

      {/* Applied rule chain */}
      <div className="mt-6">
        <div className="mb-2 flex items-center gap-2">
          <ArrowRight className="h-3.5 w-3.5 text-gray-500" />
          <h5 className="text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Applied Rule Chain</h5>
        </div>
        <div className="flex flex-wrap items-center gap-2">
          {rule.appliedRules.map((r, i) => (
            <React.Fragment key={i}>
              <span className="inline-flex items-center rounded-md border border-gray-200 bg-white px-2.5 py-1 text-xs font-medium text-gray-700 shadow-sm dark:border-gray-600 dark:bg-gray-800 dark:text-gray-300">
                {r}
              </span>
              {i < rule.appliedRules.length - 1 && (
                <ArrowRight className="h-3 w-3 text-gray-300 dark:text-gray-600" />
              )}
            </React.Fragment>
          ))}
        </div>
      </div>

      {/* Regulatory ceiling */}
      <div className="mt-4 flex items-center gap-2">
        {rule.regulatoryWarning ? (
          <>
            <AlertTriangle className="h-4 w-4 text-amber-500" />
            <span className="text-xs font-medium text-amber-600 dark:text-amber-400">
              Regulatory ceiling warning: Effective rate ({effective.toFixed(1)}%) is within {((rule.ceiling - effective) / rule.ceiling * 100).toFixed(0)}% of ceiling ({rule.ceiling}%)
            </span>
          </>
        ) : (
          <>
            <CheckCircle className="h-4 w-4 text-emerald-500" />
            <span className="text-xs font-medium text-emerald-600 dark:text-emerald-400">
              Within regulatory ceiling ({rule.ceiling}%) — Headroom: {(rule.ceiling - effective).toFixed(1)}%
            </span>
          </>
        )}
      </div>
    </div>
  );
}

/* ------------------------------------------------------------------ */
/*  Main Component                                                     */
/* ------------------------------------------------------------------ */

const COUNTRY_NAMES: Record<string, string> = { TR: "Turkey", US: "United States", DE: "Germany", AE: "UAE", GB: "United Kingdom", GR: "Greece", GE: "Georgia", AZ: "Azerbaijan", RU: "Russia" };

export default function CommissionRuleEngineDashboard() {
  const [activeTab, setActiveTab] = useState<"rules" | "analytics" | "settings">("rules");
  const [expandedRule, setExpandedRule] = useState<string | null>(null);
  const [autoApply, setAutoApply] = useState(true);
  const [complianceCheck, setComplianceCheck] = useState(true);
  const [learningLoop, setLearningLoop] = useState(false);
  const [rates, setRates] = useState<Record<string, number>>(
    Object.fromEntries(defaultRates.map((d) => [d.flag, d.rate]))
  );
  const [toast, setToast] = useState(false);
  const [dbRules, setDbRules] = useState<CommissionRule[]>([]);
  const [dbAnalytics, setDbAnalytics] = useState<any>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    Promise.all([
      commissionRuleEngineApi.getAnalytics().catch(() => null),
      ...Object.keys(COUNTRY_NAMES).map((cc) =>
        commissionRuleEngineApi.getCountryRules(cc)
          .then((res: any) => ({ countryCode: cc, data: res.data || res }))
          .catch(() => null)
      ),
    ]).then((results) => {
      if (cancelled) return;
      const [analytics, ...ruleResults] = results;
      setDbAnalytics(analytics?.data || analytics);

      const fetched: CommissionRule[] = [];
      for (const r of ruleResults) {
        if (!r?.data) continue;
        const rule = Array.isArray(r.data) ? r.data[0] : r.data;
        if (!rule) continue;
        const baseRate = Number(rule.baseCommissionRate ?? rule.baseRate ?? 0) * 100;
        const ceiling = rule.regulatoryCeiling ? Number(rule.regulatoryCeiling) * 100 : baseRate * 1.5;
        const marketAdj = rule.marketAdjustment ? Number(rule.marketAdjustment) * 100 : 0;

        fetched.push({
          id: rule.id || r.countryCode,
          country: COUNTRY_NAMES[r.countryCode] || r.countryCode,
          countryFlag: r.countryCode,
          agentType: rule.agentType || "Standard",
          baseRate,
          ceiling,
          marketAdjustment: marketAdj,
          status: rule.isActive ? "active" : "inactive",
          layers: [
            { name: "Country Base", value: baseRate, color: "bg-blue-500", description: `Base rate for ${r.countryCode}` },
            { name: "Market Adjustment", value: marketAdj, color: "bg-emerald-500", description: "Market condition adjustment" },
            { name: "Agent Type Modifier", value: 0, color: "bg-purple-500", description: "Agent classification" },
            { name: "Campaign Incentive", value: 0, color: "bg-amber-500", description: "Active campaigns" },
            { name: "Volume Incentive", value: 0, color: "bg-rose-500", description: "Volume thresholds" },
          ],
          appliedRules: [`DB Rule: ${rule.id || "default"}`, `Country: ${r.countryCode}`],
          regulatoryWarning: ceiling < baseRate + marketAdj,
        });
      }
      setDbRules(fetched.length > 0 ? fetched : []);
    }).finally(() => { if (!cancelled) setLoading(false); });

    return () => { cancelled = true; };
  }, []);

  const rules = dbRules.length > 0 ? dbRules : mockRules;

  const toggleRule = useCallback(
    (id: string) => setExpandedRule((prev) => (prev === id ? null : id)),
    []
  );

  const handleSave = useCallback(() => {
    setToast(true);
    setTimeout(() => setToast(false), 3000);
  }, []);

  const handleRateChange = useCallback((flag: string, val: string) => {
    const num = parseFloat(val);
    setRates((prev) => ({ ...prev, [flag]: isNaN(num) ? 0 : num }));
  }, []);

  /* ---------- Tab buttons ---------- */
  const tabs = [
    { key: "rules" as const, label: "Commission Rules", icon: FileText },
    { key: "analytics" as const, label: "Analytics", icon: BarChart3 },
    { key: "settings" as const, label: "Settings", icon: Settings },
  ];

  /* ---------- Total commission ---------- */
  const totalComm = dbAnalytics?.totalCommissions ?? mockBreakdown.reduce((s, b) => s + b.totalCommissions, 0);
  const avgRate = dbAnalytics?.avgRate ?? (mockBreakdown.reduce((s, b) => s + b.avgRate, 0) / mockBreakdown.length);
  const totalPayout = dbAnalytics?.totalPayout ?? Math.round(totalComm * 0.82);
  const platformRev = dbAnalytics?.platformRevenue ?? totalComm - totalPayout;
  const maxCalc = Math.max(...calcTypes.map((c) => c.value));
  const calcTotal = calcTypes.reduce((s, c) => s + c.value, 0);
  const dataSource = dbRules.length > 0 ? "Database" : "Demo";

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-950">
      <div className="mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8">
        {/* Header */}
        <div className="mb-8">
          <div className="flex items-center gap-3">
            <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-blue-600">
              <Gauge className="h-5 w-5 text-white" />
            </div>
            <div>
              <div className="flex items-center gap-3">
                <h1 className="text-2xl font-bold text-gray-900 dark:text-white">
                  Commission Rule Engine
                </h1>
                <span className={`text-xs px-2 py-0.5 rounded-full ${dataSource === "Database" ? "bg-emerald-500/20 text-emerald-600 dark:text-emerald-400" : "bg-amber-500/20 text-amber-600 dark:text-amber-400"}`}>
                  {dataSource}
                </span>
              </div>
              <p className="text-sm text-gray-500 dark:text-gray-400">
                Manage commission rules, monitor analytics, and configure engine settings
              </p>
            </div>
          </div>
        </div>

        {/* Tabs */}
        <div className="mb-6 flex gap-1 rounded-xl border border-gray-200 bg-white p-1 shadow-sm dark:border-gray-700 dark:bg-gray-900">
          {tabs.map((t) => (
            <button
              key={t.key}
              onClick={() => setActiveTab(t.key)}
              className={`flex items-center gap-2 rounded-lg px-4 py-2.5 text-sm font-medium transition-colors ${
                activeTab === t.key
                  ? "bg-blue-600 text-white shadow"
                  : "text-gray-600 hover:bg-gray-100 dark:text-gray-400 dark:hover:bg-gray-800"
              }`}
            >
              <t.icon className="h-4 w-4" />
              {t.label}
            </button>
          ))}
        </div>

        {/* ============================== TAB 1 — RULES ============================== */}
        {activeTab === "rules" && (
          <div className="space-y-3">
            {loading ? (
              <div className="text-center py-12 text-slate-400">Loading commission rules...</div>
            ) : rules.length === 0 ? (
              <div className="text-center py-12 text-slate-400">No commission rules found. Add one in Settings.</div>
            ) : rules.map((rule) => {
              const isOpen = expandedRule === rule.id;
              return (
                <div
                  key={rule.id}
                  className="overflow-hidden rounded-xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-900"
                >
                  {/* Row */}
                  <button
                    onClick={() => toggleRule(rule.id)}
                    className="flex w-full items-center gap-4 px-6 py-4 text-left transition-colors hover:bg-gray-50 dark:hover:bg-gray-800/60"
                  >
                    <span className="text-xl">{flagEmoji(rule.countryFlag)}</span>
                    <span className="w-28 text-sm font-semibold text-gray-900 dark:text-white">{rule.country}</span>
                    <span className="w-32 text-sm text-gray-600 dark:text-gray-400">{rule.agentType}</span>
                    <span className="w-20 text-sm font-bold text-blue-600 dark:text-blue-400">{rule.baseRate}%</span>
                    <span className="w-20 text-sm text-gray-500 dark:text-gray-400">{rule.ceiling}%</span>
                    <span className={`w-20 text-sm font-medium ${rule.marketAdjustment >= 0 ? "text-emerald-600 dark:text-emerald-400" : "text-red-500 dark:text-red-400"}`}>
                      {rule.marketAdjustment >= 0 ? "+" : ""}{rule.marketAdjustment}%
                    </span>
                    <StatusBadge status={rule.status} />
                    <div className="ml-auto flex items-center gap-2">
                      {rule.regulatoryWarning && (
                        <AlertTriangle className="h-4 w-4 text-amber-500" />
                      )}
                      {isOpen ? (
                        <ChevronUp className="h-4 w-4 text-gray-400" />
                      ) : (
                        <ChevronDown className="h-4 w-4 text-gray-400" />
                      )}
                    </div>
                  </button>

                  {/* Expanded detail */}
                  {isOpen && <RuleDetail rule={rule} />}
                </div>
              );
            })}
          </div>
        )}

        {/* ============================== TAB 2 — ANALYTICS ============================== */}
        {activeTab === "analytics" && (
          <div className="space-y-6">
            {/* KPI cards */}
            <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4">
              <KpiCard
                icon={DollarSign}
                label="Total Commissions Processed"
                value={`$${(totalComm / 1000).toFixed(0)}K`}
                sub="Across all markets this quarter"
                color="bg-blue-600"
              />
              <KpiCard
                icon={Target}
                label="Average Rate"
                value={`${avgRate.toFixed(1)}%`}
                sub="Weighted average across countries"
                color="bg-emerald-600"
              />
              <KpiCard
                icon={TrendingUp}
                label="Platform Revenue"
                value={`$${(platformRev / 1000).toFixed(0)}K`}
                sub={`${((platformRev / totalComm) * 100).toFixed(1)}% of total commissions`}
                color="bg-purple-600"
              />
              <KpiCard
                icon={Users}
                label="Agent Payouts"
                value={`$${(totalPayout / 1000).toFixed(0)}K`}
                sub={`${((totalPayout / totalComm) * 100).toFixed(1)}% of total commissions`}
                color="bg-rose-600"
              />
            </div>

            <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
              {/* Pie chart (div-based) */}
              <div className="rounded-xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-gray-900">
                <h3 className="mb-4 text-sm font-semibold text-gray-700 dark:text-gray-300">
                  Calculation Type Distribution
                </h3>
                <div className="flex items-center justify-center gap-8">
                  {/* Circular segments approximation */}
                  <div className="relative h-44 w-44">
                    <svg viewBox="0 0 100 100" className="h-full w-full -rotate-90">
                      {(() => {
                        let cum = 0;
                        const circumference = 2 * Math.PI * 40;
                        return calcTypes.map((ct, i) => {
                          const pct = ct.value / calcTotal;
                          const dash = pct * circumference;
                          const offset = cum * circumference;
                          cum += pct;
                          const colorMap: Record<string, string> = {
                            "bg-blue-500": "#3b82f6",
                            "bg-emerald-500": "#10b981",
                            "bg-purple-500": "#8b5cf6",
                            "bg-amber-500": "#f59e0b",
                          };
                          return (
                            <circle
                              key={i}
                              cx="50"
                              cy="50"
                              r="40"
                              fill="none"
                              stroke={colorMap[ct.color]}
                              strokeWidth="14"
                              strokeDasharray={`${dash} ${circumference - dash}`}
                              strokeDashoffset={-offset}
                              className="transition-all"
                            />
                          );
                        });
                      })()}
                    </svg>
                    <div className="absolute inset-0 flex flex-col items-center justify-center">
                      <span className="text-2xl font-bold text-gray-900 dark:text-white">{calcTotal}%</span>
                      <span className="text-xs text-gray-500 dark:text-gray-400">Total</span>
                    </div>
                  </div>

                  {/* Legend */}
                  <div className="space-y-3">
                    {calcTypes.map((ct) => (
                      <div key={ct.label} className="flex items-center gap-2">
                        <div className={`h-3 w-3 rounded-sm ${ct.color}`} />
                        <span className="text-xs font-medium text-gray-700 dark:text-gray-300">{ct.label}</span>
                        <span className="ml-auto text-xs font-bold text-gray-900 dark:text-white">{ct.value}%</span>
                      </div>
                    ))}
                  </div>
                </div>
              </div>

              {/* Country breakdown */}
              <div className="rounded-xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-gray-900">
                <h3 className="mb-4 text-sm font-semibold text-gray-700 dark:text-gray-300">
                  Country Breakdown
                </h3>
                <div className="overflow-x-auto">
                  <table className="w-full text-left text-xs">
                    <thead>
                      <tr className="border-b border-gray-100 dark:border-gray-700">
                        <th className="pb-2 font-medium text-gray-500 dark:text-gray-400">Country</th>
                        <th className="pb-2 font-medium text-gray-500 dark:text-gray-400">Total</th>
                        <th className="pb-2 font-medium text-gray-500 dark:text-gray-400">Avg Rate</th>
                        <th className="pb-2 font-medium text-gray-500 dark:text-gray-400">Accuracy</th>
                      </tr>
                    </thead>
                    <tbody className="divide-y divide-gray-50 dark:divide-gray-800">
                      {mockBreakdown.map((b) => (
                        <tr key={b.flag} className="hover:bg-gray-50 dark:hover:bg-gray-800/50">
                          <td className="py-2.5 font-medium text-gray-900 dark:text-white">
                            <span className="mr-1.5">{flagEmoji(b.flag)}</span>
                            {b.country}
                          </td>
                          <td className="py-2.5 text-gray-700 dark:text-gray-300">
                            ${(b.totalCommissions / 1000).toFixed(0)}K
                          </td>
                          <td className="py-2.5 text-gray-700 dark:text-gray-300">{b.avgRate}%</td>
                          <td className="py-2.5">
                            <div className="flex items-center gap-2">
                              <div className="h-1.5 w-16 overflow-hidden rounded-full bg-gray-200 dark:bg-gray-700">
                                <div
                                  className={`h-full rounded-full ${b.ruleAccuracy >= 98 ? "bg-emerald-500" : b.ruleAccuracy >= 96 ? "bg-amber-500" : "bg-red-500"}`}
                                  style={{ width: `${b.ruleAccuracy}%` }}
                                />
                              </div>
                              <span className="font-medium text-gray-700 dark:text-gray-300">{b.ruleAccuracy}%</span>
                            </div>
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>
            </div>

            {/* Rule Accuracy Metric */}
            <div className="rounded-xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-gray-900">
              <div className="flex items-center justify-between">
                <div>
                  <h3 className="text-sm font-semibold text-gray-700 dark:text-gray-300">Overall Rule Accuracy</h3>
                  <p className="mt-1 text-xs text-gray-500 dark:text-gray-400">
                    Percentage of calculations matching expected outcomes
                  </p>
                </div>
                <span className="text-3xl font-bold text-emerald-600 dark:text-emerald-400">97.8%</span>
              </div>
              <div className="mt-4 h-3 overflow-hidden rounded-full bg-gray-100 dark:bg-gray-800">
                <div
                  className="h-full rounded-full bg-gradient-to-r from-emerald-500 to-emerald-400 transition-all"
                  style={{ width: "97.8%" }}
                />
              </div>
              <div className="mt-3 flex items-center gap-4 text-xs text-gray-400">
                <span className="flex items-center gap-1">
                  <CheckCircle className="h-3 w-3 text-emerald-500" /> 14,287 matched
                </span>
                <span className="flex items-center gap-1">
                  <XCircle className="h-3 w-3 text-red-400" /> 318 mismatches
                </span>
              </div>
            </div>
          </div>
        )}

        {/* ============================== TAB 3 — SETTINGS ============================== */}
        {activeTab === "settings" && (
          <div className="space-y-6">
            {/* Toggle switches */}
            <div className="rounded-xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-gray-900">
              <h3 className="mb-4 text-sm font-semibold text-gray-700 dark:text-gray-300">Engine Behaviour</h3>
              <div className="space-y-4">
                {[
                  { label: "Auto-Apply Rules", desc: "Automatically apply rule changes to live calculations", state: autoApply, set: setAutoApply },
                  { label: "Compliance Check", desc: "Run regulatory compliance validation on every calculation", state: complianceCheck, set: setComplianceCheck },
                  { label: "Learning Loop", desc: "Enable ML-based rule optimisation from historical data", state: learningLoop, set: setLearningLoop },
                ].map((item) => (
                  <div
                    key={item.label}
                    className="flex items-center justify-between rounded-lg border border-gray-100 px-4 py-3 dark:border-gray-700"
                  >
                    <div>
                      <p className="text-sm font-medium text-gray-900 dark:text-white">{item.label}</p>
                      <p className="text-xs text-gray-500 dark:text-gray-400">{item.desc}</p>
                    </div>
                    <button
                      onClick={() => item.set(!item.state)}
                      className={`relative inline-flex h-6 w-11 shrink-0 cursor-pointer items-center rounded-full transition-colors ${
                        item.state ? "bg-blue-600" : "bg-gray-300 dark:bg-gray-600"
                      }`}
                    >
                      <span
                        className={`inline-block h-4 w-4 transform rounded-full bg-white shadow transition-transform ${
                          item.state ? "translate-x-6" : "translate-x-1"
                        }`}
                      />
                    </button>
                  </div>
                ))}
              </div>
            </div>

            {/* Default rates */}
            <div className="rounded-xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-gray-900">
              <h3 className="mb-4 text-sm font-semibold text-gray-700 dark:text-gray-300">
                Default Rates by Country
              </h3>
              <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
                {defaultRates.map((d) => (
                  <div
                    key={d.flag}
                    className="flex items-center gap-3 rounded-lg border border-gray-100 px-4 py-3 dark:border-gray-700"
                  >
                    <span className="text-lg">{flagEmoji(d.flag)}</span>
                    <div className="flex-1">
                      <label className="text-xs font-medium text-gray-700 dark:text-gray-300">{d.country}</label>
                      <div className="mt-1 flex items-center gap-1">
                        <input
                          type="number"
                          value={rates[d.flag]}
                          onChange={(e) => handleRateChange(d.flag, e.target.value)}
                          className="w-20 rounded-md border border-gray-300 bg-white px-2 py-1 text-sm font-bold text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500 dark:border-gray-600 dark:bg-gray-800 dark:text-white"
                          step="0.5"
                          min="0"
                          max="30"
                        />
                        <span className="text-sm text-gray-500 dark:text-gray-400">%</span>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </div>

            {/* Save */}
            <div className="flex justify-end">
              <button
                onClick={handleSave}
                className="inline-flex items-center gap-2 rounded-lg bg-blue-600 px-5 py-2.5 text-sm font-semibold text-white shadow-sm transition-colors hover:bg-blue-700 active:bg-blue-800"
              >
                <Save className="h-4 w-4" />
                Save Settings
              </button>
            </div>
          </div>
        )}
      </div>

      {/* Toast */}
      {toast && (
        <div className="fixed bottom-6 right-6 z-50 flex items-center gap-2 rounded-lg bg-gray-900 px-4 py-3 text-sm font-medium text-white shadow-xl dark:bg-gray-100 dark:text-gray-900">
          <CheckCircle className="h-4 w-4 text-emerald-400 dark:text-emerald-600" />
          Settings saved successfully
        </div>
      )}
    </div>
  );
}

export { CommissionRuleEngineDashboard };
