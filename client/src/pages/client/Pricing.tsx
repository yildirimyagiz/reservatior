import { PageShell } from "./layout/PageShell";
import { Button } from "@/components/ui/button";
import { Check, Zap, Globe, Shield, Activity, Cpu, Layers, Fingerprint, Star } from "lucide-react";
import { motion } from "framer-motion";
import { cn } from "@/lib/utils";
import { useTranslation } from "react-i18next";
import { useNavigate } from "react-router-dom";
import { useQuery } from "@tanstack/react-query";
import { apiClient } from "@/lib/api";

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
    <PageShell
      title={t('pricingTitle', 'PREMIUM LİSANS PAKETLERİ')}
      description={t('pricingDesc', 'Gayrimenkul portföyünüzü yapay zeka ve otomasyonla ölçeklendirmek için tasarlandı.')}
      stats={[
        { label: t('nodesDeployed', 'YÖNETİLEN MÜLK'), value: "14.2k", color: "text-blue-400" },
        { label: t('syncUptime', 'SİSTEM UPTIME'), value: "99.9%", color: "text-emerald-400" },
        { label: t('pricingLatency', 'API GECİKMESİ'), value: "4ms", color: "text-slate-400" },
        { label: t('globalReach', 'KÜRESEL ERİŞİM'), value: "42 BÖLGE" }
      ]}
    >
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-5 gap-6 px-4 max-w-[1600px] mx-auto">
        {isLoading ? (
          <div className="col-span-full flex flex-col items-center justify-center py-20 opacity-50">
            <Activity className="w-12 h-12 text-blue-500 animate-spin mb-4" />
            <p className="text-xs font-black text-slate-500 tracking-widest uppercase">{t('loading', 'YÜKLENİYOR...')}</p>
          </div>
        ) : plans.length === 0 ? (
          <div className="col-span-full flex flex-col items-center justify-center py-20 opacity-50">
            <p className="text-xs font-black text-slate-500 tracking-widest uppercase">{t('noPlansAvailable', 'PAKET BULUNAMADI')}</p>
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
                "relative p-10 rounded-[48px] bg-[#1a1b1e]/40 border border-white/5 backdrop-blur-3xl shadow-3xl flex flex-col h-full transition-all duration-500 hover:bg-white/5 group border-l border-t",
                isPopular && "border-blue-500/50 ring-1 ring-blue-500/20"
              )}
            >
              {isPopular && (
                <div className="absolute -top-6 left-1/2 -translate-x-1/2 bg-blue-600 text-white px-8 py-2 rounded-full text-[10px] font-black tracking-[0.3em] italic shadow-2xl shadow-blue-600/40 flex items-center gap-2">
                  <Star className="w-3 h-3 fill-white" /> {t('optimizedChoice', 'EN ÇOK TERCİH EDİLEN')}
                </div>
              )}

              <div className="space-y-6 mb-12">
                <div className="space-y-1">
                  <h3 className="text-sm font-black text-slate-500 tracking-widest uppercase italic">{plan.name}</h3>
                  <div className="flex items-baseline gap-2">
                      <span className="text-5xl font-black text-white italic tracking-tighter">{formatPrice(plan.priceMonthlyCents)}</span>
                      {plan.priceMonthlyCents !== null && <span className="text-slate-600 font-black text-xs italic uppercase">{t('cycle_per_unit', '/ BİRİM BAŞINA AY')}</span>}
                  </div>
                </div>
                <p className="text-[11px] font-bold text-slate-400 tracking-wider leading-relaxed italic h-10">
                  {t(`pricing.desc.${plan.key}`, 'İhtiyaçlarınıza özel gelişmiş yönetim paneli.')}
                </p>
              </div>

              <div className="space-y-4 mb-12 flex-1">
                <p className="text-[8px] font-black text-slate-600 tracking-[0.3em] italic border-b border-white/5 pb-2">{t('specs', 'ÖZELLİKLER')}</p>
                {generateFeatures(plan.limits).map((feature, fIdx) => (
                  <div key={fIdx} className="flex items-center gap-3">
                    <div className="h-5 w-5 rounded-full bg-blue-500/10 border border-blue-500/20 flex items-center justify-center shrink-0">
                      <Check className="w-3 h-3 text-blue-400" />
                    </div>
                    <span className="text-[10px] font-black text-white italic tracking-widest group-hover:text-blue-400 transition-colors">{feature}</span>
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
                  "w-full h-16 rounded-2xl font-black text-xs italic tracking-[0.2em] uppercase transition-all duration-300",
                  isPopular 
                    ? "bg-blue-600 hover:bg-blue-500 text-white shadow-xl shadow-blue-600/20" 
                    : "bg-white/5 hover:bg-white/10 text-white border border-white/10"
                )}
              >
                <Zap className="w-4 h-4 mr-2" /> {plan.priceMonthlyCents !== null ? t('getStarted', 'HEMEN BAŞLA') : t('contactSales', 'SATIŞ İLE İLETİŞİME GEÇ')}
              </Button>

              <div className="mt-8 flex items-center justify-center gap-4 opacity-30 group-hover:opacity-100 transition-opacity">
                <Fingerprint className="w-4 h-4 text-slate-500" />
                <Shield className="w-4 h-4 text-slate-500" />
                <Activity className="w-4 h-4 text-slate-500" />
              </div>
            </motion.div>
          );
        })}
      </div>

      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ delay: 0.5 }}
        className="mt-20 mx-4 p-12 rounded-[40px] bg-linear-to-b from-transparent to-[#1a1b1e]/20 border border-white/5 text-center"
      >
          <h2 className="text-xl font-black text-white italic tracking-tighter mb-4">{t('securityIncluded', 'ASKERİ DÜZEYDE GÜVENLİK')}</h2>
          <p className="text-[10px] font-black text-slate-500 tracking-[0.2em] italic max-w-2xl mx-auto mb-8">
            {t('securityDesc', 'Tüm paketlerimiz kurumsal düzeyde şifreleme ve gelişmiş veri güvenliği standartlarıyla korunmaktadır.')}
          </p>
          <div className="flex flex-wrap justify-center gap-12">
            {[ "AES-256", "SHA-512", "TLS 1.3", "RBAC", "ISO 27001"].map(auth => (
              <span key={auth} className="text-[9px] font-black text-slate-600 italic tracking-widest">{auth}</span>
            ))}
          </div>
      </motion.div>
    </PageShell>
  );
}
