"use client";

import { useRouter } from "next/navigation";
import { Shield, ShieldCheck, Gavel, Lock, CheckCircle, Globe, Sparkles, ArrowUpRight } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { m } from "framer-motion";
import { useTranslation } from "react-i18next";

// Sections moved inside component to use translations

export default function TrustCenterPage() {
  const { t } = useTranslation();
  const router = useRouter();

  const sections = [
    {
      title: t("trust_center.pv.title"),
      icon: <ShieldCheck className="w-8 h-8 text-success" />,
      description: t("trust_center.pv.desc"),
      features: [t("trust_center.pv.f1"), t("trust_center.pv.f2"), t("trust_center.pv.f3"), t("trust_center.pv.f4")]
    },
    {
      title: t("trust_center.bs.title"),
      icon: <Shield className="w-8 h-8 text-brand" />,
      description: t("trust_center.bs.desc"),
      features: [t("trust_center.bs.f1"), t("trust_center.bs.f2"), t("trust_center.bs.f3"), t("trust_center.bs.f4")]
    },
    {
      title: t("trust_center.lc.title"),
      icon: <Gavel className="w-8 h-8 text-brand" />,
      description: t("trust_center.lc.desc"),
      features: [t("trust_center.lc.f1"), t("trust_center.lc.f2"), t("trust_center.lc.f3"), t("trust_center.lc.f4")]
    }
  ];

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
      <div className="container mx-auto px-4 py-24">
        {/* Header */}
        <m.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-12"
        >
          <div className="flex items-center justify-between mb-8">
            <div>
              <Badge className="mb-6 bg-success/10 text-success border border-success/20 px-6 py-1 text-xs font-bold tracking-widest">
                <Sparkles className="w-3 h-3 mr-2" /> {t("trust_center.trustcenterpage.auto_ext_1")}
                                            </Badge>
              <h1 className="text-6xl md:text-8xl font-bold text-white tracking-tighter mb-4 italic leading-none">
                {t("trust_center.trustcenterpage.auto_ext_2")} <span className="text-transparent bg-clip-text bg-gradient-to-r from-blue-400 to-blue-500">{t("trust_center.trustcenterpage.auto_ext_3")}</span>
              </h1>
              <p className="text-xl text-gray-500 max-w-3xl font-bold tracking-widest italic leading-relaxed">
                {t("trust_center.trustcenterpage.auto_ext_4")}
                                            </p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-brand hover:bg-brand"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("trust_center.trustcenterpage.auto_ext_5")}
                                      </Button>
          </div>
        </m.div>

        {/* Feature Matrix */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-10 mb-20">
          {sections.map((section, idx) => (
            <m.div
              key={idx}
              initial={{ opacity: 0, y: 30 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: idx * 0.1 }}
            >
              <Card className="border-white/5 bg-white/5 backdrop-blur-xl rounded-[40px] overflow-hidden border border-brand/20 group h-full">
                <CardHeader className="p-10 pb-4 flex flex-col items-start text-left">
                  <div className="p-5 rounded-2xl bg-black/40 border border-white/5 shadow-inner mb-8 group-hover:scale-110 transition-transform">
                    {section.icon}
                  </div>
                  <CardTitle className="text-xs font-bold text-gray-500 tracking-widest flex items-center gap-3 italic mb-2">
                    {section.title}
                  </CardTitle>
                  <p className="text-2xl font-bold text-white italic tracking-tighter leading-tight">{section.title}</p>
                </CardHeader>
                <CardContent className="p-10 pt-6 space-y-8">
                  <p className="text-sm font-bold text-gray-400 tracking-tight italic leading-relaxed">{section.description}</p>
                  <ul className="space-y-4 pt-6 border-t border-white/5">
                    {section.features.map((f, i) => (
                      <li key={i} className="flex items-center gap-4 text-xs font-bold text-white italic tracking-widest opacity-70 group-hover:opacity-100 transition-opacity">
                        <CheckCircle className="w-4 h-4 text-success" />
                        {f}
                      </li>
                    ))}
                  </ul>
                </CardContent>
              </Card>
            </m.div>
          ))}
        </div>

        {/* Stats */}
        <div className="grid lg:grid-cols-2 gap-16 bg-white/5 rounded-[60px] p-16 text-white items-center border border-brand/20">
          <div className="space-y-10">
            <div className="space-y-4">
              <Badge className="bg-brand/100/10 text-brand border border-blue-500/20 px-4 py-1 text-xs font-bold tracking-widest italic">{t("trust_center.trustcenterpage.auto_ext_6")}</Badge>
              <h2 className="text-5xl font-bold italic tracking-tighter leading-[0.9]">{t("trust_center.trustcenterpage.auto_ext_7")}</h2>
            </div>
            <p className="text-gray-400 text-lg font-bold tracking-widest italic leading-relaxed max-w-xl">
              {t("trust_center.trustcenterpage.auto_ext_8")}
                                      </p>
            <div className="flex flex-wrap gap-6 pt-4">
              <div className="flex items-center gap-4 px-6 py-3 bg-black/40 rounded-2xl border border-white/5 backdrop-blur-xl">
                <Globe className="w-5 h-5 text-success animate-pulse" />
                <span className="text-xs font-bold tracking-widest italic">{t("trust_center.trustcenterpage.auto_ext_9")}</span>
              </div>
              <div className="flex items-center gap-4 px-6 py-3 bg-black/40 rounded-2xl border border-white/5 backdrop-blur-xl">
                <ShieldCheck className="w-5 h-5 text-brand" />
                <span className="text-xs font-bold tracking-widest italic">{t("trust_center.trustcenterpage.auto_ext_10")}</span>
              </div>
            </div>
          </div>
          
          <div className="grid grid-cols-2 gap-8">
            <div className="bg-black/40 p-10 rounded-[40px] border border-white/5 backdrop-blur-xl border border-brand/20">
              <h4 className="text-success text-5xl font-bold italic tracking-tighter mb-2">99.9%</h4>
              <p className="text-xs text-gray-500 font-bold tracking-widest italic">{t("trust_center.trustcenterpage.auto_ext_11")}</p>
            </div>
            <div className="bg-black/40 p-10 rounded-[40px] border border-white/5 backdrop-blur-xl border border-brand/20">
              <h4 className="text-brand text-5xl font-bold italic tracking-tighter mb-2">{t("trust_center.trustcenterpage.auto_ext_12")}</h4>
              <p className="text-xs text-gray-500 font-bold tracking-widest italic">{t("trust_center.trustcenterpage.auto_ext_13")}</p>
            </div>
            <div className="bg-black/60 p-10 rounded-[40px] col-span-2 border border-white/10 backdrop-blur-xl border border-brand/20 flex items-center justify-between">
              <div className="space-y-1">
                <h4 className="text-3xl font-bold text-white italic tracking-tighter leading-none">{t("trust_center.trustcenterpage.auto_ext_14")}</h4>
                <p className="text-xs text-gray-500 font-bold tracking-widest italic">{t("trust_center.trustcenterpage.auto_ext_15")}</p>
              </div>
              <div className="p-5 bg-white/5 border border-white/10 rounded-3xl">
                <Lock className="w-8 h-8 text-white" />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
