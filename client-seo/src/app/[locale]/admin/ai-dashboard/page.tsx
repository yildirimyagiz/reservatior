import type { Metadata } from "next";
import AdminAIDashboardPage from "./AdminAIDashboardPage";

export const metadata: Metadata = {
  title: "AI Dashboard - Admin Panel | Reservatior",
  description: "AI-powered insights and automation dashboard for the admin panel.",
  keywords: ["ai","dashboard","admin panel"],
  openGraph: {
    title: "AI Dashboard - Admin Panel | Reservatior",
    description: "AI-powered insights and automation dashboard for the admin panel.",
    type: "website",
  },
};

export default function AdminAIDashboardPageWrapper() {
  return <AdminAIDashboardPage />;
}
