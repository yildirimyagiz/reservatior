"use client";

import { useTranslation } from "react-i18next";
import { m, useScroll, useTransform } from "framer-motion";
import { Button } from "@/components/ui/button";
import Image from "next/image";
import { Building2, Globe2, Briefcase, TrendingUp, Users, ShieldCheck, ArrowRight, Zap, Target } from "lucide-react";
import Link from "next/link";

export function B2BContent() {
  const { t } = useTranslation();
  const { scrollY } = useScroll();
  const opacity = useTransform(scrollY, [0, 500], [1, 0]);

  return (
    <div className="min-h-screen bg-[#020817] text-muted-foreground selection:bg-brand/100 selection:text-white">
      
      {/* ══════ HERO SECTION ══════ */}
      <section className="relative h-[80svh] w-full overflow-hidden flex items-center justify-center">
        <m.div style={{ opacity }} className="absolute inset-0">
          <Image 
            src="https://images.unsplash.com/photo-1582719508461-905c673771fd?q=80&w=2525&auto=format&fit=crop" 
            alt="B2B Hotels" 
            fill 
            sizes="100vw"
            className="object-cover opacity-50" 
            priority
          />
          <div className="absolute inset-0 bg-gradient-to-t from-[#020817] via-transparent to-transparent" />
          <div className="absolute inset-0 bg-gradient-to-r from-[#020817]/80 via-transparent to-transparent" />
        </m.div>

        <div className="relative z-10 container mx-auto px-6 pt-24 flex flex-col items-start max-w-7xl">
          <m.div initial={{ opacity: 0, y: 30 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.8 }} className="max-w-3xl">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-brand/20 border border-blue-500/30 text-blue-300 mb-6 backdrop-blur-md">
              <Building2 className="w-4 h-4" />
              <span className="text-xs font-bold tracking-widest uppercase">{t("client.b2b.badge", { defaultValue: "Enterprise Solutions" })}</span>
            </div>
            <h1 className="text-5xl md:text-7xl font-black tracking-tight mb-6 leading-tight">
              {t("client.b2b.title", { defaultValue: "Scale Your Hotel & Agency Business." })}
            </h1>
            <p className="text-lg md:text-2xl text-muted-foreground mb-10 max-w-2xl font-light">
              {t("client.b2b.subtitle", { defaultValue: "Connect your inventory to our global distribution network. API integrations, bulk pricing, and dedicated account management." })}
            </p>
            <div className="flex flex-wrap gap-4">
              <Button size="lg" className="rounded-full px-8 h-14 bg-card text-black hover:bg-muted font-bold transition-all hover:scale-105">
                {t("client.b2b.cta_primary", { defaultValue: "Partner With Us" })}
              </Button>
              <Button size="lg" variant="outline" className="rounded-full px-8 h-14 border-white/20 hover:bg-white/10 font-bold backdrop-blur-md">
                {t("client.b2b.cta_secondary", { defaultValue: "View API Docs" })}
              </Button>
            </div>
          </m.div>
        </div>
      </section>

      {/* ══════ FEATURES BENTO GRID ══════ */}
      <section className="py-24 relative z-20 -mt-20">
        <div className="container mx-auto px-6 max-w-7xl">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            
            {/* Feature 1 */}
            <m.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.1 }}
              className="md:col-span-2 bg-white/5 border border-white/10 rounded-3xl p-8 md:p-12 backdrop-blur-xl relative overflow-hidden group">
              <div className="absolute top-0 right-0 w-64 h-64 bg-brand/10 rounded-full blur-[80px] group-hover:bg-brand/20 transition-all duration-700" />
              <Globe2 className="w-12 h-12 text-brand mb-6" />
              <h3 className="text-3xl font-black mb-4">{t("client.b2b.f1_title", { defaultValue: "Global Distribution (GDS)" })}</h3>
              <p className="text-muted-foreground text-lg max-w-md">
                {t("client.b2b.f1_desc", { defaultValue: "List your hotel inventory across 500+ channels simultaneously. Sync rates, availability, and policies in real-time." })}
              </p>
            </m.div>

            {/* Feature 2 */}
            <m.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.2 }}
              className="bg-white/5 border border-white/10 rounded-3xl p-8 backdrop-blur-xl relative overflow-hidden group">
              <Zap className="w-10 h-10 text-yellow-400 mb-6" />
              <h3 className="text-2xl font-bold mb-4">{t("client.b2b.f2_title", { defaultValue: "Instant API" })}</h3>
              <p className="text-muted-foreground">
                {t("client.b2b.f2_desc", { defaultValue: "Lightning-fast GraphQL and REST APIs for custom frontends and mobile apps." })}
              </p>
            </m.div>

            {/* Feature 3 */}
            <m.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.3 }}
              className="bg-white/5 border border-white/10 rounded-3xl p-8 backdrop-blur-xl relative overflow-hidden group">
              <ShieldCheck className="w-10 h-10 text-success mb-6" />
              <h3 className="text-2xl font-bold mb-4">{t("client.b2b.f3_title", { defaultValue: "Secure Payments" })}</h3>
              <p className="text-muted-foreground">
                {t("client.b2b.f3_desc", { defaultValue: "Automated payouts, multi-currency support, and enterprise-grade fraud protection." })}
              </p>
            </m.div>

            {/* Feature 4 */}
            <m.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.4 }}
              className="md:col-span-2 bg-gradient-to-br from-blue-900/40 to-info/40 border border-blue-500/20 rounded-3xl p-8 md:p-12 backdrop-blur-xl relative overflow-hidden group">
              <Target className="w-12 h-12 text-brand mb-6" />
              <h3 className="text-3xl font-black mb-4">{t("client.b2b.f4_title", { defaultValue: "White-Label Solutions" })}</h3>
              <p className="text-muted-foreground text-lg max-w-md mb-8">
                {t("client.b2b.f4_desc", { defaultValue: "Launch your own branded booking platform using our powerful backend engine in minutes." })}
              </p>
              <Button className="rounded-full bg-blue-600 hover:bg-brand text-white font-bold h-12 px-6">
                {t("client.b2b.learn_more", { defaultValue: "Learn More" })} <ArrowRight className="w-4 h-4 ml-2" />
              </Button>
            </m.div>

          </div>
        </div>
      </section>
      
      {/* ══════ STATS SECTION ══════ */}
      <section className="py-24 border-t border-white/10">
        <div className="container mx-auto px-6 max-w-7xl">
          <div className="grid grid-cols-2 md:grid-cols-4 gap-8 text-center">
            {[
              { label: "Partner Hotels", value: "10,000+", icon: Building2 },
              { label: "Daily Bookings", value: "$5M+", icon: TrendingUp },
              { label: "Active Agencies", value: "2,500+", icon: Briefcase },
              { label: "Global Reach", value: "120+", icon: Globe2 },
            ].map((stat, i) => (
              <m.div key={i} initial={{ opacity: 0, scale: 0.9 }} whileInView={{ opacity: 1, scale: 1 }} viewport={{ once: true }} transition={{ delay: i * 0.1 }}>
                <stat.icon className="w-8 h-8 mx-auto text-brand mb-4" />
                <h4 className="text-4xl font-black mb-2">{stat.value}</h4>
                <p className="text-sm text-muted-foreground font-medium uppercase tracking-widest">{t(`client.b2b.stat_${i}`, { defaultValue: stat.label })}</p>
              </m.div>
            ))}
          </div>
        </div>
      </section>

    </div>
  );
}

export default B2BContent;
