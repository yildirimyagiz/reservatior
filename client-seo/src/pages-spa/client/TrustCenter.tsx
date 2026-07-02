import { Shield, ShieldCheck, Gavel, Lock, CheckCircle, Globe, Sparkles } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Header } from "@/components/home/Header";
import { CTA } from "@/components/home/CTA";
import { Badge } from "@/components/ui/badge";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";

export default function TrustCenter() {
  const { t } = useTranslation();

  const sections = [
    {
      title: t('heroPropverificationTitle'),
      icon: <ShieldCheck className="w-8 h-8 text-emerald-500" />,
      description: t('heroPropverificationDesc'),
      features: [t('heroPropverificationF1'), t('heroPropverificationF2'), t('heroPropverificationF3'), t('heroPropverificationF4')]
    },
    {
      title: t('heroBookingsecurityTitle'),
      icon: <Shield className="w-8 h-8 text-indigo-500" />,
      description: t('heroBookingsecurityDesc'),
      features: [t('heroBookingsecurityF1'), t('heroBookingsecurityF2'), t('heroBookingsecurityF3'), t('heroBookingsecurityF4')]
    },
    {
      title: t('heroLegalTitle'),
      icon: <Gavel className="w-8 h-8 text-purple-500" />,
      description: t('heroLegalDesc'),
      features: [t('heroLegalF1'), t('heroLegalF2'), t('heroLegalF3'), t('heroLegalF4')]
    }
  ];

  return (
    <div className="min-h-screen bg-[#fafafa] dark:bg-[#0a0a0c] selection:bg-black selection:text-white dark:selection:bg-white dark:selection:text-black">
      <Header />

      <main className="max-w-[1400px] mx-auto px-6 md:px-12 py-24 space-y-32">
        <div className="text-center relative">
          <div className="absolute top-0 left-1/2 -translate-x-1/2 w-96 h-96 bg-indigo-500/10 dark:bg-indigo-600/10 blur-[120px] pointer-events-none rounded-full" />

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5 }}
          >
            <Badge className="mb-6 bg-indigo-50 dark:bg-indigo-900/20 text-indigo-600 dark:text-indigo-400 border border-indigo-200/60 dark:border-indigo-500/20 px-5 py-1.5 text-xs font-bold tracking-wider rounded-full">
              <Sparkles className="w-3 h-3 mr-2" /> {t('heroBadge')}
            </Badge>
            <h1 className="text-5xl md:text-8xl font-black tracking-tight text-neutral-900 dark:text-white mb-8 leading-[0.9]">
              {t('title1')}{' '}
              <span className="text-transparent bg-clip-text bg-gradient-to-r from-indigo-600 to-purple-500 dark:from-indigo-400 dark:to-purple-400">
                {t('title2')}
              </span>
            </h1>
            <p className="text-lg md:text-xl text-neutral-500 dark:text-slate-400 max-w-3xl mx-auto font-medium leading-relaxed">
              {t('heroSubtitle')}
            </p>
          </motion.div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          {sections.map((section, idx) => (
            <motion.div
              key={idx}
              initial={{ opacity: 0, y: 30 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: idx * 0.1 }}
            >
              <Card className="border border-white/60 dark:border-slate-800/60 bg-white/50 dark:bg-[#14151a]/50 backdrop-blur-xl rounded-[2rem] overflow-hidden shadow-xl group h-full">
                <CardHeader className="p-8 pb-4 flex flex-col items-start text-left">
                  <div className="p-4 rounded-2xl bg-gradient-to-br from-indigo-500 to-purple-600 shadow-lg shadow-indigo-500/20 mb-6 group-hover:scale-110 transition-transform">
                    {section.icon}
                  </div>
                  <p className="text-xs font-bold text-neutral-500 dark:text-slate-400 tracking-widest uppercase mb-2">
                    {section.title}
                  </p>
                  <CardTitle className="text-2xl font-black text-neutral-900 dark:text-white tracking-tight leading-tight">
                    {section.title}
                  </CardTitle>
                </CardHeader>
                <CardContent className="px-8 pb-8 pt-4 space-y-6">
                  <p className="text-sm font-medium text-neutral-600 dark:text-slate-400 leading-relaxed">
                    {section.description}
                  </p>
                  <ul className="space-y-3 pt-6 border-t border-neutral-200 dark:border-slate-800">
                    {section.features.map((f, i) => (
                      <li
                        key={i}
                        className="flex items-center gap-3 text-sm font-semibold text-neutral-700 dark:text-slate-300 opacity-70 group-hover:opacity-100 transition-opacity"
                      >
                        <CheckCircle className="w-4 h-4 text-emerald-500 shrink-0 shadow-[0_0_8px_rgba(16,185,129,0.3)]" />
                        {f}
                      </li>
                    ))}
                  </ul>
                </CardContent>
              </Card>
            </motion.div>
          ))}
        </div>

        <div className="grid lg:grid-cols-2 gap-12 p-10 md:p-16 rounded-[2rem] md:rounded-[3rem] bg-gradient-to-br from-indigo-500/5 to-purple-500/5 border border-indigo-500/10 overflow-hidden relative group">
          <div className="absolute top-0 right-0 w-[400px] h-[400px] bg-indigo-500/5 dark:bg-indigo-600/5 blur-[100px] rounded-full pointer-events-none" />
          <div className="absolute bottom-0 left-0 w-[300px] h-[300px] bg-purple-500/5 dark:bg-purple-600/5 blur-[80px] rounded-full pointer-events-none" />

          <div className="relative z-10 space-y-8">
            <div className="space-y-4">
              <Badge className="bg-indigo-50 dark:bg-indigo-900/20 text-indigo-600 dark:text-indigo-400 border border-indigo-200/60 dark:border-indigo-500/20 px-4 py-1 text-xs font-bold tracking-wider rounded-full">
                {t('heroHudBadge')}
              </Badge>
              <h2 className="text-4xl md:text-5xl font-black tracking-tight text-neutral-900 dark:text-white leading-[0.95]">
                {t('heroHudTitle')}
              </h2>
            </div>
            <p className="text-neutral-500 dark:text-slate-400 text-base font-medium leading-relaxed max-w-xl">
              {t('heroHudDesc')}
            </p>
            <div className="flex flex-wrap gap-4">
              <div className="flex items-center gap-3 px-5 py-3 bg-white/50 dark:bg-slate-900/50 rounded-2xl border border-white/60 dark:border-slate-700/60 backdrop-blur-md">
                <Globe className="w-4 h-4 text-indigo-500" />
                <span className="text-xs font-bold text-neutral-700 dark:text-slate-300 tracking-wider uppercase">
                  {t('coverage')}
                </span>
              </div>
              <div className="flex items-center gap-3 px-5 py-3 bg-white/50 dark:bg-slate-900/50 rounded-2xl border border-white/60 dark:border-slate-700/60 backdrop-blur-md">
                <ShieldCheck className="w-4 h-4 text-indigo-500" />
                <span className="text-xs font-bold text-neutral-700 dark:text-slate-300 tracking-wider uppercase">
                  {t('compliant')}
                </span>
              </div>
            </div>
          </div>

          <div className="relative z-10 grid grid-cols-2 gap-4">
            <div className="bg-white/50 dark:bg-[#14151a]/50 p-8 rounded-[2rem] border border-white/60 dark:border-slate-800/60 backdrop-blur-xl group/stat">
              <h4 className="text-4xl md:text-5xl font-black text-emerald-600 dark:text-emerald-400 tracking-tight mb-2 group-hover:scale-110 transition-transform">
                99.9%
              </h4>
              <p className="text-xs font-bold text-neutral-500 dark:text-slate-400 tracking-widest uppercase">
                {t('heroHudUptime')}
              </p>
            </div>
            <div className="bg-white/50 dark:bg-[#14151a]/50 p-8 rounded-[2rem] border border-white/60 dark:border-slate-800/60 backdrop-blur-xl group/stat">
              <h4 className="text-4xl md:text-5xl font-black text-indigo-600 dark:text-indigo-400 tracking-tight mb-2 group-hover:scale-110 transition-transform">
                {t("client.src.2ms")}
              </h4>
              <p className="text-xs font-bold text-neutral-500 dark:text-slate-400 tracking-widest uppercase">
                {t('heroHudLatency')}
              </p>
            </div>
            <div className="bg-white/50 dark:bg-[#14151a]/50 p-8 rounded-[2rem] col-span-2 border border-white/60 dark:border-slate-800/60 backdrop-blur-xl flex items-center justify-between group/stat">
              <div className="space-y-1">
                <h4 className="text-2xl md:text-3xl font-black text-neutral-900 dark:text-white tracking-tight leading-none">
                  {t("client.src.iso_27001")}
                </h4>
                <p className="text-xs font-bold text-neutral-500 dark:text-slate-400 tracking-widest uppercase">
                  {t('iso')}
                </p>
              </div>
              <div className="p-4 rounded-2xl bg-indigo-50 dark:bg-indigo-900/20 border border-indigo-200/60 dark:border-indigo-500/20 group-hover:bg-indigo-100 dark:group-hover:bg-indigo-900/40 transition-colors">
                <Lock className="w-6 h-6 text-indigo-600 dark:text-indigo-400" />
              </div>
            </div>
          </div>
        </div>
      </main>

      <CTA />
    </div>
  );
}
