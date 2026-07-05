import type { Metadata } from "next";
import AdminEscrowPage from "./AdminEscrowPage";

export const metadata: Metadata = {
  title: "Escrow Management - Admin Panel | Reservatior",
  description: "Manage escrow accounts, deposits, and disbursements.",
  keywords: ["escrow","admin panel","deposits","disbursements"],
  openGraph: {
    title: "Escrow Management - Admin Panel | Reservatior",
    description: "Manage escrow accounts, deposits, and disbursements.",
    type: "website",
  },
};

export default function AdminEscrowPageWrapper() {
  return <AdminEscrowPage />;
}
