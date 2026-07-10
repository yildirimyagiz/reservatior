import type { Metadata } from "next";
import AdminVideoPartnershipsPage from "./AdminVideoPartnershipsPage";

export const metadata: Metadata = {
  title: "Video Vendor Partnerships - Admin Panel | Reservatior",
  description: "Manage partnerships with video production vendors from the admin panel.",
  keywords: ["video", "partnerships", "vendors", "admin panel"],
  openGraph: {
    title: "Video Vendor Partnerships - Admin Panel | Reservatior",
    description: "Manage partnerships with video production vendors from the admin panel.",
    type: "website",
  },
};

export default function AdminVideoPartnershipsPageWrapper() {
  return <AdminVideoPartnershipsPage />;
}
