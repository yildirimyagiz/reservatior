import type { Metadata } from "next";
import CommerceOrdersPage from "./CommerceOrdersPage";

export const metadata: Metadata = {
  title: "Commerce Orders - Admin Panel | Reservatior",
  description: "Manage commerce orders, payments, and delivery tracking",
  keywords: ["orders", "commerce", "payments", "admin"],
  openGraph: {
    title: "Commerce Orders - Admin Panel | Reservatior",
    description: "Manage commerce orders, payments, and delivery tracking",
    type: "website",
  },
};

export default function CommerceOrdersPageWrapper() {
  return <CommerceOrdersPage />;
}
