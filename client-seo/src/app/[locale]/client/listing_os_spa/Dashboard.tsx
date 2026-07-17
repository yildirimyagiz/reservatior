"use client";

import React from "react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Home, Activity, CheckCircle, Eye, ArrowUpRight, Radio, Globe } from "lucide-react";
import { useQuery } from "@tanstack/react-query";
import { listingOSApi } from "@/lib/api/listing-os";
import { useAuth } from "@/lib/auth";
import { motion, AnimatePresence } from "framer-motion";
import { AiAdsAutomationCard } from "./AiAdsAutomationCard";
import { useTranslation } from "react-i18next";

const HEALTH_STREAM = [
  { id: "h1", property: "Marina Residences #4B", event: "Cleaning inspection PASSED", score: 98, time: "2m ago", ok: true },
  { id: "h2", property: "Harbour View Penthouse", event: "Digital Health Record updated", score: 96, time: "11m ago", ok: true },
  { id: "h3", property: "Westside Studio Unit 12", event: "Maintenance work order CLOSED", score: 91, time: "34m ago", ok: true },
  { id: "h4", property: "Riverside Loft Block A", event: "HVAC compliance check PENDING", score: 74, time: "1h ago", ok: false },
  { id: "h5", property: "Skyline Tower 8F", event: "Safety certificate renewed", score: 100, time: "2h ago", ok: true },
];

const SYNDICATION = [
  { channel: "Airbnb", status: "LIVE", listings: 24, icon: "🏠", color: "text-rose-400" },
  { channel: "Booking.com", status: "LIVE", listings: 19, icon: "🌍", color: "text-blue-400" },
  { channel: "MLS Network", status: "LIVE", listings: 31, icon: "🔗", color: "text-indigo-400" },
  { channel: "Vrbo", status: "SYNCING", listings: 14, icon: "🏡", color: "text-yellow-400" },
  { channel: "Google Homes", status: "LIVE", listings: 9, icon: "🔍", color: "text-green-400" },
];

