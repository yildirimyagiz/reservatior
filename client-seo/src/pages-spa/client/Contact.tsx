"use client";

import { useState } from "react";
import { PageShell } from "./layout/PageShell";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Mail, Phone, MapPin, Building, Clock, Send, MessageSquare, Zap, Shield, Activity, Globe, Cpu, Fingerprint, RefreshCw } from "lucide-react";
import { motion } from "framer-motion";
import { useToast } from "@/hooks/use-toast";
import { cn } from "@/lib/utils";
import { useTranslation } from "react-i18next";
export default function Contact() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [isSubmitting, setIsSubmitting] = useState(false);
  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);
    setTimeout(() => {
      setIsSubmitting(false);
      toast({
        title: t('successTitle'),
        description: t('successDesc')
      });
    }, 2000);
  };
  const contactNodes = [{
    icon: Mail,
    label: t('contactNodeslistEmailLabel'),
    value: "info@reservatior.com",
    sub: t('contactNodeslistEmailSub'),
    color: "text-blue-400"
  }, {
    icon: Phone,
    label: t('contactNodeslistPhoneLabel'),
    value: "+90(553) 621 20 00",
    sub: t('contactNodeslistPhoneSub'),
    color: "text-emerald-400"
  }, {
    icon: MapPin,
    label: t('contactNodeslistAddressLabel'),
    value: "TURKEY / ISTANBUL ",
    sub: t('contactNodeslistAddressSub'),
    color: "text-purple-400"
  }];
  return <PageShell title={t('contactTitle')} description={t('contactDesc')} stats={[{
    label: t('contactLatency'),
    value: "14ms",
    color: "text-emerald-400"
  }, {
    label: t('contactStatus'),
    value: "ONLINE",
    color: "text-blue-400"
  }, {
    label: t('contactEncryption'),
    value: "AES-256",
    color: "text-slate-400"
  }, {
    label: t('contactNodes'),
    value: "12 ACTIVE"
  }]}>
      <div className="grid lg:grid-cols-2 gap-12 px-4">
        {/* Contact Form Node */}
        <motion.div initial={{
        opacity: 0,
        x: -30
      }} animate={{
        opacity: 1,
        x: 0
      }} className="p-10 rounded-[40px] bg-[#1a1b1e]/40 border border-white/5 backdrop-blur-3xl shadow-3xl border-l border-t relative overflow-hidden">
          <div className="absolute top-0 right-0 p-12 opacity-5 pointer-events-none text-blue-500">
             <Send className="w-48 h-48" />
          </div>

          <div className="relative z-10 space-y-8">
            <div className="space-y-2">
               <h2 className="text-3xl font-black text-white italic tracking-tighter leading-none">{t('initUplink')}</h2>
               <p className="text-[10px] font-black text-slate-500 tracking-widest italic">{t('secureProtocol')}</p>
            </div>

            <form onSubmit={handleSubmit} className="space-y-6">
              <div className="grid md:grid-cols-2 gap-6">
                <div className="space-y-2">
                   <Label className="text-[10px] font-black text-slate-500 italic tracking-widest">{t('idAlpha')}</Label>
                   <Input required className="h-14 bg-black/40 border-white/5 rounded-2xl text-white placeholder:text-slate-700 font-bold italic" placeholder={t('nameHolder')} />
                </div>
                <div className="space-y-2">
                   <Label className="text-[10px] font-black text-slate-500 italic tracking-widest">{t('idBeta')}</Label>
                   <Input required className="h-14 bg-black/40 border-white/5 rounded-2xl text-white placeholder:text-slate-700 font-bold italic" placeholder={t('entityHolder')} />
                </div>
              </div>

              <div className="space-y-2">
                <Label className="text-[10px] font-black text-slate-500 italic tracking-widest">{t('commsNode')}</Label>
                <Input required type="email" className="h-14 bg-black/40 border-white/5 rounded-2xl text-white placeholder:text-slate-700 font-bold italic" placeholder={t('emailHolder')} />
              </div>

              <div className="space-y-2">
                <Label className="text-[10px] font-black text-slate-500 italic tracking-widest">{t('payload')}</Label>
                <Textarea required className="min-h-[160px] bg-black/40 border-white/5 rounded-3xl text-white placeholder:text-slate-700 font-bold italic p-6" placeholder={t('msgHolder')} />
              </div>

              <Button disabled={isSubmitting} className="w-full h-16 bg-blue-600 hover:bg-blue-500 text-white font-black text-xs italic tracking-widest shadow-xl shadow-blue-600/20 rounded-2xl transition-all active:scale-[0.98]">
                {isSubmitting ? <div className="flex items-center gap-3">
                    <RefreshCw className="w-5 h-5 animate-spin" />
                    <span>{t('encrypting')}</span>
                  </div> : <div className="flex items-center gap-3">
                    <Fingerprint className="w-5 h-5" />
                    <span>{t('execute')}</span>
                  </div>}
              </Button>
            </form>
          </div>
        </motion.div>

        {/* Contact Info Grid */}
        <div className="space-y-8">
           <div className="grid sm:grid-cols-2 lg:grid-cols-1 gap-6">
              {contactNodes.map((node, idx) => <motion.div key={node.label} initial={{
            opacity: 0,
            y: 20
          }} animate={{
            opacity: 1,
            y: 0
          }} transition={{
            delay: idx * 0.1
          }} className="p-8 rounded-[32px] bg-[#1a1b1e]/40 border border-white/5 backdrop-blur-3xl shadow-2xl border-l border-t group hover:bg-white/5 transition-all">
                  <div className="flex items-center gap-6">
                    <div className={cn("h-14 w-14 rounded-2xl bg-black/40 border border-white/5 flex items-center justify-center transition-transform group-hover:scale-110", node.color)}>
                      <node.icon className="w-6 h-6" />
                    </div>
                    <div className="space-y-1">
                      <p className="text-[10px] font-black text-slate-500 tracking-widest italic">{node.label}</p>
                      <p className="text-lg font-black text-white italic tracking-tighter">{node.value}</p>
                      <p className="text-[8px] font-black text-slate-600 tracking-[0.2em] italic">{node.sub}</p>
                    </div>
                  </div>
                </motion.div>)}
           </div>

           {/* Legal Node */}
           <motion.div initial={{
          opacity: 0,
          scale: 0.95
        }} animate={{
          opacity: 1,
          scale: 1
        }} transition={{
          delay: 0.4
        }} className="p-10 rounded-[40px] bg-gradient-to-br from-blue-600/10 to-purple-600/10 border border-white/5 backdrop-blur-3xl relative overflow-hidden">
              <div className="absolute top-0 right-0 p-8 opacity-10">
                 <Shield className="w-16 h-16 text-blue-400" />
              </div>
              <div className="space-y-4">
                 <h3 className="text-xl font-black text-white italic tracking-tighter">{t('legalTitle')}</h3>
                 <p className="text-[11px] font-bold text-slate-400 tracking-wider leading-relaxed italic">
                   {t('legalDesc')}
                 </p>
                 <div className="flex items-center gap-6 pt-4">
                    <div className="flex items-center gap-2">
                       <div className="w-2 h-2 rounded-full bg-emerald-500 animate-pulse" />
                       <span className="text-[8px] font-black text-white italic">{t('systemActive')}</span>
                    </div>
                    <div className="flex items-center gap-2">
                       <Cpu className="w-3 h-3 text-blue-500" />
                       <span className="text-[8px] font-black text-white italic">{t("client.src.elysiajs_core")}</span>
                    </div>
                 </div>
              </div>
           </motion.div>
        </div>
      </div>
    </PageShell>;
}