"use client";

import { t } from "i18next";
import React, { useState, useEffect } from "react";
import { motion } from "framer-motion";
import { Card, CardContent, CardHeader, CardTitle, CardDescription, CardFooter } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Switch } from "@/components/ui/switch";
import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { CheckCircle2, Zap, BarChart4, Sparkles, Crown, Instagram, Film, Languages, ArrowRight, Clock, TrendingUp, Mic2, Cpu, BrainCircuit, Settings2, Sliders, Shield, RefreshCw } from "lucide-react";
import { cn } from "@/lib/utils";
import { PageShell } from "../../client/layout/PageShell";
import { apiClient } from "@/lib/api/client";

interface PartnerAgreement {
  id: string;
  tenantId: string;
  status: string;
  terms?: {
    initial_move_in_cost_subsidy: number;
    monthly_commission_schedule: { month: number; rate: number }[];
    loyalty_yield_multipliers: { month: number; multiplier: number }[];
  };
}

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
    gpuPriority: string;
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
const AGENCY_PLANS: PricingPlan[] = [
  {
    id: "agency-starter",
    name: "STARTER",
    description: t("client.src.plans.plan_desc"),
    priceMonthly: 19,
    priceYearly: 190,
    currency: "$",
    limits: {
      properties: t("client.src.plans.prop_limit_10"),
      listings: t("client.src.plans.listing_limit_25"),
      aiProcessing: t("client.src.plans.support_email"),
      gpuPriority: t("client.src.plans.user_access_1")
    },
    features: {
      ml_services: [
        { label: t("client.src.plans.prop_limit_10"), included: true },
        { label: t("client.src.plans.user_access_1"), included: true },
        { label: t("client.src.plans.listing_limit_25"), included: true }
      ],
      video_editing: [],
      marketing: [
        { label: t("client.src.plans.support_email"), included: true }
      ],
      analytics: []
    },
    ctaLabel: t("client.src.plans.get_started")
  },
  {
    id: "agency-growth",
    name: "GROWTH",
    description: t("client.src.plans.plan_desc"),
    priceMonthly: 49,
    priceYearly: 490,
    currency: "$",
    badge: t("client.src.plans.badge_optimized"),
    limits: {
      properties: t("client.src.plans.prop_limit_25"),
      listings: t("client.src.plans.listing_limit_100"),
      aiProcessing: t("client.src.plans.support_email"),
      gpuPriority: t("client.src.plans.user_access_3")
    },
    features: {
      ml_services: [
        { label: t("client.src.plans.prop_limit_25"), included: true },
        { label: t("client.src.plans.user_access_3"), included: true },
        { label: t("client.src.plans.listing_limit_100"), included: true }
      ],
      video_editing: [],
      marketing: [
        { label: t("client.src.plans.support_email"), included: true }
      ],
      analytics: []
    },
    ctaLabel: t("client.src.plans.get_started")
  },
  {
    id: "agency-pro",
    name: "PRO",
    description: t("client.src.plans.plan_desc"),
    priceMonthly: 80,
    priceYearly: 800,
    currency: "$",
    badge: t("client.src.plans.badge_optimized"),
    isPopular: true,
    limits: {
      properties: t("client.src.plans.prop_limit_50"),
      listings: t("client.src.plans.listing_limit_250"),
      aiProcessing: t("client.src.plans.ai_analysis"),
      gpuPriority: t("client.src.plans.user_access_5")
    },
    features: {
      ml_services: [
        { label: t("client.src.plans.prop_limit_50"), included: true },
        { label: t("client.src.plans.user_access_5"), included: true },
        { label: t("client.src.plans.listing_limit_250"), included: true }
      ],
      video_editing: [
        { label: t("client.src.plans.ai_analysis"), included: true, icon: <BrainCircuit className="w-3 h-3 text-blue-400" /> }
      ],
      marketing: [
        { label: t("client.src.plans.support_24_7"), included: true }
      ],
      analytics: []
    },
    ctaLabel: t("client.src.plans.get_started")
  },
  {
    id: "agency-agency",
    name: "AGENCY",
    description: t("client.src.plans.plan_desc"),
    priceMonthly: 150,
    priceYearly: 1500,
    currency: "$",
    limits: {
      properties: t("client.src.plans.prop_limit_100"),
      listings: t("client.src.plans.listing_limit_500"),
      aiProcessing: t("client.src.plans.ai_analysis"),
      gpuPriority: t("client.src.plans.user_access_10")
    },
    features: {
      ml_services: [
        { label: t("client.src.plans.prop_limit_100"), included: true },
        { label: t("client.src.plans.user_access_10"), included: true },
        { label: t("client.src.plans.listing_limit_500"), included: true }
      ],
      video_editing: [
        { label: t("client.src.plans.ai_analysis"), included: true, icon: <BrainCircuit className="w-3 h-3 text-blue-400" /> }
      ],
      marketing: [
        { label: t("client.src.plans.support_24_7"), included: true }
      ],
      analytics: []
    },
    ctaLabel: t("client.src.plans.get_started")
  },
  {
    id: "agency-enterprise",
    name: "ENTERPRISE",
    description: t("client.src.plans.plan_desc"),
    priceMonthly: 0,
    priceYearly: 0,
    currency: "$",
    badge: t("client.src.plans.badge_enterprise"),
    limits: {
      properties: t("client.src.plans.prop_limit_unlimited"),
      listings: t("client.src.plans.listing_limit_unlimited"),
      aiProcessing: t("client.src.plans.ai_analysis"),
      gpuPriority: t("client.src.plans.custom_erp")
    },
    features: {
      ml_services: [
        { label: t("client.src.plans.prop_limit_unlimited"), included: true },
        { label: t("client.src.plans.listing_limit_unlimited"), included: true },
        { label: t("client.src.plans.custom_erp"), included: true }
      ],
      video_editing: [
        { label: t("client.src.plans.ai_analysis"), included: true, icon: <BrainCircuit className="w-3 h-3 text-blue-400" /> }
      ],
      marketing: [
        { label: t("client.src.plans.support_24_7"), included: true }
      ],
      analytics: []
    },
    ctaLabel: t("client.src.plans.contact_sales")
  }
];

