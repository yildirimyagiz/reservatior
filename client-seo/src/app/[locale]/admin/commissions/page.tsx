import type { Metadata } from "next";
import CommissionsPage from "./CommissionsPage";

export const metadata: Metadata = {
  title: "Commerce Commissions - Admin Panel | Reservatior",
  description: "Track and manage commission calculations, approvals, and payouts",
  keywords: ["commissions", "payouts", "revenue", "admin"],
  openGraph: {
    title: "Commerce Commissions - Admin Panel | Reservatior",
    description: "Track and manage commission calculations, approvals, and payouts",
    type: "website",
  },
};

export default function CommissionsPageWrapper() {
  return <CommissionsPage />;
}
