import type { Metadata } from "next";
import FinancialExpensesPage from "./FinancialExpensesPage";

export const metadata: Metadata = {
  title: "Expenses - Property Expense Tracking | Reservatior",
  description: "Track and manage property-related expenses and operational costs.",
  keywords: ["expenses","property costs","expense tracking","operational costs"],
  openGraph: {
    title: "Expenses - Property Expense Tracking | Reservatior",
    description: "Track and manage property-related expenses and operational costs.",
    type: "website",
  },
};

export default function FinancialExpensesPageWrapper() {
  return <FinancialExpensesPage />;
}
