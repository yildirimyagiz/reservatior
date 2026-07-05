import type { Metadata } from "next";
import AdminInventoryPage from "./AdminInventoryPage";

export const metadata: Metadata = {
  title: "Property Inventory - Admin Panel | Reservatior",
  description: "Manage property inventory from the admin panel.",
  keywords: ["inventory","property","admin panel"],
  openGraph: {
    title: "Property Inventory - Admin Panel | Reservatior",
    description: "Manage property inventory from the admin panel.",
    type: "website",
  },
};

export default function AdminInventoryPageWrapper() {
  return <AdminInventoryPage />;
}
