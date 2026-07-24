"use client";

import { useState, useEffect } from "react";
import { Link } from "@/lib/react-router-shim";
import {
  Calculator,
  TrendingUp,
  ArrowRight,
  ChevronDown,
  ChevronUp,
  Star,
  Shield,
  MapPin,
  BarChart3,
  Globe,
  CheckCircle,
} from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { ROICalculator } from "@/components/investment/ROICalculator";
import { RentalYieldCalculator } from "@/components/investment/RentalYieldCalculator";
import { CityComparisonEngine } from "@/components/investment/CityComparison";
import { LeadCapture } from "@/components/investment/LeadCapture";
import { FAQPageSchema } from "@/components/seo/SchemaScript";
import type { MarketData } from "@/types/investment-intelligence";

interface SEOLandingPageClientProps {
  config: {
    slug: string;
    city: string;
    title: string;
    description: string;
    keywords: string[];
    h1: string;
    calculatorType: "roi" | "yield" | "comparison";
    faq: Array<{ question: string; answer: string }>;
  };
  cityData?: MarketData;
  citySlug: string;
}

export function SEOLandingPageClient({
  config,
  cityData,
  citySlug,
}: SEOLandingPageClientProps) {
  const [showFAQ, setShowFAQ] = useState<number | null>(null);

  return (
    <>
      <FAQPageSchema questions={config.faq} />

      <div className="min-h-screen bg-background">
        {/* Hero Section */}
        <section className="relative py-16 px-4">
          <div className="max-w-4xl mx-auto text-center">
            <Badge variant="outline" className="mb-4">
              Free Investment Tool · No Registration Required
            </Badge>
            <h1 className="text-4xl md:text-5xl font-bold mb-4 tracking-tight">
              {config.h1}
            </h1>
            <p className="text-lg text-muted-foreground max-w-2xl mx-auto mb-8">
              {config.description}
            </p>

            {/* Trust Signals */}
            <div className="flex flex-wrap justify-center gap-4 mb-8">
              {[
                { icon: Shield, text: "Bank-Grade Calculations" },
                { icon: TrendingUp, text: "Real Market Data" },
                { icon: Star, text: "Free Forever" },
              ].map((item) => (
                <div key={item.text} className="flex items-center gap-1.5 text-sm text-muted-foreground">
                  <item.icon className="w-4 h-4 text-primary" />
                  {item.text}
                </div>
              ))}
            </div>

            {/* Quick Stats */}
            {cityData && (
              <div className="flex flex-wrap justify-center gap-6">
                {[
                  { label: "Avg Gross Yield", value: `${cityData.grossYield}%` },
                  { label: "Avg Net Yield", value: `${cityData.netYield}%` },
                  { label: "Appreciation", value: `${cityData.annualAppreciation}%` },
                  { label: "Vacancy Rate", value: `${cityData.vacancyRate}%` },
                ].map((stat) => (
                  <div key={stat.label} className="text-center">
                    <p className="text-2xl font-bold text-primary">{stat.value}</p>
                    <p className="text-xs text-muted-foreground">{stat.label}</p>
                  </div>
                ))}
              </div>
            )}
          </div>
        </section>

        {/* Calculator Section */}
        <section className="px-4 pb-16" id="calculator">
          {config.calculatorType === "roi" && (
            <ROICalculator
              initialCity={config.city}
              showLeadCapture={true}
              showReportCTA={true}
            />
          )}
          {config.calculatorType === "yield" && (
            <RentalYieldCalculator initialCity={config.city} />
          )}
          {config.calculatorType === "comparison" && <CityComparisonEngine />}
        </section>

        {/* District Data Table */}
        {cityData && cityData.districts.length > 0 && config.calculatorType !== "comparison" && (
          <section className="px-4 pb-16">
            <div className="max-w-6xl mx-auto">
              <h2 className="text-2xl font-bold mb-6 text-center">
                {cityData.city} District Investment Analysis
              </h2>
              <Card>
                <CardContent className="p-0 overflow-x-auto">
                  <table className="w-full text-sm">
                    <thead>
                      <tr className="border-b bg-muted/50">
                        <th className="text-left py-3 px-4">District</th>
                        <th className="text-right py-3 px-4">Avg Price/m²</th>
                        <th className="text-right py-3 px-4">Avg Rent/mo</th>
                        <th className="text-right py-3 px-4">Gross Yield</th>
                        <th className="text-right py-3 px-4">Appreciation</th>
                        <th className="text-right py-3 px-4">Grade</th>
                      </tr>
                    </thead>
                    <tbody>
                      {cityData.districts
                        .sort((a, b) => b.grossYield - a.grossYield)
                        .map((d) => (
                          <tr
                            key={d.name}
                            className="border-b border-border/50 hover:bg-muted/30"
                          >
                            <td className="py-3 px-4 font-medium">
                              <span className="flex items-center gap-1.5">
                                <MapPin className="w-3.5 h-3.5 text-primary" />
                                {d.name}
                              </span>
                            </td>
                            <td className="text-right py-3 px-4">
                              {cityData.currency} {d.avgPricePerSqm.toLocaleString()}
                            </td>
                            <td className="text-right py-3 px-4">
                              {cityData.currency} {d.avgMonthlyRent.toLocaleString()}
                            </td>
                            <td className="text-right py-3 px-4 text-emerald-400 font-medium">
                              {d.grossYield}%
                            </td>
                            <td className="text-right py-3 px-4">{d.appreciation}%</td>
                            <td className="text-right py-3 px-4">
                              <Badge variant="outline">{d.investmentGrade}</Badge>
                            </td>
                          </tr>
                        ))}
                    </tbody>
                  </table>
                </CardContent>
              </Card>
            </div>
          </section>
        )}

        {/* Internal Links / Related Tools */}
        <section className="px-4 pb-16">
          <div className="max-w-6xl mx-auto">
            <h2 className="text-2xl font-bold mb-6 text-center">Investment Tools & Calculators</h2>
            <div className="grid md:grid-cols-3 gap-4">
              {[
                { href: "/invest/dubai/property-investment-calculator", label: "Property Investment Calculator", desc: "Universal ROI & yield analysis" },
                { href: "/invest/dubai/dubai-rental-yield-calculator", label: "Dubai Rental Yield", desc: "District-level yield data" },
                { href: "/invest/dubai/dubai-property-roi-calculator", label: "Dubai ROI Calculator", desc: "Full ROI with projections" },
                { href: "/invest/istanbul/istanbul-property-roi-calculator", label: "Istanbul ROI Calculator", desc: "Turkish investment analysis" },
                { href: "/invest/dubai/dubai-vs-istanbul-investment-comparison", label: "Dubai vs Istanbul", desc: "Side-by-side city comparison" },
                { href: "/invest/dubai/mortgage-vs-cash-purchase-calculator", label: "Mortgage vs Cash", desc: "Financing strategy analysis" },
                { href: "/invest/dubai/rental-income-calculator", label: "Rental Income Calculator", desc: "Income projections" },
                { href: "/invest/dubai/real-estate-cash-flow-calculator", label: "Cash Flow Calculator", desc: "Cash flow analysis" },
                { href: "/invest/dubai/property-appreciation-calculator", label: "Appreciation Calculator", desc: "Future value forecasting" },
              ].map((link) => (
                <Link key={link.href} to={link.href}>
                  <Card className="hover:border-primary/50 transition-colors h-full">
                    <CardContent className="p-4 flex items-center justify-between">
                      <div>
                        <p className="font-medium text-sm">{link.label}</p>
                        <p className="text-xs text-muted-foreground">{link.desc}</p>
                      </div>
                      <ArrowRight className="w-4 h-4 text-primary shrink-0" />
                    </CardContent>
                  </Card>
                </Link>
              ))}
            </div>
          </div>
        </section>

        {/* FAQ Section */}
        {config.faq.length > 0 && (
          <section className="px-4 pb-16">
            <div className="max-w-3xl mx-auto">
              <h2 className="text-2xl font-bold mb-6 text-center">
                Frequently Asked Questions
              </h2>
              <div className="space-y-3">
                {config.faq.map((item, i) => (
                  <Card key={i}>
                    <button
                      className="w-full text-left p-4 flex items-center justify-between"
                      onClick={() => setShowFAQ(showFAQ === i ? null : i)}
                    >
                      <span className="font-medium pr-4">{item.question}</span>
                      {showFAQ === i ? (
                        <ChevronUp className="w-5 h-5 shrink-0 text-muted-foreground" />
                      ) : (
                        <ChevronDown className="w-5 h-5 shrink-0 text-muted-foreground" />
                      )}
                    </button>
                    {showFAQ === i && (
                      <div className="px-4 pb-4 text-muted-foreground text-sm leading-relaxed">
                        {item.answer}
                      </div>
                    )}
                  </Card>
                ))}
              </div>
            </div>
          </section>
        )}

        {/* CTA Section */}
        <section className="px-4 pb-16">
          <div className="max-w-4xl mx-auto">
            <Card className="border-primary/30 bg-primary/5">
              <CardContent className="p-8 text-center">
                <h2 className="text-2xl font-bold mb-3">
                  Ready to Make Smarter Property Investments?
                </h2>
                <p className="text-muted-foreground mb-6 max-w-xl mx-auto">
                  Join thousands of investors using Reservatior's AI-powered intelligence
                  to make data-driven property decisions.
                </p>
                <div className="flex flex-col sm:flex-row gap-3 justify-center">
                  <Link to="/signup">
                    <Button size="lg">
                      Create Free Account
                      <ArrowRight className="w-4 h-4 ml-2" />
                    </Button>
                  </Link>
                  <Link to="/ai-search">
                    <Button variant="outline" size="lg">
                      <Globe className="w-4 h-4 mr-2" />
                      Explore Properties
                    </Button>
                  </Link>
                </div>
              </CardContent>
            </Card>
          </div>
        </section>
      </div>
    </>
  );
}
