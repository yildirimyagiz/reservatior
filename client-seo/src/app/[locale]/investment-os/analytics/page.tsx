"use client";

import { useState } from "react";
import {
  BarChart3,
  TrendingUp,
  Users,
  Calculator,
  Target,
  Globe,
  ArrowUpRight,
  ArrowDownRight,
} from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { useInvestmentIntelligenceStore } from "@/lib/investment-intelligence-store";
import { CITY_COMPARISONS, MARKET_DATA } from "@/lib/seo/market-data";

export default function AnalyticsPage() {
  const { calculatorUsageCount, recentCalculations, comparisonItems } =
    useInvestmentIntelligenceStore();
  const [period, setPeriod] = useState("7d");

  const cities = Object.entries(MARKET_DATA);

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold">Investment Analytics</h1>
          <p className="text-muted-foreground">
            Track visitor engagement, calculator usage, and lead generation.
          </p>
        </div>
        <div className="flex gap-2">
          {["7d", "30d", "90d"].map((p) => (
            <button
              key={p}
              onClick={() => setPeriod(p)}
              className={`px-3 py-1.5 text-sm rounded-lg transition-colors ${
                period === p
                  ? "bg-primary text-primary-foreground"
                  : "bg-muted text-muted-foreground hover:bg-accent"
              }`}
            >
              {p}
            </button>
          ))}
        </div>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        {[
          { label: "Calculator Usage", value: calculatorUsageCount, change: "+12%", up: true, icon: Calculator },
          { label: "Leads Generated", value: Math.round(calculatorUsageCount * 0.35), change: "+8%", up: true, icon: Users },
          { label: "Conversion Rate", value: "4.2%", change: "+0.5%", up: true, icon: Target },
          { label: "Properties Compared", value: comparisonItems.length, change: "+15%", up: true, icon: BarChart3 },
        ].map((kpi) => (
          <Card key={kpi.label}>
            <CardContent className="p-4">
              <div className="flex items-start justify-between">
                <div>
                  <p className="text-xs text-muted-foreground">{kpi.label}</p>
                  <p className="text-2xl font-bold mt-1">{kpi.value}</p>
                </div>
                <div className={`flex items-center gap-0.5 text-xs ${kpi.up ? "text-blue-400" : "text-red-400"}`}>
                  {kpi.up ? <ArrowUpRight className="w-3 h-3" /> : <ArrowDownRight className="w-3 h-3" />}
                  {kpi.change}
                </div>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      <Tabs value="engagement">
        <TabsList className="grid w-full grid-cols-3">
          <TabsTrigger value="engagement">Engagement</TabsTrigger>
          <TabsTrigger value="markets">Market Trends</TabsTrigger>
          <TabsTrigger value="leads">Lead Funnel</TabsTrigger>
        </TabsList>

        <TabsContent value="engagement" className="space-y-4">
          {/* Most Searched Locations */}
          <Card>
            <CardHeader>
              <CardTitle className="text-base flex items-center gap-2">
                <Globe className="w-4 h-4" />
                Most Searched Locations
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                {[
                  { city: "Dubai", searches: 12450, pct: 100 },
                  { city: "Istanbul", searches: 8320, pct: 67 },
                  { city: "London", searches: 5680, pct: 46 },
                  { city: "Miami", searches: 4210, pct: 34 },
                  { city: "Paris", searches: 3100, pct: 25 },
                ].map((item) => (
                  <div key={item.city}>
                    <div className="flex justify-between text-sm mb-1">
                      <span>{item.city}</span>
                      <span className="text-muted-foreground">{item.searches.toLocaleString()}</span>
                    </div>
                    <div className="w-full h-2 bg-muted rounded-full overflow-hidden">
                      <div
                        className="h-full bg-primary rounded-full transition-all"
                        style={{ width: `${item.pct}%` }}
                      />
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>

          {/* Calculator Type Distribution */}
          <Card>
            <CardHeader>
              <CardTitle className="text-base">Calculator Usage by Type</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="grid grid-cols-3 gap-4">
                {[
                  { type: "ROI Calculator", pct: 45, count: 5625 },
                  { type: "Rental Yield", pct: 35, count: 4375 },
                  { type: "City Comparison", pct: 20, count: 2500 },
                ].map((item) => (
                  <div key={item.type} className="text-center p-4 rounded-lg bg-muted/30">
                    <p className="text-3xl font-bold text-primary">{item.pct}%</p>
                    <p className="text-sm text-muted-foreground mt-1">{item.type}</p>
                    <p className="text-xs text-muted-foreground/60">{item.count.toLocaleString()} uses</p>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="markets" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle className="text-base">Investor Demand Trends</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="overflow-x-auto">
                <table className="w-full text-sm">
                  <thead>
                    <tr className="border-b text-muted-foreground">
                      <th className="text-left py-2">City</th>
                      <th className="text-right py-2">Yield</th>
                      <th className="text-right py-2">Appreciation</th>
                      <th className="text-right py-2">Total Return</th>
                      <th className="text-right py-2">Demand Trend</th>
                    </tr>
                  </thead>
                  <tbody>
                    {CITY_COMPARISONS.sort((a, b) => b.totalReturn - a.totalReturn).map((city) => (
                      <tr key={city.city} className="border-b border-border/50">
                        <td className="py-2 font-medium">{city.city}</td>
                        <td className="text-right py-2 text-blue-400">{city.grossYield}%</td>
                        <td className="text-right py-2 text-blue-400">{city.appreciation}%</td>
                        <td className="text-right py-2 font-bold">{city.totalReturn}%</td>
                        <td className="text-right py-2">
                          <Badge className="bg-blue-500/20 text-blue-400">
                            <ArrowUpRight className="w-3 h-3 mr-1" />
                            Rising
                          </Badge>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="leads" className="space-y-4">
          <div className="grid md:grid-cols-3 gap-4">
            {[
              { stage: "Calculator Users", count: calculatorUsageCount || 156, pct: 100, color: "bg-blue-500" },
              { stage: "Report Requests", count: Math.round((calculatorUsageCount || 156) * 0.35), pct: 35, color: "bg-yellow-500" },
              { stage: "Qualified Leads", count: Math.round((calculatorUsageCount || 156) * 0.12), pct: 12, color: "bg-blue-500" },
            ].map((stage) => (
              <Card key={stage.stage}>
                <CardContent className="p-4 text-center">
                  <div className={`w-full h-2 rounded-full mb-3 ${stage.color}`} />
                  <p className="text-3xl font-bold">{stage.count}</p>
                  <p className="text-sm text-muted-foreground">{stage.stage}</p>
                  <p className="text-xs text-muted-foreground/60">{stage.pct}% of total</p>
                </CardContent>
              </Card>
            ))}
          </div>
        </TabsContent>
      </Tabs>
    </div>
  );
}
