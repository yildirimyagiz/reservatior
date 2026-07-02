import type { Metadata } from "next";
import FinancialReportsPage from "./FinancialReportsPage";

export const metadata: Metadata = {
  title: "Financial Reports - Analytics & Reporting | Reservatior",
  description: "Generate and view financial reports, analytics, and performance summaries.",
  keywords: ["financial reports","analytics","reporting","performance summaries"],
  openGraph: {
    title: "Financial Reports - Analytics & Reporting | Reservatior",
    description: "Generate and view financial reports, analytics, and performance summaries.",
    type: "website",
  },
};

export default function FinancialReportsPageWrapper() {
  return <FinancialReportsPage />;
}
