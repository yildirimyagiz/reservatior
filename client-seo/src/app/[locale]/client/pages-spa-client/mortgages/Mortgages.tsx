"use client";

import { useTranslation } from "react-i18next";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Landmark, Coins, Calculator, FileCheck, ArrowRight, Percent, ShieldCheck, Clock, History, TrendingUp, CreditCard } from "lucide-react";
export default function Mortgages() {
  const {
    t
  } = useTranslation();
  const offers = [{
    provider: "Global Bank",
    rate: "4.2%",
    term: "30 Years",
    type: "Fixed",
    maxLtv: "85%",
    fee: "$995"
  }, {
    provider: "Trust Finance",
    rate: "3.8%",
    term: "15 Years",
    type: "Fixed",
    maxLtv: "80%",
    fee: "$1,450"
  }, {
    provider: "Metro Lending",
    rate: "4.5%",
    term: "30 Years",
    type: "Variable",
    maxLtv: "90%",
    fee: "$0"
  }, {
    provider: "Summit Mortgages",
    rate: "4.15%",
    term: "25 Years",
    type: "Fixed",
    maxLtv: "85%",
    fee: "$500"
  }];
  return <div className="p-6 space-y-6 bg-muted min-h-screen text-foreground font-sans">
      <div className="flex justify-between items-center bg-card p-8 rounded-3xl shadow-sm border border-border">
        <div className="flex items-center gap-6">
          <div className="p-4 bg-brand rounded-2xl shadow-xl shadow-indigo-600/10">
            <Landmark className="w-10 h-10 text-white" />
          </div>
          <div>
            <h1 className="text-4xl font-extrabold tracking-tight text-muted-foreground">{t("client.src.mortgage_hub")}</h1>
            <p className="text-muted-foreground text-lg">{t("client.src.compare_rates_calculate_monthly")}</p>
          </div>
        </div>
        <div className="flex gap-4">
          <Button variant="outline" className="h-12 px-6 gap-2 rounded-xl border-slate-300 hover:bg-muted">
            <Calculator className="w-5 h-5" />{t("client.src.detailed_calculator")}</Button>
          <Button className="h-12 px-6 gap-2 rounded-xl bg-brand hover:bg-brand shadow-lg shadow-indigo-600/20">
            <FileCheck className="w-5 h-5" />{t("client.src.preapproval")}</Button>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-4 gap-6">
        <Card className="shadow-lg border-none bg-gradient-to-br from-brand to-info text-white p-6 rounded-3xl lg:col-span-1">
          <CardHeader className="p-0 mb-6">
            <CardTitle className="text-white flex items-center gap-2">
              <TrendingUp className="w-5 h-5" />{t("client.src.market_trend")}</CardTitle>
          </CardHeader>
          <CardContent className="p-0">
            <div className="space-y-4">
              <div className="text-4xl font-bold">4.12%</div>
              <p className="text-brand text-sm">{t("client.src.average_30year_fixed_rate")}<span className="font-bold">0.15%</span>{t("client.src.this_week")}</p>
              <div className="pt-6 border-t border-brand/30">
                <Button variant="secondary" className="w-full bg-white/20 hover:bg-white/30 border-none text-white gap-2 font-bold rounded-xl h-12">
                  <Clock className="w-4 h-4" />{t("client.src.watch_rates")}</Button>
              </div>
            </div>
          </CardContent>
        </Card>

        <div className="lg:col-span-3 grid grid-cols-1 md:grid-cols-2 gap-6">
          <Card className="rounded-3xl border-border shadow-xl shadow-slate-200/50">
            <CardHeader>
               <CardTitle className="flex items-center gap-2">
                  <Calculator className="w-5 h-5 text-brand" />{t("client.src.quick_estimator")}</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
               <div className="flex gap-4">
                  <div className="flex-1 space-y-1">
                    <label className="text-xs font-bold text-muted-foreground tracking-wider">{t("client.src.home_price")}</label>
                    <input type="text" aria-label="Home Price" defaultValue="$450,000" className="w-full bg-muted border-none rounded-xl h-11 px-4 font-bold" />
                  </div>
                  <div className="flex-1 space-y-1">
                    <label className="text-xs font-bold text-muted-foreground tracking-wider">{t("client.src.down_payment")}</label>
                    <input type="text" aria-label="Down Payment" defaultValue="$90,000" className="w-full bg-muted border-none rounded-xl h-11 px-4 font-bold" />
                  </div>
               </div>
               <div className="p-4 bg-brand/10 rounded-2xl flex justify-between items-center">
                  <div>
                    <p className="text-xs text-brand font-bold">{t("client.src.estimated_monthly")}</p>
                    <h2 className="text-2xl font-black text-brand">$2,415.50</h2>
                  </div>
                  <Button size="icon" aria-label={t("common.next")} className="bg-card text-brand hover:bg-card shadow-sm border border-brand/30 rounded-xl">
                    <ArrowRight className="w-5 h-5" />
                  </Button>
               </div>
            </CardContent>
          </Card>

          <Card className="rounded-3xl border-border shadow-xl shadow-slate-200/50">
            <CardHeader>
               <CardTitle className="flex items-center gap-2">
                  <ShieldCheck className="w-5 h-5 text-success" />{t("client.src.eligibility_status")}</CardTitle>
            </CardHeader>
            <CardContent>
               <div className="flex items-center gap-4 mb-6">
                  <div className="w-16 h-16 rounded-full border-4 border-blue-500 flex items-center justify-center text-xl font-bold text-foreground">
                    780
                  </div>
                  <div>
                    <p className="text-sm font-bold text-foreground">{t("client.src.credit_score_excellent")}</p>
                    <p className="text-xs text-muted-foreground">{t("client.src.last_updated_mar_24")}</p>
                  </div>
                  <Badge variant="outline" className="ml-auto bg-blue-50 text-success border-blue-200 text-[10px] font-bold">{t("client.src.verified")}</Badge>
               </div>
               <div className="grid grid-cols-2 gap-3 text-xs">
                  <div className="p-3 bg-muted rounded-xl border border-border flex items-center gap-2">
                    <History className="w-4 h-4 text-muted-foreground" />{t("client.src.0_late_payments")}</div>
                  <div className="p-3 bg-muted rounded-xl border border-border flex items-center gap-2">
                    <CreditCard className="w-4 h-4 text-muted-foreground" />{t("client.src.22_dti_ratio")}</div>
               </div>
            </CardContent>
          </Card>
        </div>
      </div>

      <div className="space-y-4">
        <h2 className="text-2xl font-black text-foreground flex items-center gap-2">
           <Coins className="w-7 h-7 text-brand" />{t("client.src.preferred_lending_partners")}</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          {offers.map((offer, i) => <Card key={i} className="rounded-3xl border-border hover:border-brand/30 transition-all hover:shadow-2xl hover:shadow-indigo-500/10 group">
              <CardHeader className="pb-4">
                <div className="flex justify-between items-start mb-2">
                  <div className="w-12 h-12 bg-muted rounded-xl flex items-center justify-center">
                    <Landmark className="w-6 h-6 text-muted-foreground group-hover:text-brand" />
                  </div>
                  <Badge className="bg-brand/10 text-brand border-none font-bold text-[9px]">{t("client.src.best_value")}</Badge>
                </div>
                <CardTitle className="text-lg font-black group-hover:text-brand">{offer.provider}</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="grid grid-cols-2 gap-4 border-y border-border py-4">
                  <div>
                    <p className="text-[10px] font-bold text-muted-foreground">{t("client.src.rate")}</p>
                    <p className="text-xl font-black text-brand flex items-center gap-1">
                      {offer.rate} <Percent className="w-3 h-3 text-brand" />
                    </p>
                  </div>
                  <div>
                    <p className="text-[10px] font-bold text-muted-foreground">{t("client.src.term")}</p>
                    <p className="text-sm font-bold text-foreground">{offer.term}</p>
                  </div>
                  <div>
                    <p className="text-[10px] font-bold text-muted-foreground">{t("common.type")}</p>
                    <p className="text-sm font-bold text-foreground">{offer.type}</p>
                  </div>
                  <div>
                    <p className="text-[10px] font-bold text-muted-foreground">{t("client.src.max_ltv")}</p>
                    <p className="text-sm font-bold text-foreground font-mono">{offer.maxLtv}</p>
                  </div>
                </div>
                <Button className="w-full bg-card hover:bg-brand text-white rounded-xl h-11 font-bold group-hover:shadow-lg group-hover:shadow-indigo-600/30">{t("client.src.select_offer")}</Button>
                <p className="text-center text-[10px] text-muted-foreground font-medium italic">{t("client.src.fees")}{offer.fee}</p>
              </CardContent>
            </Card>)}
        </div>
      </div>
    </div>;
}