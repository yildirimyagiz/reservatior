import type { Metadata } from "next";
import AdminPage from "./AdminPage";

export const metadata: Metadata = {
  title: "Admin Dashboard - System Management | Reservatior",
  description: "Manage your Reservatior platform with comprehensive admin controls, user management, and system monitoring.",
  keywords: ["admin","dashboard","system management","user management"],
  openGraph: {
    title: "Admin Dashboard - System Management | Reservatior",
    description: "Manage your Reservatior platform with comprehensive admin controls, user management, and system monitoring.",
    type: "website",
  },
};

export default function AdminPageWrapper() {
  return <AdminPage />;
}
