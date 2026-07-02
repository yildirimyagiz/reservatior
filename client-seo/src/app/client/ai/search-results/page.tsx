import type { Metadata } from "next";
import { Suspense } from "react";
import { AISearchResultsContent } from "@/app/[locale]/client/ai/search-results/AISearchResultsContent";

export const metadata: Metadata = {
  title: "AI Search Results - Intelligent Property Search | Reservatior",
  description: "View AI-powered property search results with intelligent filtering, analysis, and personalized recommendations based on your natural language query.",
  keywords: ["AI search", "property search results", "intelligent search", "natural language search", "real estate AI"],
  openGraph: {
    title: "AI Search Results - Intelligent Property Search | Reservatior",
    description: "View AI-powered property search results with intelligent filtering and analysis.",
    type: "website",
  },
};

export default function AISearchResultsPage() {
  return (
    <Suspense fallback={<div className="min-h-screen bg-[#0A0A0B] flex items-center justify-center"><div className="w-8 h-8 border-4 border-purple-500/20 border-t-purple-500 rounded-full animate-spin" /></div>}>
      <AISearchResultsContent />
    </Suspense>
  );
}
