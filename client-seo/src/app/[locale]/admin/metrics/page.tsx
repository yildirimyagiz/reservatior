import type { Metadata } from "next";
import AdminMetricsPage from "./AdminMetricsPage";

export const metadata: Metadata = {
  title: "System Metrics - Admin Panel | Reservatior",
  description: "Monitor system performance metrics from the admin panel.",
  keywords: ["metrics","system","admin panel"],
  openGraph: {
    title: "System Metrics - Admin Panel | Reservatior",
    description: "Monitor system performance metrics from the admin panel.",
    type: "website",
  },
};

export default function AdminMetricsPageWrapper() {
  return <AdminMetricsPage />;
}
