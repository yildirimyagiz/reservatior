"use client";

import { InvestmentAIAssistant } from "@/components/investment/AIAssistant";

export default function AIAssistantPage() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold">Investment AI Assistant</h1>
        <p className="text-muted-foreground">
          Ask questions about property investment, market analysis, and ROI calculations.
        </p>
      </div>
      <InvestmentAIAssistant />
    </div>
  );
}
