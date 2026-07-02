import type { Metadata } from "next";
import FinancialPage from "@/app/[locale]/client/financial/FinancialPage";

export const metadata: Metadata = {
  title: "Financial Overview - Real Estate Finance | Reservatior",
  description: "Track your real estate financials including revenue, expenses, payments, and invoices.",
  keywords: ["financial","revenue","expenses","payments","invoices"],
  openGraph: {
    title: "Financial Overview - Real Estate Finance | Reservatior",
    description: "Track your real estate financials including revenue, expenses, payments, and invoices.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export default function FinancialPageWrapper() {
  return <FinancialPage />;
}
