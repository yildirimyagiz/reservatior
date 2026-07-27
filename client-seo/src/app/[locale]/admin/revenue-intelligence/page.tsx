import type { Metadata } from "next";
import Dashboard from "./Dashboard";

export const metadata: Metadata = {
  title: "Revenue Intelligence - Admin Panel | Reservatior",
  description: "AI-powered revenue intelligence and optimization dashboard for the admin panel.",
  keywords: ["revenue", "intelligence", "optimization", "analytics", "admin panel"],
  openGraph: {
    title: "Revenue Intelligence - Admin Panel | Reservatior",
    description: "AI-powered revenue intelligence and optimization dashboard for the admin panel.",
    type: "website",
  },
};

export default function RevenueIntelligencePage() {
  return <Dashboard />;
}
