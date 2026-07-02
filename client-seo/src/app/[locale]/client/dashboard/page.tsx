import type { Metadata } from "next";
import Dashboard from "./Dashboard";

export const metadata: Metadata = {
  title: "Dashboard - Property Management Overview | Reservatior",
  description: "Your personal Reservatior dashboard with revenue analytics, property stats, and AI-powered insights.",
  keywords: ["dashboard","property management","analytics","revenue overview"],
  openGraph: {
    title: "Dashboard - Property Management Overview | Reservatior",
    description: "Your personal Reservatior dashboard with revenue analytics, property stats, and AI-powered insights.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export default function DashboardPage() {
  return <Dashboard />;
}
