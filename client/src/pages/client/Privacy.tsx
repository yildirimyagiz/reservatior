import { useNavigate } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { ArrowLeft, Shield, Disc, Activity } from "lucide-react";
import { useTranslation } from "react-i18next";
import { motion } from "framer-motion";
export default function Privacy() {
  const navigate = useNavigate();
  const {
    t
  } = useTranslation();
  return <div className="min-h-screen bg-[#14151a] text-white selection:bg-blue-500/30 relative overflow-hidden">
      {/* Background Cybernetic Elements */}
      <div className="absolute inset-0 pointer-events-none">
        <div className="absolute top-0 right-0 w-[800px] h-[800px] bg-blue-600/5 blur-[120px] rounded-full"></div>
        <div className="absolute bottom-0 left-0 w-[600px] h-[600px] bg-purple-600/5 blur-[120px] rounded-full"></div>
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
              <div className="h-14 w-14 rounded-2xl bg-blue-500/10 border border-blue-500/20 flex items-center justify-center text-blue-500 shadow-[0_0_20px_rgba(59,130,246,0.1)]">
                <Shield className="w-6 h-6" />
              </div>
              <div className="space-y-1">
                <h1 className="text-4xl font-black italic tracking-tighter leading-none">{t('privacyTitle')}</h1>
                <p className="text-[10px] font-black text-blue-500 italic tracking-widest mb-4">{t("client.src.legalprotocolv10")}</p>
                <p className="text-[10px] font-black text-slate-500 tracking-[0.3em] italic">{t('privacySubtitle')}</p>
              </div>
            </div>
          </div>
          <div className="flex items-center gap-4 px-6 py-3 rounded-full bg-white/5 border border-white/5 self-start md:self-center shadow-xl backdrop-blur-xl">
             <div className="w-2 h-2 rounded-full bg-emerald-500 animate-pulse shadow-[0_0_10px_#10b981]" />
             <span className="text-[9px] font-black text-slate-400 italic tracking-widest">{t('privacyLastupdated')}</span>
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
            <div className="absolute top-0 right-0 p-16 opacity-5 pointer-events-none rotate-12">
               <Shield className="w-80 h-80 text-blue-500" />
            </div>

            <section className="space-y-10 relative">
              <h2 className="text-sm font-black text-blue-400 tracking-[0.4em] italic flex items-center gap-4">
                <div className="h-px w-8 bg-blue-500/30" />
                <Disc className="w-5 h-5" /> {t('collection')}
              </h2>
              <div className="grid md:grid-cols-2 gap-6">
                {(t('items', {
                returnObjects: true
              }) as any[]).map((item, i) => <div key={i} className="p-8 rounded-[32px] bg-black/40 border border-white/5 hover:bg-white/5 transition-all hover:border-blue-500/20 group">
                     <p className="text-[11px] font-black text-white italic mb-3 group-hover:text-blue-400 transition-colors">{item.label}</p>
                     <p className="text-xs text-slate-500 font-bold italic leading-relaxed">{item.val}</p>
                  </div>)}
              </div>
            </section>

            <section className="space-y-10 relative">
              <h2 className="text-sm font-black text-blue-400 tracking-[0.4em] italic flex items-center gap-4">
                <div className="h-px w-8 bg-blue-500/30" />
                <Activity className="w-5 h-5" /> {t('usage')}
              </h2>
              <ul className="grid md:grid-cols-2 gap-x-16 gap-y-6">
                {(t('usageList', {
                returnObjects: true
              }) as string[]).map((text, i) => <li key={i} className="flex items-center gap-5 text-[11px] font-black text-slate-400 italic tracking-widest group">
                    <div className="h-2 w-2 rounded-full bg-blue-500/30 group-hover:bg-blue-500 transition-all border border-blue-500/20" /> 
                    <span className="group-hover:text-white transition-colors">{text}</span>
                  </li>)}
              </ul>
            </section>

            <section className="space-y-10 relative">
               <h2 className="text-sm font-black text-blue-400 tracking-[0.4em] italic flex items-center gap-4">
                <div className="h-px w-8 bg-blue-500/30" />
                <Shield className="w-5 h-5" /> {t('security')}
              </h2>
              <div className="p-10 rounded-[40px] bg-blue-500/5 border border-blue-500/10 space-y-8 relative overflow-hidden group">
                 <div className="absolute inset-0 bg-blue-500/5 opacity-0 group-hover:opacity-100 transition-opacity" />
                 <p className="text-sm font-bold text-slate-300 italic leading-loose relative z-10">
                   {t('securityDesc')}
                 </p>
                 <div className="flex flex-wrap gap-10 pt-8 border-t border-white/5 relative z-10">
                    {["AES-256 ACTIVE", "SHA-512 ENFORCED", "TLS 1.3 SYNC", "ZERO-TRUST V2"].map(tag => <span key={tag} className="text-[10px] font-black text-blue-500 italic tracking-[0.2em]">{tag}</span>)}
                 </div>
              </div>
            </section>

            <div className="pt-20 border-t border-white/5 flex flex-col md:flex-row justify-between items-center gap-12 relative">
               <div className="space-y-2 text-center md:text-left group cursor-pointer">
                  <p className="text-[11px] font-black text-white italic opacity-60 group-hover:opacity-100 transition-opacity">{t('contact')}</p>
                  <p className="text-xl font-black text-blue-500 italic tracking-widest">{t("client.src.privacyreservatiorcom")}</p>
               </div>
               <div className="flex items-center gap-10 opacity-10 group-hover:opacity-30 transition-opacity">
                  <Shield className="w-10 h-10" />
                  <Activity className="w-10 h-10" />
                  <Disc className="w-10 h-10" />
               </div>
            </div>
          </div>
        </motion.div>
      </div>
    </div>;
}