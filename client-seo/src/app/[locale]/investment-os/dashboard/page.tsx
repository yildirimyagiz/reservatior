"use client";

import { useTranslation } from "react-i18next";
import {
  Calculator,
  TrendingUp,
  Globe,
  GitCompareArrows,
  FileText,
  Bot,
  BarChart3,
  Target,
  ArrowRight,
  DollarSign,
  Percent,
  Clock,
  Star,
} from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Link } from "@/lib/react-router-shim";
import { useInvestmentIntelligenceStore } from "@/lib/investment-intelligence-store";
import { CITY_COMPARISONS } from "@/lib/seo/market-data";

export default function InvestmentOSDashboard() {
  const { calculatorUsageCount, recentCalculations, comparisonItems } =
    useInvestmentIntelligenceStore();

  const topCities = CITY_COMPARISONS.sort((a, b) => b.totalReturn - a.totalReturn).slice(0, 4);

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold">Investment Intelligence Dashboard</h1>
        <p className="text-muted-foreground">
          Real estate investment analysis, market intelligence, and portfolio tools.
        </p>
      </div>

      {/* Quick Stats */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        {[
          { label: "Calculations Run", value: calculatorUsageCount, icon: Calculator, color: "text-blue-400" },
          { label: "Properties Compared", value: comparisonItems.length, icon: GitCompareArrows, color: "text-emerald-400" },
          { label: "Top Market Yield", value: `${topCities[0]?.grossYield || 0}%`, icon: TrendingUp, color: "text-yellow-400" },
          { label: "Markets Tracked", value: CITY_COMPARISONS.length, icon: Globe, color: "text-primary" },
        ].map((stat) => (
          <Card key={stat.label}>
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-lg bg-muted flex items-center justify-center">
                  <stat.icon className={`w-5 h-5 ${stat.color}`} />
                </div>
                <div>
                  <p className="text-2xl font-bold">{stat.value}</p>
                  <p className="text-xs text-muted-foreground">{stat.label}</p>
                </div>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      {/* Tool Quick Links */}
      <div className="grid md:grid-cols-3 gap-4">
        {[
          {
            title: "ROI Calculator",
            desc: "Calculate property returns with full mortgage analysis",
            href: "/investment-os/roi-calculator",
            icon: Calculator,
          },
          {
            title: "Rental Yield",
            desc: "Compare yields across districts and markets",
            href: "/investment-os/rental-yield",
            icon: TrendingUp,
          },
          {
            title: "City Comparison",
            desc: "Compare investment metrics across global cities",
            href: "/investment-os/city-comparison",
            icon: Globe,
          },
        ].map((tool) => (
          <Link key={tool.href} to={tool.href}>
            <Card className="hover:border-primary/50 transition-colors h-full cursor-pointer group">
              <CardContent className="p-5">
                <div className="flex items-start justify-between">
                  <div>
                    <tool.icon className="w-8 h-8 text-primary mb-3" />
                    <h3 className="font-bold text-lg">{tool.title}</h3>
                    <p className="text-sm text-muted-foreground mt-1">{tool.desc}</p>
                  </div>
                  <ArrowRight className="w-5 h-5 text-muted-foreground group-hover:text-primary transition-colors mt-1" />
                </div>
              </CardContent>
            </Card>
          </Link>
        ))}
      </div>

      {/* Top Markets */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <BarChart3 className="w-5 h-5" />
            Top Investment Markets
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-4">
            {topCities.map((city) => (
              <div key={city.city} className="p-4 rounded-lg border bg-muted/30">
                <div className="flex items-center justify-between mb-2">
                  <h4 className="font-bold">{city.city}</h4>
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
                <div className="grid grid-cols-2 gap-2 text-sm">
                  <div>
                    <p className="text-muted-foreground">Yield</p>
                    <p className="font-bold text-emerald-400">{city.grossYield}%</p>
                  </div>
                  <div>
                    <p className="text-muted-foreground">Return</p>
                    <p className="font-bold text-primary">{city.totalReturn}%</p>
                  </div>
                  <div>
                    <p className="text-muted-foreground">Tax</p>
                    <p className="font-medium">{city.taxRate}%</p>
                  </div>
                  <div>
                    <p className="text-muted-foreground">Visa</p>
                    <p className="font-medium">{city.residencyByInvestment ? "Yes" : "No"}</p>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </CardContent>
      </Card>

      {/* Recent Activity */}
      {recentCalculations.length > 0 && (
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Clock className="w-5 h-5" />
              Recent Calculations
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-2">
              {recentCalculations.slice(0, 5).map((calc) => (
                <div
                  key={calc.id}
                  className="flex items-center justify-between p-3 rounded-lg bg-muted/30"
                >
                  <div className="flex items-center gap-3">
                    <Badge variant="outline" className="capitalize">
                      {calc.type}
                    </Badge>
                    <span className="capitalize text-sm">{calc.city}</span>
                  </div>
                  <div className="flex items-center gap-3">
                    <span className="font-medium text-sm">{calc.score.toFixed(1)}%</span>
                    <span className="text-xs text-muted-foreground">
                      {new Date(calc.timestamp).toLocaleTimeString()}
                    </span>
                  </div>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      )}

      {/* SEO Landing Pages Links */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <Globe className="w-5 h-5" />
            Investment Analysis Pages
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="grid md:grid-cols-2 gap-2">
            {[
              "/invest/dubai/dubai-rental-yield-calculator",
              "/invest/dubai/dubai-property-roi-calculator",
              "/invest/dubai/damac-investment-calculator",
              "/invest/dubai/dubai-marina-roi-analysis",
              "/invest/dubai/business-bay-property-investment",
              "/invest/istanbul/istanbul-property-roi-calculator",
              "/invest/dubai/property-investment-calculator",
              "/invest/dubai/rental-income-calculator",
              "/invest/dubai/real-estate-cash-flow-calculator",
              "/invest/dubai/dubai-vs-istanbul-investment-comparison",
              "/invest/dubai/mortgage-vs-cash-purchase-calculator",
              "/invest/dubai/property-appreciation-calculator",
            ].map((href) => (
              <Link key={href} to={href}>
                <div className="p-2 rounded hover:bg-muted/50 text-sm text-primary hover:underline">
                  {href.split("/").slice(-1)[0].replace(/-/g, " ")}
                </div>
              </Link>
            ))}
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
