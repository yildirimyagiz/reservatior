"use client";

import { InvestmentReportGenerator } from "@/components/investment/InvestmentReport";

export default function ReportsPage() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold">Investment Reports</h1>
        <p className="text-muted-foreground">
          AI-generated investment analysis reports with market comparisons and recommendations.
        </p>
      </div>
      <InvestmentReportGenerator />
    </div>
  );
}
