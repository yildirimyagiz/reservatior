"use client";

import { useTranslation } from "react-i18next";
import { m, useScroll, useTransform } from "framer-motion";
import { Button } from "@/components/ui/button";
import Image from "next/image";
import { TrendingUp, DollarSign, Percent, PieChart, ShieldCheck, MapPin } from "lucide-react";

export function PropertiesContent() {
  const { t } = useTranslation();
  const { scrollY } = useScroll();
  const opacity = useTransform(scrollY, [0, 500], [1, 0]);

  return (
    <div className="min-h-screen bg-[#020617] text-muted-foreground selection:bg-brand/100 selection:text-white">
      
      {/* ══════ HERO SECTION ══════ */}
      <section className="relative h-[80svh] w-full overflow-hidden flex items-center justify-center">
        <m.div style={{ opacity }} className="absolute inset-0">
          <Image 
            src="https://images.unsplash.com/photo-1460925895917-afdab827c52f?q=80&w=2426&auto=format&fit=crop" 
            alt="Investors" 
            fill 
            sizes="100vw"
            className="object-cover opacity-30 transform scale-105" 
            priority
          />
          <div className="absolute inset-0 bg-gradient-to-t from-[#020617] via-transparent to-transparent" />
          <div className="absolute inset-0 bg-gradient-to-r from-[#020617]/90 via-transparent to-transparent" />
        </m.div>

        <div className="relative z-10 container mx-auto px-6 pt-24 flex flex-col items-start max-w-7xl">
          <m.div initial={{ opacity: 0, y: 30 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.8 }} className="max-w-3xl">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-brand/20 border border-brand/30 text-brand mb-6 backdrop-blur-md">
              <PieChart className="w-4 h-4" />
              <span className="text-xs font-bold tracking-widest uppercase">{t("client.investor.badge", { defaultValue: "Investor Portal" })}</span>
            </div>
            <h1 className="text-5xl md:text-7xl font-black tracking-tight mb-6 leading-tight">
              {t("client.investor.title", { defaultValue: "Fractional Real Estate & High Yield." })}
            </h1>
            <p className="text-lg md:text-2xl text-muted-foreground mb-10 max-w-2xl font-light">
              {t("client.investor.subtitle", { defaultValue: "Track your real estate portfolio, check monthly dividend payouts, and browse high-yield investment properties." })}
            </p>
            <div className="flex flex-wrap gap-4">
              <Button size="lg" className="rounded-full px-8 h-14 bg-card text-black hover:bg-muted font-bold transition-all hover:scale-105">
                {t("client.investor.cta_primary", { defaultValue: "View Listings" })}
              </Button>
              <Button size="lg" variant="outline" className="rounded-full px-8 h-14 border-white/20 hover:bg-white/10 font-bold backdrop-blur-md">
                {t("client.investor.cta_secondary", { defaultValue: "Download Report" })}
              </Button>
            </div>
          </m.div>
        </div>
      </section>

      {/* ══════ INVESTOR METRICS GRID ══════ */}
      <section className="py-24 relative z-20 -mt-20">
        <div className="container mx-auto px-6 max-w-7xl">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            
            {/* Net Asset Value */}
            <m.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.1 }}
              className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div>
                <DollarSign className="w-10 h-10 text-brand mb-6" />
                <h3 className="text-2xl font-bold mb-2">{t("client.investor.panel1_title", { defaultValue: "Net Asset Value" })}</h3>
                <p className="text-muted-foreground text-sm">
                  {t("client.investor.panel1_desc", { defaultValue: "Current total valuation of your fractional property shares." })}
                </p>
              </div>
              <h4 className="text-4xl font-black mt-8 text-brand">$0.00</h4>
            </m.div>

            {/* Dividend Yield */}
            <m.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.2 }}
              className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div>
                <Percent className="w-10 h-10 text-success mb-6" />
                <h3 className="text-2xl font-bold mb-2">{t("client.investor.panel2_title", { defaultValue: "Target Yield (CoC)" })}</h3>
                <p className="text-muted-foreground text-sm">
                  {t("client.investor.panel2_desc", { defaultValue: "Average Cash-on-Cash dividend return target across selected region." })}
                </p>
              </div>
              <h4 className="text-4xl font-black mt-8 text-success">8.4% - 12.1%</h4>
            </m.div>

            {/* Smart Diversification */}
            <m.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.3 }}
              className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div>
                <TrendingUp className="w-10 h-10 text-brand mb-6" />
                <h3 className="text-2xl font-bold mb-2">{t("client.investor.panel3_title", { defaultValue: "Appreciation" })}</h3>
                <p className="text-muted-foreground text-sm">
                  {t("client.investor.panel3_desc", { defaultValue: "Estimated annual equity growth based on machine learning market analysis." })}
                </p>
              </div>
              <h4 className="text-4xl font-black mt-8 text-brand">{t("investors.propertiescontent.auto_ext_1")}</h4>
            </m.div>

            {/* Featured Investment Bento Box */}
            <m.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.4 }}
              className="md:col-span-3 bg-gradient-to-br from-brand/40 to-slate-950/40 border border-brand/20 rounded-[2.5rem] p-8 md:p-12 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div className="absolute top-0 right-0 w-96 h-96 bg-brand/10 rounded-full blur-[120px]" />
              <div className="relative z-10">
                <ShieldCheck className="w-12 h-12 text-brand mb-6" />
                <h3 className="text-3xl font-black mb-4">{t("client.investor.panel4_title", { defaultValue: "Securitized Property Fractions" })}</h3>
                <p className="text-muted-foreground text-lg max-w-2xl leading-relaxed mb-6">
                  {t("client.investor.panel4_desc", { defaultValue: "All properties are fully managed, legal structures secured under LLCs, and audited by tier-1 compliance professionals to guarantee hassle-free yield." })}
                </p>
              </div>
            </m.div>

          </div>
        </div>
      </section>

    </div>
  );
}

export default PropertiesContent;
