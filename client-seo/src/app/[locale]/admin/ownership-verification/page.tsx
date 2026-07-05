import type { Metadata } from "next";
import AdminOwnershipVerificationPage from "./AdminOwnershipVerificationPage";

export const metadata: Metadata = {
  title: "Ownership Verification - Admin Panel | Reservatior",
  description: "Verify property ownership from the admin panel.",
  keywords: ["ownership","verification","admin panel"],
  openGraph: {
    title: "Ownership Verification - Admin Panel | Reservatior",
    description: "Verify property ownership from the admin panel.",
    type: "website",
  },
};

export default function AdminOwnershipVerificationPageWrapper() {
  return <AdminOwnershipVerificationPage />;
}
