import type { Metadata } from "next";
import Dashboard from "./Dashboard";

export const metadata: Metadata = {
  title: "Property Intelligence | Reservatior",
  description: "AI-powered property intelligence scores, investment analysis, and neighborhood insights for every listed property.",
  keywords: ["property", "intelligence", "AI", "investment", "analysis", "neighborhood", "score"],
  openGraph: {
    title: "Property Intelligence | Reservatior",
    description: "AI-powered property intelligence scores and investment analysis.",
    type: "website",
  },
};

export default function PropertyIntelligencePage() {
  return <Dashboard />;
}
