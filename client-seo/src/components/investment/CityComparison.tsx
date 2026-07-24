"use client";

import { useState } from "react";
import { Globe, TrendingUp, Shield, ArrowRight, CheckCircle, XCircle } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { CITY_COMPARISONS } from "@/lib/seo/market-data";

export function CityComparisonEngine() {
  const [selectedTab, setSelectedTab] = useState("overview");

  return (
    <div className="max-w-6xl mx-auto px-4 py-8">
      <div className="text-center mb-8">
        <h2 className="text-3xl font-bold flex items-center justify-center gap-2">
          <Globe className="w-8 h-8" />
          Global Investment City Comparison
        </h2>
        <p className="text-muted-foreground mt-2 max-w-2xl mx-auto">
          Compare property investment metrics across major global cities.
          Yields, appreciation, risk levels, and investor-friendliness at a glance.
        </p>
      </div>

      <Tabs value={selectedTab} onValueChange={setSelectedTab}>
        <TabsList className="grid w-full grid-cols-3 mb-6">
          <TabsTrigger value="overview">Overview</TabsTrigger>
          <TabsTrigger value="yields">Yields & Returns</TabsTrigger>
          <TabsTrigger value="compare">Side-by-Side</TabsTrigger>
        </TabsList>

        <TabsContent value="overview">
          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-4">
            {CITY_COMPARISONS.map((city) => (
              <Card key={city.city} className="hover:border-primary/50 transition-colors">
                <CardHeader className="pb-3">
                  <div className="flex items-center justify-between">
                    <CardTitle className="text-lg">{city.city}</CardTitle>
                    <Badge
                      className={
                        city.riskLevel === "LOW"
                          ? "bg-emerald-500/20 text-emerald-400"
                          : city.riskLevel === "MEDIUM"
                          ? "bg-yellow-500/20 text-yellow-400"
                          : "bg-red-500/20 text-red-400"
                      }
                    >
                      {city.riskLevel} RISK
                    </Badge>
                  </div>
                  <p className="text-sm text-muted-foreground">{city.country} · {city.currency}</p>
                </CardHeader>
                <CardContent className="space-y-3">
                  <div className="grid grid-cols-2 gap-2">
                    <div className="p-2 rounded bg-muted/50 text-center">
                      <p className="text-xs text-muted-foreground">Gross Yield</p>
                      <p className="font-bold text-emerald-400">{city.grossYield}%</p>
                    </div>
                    <div className="p-2 rounded bg-muted/50 text-center">
                      <p className="text-xs text-muted-foreground">Net Yield</p>
                      <p className="font-bold">{city.netYield}%</p>
                    </div>
                    <div className="p-2 rounded bg-muted/50 text-center">
                      <p className="text-xs text-muted-foreground">Appreciation</p>
                      <p className="font-bold text-blue-400">{city.appreciation}%</p>
                    </div>
                    <div className="p-2 rounded bg-muted/50 text-center">
                      <p className="text-xs text-muted-foreground">Total Return</p>
                      <p className="font-bold text-primary">{city.totalReturn}%</p>
                    </div>
                  </div>
                  <div className="flex items-center justify-between text-sm">
                    <span className="text-muted-foreground">Liquidity</span>
                    <div className="flex items-center gap-1">
                      <div className="w-20 h-2 bg-muted rounded-full overflow-hidden">
                        <div
                          className="h-full bg-primary rounded-full"
                          style={{ width: `${city.liquidityScore}%` }}
                        />
                      </div>
                      <span className="text-xs">{city.liquidityScore}</span>
                    </div>
                  </div>
                  <div className="flex items-center gap-4 text-sm">
                    <span className="flex items-center gap-1">
                      {city.investorFriendly ? (
                        <CheckCircle className="w-4 h-4 text-emerald-400" />
                      ) : (
                        <XCircle className="w-4 h-4 text-red-400" />
                      )}
                      Investor Friendly
                    </span>
                    <span className="flex items-center gap-1">
                      {city.residencyByInvestment ? (
                        <CheckCircle className="w-4 h-4 text-emerald-400" />
                      ) : (
                        <XCircle className="w-4 h-4 text-red-400" />
                      )}
                      Residency
                    </span>
                  </div>
                  <div className="text-sm text-muted-foreground">
                    Tax Rate: <span className="font-medium text-foreground">{city.taxRate}%</span>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        </TabsContent>

        <TabsContent value="yields">
          <Card>
            <CardContent className="p-0 overflow-x-auto">
              <table className="w-full text-sm">
                <thead>
                  <tr className="border-b bg-muted/50">
                    <th className="text-left py-3 px-4">City</th>
                    <th className="text-right py-3 px-4">Gross Yield</th>
                    <th className="text-right py-3 px-4">Net Yield</th>
                    <th className="text-right py-3 px-4">Appreciation</th>
                    <th className="text-right py-3 px-4">Total Return</th>
                    <th className="text-right py-3 px-4">Risk</th>
                    <th className="text-right py-3 px-4">Liquidity</th>
                    <th className="text-right py-3 px-4">Tax</th>
                  </tr>
                </thead>
                <tbody>
                  {CITY_COMPARISONS.sort((a, b) => b.totalReturn - a.totalReturn).map((city) => (
                    <tr key={city.city} className="border-b border-border/50 hover:bg-muted/30">
                      <td className="py-3 px-4 font-medium">
                        {city.city}
                        <span className="text-muted-foreground ml-2 text-xs">{city.country}</span>
                      </td>
                      <td className="text-right py-3 px-4 text-emerald-400 font-medium">
                        {city.grossYield}%
                      </td>
                      <td className="text-right py-3 px-4">{city.netYield}%</td>
                      <td className="text-right py-3 px-4 text-blue-400">{city.appreciation}%</td>
                      <td className="text-right py-3 px-4 font-bold text-primary">
                        {city.totalReturn}%
                      </td>
                      <td className="text-right py-3 px-4">
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
                      </td>
                      <td className="text-right py-3 px-4">{city.liquidityScore}/100</td>
                      <td className="text-right py-3 px-4">{city.taxRate}%</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="compare">
          <div className="grid md:grid-cols-2 gap-6">
            {CITY_COMPARISONS.slice(0, 4).map((city, i) => (
              <Card key={city.city}>
                <CardHeader>
                  <CardTitle>{city.city}, {city.country}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-3">
                    {[
                      { label: "Gross Yield", value: city.grossYield, benchmark: 5, unit: "%" },
                      { label: "Net Yield", value: city.netYield, benchmark: 3.5, unit: "%" },
                      { label: "Appreciation", value: city.appreciation, benchmark: 5, unit: "%" },
                      { label: "Total Return", value: city.totalReturn, benchmark: 8, unit: "%" },
                      { label: "Liquidity Score", value: city.liquidityScore, benchmark: 70, unit: "/100" },
                    ].map((metric) => (
                      <div key={metric.label}>
                        <div className="flex justify-between text-sm mb-1">
                          <span className="text-muted-foreground">{metric.label}</span>
                          <span className="font-medium">{metric.value}{metric.unit}</span>
                        </div>
                        <div className="w-full h-2 bg-muted rounded-full overflow-hidden">
                          <div
                            className={`h-full rounded-full ${
                              metric.value >= metric.benchmark ? "bg-emerald-400" : "bg-yellow-400"
                            }`}
                            style={{ width: `${Math.min(100, (metric.value / (metric.benchmark * 2)) * 100)}%` }}
                          />
                        </div>
                      </div>
                    ))}
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        </TabsContent>
      </Tabs>
    </div>
  );
}
