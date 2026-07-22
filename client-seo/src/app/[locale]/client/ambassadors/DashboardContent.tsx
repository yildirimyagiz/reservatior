"use client";

import { useTranslation } from "react-i18next";
import { m, useScroll, useTransform } from "framer-motion";
import { Button } from "@/components/ui/button";
import Image from "next/image";
import { Users, Award, TrendingUp, Sparkles, Share2, DollarSign, QrCode } from "lucide-react";

export function DashboardContent() {
  const { t } = useTranslation();
  const { scrollY } = useScroll();
  const opacity = useTransform(scrollY, [0, 500], [1, 0]);

  return (
    <div className="min-h-screen bg-[#05020c] text-slate-50 selection:bg-pink-500 selection:text-white">
      
      {/* ══════ HERO SECTION ══════ */}
      <section className="relative h-[80svh] w-full overflow-hidden flex items-center justify-center">
        <m.div style={{ opacity }} className="absolute inset-0">
          <Image 
            src="https://images.unsplash.com/photo-1552581230-c01374104636?q=80&w=2670&auto=format&fit=crop" 
            alt="Ambassadors" 
            fill 
            sizes="100vw"
            className="object-cover opacity-40 transform scale-105" 
            priority
          />
          <div className="absolute inset-0 bg-gradient-to-t from-[#05020c] via-transparent to-transparent" />
          <div className="absolute inset-0 bg-gradient-to-r from-[#05020c]/90 via-transparent to-transparent" />
        </m.div>

        <div className="relative z-10 container mx-auto px-6 pt-24 flex flex-col items-start max-w-7xl">
          <m.div initial={{ opacity: 0, y: 30 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.8 }} className="max-w-3xl">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-pink-500/20 border border-pink-500/30 text-pink-300 mb-6 backdrop-blur-md">
              <Award className="w-4 h-4" />
              <span className="text-xs font-bold tracking-widest uppercase">{t("client.ambassador.badge", { defaultValue: "Ambassador Program" })}</span>
            </div>
            <h1 className="text-5xl md:text-7xl font-black tracking-tight mb-6 leading-tight">
              {t("client.ambassador.title", { defaultValue: "Share Luxury. Earn Commissions." })}
            </h1>
            <p className="text-lg md:text-2xl text-slate-300 mb-10 max-w-2xl font-light">
              {t("client.ambassador.subtitle", { defaultValue: "Join the elite Reservatior Ambassador network. Invite property owners and guests to earn passive income." })}
            </p>
            <div className="flex flex-wrap gap-4">
              <Button size="lg" className="rounded-full px-8 h-14 bg-white text-black hover:bg-slate-200 font-bold transition-all hover:scale-105">
                {t("client.ambassador.cta_primary", { defaultValue: "Apply Now" })}
              </Button>
              <Button size="lg" variant="outline" className="rounded-full px-8 h-14 border-white/20 hover:bg-white/10 font-bold backdrop-blur-md">
                {t("client.ambassador.cta_secondary", { defaultValue: "Commission Structure" })}
              </Button>
            </div>
          </m.div>
        </div>
      </section>

      {/* ══════ BENTO GRID PANELS ══════ */}
      <section className="py-24 relative z-20 -mt-20">
        <div className="container mx-auto px-6 max-w-7xl">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            
            {/* Rewards Card */}
            <m.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.1 }}
              className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div>
                <DollarSign className="w-10 h-10 text-emerald-400 mb-6" />
                <h3 className="text-2xl font-bold mb-2">{t("client.ambassador.panel1_title", { defaultValue: "Total Earnings" })}</h3>
                <p className="text-slate-400 text-sm">
                  {t("client.ambassador.panel1_desc", { defaultValue: "Track your pending approvals, direct referral payouts, and monthly passive income." })}
                </p>
              </div>
              <h4 className="text-4xl font-black mt-8 text-emerald-400">$0.00</h4>
            </m.div>

            {/* Links and Shares */}
            <m.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.2 }}
              className="md:col-span-2 bg-white/5 border border-white/10 rounded-[2.5rem] p-8 md:p-12 backdrop-blur-xl relative overflow-hidden group">
              <div className="absolute top-0 right-0 w-80 h-80 bg-pink-500/10 rounded-full blur-[100px] group-hover:bg-pink-500/20 transition-all duration-700" />
              <Share2 className="w-12 h-12 text-pink-400 mb-6" />
              <h3 className="text-3xl font-black mb-4">{t("client.ambassador.panel2_title", { defaultValue: "Your Unique Link" })}</h3>
              <p className="text-slate-400 text-lg max-w-md mb-8">
                {t("client.ambassador.panel2_desc", { defaultValue: "Share this link with property owners. When they list their home, you earn 1.5% of all bookings." })}
              </p>
              <div className="flex gap-3">
                <Button className="rounded-full bg-pink-600 hover:bg-pink-700 text-white font-bold h-12 px-6">
                  {t("client.ambassador.copy_link", { defaultValue: "Copy Referral Link" })}
                </Button>
              </div>
            </m.div>

            {/* QR Codes */}
            <m.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.3 }}
              className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8 backdrop-blur-xl relative overflow-hidden group">
              <QrCode className="w-10 h-10 text-pink-400 mb-6" />
              <h3 className="text-2xl font-bold mb-4">{t("client.ambassador.panel3_title", { defaultValue: "Flyer Creator" })}</h3>
              <p className="text-slate-400 text-sm">
                {t("client.ambassador.panel3_desc", { defaultValue: "Generate ready-to-print flyers and QR codes with your referral parameters." })}
              </p>
            </m.div>

            {/* Program details */}
            <m.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.4 }}
              className="md:col-span-2 bg-gradient-to-br from-pink-950/40 to-slate-950/40 border border-pink-500/20 rounded-[2.5rem] p-8 md:p-12 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div>
                <Users className="w-12 h-12 text-pink-400 mb-6" />
                <h3 className="text-3xl font-black mb-4">{t("client.ambassador.panel4_title", { defaultValue: "Network Statistics" })}</h3>
                <p className="text-slate-300 text-lg max-w-md">
                  {t("client.ambassador.panel4_desc", { defaultValue: "See how many users registered using your link and the total listings they brought to the platform." })}
                </p>
              </div>
            </m.div>

          </div>
        </div>
      </section>

    </div>
  );
}

export default DashboardContent;
