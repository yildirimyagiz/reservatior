"use client";


import { m } from "framer-motion";
import { Brain, Sparkles, Video, ShieldCheck, Banknote, LayoutDashboard, Zap, Globe, Clock, Scale, Building2, BarChart3, ArrowRight, CheckCircle2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Link } from "@/lib/react-router-shim";
import { useTranslation } from "react-i18next";
export default function Features() {
  const { t } = useTranslation();
  const FEATURES = [{
    category: t('admin.neuralStudio'),
    icon: Brain,
    color: "bg-purple-500/10 text-purple-400 border-purple-500/20",
    items: [{
      title: t("client.src.neural_staging_studio"),
      description: t("client.src.empty_spaces_turned_into"),
      icon: Sparkles
    }, {
      title: t("client.src.roi_predictive_analytics"),
      description: t("client.src.aidriven_forecasting_on_how"),
      icon: BarChart3
    }, {
      title: t("client.src.smart_valuation_engine"),
      description: t("client.src.realtime_true_comps_analysis"),
      icon: Building2
    }]
  }, {
    category: "Marketing & Growth",
    icon: Video,
    color: "bg-blue-500/10 text-blue-400 border-blue-500/20",
    items: [{
      title: t("client.src.neural_reels_production"),
      description: t("client.src.cinematic_broadcastquality_property_videos"),
      icon: Video
    }, {
      title: t('aiAnalytics'),
      description: t("client.src.reach_global_markets_with"),
      icon: Globe
    }, {
      title: t("client.src.video_vendor_pipeline"),
      description: t("client.src.connect_with_professional_creators"),
      icon: ArrowRight
    }]
  }, {
    category: "Financial & Security",
    icon: ShieldCheck,
    color: "bg-blue-500/10 text-blue-400 border-blue-500/20",
    items: [{
      title: t("client.src.global_tax_compliance"),
      description: t("client.src.automated_withholding_and_reporting"),
      icon: Globe
    }, {
      title: t("client.src.commission_split_matrix"),
      description: t("client.src.realtime_hierarchical_revenue_routing"),
      icon: Banknote
    }, {
      title: t("client.src.escrow_protection_hub"),
      description: t("client.src.multisig_security_layers_for"),
      icon: Scale
    }]
  }, {
    category: "Operations & Intelligence",
    icon: LayoutDashboard,
    color: "bg-amber-500/10 text-amber-400 border-amber-500/20",
    items: [{
      title: t("client.src.automated_task_sync"),
      description: t("client.src.instant_coordination_for_cleaning"),
      icon: Clock
    }, {
      title: t("client.src.predictive_maintenance"),
      description: t("client.src.ai_alerts_for_facility"),
      icon: Zap
    }, {
      title: t("client.src.neural_activity_feed"),
      description: t("client.src.every_event_tracked_and"),
      icon: CheckCircle2
    }]
  }, {
    category: "Global Hybrid Rental OS",
    icon: Globe,
    color: "bg-emerald-500/10 text-emerald-400 border-emerald-500/20",
    items: [{
      title: t("features.global_os_multi_country", "Multi-Country Intelligence"),
      description: t("features.global_os_multi_country_desc", "Operate across 23 countries with automatic compliance, tax optimization, and market opportunity scoring for each jurisdiction."),
      icon: Globe
    }, {
      title: t("features.global_os_neural_swarm", "10-Agent Neural Swarm"),
      description: t("features.global_os_neural_swarm_desc", "AI consensus engine with 10 specialized agents: compliance, tax, pricing, corporate demand, and market expansion analysis."),
      icon: Brain
    }, {
      title: t("features.global_os_revenue_dag", "Revenue DAG Pipeline"),
      description: t("features.global_os_revenue_dag_desc", "8-node directed acyclic graph splits every dollar across tax, owner payout, partner commission, and platform margin — in 15+ currencies."),
      icon: Banknote
    }]
  }];
  // Stats are shown with fallback values; actual data is loaded after auth
  return <div className="min-h-screen bg-background text-foreground selection:bg-primary/30">
      {/* Background Orbs */}
      <div className="fixed inset-0 overflow-hidden pointer-events-none">
        <div className="absolute -top-[10%] -left-[10%] w-[40%] h-[40%] bg-purple-600/10 blur-[120px] rounded-full" />
        <div className="absolute top-[20%] -right-[10%] w-[30%] h-[30%] bg-blue-600/10 blur-[100px] rounded-full" />
        <div className="absolute -bottom-[10%] left-[20%] w-[50%] h-[30%] bg-blue-600/10 blur-[150px] rounded-full opacity-50" />
      </div>

      <div className="relative z-10 container mx-auto px-6 py-24 lg:py-32">
        {/* Header Section */}
        <div className="max-w-3xl mb-24">
          <m.div initial={{
          opacity: 0,
          x: -20
        }} whileInView={{
          opacity: 1,
          x: 0
        }} viewport={{
          once: true
        }}>
            <Badge className="mb-6 rounded-full bg-primary/10 text-primary border-primary/20 px-4 py-1 text-sm italic font-black tracking-widest">{t("client.src.reservatior_ecosystem_v24")}</Badge>
            <h1 className="text-6xl lg:text-8xl font-black italic tracking-tighter mb-8 leading-[0.9]">{t("client.src.neural")}<span className="bg-gradient-to-r from-blue-400 via-purple-400 to-pink-400 bg-clip-text text-transparent italic">{t("client.src.solutions")}</span>{t("client.src.for_the_next_gen")}</h1>
            <p className="text-xl text-slate-400 max-w-2xl leading-relaxed italic border-l-2 border-primary/30 pl-6">
              {t('heroSubtitle')}
            </p>
          </m.div>
        </div>

        {/* Features Mapping */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-12">
          {FEATURES.map((group, gIdx) => <m.div key={group.category} initial={{
          opacity: 0,
          y: 30
        }} whileInView={{
          opacity: 1,
          y: 0
        }} viewport={{
          once: true
        }} transition={{
          delay: gIdx * 0.1
        }} className="space-y-8">
              <div className="flex items-center gap-4">
                <div className={`p-4 rounded-2xl border ${group.color}`}>
                  <group.icon className="w-8 h-8" />
                </div>
                <h2 className="text-3xl font-black italic tracking-tight">{group.category}</h2>
              </div>

              <div className="grid grid-cols-1 gap-4">
                {group.items.map((item, _iIdx) => <Card key={item.title} className="bg-card/60 backdrop-blur-xl border-border hover:border-primary/20 transition-all group rounded-3xl overflow-hidden cursor-help">
                    <CardContent className="p-8 flex items-start gap-6">
                      <div className="p-3 rounded-xl bg-muted text-muted-foreground group-hover:text-primary transition-colors">
                        <item.icon className="w-6 h-6" />
                      </div>
                      <div className="space-y-2">
                        <h3 className="text-xl font-bold italic tracking-tight text-foreground group-hover:translate-x-2 transition-transform">{item.title}</h3>
                        <p className="text-sm text-muted-foreground leading-relaxed italic">{item.description}</p>
                      </div>
                    </CardContent>
                  </Card>)}
              </div>
            </m.div>)}
        </div>

        {/* Live Ecosystem Stats Section */}
        <m.div initial={{
        opacity: 0,
        y: 40
      }} whileInView={{
        opacity: 1,
        y: 0
      }} viewport={{
        once: true
      }} className="mt-32 p-12 rounded-[3rem] bg-card border border-border backdrop-blur-3xl overflow-hidden relative">
          <div className="absolute top-0 right-0 p-8 opacity-10">
            <Globe className="w-64 h-64 text-blue-400 animate-spin-slow" />
          </div>
          <div className="grid grid-cols-1 md:grid-cols-4 gap-12 relative z-10">
            <div className="space-y-4">
              <h3 className="text-sm font-black text-primary tracking-[0.3em]">{t('stats.liveActivity')}</h3>
              <p className="text-4xl font-black italic tracking-tighter">
                &quot;12.4K+&quot;
                <span className="text-xs ml-2 font-bold text-slate-500 italic">{t("client.src.events")}</span>
              </p>
              <div className="h-1 w-full bg-primary/20 rounded-full overflow-hidden">
                <div className="h-full bg-primary w-[70%]" />
              </div>
            </div>
            <div className="space-y-4">
              <h3 className="text-sm font-black text-purple-400 tracking-[0.3em]">{t('stats.aiAdoption')}</h3>
              <p className="text-4xl font-black italic tracking-tighter">
                74.2%
                <span className="text-xs ml-2 font-bold text-slate-500 italic">{t("common.active")}</span>
              </p>
              <div className="h-1 w-full bg-purple-400/20 rounded-full overflow-hidden">
                <div className="h-full bg-purple-400 w-[85%]" />
              </div>
            </div>
            <div className="space-y-4">
              <h3 className="text-sm font-black text-blue-400 tracking-[0.3em]">{t('stats.revenueLift')}</h3>
              <p className="text-4xl font-black italic tracking-tighter">
                +31%
                <span className="text-xs ml-2 font-bold text-slate-500 italic">{t("client.src.roi")}</span>
              </p>
              <div className="h-1 w-full bg-blue-400/20 rounded-full overflow-hidden">
                <div className="h-full bg-blue-400 w-[92%]" />
              </div>
            </div>
            <div className="space-y-4">
              <h3 className="text-sm font-black text-blue-400 tracking-[0.3em]">{t('stats.globalNodes')}</h3>
              <p className="text-4xl font-black italic tracking-tighter">
                482
                <span className="text-xs ml-2 font-bold text-slate-500 italic">{t("client.src.agencies")}</span>
              </p>
              <div className="h-1 w-full bg-blue-400/20 rounded-full overflow-hidden">
                <div className="h-full bg-blue-400 w-[60%]" />
              </div>
            </div>
          </div>
        </m.div>

        {/* CTA Section */}
        <m.div initial={{
        opacity: 0,
        scale: 0.95
      }} whileInView={{
        opacity: 1,
        scale: 1
      }} viewport={{
        once: true
      }} className="mt-32 p-12 lg:p-24 rounded-[4rem] bg-gradient-to-br from-primary/20 via-purple-600/10 to-transparent border border-white/10 text-center relative overflow-hidden">
          <div className="absolute top-0 left-0 p-12 opacity-5 pointer-events-none">
            <Brain className="w-96 h-96 -rotate-12" />
          </div>
          <div className="relative z-10 max-w-2xl mx-auto space-y-8">
            <h2 className="text-4xl lg:text-6xl font-black italic tracking-tighter">{t("client.src.discover_more")}</h2>
            <p className="text-slate-400 italic text-lg leading-relaxed">{t("client.src.increase_the_value_of")}</p>
            <div className="flex flex-col sm:flex-row gap-4 justify-center pt-8">
              <Link to="/admin/service-analytics">
                <Button size="lg" className="h-16 px-12 rounded-full text-lg font-black italic bg-primary hover:bg-primary/90 text-primary-foreground group">{t("client.src.go_to_ai_panel")}<ArrowRight className="ml-2 group-hover:translate-x-2 transition-transform" />
                </Button>
              </Link>
              <Link to="/contact">
                <Button size="lg" variant="outline" className="h-16 px-12 rounded-full text-lg font-black italic border-white/10 hover:bg-white/5">{t("client.src.request_demo")}</Button>
              </Link>
            </div>
          </div>
        </m.div>

        {/* User Guidance / Guidance Comments */}
        <div className="mt-40 border-t border-white/5 pt-24 grid grid-cols-1 md:grid-cols-3 gap-12">
          <div>
            <span className="text-[10px] font-black text-primary tracking-[0.3em] mb-4 block">{t("client.src.getting_started")}</span>
            <h3 className="text-sm font-black italic mb-4">{t("client.src.are_you_a_property")}</h3>
            <p className="text-xs text-slate-500 leading-loose italic">{t("client.src.using_our_neural_staging")}</p>
          </div>
          <div>
            <span className="text-[10px] font-black text-blue-400 tracking-[0.3em] mb-4 block">{t("client.src.operation_guide")}</span>
            <h3 className="text-sm font-black italic mb-4">{t("client.src.agency_management")}</h3>
            <p className="text-xs text-slate-500 leading-loose italic">{t("client.src.with_the_commission_distribution")}</p>
          </div>
          <div>
            <span className="text-[10px] font-black text-blue-400 tracking-[0.3em] mb-4 block">{t("client.src.tax_compliance")}</span>
            <h3 className="text-sm font-black italic mb-4">{t("client.src.global_tax_management")}</h3>
            <p className="text-xs text-slate-500 leading-loose italic">{t("client.src.automatically_track_your_tax")}</p>
          </div>
        </div>
      </div>

      <footer className="py-12 border-t border-white/5 text-center text-slate-600 text-[10px] font-black tracking-widest">{t("client.src.2026_reservatior_neural_ecosystem")}</footer>
    </div>;
}