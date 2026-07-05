import type { Metadata } from "next";
import AdminFinancialReportsPage from "./AdminFinancialReportsPage";

export const metadata: Metadata = {
  title: "Financial Reports - Admin Panel | Reservatior",
  description: "Generate and view financial reports, statements, and analytics.",
  keywords: ["financial reports","admin panel","statements","analytics"],
  openGraph: {
    title: "Financial Reports - Admin Panel | Reservatior",
    description: "Generate and view financial reports, statements, and analytics.",
    type: "website",
  },
};

export default function AdminFinancialReportsPageWrapper() {
  return <AdminFinancialReportsPage />;
}
