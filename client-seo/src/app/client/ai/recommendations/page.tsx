import type { Metadata } from "next";
import { AIRecommendationsContent } from "@/app/[locale]/client/ai/recommendations/AIRecommendationsContent";


export const metadata: Metadata = {
  title: "AI Recommendations - Smart Property Suggestions | Reservatior",
  description: "Get AI-powered property recommendations based on your preferences, search history, and market trends. Personalized property suggestions.",
  keywords: ["AI recommendations", "property suggestions", "smart search", "personalized properties", "real estate AI"],
  openGraph: {
    title: "AI Recommendations - Smart Property Suggestions | Reservatior",
    description: "Get AI-powered property recommendations based on your preferences.",
    type: "website",
  },
};

export default function AIRecommendationsPage() {
  return <AIRecommendationsContent />;
}
