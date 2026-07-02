import type { Metadata } from "next";
import AdminFinancialPage from "./AdminFinancialPage";

export const metadata: Metadata = {
  title: "Financial Management - Admin Panel | Reservatior",
  description: "Oversee platform financials, transactions, and revenue analytics from the admin panel.",
  keywords: ["financial management","admin panel","revenue","transactions"],
  openGraph: {
    title: "Financial Management - Admin Panel | Reservatior",
    description: "Oversee platform financials, transactions, and revenue analytics from the admin panel.",
    type: "website",
  },
};

export default function AdminFinancialPageWrapper() {
  return <AdminFinancialPage />;
}
