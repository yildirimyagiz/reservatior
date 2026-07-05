import type { Metadata } from "next";
import AdminSecurityPage from "./AdminSecurityPage";

export const metadata: Metadata = {
  title: "Security Overview - Admin Panel | Reservatior",
  description: "View security overview and monitor threats from the admin panel.",
  keywords: ["security","overview","monitoring","admin panel"],
  openGraph: {
    title: "Security Overview - Admin Panel | Reservatior",
    description: "View security overview and monitor threats from the admin panel.",
    type: "website",
  },
};

export default function AdminSecurityPageWrapper() {
  return <AdminSecurityPage />;
}
