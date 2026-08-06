"use client";

import { useState } from "react";
import Link from "next/link";
import {
  MapPin, TrendingUp, Percent, Building2, Star, ArrowRight,
  BarChart3, Calculator, Shield, ChevronDown, ChevronUp,
} from "lucide-react";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { ROICalculator } from "@/components/investment/ROICalculator";
import { LeadCapture } from "@/components/investment/LeadCapture";
import type { MarketData, DistrictData } from "@/types/investment-intelligence";

interface Props {
  city: MarketData;
  district: DistrictData;
  districtSlug: string;
}

const DISTRICT_FAQ: Record<string, Array<{ question: string; answer: string }>> = {
  default: [
    { question: "What is the average rental yield in this area?", answer: "Rental yields vary by property type and size. The area averages around 7-8% gross yield, which is above the market average for most global cities." },
    { question: "Is this a good area for property investment?", answer: "This area scores well for investment with strong rental demand, good infrastructure, and consistent appreciation. It's suitable for both cash-flow and appreciation-focused investors." },
    { question: "What is the minimum investment needed?", answer: "Entry-level properties start from approximately $150,000-$300,000 depending on the property type. Studios and 1-bedroom apartments offer the lowest entry point with attractive yields." },
    { question: "How does this area compare to other districts?", answer: "This area consistently ranks among top investment locations with above-average yields and strong tenant demand. Use our comparison tools to see how it stacks up against other districts." },
  ],
};

