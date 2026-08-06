"use client";

import { useState, useCallback } from "react";
import {
  FileText,
  Download,
  Mail,
  TrendingUp,
  AlertTriangle,
  CheckCircle,
  Building2,
  BarChart3,
  Loader2,
  Share2,
} from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useInvestmentIntelligenceStore } from "@/lib/investment-intelligence-store";
import { formatCurrency } from "@/lib/seo/market-data";
import { investmentIntelligenceApi } from "@/lib/api/investment-intelligence";

interface InvestmentReportGeneratorProps {
  embedded?: boolean;
}

export function InvestmentReportGenerator({ embedded = false }: InvestmentReportGeneratorProps) {
  const { roiInput, roiOutput, report, generateInvestmentReport, isGeneratingReport } =
    useInvestmentIntelligenceStore();
  const [email, setEmail] = useState("");
  const [showEmailForm, setShowEmailForm] = useState(false);

  const handleGenerate = useCallback(async () => {
    await generateInvestmentReport(email || undefined);
  }, [generateInvestmentReport, email]);

  const handleExportPDF = useCallback(async () => {
    if (!report) return;
    try {
      const blob = await investmentIntelligenceApi.exportReportPdf(report.id);
      const url = URL.createObjectURL(blob);
      const a = document.createElement("a");
      a.href = url;
      a.download = `${report.title.replace(/\s+/g, "-").toLowerCase()}-report.pdf`;
      a.click();
      URL.revokeObjectURL(url);
    } catch {
      // silent fail
    }
  }, [report]);

  if (!roiOutput) {
    return (
      <Card className="max-w-2xl mx-auto">
        <CardContent className="text-center p-8">
          <FileText className="w-16 h-16 mx-auto mb-4 text-muted-foreground/30" />
          <p className="text-lg font-medium">Run a calculation first to generate your report</p>
          <p className="text-sm text-muted-foreground/70 mt-2">
            The ROI Calculator will provide data for your investment report
          </p>
        </CardContent>
      </Card>
    );
  }

  if (report) {
    return (
      <div className="max-w-4xl mx-auto space-y-6">
        <div className="flex items-center justify-between">
          <div>
            <h2 className="text-2xl font-bold">{report.title}</h2>
            <p className="text-muted-foreground">
              Generated {new Date(report.generatedAt).toLocaleDateString()}
            </p>
          </div>
          <div className="flex gap-2">
            <Button variant="outline" size="sm" onClick={handleExportPDF}>
              <Download className="w-4 h-4 mr-1" />
              PDF
            </Button>
            <Button variant="outline" size="sm">
              <Share2 className="w-4 h-4 mr-1" />
              Share
            </Button>
          </div>
        </div>

        {/* Score Cards */}
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
          <Card>
            <CardContent className="p-4 text-center">
              <p className="text-sm text-muted-foreground">Investment Score</p>
              <p className="text-3xl font-bold text-primary">{report.investmentScore}/100</p>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="p-4 text-center">
              <p className="text-sm text-muted-foreground">Risk Level</p>
              <Badge
                className={`text-lg mt-1 ${
                  report.riskLevel === "LOW"
                    ? "bg-success/20 text-success"
                    : report.riskLevel === "MEDIUM"
                    ? "bg-yellow-500/20 text-yellow-400"
                    : "bg-red-500/20 text-red-400"
                }`}
              >
                {report.riskLevel}
              </Badge>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="p-4 text-center">
              <p className="text-sm text-muted-foreground">Expected Return</p>
              <p className="text-3xl font-bold text-success">{report.expectedReturn}%</p>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="p-4 text-center">
              <p className="text-sm text-muted-foreground">Grade</p>
              <p className="text-3xl font-bold">{report.roi.investmentGrade}</p>
            </CardContent>
          </Card>
        </div>

        {/* Market Analysis */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <BarChart3 className="w-5 h-5" />
              Market Analysis
            </CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-muted-foreground leading-relaxed">{report.marketAnalysis}</p>
          </CardContent>
        </Card>

        {/* Rental Potential */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <TrendingUp className="w-5 h-5" />
              Rental Potential
            </CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-muted-foreground leading-relaxed">{report.rentalPotential}</p>
          </CardContent>
        </Card>

        {/* Comparable Properties */}
        {report.comparableProperties.length > 0 && (
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Building2 className="w-5 h-5" />
                Comparable Properties
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="overflow-x-auto">
                <table className="w-full text-sm">
                  <thead>
                    <tr className="border-b text-muted-foreground">
                      <th className="text-left py-2">Property</th>
                      <th className="text-right py-2">Price</th>
                      <th className="text-right py-2">Rent</th>
                      <th className="text-right py-2">Yield</th>
                    </tr>
                  </thead>
                  <tbody>
                    {report.comparableProperties.map((comp, i) => (
                      <tr key={i} className="border-b border-border/50">
                        <td className="py-2 font-medium">{comp.name}</td>
                        <td className="text-right py-2">{formatCurrency(comp.price, roiInput.currency)}</td>
                        <td className="text-right py-2">{formatCurrency(comp.rent, roiInput.currency)}/mo</td>
                        <td className="text-right py-2 text-success">{comp.yield}%</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </CardContent>
          </Card>
        )}

        {/* Recommendations */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <CheckCircle className="w-5 h-5" />
              Recommendations
            </CardTitle>
          </CardHeader>
          <CardContent>
            <ul className="space-y-3">
              {report.recommendations.map((rec, i) => (
                <li key={i} className="flex items-start gap-2">
                  <CheckCircle className="w-4 h-4 mt-0.5 text-success shrink-0" />
                  <span className="text-muted-foreground">{rec}</span>
                </li>
              ))}
            </ul>
          </CardContent>
        </Card>

        {/* CTA: Rental Management */}
        <Card className="border-primary/30 bg-primary/5">
          <CardContent className="p-6 text-center">
            <h3 className="text-lg font-bold mb-2">Ready to Invest?</h3>
            <p className="text-muted-foreground mb-4">
              Let us manage your property after purchase. Full-service rental management with guaranteed occupancy.
            </p>
            <Button size="lg">
              Get Rental Management Quote
            </Button>
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <Card className="max-w-2xl mx-auto">
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <FileText className="w-5 h-5" />
          Generate Investment Report
        </CardTitle>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="grid grid-cols-2 gap-4">
          <div className="p-3 rounded-lg bg-muted/50">
            <p className="text-xs text-muted-foreground">Gross Yield</p>
            <p className="font-bold">{roiOutput.grossRentalYield}%</p>
          </div>
          <div className="p-3 rounded-lg bg-muted/50">
            <p className="text-xs text-muted-foreground">Total ROI</p>
            <p className="font-bold">{roiOutput.totalROI}%</p>
          </div>
          <div className="p-3 rounded-lg bg-muted/50">
            <p className="text-xs text-muted-foreground">Grade</p>
            <p className="font-bold">{roiOutput.investmentGrade}</p>
          </div>
          <div className="p-3 rounded-lg bg-muted/50">
            <p className="text-xs text-muted-foreground">Risk Score</p>
            <p className="font-bold">{roiOutput.riskScore}/100</p>
          </div>
        </div>

        {showEmailForm ? (
          <div className="space-y-3">
            <Label>Email for report delivery</Label>
            <Input
              type="email"
              placeholder="your@email.com"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
            />
            <div className="flex gap-2">
              <Button onClick={handleGenerate} disabled={isGeneratingReport || !email} className="flex-1">
                {isGeneratingReport ? (
                  <Loader2 className="w-4 h-4 mr-2 animate-spin" />
                ) : (
                  <Mail className="w-4 h-4 mr-2" />
                )}
                {isGeneratingReport ? "Generating..." : "Generate & Send Report"}
              </Button>
              <Button variant="outline" onClick={() => setShowEmailForm(false)}>
                Cancel
              </Button>
            </div>
          </div>
        ) : (
          <div className="flex gap-2">
            <Button onClick={handleGenerate} disabled={isGeneratingReport} className="flex-1">
              {isGeneratingReport ? (
                <Loader2 className="w-4 h-4 mr-2 animate-spin" />
              ) : (
                <FileText className="w-4 h-4 mr-2" />
              )}
              {isGeneratingReport ? "Generating..." : "Generate Report"}
            </Button>
            <Button variant="outline" onClick={() => setShowEmailForm(true)}>
              <Mail className="w-4 h-4 mr-2" />
              Email Report
            </Button>
          </div>
        )}
      </CardContent>
    </Card>
  );
}
