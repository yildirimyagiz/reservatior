import type { Metadata } from "next";
import AdminCouponsPage from "./AdminCouponsPage";

export const metadata: Metadata = {
  title: "Coupons Management - Admin Panel | Reservatior",
  description: "Manage discount coupons and promotional codes from the admin panel.",
  keywords: ["coupons", "discounts", "promotions", "admin panel"],
  openGraph: {
    title: "Coupons Management - Admin Panel | Reservatior",
    description: "Manage discount coupons and promotional codes from the admin panel.",
    type: "website",
  },
};

export default function AdminCouponsPageWrapper() {
  return <AdminCouponsPage />;
}
