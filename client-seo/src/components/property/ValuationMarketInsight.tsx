import { useTranslation } from "react-i18next";
import { Card, CardHeader, CardTitle, CardDescription, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Search, Sparkles, Calculator, ChevronRight } from "lucide-react";
export function ValuationMarketInsight() {
  const {
    t
  } = useTranslation();
  return <Card className="border-none shadow-2xl bg-white overflow-hidden ring-1 ring-slate-100">
      <CardHeader className="bg-gradient-to-br from-slate-900 to-slate-800 text-white pb-8">
        <div className="flex items-center justify-between">
          <Badge variant="outline" className="text-indigo-400 border-indigo-400/30 uppercase text-[10px] font-black tracking-widest bg-indigo-500/10">{t("client.src.market_intelligence")}</Badge>
          <div className="flex -space-x-2">
             {[1, 2, 3].map(i => <div key={i} className="w-6 h-6 rounded-full border-2 border-slate-800 bg-slate-700 flex items-center justify-center text-[8px] font-bold">{t("client.src.ui")}</div>)}
          </div>
        </div>
        <div className="mt-4">
          <CardTitle className="text-2xl font-black tracking-tight leading-tight">{t("client.src.property_valuation_ai")}</CardTitle>
          <CardDescription className="text-slate-400 text-xs font-medium mt-1">{t("client.src.realtime_liquidity_and_asset")}</CardDescription>
        </div>
      </CardHeader>
      
      <CardContent className="p-6 -mt-4 bg-white rounded-t-3xl relative z-20 space-y-6">
        <div className="grid grid-cols-2 gap-4">
          <div className="p-4 rounded-2xl bg-slate-50 border border-slate-100">
            <p className="text-[10px] font-black text-slate-500 uppercase">{t("client.src.estimated_value")}</p>
            <p className="text-xl font-black text-slate-900 mt-1">$485,000</p>
            <p className="text-[9px] text-emerald-600 font-bold flex items-center gap-0.5 mt-0.5">
               <Sparkles className="w-2.5 h-2.5" />{t("client.src.42_yoy_growth")}</p>
          </div>
          <div className="p-4 rounded-2xl bg-slate-50 border border-slate-100">
            <p className="text-[10px] font-black text-slate-500 uppercase">{t("client.src.liquidity_score")}</p>
            <p className="text-xl font-black text-slate-900 mt-1">{t("client.src.high")}</p>
            <p className="text-[9px] text-indigo-600 font-bold flex items-center gap-0.5 mt-0.5">
               <Search className="w-2.5 h-2.5" />{t("client.src.high_demand_in_nyc")}</p>
          </div>
        </div>

        <div className="space-y-3">
           <h4 className="text-[10px] font-black text-slate-900 uppercase tracking-widest">{t("client.src.platform_insights")}</h4>
           <div className="flex items-start gap-3 p-3 rounded-xl hover:bg-slate-50 transition-colors group cursor-pointer border border-transparent hover:border-slate-100">
              <div className="p-2 bg-indigo-50 text-indigo-600 rounded-lg group-hover:bg-indigo-600 group-hover:text-white transition-all">
                 <Calculator className="w-4 h-4" />
              </div>
              <div className="flex-1">
                 <p className="font-black text-xs text-slate-900 group-hover:text-indigo-600 transition-colors">{t("client.src.yield_analysis")}</p>
                 <p className="text-[10px] text-slate-500 leading-relaxed">{t("client.src.potential_annual_return_of")}</p>
              </div>
              <ChevronRight className="w-3 h-3 text-slate-300 self-center" />
           </div>
        </div>

        <Button className="w-full h-12 bg-slate-900 text-white rounded-2xl font-black text-xs uppercase tracking-widest hover:bg-indigo-600 transition-all shadow-xl">{t("client.src.request_certified_audit")}</Button>
      </CardContent>
    </Card>;
}