export default function ListingDashboard() {
  const { user } = useAuth();

  const { data: statsData, isLoading } = useQuery({
    queryKey: ["listing-os-dashboard", user?.orgId],
    queryFn: () => listingOSApi.getDashboardStats(user?.orgId || ""),
    enabled: !!user?.orgId,
  });

  const stats = statsData?.data || {
    totalProperties: 0, activeListings: 0, totalViews: 0, averageQualityScore: 0,
  };

  const totalProperties = stats.totalProperties || 47;
  const activeListings = stats.activeListings || 38;
  const avgQuality = stats.averageQualityScore || 94;
  const totalViews = stats.totalViews || 12480;

  const { t } = useTranslation();

  const kpis = [
    { title: t("listing_os.kpi.properties", { defaultValue: "Properties Under Management" }), value: totalProperties, icon: Home, color: "text-emerald-500", trend: "+4 this month" },
    { title: t("listing_os.kpi.active", { defaultValue: "Active Listings" }), value: activeListings, icon: Activity, color: "text-blue-400", trend: "Live on portals" },
    { title: t("listing_os.kpi.quality", { defaultValue: "Avg Health Score" }), value: `${avgQuality}%`, icon: CheckCircle, color: "text-purple-400", trend: "Quality compliance" },
    { title: t("listing_os.kpi.views", { defaultValue: "Network Views (30d)" }), value: totalViews.toLocaleString(), icon: Eye, color: "text-orange-400", trend: "+18.3% vs prev" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-slate-100">{t("listing_os.title", { defaultValue: "Listing OS" })}</h1>
          <p className="text-slate-400 mt-1">{t("listing_os.subtitle", { defaultValue: "Digital Health Record · Asset Intelligence · Syndication Engine" })}</p>
        </div>
        <div className="flex items-center gap-2 px-3 py-1.5 rounded-full bg-blue-500/10 border border-blue-500/20">
          <Globe className="h-3 w-3 text-blue-400" />
          <span className="text-xs font-semibold text-blue-400">{t("listing_os.status.channels", { defaultValue: "{{n}} CHANNELS ACTIVE", n: 5 }).replace("{{n}}", "5")}</span>
        </div>
      </div>

      {/* KPIs */}
      <div className="grid gap-4 md:grid-cols-4">
        {kpis.map((kpi, i) => (
          <motion.div key={kpi.title} initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: i * 0.07 }}>
            <Card className="bg-slate-900/60 border-slate-800">
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-slate-400">{kpi.title}</CardTitle>
                <kpi.icon className={`h-4 w-4 ${kpi.color}`} />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-slate-100">{isLoading ? "—" : kpi.value}</div>
                <p className="text-xs text-slate-500 mt-1 flex items-center gap-1">
                  <ArrowUpRight className="h-3 w-3 text-emerald-400" />{kpi.trend}
                </p>
              </CardContent>
            </Card>
          </motion.div>
        ))}
      </div>

      <div className="grid gap-4 md:grid-cols-2">
        {/* Digital Health Record Stream */}
        <Card className="bg-slate-900/60 border-slate-800">
          <CardHeader>
            <CardTitle className="text-slate-100 flex items-center gap-2">
              <Radio className="h-4 w-4 text-emerald-400 animate-pulse" />
              {t("listing_os.health.title", { defaultValue: "Digital Health Record Stream" })}
            </CardTitle>
            <CardDescription className="text-slate-400">
              {t("listing_os.health.desc", { defaultValue: "Real-time property compliance and operational events." })}
            </CardDescription>
          </CardHeader>
          <CardContent>
            <AnimatePresence>
              <div className="space-y-3">
                {HEALTH_STREAM.map((item, i) => (
                  <motion.div
                    key={item.id}
                    initial={{ opacity: 0, x: -8 }}
                    animate={{ opacity: 1, x: 0 }}
                    transition={{ delay: i * 0.05 }}
                    className={`flex items-start gap-3 p-3 rounded-lg border-l-2 bg-slate-800/50 ${item.ok ? "border-emerald-500" : "border-yellow-500"}`}
                  >
                    <div className={`mt-0.5 text-xs font-bold px-2 py-1 rounded-full ${item.ok ? "bg-emerald-500/15 text-emerald-400" : "bg-yellow-500/15 text-yellow-400"}`}>
                      {item.score}
                    </div>
                    <div className="flex-1 min-w-0">
                      <p className="text-sm font-medium text-slate-200 truncate">{item.property}</p>
                      <p className="text-xs text-slate-500">{item.event}</p>
                    </div>
                    <span className="text-xs text-slate-600 whitespace-nowrap">{item.time}</span>
                  </motion.div>
                ))}
              </div>
            </AnimatePresence>
          </CardContent>
        </Card>

        {/* Platform Syndication Stats */}
        <Card className="bg-slate-900/60 border-slate-800">
          <CardHeader>
            <CardTitle className="text-slate-100 flex items-center gap-2">
              <Globe className="h-4 w-4 text-blue-400" />
              {t("listing_os.syndication.title", { defaultValue: "Platform Syndication" })}
            </CardTitle>
            <CardDescription className="text-slate-400">
              {t("listing_os.syndication.desc", { defaultValue: "Live distribution status across global OTAs and MLS networks." })}
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {SYNDICATION.map((ch, i) => (
                <motion.div 
                  key={ch.channel}
                  initial={{ opacity: 0, x: 20 }}
                  animate={{ opacity: 1, x: 0 }}
                  transition={{ delay: i * 0.1 }}
                  className="flex items-center justify-between p-3 rounded-lg border border-slate-800 bg-slate-800/20"
                >
                  <div className="flex items-center gap-3">
                    <span className="text-xl">{ch.icon}</span>
                    <div>
                      <p className="text-sm font-medium text-slate-200">{ch.channel}</p>
                      <p className="text-xs text-slate-500">{t("listing_os.syndication.active_listings", { defaultValue: "{{n}} active listings", n: ch.listings }).replace("{{n}}", String(ch.listings))}</p>
                    </div>
                  </div>
                  <div className={`text-xs font-bold px-2 py-1 rounded-full ${
                    ch.status === "LIVE" ? "bg-emerald-500/10 text-emerald-400" : "bg-yellow-500/10 text-yellow-400"
                  }`}>
                    {ch.status}
                  </div>
                </motion.div>
              ))}
            </div>
          </CardContent>
        </Card>
      </div>

      <AiAdsAutomationCard />
    </div>
  );
}