export function DistrictLandingPageClient({ city, district, districtSlug }: Props) {
  const [showCalculator, setShowCalculator] = useState(false);
  const faqs = DISTRICT_FAQ.default;

  const schemaData = {
    "@context": "https://schema.org",
    "@type": "WebPage",
    name: `${district.name} ${city.city} Property Investment`,
    description: `Investment analysis for ${district.name}, ${city.city}. Yield: ${district.grossYield}%, Appreciation: ${district.appreciation}%`,
    url: `https://reservatior.com/en/invest/${city.city.toLowerCase()}/${districtSlug}`,
    mainEntity: {
      "@type": "FAQPage",
      mainEntity: faqs.map((f) => ({
        "@type": "Question",
        name: f.question,
        acceptedAnswer: { "@type": "Answer", text: f.answer },
      })),
    },
  };

  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(schemaData) }} />
      <div className="min-h-screen bg-background">
        <section className="relative py-12 px-4">
          <div className="max-w-4xl mx-auto">
            <div className="flex items-center gap-2 text-sm text-muted-foreground mb-4">
              <Link href="/" className="hover:text-foreground">Home</Link>
              <span>/</span>
              <Link href={`/invest/${city.city.toLowerCase()}`} className="hover:text-foreground">{city.city}</Link>
              <span>/</span>
              <span className="text-foreground">{district.name}</span>
            </div>
            <div className="flex items-center gap-3 mb-2">
              <Badge className="bg-primary/20 text-primary">{district.investmentGrade}</Badge>
              <Badge variant="outline">{city.country}</Badge>
            </div>
            <h1 className="text-4xl md:text-5xl font-bold mb-3 tracking-tight">
              {district.name} <span className="text-primary">Property Investment</span>
            </h1>
            <p className="text-lg text-muted-foreground max-w-2xl mb-8">
              Investment-grade analysis for {district.name}, {city.city}. Rental yields, capital appreciation, and ROI projections with our free calculator.
            </p>
            <div className="grid grid-cols-2 md:grid-cols-5 gap-4">
              {[
                { label: "Gross Yield", value: `${district.grossYield}%`, icon: Percent, color: "text-blue-400" },
                { label: "Appreciation", value: `${district.appreciation}%`, icon: TrendingUp, color: "text-blue-400" },
                { label: "Price/m²", value: `${city.currency} ${district.avgPricePerSqm.toLocaleString()}`, icon: Building2, color: "text-primary" },
                { label: "Avg Rent/mo", value: `${city.currency} ${district.avgMonthlyRent.toLocaleString()}`, icon: BarChart3, color: "text-yellow-400" },
                { label: "Walkability", value: `${district.walkabilityScore}/100`, icon: MapPin, color: "text-primary" },
              ].map((stat) => (
                <Card key={stat.label}>
                  <CardContent className="p-4 text-center">
                    <stat.icon className={`w-5 h-5 mx-auto mb-1 ${stat.color}`} />
                    <p className="text-lg font-bold">{stat.value}</p>
                    <p className="text-xs text-muted-foreground">{stat.label}</p>
                  </CardContent>
                </Card>
              ))}
            </div>
          </div>
        </section>
        <section className="px-4 pb-12">
          <div className="max-w-6xl mx-auto">
            <Button onClick={() => setShowCalculator(!showCalculator)} size="lg" className="mb-6">
              <Calculator className="w-5 h-5 mr-2" />
              {showCalculator ? "Hide Calculator" : "Calculate ROI for " + district.name}
              {showCalculator ? <ChevronUp className="w-4 h-4 ml-2" /> : <ChevronDown className="w-4 h-4 ml-2" />}
            </Button>
            {showCalculator && (
              <ROICalculator initialCity={city.city.toLowerCase()} embedded={true} showLeadCapture={true} showReportCTA={true} />
            )}
          </div>
        </section>
        <section className="px-4 pb-12">
          <div className="max-w-6xl mx-auto">
            <h2 className="text-2xl font-bold mb-6">{city.city} District Comparison</h2>
            <Card>
              <CardContent className="p-0 overflow-x-auto">
                <table className="w-full text-sm">
                  <thead>
                    <tr className="border-b bg-muted/50">
                      <th className="text-left py-3 px-4">District</th>
                      <th className="text-right py-3 px-4">Yield</th>
                      <th className="text-right py-3 px-4">Appreciation</th>
                      <th className="text-right py-3 px-4">Walkability</th>
                      <th className="text-right py-3 px-4">Grade</th>
                    </tr>
                  </thead>
                  <tbody>
                    {city.districts.sort((a, b) => b.grossYield - a.grossYield).map((d) => (
                      <tr key={d.name} className={`border-b border-border/50 hover:bg-muted/30 ${d.name === district.name ? "bg-primary/10 font-medium" : ""}`}>
                        <td className="py-3 px-4">
                          <span className="flex items-center gap-1.5">
                            <MapPin className="w-3.5 h-3.5 text-primary" />
                            {d.name}
                            {d.name === district.name && <Badge className="ml-1 text-xs" variant="outline">Current</Badge>}
                          </span>
                        </td>
                        <td className="text-right py-3 px-4 text-blue-400">{d.grossYield}%</td>
                        <td className="text-right py-3 px-4">{d.appreciation}%</td>
                        <td className="text-right py-3 px-4">{d.walkabilityScore}/100</td>
                        <td className="text-right py-3 px-4"><Badge variant="outline">{d.investmentGrade}</Badge></td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </CardContent>
            </Card>
          </div>
        </section>
        <section className="px-4 pb-12">
          <div className="max-w-6xl mx-auto">
            <h2 className="text-2xl font-bold mb-6">Investment Analysis by District</h2>
            <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-4">
              {city.districts.slice(0, 6).map((d) => {
                const dSlug = d.name.toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/-+$/, "");
                return (
                  <Link key={d.name} href={`/invest/${city.city.toLowerCase()}/${dSlug}`}>
                    <Card className="hover:border-primary/50 transition-colors h-full">
                      <CardContent className="p-4">
                        <div className="flex items-center justify-between mb-2">
                          <h3 className="font-bold">{d.name}</h3>
                          <Badge variant="outline">{d.investmentGrade}</Badge>
                        </div>
                        <div className="grid grid-cols-2 gap-2 text-sm">
                          <div><p className="text-muted-foreground">Yield</p><p className="font-bold text-blue-400">{d.grossYield}%</p></div>
                          <div><p className="text-muted-foreground">Appreciation</p><p className="font-bold">{d.appreciation}%</p></div>
                        </div>
                      </CardContent>
                    </Card>
                  </Link>
                );
              })}
            </div>
          </div>
        </section>
        <section className="px-4 pb-12">
          <div className="max-w-3xl mx-auto">
            <h2 className="text-2xl font-bold mb-6">Frequently Asked Questions</h2>
            <div className="space-y-3">
              {faqs.map((item, i) => (
                <DistrictFAQItem key={i} question={item.question} answer={item.answer} />
              ))}
            </div>
          </div>
        </section>
        <section className="px-4 pb-12">
          <div className="max-w-2xl mx-auto">
            <LeadCapture source="district_page" calculatorType="roi" />
          </div>
        </section>
        <section className="px-4 pb-16">
          <Card className="max-w-4xl mx-auto border-primary/30 bg-primary/5">
            <CardContent className="p-8 text-center">
              <h2 className="text-2xl font-bold mb-3">Invest in {district.name} with Confidence</h2>
              <p className="text-muted-foreground mb-6 max-w-xl mx-auto">
                Use our AI-powered tools to analyze {district.name} properties and make data-driven investment decisions.
              </p>
              <div className="flex flex-col sm:flex-row gap-3 justify-center">
                <Button size="lg" onClick={() => setShowCalculator(true)}>
                  <Calculator className="w-4 h-4 mr-2" /> Calculate ROI Now
                </Button>
                <Link href="/signup">
                  <Button variant="outline" size="lg">Create Free Account <ArrowRight className="w-4 h-4 ml-2" /></Button>
                </Link>
              </div>
            </CardContent>
          </Card>
        </section>
      </div>
    </>
  );
}

function DistrictFAQItem({ question, answer }: { question: string; answer: string }) {
  const [open, setOpen] = useState(false);
  return (
    <Card>
      <button className="w-full text-left p-4 flex items-center justify-between" onClick={() => setOpen(!open)}>
        <span className="font-medium pr-4">{question}</span>
        {open ? <ChevronUp className="w-5 h-5 shrink-0 text-muted-foreground" /> : <ChevronDown className="w-5 h-5 shrink-0 text-muted-foreground" />}
      </button>
      {open && <div className="px-4 pb-4 text-muted-foreground text-sm leading-relaxed">{answer}</div>}
    </Card>
  );
}
