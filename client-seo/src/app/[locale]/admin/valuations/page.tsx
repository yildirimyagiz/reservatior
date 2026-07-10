import type { Metadata } from "next";
import AdminValuationsPage from "./AdminValuationsPage";

export const metadata: Metadata = {
  title: "AI Valuations - Admin Panel | Reservatior",
  description: "AI-powered property value estimates and market analysis from the admin panel.",
  keywords: ["valuations", "AI", "property value", "market analysis", "admin panel"],
  openGraph: {
    title: "AI Valuations - Admin Panel | Reservatior",
    description: "AI-powered property value estimates and market analysis from the admin panel.",
    type: "website",
  },
};

export default function AdminValuationsPageWrapper() {
  return <AdminValuationsPage />;
}
