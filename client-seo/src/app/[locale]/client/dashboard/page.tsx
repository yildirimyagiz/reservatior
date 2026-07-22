import type { Metadata } from "next";
import { Suspense } from "react";
import dynamic from "next/dynamic";

const Dashboard = dynamic(() => import("./Dashboard"), {
  loading: () => (
    <div className="p-6 flex items-center justify-center min-h-[400px]">
      <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
    </div>
  ),
});

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
  return (
    <Suspense fallback={
      <div className="p-6 flex items-center justify-center min-h-[400px]">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
      </div>
    }>
      <Dashboard />
    </Suspense>
  );
}
