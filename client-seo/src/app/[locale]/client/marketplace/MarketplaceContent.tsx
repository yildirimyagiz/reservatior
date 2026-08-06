"use client";

import { useTranslation } from "react-i18next";
import { m, useScroll, useTransform } from "framer-motion";
import { Button } from "@/components/ui/button";
import Image from "next/image";
import { Briefcase, Camera, Paintbrush, ShieldCheck, Heart, Star, Wrench } from "lucide-react";

export function MarketplaceContent() {
  const { t } = useTranslation();
  const { scrollY } = useScroll();
  const opacity = useTransform(scrollY, [0, 500], [1, 0]);

  return (
    <div className="min-h-screen bg-[#030308] text-muted-foreground selection:bg-brand/100 selection:text-white">
      
      {/* ══════ HERO SECTION ══════ */}
      <section className="relative h-[80svh] w-full overflow-hidden flex items-center justify-center">
        <m.div style={{ opacity }} className="absolute inset-0">
          <Image 
            src="https://images.unsplash.com/photo-1581578731548-c64695cc6952?q=80&w=2670&auto=format&fit=crop" 
            alt="Service Marketplace" 
            fill 
            sizes="100vw"
            className="object-cover opacity-35 transform scale-105" 
            priority
          />
          <div className="absolute inset-0 bg-gradient-to-t from-[#030308] via-transparent to-transparent" />
          <div className="absolute inset-0 bg-gradient-to-r from-[#030308]/90 via-transparent to-transparent" />
        </m.div>

        <div className="relative z-10 container mx-auto px-6 pt-24 flex flex-col items-start max-w-7xl">
          <m.div initial={{ opacity: 0, y: 30 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.8 }} className="max-w-3xl">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-brand/20 border border-brand/30 text-brand mb-6 backdrop-blur-md">
              <Briefcase className="w-4 h-4" />
              <span className="text-xs font-bold tracking-widest uppercase">{t("client.marketplace.badge", { defaultValue: "Service Marketplace" })}</span>
            </div>
            <h1 className="text-5xl md:text-7xl font-black tracking-tight mb-6 leading-tight">
              {t("client.marketplace.title", { defaultValue: "Professional Services, Instantly Hired." })}
            </h1>
            <p className="text-lg md:text-2xl text-muted-foreground mb-10 max-w-2xl font-light">
              {t("client.marketplace.subtitle", { defaultValue: "Connect with vetted property managers, professional cleaners, maintenance experts, and listing photographers." })}
            </p>
            <div className="flex flex-wrap gap-4">
              <Button size="lg" className="rounded-full px-8 h-14 bg-card text-black hover:bg-muted font-bold transition-all hover:scale-105">
                {t("client.marketplace.cta_primary", { defaultValue: "Hire Professionals" })}
              </Button>
              <Button size="lg" variant="outline" className="rounded-full px-8 h-14 border-white/20 hover:bg-white/10 font-bold backdrop-blur-md">
                {t("client.marketplace.cta_secondary", { defaultValue: "Become a Vendor" })}
              </Button>
            </div>
          </m.div>
        </div>
      </section>

      {/* ══════ VENDORS METRICS GRID ══════ */}
      <section className="py-24 relative z-20 -mt-20">
        <div className="container mx-auto px-6 max-w-7xl">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            
            {/* Cleaning */}
            <m.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.1 }}
              className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div>
                <Paintbrush className="w-10 h-10 text-brand mb-6" />
                <h3 className="text-2xl font-bold mb-2">{t("client.marketplace.panel1_title", { defaultValue: "Turnover Cleaning" })}</h3>
                <p className="text-muted-foreground text-sm">
                  {t("client.marketplace.panel1_desc", { defaultValue: "Expert hospitality-grade cleaners specializing in short-term rental checkout turnarounds." })}
                </p>
              </div>
            </m.div>

            {/* Maintenance */}
            <m.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.2 }}
              className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div>
                <Wrench className="w-10 h-10 text-brand mb-6" />
                <h3 className="text-2xl font-bold mb-2">{t("client.marketplace.panel2_title", { defaultValue: "Property Maintenance" })}</h3>
                <p className="text-muted-foreground text-sm">
                  {t("client.marketplace.panel2_desc", { defaultValue: "On-call plumbers, electricians, locksmiths, and painters available for emergency responses." })}
                </p>
              </div>
            </m.div>

            {/* Media Photography */}
            <m.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.3 }}
              className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div>
                <Camera className="w-10 h-10 text-brand mb-6" />
                <h3 className="text-2xl font-bold mb-2">{t("client.marketplace.panel3_title", { defaultValue: "Photography & 3D" })}</h3>
                <p className="text-muted-foreground text-sm">
                  {t("client.marketplace.panel3_desc", { defaultValue: "Professional real estate photographers, drone pilots, and Matterport 3D scanner operators." })}
                </p>
              </div>
            </m.div>

            {/* Trust and Safety Bento */}
            <m.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.4 }}
              className="md:col-span-3 bg-gradient-to-br from-brand/30 to-slate-950/40 border border-brand/20 rounded-[2.5rem] p-8 md:p-12 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div className="absolute top-0 right-0 w-96 h-96 bg-brand/10 rounded-full blur-[120px]" />
              <div className="relative z-10">
                <ShieldCheck className="w-12 h-12 text-brand mb-6" />
                <h3 className="text-3xl font-black mb-4">{t("client.marketplace.panel4_title", { defaultValue: "Vetted & Insured Vendors" })}</h3>
                <p className="text-muted-foreground text-lg max-w-2xl leading-relaxed">
                  {t("client.marketplace.panel4_desc", { defaultValue: "Every service professional listed on our platform is background checked, identity verified, and fully insured up to $1M in property liability." })}
                </p>
              </div>
            </m.div>

          </div>
        </div>
      </section>

    </div>
  );
}

export default MarketplaceContent;
