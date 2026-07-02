import type { Metadata } from "next";
import { ReportsContent } from "./ReportsContent";

export const metadata: Metadata = {
  title: "Reports - Business Reports | Reservatior",
  description: "Access all reports and analytics for your property business. View performance metrics and insights.",
  keywords: ["reports", "business reports", "analytics", "performance"],
  openGraph: {
    title: "Reports - Business Reports | Reservatior",
    description: "Access all reports and analytics for your property business.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export default function ReportsPage() {
  return <ReportsContent />;
}
