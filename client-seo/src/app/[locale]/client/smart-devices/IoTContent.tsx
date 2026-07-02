"use client";

import { useTranslation } from "react-i18next";
import { motion, useScroll, useTransform } from "framer-motion";
import { Button } from "@/components/ui/button";
import Image from "next/image";
import { Monitor, Key, Lock, ShieldAlert, Cpu, Power } from "lucide-react";

export function IoTContent() {
  const { t } = useTranslation();
  const { scrollY } = useScroll();
  const opacity = useTransform(scrollY, [0, 500], [1, 0]);

  return (
    <div className="min-h-screen bg-[#02040a] text-slate-50 selection:bg-blue-500 selection:text-white">
      
      {/* ══════ HERO SECTION ══════ */}
      <section className="relative h-[80svh] w-full overflow-hidden flex items-center justify-center">
        <motion.div style={{ opacity }} className="absolute inset-0">
          <Image 
            src="https://images.unsplash.com/photo-1558002038-1055907df827?q=80&w=2670&auto=format&fit=crop" 
            alt="IoT Smart Devices" 
            fill 
            className="object-cover opacity-35 transform scale-105" 
            priority
          />
          <div className="absolute inset-0 bg-gradient-to-t from-[#02040a] via-transparent to-transparent" />
          <div className="absolute inset-0 bg-gradient-to-r from-[#02040a]/90 via-transparent to-transparent" />
        </motion.div>

        <div className="relative z-10 container mx-auto px-6 pt-24 flex flex-col items-start max-w-7xl">
          <motion.div initial={{ opacity: 0, y: 30 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.8 }} className="max-w-3xl">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-blue-500/20 border border-blue-500/30 text-blue-300 mb-6 backdrop-blur-md">
              <Monitor className="w-4 h-4" />
              <span className="text-xs font-bold tracking-widest uppercase">{t("client.iot.badge", { defaultValue: "Smart Devices" })}</span>
            </div>
            <h1 className="text-5xl md:text-7xl font-black tracking-tight mb-6 leading-tight">
              {t("client.iot.title", { defaultValue: "Property Automation, Perfected." })}
            </h1>
            <p className="text-lg md:text-2xl text-slate-300 mb-10 max-w-2xl font-light">
              {t("client.iot.subtitle", { defaultValue: "Manage smart locks, track thermostat schedules, and monitor property decibel/smoke sensors remotely." })}
            </p>
            <div className="flex flex-wrap gap-4">
              <Button size="lg" className="rounded-full px-8 h-14 bg-white text-black hover:bg-slate-200 font-bold transition-all hover:scale-105">
                {t("client.iot.cta_primary", { defaultValue: "Connect Device" })}
              </Button>
              <Button size="lg" variant="outline" className="rounded-full px-8 h-14 border-white/20 hover:bg-white/10 font-bold backdrop-blur-md">
                {t("client.iot.cta_secondary", { defaultValue: "Sensor History" })}
              </Button>
            </div>
          </motion.div>
        </div>
      </section>

      {/* ══════ DEVICE PANELS GRID ══════ */}
      <section className="py-24 relative z-20 -mt-20">
        <div className="container mx-auto px-6 max-w-7xl">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            
            {/* Smart Lock Status */}
            <motion.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.1 }}
              className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div>
                <Lock className="w-10 h-10 text-blue-400 mb-6" />
                <h3 className="text-2xl font-bold mb-2">{t("client.iot.panel1_title", { defaultValue: "Smart Lock" })}</h3>
                <p className="text-slate-400 text-sm">
                  {t("client.iot.panel1_desc", { defaultValue: "Main entrance door lock status. Lock or unlock remotely or generate temporary pin codes for guests." })}
                </p>
              </div>
              <div className="mt-8 pt-6 border-t border-white/10 flex justify-between items-center">
                <span className="text-sm text-slate-400 uppercase font-black">{t("client.iot.status", { defaultValue: "Status" })}</span>
                <span className="px-3 py-1 rounded-full bg-emerald-500/20 text-emerald-400 border border-emerald-500/30 text-xs font-bold">{t("client.iot.locked", { defaultValue: "Locked" })}</span>
              </div>
            </motion.div>

            {/* Climate Control */}
            <motion.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.2 }}
              className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div>
                <Cpu className="w-10 h-10 text-blue-400 mb-6" />
                <h3 className="text-2xl font-bold mb-2">{t("client.iot.panel2_title", { defaultValue: "Climate Control" })}</h3>
                <p className="text-slate-400 text-sm">
                  {t("client.iot.panel2_desc", { defaultValue: "Thermostat target temperatures. Reduce power consumption when properties are vacant." })}
                </p>
              </div>
              <div className="mt-8 pt-6 border-t border-white/10 flex justify-between items-center">
                <span className="text-sm text-slate-400 uppercase font-black">{t("client.iot.temp", { defaultValue: "Temp" })}</span>
                <span className="font-black text-2xl">21.5°C</span>
              </div>
            </motion.div>

            {/* Decibel Monitoring */}
            <motion.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.3 }}
              className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div>
                <ShieldAlert className="w-10 h-10 text-yellow-400 mb-6" />
                <h3 className="text-2xl font-bold mb-2">{t("client.iot.panel3_title", { defaultValue: "Decibel Sensor" })}</h3>
                <p className="text-slate-400 text-sm">
                  {t("client.iot.panel3_desc", { defaultValue: "Monitor property noise levels dynamically without invading guest privacy to prevent loud parties." })}
                </p>
              </div>
              <div className="mt-8 pt-6 border-t border-white/10 flex justify-between items-center">
                <span className="text-sm text-slate-400 uppercase font-black">{t("client.iot.noise", { defaultValue: "Noise Level" })}</span>
                <span className="px-3 py-1 rounded-full bg-blue-500/20 text-blue-400 border border-blue-500/30 text-xs font-bold">{t("client.iot.normal", { defaultValue: "Normal (34dB)" })}</span>
              </div>
            </motion.div>

            {/* Hardware list Bento */}
            <motion.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: 0.4 }}
              className="md:col-span-3 bg-gradient-to-br from-blue-950/30 to-slate-950/40 border border-blue-500/20 rounded-[2.5rem] p-8 md:p-12 backdrop-blur-xl relative overflow-hidden group flex flex-col justify-between">
              <div className="absolute top-0 right-0 w-96 h-96 bg-blue-500/10 rounded-full blur-[120px]" />
              <div className="relative z-10">
                <Power className="w-12 h-12 text-blue-400 mb-6" />
                <h3 className="text-3xl font-black mb-4">{t("client.iot.panel4_title", { defaultValue: "Integration with Major Hubs" })}</h3>
                <p className="text-slate-300 text-lg max-w-2xl leading-relaxed">
                  {t("client.iot.panel4_desc", { defaultValue: "We support direct native integrations with Yale, August, Nest, Ecobee, Ring, and many other smart device brands for reliable property automation." })}
                </p>
              </div>
            </motion.div>

          </div>
        </div>
      </section>

    </div>
  );
}

export default IoTContent;
