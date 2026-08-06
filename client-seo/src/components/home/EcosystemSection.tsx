"use client";

import { useState, useEffect } from "react";
import { useTranslation } from "react-i18next";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { m, AnimatePresence } from "framer-motion";
import { Monitor, Gem, ShieldCheck, Sparkles, CheckCircle2, Mouse } from "lucide-react";
import { useLocalization } from "@/contexts/LocalizationContext";
import { formatCurrency } from "@/lib/utils/localization";

function EcosystemPreview() {
  const { t } = useTranslation();
  const { currency, locale } = useLocalization();
  const [activeTab, setActiveTab] = useState(0);

  useEffect(() => {
    const timer = setInterval(() => {
      setActiveTab((prev) => (prev + 1) % 3);
    }, 4000);
    return () => clearInterval(timer);
  }, []);

  const tabs = [
    {
      id: "agent-os",
      icon: <Monitor className="w-5 h-5 text-brand dark:text-brand" />,
      title: t("home.preview.agent_os"),
      content: (
        <div className="flex flex-col gap-4 h-full justify-center">
          <div className="flex justify-between items-center bg-muted/50 rounded-2xl p-5 border border-border hover:bg-muted transition-colors">
            <div>
              <div className="text-muted-foreground text-sm font-medium mb-1">{t("home.preview.commission_share")}</div>
              <div className="text-3xl font-black text-foreground">%70 / %30</div>
            </div>
            <div className="w-14 h-14 rounded-full bg-brand/10 flex items-center justify-center">
              <Sparkles className="w-7 h-7 text-brand dark:text-brand" />
            </div>
          </div>
          <div className="flex justify-between items-center bg-muted/50 rounded-2xl p-5 border border-border hover:bg-muted transition-colors">
            <div>
              <div className="text-muted-foreground text-sm font-medium mb-1">{t("home.preview.passive_income")}</div>
              <div className="text-2xl font-bold text-success dark:text-success">{formatCurrency(12450, currency, locale)} {t("home.preview.per_month")}</div>
            </div>
            <div className="w-14 h-14 rounded-full bg-success/10 flex items-center justify-center">
              <CheckCircle2 className="w-7 h-7 text-success dark:text-success" />
            </div>
          </div>
        </div>
      )
    },
    {
      id: "fintech",
      icon: <Gem className="w-5 h-5 text-brand dark:text-brand" />,
      title: t("home.preview.fintech"),
      content: (
        <div className="flex flex-col gap-4 h-full justify-center">
          <div className="text-center">
            <div className="inline-flex items-center justify-center w-20 h-20 rounded-full bg-gradient-to-br from-brand/10 to-pink-500/10 mb-6 border border-brand/20 shadow-[0_0_30px_hsl(var(--brand)/0.2)]">
              <ShieldCheck className="w-10 h-10 text-brand dark:text-brand" />
            </div>
            <span className="text-4xl font-black text-foreground mb-2 block">{t("home.preview.zero_commission")}</span>
            <p className="text-muted-foreground font-medium">{t("home.preview.open_banking")}</p>
          </div>
          <div className="bg-gradient-to-r from-brand/10 to-pink-500/10 rounded-2xl p-4 border border-brand/20 mt-6 text-center shadow-inner">
            <span className="text-sm font-black tracking-widest text-brand dark:text-brand">{t("home.preview.escrow_guarantee")}</span>
          </div>
        </div>
      )
    },
    {
      id: "ai-studio",
      icon: <Mouse className="w-5 h-5 text-success dark:text-success" />,
      title: t("home.preview.ai_studio"),
      content: (
        <div className="flex flex-col gap-4 h-full justify-center">
          {[
            { label: t("home.preview.ai_match"), status: t("home.preview.ai_match_status"), color: "text-success dark:text-success", bg: "bg-success/5 border-success/20" },
            { label: t("home.preview.ai_listing"), status: t("home.preview.ai_listing_status"), color: "text-success dark:text-success", bg: "bg-success/5 border-success/20" },
            { label: t("home.preview.ai_rag"), status: t("home.preview.ai_rag_status"), color: "text-brand dark:text-brand", bg: "bg-brand/5 border-brand/20" },
          ].map((item, i) => (
            <m.div key={i} initial={{ opacity: 0, x: 20 }} animate={{ opacity: 1, x: 0 }} transition={{ delay: i * 0.15 }}
              className={`flex justify-between items-center p-5 rounded-2xl border ${item.bg}`}>
              <span className="text-foreground/80 font-medium">{item.label}</span>
              <span className={`font-bold ${item.color}`}>{item.status}</span>
            </m.div>
          ))}
        </div>
      )
    }
  ];

  return (
    <div className="w-full h-full rounded-[2rem] border border-border bg-card/80 backdrop-blur-2xl shadow-2xl p-8 flex flex-col gap-8">
      <div className="flex justify-between items-center pb-6 border-b border-border">
        <div className="flex gap-3 bg-muted/50 p-1.5 rounded-full border border-border">
          {tabs.map((tab, i) => (
            <button
              key={tab.id}
              onClick={() => setActiveTab(i)}
              aria-label={t(`home.tab_${tab.id}`, { defaultValue: tab.title })}
              className={`px-5 py-2.5 rounded-full text-sm font-bold transition-all flex items-center gap-2 ${
                activeTab === i ? 'bg-background text-foreground shadow-sm' : 'bg-transparent text-muted-foreground hover:text-foreground'
              }`}
            >
              {tab.icon}
              <span className="hidden sm:inline">{tab.title}</span>
            </button>
          ))}
        </div>
      </div>

      <div className="flex-1 relative overflow-hidden min-h-[250px]">
        <AnimatePresence mode="wait">
          <m.div
            key={activeTab}
            initial={{ opacity: 0, y: 20, scale: 0.95 }}
            animate={{ opacity: 1, y: 0, scale: 1 }}
            exit={{ opacity: 0, y: -20, scale: 0.95 }}
            transition={{ duration: 0.4, ease: "easeOut" }}
            className="absolute inset-0 flex flex-col justify-center"
          >
            {tabs[activeTab].content}
          </m.div>
        </AnimatePresence>
      </div>

      <div className="h-24 bg-gradient-to-r from-brand/15 via-brand/15 to-transparent rounded-2xl border border-border flex items-center justify-between p-6">
        <div>
          <div className="text-muted-foreground font-medium mb-1.5">Global Operasyonel Sistem Durumu</div>
          <div className="text-foreground font-bold flex items-center gap-3 text-lg">
            <div className="w-3 h-3 rounded-full bg-success animate-pulse shadow-[0_0_10px_rgba(16,185,129,0.8)]" />
            Tüm FinTech, Güvenlik ve AI Modülleri 7/24 Devrede
          </div>
        </div>
        <Sparkles className="w-8 h-8 text-muted-foreground/30" />
      </div>
    </div>
  );
}

