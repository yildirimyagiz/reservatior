"use client";

import { useTranslation } from "react-i18next";
import { m, useScroll, useTransform } from "framer-motion";
import { Button } from "@/components/ui/button";
import Image from "next/image";
import { Users, FileText, CheckSquare, Settings, Bell, Shield } from "lucide-react";

export function HoaContent() {
  const { t } = useTranslation();
  const { scrollY } = useScroll();
  const opacity = useTransform(scrollY, [0, 500], [1, 0]);

  return (
    <div className="min-h-screen bg-[#030712] text-slate-50 selection:bg-teal-500 selection:text-white">
      
      {/* ══════ HERO SECTION ══════ */}
      <section className="relative h-[80svh] w-full overflow-hidden flex items-center justify-center">
        <m.div style={{ opacity }} className="absolute inset-0">
          <Image 
            src="https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?q=80&w=2535&auto=format&fit=crop" 
            alt="HOA" 
            fill 
            sizes="100vw"
            className="object-cover opacity-35 transform scale-105" 
            priority
          />
          <div className="absolute inset-0 bg-gradient-to-t from-[#030712] via-transparent to-transparent" />
          <div className="absolute inset-0 bg-gradient-to-r from-[#030712]/90 via-transparent to-transparent" />
        </m.div>

        <div className="relative z-10 container mx-auto px-6 pt-24 flex flex-col items-start max-w-7xl">
          <m.div initial={{ opacity: 0, y: 30 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.8 }} className="max-w-3xl">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-teal-500/20 border border-teal-500/30 text-teal-300 mb-6 backdrop-blur-md">
              <Users className="w-4 h-4" />
              <span className="text-xs font-bold tracking-widest uppercase">{t("client.hoa.badge", { defaultValue: "HOA Dashboard" })}</span>
            </div>
            <h1 className="text-5xl md:text-7xl font-black tracking-tight mb-6 leading-tight">
              {t("client.hoa.title", { defaultValue: "Streamlined Community Operations." })}
            </h1>
            <p className="text-lg md:text-2xl text-slate-300 mb-10 max-w-2xl font-light">
              {t("client.hoa.subtitle", { defaultValue: "Automate dues payment, resolve community violations, and publish legal declarations to property owners instantly." })}
            </p>
            <div className="flex flex-wrap gap-4">
              <Button size="lg" className="rounded-full px-8 h-14 bg-white text-black hover:bg-slate-200 font-bold transition-all hover:scale-105">
                {t("client.hoa.cta_primary", { defaultValue: "Manage Community" })}
              </Button>
              <Button size="lg" variant="outline" className="rounded-full px-8 h-14 border-white/20 hover:bg-white/10 font-bold backdrop-blur-md">
                {t("client.hoa.cta_secondary", { defaultValue: "Declarations" })}
              </Button>
            </div>
          </m.div>
        </div>
      </section>

      {/* ══════ HOA PANELS GRID ══════ */}
      <section className="py-24 relative z-20 -mt-20">
        <div className="container mx-auto px-6 max-w-7xl">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            
            {/* Outstanding Balances */}
            <m.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.1 }}
              className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div>
                <FileText className="w-10 h-10 text-teal-400 mb-6" />
                <h3 className="text-2xl font-bold mb-2">{t("client.hoa.panel1_title", { defaultValue: "Outstanding Dues" })}</h3>
                <p className="text-slate-400 text-sm">
                  {t("client.hoa.panel1_desc", { defaultValue: "Track and collect monthly maintenance dues automatically from unit owners." })}
                </p>
              </div>
              <h4 className="text-4xl font-black mt-8 text-teal-400">$0.00</h4>
            </m.div>

            {/* Active Violations */}
            <m.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.2 }}
              className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div>
                <CheckSquare className="w-10 h-10 text-red-400 mb-6" />
                <h3 className="text-2xl font-bold mb-2">{t("client.hoa.panel2_title", { defaultValue: "Pending Violations" })}</h3>
                <p className="text-slate-400 text-sm">
                  {t("client.hoa.panel2_desc", { defaultValue: "Report and track unresolved neighborhood violations or disputes." })}
                </p>
              </div>
              <h4 className="text-4xl font-black mt-8 text-red-400">0</h4>
            </m.div>

            {/* Announcements */}
            <m.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.3 }}
              className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div>
                <Bell className="w-10 h-10 text-yellow-400 mb-6" />
                <h3 className="text-2xl font-bold mb-2">{t("client.hoa.panel3_title", { defaultValue: "Community Broadcaster" })}</h3>
                <p className="text-slate-400 text-sm">
                  {t("client.hoa.panel3_desc", { defaultValue: "Notify all residents about upcoming maintenance work or events." })}
                </p>
              </div>
              <h4 className="text-xl font-bold mt-8 text-slate-300">{t("client.hoa.no_notifs", { defaultValue: "No active announcements" })}</h4>
            </m.div>

            {/* General HOA Info Bento */}
            <m.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.4 }}
              className="md:col-span-3 bg-gradient-to-br from-teal-950/40 to-slate-950/40 border border-teal-500/20 rounded-[2.5rem] p-8 md:p-12 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div className="absolute top-0 right-0 w-96 h-96 bg-teal-500/10 rounded-full blur-[120px]" />
              <div className="relative z-10">
                <Shield className="w-12 h-12 text-teal-400 mb-6" />
                <h3 className="text-3xl font-black mb-4">{t("client.hoa.panel4_title", { defaultValue: "HOA Security & Trust" })}</h3>
                <p className="text-slate-300 text-lg max-w-2xl leading-relaxed">
                  {t("client.hoa.panel4_desc", { defaultValue: "All community documents are securely encrypted. Board members can manage roles, approve budgets, and sign off legal files within our secure workspace." })}
                </p>
              </div>
            </m.div>

          </div>
        </div>
      </section>

    </div>
  );
}

export default HoaContent;
