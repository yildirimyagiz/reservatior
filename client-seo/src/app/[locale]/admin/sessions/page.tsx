import type { Metadata } from "next";
import AdminSessionsPage from "./AdminSessionsPage";

export const metadata: Metadata = {
  title: "Sessions - Admin Panel | Reservatior",
  description: "Manage active user sessions, force logout, and monitor session activity.",
  keywords: ["sessions","admin panel","user sessions","session management"],
  openGraph: {
    title: "Sessions - Admin Panel | Reservatior",
    description: "Manage active user sessions, force logout, and monitor session activity.",
    type: "website",
  },
};

export default function AdminSessionsPageWrapper() {
  return <AdminSessionsPage />;
}
