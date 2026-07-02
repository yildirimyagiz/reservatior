import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "../layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Building2, TrendingUp, DollarSign, PieChart, Plus, ArrowUpRight, BarChart3, Download, Zap, ShieldCheck, Globe, ChevronRight, Loader2 } from "lucide-react";
import { motion } from "framer-motion";
import { cn } from "@/lib/utils";
import { useQuery } from "@tanstack/react-query";
import { investorsApi } from "@/lib/api/investors";
interface Portfolio {
  id: string;
  name: string;
  description: string;
  totalValue: number;
  totalEquity: number;
  currency: string;
  performanceMetric: number; // percentage
  propertyCount: number;
}
export default function InvestorPortfolio() {
  const {
    t
  } = useTranslation();
  
  const { data: portfolios = [], isLoading } = useQuery({
    queryKey: ['investorPortfolios'],
    queryFn: async () => {
      const response = (await investorsApi.getPortfolios()) as any;
      // We map the backend InvestorPortfolio to the component's Portfolio format
      return (response.data || []).map((p: any) => ({
        id: p.id,
        name: p.name,
        description: p.riskTolerance ? `Risk: ${p.riskTolerance}` : t("investors.portfolio.desc_london"),
        totalValue: p.targetIrr ? p.targetIrr * 1000000 : 8450000, 
        totalEquity: p.targetIrr ? p.targetIrr * 400000 : 3200000,
        currency: "GBP",
        performanceMetric: p.targetIrr ? p.targetIrr : 12.4,
        propertyCount: p.propertyCount || 8
      })) as Portfolio[];
    }
  });
  return <PageShell title={t("investors.portfolio.title", "Yatırım Portföyüm")} description={t("investors.portfolio.desc", "Yatırımlarınızı, varlık dağılımınızı ve nakit akışınızı tek bir yerden kolayca yönetin.")}>
      <div className="space-y-12">
        {/* Market Overview Sidebar-like Top Section */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          <Card className="border-white/5 bg-gradient-to-br from-blue-600/20 to-indigo-600/20 backdrop-blur-3xl rounded-[40px] overflow-hidden shadow-3xl relative border-l border-t">
             <CardContent className="p-10">
               <div className="flex justify-between items-start mb-10">
                  <div className="space-y-1">
                    <p className="text-[10px] font-black text-blue-400 tracking-widest italic">{t("investors.portfolio.total_value", "TOPLAM PORTFÖY DEĞERİ")}</p>
                    <h2 className="text-5xl font-black text-white italic tracking-tighter leading-none">£10.55M</h2>
                  </div>
                  <Badge className="bg-emerald-500/10 text-emerald-400 border border-emerald-500/20 px-3 py-1 text-[8px] font-black tracking-widest italic">{t("investors.portfolio.last_12_months", "SON 12 AY")}</Badge>
               </div>
               <div className="grid grid-cols-2 gap-6">
                  <div className="bg-black/40 p-5 rounded-2xl border border-white/5 backdrop-blur-xl">
                     <p className="text-[9px] font-black text-slate-500 tracking-widest italic mb-1">{t("investors.portfolio.net_equity", "NET ÖZKAYNAK")}</p>
                     <p className="text-2xl font-black text-white italic tracking-tighter">£5.0M</p>
                  </div>
                  <div className="bg-black/40 p-5 rounded-2xl border border-white/5 backdrop-blur-xl">
                     <p className="text-[9px] font-black text-slate-500 tracking-widest italic mb-1">{t("investors.portfolio.ltv_ratio", "KREDİ/DEĞER ORANI")}</p>
                     <p className="text-2xl font-black text-white italic tracking-tighter">52.6%</p>
                  </div>
               </div>
             </CardContent>
             <div className="absolute top-0 right-0 p-20 opacity-5 pointer-events-none">
                <Globe className="w-64 h-64 text-white" />
             </div>
          </Card>

          <Card className="border-white/5 bg-[#1a1b1e]/60 backdrop-blur-3xl rounded-[40px] shadow-3xl border-l border-t">
            <CardHeader className="p-10 pb-4">
              <CardTitle className="text-[10px] font-black flex items-center text-slate-500 tracking-[0.2em] italic gap-3">
                 <Zap className="w-4 h-4 text-orange-500" />{t("investors.portfolio.performance", "PORTFÖY PERFORMANSI")}</CardTitle>
            </CardHeader>
            <CardContent className="p-10 pt-4 space-y-6">
               <div className="flex justify-between items-center py-4 border-b border-white/5">
                  <span className="text-[11px] font-black text-slate-400 italic tracking-widest">{t("investors.portfolio.annual_return", "Yıllık Getiri Oranı")}</span>
                  <span className="text-xl font-black text-emerald-400 italic tracking-tighter flex items-center">10.6% <ArrowUpRight className="w-4 h-4 ml-2" /></span>
               </div>
               <div className="flex justify-between items-center py-4 border-b border-white/5">
                  <span className="text-[11px] font-black text-slate-400 italic tracking-widest">{t("investors.portfolio.monthly_cashflow", "Aylık Nakit Akışı")}</span>
                  <span className="text-xl font-black text-white italic tracking-tighter whitespace-nowrap">£18,240 / Ay</span>
               </div>
               <div className="flex justify-between items-center py-4">
                  <span className="text-[11px] font-black text-slate-400 italic tracking-widest">{t("investors.portfolio.appreciation", "Yıllık Değer Artışı")}</span>
                  <span className="text-xl font-black text-blue-400 italic tracking-tighter whitespace-nowrap">£422k</span>
               </div>
            </CardContent>
          </Card>

          <Card className="border-white/5 bg-[#1a1b1e]/60 backdrop-blur-3xl rounded-[40px] shadow-3xl border-l border-t relative overflow-hidden">
            <CardContent className="p-10 flex flex-col h-full justify-between gap-8">
               <div className="space-y-6">
                  <h4 className="text-[10px] font-black text-slate-500 tracking-[0.2em] italic flex items-center gap-3">
                     <PieChart className="w-4 h-4 text-purple-500" />{t("investors.portfolio.allocation", "VARLIK DAĞILIMI")}</h4>
                  <div className="w-full bg-black/40 h-3 rounded-full overflow-hidden flex shadow-inner border border-white/5">
                     <div className="h-full bg-blue-600 shadow-[0_0_15px_#2563eb]" style={{
                  width: '75%'
                }}></div>
                     <div className="h-full bg-emerald-500 shadow-[0_0_15px_#10b981]" style={{
                  width: '25%'
                }}></div>
                  </div>
                  <div className="flex justify-between items-center pt-2">
                     <div className="flex items-center gap-3">
                        <div className="w-2 h-2 rounded-full bg-blue-600"></div>
                        <span className="text-[9px] font-black text-white italic tracking-widest">{t("investors.portfolio.residential", "KONUT (%75)")}</span>
                     </div>
                     <div className="flex items-center gap-3">
                        <div className="w-2 h-2 rounded-full bg-emerald-500"></div>
                        <span className="text-[9px] font-black text-white italic tracking-widest">{t("investors.portfolio.student", "ÖĞRENCİ (%25)")}</span>
                     </div>
                  </div>
               </div>
               <Button className="w-full h-16 rounded-2xl bg-white text-black hover:bg-slate-200 font-black text-[10px] tracking-widest italic shadow-2xl transition-all">{t("investors.portfolio.download_report", "PORTFÖY RAPORUNU İNDİR")}<Download className="w-4 h-4 ml-3" />
               </Button>
            </CardContent>
          </Card>
        </div>

        {/* Portfolios List */}
        <div className="space-y-8">
           <div className="flex justify-between items-center px-4">
              <h3 className="text-2xl font-black text-white italic tracking-tighter">{t("investors.portfolio.my_investments", "Mevcut Yatırımlarınız")}</h3>
              <div className="flex gap-4">
                <Button variant="outline" size="sm" className="h-12 border-white/5 bg-white/5 text-slate-400 hover:text-white font-black text-[10px] tracking-widest italic rounded-xl px-6">
                   <Download className="w-4 h-4 mr-3" />{t("investors.portfolio.export", "VERİLERİ DIŞA AKTAR")}</Button>
                <Button size="sm" className="h-12 bg-blue-600 hover:bg-blue-500 text-white font-black text-[10px] tracking-widest italic rounded-xl px-6 shadow-xl shadow-blue-900/20">
                   <Plus className="w-4 h-4 mr-3" />{t("investors.portfolio.add_new", "YENİ YATIRIM EKLE")}</Button>
              </div>
           </div>

           <div className="grid gap-8">
              {isLoading ? (
                <div className="flex flex-col items-center justify-center h-64 space-y-4">
                  <Loader2 className="w-8 h-8 animate-spin text-blue-500" />
                  <p className="text-[10px] font-black text-slate-500 tracking-widest italic">{t("investors.portfolio.loading", "Yükleniyor...")}</p>
                </div>
              ) : portfolios.length === 0 ? (
                <div className="flex flex-col items-center justify-center h-64 space-y-4">
                  <p className="text-[10px] font-black text-slate-500 tracking-widest italic">{t("investors.portfolio.no_portfolios", "Henüz bir yatırım portföyü bulunmuyor.")}</p>
                </div>
              ) : portfolios.map(p => <motion.div key={p.id} whileHover={{
            y: -5
          }} className="group">
                  <Card className="border-white/5 bg-[#1a1b1e]/40 backdrop-blur-3xl rounded-[40px] overflow-hidden shadow-3xl border-l border-t relative hover:bg-white/5 transition-all">
                    <CardContent className="p-0">
                      <div className="flex flex-col lg:flex-row min-h-[300px]">
                         <div className="p-12 flex-1 space-y-12">
                            <div className="flex justify-between items-start">
                              <div className="space-y-2">
                                 <h4 className="text-4xl font-black text-white italic tracking-tighter leading-none">{p.name}</h4>
                                 <p className="text-xs text-slate-500 font-black italic tracking-widest">{p.description}</p>
                              </div>
                              <div className="text-right space-y-1">
                                 <p className="text-[10px] font-black text-emerald-400 tracking-widest italic">{t("investors.portfolio.growth", "DEĞER ARTIŞI")}</p>
                                 <div className="flex items-center text-4xl font-black text-emerald-400 italic tracking-tighter leading-none justify-end">
                                    +{p.performanceMetric}% <TrendingUp className="w-6 h-6 ml-3" />
                                 </div>
                              </div>
                            </div>

                            <div className="grid grid-cols-2 lg:grid-cols-4 gap-12 pt-8 border-t border-white/5">
                               <div>
                                  <p className="text-[10px] text-slate-500 font-black italic tracking-widest mb-3">{t("investors.portfolio.total_value", "TOPLAM DEĞER")}</p>
                                  <p className="text-2xl font-black text-white italic tracking-tighter leading-none">£{p.totalValue.toLocaleString()}</p>
                               </div>
                               <div>
                                  <p className="text-[10px] text-slate-500 font-black italic tracking-widest mb-3">{t("investors.portfolio.net_equity", "NET ÖZKAYNAK")}</p>
                                  <p className="text-2xl font-black text-blue-400 italic tracking-tighter leading-none">£{p.totalEquity.toLocaleString()}</p>
                               </div>
                               <div>
                                  <p className="text-[10px] text-slate-500 font-black italic tracking-widest mb-3">{t("investors.portfolio.mortgage", "KULLANILAN KREDİ")}</p>
                                  <p className="text-2xl font-black text-slate-400 italic tracking-tighter leading-none">£{(p.totalValue - p.totalEquity).toLocaleString()}</p>
                               </div>
                               <div>
                                  <p className="text-[10px] text-slate-500 font-black italic tracking-widest mb-3">{t("investors.portfolio.properties", "AKTİF MÜLK SAYISI")}</p>
                                  <div className="flex items-center gap-4">
                                     <p className="text-2xl font-black text-white italic tracking-tighter leading-none">{p.propertyCount} {t("investors.portfolio.units", "Mülk")}</p>
                                     <div className="p-2 rounded-lg bg-blue-500/10 border border-blue-500/20 shadow-inner">
                                        <Building2 className="w-4 h-4 text-blue-400" />
                                     </div>
                                  </div>
                               </div>
                            </div>
                         </div>
                         
                         <div className="bg-black/20 p-8 border-l border-white/5 flex lg:flex-col justify-center gap-4 w-full lg:w-72 backdrop-blur-xl group-hover:bg-black/40 transition-colors">
                            <Button variant="outline" className="h-14 w-full border-white/10 bg-white/5 text-white font-black text-[10px] italic tracking-[0.2em] rounded-2xl px-6 shadow-xl hover:bg-white hover:text-black transition-all">{t("investors.portfolio.view_properties", "MÜLKLERİ İNCELE")}<ChevronRight className="w-4 h-4 ml-auto" />
                            </Button>
                            <Button variant="outline" className="h-14 w-full border-white/10 bg-white/5 text-slate-400 font-black text-[10px] italic tracking-[0.2em] rounded-2xl px-6 shadow-xl hover:text-white transition-all">{t("investors.portfolio.analytics", "PERFORMANS ANALİZİ")}</Button>
                            <Button variant="ghost" className="h-12 w-full font-black text-[10px] text-slate-600 hover:text-blue-400 italic tracking-widest">{t("investors.portfolio.details", "YATIRIM DETAYLARI")}</Button>
                         </div>
                      </div>
                    </CardContent>
                  </Card>
                </motion.div>)}
           </div>
        </div>

        {/* Investment Opportunities Banner */}
        <div className="relative rounded-[60px] overflow-hidden bg-gradient-to-br from-[#1a1b1e] to-black p-16 shadow-3xl border border-white/5 border-l border-t group">
           <div className="absolute top-0 right-0 p-20 opacity-5 group-hover:opacity-10 group-hover:scale-110 transition-all duration-1000">
              <BarChart3 className="w-[400px] h-[400px] text-white" />
           </div>
           
           <div className="relative z-10 max-w-3xl space-y-8">
              <Badge className="bg-blue-600/10 text-blue-400 border border-blue-600/20 px-6 py-2 font-black text-[10px] tracking-[0.3em] italic">{t("investors.portfolio.new_opportunities", "YENİ YATIRIM FIRSATLARI")}</Badge>
              <h2 className="text-5xl font-black text-white italic tracking-tighter leading-[0.9]">{t("investors.portfolio.discover", "Portföyünüze Değer Katacak Yeni Fırsatları Keşfedin")}</h2>
              <p className="text-slate-500 font-black italic tracking-widest text-sm leading-relaxed max-w-2xl">{t("investors.portfolio.discover_desc", "Sizin için analiz ettiğimiz, yüksek getiri potansiyelli yatırım fırsatlarını inceleyin. Ortalama beklenen getiri: ")}<span className="text-emerald-400 underline decoration-emerald-500/30">%8.4</span>.
              </p>
              <div className="flex flex-wrap gap-6 pt-6">
                 <Button className="h-16 px-12 bg-blue-600 text-white hover:bg-blue-500 rounded-2xl font-black text-[11px] tracking-widest italic shadow-xl transition-all group/btn">{t("investors.portfolio.view_opportunities", "FIRSATLARI İNCELE")}<ChevronRight className="w-4 h-4 ml-3 group-hover:translate-x-2 transition-transform" />
                 </Button>
                 <Button variant="outline" className="h-16 px-12 text-slate-400 border-white/10 bg-white/5 hover:bg-white/10 hover:text-white rounded-2xl font-black text-[11px] tracking-widest italic">{t("investors.portfolio.preferences", "TERCİHLERİ DÜZENLE")}</Button>
              </div>
           </div>
           
           <div className="absolute bottom-10 right-10 flex gap-6 opacity-40">
              <ShieldCheck className="w-8 h-8 text-slate-700" />
              <Globe className="w-8 h-8 text-slate-700" />
           </div>
        </div>
      </div>
    </PageShell>;
}