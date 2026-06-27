import { useNavigate } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { ArrowLeft, FileText, Cpu, Shield, Globe } from "lucide-react";
import { useTranslation } from "react-i18next";
import { motion } from "framer-motion";
export default function Terms() {
  const navigate = useNavigate();
  const {
    t
  } = useTranslation();
  return <div className="min-h-screen bg-[#14151a] text-white selection:bg-purple-500/30 relative overflow-hidden">
      {/* Background Cybernetic Elements */}
      <div className="absolute inset-0 pointer-events-none">
        <div className="absolute top-0 left-0 w-[800px] h-[800px] bg-purple-600/5 blur-[120px] rounded-full"></div>
        <div className="absolute bottom-0 right-0 w-[600px] h-[600px] bg-blue-600/5 blur-[120px] rounded-full"></div>
        <div className="absolute top-0 left-0 w-full h-full opacity-[0.03] bg-[radial-gradient(#fff_1px,transparent_1px)] bg-size-[40px_40px]"></div>
      </div>

      <div className="container mx-auto px-4 py-24 max-w-4xl relative z-10">
        {/* Header */}
        <motion.div initial={{
        opacity: 0,
        y: -20
      }} animate={{
        opacity: 1,
        y: 0
      }} className="flex flex-col md:flex-row md:items-center justify-between gap-8 mb-20">
          <div className="flex items-center gap-8">
            <Button variant="ghost" size="sm" onClick={() => navigate(-1)} className="h-14 px-8 rounded-2xl bg-white/5 border border-white/5 hover:bg-white/10 text-slate-400 font-black italic text-[10px] tracking-[0.25em] transition-all group">
              <ArrowLeft className="w-4 h-4 mr-3 group-hover:-translate-x-1 transition-transform" />
              {t('back')}
            </Button>
            <div className="h-14 w-px bg-white/10 hidden md:block" />
            <div className="flex items-center gap-6">
              <div className="h-14 w-14 rounded-2xl bg-purple-500/10 border border-purple-500/20 flex items-center justify-center text-purple-500 shadow-[0_0_20px_rgba(168,85,247,0.1)]">
                <FileText className="w-6 h-6" />
              </div>
              <div className="space-y-1">
                <p className="text-[10px] font-black text-blue-500 italic tracking-widest mb-4">{t("client.src.legalprotocolv10")}</p>
                <h1 className="text-4xl font-black italic tracking-tighter leading-none">{t('termsTitle')}</h1>
                <p className="text-[10px] font-black text-slate-500 tracking-[0.3em] italic">{t('termsSubtitle')}</p>
              </div>
            </div>
          </div>
          <div className="flex items-center gap-4 px-6 py-3 rounded-full bg-white/5 border border-white/5 self-start md:self-center shadow-xl backdrop-blur-xl">
             <div className="w-2 h-2 rounded-full bg-purple-500 animate-pulse shadow-[0_0_10px_#a855f7]" />
             <span className="text-[9px] font-black text-slate-400 italic tracking-widest">{t('termsLastupdated')}</span>
          </div>
        </motion.div>

        {/* Content Matrix */}
        <motion.div initial={{
        opacity: 0
      }} animate={{
        opacity: 1
      }} transition={{
        delay: 0.2
      }}>
          <div className="p-16 rounded-[64px] bg-[#1a1b1e]/40 border border-white/5 backdrop-blur-3xl shadow-3xl space-y-20 border-l border-t relative overflow-hidden">
            <div className="absolute top-0 right-0 p-16 opacity-5 pointer-events-none -rotate-12">
               <Cpu className="w-80 h-80 text-purple-500" />
            </div>

            <section className="space-y-10 relative">
              <h2 className="text-sm font-black text-purple-400 tracking-[0.4em] italic flex items-center gap-4">
                <div className="h-px w-8 bg-purple-500/30" />
                <Shield className="w-5 h-5" /> {t('acceptance')}
              </h2>
              <p className="text-sm font-bold text-slate-400 italic leading-loose">
                {t('acceptanceDesc')}
              </p>
            </section>

            <section className="space-y-10 relative">
              <h2 className="text-sm font-black text-purple-400 tracking-[0.4em] italic flex items-center gap-4">
                <div className="h-px w-8 bg-purple-500/30" />
                <Globe className="w-5 h-5" /> {t('termsService')}
              </h2>
              <div className="grid md:grid-cols-2 gap-6">
                {(t('serviceList', {
                returnObjects: true
              }) as string[]).map((item, i) => <div key={i} className="flex items-center gap-6 p-6 rounded-3xl bg-black/40 border border-white/5 hover:bg-white/5 transition-all group">
                    <div className="w-2 h-2 rounded-full bg-purple-500/30 group-hover:bg-purple-500 transition-all border border-purple-500/20 shadow-[0_0_10px_rgba(168,85,247,0.2)]" />
                    <span className="text-[11px] font-black text-slate-400 group-hover:text-white italic tracking-widest transition-colors">{item}</span>
                  </div>)}
              </div>
            </section>

            <section className="space-y-10 relative">
              <h2 className="text-sm font-black text-purple-400 tracking-[0.4em] italic flex items-center gap-4">
                <div className="h-px w-8 bg-purple-500/30" />
                <Cpu className="w-5 h-5" /> {t('prohibited')}
              </h2>
              <ul className="space-y-6 px-4">
                {(t('prohibitedList', {
                returnObjects: true
              }) as string[]).map((text, i) => <li key={i} className="flex items-center gap-6 text-[11px] font-black text-slate-500 italic tracking-[0.2em] group">
                    <span className="text-purple-500/30 group-hover:text-purple-500 transition-colors line-through text-[10px]">{t("client.src.0x0")}{i + 1}</span> 
                    <span className="group-hover:text-slate-300 transition-colors">{text}</span>
                  </li>)}
              </ul>
            </section>

            <div className="p-10 rounded-[48px] bg-purple-500/5 border border-purple-500/10 space-y-6 relative overflow-hidden group">
               <div className="absolute inset-0 bg-transparent group-hover:bg-purple-500/5 transition-all duration-700" />
               <h3 className="text-[11px] font-black text-white italic tracking-widest relative z-10">{t('liability')}</h3>
               <p className="text-[11px] font-bold text-slate-500 italic leading-loose tracking-[0.2em] relative z-10">
                 {t('liabilityDesc')}
               </p>
            </div>

            <div className="pt-20 border-t border-white/5 flex flex-col md:flex-row justify-between items-center gap-12 relative">
               <div className="space-y-2 text-center md:text-left group cursor-pointer">
                  <p className="text-[11px] font-black text-white italic opacity-60 group-hover:opacity-100 transition-opacity">{t('contact')}</p>
                  <p className="text-xl font-black text-purple-500 italic tracking-widest">{t("client.src.legalreservatiorcom")}</p>
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
    </div>;
}