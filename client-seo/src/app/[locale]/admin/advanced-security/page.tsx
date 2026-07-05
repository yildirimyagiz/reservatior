import type { Metadata } from "next";
import AdminAdvancedSecurityPage from "./AdminAdvancedSecurityPage";

export const metadata: Metadata = {
  title: "Advanced Security - Admin Panel | Reservatior",
  description: "Manage advanced security settings, policies, and threat detection.",
  keywords: ["advanced security","admin panel","threat detection","security policies"],
  openGraph: {
    title: "Advanced Security - Admin Panel | Reservatior",
    description: "Manage advanced security settings, policies, and threat detection.",
    type: "website",
  },
};

export default function AdminAdvancedSecurityPageWrapper() {
  return <AdminAdvancedSecurityPage />;
}
