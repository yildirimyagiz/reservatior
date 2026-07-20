"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Users, Building2, Phone, Mail, MapPin, Globe, TrendingUp, Star, Plus, Eye, Edit, Users2, Zap, ArrowRight, TrendingDown, Briefcase, LayoutDashboard, Sparkles, ChevronRight } from "lucide-react";
import { agenciesApi, Agency } from "@/lib/api/agencies";
import { agentsApi, Agent } from "@/lib/api/agents";
import { useQuery } from "@tanstack/react-query";
import { cn } from "@/lib/utils";
export default function AgencyDashboard() {
  const {
    t
  } = useTranslation();
  const [, setSelectedAgency] = useState<Agency | null>(null);
  const [viewMode, setViewMode] = useState<"overview" | "agents" | "partners" | "performance">("overview");
  const {
    data: agencies = [],
    isLoading: isLoadingAgencies
  } = useQuery<Agency[]>({
    queryKey: ["agencies"],
    queryFn: () => agenciesApi.getAll()
  });
  const {
    data: agents = [],
    isLoading: isLoadingAgents
  } = useQuery<Agent[]>({
    queryKey: ["agents"],
    queryFn: () => agentsApi.getAll()
  });
  const loading = isLoadingAgencies || isLoadingAgents;
  if (loading) {
    return <div className="flex flex-col items-center justify-center min-h-[60vh] gap-4 text-slate-500 font-bold">
        <Zap className="w-8 h-8 animate-spin text-violet-500" />{t("client.src.synchronizing_portfolio")}</div>;
  }
  return <div className="min-h-full bg-[#0a0b0d] p-6 lg:p-10 space-y-10 text-slate-200">
      <div className="max-w-[1600px] mx-auto space-y-10">
        
        {/* Neural Header */}
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-6">
          <div className="space-y-1.5">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-violet-500/10 border border-violet-500/20 text-violet-400 text-[10px] font-black tracking-widest">
              <Building2 className="w-3.5 h-3.5" />{t("client.src.institutional_hub")}</div>
            <h1 className="text-3xl md:text-5xl font-black text-white tracking-tighter">{t("client.src.agency_management")}</h1>
            <p className="text-slate-500 text-sm font-medium">{t("client.src.manage_agencies_consultants_and")}</p>
          </div>
          <div className="flex items-center gap-3">
             <Button variant="outline" className="bg-slate-900 border-white/5 text-white h-12 rounded-xl px-6 font-bold hover:bg-slate-800">
               <TrendingUp className="w-4 h-4 mr-2 text-emerald-400" />{t("client.src.market_analysis")}</Button>
             <Button className="bg-violet-600 hover:bg-violet-500 text-white h-12 rounded-xl px-8 font-black shadow-xl shadow-violet-600/20 border-none transition-all hover:scale-105">
               <Plus className="w-5 h-5 mr-1" />{t("client.src.new_agency_registration")}</Button>
          </div>
        </div>

        {/* Tactical Switcher */}
        <div className="flex bg-slate-900/50 p-1 rounded-2xl border border-white/5 w-fit">
           {[{
          id: "overview",
          label: t("client.src.overview"),
          icon: LayoutDashboard
        }, {
          id: "agents",
          label: t("client.src.consultants"),
          icon: Users
        }, {
          id: "partners",
          label: t("client.src.partner_network"),
          icon: Users2
        }, {
          id: "performance",
          label: t("client.src.performance"),
          icon: TrendingUp
        }].map(t => <Button key={t.id} variant="ghost" onClick={() => setViewMode(t.id as any)} className={cn("h-11 px-6 rounded-xl font-bold transition-all gap-2", viewMode === t.id ? "bg-violet-600 text-white shadow-lg" : "text-slate-500 hover:text-white")}>
               <t.icon className={cn("w-4 h-4", viewMode === t.id ? "text-white" : "text-slate-600")} />
               {t.label}
             </Button>)}
        </div>

        <AnimatePresence mode="wait">
          {viewMode === "overview" && <motion.div initial={{
          opacity: 0
        }} animate={{
          opacity: 1
        }} exit={{
          opacity: 0
        }} className="space-y-8">
              <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
                {agencies.map((agency, index) => <motion.div key={agency.id} initial={{
              opacity: 0,
              y: 20
            }} animate={{
              opacity: 1,
              y: 0
            }} transition={{
              delay: index * 0.1
            }}>
                    <Card className="bg-[#14151a]/60 border-slate-800/50 rounded-3xl overflow-hidden hover:border-violet-500/40 transition-all duration-500 group">
                      <CardHeader className="pb-4 pt-8 px-8 flex-row items-center justify-between space-y-0">
                        <div className="flex items-center gap-4">
                           <div className="w-14 h-14 rounded-2xl bg-violet-600/10 border border-violet-600/20 flex items-center justify-center text-violet-400">
                             <Building2 className="w-7 h-7" />
                           </div>
                           <div>
                              <CardTitle className="text-2xl font-black text-white group-hover:text-violet-400 transition-colors">{agency.name}</CardTitle>
                              <Badge className="bg-emerald-500/10 text-emerald-500 border-none px-2 py-0 h-5 text-[9px] font-black tracking-widest mt-1">{t("client.src.active_branch")}</Badge>
                           </div>
                        </div>
                        <div className="flex gap-2">
                           <Button variant="ghost" size="icon" className="h-10 w-10 rounded-xl hover:bg-slate-800"><Edit className="w-4 h-4" /></Button>
                        </div>
                      </CardHeader>
                      <CardContent className="px-8 pb-8 space-y-8">
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm text-slate-400 font-medium">
                          <div className="flex items-center gap-3"><MapPin className="w-4 h-4 text-violet-500" /> {agency.address}</div>
                          <div className="flex items-center gap-3"><Phone className="w-4 h-4 text-violet-500" /> {agency.phoneNumber}</div>
                          <div className="flex items-center gap-3"><Mail className="w-4 h-4 text-violet-500" /> {agency.email}</div>
                          <div className="flex items-center gap-3"><Globe className="w-4 h-4 text-violet-500" /> {agency.name.toLowerCase().split(' ')[0]}{t("client.src.reservatiorcom")}</div>
                        </div>

                        <div className="grid grid-cols-4 gap-4 p-4 rounded-2xl bg-white/5 border border-white/5">
                           <div className="text-center space-y-1">
                              <p className="text-[10px] font-black text-slate-500">{t("client.src.team")}</p>
                              <p className="text-2xl font-black text-white">{agency._count?.Agent || 0}</p>
                           </div>
                           <div className="text-center space-y-1">
                              <p className="text-[10px] font-black text-slate-500">{t("client.src.property")}</p>
                              <p className="text-2xl font-black text-white">42</p>
                           </div>
                           <div className="text-center space-y-1">
                              <p className="text-[10px] font-black text-slate-500">{t("client.src.volume")}</p>
                              <p className="text-2xl font-black text-emerald-400">{t("client.src.12m")}</p>
                           </div>
                           <div className="text-center space-y-1">
                              <p className="text-[10px] font-black text-slate-500">{t("client.src.score")}</p>
                              <p className="text-2xl font-black text-amber-400 flex items-center justify-center gap-1">4.9 <Star className="w-4 h-4 fill-amber-400" /></p>
                           </div>
                        </div>

                        <div className="flex items-center justify-between pt-2">
                           <Button className="bg-slate-900 border border-white/5 text-white font-bold h-11 px-8 rounded-xl hover:bg-slate-800">{t("client.src.view_details")}<ChevronRight className="w-4 h-4 ml-2" />
                           </Button>
                           <div className="flex -space-x-3">
                              {[1, 2, 3, 4].map(a => <div key={a} className="w-10 h-10 rounded-full border-2 border-[#14151a] bg-slate-800 flex items-center justify-center text-[10px] font-black text-white">A{a}</div>)}
                           </div>
                        </div>
                      </CardContent>
                    </Card>
                  </motion.div>)}
              </div>
            </motion.div>}

          {viewMode === "agents" && <motion.div initial={{
          opacity: 0,
          x: 20
        }} animate={{
          opacity: 1,
          x: 0
        }} exit={{
          opacity: 0,
          x: -20
        }}>
              <Card className="bg-[#14151a]/60 border-slate-800/50 rounded-3xl overflow-hidden p-8">
                <CardHeader className="px-0 pt-0 flex-row items-center justify-between pb-8 border-b border-white/5">
                  <div className="space-y-1">
                    <CardTitle className="text-3xl font-black text-white flex items-center gap-3">
                      <Users className="w-8 h-8 text-violet-500" />{t("client.src.all_consultants")}</CardTitle>
                    <p className="text-slate-500 font-medium">{t("client.src.performance_of_all_licensed")}</p>
                  </div>
                  <Button className="bg-violet-600 rounded-xl font-bold h-11 px-6">{t("client.src.add_license")}</Button>
                </CardHeader>
                <CardContent className="px-0 pt-8 space-y-4">
                  {agents.map((agent, index) => <motion.div key={agent.id} initial={{
                opacity: 0,
                x: -20
              }} animate={{
                opacity: 1,
                x: 0
              }} transition={{
                delay: index * 0.05
              }} className="flex items-center justify-between p-5 bg-white/5 rounded-2xl border border-white/5 group hover:border-violet-500/30 transition-all">
                      <div className="flex items-center gap-5">
                        <div className="w-14 h-14 rounded-2xl bg-gradient-to-br from-violet-600/20 to-indigo-600/20 border border-white/5 flex items-center justify-center text-violet-400 font-black text-xl">
                          {agent.name.charAt(0)}
                        </div>
                        <div>
                          <div className="font-black text-lg text-white group-hover:text-violet-400 transition-colors">{agent.name}</div>
                          <div className="text-sm text-slate-500 font-medium">{agent.email} • {agent.licenseNumber}</div>
                        </div>
                      </div>
                      <div className="flex items-center gap-8">
                        <div className="text-right">
                          <p className="text-[10px] font-black tracking-widest text-slate-500">{t("client.src.sales_volume")}</p>
                          <p className="font-black text-white text-lg">{t("client.src.24m")}</p>
                        </div>
                        <div className="h-10 w-px bg-white/5" />
                        <div className="hidden md:block">
                           <Badge variant="outline" className="bg-emerald-500/10 text-emerald-500 border-none px-3 font-bold">{t("client.src.active_listing_12")}</Badge>
                        </div>
                        <Button variant="ghost" className="h-12 w-12 rounded-xl group-hover:bg-violet-600 transition-all"><ArrowRight className="w-5 h-5 text-white" /></Button>
                      </div>
                    </motion.div>)}
                </CardContent>
              </Card>
            </motion.div>}

          {viewMode === "partners" && <motion.div initial={{
          opacity: 0,
          scale: 0.98
        }} animate={{
          opacity: 1,
          scale: 1
        }} exit={{
          opacity: 0,
          scale: 0.98
        }} className="space-y-8">
               <Card className="bg-gradient-to-br from-violet-600/20 to-indigo-600/10 border-violet-500/30 rounded-3xl p-8 md:p-12 relative overflow-hidden">
                  <Sparkles className="absolute top-10 right-10 w-32 h-32 opacity-10 text-violet-300" />
                  <div className="max-w-2xl space-y-6">
                     <Badge className="bg-white text-black font-black px-4 py-1.5 rounded-lg h-8">{t("client.src.new_feature")}</Badge>
                     <h2 className="text-4xl md:text-6xl font-black text-white tracking-tighter italic">{t("client.src.partner_network_waitlist")}</h2>
                     <p className="text-slate-200 text-lg md:text-xl font-medium leading-relaxed opacity-80">{t("client.src.manage_freelance_consultants_who")}</p>
                     <Button className="bg-white text-black hover:bg-slate-200 font-black h-14 px-10 rounded-2xl text-lg shadow-2xl">{t("client.src.start_partner_onboarding")}</Button>
                  </div>
               </Card>

               <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                  {[{
              name: "Julian Sterling",
              type: "Luxury Housing",
              exp: "8 Years",
              rating: "4.8",
              status: "Pending"
            }, {
              name: "Sarah Jenkins",
              type: "Commercial / Office",
              exp: "5 Years",
              rating: "4.9",
              status: "Accepted"
            }, {
              name: "David Chen",
              type: "Land Development",
              exp: "12 Years",
              rating: "5.0",
              status: "Pending"
            }].map((p, i) => <Card key={i} className="bg-[#14151a]/60 border-slate-800/50 rounded-3xl p-6 space-y-6 group hover:border-violet-600/40 transition-all">
                       <div className="flex items-center gap-4">
                          <div className="w-16 h-16 rounded-2xl bg-slate-900 border border-white/5 flex items-center justify-center text-slate-500 font-black text-2xl group-hover:text-violet-400 transition-colors">{p.name.charAt(0)}</div>
                          <div>
                             <h4 className="text-white font-black text-lg">{p.name}</h4>
                             <p className="text-slate-500 text-xs font-bold tracking-widest">{p.type}</p>
                          </div>
                       </div>
                       <div className="grid grid-cols-2 gap-4 py-4 border-y border-white/5">
                          <div><p className="text-[10px] font-black text-slate-600">{t("client.src.experience")}</p><p className="text-white font-bold">{p.exp}</p></div>
                          <div><p className="text-[10px] font-black text-slate-600">{t("client.src.score")}</p><p className="text-amber-400 font-bold flex items-center gap-1">{p.rating} <Star className="w-3 h-3 fill-amber-400" /></p></div>
                       </div>
                       <div className="pt-2">
                          <Button className={cn("w-full rounded-xl font-black h-11", p.status === "Accepted" ? "bg-emerald-500/10 text-emerald-400" : "bg-violet-600 hover:bg-violet-500 text-white")}>
                             {p.status === "Accepted" ? "Protocol Signatures" : "View Offer"}
                          </Button>
                       </div>
                    </Card>)}
               </div>
            </motion.div>}

          {viewMode === "performance" && <motion.div initial={{
          opacity: 0,
          scale: 0.95
        }} animate={{
          opacity: 1,
          scale: 1
        }} exit={{
          opacity: 0
        }} className="space-y-10">
              <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
                {[{
              label: t("client.src.total_volume"),
              value: "$28.4M",
              icon: TrendingUp,
              trend: "+12.4%",
              trendUp: true
            }, {
              label: t("client.src.active_consultant"),
              value: agents.length,
              icon: Users,
              trend: "-2",
              trendUp: false
            }, {
              label: t("client.src.avg_sale_time"),
              value: "18 Days",
              icon: Zap,
              trend: "-4 Days",
              trendUp: true
            }].map((s, i) => <Card key={i} className="bg-[#14151a]/80 border-slate-800/50 rounded-3xl p-8 space-y-6">
                    <div className="flex justify-between items-start">
                       <div className="w-12 h-12 rounded-2xl bg-white/5 border border-white/5 flex items-center justify-center">
                          <s.icon className="w-6 h-6 text-violet-400" />
                       </div>
                       <Badge className={cn("bg-transparent border-none font-black flex items-center gap-1 text-sm", s.trendUp ? "text-emerald-400" : "text-rose-400")}>
                         {s.trendUp ? <TrendingUp className="w-4 h-4" /> : <TrendingDown className="w-4 h-4" />} {s.trend}
                       </Badge>
                    </div>
                    <div>
                       <p className="text-slate-500 font-black text-[10px] tracking-widest leading-loose">{s.label}</p>
                       <p className="text-4xl font-black text-white tracking-tighter">{s.value}</p>
                    </div>
                  </Card>)}
              </div>
            </motion.div>}
        </AnimatePresence>
      </div>
    </div>;
}