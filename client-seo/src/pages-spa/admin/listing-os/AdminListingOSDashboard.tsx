"use client";

import { useTranslation } from "react-i18next";
import { Home, Activity, CheckCircle, Eye, TrendingUp, Globe, Radio, AlertTriangle, Settings, Upload } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { m } from "framer-motion";

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

export default function AdminListingOSDashboard() {
  const { t } = useTranslation();

  const kpis = [
    { title: "Total Properties", value: 47, icon: Home, color: "text-emerald-500", trend: "+4 this month" },
    { title: "Active Listings", value: 38, icon: Activity, color: "text-blue-400", trend: "Live on portals" },
    { title: "Avg Health Score", value: "94%", icon: CheckCircle, color: "text-purple-400", trend: "Quality compliance" },
    { title: "Network Views (30d)", value: "12,480", icon: Eye, color: "text-orange-400", trend: "+18.3% vs prev" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-slate-100">Listing OS Management</h1>
          <p className="text-slate-400 mt-1">Property health, syndication, and digital asset management</p>
        </div>
        <Button className="bg-indigo-600 hover:bg-indigo-700">
          <Upload className="h-4 w-4 mr-2" />
          Import Listing
        </Button>
      </div>

      {/* KPIs */}
      <div className="grid gap-4 md:grid-cols-4">
        {kpis.map((kpi, i) => (
          <m.div key={kpi.title} initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: i * 0.07 }}>
            <Card className="bg-slate-900/60 border-slate-800">
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-slate-400">{kpi.title}</CardTitle>
                <kpi.icon className={`h-4 w-4 ${kpi.color}`} />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-slate-100">{kpi.value}</div>
                <p className="text-xs text-slate-500 mt-1">{kpi.trend}</p>
              </CardContent>
            </Card>
          </m.div>
        ))}
      </div>

      <Tabs defaultValue="overview" className="space-y-4">
        <TabsList className="bg-slate-900/60 border-slate-800">
          <TabsTrigger value="overview">Overview</TabsTrigger>
          <TabsTrigger value="listings">Listings</TabsTrigger>
          <TabsTrigger value="syndication">Syndication</TabsTrigger>
          <TabsTrigger value="health">Health</TabsTrigger>
        </TabsList>

        <TabsContent value="overview" className="space-y-4">
          <div className="grid gap-4 md:grid-cols-2">
            {/* Digital Health Record Stream */}
            <Card className="bg-slate-900/60 border-slate-800">
              <CardHeader>
                <CardTitle className="text-slate-100 flex items-center gap-2">
                  <Radio className="h-4 w-4 text-emerald-400 animate-pulse" />
                  Digital Health Record Stream
                </CardTitle>
                <CardDescription className="text-slate-400">
                  Real-time property compliance and operational events
                </CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-3">
                  {HEALTH_STREAM.map((item, i) => (
                    <m.div
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
                    </m.div>
                  ))}
                </div>
              </CardContent>
            </Card>

            {/* Platform Syndication Stats */}
            <Card className="bg-slate-900/60 border-slate-800">
              <CardHeader>
                <CardTitle className="text-slate-100 flex items-center gap-2">
                  <Globe className="h-4 w-4 text-blue-400" />
                  Platform Syndication
                </CardTitle>
                <CardDescription className="text-slate-400">
                  Live distribution status across global OTAs and MLS networks
                </CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {SYNDICATION.map((ch, i) => (
                    <m.div 
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
                          <p className="text-xs text-slate-500">{ch.listings} active listings</p>
                        </div>
                      </div>
                      <div className={`text-xs font-bold px-2 py-1 rounded-full ${
                        ch.status === "LIVE" ? "bg-emerald-500/10 text-emerald-400" : "bg-yellow-500/10 text-yellow-400"
                      }`}>
                        {ch.status}
                      </div>
                    </m.div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </div>
        </TabsContent>

        <TabsContent value="listings">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Listing Management</CardTitle>
              <CardDescription className="text-slate-400">
                Manage all property listings and digital assets
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-slate-400">
                <Home className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>Listing management interface</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="syndication">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Syndication Configuration</CardTitle>
              <CardDescription className="text-slate-400">
                Configure OTA and MLS channel integrations
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-slate-400">
                <Globe className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>Syndication configuration interface</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="health">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Health Monitoring</CardTitle>
              <CardDescription className="text-slate-400">
                Monitor property health scores and compliance status
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-slate-400">
                <CheckCircle className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>Health monitoring interface</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
