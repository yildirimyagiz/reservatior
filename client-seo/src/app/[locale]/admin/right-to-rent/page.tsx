import type { Metadata } from "next";
import AdminRightToRentPage from "./AdminRightToRentPage";

export const metadata: Metadata = {
  title: "Right to Rent - Admin Panel | Reservatior",
  description: "Manage right-to-rent checks, tenant verification, and compliance records.",
  keywords: ["right to rent","admin panel","tenant verification","compliance"],
  openGraph: {
    title: "Right to Rent - Admin Panel | Reservatior",
    description: "Manage right-to-rent checks, tenant verification, and compliance records.",
    type: "website",
  },
};

export default function AdminRightToRentPageWrapper() {
  return <AdminRightToRentPage />;
}
