"use client";

import { useTranslation } from "react-i18next";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { m } from "framer-motion";
import { Globe, ArrowRight } from "lucide-react";

export default function GlobalOSSection() {
  const { t } = useTranslation();

  return (
    <section className="py-20 px-6 md:px-12">
      <m.div
        initial={{ opacity: 0, y: 40 }}
        whileInView={{ opacity: 1, y: 0 }}
        viewport={{ once: true }}
        transition={{ duration: 0.7 }}
        className="max-w-[1400px] mx-auto relative overflow-hidden rounded-[2rem] bg-gradient-to-br from-emerald-950/80 via-slate-900/90 to-blue-950/80 border border-emerald-500/20 p-10 md:p-16"
      >
        <div className="absolute top-0 right-0 w-96 h-96 bg-emerald-500/10 blur-[120px] rounded-full pointer-events-none" />
        <div className="absolute bottom-0 left-0 w-64 h-64 bg-blue-500/10 blur-[100px] rounded-full pointer-events-none" />

        <div className="relative z-10 grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
          <div>
            <div className="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-emerald-500/10 border border-emerald-500/20 mb-6">
              <Globe className="w-4 h-4 text-emerald-400" />
              <span className="text-xs font-bold text-emerald-400 tracking-widest uppercase">
                {t("home.global_os_badge", "Global Operasyon Ağı")}
              </span>
              <span className="px-1.5 py-0.5 rounded-full bg-emerald-500/20 text-emerald-300 text-[9px] font-bold">{t("home.preview.new_badge")}</span>
            </div>
            <h2 className="text-3xl md:text-5xl font-black tracking-tighter text-white leading-[1.1] mb-4">
              {t("home.global_os_title_1", "Tek Platform.")}{" "}
              <span className="bg-gradient-to-r from-emerald-400 via-blue-400 to-purple-400 bg-clip-text text-transparent">
                {t("home.global_os_title_2", "23 Ülkedeki Operasyonlar.")}
              </span>
            </h2>
            <p className="text-sm md:text-base text-slate-400 leading-relaxed mb-8 max-w-lg">
              {t("home.global_os_desc", "Kısa dönem tatil konaklaması, kurumsal konaklama ve rezidans operasyonlarınızı dünya genelinde tek ekrandan yönetin. Yapay zeka destekli ülkeye özel vergi optimizasyonu, yasal uygunluk kontrolü ve akıllı gelir analiz motoru.")}
            </p>
            <Link href="/global-os">
              <Button className="bg-emerald-500 hover:bg-emerald-600 text-white font-bold px-8 py-5 text-sm rounded-2xl gap-2">
                {t("home.global_os_cta", "Global Platformu İncele")}
                <ArrowRight className="w-4 h-4" />
              </Button>
            </Link>
          </div>

          <div className="grid grid-cols-2 gap-3">
            {[
              { value: "0%", label: t("home.global_os_s1", "Komisyon Kesintisi"), color: "border-emerald-500/30 bg-emerald-500/5", icon: "💸" },
              { value: "10", label: t("home.global_os_s2", "Gelir Kademesi"), color: "border-amber-500/30 bg-amber-500/5", icon: "🔗" },
              { value: "15+", label: t("home.global_os_s3", "Akıllı AI Asistanı"), color: "border-purple-500/30 bg-purple-500/5", icon: "🧠" },
              { value: "21", label: t("home.global_os_s4", "Günlük Escrow"), color: "border-blue-500/30 bg-blue-500/5", icon: "🏦" },
              { value: "100%", label: t("home.global_os_s5", "Doğrudan Ödeme (A2A)"), color: "border-cyan-500/30 bg-cyan-500/5", icon: "⚡" },
              { value: "24/7", label: t("home.global_os_s6", "Kesintisiz Arama"), color: "border-rose-500/30 bg-rose-500/5", icon: "🔍" },
            ].map((s) => (
              <div key={s.label} className={`rounded-2xl border ${s.color} p-4 flex items-center gap-3`}>
                <div className="text-2xl">{s.icon}</div>
                <div>
                  <div className="text-2xl font-black text-white">{s.value}</div>
                  <div className="text-[10px] text-slate-500 font-medium">{s.label}</div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </m.div>
    </section>
  );
}
