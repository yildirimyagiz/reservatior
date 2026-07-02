import { useNavigate } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { ArrowLeft, FileText, Shield, Globe, Sparkles } from "lucide-react";
import { useTranslation } from "react-i18next";
import { motion } from "framer-motion";

export default function Terms() {
  const navigate = useNavigate();
  const { t } = useTranslation();

  return (
    <div className="min-h-screen bg-[#fafafa] dark:bg-[#0a0a0c] selection:bg-black selection:text-white dark:selection:bg-white dark:selection:text-black relative overflow-hidden">
      <div className="absolute inset-0 z-0 pointer-events-none overflow-hidden">
        <div className="absolute -top-[20%] -left-[10%] w-[50%] h-[50%] rounded-full bg-indigo-400/20 dark:bg-indigo-600/10 blur-[120px] mix-blend-multiply dark:mix-blend-lighten" />
        <div className="absolute top-[20%] -right-[10%] w-[40%] h-[60%] rounded-full bg-purple-400/20 dark:bg-purple-600/10 blur-[120px] mix-blend-multiply dark:mix-blend-lighten" />
        <div className="absolute -bottom-[20%] left-[20%] w-[60%] h-[50%] rounded-full bg-blue-400/10 dark:bg-blue-600/10 blur-[120px] mix-blend-multiply dark:mix-blend-lighten" />
      </div>

      <div className="container mx-auto px-4 py-24 max-w-4xl relative z-10">
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="flex flex-col md:flex-row md:items-center justify-between gap-8 mb-16"
        >
          <div className="flex items-center gap-6">
            <Button
              variant="ghost"
              size="sm"
              onClick={() => navigate(-1)}
              className="h-12 px-6 rounded-2xl bg-white/50 dark:bg-slate-800/50 border border-white/60 dark:border-slate-700/60 hover:bg-white/80 dark:hover:bg-slate-800/80 text-neutral-700 dark:text-slate-300 font-semibold text-sm transition-all group backdrop-blur-md"
            >
              <ArrowLeft className="w-4 h-4 mr-2 group-hover:-translate-x-1 transition-transform" />
              {t('back')}
            </Button>
            <div className="h-12 w-px bg-neutral-200 dark:bg-slate-800 hidden md:block" />
            <div className="flex items-center gap-4">
              <div className="h-12 w-12 rounded-2xl bg-gradient-to-br from-indigo-500 to-purple-600 flex items-center justify-center shadow-lg shadow-indigo-500/30">
                <FileText className="w-6 h-6 text-white" />
              </div>
              <div>
                <h1 className="text-3xl md:text-4xl font-black tracking-tight text-neutral-900 dark:text-white leading-none">
                  {t('termsTitle')}
                </h1>
                <p className="text-sm font-medium text-neutral-500 dark:text-slate-400 mt-1">
                  {t('termsSubtitle')}
                </p>
              </div>
            </div>
          </div>
          <div className="flex items-center gap-3 px-5 py-2.5 rounded-full bg-white/50 dark:bg-slate-800/50 border border-white/60 dark:border-slate-700/60 backdrop-blur-md self-start md:self-center">
            <div className="w-2 h-2 rounded-full bg-indigo-500 animate-pulse shadow-[0_0_10px_rgba(99,102,241,0.5)]" />
            <span className="text-xs font-semibold text-neutral-500 dark:text-slate-400">
              {t('termsLastupdated')}
            </span>
          </div>
        </motion.div>

        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.15 }}
        >
          <div className="p-8 md:p-12 rounded-[2rem] md:rounded-[3rem] bg-white/50 dark:bg-[#14151a]/50 backdrop-blur-xl border border-white/60 dark:border-slate-800/60 shadow-xl space-y-14 relative overflow-hidden">
            <div className="absolute top-0 right-0 w-64 h-64 bg-indigo-400/5 dark:bg-indigo-600/5 rounded-full blur-[80px] pointer-events-none" />

            <section className="space-y-6 relative">
              <h2 className="text-sm font-black tracking-widest uppercase text-indigo-600 dark:text-indigo-400 flex items-center gap-3">
                <div className="h-px w-6 bg-indigo-500/40" />
                <Shield className="w-4 h-4" />
                {t('acceptance')}
              </h2>
              <p className="text-base font-medium text-neutral-600 dark:text-slate-400 leading-relaxed">
                {t('acceptanceDesc')}
              </p>
            </section>

            <section className="space-y-6 relative">
              <h2 className="text-sm font-black tracking-widest uppercase text-indigo-600 dark:text-indigo-400 flex items-center gap-3">
                <div className="h-px w-6 bg-indigo-500/40" />
                <Globe className="w-4 h-4" />
                {t('termsService')}
              </h2>
              <div className="grid md:grid-cols-2 gap-4">
                {(t('serviceList', { returnObjects: true }) as string[]).map((item, i) => (
                  <div
                    key={i}
                    className="flex items-center gap-4 p-5 rounded-2xl bg-neutral-50/80 dark:bg-slate-900/50 border border-neutral-200/60 dark:border-slate-800/60 hover:bg-white dark:hover:bg-slate-800/80 transition-all group"
                  >
                    <div className="w-2 h-2 rounded-full bg-indigo-500/40 group-hover:bg-indigo-500 transition-colors shrink-0" />
                    <span className="text-sm font-semibold text-neutral-700 dark:text-slate-300 group-hover:text-neutral-900 dark:group-hover:text-white transition-colors">
                      {item}
                    </span>
                  </div>
                ))}
              </div>
            </section>

            <section className="space-y-6 relative">
              <h2 className="text-sm font-black tracking-widest uppercase text-indigo-600 dark:text-indigo-400 flex items-center gap-3">
                <div className="h-px w-6 bg-indigo-500/40" />
                <Sparkles className="w-4 h-4" />
                {t('prohibited')}
              </h2>
              <ul className="space-y-4">
                {(t('prohibitedList', { returnObjects: true }) as string[]).map((text, i) => (
                  <li
                    key={i}
                    className="flex items-center gap-4 text-sm font-medium text-neutral-500 dark:text-slate-400 group"
                  >
                    <span className="text-indigo-400/50 group-hover:text-indigo-500 transition-colors text-xs font-black">
                      [0x{i + 1}]
                    </span>
                    <span className="group-hover:text-neutral-700 dark:group-hover:text-slate-300 transition-colors">
                      {text}
                    </span>
                  </li>
                ))}
              </ul>
            </section>

            <div className="p-8 rounded-[2rem] bg-gradient-to-br from-indigo-500/5 to-purple-500/5 border border-indigo-500/10 space-y-4 relative overflow-hidden group">
              <div className="absolute inset-0 bg-transparent group-hover:bg-indigo-500/5 transition-colors duration-500" />
              <h3 className="text-sm font-black text-neutral-900 dark:text-white relative z-10">
                {t('liability')}
              </h3>
              <p className="text-sm font-medium text-neutral-600 dark:text-slate-400 leading-relaxed relative z-10">
                {t('liabilityDesc')}
              </p>
            </div>

            <div className="pt-12 border-t border-neutral-200 dark:border-slate-800 flex flex-col md:flex-row justify-between items-center gap-8 relative">
              <div className="text-center md:text-left group cursor-pointer">
                <p className="text-sm font-medium text-neutral-500 dark:text-slate-400 group-hover:text-neutral-700 dark:group-hover:text-slate-300 transition-colors">
                  {t('contact')}
                </p>
                <p className="text-lg font-black text-indigo-600 dark:text-indigo-400 mt-1">
                  {t("client.src.legalreservatiorcom")}
                </p>
              </div>
              <div className="flex items-center gap-6 opacity-20 group-hover:opacity-40 transition-opacity">
                <Shield className="w-6 h-6 text-neutral-400 dark:text-slate-500" />
                <Globe className="w-6 h-6 text-neutral-400 dark:text-slate-500" />
                <Sparkles className="w-6 h-6 text-indigo-400" />
              </div>
            </div>
          </div>
        </motion.div>
      </div>
    </div>
  );
}
