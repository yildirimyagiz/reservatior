"use client";

import { useTranslation } from "react-i18next";
import { motion, useScroll, useTransform } from "framer-motion";
import { Button } from "@/components/ui/button";
import Image from "next/image";
import { Gem, Car, Shield, Compass, User, Clock } from "lucide-react";

export function ConciergeContent() {
  const { t } = useTranslation();
  const { scrollY } = useScroll();
  const opacity = useTransform(scrollY, [0, 500], [1, 0]);

  return (
    <div className="min-h-screen bg-[#030205] text-slate-50 selection:bg-amber-500 selection:text-white">
      
      {/* ══════ HERO SECTION ══════ */}
      <section className="relative h-[80svh] w-full overflow-hidden flex items-center justify-center">
        <motion.div style={{ opacity }} className="absolute inset-0">
          <Image 
            src="https://images.unsplash.com/photo-1540555700478-4be289fbecef?q=80&w=2670&auto=format&fit=crop" 
            alt="VIP Concierge" 
            fill 
            className="object-cover opacity-40 transform scale-105" 
            priority
          />
          <div className="absolute inset-0 bg-gradient-to-t from-[#030205] via-transparent to-transparent" />
          <div className="absolute inset-0 bg-gradient-to-r from-[#030205]/90 via-transparent to-transparent" />
        </motion.div>

        <div className="relative z-10 container mx-auto px-6 pt-24 flex flex-col items-start max-w-7xl">
          <motion.div initial={{ opacity: 0, y: 30 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.8 }} className="max-w-3xl">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-amber-500/20 border border-amber-500/30 text-amber-300 mb-6 backdrop-blur-md">
              <Gem className="w-4 h-4" />
              <span className="text-xs font-bold tracking-widest uppercase">{t("client.concierge.badge", { defaultValue: "Concierge & VIP" })}</span>
            </div>
            <h1 className="text-5xl md:text-7xl font-black tracking-tight mb-6 leading-tight">
              {t("client.concierge.title", { defaultValue: "Besupoke Luxury, Curated For You." })}
            </h1>
            <p className="text-lg md:text-2xl text-slate-300 mb-10 max-w-2xl font-light">
              {t("client.concierge.subtitle", { defaultValue: "Private chefs, luxury car hires, executive protection, and premium bookings. Anything, anywhere, at any time." })}
            </p>
            <div className="flex flex-wrap gap-4">
              <Button size="lg" className="rounded-full px-8 h-14 bg-white text-black hover:bg-slate-200 font-bold transition-all hover:scale-105">
                {t("client.concierge.cta_primary", { defaultValue: "Request Service" })}
              </Button>
              <Button size="lg" variant="outline" className="rounded-full px-8 h-14 border-white/20 hover:bg-white/10 font-bold backdrop-blur-md">
                {t("client.concierge.cta_secondary", { defaultValue: "View Catalog" })}
              </Button>
            </div>
          </motion.div>
        </div>
      </section>

      {/* ══════ CONCIERGE OPTIONS GRID ══════ */}
      <section className="py-24 relative z-20 -mt-20">
        <div className="container mx-auto px-6 max-w-7xl">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            
            {/* Private Transport */}
            <motion.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.1 }}
              className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div>
                <Car className="w-10 h-10 text-amber-400 mb-6" />
                <h3 className="text-2xl font-bold mb-2">{t("client.concierge.panel1_title", { defaultValue: "Elite Transport" })}</h3>
                <p className="text-slate-400 text-sm">
                  {t("client.concierge.panel1_desc", { defaultValue: "Book supercars, private jets, or luxury yacht charters instantly with chauffeured services." })}
                </p>
              </div>
            </motion.div>

            {/* Executive Protection */}
            <motion.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.2 }}
              className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div>
                <Shield className="w-10 h-10 text-amber-400 mb-6" />
                <h3 className="text-2xl font-bold mb-2">{t("client.concierge.panel2_title", { defaultValue: "Close Protection" })}</h3>
                <p className="text-slate-400 text-sm">
                  {t("client.concierge.panel2_desc", { defaultValue: "Discrete, licensed executive bodyguards and security details for total peace of mind." })}
                </p>
              </div>
            </motion.div>

            {/* Private Dining */}
            <motion.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.3 }}
              className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div>
                <Compass className="w-10 h-10 text-amber-400 mb-6" />
                <h3 className="text-2xl font-bold mb-2">{t("client.concierge.panel3_title", { defaultValue: "Private Chefs & Dining" })}</h3>
                <p className="text-slate-400 text-sm">
                  {t("client.concierge.panel3_desc", { defaultValue: "Michelin-starred chefs preparing custom tasting menus directly inside your suite." })}
                </p>
              </div>
            </motion.div>

            {/* VIP Concierge Service Bento Box */}
            <motion.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.4 }}
              className="md:col-span-3 bg-gradient-to-br from-amber-950/30 to-slate-950/40 border border-amber-500/20 rounded-[2.5rem] p-8 md:p-12 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div className="absolute top-0 right-0 w-96 h-96 bg-amber-500/10 rounded-full blur-[120px]" />
              <div className="relative z-10">
                <Clock className="w-12 h-12 text-amber-400 mb-6" />
                <h3 className="text-3xl font-black mb-4">{t("client.concierge.panel4_title", { defaultValue: "24/7 Dedicated Support" })}</h3>
                <p className="text-slate-300 text-lg max-w-2xl leading-relaxed">
                  {t("client.concierge.panel4_desc", { defaultValue: "Every booking includes a dedicated human concierge assistant available on chat to solve your reservations, flight changes, or last-minute requests." })}
                </p>
              </div>
            </motion.div>

          </div>
        </div>
      </section>

    </div>
  );
}

export default ConciergeContent;
