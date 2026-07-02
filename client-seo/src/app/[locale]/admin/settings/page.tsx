import type { Metadata } from "next";
import AdminSettingsPage from "./AdminSettingsPage";

export const metadata: Metadata = {
  title: "System Settings - Admin Panel | Reservatior",
  description: "Configure system settings, security policies, and platform preferences.",
  keywords: ["system settings","admin panel","configuration","security"],
  openGraph: {
    title: "System Settings - Admin Panel | Reservatior",
    description: "Configure system settings, security policies, and platform preferences.",
    type: "website",
  },
};

export default function AdminSettingsPageWrapper() {
  return <AdminSettingsPage />;
}
