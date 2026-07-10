import type { Metadata } from "next";
import AdminVideoVendorsPage from "./AdminVideoVendorsPage";

export const metadata: Metadata = {
  title: "Video Vendors - Admin Panel | Reservatior",
  description: "Manage AI video generation vendors from the admin panel.",
  keywords: ["video", "vendors", "AI", "generation", "admin panel"],
  openGraph: {
    title: "Video Vendors - Admin Panel | Reservatior",
    description: "Manage AI video generation vendors from the admin panel.",
    type: "website",
  },
};

export default function AdminVideoVendorsPageWrapper() {
  return <AdminVideoVendorsPage />;
}
