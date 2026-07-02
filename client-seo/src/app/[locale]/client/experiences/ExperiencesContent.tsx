"use client";

import { useTranslation } from "react-i18next";
import { motion, useScroll, useTransform } from "framer-motion";
import { Button } from "@/components/ui/button";
import Image from "next/image";
import { Compass, Map, Camera, Utensils, Award, Heart } from "lucide-react";

export function ExperiencesContent() {
  const { t } = useTranslation();
  const { scrollY } = useScroll();
  const opacity = useTransform(scrollY, [0, 500], [1, 0]);

  return (
    <div className="min-h-screen bg-[#020502] text-slate-50 selection:bg-emerald-500 selection:text-white">
      
      {/* ══════ HERO SECTION ══════ */}
      <section className="relative h-[80svh] w-full overflow-hidden flex items-center justify-center">
        <motion.div style={{ opacity }} className="absolute inset-0">
          <Image 
            src="https://images.unsplash.com/photo-1516483638261-f4dbaf036963?q=80&w=2574&auto=format&fit=crop" 
            alt="Experiences" 
            fill 
            className="object-cover opacity-35 transform scale-105" 
            priority
          />
          <div className="absolute inset-0 bg-gradient-to-t from-[#020502] via-transparent to-transparent" />
          <div className="absolute inset-0 bg-gradient-to-r from-[#020502]/90 via-transparent to-transparent" />
        </motion.div>

        <div className="relative z-10 container mx-auto px-6 pt-24 flex flex-col items-start max-w-7xl">
          <motion.div initial={{ opacity: 0, y: 30 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.8 }} className="max-w-3xl">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-emerald-500/20 border border-emerald-500/30 text-emerald-300 mb-6 backdrop-blur-md">
              <Compass className="w-4 h-4" />
              <span className="text-xs font-bold tracking-widest uppercase">{t("client.experiences.badge", { defaultValue: "Curated Experiences" })}</span>
            </div>
            <h1 className="text-5xl md:text-7xl font-black tracking-tight mb-6 leading-tight">
              {t("client.experiences.title", { defaultValue: "Live Unforgettable Moments." })}
            </h1>
            <p className="text-lg md:text-2xl text-slate-300 mb-10 max-w-2xl font-light">
              {t("client.experiences.subtitle", { defaultValue: "Unique local tours, culinary masterclasses, outdoor expeditions, and exclusive activities designed by local experts." })}
            </p>
            <div className="flex flex-wrap gap-4">
              <Button size="lg" className="rounded-full px-8 h-14 bg-white text-black hover:bg-slate-200 font-bold transition-all hover:scale-105">
                {t("client.experiences.cta_primary", { defaultValue: "Book Experience" })}
              </Button>
              <Button size="lg" variant="outline" className="rounded-full px-8 h-14 border-white/20 hover:bg-white/10 font-bold backdrop-blur-md">
                {t("client.experiences.cta_secondary", { defaultValue: "List Your Tour" })}
              </Button>
            </div>
          </motion.div>
        </div>
      </section>

      {/* ══════ EXPERIENCES GRID ══════ */}
      <section className="py-24 relative z-20 -mt-20">
        <div className="container mx-auto px-6 max-w-7xl">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            
            {/* Culinary Tours */}
            <motion.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.1 }}
              className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div>
                <Utensils className="w-10 h-10 text-emerald-400 mb-6" />
                <h3 className="text-2xl font-bold mb-2">{t("client.experiences.panel1_title", { defaultValue: "Gastronomy" })}</h3>
                <p className="text-slate-400 text-sm">
                  {t("client.experiences.panel1_desc", { defaultValue: "Wine tastings, traditional cooking masterclasses, and hidden local restaurant tours." })}
                </p>
              </div>
            </motion.div>

            {/* Outdoor Exploration */}
            <motion.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.2 }}
              className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div>
                <Map className="w-10 h-10 text-emerald-400 mb-6" />
                <h3 className="text-2xl font-bold mb-2">{t("client.experiences.panel2_title", { defaultValue: "Exploration" })}</h3>
                <p className="text-slate-400 text-sm">
                  {t("client.experiences.panel2_desc", { defaultValue: "Helicopter rides, private island cruises, hiking trips, and hot air balloon adventures." })}
                </p>
              </div>
            </motion.div>

            {/* Photography */}
            <motion.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.3 }}
              className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div>
                <Camera className="w-10 h-10 text-emerald-400 mb-6" />
                <h3 className="text-2xl font-bold mb-2">{t("client.experiences.panel3_title", { defaultValue: "Photography" })}</h3>
                <p className="text-slate-400 text-sm">
                  {t("client.experiences.panel3_desc", { defaultValue: "Personal professional photographer details to capture your memories in high quality." })}
                </p>
              </div>
            </motion.div>

            {/* Quality Standard Bento */}
            <motion.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.4 }}
              className="md:col-span-3 bg-gradient-to-br from-emerald-950/30 to-slate-950/40 border border-emerald-500/20 rounded-[2.5rem] p-8 md:p-12 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div className="absolute top-0 right-0 w-96 h-96 bg-emerald-500/10 rounded-full blur-[120px]" />
              <div className="relative z-10">
                <Award className="w-12 h-12 text-emerald-400 mb-6" />
                <h3 className="text-3xl font-black mb-4">{t("client.experiences.panel4_title", { defaultValue: "Tier-1 Quality Assurance" })}</h3>
                <p className="text-slate-300 text-lg max-w-2xl leading-relaxed">
                  {t("client.experiences.panel4_desc", { defaultValue: "All operators are fully vetted, background checked, and liability insured to ensure your tour experience is as safe as it is thrilling." })}
                </p>
              </div>
            </motion.div>

          </div>
        </div>
      </section>

    </div>
  );
}

export default ExperiencesContent;
