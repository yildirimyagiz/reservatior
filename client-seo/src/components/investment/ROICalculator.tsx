"use client";

import { useState, useCallback, useEffect } from "react";
import { useTranslation } from "react-i18next";
import {
  Calculator,
  TrendingUp,
  DollarSign,
  Percent,
  Clock,
  AlertTriangle,
  ChevronDown,
  ChevronUp,
  BarChart3,
  ArrowRight,
  Download,
  Mail,
} from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { useInvestmentIntelligenceStore } from "@/lib/investment-intelligence-store";
import { getCityData, formatCurrency, MARKET_DATA } from "@/lib/seo/market-data";
import type { PropertyROIInput } from "@/types/investment-intelligence";

interface ROICalculatorProps {
  initialCity?: string;
  embedded?: boolean;
  showLeadCapture?: boolean;
  showReportCTA?: boolean;
}

export function ROICalculator({
  initialCity = "dubai",
  embedded = false,
  showLeadCapture = true,
  showReportCTA = true,
}: ROICalculatorProps) {
  const { t } = useTranslation();
  const {
    roiInput,
    roiOutput,
    isCalculating,
    setROIInput,
    calculatePropertyROI,
    generateInvestmentReport,
    isGeneratingReport,
    calculatorUsageCount,
  } = useInvestmentIntelligenceStore();

  const [showAdvanced, setShowAdvanced] = useState(false);
  const [activeTab, setActiveTab] = useState<"inputs" | "results">("inputs");
  const [email, setEmail] = useState("");
  const [selectedCity, setSelectedCity] = useState(initialCity);

  useEffect(() => {
    const cityData = getCityData(selectedCity);
    if (cityData) {
      setROIInput({
        city: selectedCity,
        currency: cityData.currency,
      });
    }
  }, [selectedCity, setROIInput]);

  const handleCalculate = useCallback(() => {
    calculatePropertyROI();
    setActiveTab("results");
  }, [calculatePropertyROI]);

  const handleExportReport = useCallback(async () => {
    await generateInvestmentReport(email || undefined);
  }, [generateInvestmentReport, email]);

  const cityData = getCityData(selectedCity);

  const inputFields: Array<{
    key: keyof PropertyROIInput;
    label: string;
    type?: string;
    suffix?: string;
    min?: number;
    max?: number;
    step?: number;
    description?: string;
  }> = [
    { key: "purchasePrice", label: "Purchase Price", suffix: roiInput.currency, min: 10000, step: 50000, description: "Total property purchase price" },
    { key: "downPaymentPercent", label: "Down Payment", type: "percent", suffix: "%", min: 0, max: 100, step: 5, description: "Percentage of purchase price" },
    { key: "mortgageAmount", label: "Mortgage Amount", suffix: roiInput.currency, min: 0, step: 50000, description: "Loan amount (0 if cash purchase)" },
    { key: "interestRate", label: "Interest Rate", type: "percent", suffix: "%", min: 0, max: 20, step: 0.1, description: "Annual mortgage interest rate" },
    { key: "monthlyRent", label: "Monthly Rent", suffix: roiInput.currency, min: 0, step: 500, description: "Expected monthly rental income" },
  ];

  const advancedFields: Array<{
    key: keyof PropertyROIInput;
    label: string;
    type?: string;
    suffix?: string;
    min?: number;
    max?: number;
    step?: number;
  }> = [
    { key: "annualMaintenance", label: "Annual Maintenance", suffix: roiInput.currency, min: 0, step: 1000 },
    { key: "serviceCharges", label: "Service Charges", suffix: roiInput.currency, min: 0, step: 1000 },
    { key: "vacancyRate", label: "Vacancy Rate", type: "percent", suffix: "%", min: 0, max: 50, step: 1 },
    { key: "appreciationRate", label: "Appreciation Rate", type: "percent", suffix: "%", min: -10, max: 30, step: 0.5 },
    { key: "holdingPeriodYears", label: "Holding Period", suffix: "years", min: 1, max: 30, step: 1 },
  ];

  const gradeColors: Record<string, string> = {
    "A+": "bg-success/20 text-success border-blue-500/30",
    A: "bg-success/15 text-blue-300 border-blue-500/25",
    "B+": "bg-brand/15 text-brand border-blue-500/25",
    B: "bg-brand/10 text-blue-300 border-blue-500/20",
    "C+": "bg-yellow-500/15 text-yellow-400 border-yellow-500/25",
    C: "bg-orange-500/15 text-orange-400 border-orange-500/25",
    D: "bg-red-500/15 text-red-400 border-red-500/25",
  };

  return (
    <div className={embedded ? "" : "max-w-6xl mx-auto px-4 py-8"}>
      {!embedded && (
        <div className="text-center mb-8">
          <h1 className="text-3xl font-bold mb-2">
            {roiInput.city ? `${roiInput.city.charAt(0).toUpperCase() + roiInput.city.slice(1)} ` : ""}
            Property ROI Calculator
          </h1>
          <p className="text-muted-foreground max-w-2xl mx-auto">
            Calculate rental yields, cash flow, and total ROI for property investments.
            Free investment analysis with real market data.
          </p>
        </div>
      )}

      {/* City Selector */}
      {!embedded && (
        <div className="flex flex-wrap gap-2 mb-6 justify-center">
          {Object.keys(MARKET_DATA).map((city) => (
            <button
              key={city}
              onClick={() => setSelectedCity(city)}
              className={`px-4 py-2 rounded-full text-sm font-medium transition-all ${
                selectedCity === city
                  ? "bg-primary text-primary-foreground shadow-md"
                  : "bg-card text-muted-foreground border border-border hover:border-primary/50"
              }`}
            >
              {city.charAt(0).toUpperCase() + city.slice(1)}
            </button>
          ))}
        </div>
      )}

      {cityData && !embedded && (
        <div className="grid grid-cols-2 md:grid-cols-4 gap-3 mb-8">
          {[
            { label: "Avg Yield", value: `${cityData.grossYield}%`, icon: Percent },
            { label: "Net Yield", value: `${cityData.netYield}%`, icon: TrendingUp },
            { label: "Appreciation", value: `${cityData.annualAppreciation}%`, icon: BarChart3 },
            { label: "Vacancy", value: `${cityData.vacancyRate}%`, icon: Clock },
          ].map((stat) => (
            <Card key={stat.label} className="text-center">
              <CardContent className="p-4">
                <stat.icon className="w-5 h-5 mx-auto mb-1 text-primary" />
                <p className="text-2xl font-bold">{stat.value}</p>
                <p className="text-xs text-muted-foreground">{stat.label}</p>
              </CardContent>
            </Card>
          ))}
        </div>
      )}

      <div className="grid lg:grid-cols-5 gap-6">
        {/* Input Panel */}
        <div className="lg:col-span-2">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2 text-lg">
                <Calculator className="w-5 h-5" />
                Investment Parameters
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              {inputFields.map((field) => (
                <div key={field.key}>
                  <Label className="text-sm font-medium flex items-center justify-between">
                    {field.label}
                    {field.description && (
                      <span className="text-xs text-muted-foreground font-normal">{field.description}</span>
                    )}
                  </Label>
                  <div className="relative mt-1">
                    <Input
                      type="number"
                      value={roiInput[field.key] as number}
                      onChange={(e) =>
                        setROIInput({ [field.key]: parseFloat(e.target.value) || 0 })
                      }
                      min={field.min}
                      max={field.max}
                      step={field.step}
                      className="pr-16"
                    />
                    <span className="absolute right-3 top-1/2 -translate-y-1/2 text-sm text-muted-foreground">
                      {field.suffix}
                    </span>
                  </div>
                </div>
              ))}

              <button
                onClick={() => setShowAdvanced(!showAdvanced)}
                className="flex items-center gap-1 text-sm text-primary hover:underline"
              >
                {showAdvanced ? <ChevronUp className="w-4 h-4" /> : <ChevronDown className="w-4 h-4" />}
                {showAdvanced ? "Hide" : "Show"} Advanced Options
              </button>

              {showAdvanced && (
                <div className="space-y-4 pt-2 border-t">
                  {advancedFields.map((field) => (
                    <div key={field.key}>
                      <Label className="text-sm">{field.label}</Label>
                      <div className="relative mt-1">
                        <Input
                          type="number"
                          value={roiInput[field.key] as number}
                          onChange={(e) =>
                            setROIInput({ [field.key]: parseFloat(e.target.value) || 0 })
                          }
                          min={field.min}
                          max={field.max}
                          step={field.step}
                          className="pr-16"
                        />
                        <span className="absolute right-3 top-1/2 -translate-y-1/2 text-sm text-muted-foreground">
                          {field.suffix}
                        </span>
                      </div>
                    </div>
                  ))}
                </div>
              )}

              <Button
                onClick={handleCalculate}
                disabled={isCalculating}
                className="w-full"
                size="lg"
              >
                {isCalculating ? "Calculating..." : "Calculate ROI"}
                <ArrowRight className="w-4 h-4 ml-2" />
              </Button>
            </CardContent>
          </Card>
        </div>

        {/* Results Panel */}
        <div className="lg:col-span-3">
          {roiOutput ? (
            <div className="space-y-4">
              {/* Grade Badge */}
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-3">
                  <Badge className={`text-lg px-4 py-1 ${gradeColors[roiOutput.investmentGrade]}`}>
                    {roiOutput.investmentGrade}
                  </Badge>
                  <div>
                    <p className="text-sm text-muted-foreground">Investment Grade</p>
                    <p className="font-semibold">Risk Score: {roiOutput.riskScore}/100</p>
                  </div>
                </div>
                {showReportCTA && (
                  <Button variant="outline" size="sm" onClick={handleExportReport} disabled={isGeneratingReport}>
                    <Download className="w-4 h-4 mr-1" />
                    {isGeneratingReport ? "Generating..." : "Get Full Report"}
                  </Button>
                )}
              </div>

              {/* Key Metrics */}
              <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
                {[
                  { label: "Gross Yield", value: `${roiOutput.grossRentalYield}%`, color: "text-success" },
                  { label: "Net Yield", value: `${roiOutput.netRentalYield}%`, color: "text-blue-300" },
                  { label: "Annual Cash Flow", value: formatCurrency(roiOutput.annualCashFlow, roiInput.currency), color: roiOutput.annualCashFlow >= 0 ? "text-success" : "text-red-400" },
                  { label: "Total ROI", value: `${roiOutput.totalROI}%`, color: "text-primary" },
                ].map((metric) => (
                  <Card key={metric.label}>
                    <CardContent className="p-4 text-center">
                      <p className="text-xs text-muted-foreground mb-1">{metric.label}</p>
                      <p className={`text-xl font-bold ${metric.color}`}>{metric.value}</p>
                    </CardContent>
                  </Card>
                ))}
              </div>

              {/* Detailed Metrics */}
              <Card>
                <CardContent className="p-4">
                  <div className="grid grid-cols-2 md:grid-cols-3 gap-4">
                    {[
                      { label: "Cap Rate", value: `${roiOutput.capRate}%` },
                      { label: "Monthly Cash Flow", value: formatCurrency(roiOutput.monthlyCashFlow, roiInput.currency) },
                      { label: "Total Investment", value: formatCurrency(roiOutput.totalInvestment, roiInput.currency) },
                      { label: "Total Return", value: formatCurrency(roiOutput.totalReturn, roiInput.currency) },
                      { label: "Annual ROI", value: `${roiOutput.annualROI}%` },
                      { label: "Break-Even", value: roiOutput.breakEvenMonths > 0 ? `${Math.round(roiOutput.breakEvenMonths / 12)} years` : "N/A" },
                    ].map((item) => (
                      <div key={item.label} className="flex justify-between items-center py-2 border-b border-border last:border-0">
                        <span className="text-sm text-muted-foreground">{item.label}</span>
                        <span className="font-semibold">{item.value}</span>
                      </div>
                    ))}
                  </div>
                </CardContent>
              </Card>

              {/* Year by Year Projection */}
              {roiOutput.yearByYear.length > 0 && (
                <Card>
                  <CardHeader>
                    <CardTitle className="text-base flex items-center gap-2">
                      <BarChart3 className="w-4 h-4" />
                      Year-by-Year Projection
                    </CardTitle>
                  </CardHeader>
                  <CardContent>
                    <div className="overflow-x-auto">
                      <table className="w-full text-sm">
                        <thead>
                          <tr className="border-b text-muted-foreground">
                            <th className="text-left py-2 px-2">Year</th>
                            <th className="text-right py-2 px-2">Value</th>
                            <th className="text-right py-2 px-2">Rent</th>
                            <th className="text-right py-2 px-2">Net Income</th>
                            <th className="text-right py-2 px-2">Cash Flow</th>
                            <th className="text-right py-2 px-2">ROI</th>
                          </tr>
                        </thead>
                        <tbody>
                          {roiOutput.yearByYear.map((yp) => (
                            <tr key={yp.year} className="border-b border-border/50 hover:bg-muted/50">
                              <td className="py-2 px-2 font-medium">{yp.year}</td>
                              <td className="text-right py-2 px-2">{formatCurrency(yp.propertyValue, roiInput.currency)}</td>
                              <td className="text-right py-2 px-2">{formatCurrency(yp.annualRent, roiInput.currency)}</td>
                              <td className={`text-right py-2 px-2 ${yp.netIncome >= 0 ? "text-success" : "text-red-400"}`}>
                                {formatCurrency(yp.netIncome, roiInput.currency)}
                              </td>
                              <td className={`text-right py-2 px-2 ${yp.cumulativeCashFlow >= 0 ? "text-success" : "text-red-400"}`}>
                                {formatCurrency(yp.cumulativeCashFlow, roiInput.currency)}
                              </td>
                              <td className="text-right py-2 px-2 font-medium">{yp.totalROI}%</td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    </div>
                  </CardContent>
                </Card>
              )}

              {/* Lead Capture */}
              {showLeadCapture && (
                <Card className="border-primary/30 bg-primary/5">
                  <CardContent className="p-4">
                    <div className="flex flex-col md:flex-row gap-3 items-center">
                      <div className="flex-1">
                        <p className="font-medium">Get Your Full Investment Report</p>
                        <p className="text-sm text-muted-foreground">
                          AI-powered analysis with market comparisons, risk assessment, and recommendations
                        </p>
                      </div>
                      <div className="flex gap-2 w-full md:w-auto">
                        <Input
                          type="email"
                          placeholder="your@email.com"
                          value={email}
                          onChange={(e) => setEmail(e.target.value)}
                          className="md:w-64"
                        />
                        <Button onClick={handleExportReport} disabled={isGeneratingReport || !email}>
                          <Mail className="w-4 h-4 mr-1" />
                          Send
                        </Button>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              )}
            </div>
          ) : (
            <Card className="h-full flex items-center justify-center min-h-[400px]">
              <CardContent className="text-center p-8">
                <Calculator className="w-16 h-16 mx-auto mb-4 text-muted-foreground/30" />
                <p className="text-lg font-medium text-muted-foreground">Configure parameters and click Calculate</p>
                <p className="text-sm text-muted-foreground/70 mt-2">
                  Results will appear here with detailed projections
                </p>
                {calculatorUsageCount > 0 && (
                  <p className="text-xs text-muted-foreground/50 mt-4">
                    You&apos;ve made {calculatorUsageCount} calculations this session
                  </p>
                )}
              </CardContent>
            </Card>
          )}
        </div>
      </div>
    </div>
  );
}
