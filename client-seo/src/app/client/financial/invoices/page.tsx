import type { Metadata } from "next";
import FinancialInvoicesPage from "@/app/[locale]/client/financial/invoices/FinancialInvoicesPage";

export const metadata: Metadata = {
  title: "Invoices - Billing & Invoicing | Reservatior",
  description: "Manage real estate invoices, billing, and payment collections.",
  keywords: ["invoices","billing","payment collection","invoicing"],
  openGraph: {
    title: "Invoices - Billing & Invoicing | Reservatior",
    description: "Manage real estate invoices, billing, and payment collections.",
    type: "website",
  },
};

export default function FinancialInvoicesPageWrapper() {
  return <FinancialInvoicesPage />;
}
