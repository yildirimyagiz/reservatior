"use client";

import { useState } from "react";
import Link from "next/link";
import { TrendingUp, ArrowRight, Calculator, Globe, Percent, BarChart3 } from "lucide-react";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { CITY_COMPARISONS } from "@/lib/seo/market-data";

export function InvestmentWidget() {
  const topCities = CITY_COMPARISONS.sort((a, b) => b.totalReturn - a.totalReturn).slice(0, 4);

  return (
    <section className="py-16 px-4">
      <div className="max-w-6xl mx-auto">
        <div className="text-center mb-10">
          <Badge variant="outline" className="mb-3">Investment Intelligence</Badge>
          <h2 className="text-3xl md:text-4xl font-bold mb-3">
            Real Estate Investment <span className="text-gradient">Made Intelligent</span>
          </h2>
          <p className="text-muted-foreground max-w-2xl mx-auto">
            Free ROI calculators, rental yield analysis, and AI-powered investment reports.
            Make data-driven property decisions before you invest.
          </p>
        </div>

        {/* Top Markets */}
        <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-4 mb-10">
          {topCities.map((city) => (
            <Link key={city.city} href={`/en/invest/${city.city.toLowerCase()}/${city.city.toLowerCase()}-rental-yield-calculator`}>
              <Card className="hover:border-primary/50 transition-all hover:shadow-lg cursor-pointer h-full group">
                <CardContent className="p-5">
                  <div className="flex items-center justify-between mb-3">
                    <h3 className="font-bold text-lg">{city.city}</h3>
                    <Badge
                      className={
                        city.riskLevel === "LOW"
                          ? "bg-emerald-500/20 text-emerald-400"
                          : city.riskLevel === "MEDIUM"
                          ? "bg-yellow-500/20 text-yellow-400"
                          : "bg-red-500/20 text-red-400"
                      }
                    >
                      {city.riskLevel}
                    </Badge>
                  </div>
                  <div className="grid grid-cols-2 gap-3 mb-3">
                    <div>
                      <p className="text-xs text-muted-foreground">Yield</p>
                      <p className="text-xl font-bold text-emerald-400">{city.grossYield}%</p>
                    </div>
                    <div>
                      <p className="text-xs text-muted-foreground">Total Return</p>
                      <p className="text-xl font-bold text-primary">{city.totalReturn}%</p>
                    </div>
                  </div>
                  <div className="flex items-center gap-2 text-xs text-muted-foreground">
                    {city.residencyByInvestment && <span>Residency</span>}
                    {city.taxRate === 0 && <span>0% Tax</span>}
                    <ArrowRight className="w-3 h-3 ml-auto group-hover:text-primary transition-colors" />
                  </div>
                </CardContent>
              </Card>
            </Link>
          ))}
        </div>

        {/* Tool Cards */}
        <div className="grid md:grid-cols-3 gap-4 mb-10">
          {[
            {
              title: "ROI Calculator",
              desc: "Calculate property returns with mortgage, vacancy, and 10-year projections",
              href: "/en/invest/dubai/property-investment-calculator",
              icon: Calculator,
            },
            {
              title: "Rental Yield Analysis",
              desc: "Compare yields across districts with real market benchmarks",
              href: "/en/invest/dubai/dubai-rental-yield-calculator",
              icon: Percent,
            },
            {
              title: "City Comparison",
              desc: "Compare investment metrics across global cities",
              href: "/en/invest/dubai/dubai-vs-istanbul-investment-comparison",
              icon: Globe,
            },
          ].map((tool) => (
            <Link key={tool.href} href={tool.href}>
              <Card className="hover:border-primary/50 transition-colors h-full cursor-pointer group">
                <CardContent className="p-5">
                  <tool.icon className="w-8 h-8 text-primary mb-3" />
                  <h3 className="font-bold text-lg mb-1">{tool.title}</h3>
                  <p className="text-sm text-muted-foreground">{tool.desc}</p>
                </CardContent>
              </Card>
            </Link>
          ))}
        </div>

        {/* CTA */}
        <div className="text-center">
          <Link href="/en/invest/dubai/property-investment-calculator">
            <Button size="lg">
              Start Investing Smarter
              <ArrowRight className="w-4 h-4 ml-2" />
            </Button>
          </Link>
        </div>
      </div>
    </section>
  );
}