const HOTEL_PLANS: PricingPlan[] = [{
  id: "hotel-standard",
  name: "Hotel Operations",
  description: "High volume booking & channel management for boutique hotels",
  priceMonthly: 599,
  priceYearly: 5990,
  currency: "$",
  limits: {
    properties: "10 Properties",
    listings: "Unlimited Rooms",
    aiProcessing: "Dynamic Daily Pricing AI",
    gpuPriority: "Ultra"
  },
  features: {
    ml_services: [{
      label: "Occupancy Predictive AI",
      included: true,
      icon: <Sparkles className="w-3 h-3 text-emerald-400" />
    }, {
      label: "Real-time Competitor Pricing",
      included: true,
      icon: <BarChart4 className="w-3 h-3 text-blue-400" />
    }, {
      label: "Smart Guest Support Chatbot",
      included: true,
      icon: <BrainCircuit className="w-3 h-3 text-orange-400" />
    }],
    video_editing: [{
      label: "Virtual Room Walkthroughs",
      included: true
    }, {
      label: "Multi-language Welcome Videos",
      included: true
    }, {
      label: "AI Neighborhood Guides",
      included: true
    }],
    marketing: [{
      label: "Booking.com & Airbnb Sync",
      included: true,
      icon: <RefreshCw className="w-3 h-3 text-emerald-400" />
    }, {
      label: "Automated Review Replies",
      included: true
    }],
    analytics: [{
      label: "RevPAR & ADR Forecasting",
      included: true
    }, {
      label: "Guest Sentiment Analysis",
      included: true
    }]
  },
  ctaLabel: "Start Hotel Plan"
}];

