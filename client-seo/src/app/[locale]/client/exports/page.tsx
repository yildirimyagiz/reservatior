import type { Metadata } from "next";
import { ExportsContent } from "./ExportsContent";

export const metadata: Metadata = {
  title: "Exports - Data Exports | Reservatior",
  description: "Export data from your account. Generate reports and download data in various formats.",
  keywords: ["exports", "data export", "report generation", "data download"],
  openGraph: {
    title: "Exports - Data Exports | Reservatior",
    description: "Export data from your account.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export default function ExportsPage() {
  return <ExportsContent />;
}
