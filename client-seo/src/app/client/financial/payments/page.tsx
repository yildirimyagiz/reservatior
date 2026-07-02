import type { Metadata } from "next";
import FinancialPaymentsPage from "@/app/[locale]/client/financial/payments/FinancialPaymentsPage";

export const metadata: Metadata = {
  title: "Payments - Transaction Management | Reservatior",
  description: "Track and manage real estate payments, transactions, and payment history.",
  keywords: ["payments","transactions","payment history","payment tracking"],
  openGraph: {
    title: "Payments - Transaction Management | Reservatior",
    description: "Track and manage real estate payments, transactions, and payment history.",
    type: "website",
  },
};

export default function FinancialPaymentsPageWrapper() {
  return <FinancialPaymentsPage />;
}
