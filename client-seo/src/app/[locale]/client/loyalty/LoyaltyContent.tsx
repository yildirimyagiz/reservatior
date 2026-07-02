"use client";

import { useTranslation } from "react-i18next";
import { motion, useScroll, useTransform } from "framer-motion";
import { Button } from "@/components/ui/button";
import Image from "next/image";
import { Trophy, Star, Gift, Gem, Coins, ArrowRight, Plane, Coffee, BadgeCheck, Compass, Clock } from "lucide-react";

export function LoyaltyContent() {
  const { t } = useTranslation();
  const { scrollY } = useScroll();
  const opacity = useTransform(scrollY, [0, 500], [1, 0]);

  return (
    <div className="min-h-screen bg-[#060402] text-slate-50 selection:bg-amber-500 selection:text-white">
      
      {/* ══════ HERO SECTION ══════ */}
      <section className="relative h-[80svh] w-full overflow-hidden flex items-center justify-center">
        <motion.div style={{ opacity }} className="absolute inset-0">
          <Image 
            src="https://images.unsplash.com/photo-1571896349842-33c89424de2d?q=80&w=2680&auto=format&fit=crop" 
            alt="Loyalty Program" 
            fill 
            className="object-cover opacity-35 transform scale-105" 
            priority
          />
          <div className="absolute inset-0 bg-gradient-to-t from-[#060402] via-transparent to-transparent" />
          <div className="absolute inset-0 bg-gradient-to-r from-[#060402]/90 via-transparent to-transparent" />
        </motion.div>

        <div className="relative z-10 container mx-auto px-6 pt-24 flex flex-col items-start max-w-7xl">
          <motion.div initial={{ opacity: 0, y: 30 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.8 }} className="max-w-3xl">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-amber-500/20 border border-amber-500/30 text-amber-300 mb-6 backdrop-blur-md">
              <Trophy className="w-4 h-4" />
              <span className="text-xs font-bold tracking-widest uppercase">{t("client.loyalty.badge", { defaultValue: "Loyalty Club" })}</span>
            </div>
            <h1 className="text-5xl md:text-7xl font-black tracking-tight mb-6 leading-tight">
              {t("client.loyalty.title", { defaultValue: "Unmatched Perks. Infinite Rewards." })}
            </h1>
            <p className="text-lg md:text-2xl text-slate-300 mb-10 max-w-2xl font-light">
              {t("client.loyalty.subtitle", { defaultValue: "Earn Reservatior Coins with every booking. Redeem them for room upgrades, free spa vouchers, or local flights." })}
            </p>
            <div className="flex flex-wrap gap-4">
              <Button size="lg" className="rounded-full px-8 h-14 bg-white text-black hover:bg-slate-200 font-bold transition-all hover:scale-105">
                {t("client.loyalty.cta_primary", { defaultValue: "My Membership" })}
              </Button>
              <Button size="lg" variant="outline" className="rounded-full px-8 h-14 border-white/20 hover:bg-white/10 font-bold backdrop-blur-md">
                {t("client.loyalty.cta_secondary", { defaultValue: "Perks Catalog" })}
              </Button>
            </div>
          </motion.div>
        </div>
      </section>

      {/* ══════ LOYALTY METRICS GRID ══════ */}
      <section className="py-24 relative z-20 -mt-20">
        <div className="container mx-auto px-6 max-w-7xl">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            
            {/* Balance */}
            <motion.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.1 }}
              className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div>
                <Coins className="w-10 h-10 text-amber-400 mb-6 animate-spin" />
                <h3 className="text-2xl font-bold mb-2">{t("client.loyalty.panel1_title", { defaultValue: "Reservatior Coins" })}</h3>
                <p className="text-slate-400 text-sm">
                  {t("client.loyalty.panel1_desc", { defaultValue: "Use these coins to book stays, tours, or request luxury concierge services." })}
                </p>
              </div>
              <h4 className="text-4xl font-black mt-8 text-amber-400">0 Coins</h4>
            </motion.div>

            {/* Current Level */}
            <motion.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.2 }}
              className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div>
                <Gem className="w-10 h-10 text-amber-400 mb-6" />
                <h3 className="text-2xl font-bold mb-2">{t("client.loyalty.panel2_title", { defaultValue: "Membership Level" })}</h3>
                <p className="text-slate-400 text-sm">
                  {t("client.loyalty.panel2_desc", { defaultValue: "Unlock more privileges as your membership rank increases (Gold, Platinum, Black Edition)." })}
                </p>
              </div>
              <h4 className="text-3xl font-black mt-8 text-slate-200">Classic</h4>
            </motion.div>

            {/* Next Milestone */}
            <motion.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.3 }}
              className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div>
                <Star className="w-10 h-10 text-amber-400 mb-6" />
                <h3 className="text-2xl font-bold mb-2">{t("client.loyalty.panel3_title", { defaultValue: "Next Level Status" })}</h3>
                <p className="text-slate-400 text-sm">
                  {t("client.loyalty.panel3_desc", { defaultValue: "Stays or coins required to advance to the next privileged membership level." })}
                </p>
              </div>
              <h4 className="text-xl font-bold mt-8 text-slate-300">10,000 pts to Gold</h4>
            </motion.div>

            {/* Benefits Bento */}
            <motion.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.4 }}
              className="md:col-span-3 bg-gradient-to-br from-amber-950/30 to-slate-950/40 border border-amber-500/20 rounded-[2.5rem] p-8 md:p-12 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div className="absolute top-0 right-0 w-96 h-96 bg-amber-500/10 rounded-full blur-[120px]" />
              <div className="relative z-10">
                <BadgeCheck className="w-12 h-12 text-amber-400 mb-6" />
                <h3 className="text-3xl font-black mb-4">{t("client.loyalty.panel4_title", { defaultValue: "Elite Club Benefits" })}</h3>
                <p className="text-slate-300 text-lg max-w-2xl leading-relaxed">
                  {t("client.loyalty.panel4_desc", { defaultValue: "Gold level and above enjoy free early check-ins, late check-outs, airport VIP transfers, and bespoke welcome gifts directly inside their properties." })}
                </p>
              </div>
            </motion.div>

          </div>
        </div>
      </section>

    </div>
  );
}

export default LoyaltyContent;
