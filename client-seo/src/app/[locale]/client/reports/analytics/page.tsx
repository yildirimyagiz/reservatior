import type { Metadata } from "next";
import { AnalyticsContent } from "./AnalyticsContent";

export const metadata: Metadata = {
  title: "Analytics - Reports & Analytics | Reservatior",
  description: "View analytics and reports for your property business. Track performance metrics and insights.",
  keywords: ["analytics", "reports", "performance metrics", "business insights"],
  openGraph: {
    title: "Analytics - Reports & Analytics | Reservatior",
    description: "View analytics and reports for your property business.",
    type: "website",
  },
};

export default function AnalyticsPage() {
  return <AnalyticsContent />;
}
