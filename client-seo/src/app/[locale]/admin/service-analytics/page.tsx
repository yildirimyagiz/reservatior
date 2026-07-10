import type { Metadata } from "next";
import AdminServiceAnalyticsPage from "./AdminServiceAnalyticsPage";

export const metadata: Metadata = {
  title: "AI Service Analytics - Admin Panel | Reservatior",
  description: "Monitor AI service performance and analytics from the admin panel.",
  keywords: ["AI", "service", "analytics", "performance", "admin panel"],
  openGraph: {
    title: "AI Service Analytics - Admin Panel | Reservatior",
    description: "Monitor AI service performance and analytics from the admin panel.",
    type: "website",
  },
};

export default function AdminServiceAnalyticsPageWrapper() {
  return <AdminServiceAnalyticsPage />;
}