export default function EcosystemSection() {
  const { t } = useTranslation();

  return (
    <section className="py-32 bg-background text-foreground overflow-hidden relative">
      <div className="absolute top-0 right-0 w-[800px] h-[800px] bg-brand/10 rounded-full blur-[120px] pointer-events-none" />
      <div className="max-w-[1800px] mx-auto px-6 md:px-12 relative z-10">
        <div className="grid lg:grid-cols-2 gap-16 items-center">
          <m.div initial={{ opacity: 0, x: -40 }} whileInView={{ opacity: 1, x: 0 }} viewport={{ once: true }}>
            <span className="text-brand font-black tracking-widest uppercase text-sm mb-4 block">
              {t("home.ecosystem.badge", { defaultValue: "Emlak Teknolojisi & OS" })}
            </span>
            <h2 className="text-4xl md:text-6xl font-black tracking-tighter leading-tight mb-6">
              {t("home.ecosystem.title", { defaultValue: "Danışmanlar ve Mülk Yöneticileri İçin İşletim Sistemi." })}
            </h2>
            <p className="text-xl text-muted-foreground mb-10 font-medium max-w-lg leading-relaxed">
              {t("home.ecosystem.desc", { defaultValue: "FinTech ve yapay zeka entegre gayrimenkul ekosistemi. Komisyonsuz Açık Bankacılık transferlerinden pasif gelir ortaklık ağlarına kadar, emlak işinizi ve portföyünüzü tek bir kontrol merkezinden yönetin." })}
            </p>

            <div className="space-y-6">
              {[
                { icon: Monitor, title: "Danışman İşletim Sistemi (OS)", desc: "Komisyon paylaşım planlarını, sözleşme süreçlerini ve ofis içi operasyonları tam otomatikleştirin." },
                { icon: Gem, title: "%0 Kesintili Finans Altyapısı", desc: "Açık bankacılık (A2A) transferleri ve 21 günlük Escrow depozito güvence mekanizması ile doğrudan tahsilat yapın." },
                { icon: ShieldCheck, title: "Akıllı Yapay Zeka Stüdyosu", desc: "Anlam odaklı nöral arama motoru ile doğru alıcıyı bulun ve portföyünüze özel ilan pazarlama materyalleri hazırlayın." },
              ].map((feature, i) => (
                <div key={i} className="flex gap-4">
                  <div className="w-12 h-12 rounded-2xl bg-muted/50 flex items-center justify-center shrink-0 border border-border">
                    <feature.icon className="w-6 h-6 text-foreground" />
                  </div>
                  <div>
                    <h3 className="text-lg font-bold text-foreground">{feature.title}</h3>
                    <p className="text-muted-foreground text-sm">{feature.desc}</p>
                  </div>
                </div>
              ))}
            </div>

            <Button className="mt-12 rounded-full h-14 px-8 bg-primary text-primary-foreground hover:bg-primary/90 font-bold text-base transition-all hover:scale-105" asChild>
              <Link href="/admin/dashboard">
                {t("home.ecosystem.cta", { defaultValue: "Platform Özelliklerini Keşfet" })}
              </Link>
            </Button>
          </m.div>

          <m.div initial={{ opacity: 0, scale: 0.95 }} whileInView={{ opacity: 1, scale: 1 }} viewport={{ once: true }}
            className="relative aspect-square md:aspect-auto md:h-[700px] w-full rounded-[3rem] border border-border bg-gradient-to-br from-muted/30 to-transparent overflow-hidden shadow-2xl flex items-center justify-center p-4 md:p-8">
            <EcosystemPreview />
          </m.div>
        </div>
      </div>
    </section>
  );
}
