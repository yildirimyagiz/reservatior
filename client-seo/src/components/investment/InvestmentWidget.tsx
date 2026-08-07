"use client";

import { useState } from "react";
import Link from "next/link";
import { TrendingUp, ArrowRight, Calculator, Globe, Percent, BarChart3, ShieldCheck } from "lucide-react";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { CITY_COMPARISONS } from "@/lib/seo/market-data";
import { useTranslation } from "react-i18next";

export function InvestmentWidget() {
  const { t } = useTranslation();
  const topCities = CITY_COMPARISONS.sort((a, b) => b.totalReturn - a.totalReturn).slice(0, 4);

  const getRiskLabel = (level: string) => {
    switch (level.toUpperCase()) {
      case "LOW":
        return t("investment.risk.low", { defaultValue: "Low Risk (Safe Portfolio)" });
      case "MEDIUM":
        return t("investment.risk.medium", { defaultValue: "Balanced Yield & Risk" });
      case "HIGH":
        return t("investment.risk.high", { defaultValue: "High Capital Growth Potential" });
      default:
        return level;
    }
  };

  return (
    <section className="py-16 px-4">
      <div className="max-w-6xl mx-auto">
        <div className="text-center mb-10">
          <Badge variant="outline" className="mb-3 px-4 py-1 font-bold tracking-wide border-primary/40 text-primary">
            {t("investment.badge", { defaultValue: "Investment Analytics & Financial Reporting" })}
          </Badge>
          <h2 className="text-3xl md:text-5xl font-extrabold tracking-tight mb-4">
            {t("investment.title_1", { defaultValue: "Data-Driven Real Estate" })}{" "}
            <span className="bg-gradient-to-r from-primary via-emerald-500 to-indigo-500 bg-clip-text text-transparent">
              {t("investment.title_2", { defaultValue: "Investment Decision Engine" })}
            </span>
          </h2>
          <p className="text-muted-foreground text-base md:text-lg max-w-2xl mx-auto leading-relaxed">
            {t("investment.subtitle", {
              defaultValue:
                "Free ROI and depreciation calculators, rental-yield comparisons, and AI-powered market trend analysis reports. Base your investment decisions on concrete property data, not assumptions.",
            })}
          </p>
        </div>

        {/* Top Markets */}
        <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-4 mb-10">
          {topCities.map((city) => (
            <Link key={city.city} href={`/en/invest/${city.city.toLowerCase()}/${city.city.toLowerCase()}-rental-yield-calculator`}>
              <Card className="hover:border-primary/60 transition-all duration-300 hover:shadow-xl cursor-pointer h-full group bg-card/90 backdrop-blur-md">
                <CardContent className="p-5 flex flex-col h-full justify-between">
                  <div>
                    <div className="flex items-center justify-between gap-2 mb-3">
                      <h3 className="font-extrabold text-lg tracking-tight">{city.city}</h3>
                      <Badge
                        className={`text-[10px] font-bold px-2 py-0.5 border text-center ${
                          city.riskLevel === "LOW"
                            ? "bg-emerald-500/15 text-emerald-400 border-emerald-500/30"
                            : city.riskLevel === "MEDIUM"
                            ? "bg-amber-500/15 text-amber-400 border-amber-500/30"
                            : "bg-indigo-500/15 text-indigo-400 border-indigo-500/30"
                        }`}
                      >
                        {getRiskLabel(city.riskLevel)}
                      </Badge>
                    </div>
                    <div className="grid grid-cols-2 gap-3 mb-4 pt-2 border-t border-border/60">
                      <div>
                        <p className="text-[11px] font-semibold text-muted-foreground uppercase tracking-wider mb-0.5">{t("investment.stats.annual_rental_yield", { defaultValue: "Annual Rental Yield" })}</p>
                        <p className="text-xl font-extrabold text-emerald-500">%{city.grossYield}</p>
                      </div>
                      <div>
                        <p className="text-[11px] font-semibold text-muted-foreground uppercase tracking-wider mb-0.5">{t("investment.stats.value_appreciation", { defaultValue: "Value Appreciation" })}</p>
                        <p className="text-xl font-extrabold text-primary">%{city.totalReturn}</p>
                      </div>
                    </div>
                  </div>
                  <div className="flex items-center gap-2 text-xs font-semibold text-muted-foreground pt-3 border-t border-border/40">
                    {city.residencyByInvestment && <span className="bg-muted px-2 py-0.5 rounded text-foreground">{t("investment.tags.citizenship", { defaultValue: "Citizenship / Residence" })}</span>}
                    {city.taxRate === 0 && <span className="bg-emerald-500/10 text-emerald-400 px-2 py-0.5 rounded border border-emerald-500/20">{t("investment.tags.tax_advantage", { defaultValue: "0% Tax Advantage" })}</span>}
                    <ArrowRight className="w-4 h-4 ml-auto group-hover:text-primary transition-transform group-hover:translate-x-1" />
                  </div>
                </CardContent>
              </Card>
            </Link>
          ))}
        </div>

        {/* Tool Cards */}
        <div className="grid md:grid-cols-3 gap-5 mb-12">
          {[
            {
              title: t("investment.tools.depreciation.title", { defaultValue: "Depreciation & Net Return Calculator" }),
              desc: t("investment.tools.depreciation.desc", { defaultValue: "Calculate your net payback period with mortgage payments, service fees, occupancy rate, and a 10-year capital appreciation projection." }),
              href: "/en/invest/dubai/property-investment-calculator",
              icon: Calculator,
            },
            {
              title: t("investment.tools.regional.title", { defaultValue: "Regional Rental Yield Benchmark" }),
              desc: t("investment.tools.regional.desc", { defaultValue: "Compare average rental income per m² across districts and neighborhoods with real-time market indices." }),
              href: "/en/invest/dubai/dubai-rental-yield-calculator",
              icon: Percent,
            },
            {
              title: t("investment.tools.global.title", { defaultValue: "Global Metropolis Investment Comparison" }),
              desc: t("investment.tools.global.desc", { defaultValue: "Compare tax advantages, residence permits, and capital gains rates across global markets like Istanbul, Dubai, Miami, and Lisbon." }),
              href: "/en/invest/dubai/dubai-vs-istanbul-investment-comparison",
              icon: Globe,
            },
          ].map((tool) => (
            <Link key={tool.href} href={tool.href}>
              <Card className="hover:border-primary/50 hover:bg-muted/30 transition-all h-full cursor-pointer group shadow-sm">
                <CardContent className="p-6">
                  <div className="w-12 h-12 rounded-2xl bg-primary/10 flex items-center justify-center mb-4 border border-primary/20 group-hover:scale-105 transition-transform">
                    <tool.icon className="w-6 h-6 text-primary" />
                  </div>
                  <h3 className="font-bold text-lg mb-2 text-foreground group-hover:text-primary transition-colors">{tool.title}</h3>
                  <p className="text-sm text-muted-foreground leading-relaxed">{tool.desc}</p>
                </CardContent>
              </Card>
            </Link>
          ))}
        </div>

        {/* CTA */}
        <div className="text-center">
          <Link href="/en/invest/dubai/property-investment-calculator">
            <Button size="lg" className="rounded-full px-8 py-6 font-bold text-base bg-gradient-to-r from-primary to-indigo-600 hover:opacity-95 transition-transform hover:scale-[1.02] shadow-lg shadow-primary/25">
              <span>{t("investment.cta_button", { defaultValue: "Start Data-Driven Investments" })}</span>
              <ArrowRight className="w-5 h-5 ml-2" />
            </Button>
          </Link>
        </div>
      </div>
    </section>
  );
}
