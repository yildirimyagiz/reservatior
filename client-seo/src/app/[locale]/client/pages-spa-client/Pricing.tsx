"use client";

import { Helmet } from "react-helmet-async";
import { FAQPageSchema } from "@/components/seo/SchemaScript";
import { Button } from "@/components/ui/button";
import { Check, Zap, Shield, Activity, Star, Sparkles } from "lucide-react";
import { motion } from "framer-motion";
import { cn } from "@/lib/utils";
import { useTranslation } from "react-i18next";
import { useNavigate } from "@/lib/react-router-shim";
import { useQuery } from "@tanstack/react-query";
import { apiClient } from "@/lib/api/client";

export default function Pricing() {
  const { t } = useTranslation();
  const navigate = useNavigate();

  const FALLBACK_PLANS = [
    {
      id: "starter-10",
      name: "STARTER (10 MÜLK)",
      key: "starter",
      priceMonthlyCents: 1900,
      limits: { maxProperties: 10, maxUsers: 1, maxListings: 25, aiFeatures: false, customIntegrations: false, prioritySupport: false }
    },
    {
      id: "growth-25",
      name: "GROWTH (25 MÜLK)",
      key: "growth",
      priceMonthlyCents: 4900,
      limits: { maxProperties: 25, maxUsers: 3, maxListings: 100, aiFeatures: false, customIntegrations: false, prioritySupport: false }
    },
    {
      id: "professional-50",
      name: "PRO (50 MÜLK)",
      key: "professional",
      priceMonthlyCents: 8000,
      limits: { maxProperties: 50, maxUsers: 5, maxListings: 250, aiFeatures: true, customIntegrations: false, prioritySupport: true }
    },
    {
      id: "agency-100",
      name: "AGENCY (100 MÜLK)",
      key: "agency",
      priceMonthlyCents: 15000,
      limits: { maxProperties: 100, maxUsers: 10, maxListings: 500, aiFeatures: true, customIntegrations: false, prioritySupport: true }
    },
    {
      id: "enterprise",
      name: "ENTERPRISE",
      key: "enterprise",
      priceMonthlyCents: null,
      limits: { maxProperties: null, maxUsers: null, maxListings: null, aiFeatures: true, customIntegrations: true, prioritySupport: true }
    }
  ];

  const { data: plans = [], isLoading } = useQuery({
    queryKey: ['publicPlans'],
    queryFn: async () => {
      try {
        const res = (await apiClient.get("/plan")) as { data: any[] };
        return (res.data && res.data.length > 0) ? res.data : FALLBACK_PLANS;
      } catch (error) {
        console.error("Failed to fetch plans", error);
        return FALLBACK_PLANS;
      }
    }
  });

  const formatPrice = (cents: number | null) => {
    if (cents === null || cents === undefined) return t('price', 'ÖZEL');
    return `$${(cents / 100).toFixed(0)}`;
  };

  const generateFeatures = (limits: any) => {
    const features = [];
    if (limits?.maxProperties) {
      features.push(`${limits.maxProperties} ${t('pricing.features.dynamic.maxProperties', 'Mülke Kadar Portföy Yönetimi')}`);
    } else {
      features.push(t('pricing.features.dynamic.unlimitedProperties', 'Sınırsız Mülk & Portföy Yönetimi'));
    }
    if (limits?.maxUsers) {
      features.push(`${limits.maxUsers} ${t('pricing.features.dynamic.maxUsers', 'Kullanıcı Erişimi')}`);
    }
    if (limits?.maxListings) {
      features.push(`${limits.maxListings} ${t('pricing.features.dynamic.maxListings', 'Aktif İlan Limiti')}`);
    } else {
      features.push(t('pricing.features.dynamic.unlimitedListings', 'Sınırsız İlan Yayını'));
    }
    if (limits?.aiFeatures) {
      features.push(t('pricing.features.dynamic.ai', 'Yapay Zeka Destekli Analiz'));
    }
    if (limits?.customIntegrations) {
      features.push(t('pricing.features.dynamic.integrations', 'Özel Entegrasyonlar ve ERP'));
    }
    if (limits?.prioritySupport) {
      features.push(t('pricing.features.dynamic.support', '7/24 Öncelikli Canlı Destek'));
    } else {
      features.push(t('pricing.features.dynamic.basicSupport', 'Standart E-posta Desteği'));
    }
    return features;
  };

  return (
    <>

    <div className="min-h-screen bg-[#fafafa] dark:bg-[#0a0a0c] selection:bg-black selection:text-white dark:selection:bg-white dark:selection:text-black relative overflow-hidden">
      <div className="absolute inset-0 z-0 pointer-events-none overflow-hidden">
        <div className="absolute -top-[20%] -left-[10%] w-[50%] h-[50%] rounded-full bg-indigo-400/20 dark:bg-indigo-600/10 blur-[120px] mix-blend-multiply dark:mix-blend-lighten" />
        <div className="absolute top-[20%] -right-[10%] w-[40%] h-[60%] rounded-full bg-purple-400/20 dark:bg-purple-600/10 blur-[120px] mix-blend-multiply dark:mix-blend-lighten" />
        <div className="absolute -bottom-[20%] left-[20%] w-[60%] h-[50%] rounded-full bg-blue-400/10 dark:bg-blue-600/10 blur-[120px] mix-blend-multiply dark:mix-blend-lighten" />
      </div>

      <div className="relative z-10 max-w-[1600px] mx-auto px-6 py-24">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="text-center mb-20 space-y-6"
        >
          <div className="inline-flex items-center gap-2 px-5 py-2 rounded-full bg-white/50 dark:bg-slate-800/50 border border-white/60 dark:border-slate-700/60 backdrop-blur-md">
            <Sparkles className="w-4 h-4 text-indigo-500" />
            <span className="text-xs font-bold text-neutral-600 dark:text-slate-300 tracking-wider uppercase">
              {t('pricingTitle', 'PREMIUM LİSANS PAKETLERİ')}
            </span>
          </div>

          <h1 className="text-5xl md:text-7xl font-black tracking-tight text-neutral-900 dark:text-white leading-[0.95]">
            {t('pricingTitle', 'PREMIUM LİSANS PAKETLERİ').split(' ')[0]}{' '}
            <span className="text-transparent bg-clip-text bg-gradient-to-r from-indigo-600 to-purple-500 dark:from-indigo-400 dark:to-purple-400">
              {t('pricingTitle', 'PREMIUM LİSANS PAKETLERİ').split(' ').slice(1).join(' ')}
            </span>
          </h1>
          <p className="text-lg text-neutral-500 dark:text-slate-400 max-w-2xl mx-auto font-medium">
            {t('pricingDesc', 'Gayrimenkul portföyünüzü yapay zeka ve otomasyonla ölçeklendirmek için tasarlandı.')}
          </p>

          <div className="flex flex-wrap justify-center gap-6 pt-4">
            {[
              { label: t('nodesDeployed', 'YÖNETİLEN MÜLK'), value: "14.2k", color: "text-indigo-600 dark:text-indigo-400" },
              { label: t('syncUptime', 'SİSTEM UPTIME'), value: "99.9%", color: "text-emerald-600 dark:text-emerald-400" },
              { label: t('pricingLatency', 'API GECİKMESİ'), value: "4ms", color: "text-neutral-500 dark:text-slate-400" },
              { label: t('globalReach', 'KÜRESEL ERİŞİM'), value: "42 BÖLGE", color: "text-purple-600 dark:text-purple-400" }
            ].map((stat, i) => (
              <motion.div
                key={stat.label}
                initial={{ opacity: 0, y: 15 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: i * 0.1 }}
                className="px-6 py-4 rounded-2xl bg-white/50 dark:bg-[#14151a]/50 backdrop-blur-xl border border-white/60 dark:border-slate-800/60 shadow-sm"
              >
                <p className="text-2xl font-black tracking-tight text-neutral-900 dark:text-white">{stat.value}</p>
                <p className="text-xs font-semibold text-neutral-500 dark:text-slate-400 mt-1 tracking-wider">{stat.label}</p>
              </motion.div>
            ))}
          </div>
        </motion.div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-5 gap-6">
          {isLoading ? (
            <div className="col-span-full flex flex-col items-center justify-center py-20">
              <Activity className="w-10 h-10 text-indigo-500 animate-spin mb-4" />
              <p className="text-sm font-bold text-neutral-500 dark:text-slate-400 tracking-widest uppercase">
                {t('loading', 'YÜKLENİYOR...')}
              </p>
            </div>
          ) : plans.length === 0 ? (
            <div className="col-span-full flex flex-col items-center justify-center py-20">
              <p className="text-sm font-bold text-neutral-500 dark:text-slate-400 tracking-widest uppercase">
                {t('noPlansAvailable', 'PAKET BULUNAMADI')}
              </p>
            </div>
          ) : plans.map((plan: any, index: number) => {
            const isPopular = plan.priceMonthlyCents !== null && plan.priceMonthlyCents > 5000 && plan.priceMonthlyCents < 20000;
            return (
              <motion.div
                key={plan.id}
                initial={{ opacity: 0, y: 30 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: index * 0.1 }}
                className={cn(
                  "relative p-8 rounded-[2rem] bg-white/50 dark:bg-[#14151a]/50 backdrop-blur-xl border border-white/60 dark:border-slate-800/60 shadow-xl flex flex-col h-full transition-all duration-500 hover:shadow-2xl hover:-translate-y-1 group",
                  isPopular && "border-indigo-500/50 dark:border-indigo-500/30 ring-2 ring-indigo-500/10"
                )}
              >
                {isPopular && (
                  <div className="absolute -top-5 left-1/2 -translate-x-1/2 bg-gradient-to-r from-indigo-600 to-purple-600 text-white px-6 py-2 rounded-full text-xs font-black tracking-wider shadow-xl shadow-indigo-600/30 flex items-center gap-2 whitespace-nowrap">
                    <Star className="w-3 h-3 fill-white" />
                    {t('optimizedChoice', 'EN ÇOK TERCİH EDİLEN')}
                  </div>
                )}

                <div className="space-y-4 mb-10">
                  <h3 className="text-sm font-black text-neutral-400 dark:text-slate-500 tracking-widest uppercase">
                    {plan.name}
                  </h3>
                  <div className="flex items-baseline gap-2">
                    <span className="text-4xl md:text-5xl font-black text-neutral-900 dark:text-white tracking-tight">
                      {formatPrice(plan.priceMonthlyCents)}
                    </span>
                    {plan.priceMonthlyCents !== null && (
                      <span className="text-xs font-bold text-neutral-400 dark:text-slate-500 uppercase">
                        {t('cycle_per_unit', '/ BİRİM BAŞINA AY')}
                      </span>
                    )}
                  </div>
                  <p className="text-sm font-medium text-neutral-500 dark:text-slate-400 leading-relaxed">
                    {t(`pricing.desc.${plan.key}`, 'İhtiyaçlarınıza özel gelişmiş yönetim paneli.')}
                  </p>
                </div>

                <div className="space-y-3 mb-10 flex-1">
                  <p className="text-xs font-semibold text-neutral-400 dark:text-slate-500 tracking-widest uppercase border-b border-neutral-200 dark:border-slate-800 pb-3">
                    {t('specs', 'ÖZELLİKLER')}
                  </p>
                  {generateFeatures(plan.limits).map((feature, fIdx) => (
                    <div key={fIdx} className="flex items-center gap-3">
                      <div className="w-5 h-5 rounded-full bg-indigo-50 dark:bg-indigo-900/30 flex items-center justify-center shrink-0">
                        <Check className="w-3 h-3 text-indigo-600 dark:text-indigo-400" />
                      </div>
                      <span className="text-sm font-semibold text-neutral-700 dark:text-slate-300 group-hover:text-indigo-600 dark:group-hover:text-indigo-400 transition-colors">
                        {feature}
                      </span>
                    </div>
                  ))}
                </div>

                <Button
                  onClick={() => {
                    if (plan.priceMonthlyCents !== null) {
                      navigate(`/checkout?plan=${plan.id}`);
                    } else {
                      navigate(`/contact?reason=enterprise`);
                    }
                  }}
                  className={cn(
                    "w-full h-14 rounded-2xl font-bold text-sm tracking-wider uppercase transition-all duration-300",
                    isPopular
                      ? "bg-gradient-to-r from-indigo-600 to-purple-600 hover:from-indigo-500 hover:to-purple-500 text-white shadow-xl shadow-indigo-600/20"
                      : "bg-white/60 dark:bg-slate-800/60 hover:bg-white/80 dark:hover:bg-slate-800/80 text-neutral-700 dark:text-slate-300 border border-white/60 dark:border-slate-700/60"
                  )}
                >
                  <Zap className="w-4 h-4 mr-2" />
                  {plan.priceMonthlyCents !== null ? t('getStarted', 'HEMEN BAŞLA') : t('contactSales', 'SATIŞ İLE İLETİŞİME GEÇ')}
                </Button>

                <div className="mt-6 flex items-center justify-center gap-4 opacity-30 group-hover:opacity-60 transition-opacity">
                  <Shield className="w-4 h-4 text-neutral-400 dark:text-slate-500" />
                  <Activity className="w-4 h-4 text-neutral-400 dark:text-slate-500" />
                  <Sparkles className="w-4 h-4 text-indigo-400" />
                </div>
              </motion.div>
            );
          })}
        </div>

        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.5 }}
          className="mt-20 p-12 rounded-[2rem] md:rounded-[3rem] bg-white/30 dark:bg-[#14151a]/30 backdrop-blur-xl border border-white/60 dark:border-slate-800/60 text-center"
        >
          <h2 className="text-2xl md:text-3xl font-black text-neutral-900 dark:text-white tracking-tight mb-4">
            {t('securityIncluded', 'ASKERİ DÜZEYDE GÜVENLİK')}
          </h2>
          <p className="text-sm font-medium text-neutral-500 dark:text-slate-400 max-w-2xl mx-auto mb-8">
            {t('securityDesc', 'Tüm paketlerimiz kurumsal düzeyde şifreleme ve gelişmiş veri güvenliği standartlarıyla korunmaktadır.')}
          </p>
          <div className="flex flex-wrap justify-center gap-4">
            {["AES-256", "SHA-512", "TLS 1.3", "RBAC", "ISO 27001"].map(auth => (
              <span
                key={auth}
                className="text-xs font-black text-indigo-600 dark:text-indigo-400 tracking-widest bg-indigo-50 dark:bg-indigo-900/20 px-4 py-2 rounded-full"
              >
                {auth}
              </span>
            ))}
          </div>
        </motion.div>
      </div>
      <FAQPageSchema questions={[
        { question: "Which pricing plan is right for my business?", answer: "We offer plans from Starter (10 properties) to Enterprise (unlimited). The Professional plan is our most popular choice, offering 50 properties, AI features, and priority support. You can upgrade at any time." },
        { question: "Are there any setup fees or hidden costs?", answer: "No, there are no setup fees or hidden costs. All plans are billed monthly with transparent pricing. You can cancel anytime with no penalties. Enterprise plans include custom pricing based on your specific needs." },
        { question: "What features are included in the AI-powered plans?", answer: "AI-powered plans include instant property valuation, market forecasting, automated pricing optimization, cinematic video tour generation, and predictive analytics. These features are available in the Professional plan and above." },
      ]} />
    </div>
    </>
  );
}
