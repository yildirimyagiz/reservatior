import type { Metadata } from "next";
import { AIValuationContent } from "@/app/[locale]/client/ai/valuation/AIValuationContent";

export const metadata: Metadata = {
  title: "AI Valuation - Property Valuation AI | Reservatior",
  description: "Get AI-powered property valuations with advanced machine learning models. Accurate, fast, and data-driven property price estimates.",
  keywords: ["AI valuation", "property valuation", "price estimation", "real estate AI", "property value"],
  openGraph: {
    title: "AI Valuation - Property Valuation AI | Reservatior",
    description: "Get AI-powered property valuations with advanced machine learning models.",
    type: "website",
  },
};

export const revalidate = 3600;

export default function AIValuationPage() {
  return <AIValuationContent />;
}
