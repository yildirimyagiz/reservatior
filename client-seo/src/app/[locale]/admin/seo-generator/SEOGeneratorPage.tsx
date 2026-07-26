"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Label } from "@/components/ui/label";
import {
  Search,
  Code2,
  TrendingUp,
  DollarSign,
  AlertCircle,
  Copy,
  Check,
} from "lucide-react";
import { m, AnimatePresence } from "framer-motion";
import { useTranslation } from "react-i18next";
import { seoDataApi, type PropertySEOData, type InvestmentScore, type RentalYield } from "@/lib/api/seo-data";

export default function SEOGeneratorPage() {
  const { t } = useTranslation();
  const [propertyId, setPropertyId] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [seoData, setSEOData] = useState<PropertySEOData | null>(null);
  const [investmentScore, setInvestmentScore] = useState<InvestmentScore | null>(null);
  const [rentalYield, setRentalYield] = useState<RentalYield | null>(null);
  const [copiedJsonLd, setCopiedJsonLd] = useState(false);
  const [activeTab, setActiveTab] = useState("seo");

  const handleGenerate = async () => {
    if (!propertyId.trim()) return;
    setLoading(true);
    setError(null);
    setSEOData(null);
    setInvestmentScore(null);
    setRentalYield(null);

    try {
      const [seoResult, scoreResult, yieldResult] = await Promise.allSettled([
        seoDataApi.getPropertySEO(propertyId),
        seoDataApi.getInvestmentScore(propertyId),
        seoDataApi.getRentalYield(propertyId),
      ]);

      if (seoResult.status === "fulfilled") setSEOData(seoResult.value);
      if (scoreResult.status === "fulfilled") setInvestmentScore(scoreResult.value);
      if (yieldResult.status === "fulfilled") setRentalYield(yieldResult.value);

      if (seoResult.status === "rejected") {
        setError(seoResult.reason?.message || "Failed to generate SEO data");
      }
    } catch (e: any) {
      setError(e.message || "An error occurred");
    } finally {
      setLoading(false);
    }
  };

  const copyJsonLd = () => {
    if (seoData?.jsonLd) {
      navigator.clipboard.writeText(JSON.stringify(seoData.jsonLd, null, 2));
      setCopiedJsonLd(true);
      setTimeout(() => setCopiedJsonLd(false), 2000);
    }
  };

  const getGradeColor = (grade: string) => {
    if (grade.startsWith("AA")) return "bg-emerald-100 text-emerald-800 border-emerald-200";
    if (grade.startsWith("A")) return "bg-blue-100 text-blue-800 border-blue-200";
    if (grade === "BBB") return "bg-yellow-100 text-yellow-800 border-yellow-200";
    if (grade === "BB") return "bg-orange-100 text-orange-800 border-orange-200";
    return "bg-red-100 text-red-800 border-red-200";
  };

  const getScoreColor = (score: number) => {
    if (score >= 80) return "text-emerald-600";
    if (score >= 60) return "text-blue-600";
    if (score >= 40) return "text-yellow-600";
    return "text-red-600";
  };

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold">{t("admin_seo_generator_title", "SEO Data Generator")}</h1>
        <p className="text-muted-foreground">
          {t("admin_seo_generator_description", "Generate structured data, investment scores, and rental yields")}
        </p>
      </div>

      <Card>
        <CardContent className="pt-6">
          <div className="flex gap-3">
            <div className="flex-1">
              <Label htmlFor="propertyId" className="sr-only">
                {t("admin_seo_generator_property_id", "Property ID")}
              </Label>
              <Input
                id="propertyId"
                placeholder={t("admin_seo_generator_property_id", "Property ID")}
                value={propertyId}
                onChange={(e) => setPropertyId(e.target.value)}
                onKeyDown={(e) => e.key === "Enter" && handleGenerate()}
              />
            </div>
            <Button onClick={handleGenerate} disabled={loading || !propertyId.trim()}>
              {loading ? (
                <span className="flex items-center gap-2">
                  <span className="h-4 w-4 animate-spin rounded-full border-2 border-current border-t-transparent" />
                  {t("generic_os.loading", "Loading...")}
                </span>
              ) : (
                <span className="flex items-center gap-2">
                  <Search className="h-4 w-4" />
                  {t("admin_seo_generator_generate", "Generate")}
                </span>
              )}
            </Button>
          </div>
        </CardContent>
      </Card>

      {error && (
        <Card className="border-red-200 bg-red-50">
          <CardContent className="pt-6">
            <div className="flex items-center gap-2 text-red-700">
              <AlertCircle className="h-4 w-4" />
              <span>{error}</span>
            </div>
          </CardContent>
        </Card>
      )}

      {!seoData && !loading && !error && (
        <Card>
          <CardContent className="pt-6">
            <p className="text-center text-muted-foreground">
              {t("admin_seo_generator_no_data", "Enter a property ID to generate SEO data")}
            </p>
          </CardContent>
        </Card>
      )}

      <AnimatePresence>
        {seoData && (
          <m.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: 20 }}
          >
            <Tabs value={activeTab} onValueChange={setActiveTab}>
              <TabsList>
                <TabsTrigger value="seo" className="flex items-center gap-2">
                  <Code2 className="h-4 w-4" />
                  {t("admin_seo_generator_seo_tab", "SEO Data")}
                </TabsTrigger>
                <TabsTrigger value="investment" className="flex items-center gap-2">
                  <TrendingUp className="h-4 w-4" />
                  {t("admin_seo_generator_investment_tab", "Investment Score")}
                </TabsTrigger>
                <TabsTrigger value="yield" className="flex items-center gap-2">
                  <DollarSign className="h-4 w-4" />
                  {t("admin_seo_generator_yield_tab", "Rental Yield")}
                </TabsTrigger>
              </TabsList>

              <TabsContent value="seo">
                <Card>
                  <CardHeader>
                    <CardTitle className="flex items-center justify-between">
                      <span>{t("admin_seo_generator_seo_tab", "SEO Data")}</span>
                      <div className="flex items-center gap-2">
                        <Badge variant="outline" className={getGradeColor(seoData.investmentGrade)}>
                          {seoData.investmentGrade}
                        </Badge>
                        <span className={`text-sm font-semibold ${getScoreColor(seoData.yieldRate)}`}>
                          {seoData.yieldRate.toFixed(1)}% yield
                        </span>
                      </div>
                    </CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-4">
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                      <div className="space-y-2">
                        <Label className="text-muted-foreground">{t("admin_seo_generator_title_label", "Title")}</Label>
                        <p className="font-medium">{seoData.title}</p>
                      </div>
                      <div className="space-y-2">
                        <Label className="text-muted-foreground">URL</Label>
                        <p className="font-medium text-sm break-all">{seoData.url}</p>
                      </div>
                    </div>

                    <div className="space-y-2">
                      <Label className="text-muted-foreground">{t("admin_seo_generator_description_label", "Description")}</Label>
                      <p className="text-sm">{seoData.description}</p>
                    </div>

                    <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                      <div className="space-y-1">
                        <Label className="text-xs text-muted-foreground">Price</Label>
                        <p className="font-semibold">{seoData.currency} {seoData.price.toLocaleString()}</p>
                      </div>
                      <div className="space-y-1">
                        <Label className="text-xs text-muted-foreground">{t("admin_seo_generator_estimated_rent", "Estimated Rent")}</Label>
                        <p className="font-semibold">{seoData.currency} {seoData.estimatedRent.toLocaleString()}/mo</p>
                      </div>
                      <div className="space-y-1">
                        <Label className="text-xs text-muted-foreground">{t("admin_seo_generator_trust_score", "Trust Score")}</Label>
                        <p className="font-semibold">{seoData.trustScore.toFixed(0)}/100</p>
                      </div>
                      <div className="space-y-1">
                        <Label className="text-xs text-muted-foreground">{t("admin_seo_generator_occupancy", "Occupancy Rate")}</Label>
                        <p className="font-semibold">{(seoData.occupancyRate * 100).toFixed(0)}%</p>
                      </div>
                    </div>

                    <div className="space-y-2">
                      <div className="flex items-center justify-between">
                        <Label className="text-muted-foreground">{t("admin_seo_generator_json_ld", "JSON-LD")}</Label>
                        <Button variant="ghost" size="sm" onClick={copyJsonLd}>
                          {copiedJsonLd ? (
                            <Check className="h-4 w-4 text-emerald-600" />
                          ) : (
                            <Copy className="h-4 w-4" />
                          )}
                        </Button>
                      </div>
                      <pre className="rounded-lg bg-muted p-4 text-xs overflow-auto max-h-64">
                        {JSON.stringify(seoData.jsonLd, null, 2)}
                      </pre>
                    </div>
                  </CardContent>
                </Card>
              </TabsContent>

              <TabsContent value="investment">
                {investmentScore ? (
                  <Card>
                    <CardHeader>
                      <CardTitle className="flex items-center justify-between">
                        <span>{t("admin_seo_generator_investment_tab", "Investment Score")}</span>
                        <Badge variant="outline" className={getGradeColor(investmentScore.grade)}>
                          Grade: {investmentScore.grade}
                        </Badge>
                      </CardTitle>
                    </CardHeader>
                    <CardContent className="space-y-6">
                      <div className="flex items-center justify-center">
                        <div className="relative">
                          <svg className="h-40 w-40" viewBox="0 0 120 120">
                            <circle cx="60" cy="60" r="50" fill="none" stroke="currentColor" strokeWidth="8" className="text-muted" />
                            <circle
                              cx="60" cy="60" r="50" fill="none" strokeWidth="8" strokeLinecap="round"
                              className={getScoreColor(investmentScore.overallScore)}
                              stroke="currentColor"
                              strokeDasharray={`${(investmentScore.overallScore / 100) * 314} 314`}
                              transform="rotate(-90 60 60)"
                            />
                          </svg>
                          <div className="absolute inset-0 flex flex-col items-center justify-center">
                            <span className={`text-3xl font-bold ${getScoreColor(investmentScore.overallScore)}`}>
                              {investmentScore.overallScore}
                            </span>
                            <span className="text-xs text-muted-foreground">
                              {t("admin_seo_generator_overall_score", "Overall Score")}
                            </span>
                          </div>
                        </div>
                      </div>

                      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                        <ScoreBar label={t("admin_seo_generator_yield_score", "Yield Score")} score={investmentScore.yieldScore} />
                        <ScoreBar label={t("admin_seo_generator_location_score", "Location Score")} score={investmentScore.locationScore} />
                        <ScoreBar label={t("admin_seo_generator_demand_score", "Demand Score")} score={investmentScore.demandScore} />
                        <ScoreBar label={t("admin_seo_generator_risk_score", "Risk Score")} score={investmentScore.riskScore} />
                      </div>

                      <div className="space-y-2">
                        <Label className="text-muted-foreground">{t("admin_seo_generator_factors", "Key Factors")}</Label>
                        <ul className="space-y-1">
                          {investmentScore.factors.map((factor, i) => (
                            <li key={i} className="text-sm flex items-center gap-2">
                              <span className="h-1.5 w-1.5 rounded-full bg-blue-500" />
                              {factor}
                            </li>
                          ))}
                        </ul>
                      </div>

                      <div className="space-y-2">
                        <Label className="text-muted-foreground">{t("admin_seo_generator_recommendation", "Recommendation")}</Label>
                        <p className="text-sm bg-muted rounded-lg p-3">{investmentScore.recommendation}</p>
                      </div>
                    </CardContent>
                  </Card>
                ) : (
                  <Card>
                    <CardContent className="pt-6 text-center text-muted-foreground">
                      Investment score data unavailable
                    </CardContent>
                  </Card>
                )}
              </TabsContent>

              <TabsContent value="yield">
                {rentalYield ? (
                  <Card>
                    <CardHeader>
                      <CardTitle>{t("admin_seo_generator_yield_tab", "Rental Yield")}</CardTitle>
                    </CardHeader>
                    <CardContent className="space-y-6">
                      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                        <MetricCard
                          label={t("admin_seo_generator_gross_yield", "Gross Yield")}
                          value={`${rentalYield.grossYield.toFixed(2)}%`}
                          color="text-emerald-600"
                        />
                        <MetricCard
                          label={t("admin_seo_generator_net_yield", "Net Yield")}
                          value={`${rentalYield.netYield.toFixed(2)}%`}
                          color="text-blue-600"
                        />
                        <MetricCard
                          label={t("admin_seo_generator_monthly_rent", "Monthly Rent")}
                          value={`$${rentalYield.monthlyRent.toLocaleString()}`}
                          color="text-purple-600"
                        />
                        <MetricCard
                          label={t("admin_seo_generator_annual_rent", "Annual Rent")}
                          value={`$${rentalYield.annualRent.toLocaleString()}`}
                          color="text-orange-600"
                        />
                      </div>

                      <div className="space-y-2">
                        <Label className="text-muted-foreground">{t("admin_seo_generator_expenses", "Expenses")}</Label>
                        <div className="space-y-2">
                          {rentalYield.expenses.map((expense, i) => (
                            <div key={i} className="flex items-center justify-between text-sm bg-muted rounded-lg px-3 py-2">
                              <span>{expense.label}</span>
                              <span className="font-mono">${expense.amount.toLocaleString(undefined, { maximumFractionDigits: 0 })}</span>
                            </div>
                          ))}
                        </div>
                      </div>

                      <div className="grid grid-cols-2 gap-4">
                        <MetricCard
                          label={t("admin_seo_generator_break_even", "Break-Even (Months)")}
                          value={`${rentalYield.breakEvenMonths}`}
                          color="text-yellow-600"
                        />
                        <MetricCard
                          label={t("admin_seo_generator_cash_on_cash", "Cash-on-Cash Return")}
                          value={`${rentalYield.cashOnCashReturn.toFixed(2)}%`}
                          color="text-emerald-600"
                        />
                      </div>
                    </CardContent>
                  </Card>
                ) : (
                  <Card>
                    <CardContent className="pt-6 text-center text-muted-foreground">
                      Rental yield data unavailable
                    </CardContent>
                  </Card>
                )}
              </TabsContent>
            </Tabs>
          </m.div>
        )}
      </AnimatePresence>
    </div>
  );
}

function ScoreBar({ label, score }: { label: string; score: number }) {
  const color =
    score >= 80 ? "bg-emerald-500" : score >= 60 ? "bg-blue-500" : score >= 40 ? "bg-yellow-500" : "bg-red-500";

  return (
    <div className="space-y-2">
      <div className="flex items-center justify-between text-sm">
        <span className="text-muted-foreground">{label}</span>
        <span className="font-semibold">{score}</span>
      </div>
      <div className="h-2 rounded-full bg-muted overflow-hidden">
        <m.div
          className={`h-full rounded-full ${color}`}
          initial={{ width: 0 }}
          animate={{ width: `${score}%` }}
          transition={{ duration: 0.8, ease: "easeOut" }}
        />
      </div>
    </div>
  );
}

function MetricCard({ label, value, color }: { label: string; value: string; color: string }) {
  return (
    <div className="rounded-lg border p-3 space-y-1">
      <p className="text-xs text-muted-foreground">{label}</p>
      <p className={`text-lg font-bold ${color}`}>{value}</p>
    </div>
  );
}