const APARTMENT_PLANS: PricingPlan[] = [{
  id: "apartment-portfolio",
  name: "Apartment Portfolio",
  description: "Comprehensive lease & maintenance AI for property managers",
  priceMonthly: 899,
  priceYearly: 8990,
  currency: "$",
  badge: "ENTERPRISE",
  limits: {
    properties: "Unlimited Units",
    listings: "Unlimited",
    aiProcessing: "Predictive Maintenance AI",
    gpuPriority: "Dedicated"
  },
  features: {
    ml_services: [{
      label: "AI Tenant Background Check",
      included: true,
      icon: <Shield className="w-3 h-3 text-emerald-400" />
    }, {
      label: "Predictive Maintenance Alerts",
      included: true,
      icon: <Zap className="w-3 h-3 text-orange-400" />
    }, {
      label: "Automated Lease Parsing",
      included: true
    }],
    video_editing: [{
      label: "Move-in/Move-out Video Analysis",
      included: true,
      icon: <Film className="w-3 h-3 text-blue-400" />
    }, {
      label: "Damage Detection AI",
      included: true
    }, {
      label: "Property Promotion Reels",
      included: true
    }],
    marketing: [{
      label: "Vacancy Fill Optimization",
      included: true
    }, {
      label: "Automated Listing Syndication",
      included: true
    }],
    analytics: [{
      label: "Long-term Yield Projection",
      included: true,
      icon: <TrendingUp className="w-3 h-3 text-emerald-400" />
    }, {
      label: "Maintenance Cost Forecasting",
      included: true
    }]
  },
  ctaLabel: "Contact Sales"
}];

interface PrivateYieldDashboardProps {
  agreement: {
    id: string;
    tenantId: string;
    status: string;
    terms?: {
      initial_move_in_cost_subsidy: number;
      monthly_commission_schedule: Array<{ month: number; rate: number }>;
      loyalty_yield_multipliers: Array<{ month: number; multiplier: number }>;
    }
  };
}

