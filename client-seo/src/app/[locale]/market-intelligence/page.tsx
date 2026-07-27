import type { Metadata } from "next";
import Dashboard from "./Dashboard";

export const metadata: Metadata = {
  title: "Market Intelligence | Reservatior",
  description: "Real-time market analysis with AI-driven demand index, price trends, yield comparisons across global markets.",
  keywords: ["market", "intelligence", "AI", "analysis", "demand", "yield", "real estate"],
};

export default function MarketIntelligencePage() {
  return <Dashboard />;
}
