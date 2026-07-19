import type { Metadata } from "next";
import SuppliersPage from "./SuppliersPage";

export const metadata: Metadata = {
  title: "Suppliers - Admin Panel | Reservatior",
  description: "Manage supplier directory, contacts, and commission rates",
  keywords: ["suppliers", "vendors", "commerce", "admin"],
  openGraph: {
    title: "Suppliers - Admin Panel | Reservatior",
    description: "Manage supplier directory, contacts, and commission rates",
    type: "website",
  },
};

export default function SuppliersPageWrapper() {
  return <SuppliersPage />;
}
