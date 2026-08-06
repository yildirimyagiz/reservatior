"use client";

import { useNavigate } from "@/lib/react-router-shim";
import { Button } from "@/components/ui/button";
import { ArrowLeft, Shield } from "lucide-react";
import { useTranslation } from "react-i18next";
import { m } from "framer-motion";
import { SecuritySettings as SecuritySettingsComponent } from "@/components/profile/SecuritySettings";

export default function SecuritySettings() {
  const navigate = useNavigate();
  const { t } = useTranslation();

  return (
    <div className="min-h-screen bg-background text-white selection:bg-brand/30 relative overflow-hidden">
      {/* Background Cybernetic Elements */}
      <div className="absolute inset-0 pointer-events-none">
        <div className="absolute top-0 right-0 w-[800px] h-[800px] bg-blue-600/5 blur-[120px] rounded-full"></div>
        <div className="absolute bottom-0 left-0 w-[600px] h-[600px] bg-brand/5 blur-[120px] rounded-full"></div>
        <div className="absolute top-0 left-0 w-full h-full opacity-[0.03] bg-[radial-gradient(#fff_1px,transparent_1px)] bg-size-[40px_40px]"></div>
      </div>

      <div className="container mx-auto px-4 py-24 max-w-5xl relative z-10">
        {/* Header HUD */}
        <m.div 
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="flex flex-col md:flex-row md:items-center justify-between gap-8 mb-16"
        >
          <div className="flex items-center gap-8">
            <Button 
              variant="ghost" 
              size="sm" 
              onClick={() => navigate(-1)}
              className="h-14 px-8 rounded-2xl bg-white/5 border border-white/5 hover:bg-white/10 text-muted-foreground font-black italic text-[10px] tracking-[0.25em] transition-all group"
            >
              <ArrowLeft className="w-4 h-4 mr-3 group-hover:-translate-x-1 transition-transform" />
              {t('back')}
            </Button>
            <div className="h-14 w-px bg-white/10 hidden md:block" />
            <div className="flex items-center gap-6">
              <div className="h-14 w-14 rounded-2xl bg-brand/10 border border-blue-500/20 flex items-center justify-center text-brand shadow-[0_0_20px_rgba(59,130,246,0.1)]">
                <Shield className="w-6 h-6" />
              </div>
              <div className="space-y-1">
                <h1 className="text-4xl font-black italic tracking-tighter leading-none">{t('securityTitle')}</h1>
                <p className="text-[10px] font-black text-muted-foreground tracking-[0.3em] italic">{t('securityDesc')}</p>
              </div>
            </div>
          </div>
        </m.div>

        {/* Security Matrix */}
        <m.div 
          initial={{ opacity: 0, scale: 0.98 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ delay: 0.1 }}
          className="p-12 md:p-16 rounded-[48px] bg-card/40 border border-white/5 backdrop-blur-3xl shadow-3xl border-l border-t"
        >
          <SecuritySettingsComponent />
        </m.div>
      </div>
    </div>
  );
}
