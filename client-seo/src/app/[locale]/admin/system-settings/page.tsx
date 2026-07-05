import type { Metadata } from "next";
import AdminSystemSettingsPage from "./AdminSystemSettingsPage";

export const metadata: Metadata = {
  title: "System Settings - Admin Panel | Reservatior",
  description: "Configure system-wide settings from the admin panel.",
  keywords: ["system","settings","admin panel"],
  openGraph: {
    title: "System Settings - Admin Panel | Reservatior",
    description: "Configure system-wide settings from the admin panel.",
    type: "website",
  },
};

export default function AdminSystemSettingsPageWrapper() {
  return <AdminSystemSettingsPage />;
}
