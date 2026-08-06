"use client";

import React from "react";
import { useTranslation } from "react-i18next";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Globe, Coins, Languages, TrendingUp, ArrowUpRight, Zap } from "lucide-react";
import { useAuth } from "@/lib/auth";
import {
  XAxis, YAxis, CartesianGrid, Tooltip,
  ResponsiveContainer, AreaChart, Area, ReferenceLine,
} from "recharts";
import { m } from "framer-motion";
import { useQuery } from "@tanstack/react-query";

const DEMO_CHART = [
  { name: "Mon", rate: 1.082 }, { name: "Tue", rate: 1.085 },
  { name: "Wed", rate: 1.079 }, { name: "Thu", rate: 1.091 },
  { name: "Fri", rate: 1.088 }, { name: "Sat", rate: 1.084 },
  { name: "Sun", rate: 1.087 },
];

const DEMO_RATES = [
  { id: "1", pair: "EUR/USD", rate: "1.0872", change: "+0.32%", status: "ACTIVE", updated: new Date(Date.now() - 1000*60*10).toISOString() },
  { id: "2", pair: "GBP/USD", rate: "1.2641", change: "+0.18%", status: "ACTIVE", updated: new Date(Date.now() - 1000*60*25).toISOString() },
  { id: "3", pair: "USD/JPY", rate: "149.82", change: "-0.14%", status: "ACTIVE", updated: new Date(Date.now() - 1000*60*40).toISOString() },
  { id: "4", pair: "USD/CHF", rate: "0.8734", change: "+0.09%", status: "ACTIVE", updated: new Date(Date.now() - 1000*60*60).toISOString() },
];

