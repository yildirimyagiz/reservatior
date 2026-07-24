"use client";

import { useState, useCallback } from "react";
import {
  TrendingUp,
  Percent,
  MapPin,
  Building2,
  Star,
  ArrowRight,
} from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Badge } from "@/components/ui/badge";
import { useInvestmentIntelligenceStore } from "@/lib/investment-intelligence-store";
import { getCityData, getDistricts, formatCurrency } from "@/lib/seo/market-data";

interface RentalYieldCalculatorProps {
  initialCity?: string;
  embedded?: boolean;
}

export function RentalYieldCalculator({
  initialCity = "dubai",
  embedded = false,
}: RentalYieldCalculatorProps) {
  const { yieldInput, yieldOutput, setYieldInput, calculatePropertyYield, isCalculating } =
    useInvestmentIntelligenceStore();
  const [selectedCity, setSelectedCity] = useState(initialCity);

  const handleCalculate = useCallback(() => {
    calculatePropertyYield();
  }, [calculatePropertyYield]);

  const cityData = getCityData(selectedCity);
  const districts = getDistricts(selectedCity);

  return (
    <div className={embedded ? "" : "max-w-5xl mx-auto px-4 py-8"}>
      {!embedded && (
        <div className="text-center mb-8">
          <h1 className="text-3xl font-bold mb-2">
            {selectedCity.charAt(0).toUpperCase() + selectedCity.slice(1)} Rental Yield Calculator
          </h1>
          <p className="text-muted-foreground max-w-2xl mx-auto">
            Analyze rental yields by district. Compare gross and net yields with real market benchmarks.
          </p>
        </div>
      )}

      <div className="grid lg:grid-cols-3 gap-6">
        {/* Input Panel */}
        <div className="lg:col-span-1">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2 text-lg">
                <TrendingUp className="w-5 h-5" />
                Yield Parameters
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div>
                <Label>City</Label>
                <Select
                  value={selectedCity}
                  onValueChange={(val) => {
                    setSelectedCity(val);
                    setYieldInput({ city: val });
                  }}
                >
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    {["dubai", "istanbul", "london", "miami", "paris"].map((c) => (
                      <SelectItem key={c} value={c}>
                        {c.charAt(0).toUpperCase() + c.slice(1)}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>

              <div>
                <Label>Property Type</Label>
                <Select
                  value={yieldInput.propertyType}
                  onValueChange={(val) => setYieldInput({ propertyType: val })}
                >
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    {["apartment", "villa", "townhouse", "studio", "penthouse"].map((t) => (
                      <SelectItem key={t} value={t}>
                        {t.charAt(0).toUpperCase() + t.slice(1)}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>

              <div>
                <Label>Bedrooms</Label>
                <Select
                  value={String(yieldInput.bedrooms || 2)}
                  onValueChange={(val) => setYieldInput({ bedrooms: parseInt(val) })}
                >
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    {[0, 1, 2, 3, 4, 5].map((b) => (
                      <SelectItem key={b} value={String(b)}>
                        {b === 0 ? "Studio" : `${b} BR`}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>

              <div>
                <Label>Purchase Price</Label>
                <Input
                  type="number"
                  value={yieldInput.purchasePrice}
                  onChange={(e) =>
                    setYieldInput({ purchasePrice: parseFloat(e.target.value) || 0 })
                  }
                />
              </div>

              <div>
                <Label>Monthly Rent</Label>
                <Input
                  type="number"
                  value={yieldInput.monthlyRent}
                  onChange={(e) =>
                    setYieldInput({ monthlyRent: parseFloat(e.target.value) || 0 })
                  }
                />
              </div>

              <div>
                <Label>Service Charges (annual)</Label>
                <Input
                  type="number"
                  value={yieldInput.serviceCharges || 0}
                  onChange={(e) =>
                    setYieldInput({ serviceCharges: parseFloat(e.target.value) || 0 })
                  }
                />
              </div>

              <Button
                onClick={handleCalculate}
                disabled={isCalculating}
                className="w-full"
                size="lg"
              >
                {isCalculating ? "Calculating..." : "Calculate Yield"}
                <ArrowRight className="w-4 h-4 ml-2" />
              </Button>
            </CardContent>
          </Card>
        </div>

        {/* Results */}
        <div className="lg:col-span-2 space-y-4">
          {yieldOutput ? (
            <>
              <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
                <Card>
                  <CardContent className="p-4 text-center">
                    <Percent className="w-5 h-5 mx-auto mb-1 text-emerald-400" />
                    <p className="text-2xl font-bold text-emerald-400">{yieldOutput.grossYield}%</p>
                    <p className="text-xs text-muted-foreground">Gross Yield</p>
                  </CardContent>
                </Card>
                <Card>
                  <CardContent className="p-4 text-center">
                    <TrendingUp className="w-5 h-5 mx-auto mb-1 text-blue-400" />
                    <p className="text-2xl font-bold text-blue-400">{yieldOutput.netYield}%</p>
                    <p className="text-xs text-muted-foreground">Net Yield</p>
                  </CardContent>
                </Card>
                <Card>
                  <CardContent className="p-4 text-center">
                    <Star className="w-5 h-5 mx-auto mb-1 text-yellow-400" />
                    <p className="text-2xl font-bold text-yellow-400">{yieldOutput.investorScore}/100</p>
                    <p className="text-xs text-muted-foreground">Investor Score</p>
                  </CardContent>
                </Card>
                <Card>
                  <CardContent className="p-4 text-center">
                    <Building2 className="w-5 h-5 mx-auto mb-1 text-primary" />
                    <Badge
                      className={
                        yieldOutput.riskLevel === "LOW"
                          ? "bg-emerald-500/20 text-emerald-400"
                          : yieldOutput.riskLevel === "MEDIUM"
                          ? "bg-yellow-500/20 text-yellow-400"
                          : "bg-red-500/20 text-red-400"
                      }
                    >
                      {yieldOutput.riskLevel} RISK
                    </Badge>
                    <p className="text-xs text-muted-foreground mt-1">Risk Level</p>
                  </CardContent>
                </Card>
              </div>

              {/* Market Benchmark */}
              {cityData && (
                <Card>
                  <CardHeader>
                    <CardTitle className="text-base flex items-center gap-2">
                      <MapPin className="w-4 h-4" />
                      Market Benchmark - {cityData.city}
                    </CardTitle>
                  </CardHeader>
                  <CardContent>
                    <div className="grid grid-cols-3 gap-4 mb-4">
                      <div className="text-center">
                        <p className="text-sm text-muted-foreground">Market Avg Yield</p>
                        <p className="text-lg font-semibold">{cityData.grossYield}%</p>
                      </div>
                      <div className="text-center">
                        <p className="text-sm text-muted-foreground">Your Yield</p>
                        <p className={`text-lg font-semibold ${yieldOutput.grossYield >= cityData.grossYield ? "text-emerald-400" : "text-orange-400"}`}>
                          {yieldOutput.grossYield}%
                        </p>
                      </div>
                      <div className="text-center">
                        <p className="text-sm text-muted-foreground">vs Market</p>
                        <p className={`text-lg font-semibold ${yieldOutput.grossYield >= cityData.grossYield ? "text-emerald-400" : "text-orange-400"}`}>
                          {yieldOutput.grossYield >= cityData.grossYield ? "+" : ""}
                          {(yieldOutput.grossYield - cityData.grossYield).toFixed(1)}%
                        </p>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              )}

              {/* District Comparison */}
              {districts.length > 0 && (
                <Card>
                  <CardHeader>
                    <CardTitle className="text-base flex items-center gap-2">
                      <Building2 className="w-4 h-4" />
                      District Comparison
                    </CardTitle>
                  </CardHeader>
                  <CardContent>
                    <div className="overflow-x-auto">
                      <table className="w-full text-sm">
                        <thead>
                          <tr className="border-b text-muted-foreground">
                            <th className="text-left py-2">District</th>
                            <th className="text-right py-2">Yield</th>
                            <th className="text-right py-2">Appreciation</th>
                            <th className="text-right py-2">Walkability</th>
                            <th className="text-right py-2">Grade</th>
                          </tr>
                        </thead>
                        <tbody>
                          {districts.map((d) => (
                            <tr
                              key={d.name}
                              className={`border-b border-border/50 hover:bg-muted/50 ${
                                yieldInput.district === d.name ? "bg-primary/10" : ""
                              }`}
                            >
                              <td className="py-2 font-medium">{d.name}</td>
                              <td className="text-right py-2 text-emerald-400">{d.grossYield}%</td>
                              <td className="text-right py-2">{d.appreciation}%</td>
                              <td className="text-right py-2">{d.walkabilityScore}/100</td>
                              <td className="text-right py-2">
                                <Badge variant="outline" className="text-xs">
                                  {d.investmentGrade}
                                </Badge>
                              </td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    </div>
                  </CardContent>
                </Card>
              )}
            </>
          ) : (
            <Card className="h-full flex items-center justify-center min-h-[400px]">
              <CardContent className="text-center p-8">
                <TrendingUp className="w-16 h-16 mx-auto mb-4 text-muted-foreground/30" />
                <p className="text-lg font-medium text-muted-foreground">
                  Select parameters and calculate yield
                </p>
                <p className="text-sm text-muted-foreground/70 mt-2">
                  Results include district comparisons and market benchmarks
                </p>
              </CardContent>
            </Card>
          )}
        </div>
      </div>
    </div>
  );
}
