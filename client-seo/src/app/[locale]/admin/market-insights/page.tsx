import type { Metadata } from "next";
import AdminMarketInsightsPage from "./AdminMarketInsightsPage";

export const metadata: Metadata = {
  title: "Market Insights - Admin Panel | Reservatior",
  description: "AI-powered market analysis and insights from the admin panel.",
  keywords: ["market", "insights", "analysis", "AI", "admin panel"],
  openGraph: {
    title: "Market Insights - Admin Panel | Reservatior",
    description: "AI-powered market analysis and insights from the admin panel.",
    type: "website",
  },
};

export default function AdminMarketInsightsPageWrapper() {
  return <AdminMarketInsightsPage />;
}
