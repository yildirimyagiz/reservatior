import { Shield, ShieldCheck, Gavel, Lock, CheckCircle, Globe, Sparkles } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Header } from "@/components/home/Header";
import { CTA } from "@/components/home/CTA";
import { Badge } from "@/components/ui/badge";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";
export default function TrustCenter() {
  const {
    t
  } = useTranslation();
  const sections = [{
    title: t('heroPropverificationTitle'),
    icon: <ShieldCheck className="w-8 h-8 text-emerald-500" />,
    description: t('heroPropverificationDesc'),
    features: [t('heroPropverificationF1'), t('heroPropverificationF2'), t('heroPropverificationF3'), t('heroPropverificationF4')]
  }, {
    title: t('heroBookingsecurityTitle'),
    icon: <Shield className="w-8 h-8 text-blue-500" />,
    description: t('heroBookingsecurityDesc'),
    features: [t('heroBookingsecurityF1'), t('heroBookingsecurityF2'), t('heroBookingsecurityF3'), t('heroBookingsecurityF4')]
  }, {
    title: t('heroLegalTitle'),
    icon: <Gavel className="w-8 h-8 text-indigo-500" />,
    description: t('heroLegalDesc'),
    features: [t('heroLegalF1'), t('heroLegalF2'), t('heroLegalF3'), t('heroLegalF4')]
  }];
  return <div className="min-h-screen bg-[#14151a]">
      <Header />
      
      <main className="max-w-[1400px] mx-auto px-8 lg:px-12 py-24 space-y-32">
        {/* Hero Section */}
        <div className="text-center relative">
          <div className="absolute top-0 left-1/2 -translate-x-1/2 w-96 h-96 bg-emerald-500/10 blur-[120px] pointer-events-none rounded-full" />
          
          <motion.div initial={{
          opacity: 0,
          y: 20
        }} animate={{
          opacity: 1,
          y: 0
        }} transition={{
          duration: 0.5
        }}>
            <Badge className="mb-6 bg-emerald-500/10 text-emerald-400 border border-emerald-500/20 px-6 py-1 text-[10px] font-black tracking-[0.2em] italic">
              <Sparkles className="w-3 h-3 mr-2" /> {t('heroBadge')}
            </Badge>
            <h1 className="text-6xl md:text-8xl font-black text-white tracking-tighter mb-8 italic leading-none">
              {t('title1')} <span className="text-transparent bg-clip-text bg-linear-to-r from-emerald-400 to-blue-500 underline decoration-emerald-500/30">{t('title2')}</span>
            </h1>
            <p className="text-xl text-slate-500 max-w-3xl mx-auto font-black tracking-widest italic leading-relaxed">
              {t('heroSubtitle')}
            </p>
          </motion.div>
        </div>

        {/* Feature Matrix */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-10">
          {sections.map((section, idx) => <motion.div key={idx} initial={{
          opacity: 0,
          y: 30
        }} whileInView={{
          opacity: 1,
          y: 0
        }} viewport={{
          once: true
        }} transition={{
          delay: idx * 0.1
        }}>
              <Card className="border-white/5 bg-[#1a1b1e]/40 backdrop-blur-3xl rounded-[40px] overflow-hidden shadow-3xl border-l border-t group h-full">
                <CardHeader className="p-10 pb-4 flex flex-col items-start text-left">
                  <div className="p-5 rounded-2xl bg-black/40 border border-white/5 shadow-inner mb-8 group-hover:scale-110 transition-transform">
                    {section.icon}
                  </div>
                  <CardTitle className="text-xs font-black text-slate-500 tracking-widest flex items-center gap-3 italic mb-2">
                    {section.title}
                  </CardTitle>
                  <p className="text-2xl font-black text-white italic tracking-tighter leading-tight">{section.title}</p>
                </CardHeader>
                <CardContent className="p-10 pt-6 space-y-8">
                  <p className="text-sm font-bold text-slate-400 tracking-tight italic leading-relaxed">{section.description}</p>
                  <ul className="space-y-4 pt-6 border-t border-white/5">
                    {section.features.map((f, i) => <li key={i} className="flex items-center gap-4 text-[10px] font-black text-white italic tracking-widest opacity-70 group-hover:opacity-100 transition-opacity">
                        <CheckCircle className="w-4 h-4 text-emerald-500 shadow-[0_0_10px_#10b981]" />
                        {f}
                      </li>)}
                  </ul>
                </CardContent>
              </Card>
            </motion.div>)}
        </div>

        {/* Identity Engine HUD */}
        <div className="grid lg:grid-cols-2 gap-16 bg-[#1a1b1e]/60 rounded-[60px] p-16 text-white items-center border border-white/5 border-l border-t relative overflow-hidden shadow-3xl group">
          <div className="absolute top-0 right-0 w-[500px] h-[500px] bg-blue-500/5 blur-[120px] rounded-full pointer-events-none group-hover:bg-blue-500/10 transition-all duration-1000" />
          <div className="absolute bottom-0 left-0 w-[400px] h-[400px] bg-emerald-500/5 blur-[100px] rounded-full pointer-events-none group-hover:bg-emerald-500/10 transition-all duration-1000" />
          
          <div className="relative z-10 space-y-10">
             <div className="space-y-4">
                <Badge className="bg-blue-500/10 text-blue-400 border border-blue-500/20 px-4 py-1 text-[9px] font-black tracking-widest italic">{t('heroHudBadge')}</Badge>
                <h2 className="text-5xl font-black italic tracking-tighter leading-[0.9]">{t('heroHudTitle')}</h2>
             </div>
             <p className="text-slate-400 text-lg font-black tracking-widest italic leading-relaxed max-w-xl">
               {t('heroHudDesc')}
             </p>
             <div className="flex flex-wrap gap-6 pt-4">
                <div className="flex items-center gap-4 px-6 py-3 bg-black/40 rounded-2xl border border-white/5 backdrop-blur-xl shadow-2xl">
                   <Globe className="w-5 h-5 text-emerald-400 animate-pulse" />
                   <span className="text-[10px] font-black tracking-[0.2em] italic">{t('coverage')}</span>
                </div>
                <div className="flex items-center gap-4 px-6 py-3 bg-black/40 rounded-2xl border border-white/5 backdrop-blur-xl shadow-2xl">
                   <ShieldCheck className="w-5 h-5 text-blue-400" />
                   <span className="text-[10px] font-black tracking-[0.2em] italic">{t('compliant')}</span>
                </div>
             </div>
          </div>
          
          <div className="relative z-10 grid grid-cols-2 gap-8">
             <div className="bg-black/40 p-10 rounded-[40px] border border-white/5 backdrop-blur-3xl shadow-3xl border-l border-t group/stat">
                <h4 className="text-emerald-400 text-5xl font-black italic tracking-tighter mb-2 group-hover:scale-110 transition-transform">99.9%</h4>
                <p className="text-[10px] text-slate-500 font-black tracking-widest italic">{t('heroHudUptime')}</p>
             </div>
             <div className="bg-black/40 p-10 rounded-[40px] border border-white/5 backdrop-blur-3xl shadow-3xl border-l border-t group/stat">
                <h4 className="text-blue-400 text-5xl font-black italic tracking-tighter mb-2 group-hover:scale-110 transition-transform">{t("client.src.2ms")}</h4>
                <p className="text-[10px] text-slate-500 font-black tracking-widest italic">{t('heroHudLatency')}</p>
             </div>
             <div className="bg-black/60 p-10 rounded-[40px] col-span-2 border border-white/10 backdrop-blur-3xl shadow-3xl border-l border-t flex items-center justify-between group/stat">
                <div className="space-y-1">
                  <h4 className="text-3xl font-black text-white italic tracking-tighter leading-none">{t("client.src.iso_27001")}</h4>
                  <p className="text-[10px] text-slate-500 font-black tracking-widest italic">{t('iso')}</p>
                </div>
                <div className="p-5 bg-white/5 border border-white/10 rounded-3xl group-hover:bg-white/10 transition-colors">
                   <Lock className="w-8 h-8 text-white" />
                </div>
             </div>
          </div>
        </div>
      </main>

      <CTA />
    </div>;
}