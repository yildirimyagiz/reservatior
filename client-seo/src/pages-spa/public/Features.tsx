"use client";

import { m } from "framer-motion";
import { Brain, Sparkles, Video, ShieldCheck, Banknote, LayoutDashboard, Zap, Globe, Clock, Scale, Building2, BarChart3, ArrowRight, CheckCircle2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Link } from "@/lib/react-router-shim";
import { useTranslation } from "react-i18next";

const fadeUp = {
  hidden: { opacity: 0, y: 30 },
  show: { opacity: 1, y: 0 },
};

export default function Features() {
  const { t } = useTranslation();

  const FEATURES = [{
    category: t('admin.neuralStudio'),
    icon: Brain,
    accent: "purple",
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
    accent: "blue",
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
    accent: "emerald",
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
    accent: "amber",
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
  }];

  const accents: Record<string, { chip: string; label: string; bar: string }> = {
    purple: {
      chip: "bg-purple-500/10 text-purple-600 dark:text-purple-400 border-purple-500/20",
      label: "text-purple-600 dark:text-purple-400",
      bar: "bg-purple-500",
    },
    blue: {
      chip: "bg-blue-500/10 text-blue-600 dark:text-blue-400 border-blue-500/20",
      label: "text-blue-600 dark:text-blue-400",
      bar: "bg-blue-500",
    },
    emerald: {
      chip: "bg-emerald-500/10 text-emerald-600 dark:text-emerald-400 border-emerald-500/20",
      label: "text-emerald-600 dark:text-emerald-400",
      bar: "bg-emerald-500",
    },
    amber: {
      chip: "bg-amber-500/10 text-amber-600 dark:text-amber-400 border-amber-500/20",
      label: "text-amber-600 dark:text-amber-400",
      bar: "bg-amber-500",
    },
  };

  const STATS = [
    { label: t('stats.liveActivity'), color: "text-brand dark:text-brand", bar: "bg-brand", value: "12.4K+", suffix: t("client.src.events"), pct: 70 },
    { label: t('stats.aiAdoption'), color: "text-purple-600 dark:text-purple-400", bar: "bg-purple-500", value: "74.2%", suffix: t("client.src.active"), pct: 85 },
    { label: t('stats.revenueLift'), color: "text-emerald-600 dark:text-emerald-400", bar: "bg-emerald-500", value: "+31%", suffix: t("client.src.roi"), pct: 92 },
    { label: t('stats.globalNodes'), color: "text-blue-600 dark:text-blue-400", bar: "bg-blue-500", value: "482", suffix: t("client.src.agencies"), pct: 60 },
  ];

  const GUIDES = [
    { eyebrow: t("client.src.getting_started"), color: "text-brand dark:text-brand", title: t("client.src.are_you_a_property"), desc: t("client.src.using_our_neural_staging") },
    { eyebrow: t("client.src.operation_guide"), color: "text-blue-600 dark:text-blue-400", title: t("client.src.agency_management"), desc: t("client.src.with_the_commission_distribution") },
    { eyebrow: t("client.src.tax_compliance"), color: "text-emerald-600 dark:text-emerald-400", title: t("client.src.global_tax_management"), desc: t("client.src.automatically_track_your_tax") },
  ];

  return (
    <div className="min-h-screen bg-background text-foreground selection:bg-brand/30">
      <div className="relative overflow-hidden">
        {/* Soft theme-aware background orbs */}
        <div className="pointer-events-none absolute inset-0 overflow-hidden" aria-hidden>
          <div className="absolute -top-[10%] -left-[10%] w-[40%] h-[40%] bg-brand/10 blur-[120px] rounded-full" />
          <div className="absolute top-[20%] -right-[10%] w-[30%] h-[30%] bg-purple-500/10 blur-[100px] rounded-full" />
          <div className="absolute -bottom-[10%] left-[20%] w-[50%] h-[30%] bg-emerald-500/10 blur-[150px] rounded-full" />
        </div>

        <div className="relative z-10 container mx-auto px-6 py-16 lg:py-24">
          {/* ─── Header / Hero ─── */}
          <m.div
            variants={fadeUp}
            initial="hidden"
            animate="show"
            transition={{ duration: 0.7, ease: [0.22, 1, 0.36, 1] }}
            className="max-w-3xl mb-16 lg:mb-20"
          >
            <Badge className="mb-6 rounded-full bg-brand/10 text-brand border-brand/20 px-4 py-1.5 text-sm font-black tracking-widest">
              {t("client.src.reservatior_ecosystem_v24")}
            </Badge>
            <h1 className="text-5xl lg:text-7xl font-black tracking-tight mb-6 leading-[1.05]">
              {t("client.src.neural")}{" "}
              <span className="bg-gradient-to-r from-brand via-info to-purple-500 bg-clip-text text-transparent">
                {t("client.src.solutions")}
              </span>{" "}
              {t("client.src.for_the_next_gen")}
            </h1>
            <p className="text-lg lg:text-xl text-muted-foreground max-w-2xl leading-relaxed border-l-2 border-brand/30 pl-6">
              {t('heroSubtitle')}
            </p>
          </m.div>

          {/* ─── Feature Groups ─── */}
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-10 lg:gap-12">
            {FEATURES.map((group, gIdx) => {
              const accent = accents[group.accent];
              return (
                <m.div
                  key={group.category}
                  initial={{ opacity: 0, y: 30 }}
                  whileInView={{ opacity: 1, y: 0 }}
                  viewport={{ once: true, margin: "-80px" }}
                  transition={{ delay: gIdx * 0.08, duration: 0.6 }}
                  className="space-y-5"
                >
                  <div className="flex items-center gap-4">
                    <div className={`p-3.5 rounded-2xl border ${accent.chip}`}>
                      <group.icon className="w-7 h-7" />
                    </div>
                    <div>
                      <h2 className="text-2xl font-black tracking-tight">{group.category}</h2>
                      <p className="text-xs font-bold tracking-widest uppercase text-muted-foreground">
                        Reservatior OS
                      </p>
                    </div>
                  </div>

                  <div className="grid grid-cols-1 gap-4">
                    {group.items.map((item) => (
                      <Card
                        key={item.title}
                        className="group bg-card border-border hover:border-brand/40 rounded-3xl overflow-hidden cursor-help transition-all duration-300 hover:-translate-y-0.5 hover:shadow-[0_12px_40px_-12px_hsl(var(--brand)/0.25)]"
                      >
                        <CardContent className="p-6 flex items-start gap-5">
                          <div className={`p-3 rounded-xl border ${accent.chip} shrink-0 transition-transform group-hover:scale-110`}>
                            <item.icon className="w-6 h-6" />
                          </div>
                          <div className="space-y-1.5 min-w-0">
                            <h3 className="text-lg font-bold tracking-tight group-hover:text-brand transition-colors">
                              {item.title}
                            </h3>
                            <p className="text-sm text-muted-foreground leading-relaxed">
                              {item.description}
                            </p>
                          </div>
                        </CardContent>
                      </Card>
                    ))}
                  </div>
                </m.div>
              );
            })}
          </div>

          {/* ─── Live Ecosystem Stats ─── */}
          <m.div
            initial={{ opacity: 0, y: 40 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true, margin: "-80px" }}
            transition={{ duration: 0.7 }}
            className="mt-20 lg:mt-28 p-8 lg:p-12 rounded-[3rem] bg-card/80 backdrop-blur-xl border border-border overflow-hidden relative"
          >
            <div className="absolute top-0 right-0 p-8 opacity-10" aria-hidden>
              <Globe className="w-56 h-56 text-brand" />
            </div>
            <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-10 relative z-10">
              {STATS.map((s) => (
                <div key={s.label} className="space-y-4">
                  <h3 className={`text-xs font-black tracking-[0.25em] uppercase ${s.color}`}>{s.label}</h3>
                  <p className="text-4xl font-black tracking-tighter">
                    {s.value}
                    <span className="text-xs ml-2 font-bold text-muted-foreground">{s.suffix}</span>
                  </p>
                  <div className="h-1.5 w-full bg-muted rounded-full overflow-hidden">
                    <m.div
                      className={`h-full rounded-full ${s.bar}`}
                      initial={{ width: 0 }}
                      whileInView={{ width: `${s.pct}%` }}
                      viewport={{ once: true }}
                      transition={{ duration: 1, ease: "easeOut", delay: 0.2 }}
                    />
                  </div>
                </div>
              ))}
            </div>
          </m.div>

          {/* ─── CTA Section ─── */}
          <m.div
            initial={{ opacity: 0, scale: 0.96 }}
            whileInView={{ opacity: 1, scale: 1 }}
            viewport={{ once: true, margin: "-80px" }}
            transition={{ duration: 0.6 }}
            className="mt-20 lg:mt-28 p-10 lg:p-16 rounded-[3rem] bg-gradient-to-br from-brand/10 via-purple-500/5 to-transparent border border-border text-center relative overflow-hidden"
          >
            <div className="absolute top-0 left-0 p-12 opacity-5 pointer-events-none" aria-hidden>
              <Brain className="w-72 h-72 -rotate-12" />
            </div>
            <div className="relative z-10 max-w-2xl mx-auto space-y-6">
              <h2 className="text-4xl lg:text-5xl font-black tracking-tight">{t("client.src.discover_more")}</h2>
              <p className="text-muted-foreground text-lg leading-relaxed">{t("client.src.increase_the_value_of")}</p>
              <div className="flex flex-col sm:flex-row gap-4 justify-center pt-6">
                <Link to="/admin/service-analytics">
                  <Button size="lg" className="h-14 px-10 rounded-full text-base font-black bg-brand hover:bg-brand/90 text-white shadow-[0_10px_30px_-10px_hsl(var(--brand)/0.5)] group">
                    {t("client.src.go_to_ai_panel")}
                    <ArrowRight className="ml-2 group-hover:translate-x-1.5 transition-transform" />
                  </Button>
                </Link>
                <Link to="/contact">
                  <Button size="lg" variant="outline" className="h-14 px-10 rounded-full text-base font-black border-border hover:bg-brand/5">
                    {t("client.src.request_demo")}
                  </Button>
                </Link>
              </div>
            </div>
          </m.div>

          {/* ─── Getting Started / Guidance ─── */}
          <div className="mt-20 lg:mt-28 border-t border-border pt-14 grid grid-cols-1 md:grid-cols-3 gap-10">
            {GUIDES.map((g) => (
              <m.div
                key={g.eyebrow}
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true, margin: "-60px" }}
                transition={{ duration: 0.5 }}
              >
                <span className={`text-[10px] font-black tracking-[0.3em] uppercase mb-4 block ${g.color}`}>{g.eyebrow}</span>
                <h3 className="text-base font-black mb-3">{g.title}</h3>
                <p className="text-sm text-muted-foreground leading-relaxed">{g.desc}</p>
              </m.div>
            ))}
          </div>

          <footer className="mt-16 pt-8 border-t border-border text-center text-muted-foreground text-xs font-bold tracking-widest">
            {t("client.src.2026_reservatior_neural_ecosystem")}
          </footer>
        </div>
      </div>
    </div>
  );
}
