"use client";

import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { ArrowLeft, Shield, Disc, Activity } from "lucide-react";
import { m } from "framer-motion";
import { useTranslation } from "react-i18next";

export function PrivacyContent() {
    const { t } = useTranslation();
  const router = useRouter();

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900 text-white">
      <div className="container mx-auto px-4 py-24 max-w-4xl">
        {/* Header */}
        <m.div
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
              {t("privacy.privacycontent.auto_ext_1")}
                                      </Button>
            <div className="h-14 w-px bg-white/10 hidden md:block" />
            <div className="flex items-center gap-6">
              <div className="h-14 w-14 rounded-2xl bg-blue-500/10 border border-blue-500/20 flex items-center justify-center text-blue-500">
                <Shield className="w-6 h-6" />
              </div>
              <div className="space-y-1">
                <h1 className="text-4xl font-bold tracking-tighter leading-none">{t("privacy.privacycontent.auto_ext_2")}</h1>
                <p className="text-xs font-bold text-blue-500 tracking-widest">{t("privacy.privacycontent.auto_ext_3")}</p>
                <p className="text-xs font-bold text-gray-500 tracking-widest">{t("privacy.privacycontent.auto_ext_4")}</p>
              </div>
            </div>
          </div>
          <div className="flex items-center gap-4 px-6 py-3 rounded-full bg-white/5 border border-white/5 self-start md:self-center backdrop-blur-xl">
            <div className="w-2 h-2 rounded-full bg-emerald-500 animate-pulse" />
            <span className="text-xs font-bold text-gray-400 tracking-widest">{t("privacy.privacycontent.auto_ext_5")}</span>
          </div>
        </m.div>

        {/* Content */}
        <m.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.2 }}
        >
          <div className="p-16 rounded-[64px] bg-white/5 backdrop-blur-xl border border-purple-500/20 space-y-20">
            <section className="space-y-10">
              <h2 className="text-sm font-bold text-blue-400 tracking-widest flex items-center gap-4">
                <div className="h-px w-8 bg-blue-500/30" />
                <Disc className="w-5 h-5" /> {t("privacy.privacycontent.auto_ext_6")}
                                            </h2>
              <div className="grid md:grid-cols-2 gap-6">
                {[
                  { label: "Personal Information", val: "Name, email, phone, address" },
                  { label: "Property Data", val: "Property details, images, documents" },
                  { label: "Usage Analytics", val: "Page views, clicks, session data" },
                  { label: "Communication", val: "Messages, support tickets, feedback" }
                ].map((item, i) => (
                  <div key={i} className="p-8 rounded-[32px] bg-black/40 border border-white/5 hover:bg-white/5 transition-all hover:border-blue-500/20 group">
                    <p className="text-xs font-bold text-white mb-3 group-hover:text-blue-400 transition-colors">{item.label}</p>
                    <p className="text-sm text-gray-500 font-bold leading-relaxed">{item.val}</p>
                  </div>
                ))}
              </div>
            </section>

            <section className="space-y-10">
              <h2 className="text-sm font-bold text-blue-400 tracking-widest flex items-center gap-4">
                <div className="h-px w-8 bg-blue-500/30" />
                <Activity className="w-5 h-5" /> {t("privacy.privacycontent.auto_ext_7")}
                                            </h2>
              <ul className="grid md:grid-cols-2 gap-x-16 gap-y-6">
                {[
                  "Provide and improve our services",
                  "Process transactions and bookings",
                  "Send notifications and updates",
                  "Analyze usage patterns",
                  "Ensure security and prevent fraud",
                  "Comply with legal obligations"
                ].map((text, i) => (
                  <li key={i} className="flex items-center gap-5 text-xs font-bold text-gray-400 tracking-widest group">
                    <div className="h-2 w-2 rounded-full bg-blue-500/30 group-hover:bg-blue-500 transition-all border border-blue-500/20" />
                    <span className="group-hover:text-white transition-colors">{text}</span>
                  </li>
                ))}
              </ul>
            </section>

            <section className="space-y-10">
              <h2 className="text-sm font-bold text-blue-400 tracking-widest flex items-center gap-4">
                <div className="h-px w-8 bg-blue-500/30" />
                <Shield className="w-5 h-5" /> {t("privacy.privacycontent.auto_ext_8")}
                                            </h2>
              <div className="p-10 rounded-[40px] bg-blue-500/5 border border-blue-500/10 space-y-8">
                <p className="text-sm font-bold text-gray-300 leading-loose">
                  {t("privacy.privacycontent.auto_ext_9")}
                                                  </p>
                <div className="flex flex-wrap gap-10 pt-8 border-t border-white/5">
                  {["AES-256 ACTIVE", "SHA-512 ENFORCED", "TLS 1.3 SYNC", "ZERO-TRUST V2"].map(tag => (
                    <span key={tag} className="text-xs font-bold text-blue-500 tracking-widest">{tag}</span>
                  ))}
                </div>
              </div>
            </section>

            <div className="pt-20 border-t border-white/5 flex flex-col md:flex-row justify-between items-center gap-12">
              <div className="space-y-2 text-center md:text-left group cursor-pointer">
                <p className="text-xs font-bold text-white opacity-60 group-hover:opacity-100 transition-opacity">{t("privacy.privacycontent.auto_ext_10")}</p>
                <p className="text-xl font-bold text-blue-500 tracking-widest">{t("privacy.privacycontent.auto_ext_11")}</p>
              </div>
              <div className="flex items-center gap-10 opacity-10 group-hover:opacity-30 transition-opacity">
                <Shield className="w-10 h-10" />
                <Activity className="w-10 h-10" />
                <Disc className="w-10 h-10" />
              </div>
            </div>
          </div>
        </m.div>
      </div>
    </div>
  );
}