function PrivateYieldDashboard({ agreement }: PrivateYieldDashboardProps) {
  const [baseRevenue, setBaseRevenue] = useState(10000);
  const [exposure, setExposure] = useState(0.9);
  const [engagement, setEngagement] = useState(0.8);
  const [conversion, setConversion] = useState(0.85);
  const [timeDecay, setTimeDecay] = useState(0.97);
  const [behavior, setBehavior] = useState(1.1);

  const terms = agreement.terms || {
    initial_move_in_cost_subsidy: 1500,
    monthly_commission_schedule: [
      { month: 1, rate: 0.035 },
      { month: 2, rate: 0.035 },
      { month: 3, rate: 0.035 },
      { month: 6, rate: 0.035 },
      { month: 12, rate: 0.035 }
    ],
    loyalty_yield_multipliers: [
      { month: 6, multiplier: 1.1 },
      { month: 12, multiplier: 1.25 }
    ]
  };

  const steps = [
    "CREATED",
    "PENDING",
    "ACTIVE",
    "SUSPENDED",
    "MODIFIED",
    "ESCALATED",
    "RE_EXECUTED",
    "SETTLED",
    "ARCHIVED"
  ];

  const currentStepIndex = steps.indexOf(agreement.status);

  const monthsData = Array.from({ length: 12 }, (_, i) => {
    const monthIndex = i + 1;
    const sched = terms.monthly_commission_schedule || [];
    const rate = sched.find((m: { month: number; rate: number }) => m.month === monthIndex)?.rate 
      ?? sched[sched.length - 1]?.rate 
      ?? 0.015;

    const mults = terms.loyalty_yield_multipliers || [];
    const loyalty = mults.find((m: { month: number; multiplier: number }) => m.month === monthIndex)?.multiplier 
      ?? 1;

    const decayFactor = Math.pow(timeDecay, monthIndex);
    const gross = baseRevenue * exposure * engagement * conversion * decayFactor * behavior;
    const commission = gross * rate * loyalty;
    const net = gross - commission;

    return {
      month: monthIndex,
      rate,
      loyalty,
      gross: Math.round(gross),
      commission: Math.round(commission),
      net: Math.round(net)
    };
  });

  const totalGross = monthsData.reduce((acc, m) => acc + m.gross, 0);
  const totalNet = monthsData.reduce((acc, m) => acc + m.net, 0);
  const subsidyAmortized = terms.initial_move_in_cost_subsidy / 12;

  return (
    <div className="space-y-12 max-w-7xl mx-auto p-6 bg-[#0c0d12] border border-orange-500/10 rounded-[40px] shadow-2xl relative overflow-hidden">
       <div className="absolute inset-0 bg-[linear-gradient(to_right,#8080800a_1px,transparent_1px),linear-gradient(to_bottom,#8080800a_1px,transparent_1px)] bg-size-[14px_24px] pointer-events-none" />
       
       <div className="relative z-10 space-y-8">
         <div className="flex flex-col md:flex-row justify-between items-start md:items-center border-b border-white/5 pb-8 gap-4">
           <div>
             <Badge className="bg-orange-500/10 text-orange-400 border border-orange-500/20 px-4 py-1.5 font-black tracking-widest text-[10px] uppercase mb-3">
               <Shield className="w-3.5 h-3.5 mr-2 inline" /> Opaque Financial Matrix Active
             </Badge>
             <h2 className="text-3xl md:text-5xl font-black text-white italic tracking-tighter leading-none">
               PRIVATE YIELD ENGINE
             </h2>
             <p className="text-slate-400 text-sm italic font-medium mt-1">
               Contract ID: <span className="font-mono text-orange-500 font-bold">{agreement.id}</span> • Tenant Isolated Operating Loop
             </p>
           </div>
           
           <div className="bg-[#14151a]/80 backdrop-blur-xl border border-white/5 p-4 rounded-3xl flex items-center gap-4">
             <div className="w-3 h-3 rounded-full bg-emerald-500 animate-ping" />
             <div>
               <p className="text-[10px] font-black text-slate-500 tracking-widest uppercase">System State</p>
               <p className="text-lg font-black text-emerald-400 italic tracking-wider">{agreement.status}</p>
             </div>
           </div>
         </div>

         <div className="space-y-4 bg-white/5 border border-white/5 p-6 rounded-3xl">
           <h3 className="text-[11px] font-black text-slate-400 tracking-[0.2em] uppercase italic">
             Contract Execution State Machine
           </h3>
           <div className="grid grid-cols-2 md:grid-cols-9 gap-3">
             {steps.map((st, i) => {
               const isActive = i <= currentStepIndex;
               const isCurrent = st === agreement.status;
               return (
                 <div
                   key={st}
                   className={cn(
                     "p-3 rounded-xl border text-center transition-all duration-300",
                     isCurrent 
                       ? "bg-orange-500/20 border-orange-500 text-white font-black scale-105 shadow-lg shadow-orange-500/10"
                       : isActive
                       ? "bg-emerald-500/10 border-emerald-500/20 text-emerald-400 font-bold"
                       : "bg-white/5 border-white/5 text-slate-600 font-medium"
                   )}
                 >
                   <p className="text-[9px] tracking-tight">{st}</p>
                 </div>
               );
             })}
           </div>
         </div>

         <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
           <div className="lg:col-span-1 space-y-6 bg-white/5 border border-white/5 p-8 rounded-[30px]">
             <div className="flex items-center justify-between pb-4 border-b border-white/5">
               <h3 className="text-sm font-black text-white italic tracking-widest uppercase flex items-center gap-2">
                 <Sliders className="w-4 h-4 text-orange-500" /> Revenue DAG Sim
               </h3>
               <span className="text-[9px] font-mono text-slate-500">f(x) Deterministic</span>
             </div>

             <div className="space-y-5">
               <div className="space-y-2">
                 <div className="flex justify-between text-xs font-bold italic">
                   <span className="text-slate-400">Base Revenue Estimate</span>
                   <span className="text-white">${baseRevenue.toLocaleString()}</span>
                 </div>
                 <input 
                   type="range" min="1000" max="50000" step="500" 
                   value={baseRevenue} onChange={e => setBaseRevenue(Number(e.target.value))}
                   className="w-full accent-orange-500 h-1 bg-white/10 rounded-lg cursor-pointer"
                 />
               </div>

               <div className="space-y-2">
                 <div className="flex justify-between text-xs font-bold italic">
                   <span className="text-slate-400">Exposure Score (Visibility)</span>
                   <span className="text-orange-400">{Math.round(exposure * 100)}%</span>
                 </div>
                 <input 
                   type="range" min="0.1" max="1.0" step="0.05" 
                   value={exposure} onChange={e => setExposure(Number(e.target.value))}
                   className="w-full accent-orange-500 h-1 bg-white/10 rounded-lg cursor-pointer"
                 />
               </div>

               <div className="space-y-2">
                 <div className="flex justify-between text-xs font-bold italic">
                   <span className="text-slate-400">Engagement Rate</span>
                   <span className="text-orange-400">{Math.round(engagement * 100)}%</span>
                 </div>
                 <input 
                   type="range" min="0.1" max="1.0" step="0.05" 
                   value={engagement} onChange={e => setEngagement(Number(e.target.value))}
                   className="w-full accent-orange-500 h-1 bg-white/10 rounded-lg cursor-pointer"
                 />
               </div>

               <div className="space-y-2">
                 <div className="flex justify-between text-xs font-bold italic">
                   <span className="text-slate-400">Lead Conversion Prob</span>
                   <span className="text-orange-400">{Math.round(conversion * 100)}%</span>
                 </div>
                 <input 
                   type="range" min="0.1" max="1.0" step="0.05" 
                   value={conversion} onChange={e => setConversion(Number(e.target.value))}
                   className="w-full accent-orange-500 h-1 bg-white/10 rounded-lg cursor-pointer"
                 />
               </div>

               <div className="space-y-2">
                 <div className="flex justify-between text-xs font-bold italic">
                   <span className="text-slate-400">Monthly Time Decay</span>
                   <span className="text-blue-400">{(timeDecay).toFixed(2)}x</span>
                 </div>
                 <input 
                   type="range" min="0.80" max="1.0" step="0.01" 
                   value={timeDecay} onChange={e => setTimeDecay(Number(e.target.value))}
                   className="w-full accent-orange-500 h-1 bg-white/10 rounded-lg cursor-pointer"
                 />
               </div>

               <div className="space-y-2">
                 <div className="flex justify-between text-xs font-bold italic">
                   <span className="text-slate-400">Tenant Behavior Multiplier</span>
                   <span className="text-blue-400">{(behavior).toFixed(2)}x</span>
                 </div>
                 <input 
                   type="range" min="0.50" max="1.50" step="0.05" 
                   value={behavior} onChange={e => setBehavior(Number(e.target.value))}
                   className="w-full accent-orange-500 h-1 bg-white/10 rounded-lg cursor-pointer"
                 />
               </div>
             </div>
           </div>

           <div className="lg:col-span-2 space-y-6">
             <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
               <Card className="bg-[#14151a]/40 border-white/5 rounded-2xl">
                 <CardContent className="pt-6">
                   <p className="text-[10px] font-black text-slate-500 tracking-widest uppercase">Projected 12M Gross</p>
                   <p className="text-3xl font-black text-white italic tracking-tighter mt-1">
                     ${totalGross.toLocaleString()}
                   </p>
                 </CardContent>
               </Card>

               <Card className="bg-[#14151a]/40 border-orange-500/20 rounded-2xl relative overflow-hidden">
                 <div className="absolute top-0 right-0 bg-orange-600 text-white text-[8px] font-black px-2.5 py-1 rounded-bl-lg">
                   ACTIVE YIELD
                 </div>
                 <CardContent className="pt-6">
                   <p className="text-[10px] font-black text-slate-500 tracking-widest uppercase">Net Partner Payout</p>
                   <p className="text-3xl font-black text-orange-400 italic tracking-tighter mt-1">
                     ${totalNet.toLocaleString()}
                   </p>
                 </CardContent>
               </Card>

               <Card className="bg-[#14151a]/40 border-white/5 rounded-2xl">
                 <CardContent className="pt-6">
                   <p className="text-[10px] font-black text-slate-500 tracking-widest uppercase">Move-In Subsidy</p>
                   <p className="text-3xl font-black text-blue-400 italic tracking-tighter mt-1">
                     -${terms.initial_move_in_cost_subsidy}
                   </p>
                   <p className="text-[9px] text-slate-400 italic mt-1">
                     Amortized: ${Math.round(subsidyAmortized)}/month
                   </p>
                 </CardContent>
               </Card>
             </div>

             <div className="bg-white/5 border border-white/5 p-8 rounded-[30px] space-y-4">
               <div className="flex justify-between items-center pb-2">
                 <h4 className="text-[10px] font-black text-white tracking-[0.2em] uppercase italic">
                   12-Month Net Yield Projection Curve
                 </h4>
                 <span className="text-[9px] text-slate-500 font-mono">Commission vs Net</span>
               </div>
               
               <div className="h-48 w-full bg-slate-950/40 rounded-2xl border border-white/5 p-4 flex items-end relative">
                 <svg className="w-full h-full overflow-visible" viewBox="0 0 120 40">
                   <line x1="0" y1="10" x2="120" y2="10" stroke="rgba(255,255,255,0.03)" strokeWidth="0.5" />
                   <line x1="0" y1="20" x2="120" y2="20" stroke="rgba(255,255,255,0.03)" strokeWidth="0.5" />
                   <line x1="0" y1="30" x2="120" y2="30" stroke="rgba(255,255,255,0.03)" strokeWidth="0.5" />
                   
                   <path
                     d={`M ${monthsData.map((d, idx) => `${idx * 10.9}, ${40 - (d.net / Math.max(...monthsData.map(m => m.gross))) * 35}`).join(' L ')}`}
                     fill="none"
                     stroke="#f97316"
                     strokeWidth="1.5"
                   />
                   <path
                     d={`M ${monthsData.map((d, idx) => `${idx * 10.9}, ${40 - (d.gross / Math.max(...monthsData.map(m => m.gross))) * 35}`).join(' L ')}`}
                     fill="none"
                     stroke="rgba(255,255,255,0.2)"
                     strokeWidth="1"
                     strokeDasharray="2"
                   />
                 </svg>

                 <div className="absolute bottom-2 left-4 right-4 flex justify-between text-[8px] font-mono text-slate-500">
                   <span>M1</span>
                   <span>M3</span>
                   <span>M6</span>
                   <span>M9</span>
                   <span>M12</span>
                 </div>
               </div>
               
               <div className="overflow-x-auto">
                 <table className="w-full text-left text-xs text-slate-400">
                   <thead>
                     <tr className="border-b border-white/5 text-[9px] font-black text-slate-500 tracking-wider">
                       <th className="py-2">Month</th>
                       <th className="py-2">Gross Est.</th>
                       <th className="py-2">Comm. Rate</th>
                       <th className="py-2">Loyalty</th>
                       <th className="py-2 text-right">Net Payout</th>
                     </tr>
                   </thead>
                   <tbody>
                     {monthsData.slice(0, 6).map((m) => (
                       <tr key={m.month} className="border-b border-white/5 hover:bg-white/5 transition-all">
                         <td className="py-2 font-black text-white">Month {m.month}</td>
                         <td className="py-2">${m.gross.toLocaleString()}</td>
                         <td className="py-2">{(m.rate * 100).toFixed(1)}%</td>
                         <td className="py-2">{m.loyalty}x</td>
                         <td className="py-2 text-right font-bold text-orange-400">${m.net.toLocaleString()}</td>
                       </tr>
                     ))}
                   </tbody>
                 </table>
                 <p className="text-[9px] text-slate-500 italic mt-2 text-center">
                   *Showing first 6 months. Detailed 36-month projections compiled securely in server memory.
                 </p>
               </div>
             </div>
           </div>
         </div>
       </div>
    </div>
  );
}

