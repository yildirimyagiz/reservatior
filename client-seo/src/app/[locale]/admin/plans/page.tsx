import type { Metadata } from "next";
import AdminPlansPage from "./AdminPlansPage";

export const metadata: Metadata = {
  title: "Plans & Subscriptions - Admin Panel | Reservatior",
  description: "Manage subscription plans, pricing tiers, and billing configurations.",
  keywords: ["plans","subscriptions","admin panel","pricing","billing"],
  openGraph: {
    title: "Plans & Subscriptions - Admin Panel | Reservatior",
    description: "Manage subscription plans, pricing tiers, and billing configurations.",
    type: "website",
  },
};

export default function AdminPlansPageWrapper() {
  return <AdminPlansPage />;
}
