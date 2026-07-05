import type { Metadata } from "next";
import AdminRolesPage from "./AdminRolesPage";

export const metadata: Metadata = {
  title: "Roles - Admin Panel | Reservatior",
  description: "Manage user roles from the admin panel.",
  keywords: ["roles","permissions","admin panel"],
  openGraph: {
    title: "Roles - Admin Panel | Reservatior",
    description: "Manage user roles from the admin panel.",
    type: "website",
  },
};

export default function AdminRolesPageWrapper() {
  return <AdminRolesPage />;
}
