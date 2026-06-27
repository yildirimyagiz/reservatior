import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useSearchParams } from "react-router-dom";
import React, { useState } from "react";
import { motion } from "framer-motion";
import { Card, CardContent, CardHeader, CardTitle, CardDescription, CardFooter } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Switch } from "@/components/ui/switch";
import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { CheckCircle2, Zap, Video, Globe, BarChart4, Sparkles, Crown, Building2, Instagram, Film, Languages, ArrowRight, UserPlus, Users2, Briefcase, Rocket, Clock, TrendingUp, MapPin, Mic2, Cpu, BrainCircuit, Settings2 } from "lucide-react";
import { cn } from "@/lib/utils";
import { PageShell } from "../../client/layout/PageShell";

// ── Types ──────────────────────────────────────────────────────────────────
interface PricingPlan {
  id: string;
  name: string;
  description: string;
  priceMonthly: number;
  priceYearly: number;
  currency: string;
  badge?: string;
  isPopular?: boolean;
  limits: {
    properties: string;
    listings: string;
    aiProcessing: string; // New: AI credits/month
    gpuPriority: "Standard" | "High" | "Ultra" | "Dedicated";
  };
  features: {
    ml_services: {
      label: string;
      included: boolean;
      icon?: React.ReactNode;
    }[];
    video_editing: {
      label: string;
      included: boolean;
      icon?: React.ReactNode;
    }[];
    marketing: {
      label: string;
      included: boolean;
      icon?: React.ReactNode;
    }[];
    analytics: {
      label: string;
      included: boolean;
      icon?: React.ReactNode;
    }[];
  };
  ctaLabel: string;
}
const INDIVIDUAL_PLANS: PricingPlan[] = [{
  id: "individual-starter",
  name: "AI Starter",
  description: t("client.src.ideal_for_solo_agents"),
  priceMonthly: 79,
  priceYearly: 790,
  currency: "$",
  limits: {
    properties: "5 Properties",
    listings: "5 Listings",
    aiProcessing: "50 AI Scans",
    gpuPriority: "Standard"
  },
  features: {
    ml_services: [{
      label: t("client.src.ai_photo_clarification"),
      included: true,
      icon: <Sparkles className="w-3 h-3 text-emerald-400" />
    }, {
      label: t("client.src.neighborhood_dna_insights"),
      included: true
    }, {
      label: t("client.src.smart_real_estate_assistant"),
      included: false
    }],
    video_editing: [{
      label: t("client.src.standard_hd_export"),
      included: true
    }, {
      label: t("client.src.add_audiomp3_backgrounds"),
      included: true,
      icon: <Mic2 className="w-3 h-3 text-blue-400" />
    }, {
      label: t("client.src.smart_subtitle_generation"),
      included: false
    }],
    marketing: [{
      label: t("client.src.neural_hub_listing_style"),
      included: true
    }, {
      label: t("client.src.social_media_autoposter"),
      included: false
    }],
    analytics: [{
      label: t("client.src.basic_view_analytics"),
      included: true
    }, {
      label: t("client.src.ai_true_comps_analysis"),
      included: false
    }]
  },
  ctaLabel: "Explore Starter"
}, {
  id: "individual-pro",
  name: "AI Pro",
  description: t("client.src.full_ai_toolkit_including"),
  priceMonthly: 149,
  priceYearly: 1490,
  currency: "$",
  badge: "MOST POPULAR",
  isPopular: true,
  limits: {
    properties: "20 Properties",
    listings: "20 Listings",
    aiProcessing: "250 AI Scans",
    gpuPriority: "High"
  },
  features: {
    ml_services: [{
      label: t("client.src.ultrahd_video_enhancement"),
      included: true,
      icon: <Zap className="w-3 h-3 text-orange-400" />
    }, {
      label: t("client.src.neural_content_customization"),
      included: true,
      icon: <Settings2 className="w-3 h-3 text-orange-400" />
    }, {
      label: t("client.src.intelligent_ai_chat_support"),
      included: true,
      icon: <BrainCircuit className="w-3 h-3 text-blue-400" />
    }],
    video_editing: [{
      label: t("client.src.4k_cinematic_exports"),
      included: true
    }, {
      label: t("client.src.multilanguage_global_subtitles"),
      included: true,
      icon: <Languages className="w-3 h-3 text-violet-400" />
    }, {
      label: t("client.src.realtime_ai_video_dubbing"),
      included: false
    }],
    marketing: [{
      label: t("client.src.doping_priority_5month"),
      included: true
    }, {
      label: t("client.src.auto_social_reel_generation"),
      included: true,
      icon: <Instagram className="w-3 h-3 text-pink-500" />
    }],
    analytics: [{
      label: t("client.src.full_roi_dashboard"),
      included: true
    }, {
      label: t("client.src.predictive_market_trends"),
      included: true
    }]
  },
  ctaLabel: "Upgrade to Pro"
}];
const AGENCY_PLANS: PricingPlan[] = [{
  id: "agency-standard",
  name: "Agency Scale",
  description: t("client.src.total_team_coordination_with"),
  priceMonthly: 299,
  priceYearly: 2990,
  currency: "$",
  limits: {
    properties: "50 Properties",
    listings: "50 Listings",
    aiProcessing: "Unlimited Photos",
    gpuPriority: "Ultra"
  },
  features: {
    ml_services: [{
      label: t("client.src.unlimited_highresolution_media"),
      included: true,
      icon: <Sparkles className="w-3 h-3 text-emerald-400" />
    }, {
      label: t("client.src.hyperfast_cloud_processing"),
      included: true,
      icon: <Cpu className="w-3 h-3 text-violet-400" />
    }, {
      label: t("client.src.regional_translation_hub"),
      included: true,
      icon: <Globe className="w-3 h-3 text-blue-400" />
    }],
    video_editing: [{
      label: t("client.src.full_neural_dubbing_ai"),
      included: true,
      icon: <Mic2 className="w-3 h-3 text-blue-400" />
    }, {
      label: t("client.src.whitelabel_video_branding"),
      included: true
    }, {
      label: t("client.src.batch_video_processing"),
      included: true
    }],
    marketing: [{
      label: t("client.src.agencywide_doping_20mo"),
      included: true
    }, {
      label: t("client.src.agent_recruiting_portal"),
      included: true
    }],
    analytics: [{
      label: t("client.src.team_performance_metrics"),
      included: true
    }, {
      label: t("client.src.mls_data_synchronization"),
      included: true
    }]
  },
  ctaLabel: "Agency Package"
}, {
  id: "agency-elite",
  name: "Agency Elite",
  description: t("client.src.dedicated_server_node_for"),
  priceMonthly: 499,
  priceYearly: 4990,
  currency: "$",
  badge: "ENTERPRISE",
  limits: {
    properties: "Unlimited",
    listings: "Unlimited",
    aiProcessing: "Dedicated Node",
    gpuPriority: "Dedicated"
  },
  features: {
    ml_services: [{
      label: t("client.src.dedicated_neural_server_node"),
      included: true,
      icon: <Rocket className="w-3 h-3 text-rose-500" />
    }, {
      label: t("client.src.custom_model_personalization"),
      included: true,
      icon: <BrainCircuit className="w-3 h-3 text-emerald-400" />
    }, {
      label: t("client.src.api_direct_hub_access"),
      included: true
    }],
    video_editing: [{
      label: t("client.src.realtime_virtual_tours"),
      included: true,
      icon: <Film className="w-3 h-3 text-yellow-500" />
    }, {
      label: t("client.src.cinematic_drone_ai_simulated"),
      included: true
    }, {
      label: t("client.src.multilingual_ai_avatars"),
      included: true,
      icon: <Users2 className="w-3 h-3 text-emerald-400" />
    }],
    marketing: [{
      label: t("client.src.unlimited_doping_standard"),
      included: true,
      icon: <Zap className="w-3 h-3 text-amber-400" />
    }, {
      label: t("client.src.global_mls_distribution"),
      included: true
    }],
    analytics: [{
      label: t("client.src.advanced_market_dna_reports"),
      included: true
    }, {
      label: t("client.src.custom_data_export_jsoncsv"),
      included: true
    }]
  },
  ctaLabel: "Contact Sales"
}];
export default function SubscriptionsPage() {
  const {
    t
  } = useTranslation();
  const [searchParams] = useSearchParams();
  const isVipPromo = searchParams.get("promo") === "VIPTR";

  const [isAnnual, setIsAnnual] = useState(false);
  const [activeTab, setActiveTab] = useState<"individual" | "agency">("individual");
  const basePlans = activeTab === "individual" ? INDIVIDUAL_PLANS : AGENCY_PLANS;
  
  // Eğer VIP promosyonu varsa fiyatları %50 düşür ve butonları değiştir
  const plans = basePlans.map(plan => {
    if (!isVipPromo) return plan;
    return {
      ...plan,
      priceMonthly: plan.priceMonthly * 0.5,
      priceYearly: plan.priceYearly * 0.5,
      ctaLabel: "2 Ay Ücretsiz Dene"
    };
  });
  return <PageShell title={t("client.src.membership_plans")} description={t("client.src.neuralpowered_real_estate_tiers")}>
      <div className="p-4 lg:p-8 space-y-12 bg-[#0a0b0d] min-h-full text-slate-200">
        
        {/* Header Section */}
        <div className="text-center max-w-4xl mx-auto space-y-6 pt-10">
          <motion.div initial={{
          opacity: 0,
          scale: 0.9
        }} animate={{
          opacity: 1,
          scale: 1
        }} className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-orange-500/10 border border-orange-500/20 text-orange-400 text-[10px] font-black tracking-widest mb-2">
            <Sparkles className="w-4 h-4" />{t("client.src.ai_media_infrastructure")}</motion.div>
          
          {isVipPromo && (
            <motion.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} className="bg-gradient-to-r from-emerald-500/20 to-teal-500/20 border border-emerald-500/30 text-emerald-300 p-4 rounded-xl mb-6 shadow-lg shadow-emerald-500/10">
              <div className="flex items-center justify-center gap-2 font-bold text-lg">
                <Crown className="w-6 h-6 text-emerald-400" />
                <span>VIP Emlakçı Kampanyası Aktif!</span>
              </div>
              <p className="text-emerald-100/80 text-sm mt-1">İlk 2 Ay Tamamen Ücretsiz! 3. Ay %50 İndirim (Sonrasında Standart Ücret)</p>
            </motion.div>
          )}

          <h1 className="text-4xl md:text-6xl font-black text-white italic tracking-tighter">{t("client.src.neural")}<span className="text-orange-500 underline decoration-white/10 underline-offset-8">{t("client.src.pricing")}</span>{t("client.src.matrix")}</h1>
          <p className="text-slate-400 text-lg max-w-2xl mx-auto font-medium italic">{t("client.src.transform_the_real_estate")}</p>
          
          <div className="pt-4 flex flex-col items-center gap-8">
            <Tabs value={activeTab} onValueChange={v => setActiveTab(v as any)} className="bg-[#14151a]/60 backdrop-blur-xl border border-white/5 p-1 rounded-2xl">
              <TabsList className="bg-transparent gap-2 h-14">
                <TabsTrigger value="individual" className="rounded-xl data-[state=active]:bg-orange-600 data-[state=active]:text-white font-black tracking-widest text-[10px] px-10">{t("client.src.solo_agent")}</TabsTrigger>
                <TabsTrigger value="agency" className="rounded-xl data-[state=active]:bg-orange-600 data-[state=active]:text-white font-black tracking-widest text-[10px] px-10">{t("client.src.global_agency")}</TabsTrigger>
              </TabsList>
            </Tabs>

            <div className="flex items-center gap-6">
              <span className={cn("text-[10px] font-black  tracking-widest", !isAnnual ? "text-orange-400" : "text-slate-500")}>{t("client.src.monthly")}</span>
              <Switch checked={isAnnual} onCheckedChange={setIsAnnual} className="data-[state=checked]:bg-orange-600 shadow-xl shadow-orange-600/20" />
              <span className={cn("text-[10px] font-black  tracking-widest flex items-center gap-2", isAnnual ? "text-orange-400" : "text-slate-500")}>{t("client.src.annual")}<Badge className="bg-emerald-500/10 text-emerald-400 border-none text-[9px] font-black italic">{t("client.src.20_off")}</Badge>
              </span>
            </div>
          </div>
        </div>

        {/* Pricing Cards */}
        <div className={cn("grid grid-cols-1 gap-8 max-w-7xl mx-auto auto-rows-fr mt-20 pb-20", "md:grid-cols-2")}>
          {plans.map((plan, idx) => {
          const price = isAnnual ? plan.priceYearly : plan.priceMonthly;
          return <motion.div key={plan.id} initial={{
            opacity: 0,
            y: 30
          }} animate={{
            opacity: 1,
            y: 0
          }} transition={{
            delay: idx * 0.1
          }}>
                <Card className={cn("w-full h-full relative overflow-hidden bg-[#14151a]/40 backdrop-blur-3xl border-white/5 rounded-[40px] flex flex-col transition-all duration-300 group hover:border-orange-500/30", plan.isPopular && "border-orange-500/40 shadow-2xl scale-[1.03] z-10")}>
                  {plan.badge && <div className="absolute top-6 left-6 z-20">
                      <Badge className="bg-orange-600 text-white text-[9px] font-black tracking-widest px-4 py-1.5 border-none shadow-xl">
                        {plan.badge}
                      </Badge>
                    </div>}

                  <CardHeader className="text-center pt-20 pb-10 px-10">
                    <CardTitle className="text-3xl font-black text-white italic tracking-tighter mb-2">{plan.name}</CardTitle>
                    <CardDescription className="text-slate-500 text-xs font-medium tracking-widest italic">{plan.description}</CardDescription>
                    <div className="mt-8 flex justify-center items-end gap-1">
                      <span className="text-6xl font-black text-white tracking-tighter italic">${parseInt(price.toString()).toLocaleString()}</span>
                      <span className="text-slate-500 text-xs font-black tracking-widest pb-3">/{isAnnual ? 'Year' : 'Mo'}</span>
                    </div>
                  </CardHeader>

                  <CardContent className="flex-1 space-y-10 px-10 pb-10">
                    {/* Performance Counters */}
                    <div className="grid grid-cols-2 gap-4 p-6 rounded-3xl bg-white/5 border border-white/5 relative overflow-hidden">
                       <div className="space-y-1">
                          <p className="text-[10px] font-black text-slate-500 tracking-widest italic">{t("client.src.inventory")}</p>
                          <p className="text-lg font-black text-white italic">{plan.limits.properties}</p>
                       </div>
                       <div className="space-y-1">
                          <p className="text-[10px] font-black text-slate-500 tracking-widest italic">{t("client.src.ai_processing")}</p>
                          <p className="text-lg font-black text-orange-400 italic">{plan.limits.aiProcessing}</p>
                       </div>
                       <div className="col-span-2 space-y-1 pt-4 border-t border-white/5">
                          <p className="text-[10px] font-black text-slate-500 tracking-widest italic">{t("client.src.gpu_priority")}</p>
                          <p className="text-lg font-black text-blue-400 italic flex items-center gap-2">
                             <Cpu className="w-4 h-4" /> {plan.limits.gpuPriority}{t("client.src.node")}</p>
                       </div>
                    </div>

                    <div className="space-y-8">
                       {Object.entries(plan.features).map(([key, list]) => <div key={key} className="space-y-4">
                            <h4 className="text-[10px] font-black text-white tracking-[0.2em] italic border-b border-white/5 pb-2">{key.replace('_', ' ')}</h4>
                            <ul className="space-y-3">
                               {list.map((feature, i) => <li key={i} className="flex items-center gap-4 text-xs font-medium group/feat">
                                    <div className={cn("w-5 h-5 rounded-lg flex items-center justify-center transition-all", feature.included ? "bg-orange-500/10 text-orange-400" : "bg-slate-800 text-slate-600")}>
                                       {feature.included ? <CheckCircle2 className="w-3.5 h-3.5" /> : <Clock className="w-3.5 h-3.5" />}
                                    </div>
                                    <span className={cn("flex-1 italic tracking-tight", feature.included ? "text-slate-200" : "text-slate-500")}>
                                       {feature.label}
                                    </span>
                                    {feature.included && feature.icon && <span className="opacity-50 group-hover/feat:opacity-100 transition-all">{feature.icon}</span>}
                                 </li>)}
                            </ul>
                         </div>)}
                    </div>
                  </CardContent>

                  <CardFooter className="p-10 pt-0">
                    <Button className={cn("w-full h-16 rounded-2xl font-black  tracking-[0.2em] text-xs transition-all", plan.isPopular ? "bg-orange-600 hover:bg-orange-500 text-white shadow-2xl shadow-orange-600/30" : "bg-white/5 hover:bg-white/10 text-white border border-white/5")}>
                      {plan.ctaLabel} <ArrowRight className="w-4 h-4 ml-2" />
                    </Button>
                  </CardFooter>
                </Card>
              </motion.div>;
        })}
        </div>

        {/* Partnership / Hybrid Action */}
        <div className="max-w-7xl mx-auto pb-20">
           <Card className="bg-linear-to-r from-orange-600/10 to-transparent border-white/5 rounded-[50px] p-12 overflow-hidden relative">
              <div className="flex flex-col md:flex-row items-center gap-10 relative z-10">
                 <div className="flex-1 space-y-6">
                    <Badge className="bg-emerald-500/10 text-emerald-400 border-none px-4 py-1.5 font-black italic tracking-widest text-[10px]">{t("client.src.neural_freelance_network")}</Badge>
                    <h2 className="text-4xl md:text-5xl font-black text-white italic tracking-tighter leading-none">{t("client.src.agency_freelance")}<br />{t("client.src.hybrid_synergy")}</h2>
                    <p className="text-slate-400 text-lg italic font-medium leading-relaxed">{t("client.src.join_an_agency_with")}</p>
                    <div className="flex gap-4 pt-4">
                       <Button className="h-14 px-10 rounded-2xl bg-white text-black font-black text-xs tracking-widest">{t("client.src.explore_agency")}</Button>
                       <Button variant="outline" className="h-14 px-10 rounded-2xl border-white/5 bg-white/5 text-white font-black text-xs tracking-widest">{t("client.src.become_agent")}</Button>
                    </div>
                 </div>
                 <div className="w-full md:w-80 bg-[#14151a] border border-white/5 rounded-4xl p-8 shadow-2xl">
                    <div className="flex items-center gap-3 mb-6">
                       <div className="w-10 h-10 bg-orange-600/20 rounded-xl flex items-center justify-center text-orange-500">
                          <BrainCircuit className="w-5 h-5" />
                       </div>
                       <p className="text-sm font-black text-white italic">{t("client.src.neural_network_benefits")}</p>
                    </div>
                    <ul className="space-y-4">
                       {["ZK-Registry Verified Identity", "Model Sharing Infrastructure", "Shared GPU Pool", "Blockchain Revenue Distribution"].map((t, i) => <li key={i} className="flex items-center gap-3 text-xs font-medium text-slate-400 italic">
                            <CheckCircle2 className="w-3.5 h-3.5 text-emerald-500" /> {t}
                         </li>)}
                    </ul>
                 </div>
              </div>
           </Card>
        </div>
      </div>
    </PageShell>;
}