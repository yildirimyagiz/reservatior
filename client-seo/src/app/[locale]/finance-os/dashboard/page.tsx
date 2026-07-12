import type { Metadata } from "next";
import FinanceDashboard from "@/pages-spa/finance_os/Dashboard";

export const metadata: Metadata = {
  title: "Finance OS Dashboard | Reservatior",
  description: "Real-time escrow, payouts, and float management across all markets.",
};

export default function FinanceDashboardPage() {
  return <FinanceDashboard />;
}
