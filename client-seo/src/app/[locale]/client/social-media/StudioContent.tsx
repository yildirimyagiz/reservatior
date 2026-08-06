"use client";

import { useTranslation } from "react-i18next";
import { m, useScroll, useTransform } from "framer-motion";
import { Button } from "@/components/ui/button";
import Image from "next/image";
import { Sparkles, BarChart3, Users, Share2, Video, Heart, MessageSquare, Play, Send } from "lucide-react";

export function StudioContent() {
  const { t } = useTranslation();
  const { scrollY } = useScroll();
  const opacity = useTransform(scrollY, [0, 500], [1, 0]);

  return (
    <div className="min-h-screen bg-[#020205] text-muted-foreground selection:bg-brand/100 selection:text-white">
      
      {/* ══════ HERO SECTION ══════ */}
      <section className="relative h-[80svh] w-full overflow-hidden flex items-center justify-center">
        <m.div style={{ opacity }} className="absolute inset-0">
          <Image 
            src="https://images.unsplash.com/photo-1611162617213-7d7a39e9b1d7?q=80&w=2574&auto=format&fit=crop" 
            alt="Social Media Studio" 
            fill 
            sizes="100vw"
            className="object-cover opacity-40 transform scale-105" 
            priority
          />
          <div className="absolute inset-0 bg-gradient-to-t from-[#020205] via-transparent to-transparent" />
          <div className="absolute inset-0 bg-gradient-to-r from-[#020205]/90 via-transparent to-transparent" />
        </m.div>

        <div className="relative z-10 container mx-auto px-6 pt-24 flex flex-col items-start max-w-7xl">
          <m.div initial={{ opacity: 0, y: 30 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.8 }} className="max-w-3xl">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-brand/20 border border-brand/30 text-brand mb-6 backdrop-blur-md">
              <Sparkles className="w-4 h-4" />
              <span className="text-xs font-bold tracking-widest uppercase">{t("client.social.badge", { defaultValue: "Social Media Studio" })}</span>
            </div>
            <h1 className="text-5xl md:text-7xl font-black tracking-tight mb-6 leading-tight">
              {t("client.social.title", { defaultValue: "Automate Content. Boost Engagement." })}
            </h1>
            <p className="text-lg md:text-2xl text-muted-foreground mb-10 max-w-2xl font-light">
              {t("client.social.subtitle", { defaultValue: "Generate promotional videos, track active campaigns, and schedule automated posts directly to Instagram, TikTok, and YouTube Shorts." })}
            </p>
            <div className="flex flex-wrap gap-4">
              <Button size="lg" className="rounded-full px-8 h-14 bg-card text-black hover:bg-muted font-bold transition-all hover:scale-105">
                {t("client.social.cta_primary", { defaultValue: "Start Free Trial" })}
              </Button>
              <Button size="lg" variant="outline" className="rounded-full px-8 h-14 border-white/20 hover:bg-white/10 font-bold backdrop-blur-md">
                {t("client.social.cta_secondary", { defaultValue: "Watch Demo" })}
              </Button>
            </div>
          </m.div>
        </div>
      </section>

      {/* ══════ CONTROL PANEL BENTO GRID ══════ */}
      <section className="py-24 relative z-20 -mt-20">
        <div className="container mx-auto px-6 max-w-7xl">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            
            {/* AI Generator Panel */}
            <m.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.1 }}
              className="md:col-span-2 bg-white/5 border border-white/10 rounded-[2.5rem] p-8 md:p-12 backdrop-blur-xl relative overflow-hidden group">
              <div className="absolute top-0 right-0 w-80 h-80 bg-brand/10 rounded-full blur-[100px] group-hover:bg-brand/20 transition-all duration-700" />
              <Video className="w-12 h-12 text-brand mb-6 animate-pulse" />
              <h3 className="text-3xl font-black mb-4">{t("client.social.panel1_title", { defaultValue: "AI Shorts Creator" })}</h3>
              <p className="text-muted-foreground text-lg max-w-md mb-8">
                {t("client.social.panel1_desc", { defaultValue: "Convert property listings into engaging vertical videos with voiceovers, subtitles, and music with one click." })}
              </p>
              <div className="flex gap-3">
                <Button className="rounded-full bg-brand hover:bg-brand text-white font-bold h-12 px-6">
                  <Play className="w-4 h-4 mr-2" /> {t("client.social.generate", { defaultValue: "Generate Video" })}
                </Button>
              </div>
            </m.div>

            {/* Campaign Analytics */}
            <m.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.2 }}
              className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div>
                <BarChart3 className="w-10 h-10 text-pink-400 mb-6" />
                <h3 className="text-2xl font-bold mb-2">{t("client.social.panel2_title", { defaultValue: "Active Campaigns" })}</h3>
                <p className="text-muted-foreground text-sm">
                  {t("client.social.panel2_desc", { defaultValue: "Real-time statistics of click-through rates and guest conversion." })}
                </p>
              </div>
              <div className="mt-8 pt-6 border-t border-white/10 flex justify-between items-center">
                <div className="flex items-center gap-2"><Heart className="w-4 h-4 text-pink-500" /> <span className="font-bold">{t("social_media.studiocontent.auto_ext_1")}</span></div>
                <div className="flex items-center gap-2"><MessageSquare className="w-4 h-4 text-brand" /> <span className="font-bold">890</span></div>
                <div className="flex items-center gap-2"><Share2 className="w-4 h-4 text-brand" /> <span className="font-bold">{t("social_media.studiocontent.auto_ext_2")}</span></div>
              </div>
            </m.div>

            {/* Automated Scheduling */}
            <m.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.3 }}
              className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8 backdrop-blur-xl relative overflow-hidden group">
              <Send className="w-10 h-10 text-brand mb-6" />
              <h3 className="text-2xl font-bold mb-4">{t("client.social.panel3_title", { defaultValue: "Autopilot Posting" })}</h3>
              <p className="text-muted-foreground text-sm">
                {t("client.social.panel3_desc", { defaultValue: "Schedule posts automatically based on maximum online activity algorithms." })}
              </p>
            </m.div>

            {/* Reach stats */}
            <m.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.4 }}
              className="md:col-span-2 bg-gradient-to-br from-brand/40 to-slate-950/40 border border-brand/20 rounded-[2.5rem] p-8 md:p-12 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div>
                <Users className="w-12 h-12 text-brand mb-6" />
                <h3 className="text-3xl font-black mb-4">{t("client.social.panel4_title", { defaultValue: "Reach New Guests" })}</h3>
                <p className="text-muted-foreground text-lg max-w-md">
                  {t("client.social.panel4_desc", { defaultValue: "Leverage viral real estate algorithms to find high-value clients across visual platforms organically." })}
                </p>
              </div>
            </m.div>

          </div>
        </div>
      </section>

    </div>
  );
}

export default StudioContent;
