"use client";

import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { ArrowLeft, FileText, Cpu, Shield, Globe } from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";

export function TermsContent() {
    const { t } = useTranslation();
  const router = useRouter();

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900 text-white">
      <div className="container mx-auto px-4 py-24 max-w-4xl">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="flex flex-col md:flex-row md:items-center justify-between gap-8 mb-20"
        >
          <div className="flex items-center gap-8">
            <Button
              variant="ghost"
              size="sm"
              onClick={() => router.back()}
              className="h-14 px-8 rounded-2xl bg-white/5 border border-white/5 hover:bg-white/10 text-gray-400 font-bold text-xs tracking-widest transition-all group"
            >
              <ArrowLeft className="w-4 h-4 mr-3 group-hover:-translate-x-1 transition-transform" />
              {t("terms.termscontent.auto_ext_1")}
                                      </Button>
            <div className="h-14 w-px bg-white/10 hidden md:block" />
            <div className="flex items-center gap-6">
              <div className="h-14 w-14 rounded-2xl bg-purple-500/10 border border-purple-500/20 flex items-center justify-center text-purple-500">
                <FileText className="w-6 h-6" />
              </div>
              <div className="space-y-1">
                <p className="text-xs font-bold text-blue-500 tracking-widest">{t("terms.termscontent.auto_ext_2")}</p>
                <h1 className="text-4xl font-bold tracking-tighter leading-none">{t("terms.termscontent.auto_ext_3")}</h1>
                <p className="text-xs font-bold text-gray-500 tracking-widest">{t("terms.termscontent.auto_ext_4")}</p>
              </div>
            </div>
          </div>
          <div className="flex items-center gap-4 px-6 py-3 rounded-full bg-white/5 border border-white/5 self-start md:self-center backdrop-blur-xl">
            <div className="w-2 h-2 rounded-full bg-purple-500 animate-pulse" />
            <span className="text-xs font-bold text-gray-400 tracking-widest">{t("terms.termscontent.auto_ext_5")}</span>
          </div>
        </motion.div>

        {/* Content */}
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.2 }}
        >
          <div className="p-16 rounded-[64px] bg-white/5 backdrop-blur-xl border border-purple-500/20 space-y-20">
            <section className="space-y-10">
              <h2 className="text-sm font-bold text-purple-400 tracking-widest flex items-center gap-4">
                <div className="h-px w-8 bg-purple-500/30" />
                <Shield className="w-5 h-5" /> {t("terms.termscontent.auto_ext_6")}
                                            </h2>
              <p className="text-sm font-bold text-gray-400 leading-loose">
                {t("terms.termscontent.auto_ext_7")}
                                            </p>
            </section>

            <section className="space-y-10">
              <h2 className="text-sm font-bold text-purple-400 tracking-widest flex items-center gap-4">
                <div className="h-px w-8 bg-purple-500/30" />
                <Globe className="w-5 h-5" /> {t("terms.termscontent.auto_ext_8")}
                                            </h2>
              <div className="grid md:grid-cols-2 gap-6">
                {[
                  "Property listing and management",
                  "Booking and reservation system",
                  "AI-powered property valuation",
                  "Automated workflow triggers",
                  "Financial tracking and reporting",
                  "Communication and messaging"
                ].map((item, i) => (
                  <div key={i} className="flex items-center gap-6 p-6 rounded-3xl bg-black/40 border border-white/5 hover:bg-white/5 transition-all group">
                    <div className="w-2 h-2 rounded-full bg-purple-500/30 group-hover:bg-purple-500 transition-all border border-purple-500/20" />
                    <span className="text-xs font-bold text-gray-400 group-hover:text-white tracking-widest transition-colors">{item}</span>
                  </div>
                ))}
              </div>
            </section>

            <section className="space-y-10">
              <h2 className="text-sm font-bold text-purple-400 tracking-widest flex items-center gap-4">
                <div className="h-px w-8 bg-purple-500/30" />
                <Cpu className="w-5 h-5" /> {t("terms.termscontent.auto_ext_9")}
                                            </h2>
              <ul className="space-y-6 px-4">
                {[
                  "Using the platform for illegal activities",
                  "Creating fake listings or fraudulent bookings",
                  "Violating property laws and regulations",
                  "Harassing other users or staff",
                  "Attempting to hack or disrupt the service",
                  "Sharing account credentials"
                ].map((text, i) => (
                  <li key={i} className="flex items-center gap-6 text-xs font-bold text-gray-500 tracking-widest group">
                    <span className="text-purple-500/30 group-hover:text-purple-500 transition-colors line-through">{t("terms.termscontent.auto_ext_10")}{i + 1}</span>
                    <span className="group-hover:text-gray-300 transition-colors">{text}</span>
                  </li>
                ))}
              </ul>
            </section>

            <div className="p-10 rounded-[48px] bg-purple-500/5 border border-purple-500/10 space-y-6">
              <h3 className="text-xs font-bold text-white tracking-widest">{t("terms.termscontent.auto_ext_11")}</h3>
              <p className="text-xs font-bold text-gray-500 leading-loose tracking-widest">
                {t("terms.termscontent.auto_ext_12")}
                                            </p>
            </div>

            <div className="pt-20 border-t border-white/5 flex flex-col md:flex-row justify-between items-center gap-12">
              <div className="space-y-2 text-center md:text-left group cursor-pointer">
                <p className="text-xs font-bold text-white opacity-60 group-hover:opacity-100 transition-opacity">{t("terms.termscontent.auto_ext_13")}</p>
                <p className="text-xl font-bold text-purple-500 tracking-widest">{t("terms.termscontent.auto_ext_14")}</p>
              </div>
              <div className="flex items-center gap-10 opacity-10 group-hover:opacity-30 transition-opacity">
                <FileText className="w-10 h-10" />
                <Cpu className="w-10 h-10" />
                <Globe className="w-10 h-10" />
              </div>
            </div>
          </div>
        </motion.div>
      </div>
    </div>
  );
}
