"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import React, { useState } from "react";
import { m, AnimatePresence } from "framer-motion";
import { Sparkles, ChevronRight, Eye, Clapperboard, Globe, CheckCircle2, TrendingUp, Calendar, ShieldCheck, Zap, Play } from "lucide-react";
import Image from "next/image";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
export default function NeuralReview() {
  const {
    t
  } = useTranslation();
  const [activeTab, setActiveTab] = useState("comparison");
  const [isApproved, setIsApproved] = useState(false);
  const [showConfetti, setShowConfetti] = useState(false);
  const handleApprove = () => {
    setIsApproved(true);
    setTimeout(() => setShowConfetti(true), 500);
  };
  return <div className="min-h-screen bg-[#06070a] text-white selection:bg-blue-500/30">
      {/* Cinematic Background Gradient */}
      <div className="fixed inset-0 overflow-hidden pointer-events-none">
        <div className="absolute top-[-10%] left-[-10%] w-[40%] h-[40%] bg-blue-600/10 blur-[120px] rounded-full" />
        <div className="absolute bottom-[-10%] right-[-10%] w-[40%] h-[40%] bg-blue-600/10 blur-[120px] rounded-full" />
      </div>

      <div className="relative z-10 max-w-7xl mx-auto px-6 py-12">
        {/* Header Section */}
        <header className="flex flex-col md:flex-row md:items-end justify-between gap-8 mb-16">
          <div className="space-y-4">
            <Badge variant="outline" className="bg-blue-500/10 text-blue-400 border-blue-500/20 px-4 py-1 text-xs font-black tracking-widest italic">{t("client.src.neural_reel_ready")}</Badge>
            <h1 className="text-5xl md:text-7xl font-black italic tracking-tighter leading-none">{t("client.src.revolutionize")}<br />{t("client.src.your_property")}</h1>
            <p className="text-slate-400 max-w-xl text-lg font-medium leading-relaxed">{t("client.src.your_agent_has_prepared")}<span className="text-white">{t("client.src.123_sunset_boulevard")}</span>{t("client.src.review_the_cinematic_transformation")}</p>
          </div>
          <div className="flex items-center gap-4">
             <div className="text-right hidden md:block">
                <p className="text-[10px] font-black text-slate-500 tracking-widest leading-none">{t("client.src.market_readiness")}</p>
                <p className="text-2xl font-black italic text-blue-500">{t("client.src.98_optimized")}</p>
             </div>
             <div className="p-4 bg-white/5 border border-white/10 rounded-2xl">
                <TrendingUp className="w-8 h-8 text-blue-500" />
             </div>
          </div>
        </header>

        {/* Action Tabs */}
        <div className="flex gap-4 mb-8 overflow-x-auto pb-4 scrollbar-hide">
          {[{
          id: "comparison",
          label: t("client.src.transformation"),
          icon: Zap
        }, {
          id: "video",
          label: t("client.src.neural_reel"),
          icon: Clapperboard
        }, {
          id: "market",
          label: t("client.src.market_reach"),
          icon: Globe
        }, {
          id: "roi",
          label: t("client.src.earnings_forecast"),
          icon: TrendingUp
        }].map(tab => <button key={tab.id} onClick={() => setActiveTab(tab.id)} className={`flex items-center gap-2 px-6 py-4 rounded-2xl text-xs font-black  tracking-widest transition-all duration-300 border ${activeTab === tab.id ? "bg-white text-black border-white shadow-[0_0_30px_rgba(255,255,255,0.15)] scale-105" : "bg-white/5 text-slate-400 border-white/5 hover:bg-white/10 hover:border-white/10"}`}>
              <tab.icon className="w-4 h-4" />
              {tab.label}
            </button>)}
        </div>

        {/* Main Content Area */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          <div className="lg:col-span-2 space-y-8">
             <AnimatePresence mode="wait">
               {activeTab === "comparison" && <m.div key="comparison" initial={{
              opacity: 0,
              x: -20
            }} animate={{
              opacity: 1,
              x: 0
            }} exit={{
              opacity: 0,
              x: 20
            }} className="relative group rounded-3xl overflow-hidden border border-white/10 shadow-2xl h-[500px]">
                    {/* Simulated Comparison Slider */}
                    <Image src="https://images.unsplash.com/photo-1600585154340-be6161a56a0c" alt={t("client.src.modern_home")} fill className="object-cover" priority sizes="(max-width: 1024px) 100vw, 66vw" />
                    <div className="absolute inset-0 bg-black/40 flex items-center justify-center group-hover:bg-black/20 transition-all duration-500">
                       <div className="flex items-center gap-8 px-12">
                          <div className="text-center space-y-2">
                             <Badge className="bg-orange-500 font-black italic">{t("client.src.before_mls")}</Badge>
                             <p className="text-xs text-slate-300 font-medium">{t("client.src.standard_static_photo")}</p>
                          </div>
                          <div className="w-px h-16 bg-white/20" />
                          <div className="text-center space-y-2">
                             <Badge className="bg-blue-500 font-black italic border-0 shadow-[0_0_20px_rgba(16,185,129,0.4)]">{t("client.src.after_neural")}</Badge>
                             <p className="text-xs text-slate-300 font-medium">{t("client.src.ai_restaged_polished")}</p>
                          </div>
                       </div>
                    </div>
                    <div className="absolute bottom-8 left-8 right-8 p-6 bg-black/60 backdrop-blur-xl border border-white/5 rounded-2xl flex justify-between items-center">
                       <div>
                          <h2 className="text-lg font-black italic">{t("client.src.neural_restaging_active")}</h2>
                          <p className="text-xs text-slate-400">{t("client.src.virtual_furniture_lighting_optimization")}</p>
                       </div>
                       <Button variant="ghost" className="text-xs font-black tracking-widest text-blue-400">{t("client.src.view_gallery")}<ChevronRight className="w-4 h-4 ml-2" />
                       </Button>
                    </div>
                 </m.div>}

               {activeTab === "video" && <m.div key="video" initial={{
              opacity: 0,
              scale: 0.95
            }} animate={{
              opacity: 1,
              scale: 1
            }} className="relative rounded-3xl overflow-hidden border border-white/10 aspect-video bg-black flex items-center justify-center">
                    <div className="absolute inset-0 opacity-40">
                       <Image src="https://images.unsplash.com/photo-1600607687920-4e2a09cf159d" alt={t("client.src.video_background")} fill className="object-cover" loading="lazy" sizes="(max-width: 1024px) 100vw, 66vw" />
                    </div>
                    <div className="relative z-10 flex flex-col items-center gap-6">
                       <div className="w-20 h-20 bg-blue-500 rounded-full flex items-center justify-center shadow-[0_0_40px_rgba(16,185,129,0.5)] cursor-pointer hover:scale-110 transition-transform">
                          <Play className="w-8 h-8 text-white ml-1 fill-current" />
                       </div>
                        <h2 className="text-2xl font-black italic tracking-tighter">{t("client.src.preview_neural_reel")}</h2>
                       <p className="text-sm text-slate-300">{t("client.src.generated_for_instagram_tiktok")}</p>
                    </div>
                 </m.div>}
             </AnimatePresence>

             {/* Dynamic Stats Grid */}
             <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                {[{
              label: t("client.src.reach_multiplier"),
              val: "12X",
              icon: Globe
            }, {
              label: t("client.src.est_booking_velocity"),
              val: "+45%",
              icon: Calendar
            }, {
              label: t("client.src.neural_clarity_score"),
              val: "94/100",
              icon: Sparkles
            }, {
              label: t("client.src.global_translation"),
              val: "14 Lang",
              icon: Globe
            }].map((stat, i) => <div key={i} className="p-4 bg-white/5 border border-white/5 rounded-2xl space-y-1">
                     <p className="text-[9px] font-black text-slate-500 tracking-widest leading-none">{stat.label}</p>
                     <p className="text-xl font-black italic text-white flex items-center gap-2">
                        {stat.val}
                        <stat.icon className="w-3 h-3 text-blue-500" />
                     </p>
                  </div>)}
             </div>
          </div>

          <div className="space-y-6">
             <Card className="bg-[#0f1014] border-white/10 rounded-[32px] overflow-hidden shadow-2xl sticky top-24">
                <CardContent className="p-8 space-y-8">
                   <div className="space-y-2">
                      <h2 className="text-2xl font-black italic tracking-tighter">{t("client.src.go_global_with_reservatior")}</h2>
                      <p className="text-sm text-slate-400 font-medium leading-relaxed">{t("client.src.by_approving_this_modernization")}</p>
                   </div>

                   <div className="space-y-6">
                      {[{
                  title: t("client.src.ai_generated_contracts"),
                  icon: ShieldCheck
                }, {
                  title: t("client.src.direct_payout_terminal"),
                  icon: Zap
                }, {
                  title: t("client.src.live_activity_tracking"),
                  icon: Eye
                }].map((feature, i) => <div key={i} className="flex items-center gap-4">
                           <div className="p-2 bg-blue-500/10 rounded-lg">
                              <feature.icon className="w-4 h-4 text-blue-500" />
                           </div>
                           <span className="text-xs font-black text-slate-300 tracking-widest">{feature.title}</span>
                        </div>)}
                   </div>

                   <div className="space-y-4 pt-4 border-t border-white/5">
                      <div className="flex justify-between items-center text-xs font-black tracking-widest">
                         <span className="text-slate-500">{t("client.src.approval_progress")}</span>
                         <span className="text-blue-500">{t("client.src.ready_to_launch")}</span>
                      </div>
                      <Progress value={isApproved ? 100 : 75} className="h-2 bg-white/5" />
                   </div>

                   {!isApproved ? <Button onClick={handleApprove} className="w-full h-20 rounded-2xl bg-white hover:bg-blue-500 hover:text-white text-black font-black tracking-widest shadow-2xl transition-all duration-300 flex flex-col items-center justify-center group">
                        <span className="group-hover:scale-110 transition-transform">{t("client.src.approve_hub_launch")}</span>
                        <span className="text-[9px] opacity-60 font-medium">{t("client.src.onboard_to_reservatior_ecosystem")}</span>
                     </Button> : <div className="space-y-4">
                        <Button className="w-full h-20 rounded-2xl bg-blue-600/20 border border-blue-500/30 text-blue-500 font-black tracking-widest cursor-default">
                           <CheckCircle2 className="w-6 h-6 mr-3" />{t("client.src.onboarding_in_progress")}</Button>
                        <p className="text-center text-[10px] text-slate-500 font-black tracking-widest">{t("client.src.redirecting_to_host_dashboard")}</p>
                     </div>}

                   <div className="text-center">
                      <button className="text-[10px] font-black text-slate-500 hover:text-white transition-colors tracking-widest">{t("client.src.decline_modernization")}</button>
                   </div>
                </CardContent>
             </Card>

             <div className="bg-blue-600/10 border border-blue-500/20 rounded-[32px] p-6 space-y-4">
                <div className="flex items-center gap-3">
                   <div className="w-10 h-10 rounded-full bg-blue-500 flex items-center justify-center">
                      <Zap className="w-5 h-5 text-white" />
                   </div>
                   <div>
                       <h3 className="text-[10px] font-black tracking-widest text-slate-400 leading-none">{t("client.src.ai_agent_assigned")}</h3>
                      <p className="text-sm font-black italic text-white">{t("client.src.neural_skipper_v40")}</p>
                   </div>
                </div>
                <p className="text-[10px] text-blue-300 font-medium italic leading-relaxed">{t("client.src.weve_analyzed_450_similar")}</p>
             </div>
          </div>
        </div>
      </div>
    </div>;
}