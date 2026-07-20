import type { Metadata } from "next";
import AnalyticsDashboard from "@/pages-spa/analytics_os/Dashboard";

export const metadata: Metadata = {
  title: "Analytics OS Dashboard | Reservatior",
  description: "Revenue intelligence, user behavior analysis, and custom report builder.",
};

export default function AnalyticsDashboardPage() {
  return <AnalyticsDashboard />;
}
