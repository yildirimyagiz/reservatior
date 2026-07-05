import type { Metadata } from "next";
import AdminSystemMetricsPage from "./AdminSystemMetricsPage";

export const metadata: Metadata = {
  title: "System Metrics - Admin Panel | Reservatior",
  description: "Monitor system performance and metrics from the admin panel.",
  keywords: ["system", "metrics", "performance", "admin panel"],
  openGraph: {
    title: "System Metrics - Admin Panel | Reservatior",
    description: "Monitor system performance and metrics from the admin panel.",
    type: "website",
  },
};

export default function AdminSystemMetricsPageWrapper() {
  return <AdminSystemMetricsPage />;
}
