import type { Metadata } from "next";
import AdminDashboardPage from "./AdminDashboardPage";

export const metadata: Metadata = {
  title: "Admin Dashboard - Platform Overview | Reservatior",
  description: "Platform-wide analytics, system health monitoring, and administrative controls.",
  keywords: ["admin dashboard","analytics","system health","platform overview"],
  openGraph: {
    title: "Admin Dashboard - Platform Overview | Reservatior",
    description: "Platform-wide analytics, system health monitoring, and administrative controls.",
    type: "website",
  },
};

export default function AdminDashboardPageWrapper() {
  return <AdminDashboardPage />;
}
