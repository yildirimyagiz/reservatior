import { useTranslation } from "react-i18next";
import { Card, CardHeader, CardTitle, CardDescription, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Search, Sparkles, Calculator, ChevronRight } from "lucide-react";
export function ValuationMarketInsight() {
  const {
    t
  } = useTranslation();
  return <Card className="border-none shadow-2xl bg-card overflow-hidden ring-1 ring-slate-100">
      <CardHeader className="bg-gradient-to-br from-slate-900 to-slate-800 text-white pb-8">
        <div className="flex items-center justify-between">
          <Badge variant="outline" className="text-brand border-brand/30 uppercase text-[10px] font-black tracking-widest bg-brand/10">{t("client.src.market_intelligence")}</Badge>
          <div className="flex -space-x-2">
             {[1, 2, 3].map(i => <div key={i} className="w-6 h-6 rounded-full border-2 border-border bg-muted flex items-center justify-center text-[8px] font-bold">{t("client.src.ui")}</div>)}
          </div>
        </div>
        <div className="mt-4">
          <CardTitle className="text-2xl font-black tracking-tight leading-tight">{t("client.src.property_valuation_ai")}</CardTitle>
          <CardDescription className="text-muted-foreground text-xs font-medium mt-1">{t("client.src.realtime_liquidity_and_asset")}</CardDescription>
        </div>
      </CardHeader>
      
      <CardContent className="p-6 -mt-4 bg-card rounded-t-3xl relative z-20 space-y-6">
        <div className="grid grid-cols-2 gap-4">
          <div className="p-4 rounded-2xl bg-muted border border-border">
            <p className="text-[10px] font-black text-muted-foreground uppercase">{t("client.src.estimated_value")}</p>
            <p className="text-xl font-black text-foreground mt-1">$485,000</p>
            <p className="text-[9px] text-success font-bold flex items-center gap-0.5 mt-0.5">
               <Sparkles className="w-2.5 h-2.5" />{t("client.src.42_yoy_growth")}</p>
          </div>
          <div className="p-4 rounded-2xl bg-muted border border-border">
            <p className="text-[10px] font-black text-muted-foreground uppercase">{t("client.src.liquidity_score")}</p>
            <p className="text-xl font-black text-foreground mt-1">{t("common.high")}</p>
            <p className="text-[9px] text-brand font-bold flex items-center gap-0.5 mt-0.5">
               <Search className="w-2.5 h-2.5" />{t("client.src.high_demand_in_nyc")}</p>
          </div>
        </div>

        <div className="space-y-3">
           <h4 className="text-[10px] font-black text-foreground uppercase tracking-widest">{t("client.src.platform_insights")}</h4>
           <div className="flex items-start gap-3 p-3 rounded-xl hover:bg-muted transition-colors group cursor-pointer border border-transparent hover:border-border">
              <div className="p-2 bg-brand/10 text-brand rounded-lg group-hover:bg-brand group-hover:text-white transition-all">
                 <Calculator className="w-4 h-4" />
              </div>
              <div className="flex-1">
                 <p className="font-black text-xs text-foreground group-hover:text-brand transition-colors">{t("client.src.yield_analysis")}</p>
                 <p className="text-[10px] text-muted-foreground leading-relaxed">{t("client.src.potential_annual_return_of")}</p>
              </div>
              <ChevronRight className="w-3 h-3 text-muted-foreground self-center" />
           </div>
        </div>

        <Button className="w-full h-12 bg-card text-white rounded-2xl font-black text-xs uppercase tracking-widest hover:bg-brand transition-all shadow-xl">{t("client.src.request_certified_audit")}</Button>
      </CardContent>
    </Card>;
}