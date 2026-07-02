import type { Metadata } from "next";
import AdminUsersPage from "./AdminUsersPage";

export const metadata: Metadata = {
  title: "User Management - Admin Panel | Reservatior",
  description: "Manage platform users, permissions, and roles from the admin control panel.",
  keywords: ["user management","admin panel","user roles","permissions"],
  openGraph: {
    title: "User Management - Admin Panel | Reservatior",
    description: "Manage platform users, permissions, and roles from the admin control panel.",
    type: "website",
  },
};

export default function AdminUsersPageWrapper() {
  return <AdminUsersPage />;
}
