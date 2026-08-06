"use client";

import { useState, useCallback } from "react";
import {
  TrendingUp,
  Percent,
  MapPin,
  Building2,
  Star,
  ArrowRight,
  DollarSign,
  Scale
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
  const [platformCommission, setPlatformCommission] = useState(5);
  const [maintenancePercent, setMaintenancePercent] = useState(2);
  const [taxPercent, setTaxPercent] = useState(8);

  const handleCalculate = useCallback(() => {
    calculatePropertyYield();
  }, [calculatePropertyYield]);

  const cityData = getCityData(selectedCity);
  const districts = getDistricts(selectedCity);

  const totalDeductions = platformCommission + maintenancePercent + taxPercent;
  const customNetYield = yieldOutput
    ? Math.max(0, Math.round((yieldOutput.grossYield - totalDeductions) * 100) / 100)
    : 0;

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

              <div className="space-y-3 pt-4 border-t border-border/60">
                <span className="text-xs font-bold text-muted-foreground uppercase tracking-wider block">Net Yield Adjusters</span>
                
                <div className="space-y-1">
                  <div className="flex justify-between text-xs font-semibold">
                    <Label className="text-muted-foreground">Platform Commission</Label>
                    <span className="text-blue-500 font-bold">{platformCommission}%</span>
                  </div>
                  <input
                    type="range"
                    min="0"
                    max="15"
                    step="0.5"
                    value={platformCommission}
                    onChange={(e) => setPlatformCommission(parseFloat(e.target.value))}
                    className="w-full h-1.5 bg-muted rounded-lg appearance-none cursor-pointer accent-blue-500"
                  />
                </div>

                <div className="space-y-1">
                  <div className="flex justify-between text-xs font-semibold">
                    <Label className="text-muted-foreground">Est. Maintenance & Reserve</Label>
                    <span className="text-blue-500 font-bold">{maintenancePercent}%</span>
                  </div>
                  <input
                    type="range"
                    min="0"
                    max="10"
                    step="0.5"
                    value={maintenancePercent}
                    onChange={(e) => setMaintenancePercent(parseFloat(e.target.value))}
                    className="w-full h-1.5 bg-muted rounded-lg appearance-none cursor-pointer accent-blue-500"
                  />
                </div>

                <div className="space-y-1">
                  <div className="flex justify-between text-xs font-semibold">
                    <Label className="text-muted-foreground">Taxes & Other Costs</Label>
                    <span className="text-blue-500 font-bold">{taxPercent}%</span>
                  </div>
                  <input
                    type="range"
                    min="0"
                    max="20"
                    step="0.5"
                    value={taxPercent}
                    onChange={(e) => setTaxPercent(parseFloat(e.target.value))}
                    className="w-full h-1.5 bg-muted rounded-lg appearance-none cursor-pointer accent-blue-500"
                  />
                </div>
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
                    <Percent className="w-5 h-5 mx-auto mb-1 text-success" />
                    <p className="text-2xl font-bold text-success">{yieldOutput.grossYield}%</p>
                    <p className="text-xs text-muted-foreground">Gross Yield</p>
                  </CardContent>
                </Card>
                 <Card>
                  <CardContent className="p-4 text-center">
                    <TrendingUp className="w-5 h-5 mx-auto mb-1 text-brand" />
                    <p className="text-2xl font-bold text-brand">{customNetYield}%</p>
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
                          ? "bg-success/20 text-success"
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

              {/* Gross vs Net Breakdown Card */}
              <Card className="bg-gradient-to-br from-blue-500/5 to-purple-500/5 border border-blue-500/10">
                <CardHeader className="pb-2">
                  <CardTitle className="text-base flex items-center gap-2">
                    <Scale className="w-4 h-4 text-blue-500" />
                    Gross vs Net Yield Breakdown
                  </CardTitle>
                </CardHeader>
                <CardContent className="space-y-3">
                  <div className="flex justify-between items-center text-sm">
                    <span className="text-muted-foreground">Initial Gross Yield</span>
                    <span className="font-semibold text-success">{yieldOutput.grossYield}%</span>
                  </div>
                  
                  <div className="space-y-1.5 pt-2 border-t border-border/50 text-xs">
                    <div className="flex justify-between items-center text-muted-foreground">
                      <span>- Platform Commission</span>
                      <span>{platformCommission}%</span>
                    </div>
                    <div className="flex justify-between items-center text-muted-foreground">
                      <span>- Maintenance & Reserves</span>
                      <span>{maintenancePercent}%</span>
                    </div>
                    <div className="flex justify-between items-center text-muted-foreground">
                      <span>- Local Taxes & Insurance</span>
                      <span>{taxPercent}%</span>
                    </div>
                    <div className="flex justify-between items-center text-red-400 font-medium">
                      <span>Total Estimated Deductions</span>
                      <span>-{totalDeductions}%</span>
                    </div>
                  </div>

                  <div className="flex justify-between items-center pt-2.5 border-t border-border font-bold text-sm">
                    <span className="text-foreground">Estimated Net Yield</span>
                    <span className="text-blue-500 text-base">{customNetYield}%</span>
                  </div>
                </CardContent>
              </Card>

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
                        <p className={`text-lg font-semibold ${yieldOutput.grossYield >= cityData.grossYield ? "text-success" : "text-orange-400"}`}>
                          {yieldOutput.grossYield}%
                        </p>
                      </div>
                      <div className="text-center">
                        <p className="text-sm text-muted-foreground">vs Market</p>
                        <p className={`text-lg font-semibold ${yieldOutput.grossYield >= cityData.grossYield ? "text-success" : "text-orange-400"}`}>
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
                              <td className="text-right py-2 text-success">{d.grossYield}%</td>
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