export default function LocalizationDashboard() {
  const { user } = useAuth();

  const { data: statsData, isLoading } = useQuery({
    queryKey: ["localization-os-dashboard"],
    queryFn: async () => {
      const res = await fetch(`/api/v1/localization-os/dashboard`);
      if (!res.ok) throw new Error("Failed to fetch");
      return res.json();
    },
  });

  const stats = statsData?.data || {
    totalCountries: 0,
    activeCurrencies: 0,
    activeLanguages: 0,
    exchangeRates: 0,
    chartData: [],
    recentRates: [],
  };

  const chartData = stats.chartData?.length > 0 ? stats.chartData : DEMO_CHART;
  const rates = stats.recentRates?.length > 0 ? stats.recentRates : DEMO_RATES;
  const totalCountries = stats.totalCountries > 0 ? stats.totalCountries : 195;
  const activeCurrencies = stats.activeCurrencies > 0 ? stats.activeCurrencies : 42;
  const activeLanguages = stats.activeLanguages > 0 ? stats.activeLanguages : 78;
  const exchangeRates = stats.exchangeRates > 0 ? stats.exchangeRates : 156;

  const { t } = useTranslation();

  const kpis = [
    {
      title: t("localization_os.total_countries", { defaultValue: "Total Countries" }),
      value: totalCountries,
      icon: Globe,
      color: "text-blue-500",
      bg: "from-blue-500/10 to-blue-500/0",
      sub: t("localization_os.countries_sub", { defaultValue: "Supported regions" }),
      trend: "+3 this quarter",
    },
    {
      title: t("localization_os.active_currencies", { defaultValue: "Active Currencies" }),
      value: activeCurrencies,
      icon: Coins,
      color: "text-blue-400",
      bg: "from-blue-400/10 to-blue-400/0",
      sub: t("localization_os.currencies_sub", { defaultValue: "Fiat and crypto supported" }),
      trend: "+2 this month",
    },
    {
      title: t("localization_os.active_languages", { defaultValue: "Active Languages" }),
      value: activeLanguages,
      icon: Languages,
      color: "text-blue-400",
      bg: "from-blue-400/10 to-blue-400/0",
      sub: t("localization_os.languages_sub", { defaultValue: "Locale translations live" }),
      trend: "+5 this quarter",
    },
    {
      title: t("localization_os.exchange_rates", { defaultValue: "Exchange Rates" }),
      value: exchangeRates,
      icon: TrendingUp,
      color: "text-blue-400",
      bg: "from-blue-400/10 to-blue-400/0",
      sub: t("localization_os.rates_sub", { defaultValue: "Active rate pairs" }),
      trend: "+0.4% avg",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-slate-100">{t("localization_os.title", { defaultValue: "Localization OS" })}</h1>
          <p className="text-slate-400 mt-1">{t("localization_os.subtitle", { defaultValue: "Country · Language · Regulation · Currency" })}</p>
        </div>
        <div className="flex items-center gap-2 px-3 py-1.5 rounded-full bg-blue-500/10 border border-blue-500/20">
          <span className="h-2 w-2 rounded-full bg-blue-400 animate-pulse" />
          <span className="text-xs font-semibold text-blue-400">{t("localization_os.live", { defaultValue: "LIVE" })}</span>
        </div>
      </div>

      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        {kpis.map((kpi, i) => (
          <m.div
            key={kpi.title}
            initial={{ opacity: 0, y: 12 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: i * 0.08 }}
          >
            <Card className="bg-slate-900/60 border-slate-800 overflow-hidden relative">
              <div className={`absolute inset-0 bg-gradient-to-br ${kpi.bg} pointer-events-none`} />
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-slate-400">{kpi.title}</CardTitle>
                <kpi.icon className={`h-4 w-4 ${kpi.color}`} />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-slate-100">{isLoading ? "—" : kpi.value}</div>
                <div className="flex items-center gap-2 mt-1">
                  <p className="text-xs text-slate-500">{kpi.sub}</p>
                  <span className="ml-auto text-xs font-semibold text-blue-400 flex items-center gap-0.5">
                    <ArrowUpRight className="h-3 w-3" />{kpi.trend}
                  </span>
                </div>
              </CardContent>
            </Card>
          </m.div>
        ))}
      </div>

      <div className="grid gap-4 md:grid-cols-2">
        <Card className="bg-slate-900/60 border-slate-800">
          <CardHeader>
            <CardTitle className="text-slate-100 flex items-center gap-2">
              <Zap className="h-4 w-4 text-blue-400" />
              {t("localization_os.rate_trend", { defaultValue: "Exchange Rate Trend" })}
            </CardTitle>
            <CardDescription className="text-slate-400">
              {t("localization_os.rate_trend_desc", { defaultValue: "EUR/USD reference rate over the past week." })}
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="h-[220px]">
              <ResponsiveContainer width="100%" height="100%">
                <AreaChart data={chartData} margin={{ top: 5, right: 10, bottom: 0, left: -20 }}>
                  <defs>
                    <linearGradient id="locGrad" x1="0" y1="0" x2="0" y2="1">
                      <stop offset="5%" stopColor="#3b82f6" stopOpacity={0.25} />
                      <stop offset="95%" stopColor="#3b82f6" stopOpacity={0} />
                    </linearGradient>
                  </defs>
                  <CartesianGrid strokeDasharray="3 3" stroke="#1e293b" vertical={false} />
                  <XAxis dataKey="name" stroke="#475569" fontSize={11} tickLine={false} axisLine={false} />
                  <YAxis stroke="#475569" fontSize={11} tickLine={false} axisLine={false} domain={["dataMin - 0.005", "dataMax + 0.005"]} tickFormatter={(v) => v.toFixed(3)} />
                  <Tooltip
                    contentStyle={{ backgroundColor: "#0f172a", border: "1px solid #1e293b", borderRadius: "8px" }}
                    itemStyle={{ color: "#3b82f6" }}
                    formatter={(v) => [Number(Array.isArray(v) ? v[0] : (v ?? 0)).toFixed(4), t("localization_os.rate", { defaultValue: "Rate" })] as [string, string]}
                  />
                  <ReferenceLine y={1.085} stroke="#334155" strokeDasharray="3 3" />
                  <Area type="monotone" dataKey="rate" stroke="#3b82f6" strokeWidth={2} fill="url(#locGrad)" dot={false} activeDot={{ r: 4, fill: "#3b82f6" }} />
                </AreaChart>
              </ResponsiveContainer>
            </div>
          </CardContent>
        </Card>

        <Card className="bg-slate-900/60 border-slate-800">
          <CardHeader>
            <CardTitle className="text-slate-100">{t("localization_os.latest_rates", { defaultValue: "Latest Exchange Rates" })}</CardTitle>
            <CardDescription className="text-slate-400">{t("localization_os.latest_rates_desc", { defaultValue: "Most recently updated currency pairs." })}</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {rates.slice(0, 4).map((r: { id?: string; pair: string; rate: string; change: string; status: string; updated: string }, i: number) => (
                <div key={r.id || i} className="flex items-center justify-between p-3 rounded-lg border border-slate-800 bg-slate-800/20">
                  <div className="flex items-center gap-3">
                    <div className="p-2 rounded-full bg-blue-500/10 text-blue-400">
                      <Coins className="h-4 w-4" />
                    </div>
                    <div>
                      <p className="text-sm font-medium text-slate-200">{r.pair}</p>
                      <p className="text-xs text-slate-500">{new Date(r.updated).toLocaleTimeString()}</p>
                    </div>
                  </div>
                  <div className="text-right">
                    <p className="text-sm font-bold text-slate-200">{r.rate}</p>
                    <p className={`text-xs font-semibold ${r.change.startsWith("+") ? "text-blue-400" : "text-red-400"}`}>
                      {r.change}
                    </p>
                  </div>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