export default function SubscriptionsPage() {
  const [agreement, setAgreement] = useState<PartnerAgreement | null>(null);
  const [loadingAgreement, setLoadingAgreement] = useState(true);

  useEffect(() => {
    apiClient.get("/partner-agreement/active")
      .then((res: unknown) => {
        const val = res as { data?: PartnerAgreement };
        if (val && val.data) {
          setAgreement(val.data);
        }
      })
      .catch(err => console.error("Error loading agreement:", err))
      .finally(() => setLoadingAgreement(false));
  }, []);

  const [isAnnual, setIsAnnual] = useState(false);
  const [activeTab, setActiveTab] = useState<"individual" | "agency" | "hotel" | "apartment" | "commission">("agency");
  
  let basePlans = INDIVIDUAL_PLANS;
  if (activeTab === "agency") basePlans = AGENCY_PLANS;
  else if (activeTab === "hotel") basePlans = HOTEL_PLANS;
  else if (activeTab === "apartment") basePlans = APARTMENT_PLANS;
  
  const plans = basePlans;

  if (loadingAgreement) {
    return (
      <PageShell title={t("client.src.membership_plans")} description={t("client.src.neuralpowered_real_estate_tiers")}>
        <div className="flex items-center justify-center h-64 bg-[#0a0b0d] text-slate-200">
          <RefreshCw className="h-8 w-8 animate-spin text-orange-500" />
        </div>
      </PageShell>
    );
  }

  if (agreement) {
    return (
      <PageShell title="Private Yield Engine" description="Secure Contract Yield Dashboard">
        <div className="p-4 lg:p-8 space-y-12 bg-[#0a0b0d] min-h-full text-slate-200">
          <PrivateYieldDashboard agreement={agreement} />
        </div>
      </PageShell>
    );
  }

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
          
          <motion.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} className="bg-gradient-to-r from-emerald-500/20 to-teal-500/20 border border-emerald-500/30 text-emerald-300 p-4 rounded-xl mb-6 shadow-lg shadow-emerald-500/10">
            <div className="flex items-center justify-center gap-2 font-bold text-lg">
              <Crown className="w-6 h-6 text-emerald-400" />
              <span>{t("client.src.plans.discount_notice")}</span>
            </div>
            <p className="text-emerald-100/80 text-sm mt-1">{t("client.src.plans.commission_notice")}</p>
          </motion.div>
          


          <h1 className="text-4xl md:text-6xl font-black text-white italic tracking-tighter">{t("client.src.neural")}<span className="text-orange-500 underline decoration-white/10 underline-offset-8">{t("client.src.pricing")}</span>{t("client.src.matrix")}</h1>
          <p className="text-slate-400 text-lg max-w-2xl mx-auto font-medium italic">{t("client.src.transform_the_real_estate")}</p>
          
          <div className="pt-4 flex flex-col items-center gap-8">
            <Tabs value={activeTab} onValueChange={v => setActiveTab(v as "individual" | "agency" | "hotel" | "apartment" | "commission")} className="bg-[#14151a]/60 backdrop-blur-xl border border-white/5 p-1 rounded-2xl flex flex-wrap justify-center">
              <TabsList className="bg-transparent gap-2 h-auto flex-wrap justify-center p-2">
                <TabsTrigger value="individual" className="rounded-xl data-[state=active]:bg-orange-600 data-[state=active]:text-white font-black tracking-widest text-[10px] px-8 h-10">{t("client.src.solo_agent")}</TabsTrigger>
                <TabsTrigger value="agency" className="rounded-xl data-[state=active]:bg-orange-600 data-[state=active]:text-white font-black tracking-widest text-[10px] px-8 h-10">{t("client.src.global_agency")}</TabsTrigger>
                <TabsTrigger value="hotel" className="rounded-xl data-[state=active]:bg-orange-600 data-[state=active]:text-white font-black tracking-widest text-[10px] px-8 h-10">{t("client.src.plans.tab_hotel")}</TabsTrigger>
                <TabsTrigger value="apartment" className="rounded-xl data-[state=active]:bg-orange-600 data-[state=active]:text-white font-black tracking-widest text-[10px] px-8 h-10">{t("client.src.plans.tab_apartment")}</TabsTrigger>
                <TabsTrigger value="commission" className="rounded-xl data-[state=active]:bg-emerald-600 data-[state=active]:text-white font-black tracking-widest text-[10px] px-8 h-10 text-emerald-400 border border-emerald-500/20 bg-emerald-500/5 ml-2">{t("client.src.plans.tab_commission")}</TabsTrigger>
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
        {activeTab === "commission" ? (
          <div className="mt-10 max-w-5xl mx-auto w-full">
            <PrivateYieldDashboard agreement={{
              id: "DEMO-YIELD-MATRIX",
              tenantId: "demo-tenant",
              status: "ACTIVE"
            }} />
          </div>
        ) : (
          <div className={cn("grid gap-8 max-w-7xl mx-auto auto-rows-fr mt-20 pb-20", plans.length >= 3 ? "grid-cols-1 md:grid-cols-2 lg:grid-cols-3" : "grid-cols-1 md:grid-cols-2")}>
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
                      {price === 0 ? (
                        <span className="text-3xl font-black text-white tracking-tighter italic pb-2">SATIŞ İLE İLETİŞİME GEÇ</span>
                      ) : (
                        <>
                          <span className="text-6xl font-black text-white tracking-tighter italic">${parseInt(price.toString()).toLocaleString()}</span>
                          <span className="text-slate-500 text-xs font-black tracking-widest pb-3">/{isAnnual ? 'Year' : 'Mo'}</span>
                        </>
                      )}
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
        )}

        {/* Partnership / Hybrid Action */}
        <div className="max-w-7xl mx-auto pb-20">
           <Card className="bg-gradient-to-r from-orange-600/10 to-transparent border-white/5 rounded-[50px] p-12 overflow-hidden relative">
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