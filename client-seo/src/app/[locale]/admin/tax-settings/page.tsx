import type { Metadata } from "next";
import AdminTaxSettingsPage from "./AdminTaxSettingsPage";

export const metadata: Metadata = {
  title: "Tax Settings - Admin Panel | Reservatior",
  description: "Configure global tax settings and compliance from the admin panel.",
  keywords: ["tax", "settings", "compliance", "admin panel"],
  openGraph: {
    title: "Tax Settings - Admin Panel | Reservatior",
    description: "Configure global tax settings and compliance from the admin panel.",
    type: "website",
  },
};

export default function AdminTaxSettingsPageWrapper() {
  return <AdminTaxSettingsPage />;
}
