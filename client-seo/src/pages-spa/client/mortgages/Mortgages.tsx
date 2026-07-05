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
  return <div className="p-6 space-y-6 bg-slate-50 min-h-screen text-slate-900 font-sans">
      <div className="flex justify-between items-center bg-white p-8 rounded-3xl shadow-sm border border-slate-200">
        <div className="flex items-center gap-6">
          <div className="p-4 bg-indigo-600 rounded-2xl shadow-xl shadow-indigo-600/10">
            <Landmark className="w-10 h-10 text-white" />
          </div>
          <div>
            <h1 className="text-4xl font-extrabold tracking-tight text-slate-950">{t("client.src.mortgage_hub")}</h1>
            <p className="text-slate-500 text-lg">{t("client.src.compare_rates_calculate_monthly")}</p>
          </div>
        </div>
        <div className="flex gap-4">
          <Button variant="outline" className="h-12 px-6 gap-2 rounded-xl border-slate-300 hover:bg-slate-50">
            <Calculator className="w-5 h-5" />{t("client.src.detailed_calculator")}</Button>
          <Button className="h-12 px-6 gap-2 rounded-xl bg-indigo-600 hover:bg-indigo-700 shadow-lg shadow-indigo-600/20">
            <FileCheck className="w-5 h-5" />{t("client.src.preapproval")}</Button>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-4 gap-6">
        <Card className="shadow-lg border-none bg-gradient-to-br from-indigo-600 to-indigo-800 text-white p-6 rounded-3xl lg:col-span-1">
          <CardHeader className="p-0 mb-6">
            <CardTitle className="text-white flex items-center gap-2">
              <TrendingUp className="w-5 h-5" />{t("client.src.market_trend")}</CardTitle>
          </CardHeader>
          <CardContent className="p-0">
            <div className="space-y-4">
              <div className="text-4xl font-bold">4.12%</div>
              <p className="text-indigo-100 text-sm">{t("client.src.average_30year_fixed_rate")}<span className="font-bold">0.15%</span>{t("client.src.this_week")}</p>
              <div className="pt-6 border-t border-indigo-500/30">
                <Button variant="secondary" className="w-full bg-white/20 hover:bg-white/30 border-none text-white gap-2 font-bold rounded-xl h-12">
                  <Clock className="w-4 h-4" />{t("client.src.watch_rates")}</Button>
              </div>
            </div>
          </CardContent>
        </Card>

        <div className="lg:col-span-3 grid grid-cols-1 md:grid-cols-2 gap-6">
          <Card className="rounded-3xl border-slate-200 shadow-xl shadow-slate-200/50">
            <CardHeader>
               <CardTitle className="flex items-center gap-2">
                  <Calculator className="w-5 h-5 text-indigo-600" />{t("client.src.quick_estimator")}</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
               <div className="flex gap-4">
                  <div className="flex-1 space-y-1">
                    <label className="text-xs font-bold text-slate-500 tracking-wider">{t("client.src.home_price")}</label>
                    <input type="text" defaultValue="$450,000" className="w-full bg-slate-100 border-none rounded-xl h-11 px-4 font-bold" />
                  </div>
                  <div className="flex-1 space-y-1">
                    <label className="text-xs font-bold text-slate-500 tracking-wider">{t("client.src.down_payment")}</label>
                    <input type="text" defaultValue="$90,000" className="w-full bg-slate-100 border-none rounded-xl h-11 px-4 font-bold" />
                  </div>
               </div>
               <div className="p-4 bg-indigo-50 rounded-2xl flex justify-between items-center">
                  <div>
                    <p className="text-xs text-indigo-600 font-bold">{t("client.src.estimated_monthly")}</p>
                    <h3 className="text-2xl font-black text-indigo-950">$2,415.50</h3>
                  </div>
                  <Button size="icon" className="bg-white text-indigo-600 hover:bg-white shadow-sm border border-indigo-100 rounded-xl">
                    <ArrowRight className="w-5 h-5" />
                  </Button>
               </div>
            </CardContent>
          </Card>

          <Card className="rounded-3xl border-slate-200 shadow-xl shadow-slate-200/50">
            <CardHeader>
               <CardTitle className="flex items-center gap-2">
                  <ShieldCheck className="w-5 h-5 text-emerald-600" />{t("client.src.eligibility_status")}</CardTitle>
            </CardHeader>
            <CardContent>
               <div className="flex items-center gap-4 mb-6">
                  <div className="w-16 h-16 rounded-full border-4 border-emerald-500 flex items-center justify-center text-xl font-bold text-slate-900">
                    780
                  </div>
                  <div>
                    <p className="text-sm font-bold text-slate-900">{t("client.src.credit_score_excellent")}</p>
                    <p className="text-xs text-slate-500">{t("client.src.last_updated_mar_24")}</p>
                  </div>
                  <Badge variant="outline" className="ml-auto bg-emerald-50 text-emerald-600 border-emerald-200 text-[10px] font-bold">{t("client.src.verified")}</Badge>
               </div>
               <div className="grid grid-cols-2 gap-3 text-xs">
                  <div className="p-3 bg-slate-50 rounded-xl border border-slate-100 flex items-center gap-2">
                    <History className="w-4 h-4 text-slate-400" />{t("client.src.0_late_payments")}</div>
                  <div className="p-3 bg-slate-50 rounded-xl border border-slate-100 flex items-center gap-2">
                    <CreditCard className="w-4 h-4 text-slate-400" />{t("client.src.22_dti_ratio")}</div>
               </div>
            </CardContent>
          </Card>
        </div>
      </div>

      <div className="space-y-4">
        <h2 className="text-2xl font-black text-slate-900 flex items-center gap-2">
           <Coins className="w-7 h-7 text-indigo-600" />{t("client.src.preferred_lending_partners")}</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          {offers.map((offer, i) => <Card key={i} className="rounded-3xl border-slate-200 hover:border-indigo-500 transition-all hover:shadow-2xl hover:shadow-indigo-500/10 group">
              <CardHeader className="pb-4">
                <div className="flex justify-between items-start mb-2">
                  <div className="w-12 h-12 bg-slate-100 rounded-xl flex items-center justify-center">
                    <Landmark className="w-6 h-6 text-slate-400 group-hover:text-indigo-600" />
                  </div>
                  <Badge className="bg-indigo-50 text-indigo-600 border-none font-bold text-[9px]">{t("client.src.best_value")}</Badge>
                </div>
                <CardTitle className="text-lg font-black group-hover:text-indigo-600">{offer.provider}</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="grid grid-cols-2 gap-4 border-y border-slate-100 py-4">
                  <div>
                    <p className="text-[10px] font-bold text-slate-400">{t("client.src.rate")}</p>
                    <p className="text-xl font-black text-indigo-950 flex items-center gap-1">
                      {offer.rate} <Percent className="w-3 h-3 text-indigo-400" />
                    </p>
                  </div>
                  <div>
                    <p className="text-[10px] font-bold text-slate-400">{t("client.src.term")}</p>
                    <p className="text-sm font-bold text-slate-900">{offer.term}</p>
                  </div>
                  <div>
                    <p className="text-[10px] font-bold text-slate-400">{t("client.src.type")}</p>
                    <p className="text-sm font-bold text-slate-900">{offer.type}</p>
                  </div>
                  <div>
                    <p className="text-[10px] font-bold text-slate-400">{t("client.src.max_ltv")}</p>
                    <p className="text-sm font-bold text-slate-900 font-mono">{offer.maxLtv}</p>
                  </div>
                </div>
                <Button className="w-full bg-slate-900 hover:bg-indigo-600 text-white rounded-xl h-11 font-bold group-hover:shadow-lg group-hover:shadow-indigo-600/30">{t("client.src.select_offer")}</Button>
                <p className="text-center text-[10px] text-slate-400 font-medium italic">{t("client.src.fees")}{offer.fee}</p>
              </CardContent>
            </Card>)}
        </div>
      </div>
    </div>;
}