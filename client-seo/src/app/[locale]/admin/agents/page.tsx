import type { Metadata } from "next";
import AdminAgentsPage from "./AdminAgentsPage";

export const metadata: Metadata = {
  title: "Agent Management - Admin Panel | Reservatior",
  description: "Manage platform agents from the admin panel.",
  keywords: ["agents","management","admin panel"],
  openGraph: {
    title: "Agent Management - Admin Panel | Reservatior",
    description: "Manage platform agents from the admin panel.",
    type: "website",
  },
};

export default function AdminAgentsPageWrapper() {
  return <AdminAgentsPage />;
}
